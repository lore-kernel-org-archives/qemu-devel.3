Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B5AC5479F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdCsg-0004qu-RV; Thu, 22 Feb 2024 12:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsf-0004q8-Dy
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdCsa-0003FL-Md
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:29:09 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MGtnIe018397; Thu, 22 Feb 2024 17:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=xATcafse/wUuxDOzzgHfYRL4vsb0ilbGj2zzju+9HeY=;
 b=OMndT/PjPlD6SyEh+5peqoJ8x+qcUCyD2P9JnlLEcUM1fKwlS03dNDxk6dIKYEY4BqHL
 /F/lGpwVnwRq29dSksBzlVtf0vqonUePd3djd8Tdl3uZa8Pxnon5DWApGahskKZjKJis
 By6WKXdz8B/l/Olv6l9YppDfBq2yvDPHEZAu461QVv3bia4+gnxCOBTA5L8oHlyTjaaX
 HK2yPsTTbTdNCqBY3JstnTMVuAbDSI/gGJlqe0s/Gr72p7pAzEE8YSgkrH0i96UA+rvy
 T7rGMCu8rW01E2e59upwf/CrKldd1lfXgZgcfVaQ44mRo1Fbv7nZJoLZCeby2OkPQna+ tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvn9yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MG4la8024355; Thu, 22 Feb 2024 17:29:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8ayrxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 17:29:01 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41MHSgAF032453;
 Thu, 22 Feb 2024 17:29:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wak8ayre4-14; Thu, 22 Feb 2024 17:29:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 13/14] migration: update cpr-reboot description
Date: Thu, 22 Feb 2024 09:28:39 -0800
Message-Id: <1708622920-68779-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_13,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220138
X-Proofpoint-GUID: DwRjC9gQ-oOgKkAedkzOJdcrM2LVRuHy
X-Proofpoint-ORIG-GUID: DwRjC9gQ-oOgKkAedkzOJdcrM2LVRuHy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Clarify qapi for cpr-reboot migration mode, and add vfio support.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/migration.json | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 5a565d9..0990297 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -636,19 +636,28 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command saves state to a file, allowing one to
-#              quit qemu, reboot to an updated kernel, and restart an updated
-#              version of qemu.  The caller must specify a migration URI
-#              that writes to and reads from a file.  Unlike normal mode,
-#              the use of certain local storage options does not block the
-#              migration, but the caller must not modify guest block devices
-#              between the quit and restart.  To avoid saving guest RAM to the
-#              file, the memory backend must be shared, and the @x-ignore-shared
-#              migration capability must be set.  Guest RAM must be non-volatile
-#              across reboot, such as by backing it with a dax device, but this
-#              is not enforced.  The restarted qemu arguments must match those
-#              used to initially start qemu, plus the -incoming option.
-#              (since 8.2)
+# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
+#     After quitting qemu, the user resumes by running qemu -incoming.
+#
+#     This mode allows the user to quit qemu, and restart an updated version
+#     of qemu.  The user may even update and reboot the OS before restarting,
+#     as long as the URI persists across a reboot.
+#
+#     Unlike normal mode, the use of certain local storage options does not
+#     block the migration, but the user must not modify guest block devices
+#     between the quit and restart.
+#
+#     This mode supports vfio devices provided the user first puts the guest
+#     in the suspended runstate, such as by issuing guest-suspend-ram to the
+#     qemu guest agent.
+#
+#     Best performance is achieved when the memory backend is shared and the
+#     @x-ignore-shared migration capability is set, but this is not required.
+#     Further, if the user reboots before restarting such a configuration, the
+#     shared backend must be be non-volatile across reboot, such as by backing
+#     it with a dax device.
+#
+#     (since 8.2)
 ##
 { 'enum': 'MigMode',
   'data': [ 'normal', 'cpr-reboot' ] }
-- 
1.8.3.1


