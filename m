Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22244C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP28g-0004ku-8I; Tue, 10 Jun 2025 12:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP167-0004cd-3o
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP165-0006HB-Gr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:41:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXbL0030408;
 Tue, 10 Jun 2025 15:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=CbUpGpAA1uYVed/kJWUTIz4OzRzM8cVRAKvIijqS6CQ=; b=
 rjCFSEUHZSU1ARYMQdxIuxnv/diCoHTGAxT2Nrc0FeWqF29BQO2mqnlKP0+9ZU/g
 9k1rJZ0oN/cHAXrTmMaMbPqoIgaWXppCqVIKAhYQkQv5iP6sLHoxOgSCQU6j0Qfn
 mH9feArDVot51fjMepxVRAMcJKqlwbFCuVn6ISUOcA56uk5SpoCKIX607PEED52D
 4EYw9W/kvQSdpdYvxuFz7cjH7bNBnBaGXqFqB4YWuaeUWcoAe9AmqLG4eKTFWh9o
 HQDtcRvve/5rJo4Dgvi+Ncgrs93Z5wMUJemem1twFHIBB9m+xR8JV30MJjKNkPjc
 yr+j1HLFPYOvzb9q75B8OA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF52Cd003304; Tue, 10 Jun 2025 15:40:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wc6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrgN028825;
 Tue, 10 Jun 2025 15:40:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-39; Tue, 10 Jun 2025 15:40:53 +0000
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
Subject: [PATCH V5 38/38] vfio: doc changes for cpr
Date: Tue, 10 Jun 2025 08:39:51 -0700
Message-Id: <1749569991-25171-39-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: j4Cwgm4ZlOBrD1ljsQuPQ_Ho6LdkGnFq
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68485207 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=cQ5gJ0ErMGRkCJeqeJUA:9 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXx8wexBLIEGaN
 ZtdaLf7L1snnso5d1voERcO7Ftk0XaXc/aPuq6zMl/HO6iHypMMffI1GinyWBdmFw+Yj9U0FBvR
 i/hboBJ2Bxr4rPdYjyo/GhJsdSJP3mCPUl+GWR8S9ddWgVEDueBwAHye2JfZE/fQv+g3PuuIf+S
 +jyniUdJNG5WqKDN/VygtP6qGzQA5VqHRM8S5AJN6evXfv2MlsmFHLVOxYrs6ZlmWeN7eOS0mdb
 M4DPjkM4iagAy0o0wZUdn8PPW4PekcZO2bloeuIsl66Qj/tMyojautOkNnwPfCfs1IlLw0umkos
 A3SJElS2TNRkk8PEljEkMnFlOWuHwlo225SskRJhmlYit8qxIdheUAo5XHQc70v1Pxut7PtiQjO
 ZDH11LWHJwz3bzccuIFwQsoEV9a1dJ7Gdnf//qJmJ/0EpwCqvinMelUI+YGatKcyrUl4nUuq
X-Proofpoint-ORIG-GUID: j4Cwgm4ZlOBrD1ljsQuPQ_Ho6LdkGnFq
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


