Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EAAC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCx0-0001vc-Hv; Tue, 09 Apr 2024 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwq-0001pR-ED; Tue, 09 Apr 2024 10:59:44 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwo-0005vZ-62; Tue, 09 Apr 2024 10:59:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5278720A77;
 Tue,  9 Apr 2024 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eZTojFzlbmM9srO5Hfd2P2mso848RuOOS1Zx/au5io=;
 b=vSpKTPL/ZU+FKaysuJKxWEeo1YfePCkasWQLAoJG0kRhDyX0fVLNec8KroMS78roBaCoOa
 tEjW4OiXI4G9hEw+i6teWHZCj3U9GsjdDhDWiIJ3hovZelDFFmNB5H5RfJN4sBUTyR3TCf
 zpbcYD7gXNAqXbb/0aiJr6GxfXeSLHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eZTojFzlbmM9srO5Hfd2P2mso848RuOOS1Zx/au5io=;
 b=41N4Bxa+A6uJxeSAp/IgIMdQUqiJGQm+E3r2B/2jOQ28c7dLsevjTDPW7BMrluCwl3/Tdy
 5APYOMJapszzu9Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="vSpKTPL/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=41N4Bxa+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eZTojFzlbmM9srO5Hfd2P2mso848RuOOS1Zx/au5io=;
 b=vSpKTPL/ZU+FKaysuJKxWEeo1YfePCkasWQLAoJG0kRhDyX0fVLNec8KroMS78roBaCoOa
 tEjW4OiXI4G9hEw+i6teWHZCj3U9GsjdDhDWiIJ3hovZelDFFmNB5H5RfJN4sBUTyR3TCf
 zpbcYD7gXNAqXbb/0aiJr6GxfXeSLHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eZTojFzlbmM9srO5Hfd2P2mso848RuOOS1Zx/au5io=;
 b=41N4Bxa+A6uJxeSAp/IgIMdQUqiJGQm+E3r2B/2jOQ28c7dLsevjTDPW7BMrluCwl3/Tdy
 5APYOMJapszzu9Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4D3D13313;
 Tue,  9 Apr 2024 14:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCMfItdXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 04/11] block: Reschedule query-block during qcow2
 invalidation
Date: Tue,  9 Apr 2024 11:59:10 -0300
Message-Id: <20240409145917.6780-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5278720A77
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[18];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[nongnu.org,redhat.com,suse.de,suse.com,yandex-team.ru,huawei.com,gmail.com,euphon.net];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,gitlab.com:url];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

