Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C8CC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhns-0002gu-BY; Thu, 29 Feb 2024 09:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhnq-0002df-6T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:54:30 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhno-0004ID-6p
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:54:29 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9Tv1a012241; Thu, 29 Feb 2024 14:54:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-11-20;
 bh=lu0I3u2sm0/hOTtGpOdX3pU+V3NKonjg7+RQUx+94KI=;
 b=nOaYGkLCG59J9wChiDu84BToT4IGLuVElHlLVzGvtcbWX4CJaJj/rXM9upFbHY0lz8Mp
 yTlFDxRur3YteZUvYRYV0JTA+id8AVyHQpL44RkzHxCkp7lbPch4FIiipZnWdsv5Nhpd
 iumoFKUiEuVjPufvydwRuw45bn/vOh14itne0lrMUhs1/7YAJYJk1S4iHLB3LtO2Z0Dv
 Rsimbzm6Uwmm+qSP0YG/HL7/OrKjyl8ZJl1VTBwyS7J0R7oy1TXVEVG4gf0VhHQz64X2
 RVsjI1bqtWPATjMEtZN5qx+aWE+IOVTbuO74CRpqTzS0CVBLdu/FunNBzzPCrJZZI/Rm nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6ve5syv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:54:24 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TEOOfG004707; Thu, 29 Feb 2024 14:54:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrq6992u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:54:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41TEsNUp014256;
 Thu, 29 Feb 2024 14:54:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wjrq6991u-1; Thu, 29 Feb 2024 14:54:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2] migration: massage cpr-reboot documentation
Date: Thu, 29 Feb 2024 06:54:22 -0800
Message-Id: <1709218462-3640-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290114
X-Proofpoint-ORIG-GUID: KR9MBz5NlIC0aIYzkSLnSkHM7DpK9xG9
X-Proofpoint-GUID: KR9MBz5NlIC0aIYzkSLnSkHM7DpK9xG9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
cpr-reboot references, capitalize COLO and VFIO, and tweak the
wording.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 qapi/migration.json | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index c6bfe2e..c86113b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -636,28 +636,30 @@
 #
 # @normal: the original form of migration. (since 8.2)
 #
-# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
-#     After quitting qemu, the user resumes by running qemu -incoming.
+# @cpr-reboot: The migrate command stops the VM and saves state to
+#     the URI.  After quitting qemu, the user resumes by running
+#     qemu -incoming.
 #
-#     This mode allows the user to quit qemu, and restart an updated version
-#     of qemu.  The user may even update and reboot the OS before restarting,
-#     as long as the URI persists across a reboot.
+#     This mode allows the user to quit qemu, optionally update and
+#     reboot the OS, and restart qemu.  If the user reboots, the URI
+#     must persist across the reboot, such as by using a file.
 #
-#     Unlike normal mode, the use of certain local storage options does not
-#     block the migration, but the user must not modify guest block devices
-#     between the quit and restart.
+#     Unlike normal mode, the use of certain local storage options
+#     does not block the migration, but the user must not modify the
+#     contents of guest block devices between the quit and restart.
 #
-#     This mode supports vfio devices provided the user first puts the guest
-#     in the suspended runstate, such as by issuing guest-suspend-ram to the
-#     qemu guest agent.
+#     This mode supports VFIO devices provided the user first puts
+#     the guest in the suspended runstate, such as by issuing
+#     guest-suspend-ram to the qemu guest agent.
 #
-#     Best performance is achieved when the memory backend is shared and the
-#     @x-ignore-shared migration capability is set, but this is not required.
-#     Further, if the user reboots before restarting such a configuration, the
-#     shared backend must be be non-volatile across reboot, such as by backing
-#     it with a dax device.
+#     Best performance is achieved when the memory backend is shared
+#     and the @x-ignore-shared migration capability is set, but this
+#     is not required.  Further, if the user reboots before restarting
+#     such a configuration, the shared memory must persist across the
+#     reboot, such as by backing it with a dax device.
 #
-#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
+#     @cpr-reboot may not be used with postcopy, background-snapshot,
+#     or COLO.
 #
 #     (since 8.2)
 ##
-- 
1.8.3.1


