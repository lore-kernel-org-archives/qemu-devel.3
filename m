Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6AFC5DF66
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRJ-0004Qy-G0; Wed, 12 Aug 2026 19:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRF-0004Pa-Ky
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRC-0001Rp-Fo
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEoluL882232; Wed, 12 Aug 2026 23:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=yoriN
 xgu4uYyO7npXNIdPtll23yt1XBkmmKih2lxoik=; b=eWwAQpPZWBchgDXLFjnCZ
 XUTp+hh3h5Gi5NJYD2rfcabPxaYXFqGVkDqVItGScEVgRoIHCFYUbbw6iPG+oiCv
 EpwyFh4UadF+zXC8EDXFuVO9g+bYZA7V10NK2YI4Jq2j26WDy9xRPj7CIW4FIsCS
 R/5s8Zn7R+iHlCbAaIWvo9mrKvnZtDjfAI+7GPQGW61C7mrwnI9djLVOtynh56d7
 oc/0svxQU13AMqv2/3x/6yR9FWLQMIEWb6kyzqvfwEuztVGtipsXR0CHHC3Tg1rc
 AIfdbiO+JPWlt4FwJwvHTEh7X7Bt2PC/Wf1/wmZdmK+RcfrKWe8AsHvmPq85DNLp
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxynch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNTxUB017332; Wed, 12 Aug 2026 23:32:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:39 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHY025569;
 Wed, 12 Aug 2026 23:32:38 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-2; Wed, 12 Aug 2026 23:32:38 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 1/5] migration/qapi: Add memfd migration transport
Date: Wed, 12 Aug 2026 16:27:46 -0700
Message-ID: <20260812232842.470225-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260812232842.470225-1-dongli.zhang@oracle.com>
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120190
X-Proofpoint-GUID: Bl8_auSw0km3xOSWrG-yqzD31DiB8Aos
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7d0298 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=1HexDGPBlmFBiWrkqnYA:9
X-Proofpoint-ORIG-GUID: Bl8_auSw0km3xOSWrG-yqzD31DiB8Aos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX0R0lyVpqImkj
 FW3A8qkShGyo5Pp3x1GP9PppfPLxSEPXzAqy0VcNcUiKiR7sxqUHm6bFPyzlKT4gkLUbVmJB5dV
 R25AwNvpVC8F2PJ5k8dGlAjQ+Xh7uHTBK9essSVae8iZqTz4j/l5ogk6k5MbaJ/kcAisYxgNEtW
 /FEUBvjtqk0btAqvLLP0JpeyJpNOBjpV8051U+GBD1ie0lE3V/7ampG2ZEzNIvOOZ4bwAn2O/yF
 vhzGAfjjGwpl6IS1f3p/+jBJQ8ors0GY2FGLVZKkfpMP2zxcf+xEz3AI/ouCV1EkU/LpYSA1CMQ
 GTem0m2hkf+1hw12L55ArqItPrCogmdpl42BJoCGV/nL3UfzQi+GKOu3eepKM8y7oTBRPDE4D4Q
 LhC1HXfEdqmUtG2IQy8LRqxemnkqzGYaKK2Q2OMfo+0EMa5lvz4tEkqTK3jcnRXtUj0ZfBtQxCS
 XWKHeoEn/x/wNcjEPHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX5I/EWFTUgTM/
 snywxXZ8WknYJQTat7Qf/UiaqMKCVdZ6dy4mWcjNHG5RkNcgbYBENHEwGN+s3lbohegLc/1y75Q
 k9aR6JKBuagu7y9rbVZjDKw27H7MngiG2B4sT9uSx7XpSKmf4GPn
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a memfd migration transport to the MigrationAddress QAPI schema. The
new transport has no user-supplied arguments because QEMU creates and
passes the backing memfd internally.

The initial user is cpr-exec, where the main VM/device migration stream can
be stored in an inherited memfd instead of an external file.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 qapi/migration.json | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b054..1505c201ca 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -702,9 +702,11 @@
 # @cpr-exec: The migrate command stops the VM, saves state to the
 #     migration channel, directly exec's a new version of QEMU on the
 #     same host, replacing the original process while retaining its
-#     PID, and loads state from the channel.  Guest RAM is preserved
-#     in place.  Devices and their pinned pages are also preserved for
-#     VFIO and IOMMUFD.
+#     PID, and loads state from the channel.  With the @memfd
+#     migration transport, QEMU saves VM/device state to an internal
+#     memfd instead of an external main migration channel.  Guest RAM
+#     is preserved in place.  Devices and their pinned pages are also
+#     preserved for VFIO and IOMMUFD.
 #
 #     Old QEMU starts new QEMU by exec'ing the command specified by
 #     the @cpr-exec-command parameter.  The command may be a direct
@@ -716,6 +718,13 @@
 #     as a file, that accepts all data before old QEMU exits.
 #     Otherwise, old QEMU may quietly block writing to the channel.
 #
+#     Alternatively, use the @memfd migration transport to save
+#     VM/device state to an internal memfd inherited by new QEMU.
+#
+#     With @memfd, the new QEMU command may include '-incoming memfd:'
+#     to load the migration stream automatically, or '-incoming defer'
+#     to load it later with `migrate-incoming`.
+#
 #     Memory-backend objects must have the share=on attribute, but
 #     memory-backend-epc is not supported.  The VM must be started
 #     with the '-machine aux-ram-share=on' option.
@@ -1309,10 +1318,14 @@
 #
 # @file: Direct the migration stream to a file.
 #
+# @memfd: Direct the migration stream to an internal memfd.  This
+#     transport is currently only valid with cpr-exec migration mode.
+#     (Since 11.2)
+#
 # Since: 8.2
 ##
 { 'enum': 'MigrationAddressType',
-  'data': [ 'socket', 'exec', 'rdma', 'file' ] }
+  'data': [ 'socket', 'exec', 'rdma', 'file', 'memfd' ] }
 
 ##
 # @FileMigrationArgs:
@@ -1337,6 +1350,14 @@
 { 'struct': 'MigrationExecCommand',
   'data': {'args': [ 'str' ] } }
 
+##
+# @MemfdMigrationArgs:
+#
+# Since: 11.2
+##
+{ 'struct': 'MemfdMigrationArgs',
+  'data': { } }
+
 ##
 # @MigrationAddress:
 #
@@ -1353,7 +1374,8 @@
     'socket': 'SocketAddress',
     'exec': 'MigrationExecCommand',
     'rdma': 'InetSocketAddress',
-    'file': 'FileMigrationArgs' } }
+    'file': 'FileMigrationArgs',
+    'memfd': 'MemfdMigrationArgs' } }
 
 ##
 # @MigrationChannelType:
-- 
2.43.5


