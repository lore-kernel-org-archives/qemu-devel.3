Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D67ECD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCxd-0002dG-BQ; Tue, 09 Apr 2024 11:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCxG-0002MO-Vk; Tue, 09 Apr 2024 11:00:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCxB-000611-D1; Tue, 09 Apr 2024 11:00:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B4A733A57;
 Tue,  9 Apr 2024 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jkd3pQPgVFfA8kxk0mRImtAej1THT0x0NrGWIGh+Qc=;
 b=l8EDq5+TzzXs+rLpKp6p6nRpjp9zCqCeAjWbGd/DlAquMf3b05kvI//DlSmHnvxIjMZ05T
 JnMKsv0605iAB9xdy6WQZvZqBVFTijgZDNv0YFUnxGnKJUy7T0D//dDE2FUTYd9T2BKzMr
 kadkyOMccFO+BjTbfl55iDgYUfm2KAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jkd3pQPgVFfA8kxk0mRImtAej1THT0x0NrGWIGh+Qc=;
 b=oavRpblkHuSoyidGSQBEBAcrebB3Yp9v1AmmA+falMC1Fnod9ReR+CJJNaoc7bYhO59Yl/
 NbtUnZXDVmjjZFBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jkd3pQPgVFfA8kxk0mRImtAej1THT0x0NrGWIGh+Qc=;
 b=l8EDq5+TzzXs+rLpKp6p6nRpjp9zCqCeAjWbGd/DlAquMf3b05kvI//DlSmHnvxIjMZ05T
 JnMKsv0605iAB9xdy6WQZvZqBVFTijgZDNv0YFUnxGnKJUy7T0D//dDE2FUTYd9T2BKzMr
 kadkyOMccFO+BjTbfl55iDgYUfm2KAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jkd3pQPgVFfA8kxk0mRImtAej1THT0x0NrGWIGh+Qc=;
 b=oavRpblkHuSoyidGSQBEBAcrebB3Yp9v1AmmA+falMC1Fnod9ReR+CJJNaoc7bYhO59Yl/
 NbtUnZXDVmjjZFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BF0C13313;
 Tue,  9 Apr 2024 14:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QGnrOO5XFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 10/11] block: Convert qmp_query_block and
 qmp_query_named_block_nodes to coroutine
Date: Tue,  9 Apr 2024 11:59:16 -0300
Message-Id: <20240409145917.6780-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.989];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL14emxp6ck9fz14jedoy69s36)];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Lin Ma <lma@suse.com>

Convert the remaining functions to make the QMP commands query-block
and query-named-block-nodes run in their entirety in a coroutine. With
this, any yield from those commands will return all the way back to
the main loop. This releases the BQL and the main loop and avoids
having the QMP command block another more important task from running.

Both commands need to be converted at once because hmp_info_block
calls both and it needs to be moved to a coroutine as well.

Now the wrapper for bdrv_co_get_allocated_file_size() can be made not
mixed and the wrapper for bdrv_co_block_device_info() can be removed.

Signed-off-by: Lin Ma <lma@suse.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block.c                            |  8 ++++----
 block/monitor/block-hmp-cmds.c     |  2 +-
 block/qapi.c                       | 12 ++++++------
 blockdev.c                         |  8 ++++----
 hmp-commands-info.hx               |  1 +
 include/block/block-global-state.h |  3 ++-
 include/block/block-hmp-cmds.h     |  2 +-
 include/block/block-io.h           |  2 +-
 include/block/qapi.h               |  3 ---
 qapi/block-core.json               |  5 +++--
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/block.c b/block.c
index 01478c5471..cba28f07fc 100644
--- a/block.c
+++ b/block.c
@@ -6207,18 +6207,18 @@ BlockDriverState *bdrv_find_node(const char *node_name)
 }
 
 /* Put this QMP function here so it can access the static graph_bdrv_states. */
-BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
-                                           Error **errp)
+BlockDeviceInfoList *coroutine_fn bdrv_co_named_nodes_list(bool flat,
+                                                           Error **errp)
 {
     BlockDeviceInfoList *list;
     BlockDriverState *bs;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    GRAPH_RDLOCK_GUARD();
 
     list = NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
+        BlockDeviceInfo *info = bdrv_co_block_device_info(NULL, bs, flat, errp);
         if (!info) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 9db587c661..8ceff59688 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -738,7 +738,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 }
 
-void hmp_info_block(Monitor *mon, const QDict *qdict)
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict)
 {
     BlockInfoList *block_list, *info;
     BlockDeviceInfoList *blockdev_list, *blockdev;
diff --git a/block/qapi.c b/block/qapi.c
index 9a59e5606f..c4514295ec 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -418,8 +418,8 @@ fail:
 }
 
 /* @p_info will be set only on success. */
