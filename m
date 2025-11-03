Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0D9CCFA08
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzNA-00060B-Vn; Mon, 03 Nov 2025 13:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzN8-0005vd-2x
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vFzMw-0006yq-LO
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 13:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762194806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EGZjmbie7WvN5P/atFBVzVk3p2GtY/pSoH3cMkB8LE=;
 b=ZFFNbBJEgRfzkE8yvgpk6md1+FhOm6iMjd5zFHFbs+3shKzxCGh+/UoRMqOBXKsziqOwlh
 7HeWnWBqpQdr9E5B/n/1xhB2GXj98rQAC5mCIaDBAxSJC9KBaf8OFrlDJbEMs8cj6e8sNz
 0A47YKynxjJ/hnd3Z2MGBWDi0oec5TY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-6jG5dWeaOI2cT_sulp1z6g-1; Mon,
 03 Nov 2025 13:33:22 -0500
X-MC-Unique: 6jG5dWeaOI2cT_sulp1z6g-1
X-Mimecast-MFC-AGG-ID: 6jG5dWeaOI2cT_sulp1z6g_1762194801
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56EA619539B8; Mon,  3 Nov 2025 18:33:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.249])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 068BB180058C; Mon,  3 Nov 2025 18:33:10 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>
Subject: [PATCH v4 2/8] migration: Do not try to start VM if disk activation
 fails
Date: Mon,  3 Nov 2025 19:32:51 +0100
Message-ID: <20251103183301.3840862-3-jmarcin@redhat.com>
In-Reply-To: <20251103183301.3840862-1-jmarcin@redhat.com>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

If a rare split brain happens (e.g. dest QEMU started running somehow,
taking shared drive locks), src QEMU may not be able to activate the
drives anymore.  In this case, src QEMU shouldn't start the VM or it might
crash the block layer later with something like:

Meanwhile, src QEMU cannot try to continue either even if dest QEMU can
release the drive locks (e.g. by QMP "stop").  Because as long as dest QEMU
started running, it means dest QEMU's RAM is the only version that is
consistent with current status of the shared storage.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5e74993b46..6e647c7c4a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3526,6 +3526,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
 static void migration_iteration_finish(MigrationState *s)
 {
+    Error *local_err = NULL;
+
     bql_lock();
 
     /*
@@ -3549,11 +3551,28 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        /*
-         * Re-activate the block drives if they're inactivated.  Note, COLO
-         * shouldn't use block_active at all, so it should be no-op there.
-         */
-        migration_block_activate(NULL);
+        if (!migration_block_activate(&local_err)) {
+            /*
+            * Re-activate the block drives if they're inactivated.
+            *
+            * If it fails (e.g. in case of a split brain, where dest QEMU
+            * might have taken some of the drive locks and running!), do
+            * not start VM, instead wait for mgmt to decide the next step.
+            *
+            * If dest already started, it means dest QEMU should contain
+            * all the data it needs and it properly owns all the drive
+            * locks.  Then even if src QEMU got a FAILED in migration, it
+            * normally should mean we should treat the migration as
+            * COMPLETED.
+            *
+            * NOTE: it's not safe anymore to start VM on src now even if
+            * dest would release the drive locks.  It's because as long as
+            * dest started running then only dest QEMU's RAM is consistent
+            * with the shared storage.
+            */
+            error_free(local_err);
+            break;
+        }
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
-- 
2.51.0


