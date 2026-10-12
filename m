Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3429BCA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 00:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPu1-0005ej-KU; Mon, 12 Oct 2026 19:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtz-0005cx-5d
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1xGPtv-0006EN-7V
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:57:54 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CMgYtE3713163; Mon, 12 Oct 2026 23:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=2SmRr
 HWahGu4IcKt0wFvUXhPB5XElnWlM1YNXqXYSGw=; b=bog5rZZT9Qr2+vT7FTkxe
 CefG7nYAb74M4BXklDvvW8YkFbl0nLpkAvq08ENanOCRVGrn+nP/8p00pgLTW48A
 8KNUc0MDDfck5re7rE0D7sgApG0Yqud2VUr3rn+asTMIcslXZJmK54lX3Ix0xpGg
 DNMJlz0c3ZgJC3idg/AwDUZ2ZU/7elG0Ek1y8pudqS8961qaRYDe6OwnIdYXm8ka
 c5fsQVGBbre6JKukOC7CIZQxTCBs1WLo09KhXtrXM/Y6AtYYz76Edk+JCGmmaBfG
 UZYntrXco67fk8HwmNZe3cSeWAULpBfnwL1h49m3zcAKFXKg4f04SFMjA/xrQosv
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dbkk691-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69CNpf4Z015146; Mon, 12 Oct 2026 23:57:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btnuhrv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Oct 2026 23:57:43 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CNvfH9025328;
 Mon, 12 Oct 2026 23:57:42 GMT
Received: from donglzha-e6-vfio-setup.osdevelopmeniad.oraclevcn.com
 (donglzha-e6-vfio-setup.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.255.69])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btnuhra-2; Mon, 12 Oct 2026 23:57:42 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@kernel.org, imammedo@redhat.com, maciej.szmigiero@oracle.com,
 peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, pierrick.bouvier@oss.qualcomm.com,
 alex@shazbot.org, clg@redhat.com, yi.l.liu@intel.com,
 eric.auger@redhat.com, zhenzhong.duan@intel.com, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com
Subject: [PATCH 01/21] qapi/migration: add cpr-luo migration mode
Date: Mon, 12 Oct 2026 23:55:57 +0000
Message-ID: <20261012235727.398133-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261012235727.398133-1-dongli.zhang@oracle.com>
References: <20261012235727.398133-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120095
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6acd73f8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=DI37mbQq3CLBlZ2vXzEA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-GUID: euGK1cEcLEs-5rNUoNdmsYJFQNLALCpl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX8YKPOozTAJhI
 RxjOm9H6Z7OASNjkobq7av+8G91oaLiLNKbN6vPl2CHYRlIvG2Ac8lSNWFS6r3SCsLSmxemvCzA
 MQOPqquBhNkYpLrBumKIieXSnGntWbbhT8/KZYNGicfFU+yH9f5pAqWQ6LNPULQ/ofV/DpV+oJO
 p3bmh+EmR/FtwiLcnQG9+iT1XDE0qU79de4c/vM315UUIgh+/ugMiPFW2axsRHoGvX5DCRl4jbR
 xRZsLrbTlrDqjQ3lzbHvkNSKQ3gnUmau/dqW2Tpaldb1hVLhIoUczIWyQ/uTwPIWIWb6gxv7arM
 GXPi7gRgIKuiNE7Gq4Mh7djeO+L3VEXBL9aF/kvImXqjPb8FyNpFOz+EQ92yHlNcYUghnJolHd+
 kHs5bsdTSlBpsk0qUbMsH2ouqiKGaE6vrSqfuO8F5eIy04ER8WhoZxmq6ryd5XU+e2vN+jetQBQ
 Xnd3Zw+KzOtkfvyEs901+YtKWmc4cyidHZFJKbVM=
X-Proofpoint-ORIG-GUID: euGK1cEcLEs-5rNUoNdmsYJFQNLALCpl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NSBTYWx0ZWRfX7uZl3ztKNJpX
 QqLSMF2TOOHji4Wf16K87GFSf4JJIcmMu5mkHHnMndE6dyttzJ8Z9p08GiiWW6IUltpz+5KRNaW
 BzQvJWaSCH77lytexj8KrLDZDipRWa/FJ/LM51+GxAMzhepZPNBe
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the cpr-luo migration mode for CPR through the Linux Live Update
Orchestrator (LUO). Subsequent changes preserve CPR state and RAMBlock
backing file descriptors in an LUO session across a host kernel update.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 qapi/migration.json | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 889a9b89c2..ab117c3897 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -712,9 +712,18 @@
 #     with the '-machine aux-ram-share=on' option.
 #
 #     (since 10.2)
+#
+# @cpr-luo: A CPR mode that preserves guest RAM backing file
+#     descriptors and CPR state through the Linux Live Update
+#     Orchestrator (LUO) across a host kernel update.
+#
+#     This mode requires Linux with LUO support.
+#
+#     (since 11.2)
 ##
 { 'enum': 'MigMode',
-  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
+  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec',
+            'cpr-luo' ] }
 
 ##
 # @ZeroPageDetection:
-- 
2.43.5