-static void GRAPH_RDLOCK
-bdrv_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
+static void GRAPH_RDLOCK coroutine_fn
+bdrv_co_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
 {
     BlockInfo *info = g_malloc0(sizeof(*info));
     BlockDriverState *bs = blk_bs(blk);
@@ -451,7 +451,7 @@ bdrv_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
     }
 
     if (bs && bs->drv) {
-        info->inserted = bdrv_block_device_info(blk, bs, false, errp);
+        info->inserted = bdrv_co_block_device_info(blk, bs, false, errp);
         if (info->inserted == NULL) {
             goto err;
         }
@@ -661,13 +661,13 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
     return s;
 }
 
-BlockInfoList *qmp_query_block(Error **errp)
+BlockInfoList *coroutine_fn qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
     BlockBackend *blk;
     Error *local_err = NULL;
 
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    GRAPH_RDLOCK_GUARD();
 
     for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
         BlockInfoList *info;
@@ -677,7 +677,7 @@ BlockInfoList *qmp_query_block(Error **errp)
         }
 
         info = g_malloc0(sizeof(*info));
-        bdrv_query_info(blk, &info->value, &local_err);
+        bdrv_co_query_info(blk, &info->value, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             g_free(info);
diff --git a/blockdev.c b/blockdev.c
index 057601dcf0..fe3226c8c4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2744,13 +2744,13 @@ void qmp_drive_backup(DriveBackup *backup, Error **errp)
     blockdev_do_action(&action, errp);
 }
 
-BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
-                                                 bool flat,
-                                                 Error **errp)
+BlockDeviceInfoList *coroutine_fn qmp_query_named_block_nodes(bool has_flat,
+                                                              bool flat,
+                                                              Error **errp)
 {
     bool return_flat = has_flat && flat;
 
-    return bdrv_named_nodes_list(return_flat, errp);
+    return bdrv_co_named_nodes_list(return_flat, errp);
 }
 
 XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad1b1306e3..c0dad1fc86 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -65,6 +65,7 @@ ERST
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .coroutine  = true,
     },
 
 SRST
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index bd7cecd1cf..ee87a0c7d9 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -196,7 +196,8 @@ void bdrv_aio_cancel(BlockAIOCB *acb);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int coroutine_mixed_fn GRAPH_RDLOCK bdrv_has_zero_init(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
-BlockDeviceInfoList *bdrv_named_nodes_list(bool flat, Error **errp);
+BlockDeviceInfoList *coroutine_fn bdrv_co_named_nodes_list(bool flat,
+                                                           Error **errp);
 XDbgBlockGraph * GRAPH_RDLOCK bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..6d9152318f 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -48,7 +48,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
 
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 
-void hmp_info_block(Monitor *mon, const QDict *qdict);
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict);
 void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 349d7760a1..b49e0537dd 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -86,7 +86,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
 int64_t coroutine_fn GRAPH_RDLOCK
 bdrv_co_get_allocated_file_size(BlockDriverState *bs);
 
-int64_t co_wrapper_mixed_bdrv_rdlock
+int64_t co_wrapper_bdrv_rdlock
 bdrv_get_allocated_file_size(BlockDriverState *bs);
 
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 9f0e957963..9274b76814 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -33,9 +33,6 @@
 BlockDeviceInfo *coroutine_fn GRAPH_RDLOCK
 bdrv_co_block_device_info(BlockBackend *blk, BlockDriverState *bs, bool flat,
                           Error **errp);
-BlockDeviceInfo *co_wrapper_bdrv_rdlock
-bdrv_block_device_info(BlockBackend *blk, BlockDriverState *bs, bool flat,
-                       Error **errp);
 int GRAPH_RDLOCK
 bdrv_query_snapshot_info_list(BlockDriverState *bs,
                               SnapshotInfoList **p_list,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 746d1694c2..4a0a336431 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -849,7 +849,7 @@
 #        }
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
-  'allow-preconfig': true }
+  'allow-preconfig': true, 'coroutine': true }
 
 ##
 # @BlockDeviceTimedStats:
@@ -1997,7 +1997,8 @@
 { 'command': 'query-named-block-nodes',
   'returns': [ 'BlockDeviceInfo' ],
   'data': { '*flat': 'bool' },
-  'allow-preconfig': true }
+  'allow-preconfig': true,
+  'coroutine': true}
 
 ##
 # @XDbgBlockGraphNodeType:
-- 
2.35.3


