Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F27CC4829A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY9XS-0001X6-Qr; Thu, 08 Feb 2024 13:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XN-0001Qc-Bs
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rY9XK-0005nG-Js
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:54:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 418Ik2Ah031385; Thu, 8 Feb 2024 18:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=FcJTiqsgF1X2wz8iNV5OhBrAgSn2FRO2IaN6FRWM09g=;
 b=Mw93NN3LmFCl1vByrmnm9bjLTdAObxihe6RmE8NAeGXHihRGHzPDlBOrfCvwQ4EtH+ZQ
 AfqSzciqeFHfmgqaoEBzhRcS3C19feNFK9od/nFjgBVDHRT67cUETVZKJiPBBTn9Nf6T
 J3GjtXaPbzJmuggzQq9aQFC2aRxD8f6+EWq5Jvgeq90wdw32zqGr1gWO0g8jgvTB+B60
 dKHuwyZS4z7MvYer4nshr5/5z5YFxNmPzfkMshACAWBFxsdk9KhIbNi/OV61rqMJEkXP
 frIa+bL9570Kcr28kxtAf0j1KqM8rn2k1UfpIxe2dPRzc/KbqET17p2JvpLOWFhPg8uo dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbne61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:13 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 418ID0pt038393; Thu, 8 Feb 2024 18:54:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3w1bxawn1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 08 Feb 2024 18:54:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418Iq361013534;
 Thu, 8 Feb 2024 18:54:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3w1bxawmw9-3; Thu, 08 Feb 2024 18:54:11 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 02/13] migration: remove error from notifier data
Date: Thu,  8 Feb 2024 10:53:55 -0800
Message-Id: <1707418446-134863-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080099
X-Proofpoint-GUID: 4hHglG1xEQTyfiqm79SLH31w-6TAAMd7
X-Proofpoint-ORIG-GUID: 4hHglG1xEQTyfiqm79SLH31w-6TAAMd7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Remove the error object from opaque data passed to notifiers.
Use the new error parameter passed to the notifier instead.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/virtio/vhost-user.c   | 8 ++++----
 include/migration/misc.h | 1 -
 migration/postcopy-ram.c | 1 -
 migration/postcopy-ram.h | 1 -
 migration/ram.c          | 1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f502345..a1eea85 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2096,20 +2096,20 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
         if (!virtio_has_feature(dev->protocol_features,
                                 VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
-            error_setg(pnd->errp,
+            error_setg(errp,
                        "vhost-user backend not capable of postcopy");
             return -ENOENT;
         }
         break;
 
     case POSTCOPY_NOTIFY_INBOUND_ADVISE:
-        return vhost_user_postcopy_advise(dev, pnd->errp);
+        return vhost_user_postcopy_advise(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_LISTEN:
-        return vhost_user_postcopy_listen(dev, pnd->errp);
+        return vhost_user_postcopy_listen(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_END:
-        return vhost_user_postcopy_end(dev, pnd->errp);
+        return vhost_user_postcopy_end(dev, errp);
 
     default:
         /* We ignore notifications we don't know */
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 1bc8902..5e65c18 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -31,7 +31,6 @@ typedef enum PrecopyNotifyReason {
 
 typedef struct PrecopyNotifyData {
     enum PrecopyNotifyReason reason;
-    Error **errp;
 } PrecopyNotifyData;
 
 void precopy_infrastructure_init(void);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3ab2f6b..0273dc6 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -77,7 +77,6 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
 {
     struct PostcopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&postcopy_notifier_list,
                                             &pnd, errp);
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 442ab89..ecae941 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -128,7 +128,6 @@ enum PostcopyNotifyReason {
 
 struct PostcopyNotifyData {
     enum PostcopyNotifyReason reason;
-    Error **errp;
 };
 
 void postcopy_add_notifier(NotifierWithReturn *nn);
diff --git a/migration/ram.c b/migration/ram.c
index ed9241a..fe90024 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -426,7 +426,6 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
 {
     PrecopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
-- 
1.8.3.1


