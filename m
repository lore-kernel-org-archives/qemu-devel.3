Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1641CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 12:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7sD-00043e-0M; Mon, 15 Sep 2025 07:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7sB-00043G-EY
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uy7s6-0004Yy-8F
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757937583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O5Ns+gRP/BDir8gasafzaZlhxfAoGAe28uqV3eZtNbs=;
 b=SjrNmKzJhoGw6Btb+doV9CsXhWbZ61lTDrXdVTTMBm99ucWg7ezjnJBzdDP0Iuo5xlr1t+
 5X9BUXNXzJ6+FImI+BGMM3+qMSgv8cBySOPJpKyXz/1drFXA2boaAT5w+wh0AoDWbf9D2C
 Wt7D/LBPob7G+hOZm1nwhoC2q96gogk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-1nrs_2dqPzW2lvqbYjkshw-1; Mon,
 15 Sep 2025 07:59:37 -0400
X-MC-Unique: 1nrs_2dqPzW2lvqbYjkshw-1
X-Mimecast-MFC-AGG-ID: 1nrs_2dqPzW2lvqbYjkshw_1757937576
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8122C19107D8; Mon, 15 Sep 2025 11:59:36 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.193])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DDF41954126; Mon, 15 Sep 2025 11:59:33 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/4] migration: Do not try to start VM if disk activation fails
Date: Mon, 15 Sep 2025 13:59:12 +0200
Message-ID: <20250915115918.3520735-2-jmarcin@redhat.com>
In-Reply-To: <20250915115918.3520735-1-jmarcin@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

bdrv_co_write_req_prepare: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

Meanwhile, src QEMU cannot try to continue either even if dest QEMU can
release the drive locks (e.g. by QMP "stop").  Because as long as dest QEMU
started running, it means dest QEMU's RAM is the only version that is
consistent with current status of the shared storage.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..54dac3db88 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3502,6 +3502,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
 static void migration_iteration_finish(MigrationState *s)
 {
+    Error *local_err = NULL;
+
     bql_lock();
 
     /*
@@ -3525,11 +3527,28 @@ static void migration_iteration_finish(MigrationState *s)
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


