Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E7DC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5UD-0003Wi-VS; Wed, 02 Jul 2025 17:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5UC-0003WU-7m
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U7-0003m1-BC
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQxmo028292;
 Wed, 2 Jul 2025 21:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=gEm/LuJJzxZFaI/fmQhNlXXmc+Vyq1rOmMGEgxNtF1M=; b=
 ja8Es07bAu0jU/wFxgDNANAjGEsuB/UzxFLI5OhzVf5Bin0SJ0jaquiPnvze4hAy
 S+V5g/e9pkcxqxiZsN+eeiNoZ/eT6MPl20lb4EDEFE4jY3pD1lJQH1PaXB+WnG1r
 ojE7er+6QHrE6+2LHeeYNrkmBRU9JWHsTTXD5EKcVVP6g5my+ImfaAel8vtwlhg6
 DxfwA3bXysL/UHLYWtqJbQ/zi/C6YHqc7VrX2lzAjG4eP8gVpivrSKOcU4hlhhLB
 sCjV9ZNgRz0X8VZJS5YWxOmi7rLgnAQ92pDflRB0a/mL5N2UbGXKTicEopMIb+LO
 6cS2mFI12OOmi90ZCJUNNA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w7vrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LoWAx033773; Wed, 2 Jul 2025 21:59:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:15 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxga020012;
 Wed, 2 Jul 2025 21:59:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-22; Wed, 02 Jul 2025 21:59:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 21/21] vfio: doc changes for cpr
Date: Wed,  2 Jul 2025 14:58:58 -0700
Message-Id: <1751493538-202042-22-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: fCxtTmycWpPEuPOSLqswscFwpf0VmSH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX7+j4Kkmd/Yhm
 dfVky77+vS6DGIwn7qE0LNPmLqJFJqi7fnlFC3D4QV6S80NX10UuFlpB9EOdJkaB3z2TEsrv/lz
 LGig/UtrtsR4g/dXX6cAeN4g7byFTgjKIxk8mm+RGz6f7kBNf35vVI5UKlKrtypZkQ0i0CGmTEJ
 190CsB2bAUlV8S8OS9PdPXd5u6Oj+7pADPHxFrafnzbMD8g5fLaVjgmN3Ihcr90ibLmCHzMhpRY
 X5/7/TYaI+mPHqEnxu1e28Jw2daCtKYIaGYIbPvT9e8DZytbDlirDYwFWvBhW9iDpGsIDw2y4/+
 W1RMhHVhjlq5XhiHJLtwW+gFLowRoqqkqXnA0mihV/nlN1ke09p82TfUGX+YmRr3N8AWmuo5+69
 sSbfDCg6v1E8W/AQmb62iOH40w7kEQCIO3LB5pV3DSLuLP5UN3NgEKY2oljqWKK71d9BJWSX
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6865abb4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=cQ5gJ0ErMGRkCJeqeJUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fCxtTmycWpPEuPOSLqswscFwpf0VmSH2
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Update documentation to say that cpr-transfer supports vfio and iommufd.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/CPR.rst | 5 ++---
 qapi/migration.json          | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
index 7897873..0a0fd4f 100644
--- a/docs/devel/migration/CPR.rst
+++ b/docs/devel/migration/CPR.rst
@@ -152,8 +152,7 @@ cpr-transfer mode
 This mode allows the user to transfer a guest to a new QEMU instance
 on the same host with minimal guest pause time, by preserving guest
 RAM in place, albeit with new virtual addresses in new QEMU.  Devices
-and their pinned memory pages will also be preserved in a future QEMU
-release.
+and their pinned memory pages are also preserved for VFIO and IOMMUFD.
 
 The user starts new QEMU on the same host as old QEMU, with command-
 line arguments to create the same machine, plus the ``-incoming``
@@ -322,6 +321,6 @@ Futures
 
 cpr-transfer mode is based on a capability to transfer open file
 descriptors from old to new QEMU.  In the future, descriptors for
-vfio, iommufd, vhost, and char devices could be transferred,
+vhost, and char devices could be transferred,
 preserving those devices and their kernel state without interruption,
 even if they do not explicitly support live migration.
diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6c..e8a7d3b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -620,8 +620,10 @@
 #
 # @cpr-transfer: This mode allows the user to transfer a guest to a
 #     new QEMU instance on the same host with minimal guest pause
-#     time by preserving guest RAM in place.  Devices and their pinned
-#     pages will also be preserved in a future QEMU release.
+#     time by preserving guest RAM in place.
+#
+#     Devices and their pinned pages are also preserved for VFIO and
+#     IOMMUFD. (since 10.1)
 #
 #     The user starts new QEMU on the same host as old QEMU, with
 #     command-line arguments to create the same machine, plus the
-- 
1.8.3.1


