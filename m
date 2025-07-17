Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC00C83F38
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVSi-0006uX-Ug; Thu, 17 Jul 2025 16:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW6-0008Uz-O9
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucTW4-00008E-2F
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:39:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0iXW018940;
 Thu, 17 Jul 2025 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=VgprnmZCr3q9J4H2t0odPHCzfj2X9xCle5ED7ksx70k=; b=
 SGqZYH8sniDD4lCBYc+mJ62kZFHOelAQT9zWAkSNjxDuEl4Jb2YLL/cCaEZe6Qar
 fHxN+5tgDO+o5gaApVr7/6A9z1JkonO9NhC+iP3fyRkrp8Vn/z09sP9QQkQXf3b8
 rJVH31fYRTVNWh8YhZxhIWvh6ZWsiHldRsXM/vhA84hayXRhL4WEyQuqVBSdEu0L
 156A+DKAsVR5oEXjzu3muoJ9+WBrDA4tMnvYq8d9q1nAapjOX35LFJpq77zS/oc2
 CEJfVyJTDIJX9Mi8iF2s/9iHZFT9yGP++aB/EVYCTh0AYyz1pjcRyLyx6ri+g0Fu
 S+hCNkRW3AHy9pkhjCtxPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx83yb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56HGxmrQ023785; Thu, 17 Jul 2025 18:39:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5d2t9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Jul 2025 18:39:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56HIcoij007425;
 Thu, 17 Jul 2025 18:39:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5d2t8q-2; Thu, 17 Jul 2025 18:39:29 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V2 1/8] migration: stop vm earlier for cpr
Date: Thu, 17 Jul 2025 11:39:21 -0700
Message-Id: <1752777568-236368-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170165
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=68794363 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=SpDTNw6YXiUZnQYNxJkA:9
X-Proofpoint-ORIG-GUID: lMa3iabYyk_bQGaBuyJLWQ8WtA237J8Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2NSBTYWx0ZWRfX/JHB6pMdyKun
 dW/lEDJdCYpuVEj9WYvgj9ya9tDd9xOxkx7mCglNLSeJeR8RIRjVq98GGvsn375+q6gqX8+BHPV
 ibhM/YWbZ2ZkxEYl95q/79mMaBZIqvMpeIrIrXc3slhVoNl3tZtXVX8ZAGf3ci6j5ySqKv1DPfT
 s19MWsxmMS4kBXn/J1HdB4bjMJ4m6n5/8jpN1A6YO0wQ61Iabh/4jqt7LDDGO4+juqm+tv7vwkH
 HRsdyB+mALTSV5K+ZBat9/JRZ5JQXXKBQprMd+IlybUtDflKSo6sWI944G8EYiq193qgE7gSpSu
 SGY/BTShiYQpZ/jHU+nI03s6jFokF6IUxf/cG56oxHL0xzSBR9kdl0eb1etxh9c6mKRZ39qGsq5
 L+1OUkmXtSZIRiub3/8RtvPb5TYlNok0bFC9+SU0I7tabPZL3QnCFlFemfTF6bkVYeQhHq0/
X-Proofpoint-GUID: lMa3iabYyk_bQGaBuyJLWQ8WtA237J8Y
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stop the vm earlier for cpr, before cpr_save_state which causes new QEMU
to proceed and initialize devices.  We must guarantee devices are stopped
in old QEMU, and all source notifiers called, before they are initialized
in new QEMU.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d..2efe60a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1662,6 +1662,7 @@ void migration_cancel(void)
                           MIGRATION_STATUS_CANCELLED);
         cpr_state_close();
         migrate_hup_delete(s);
+        vm_resume(s->vm_old_state);
     }
 }
 
@@ -2196,6 +2197,7 @@ void qmp_migrate(const char *uri, bool has_channels,
     MigrationAddress *addr = NULL;
     MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
     MigrationChannel *cpr_channel = NULL;
+    bool stopped = false;
 
     /*
      * Having preliminary checks for uri and channel
@@ -2248,6 +2250,15 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
+        if (ret < 0) {
+            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
+            goto out;
+        }
+        stopped = true;
+    }
+
     if (cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
@@ -2274,6 +2285,9 @@ out:
     if (local_err) {
         migration_connect_set_error(s, local_err);
         error_propagate(errp, local_err);
+        if (stopped) {
+            vm_resume(s->vm_old_state);
+        }
     }
 }
 
@@ -2319,6 +2333,9 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         }
         migration_connect_set_error(s, local_err);
         error_propagate(errp, local_err);
+        if (migrate_mode_is_cpr(s)) {
+            vm_resume(s->vm_old_state);
+        }
         return;
     }
 }
@@ -3961,7 +3978,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     Error *local_err = NULL;
     uint64_t rate_limit;
     bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
-    int ret;
 
     /*
      * If there's a previous error, free it and prepare for another one.
@@ -4033,14 +4049,6 @@ void migration_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (migrate_mode_is_cpr(s)) {
-        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
-        if (ret < 0) {
-            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
-            goto fail;
-        }
-    }
-
     /*
      * Take a refcount to make sure the migration object won't get freed by
      * the main thread already in migration_shutdown().
-- 
1.8.3.1