There is a small window at the end of block device migration when
devices are being re-activated. This includes a resetting of some
fields of BDRVQcow2State at qcow2_co_invalidate_cache(). A concurrent
QMP query-block command can call qcow2_get_specific_info() during this
window and see the cleared values, which leads to an assert:

  qcow2_get_specific_info: Assertion `false' failed

This is the same issue as Gitlab #1933, which has already been
resolved[1], but there the fix applied only to non-coroutine
commands. Once we move query-block to a coroutine the problem will
manifest again.

Add an operation blocker to the invalidation function to block the
query info path during this window.

Instead of failing query-block, which would be disruptive to users,
use the blocker to know when to reschedule the coroutine back into the
iohandler so it doesn't run while the BDRVQcow2State is inconsistent.

To avoid failing query-block when all block operations are blocked,
unblock the INFO operation at various places. This preserves the prior
situations where query-block used to work.

1 - https://gitlab.com/qemu-project/qemu/-/issues/1933

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block.c                      |  1 +
 block/mirror.c               |  1 +
 block/qcow2.c                | 20 ++++++++++++++++++++
 block/replication.c          |  1 +
 blockjob.c                   |  1 +
 include/block/block-common.h |  1 +
 migration/block.c            |  1 +
 7 files changed, 26 insertions(+)

diff --git a/block.c b/block.c
index 468cf5e67d..01478c5471 100644
--- a/block.c
+++ b/block.c
@@ -1296,6 +1296,7 @@ static void GRAPH_WRLOCK bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
                     parent->backing_blocker);
+    bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_INFO, parent->backing_blocker);
 }
 
 static void bdrv_backing_detach(BdrvChild *c)
diff --git a/block/mirror.c b/block/mirror.c
index 1bdce3b657..9f952f3fdd 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1191,6 +1191,7 @@ static void mirror_complete(Job *job, Error **errp)
         error_setg(&s->replace_blocker,
                    "block device is in use by block-job-complete");
         bdrv_op_block_all(s->to_replace, s->replace_blocker);
+        bdrv_op_unblock(s->to_replace, BLOCK_OP_TYPE_INFO, s->replace_blocker);
         bdrv_ref(s->to_replace);
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 956128b409..b0ec8009e3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2834,6 +2834,7 @@ qcow2_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     BdrvChild *data_file;
     int flags = s->flags;
     QCryptoBlock *crypto = NULL;
+    Error *blocker = NULL;
     QDict *options;
     int ret;
 
@@ -2845,6 +2846,17 @@ qcow2_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     crypto = s->crypto;
     s->crypto = NULL;
 
+    /*
+     * When qcow2_do_open() below reads the qcow header, it yields to
+     * wait for the I/O which allows a concurrent QMP query-block
+     * command to be dispatched on the same context before
+     * BDRVQcow2State has been completely repopulated. Block the
+     * query-info operation during this window to avoid having
+     * qcow2_get_specific_info() access bogus values.
+     */
+    error_setg(&blocker, "invalidating cached metadata");
+    bdrv_op_block(bs, BLOCK_OP_TYPE_INFO, blocker);
+
     /*
      * Do not reopen s->data_file (i.e., have qcow2_do_close() not close it,
      * and then prevent qcow2_do_open() from opening it), because this function
@@ -2864,6 +2876,8 @@ qcow2_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     qemu_co_mutex_lock(&s->lock);
     ret = qcow2_do_open(bs, options, flags, false, errp);
     qemu_co_mutex_unlock(&s->lock);
+    bdrv_op_unblock(bs, BLOCK_OP_TYPE_INFO, blocker);
+    g_free(blocker);
     qobject_unref(options);
     if (ret < 0) {
         error_prepend(errp, "Could not reopen qcow2 layer: ");
@@ -5240,6 +5254,12 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
     ImageInfoSpecific *spec_info;
     QCryptoBlockInfo *encrypt_info = NULL;
 
+    if (qemu_in_coroutine() &&
+        bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INFO, errp)) {
+        errp = NULL;
+        aio_co_reschedule_self(iohandler_get_aio_context());
+    }
+
     if (s->crypto != NULL) {
         encrypt_info = qcrypto_block_get_info(s->crypto, errp);
         if (!encrypt_info) {
diff --git a/block/replication.c b/block/replication.c
index ca6bd0a720..459d644673 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -577,6 +577,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         }
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
+        bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_INFO, s->blocker);
 
         bdrv_graph_wrunlock();
 
diff --git a/blockjob.c b/blockjob.c
index d5f29e14af..f0df345982 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -244,6 +244,7 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
 
     job->nodes = g_slist_prepend(job->nodes, c);
     bdrv_op_block_all(bs, job->blocker);
+    bdrv_op_unblock(bs, BLOCK_OP_TYPE_INFO, job->blocker);
 
     return 0;
 }
diff --git a/include/block/block-common.h b/include/block/block-common.h
index a846023a09..4458617179 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -364,6 +364,7 @@ typedef enum BlockOpType {
     BLOCK_OP_TYPE_RESIZE,
     BLOCK_OP_TYPE_STREAM,
     BLOCK_OP_TYPE_REPLACE,
+    BLOCK_OP_TYPE_INFO,
     BLOCK_OP_TYPE_MAX,
 } BlockOpType;
 
diff --git a/migration/block.c b/migration/block.c
index 2b9054889a..3f3bc2748f 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -451,6 +451,7 @@ static int init_blk_migration(QEMUFile *f)
             alloc_aio_bitmap(bmds);
             error_setg(&bmds->blocker, "block device is in use by migration");
             bdrv_op_block_all(bs, bmds->blocker);
+            bdrv_op_unblock(bs, BLOCK_OP_TYPE_INFO, bmds->blocker);
         }
     }
 
-- 
2.35.3


