Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFBFC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCxA-0002CD-4h; Tue, 09 Apr 2024 11:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCx7-0002B3-Q8; Tue, 09 Apr 2024 11:00:01 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCx5-0005yq-5m; Tue, 09 Apr 2024 11:00:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01CCD33A53;
 Tue,  9 Apr 2024 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UitpenjgjaZ/EGFw0QIA5tUbLvxpmY7Nii+8cAT9XSc=;
 b=wvhLbUinMgKSJApHuoaaUreBTbz1Q5i26lB4qm59Xm6XAT9myRI8b3MdfnQb2OoibnLzVq
 Uk448S3f8MSqj1cUar/yM3NrY1ha5ZqtEs9qTVoIvS35KtOJO/yguUXv7gbzvEWCZ54jLY
 o2/mUS1Hl9Jmsgs3EyVO6/VKduSjHWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UitpenjgjaZ/EGFw0QIA5tUbLvxpmY7Nii+8cAT9XSc=;
 b=eIn3Hh1PIxRxg4gCqpGgQWCe1FboOaPaMTnEOwgMYLwVajE3u9U5Z/Et2KJ4Lpi9Sfn4ig
 RAChL+g+l69QYSDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wvhLbUin;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eIn3Hh1P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UitpenjgjaZ/EGFw0QIA5tUbLvxpmY7Nii+8cAT9XSc=;
 b=wvhLbUinMgKSJApHuoaaUreBTbz1Q5i26lB4qm59Xm6XAT9myRI8b3MdfnQb2OoibnLzVq
 Uk448S3f8MSqj1cUar/yM3NrY1ha5ZqtEs9qTVoIvS35KtOJO/yguUXv7gbzvEWCZ54jLY
 o2/mUS1Hl9Jmsgs3EyVO6/VKduSjHWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UitpenjgjaZ/EGFw0QIA5tUbLvxpmY7Nii+8cAT9XSc=;
 b=eIn3Hh1PIxRxg4gCqpGgQWCe1FboOaPaMTnEOwgMYLwVajE3u9U5Z/Et2KJ4Lpi9Sfn4ig
 RAChL+g+l69QYSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5F2B13313;
 Tue,  9 Apr 2024 14:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iA2sIudXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 08/11] block: Convert bdrv_block_device_info into co_wrapper
Date: Tue,  9 Apr 2024 11:59:14 -0300
Message-Id: <20240409145917.6780-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 01CCD33A53
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL8i9y4krh53rntrk3u7dj74zf)];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We're converting callers of bdrv_co_get_allocated_file_size() to run
in coroutines because that function will be made asynchronous when
called (indirectly) from the QMP dispatcher.

This function is a candidate because it calls bdrv_query_image_info()
-> bdrv_co_do_query_node_info() -> bdrv_co_get_allocated_file_size().

It is safe to turn this is a coroutine because the code it calls is
made up of either simple accessors and string manipulation functions
[1] or it has already been determined to be safe [2].

1) bdrv_refresh_filename(), bdrv_is_read_only(),
   blk_enable_write_cache(), bdrv_cow_bs(), blk_get_public(),
   throttle_group_get_name(), bdrv_write_threshold_get(),
   bdrv_query_dirty_bitmaps(), throttle_group_get_config(),
   bdrv_filter_or_cow_bs(), bdrv_skip_implicit_filters()

2) bdrv_co_do_query_node_info() (see previous commits);

This was the only caller of bdrv_query_image_info(), so we can remove
the wrapper for that function now.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- used co_wrapper_bdrv_rdlock instead of co_wrapper
---
 block/qapi.c         | 10 +++++-----
 include/block/qapi.h | 13 ++++++-------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 5e263960a9..9a59e5606f 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -41,10 +41,10 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 
-BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs,
-                                        bool flat,
-                                        Error **errp)
+BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
+                                                        BlockDriverState *bs,
+                                                        bool flat,
+                                                        Error **errp)
 {
     ERRP_GUARD();
     ImageInfo **p_image_info;
@@ -152,7 +152,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
      * Skip automatically inserted nodes that the user isn't aware of for
      * query-block (blk != NULL), but not for query-named-block-nodes
      */
-    bdrv_query_image_info(bs, p_image_info, flat, blk != NULL, errp);
+    bdrv_co_query_image_info(bs, p_image_info, flat, blk != NULL, errp);
     if (*errp) {
         qapi_free_BlockDeviceInfo(info);
         return NULL;
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 5f7e3a690e..9f0e957963 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -30,10 +30,12 @@
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
 
-BlockDeviceInfo * GRAPH_RDLOCK
-bdrv_block_device_info(BlockBackend *blk, BlockDriverState *bs,
-                       bool flat, Error **errp);
-
+BlockDeviceInfo *coroutine_fn GRAPH_RDLOCK
+bdrv_co_block_device_info(BlockBackend *blk, BlockDriverState *bs, bool flat,
+                          Error **errp);
+BlockDeviceInfo *co_wrapper_bdrv_rdlock
+bdrv_block_device_info(BlockBackend *blk, BlockDriverState *bs, bool flat,
+                       Error **errp);
 int GRAPH_RDLOCK
 bdrv_query_snapshot_info_list(BlockDriverState *bs,
                               SnapshotInfoList **p_list,
@@ -41,9 +43,6 @@ bdrv_query_snapshot_info_list(BlockDriverState *bs,
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
                          bool skip_implicit_filters, Error **errp);
-void co_wrapper_bdrv_rdlock
-bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
-                      bool skip_implicit_filters, Error **errp);
 
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
-- 
2.35.3


