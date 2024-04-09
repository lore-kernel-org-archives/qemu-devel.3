Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F6CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCx4-00024w-VD; Tue, 09 Apr 2024 10:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCx0-0001wJ-NC; Tue, 09 Apr 2024 10:59:55 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwy-0005xN-UN; Tue, 09 Apr 2024 10:59:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5215E20A78;
 Tue,  9 Apr 2024 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNhniJdJtCPE7hwb4rO4kEJtB24O1r0vXiH7WmETWpE=;
 b=lIdMSM3c+mmoDTn+xSu8jcKmczmSZeSLxCQ+xYKNYdySkzS/AeDRyuSYtMLG3EMAgTdf3X
 ufjfB54jR5QEfInMJ8AcwVTzCN35f1pmb9Z1NFlbH1Bt4E3EeDOHqDwyrz57gFFMc4ysbY
 HhPPszYdOT2iB61C/1j2QKDayPC4PEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNhniJdJtCPE7hwb4rO4kEJtB24O1r0vXiH7WmETWpE=;
 b=qYkYB80SxapEbC0bWbjrHA83wuDYzOEZNat7mVnuZ23HPETTlvPO366d1Bo4Bp8Dq7TwZ4
 Lk3XTFtav3oUHyCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIdMSM3c;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qYkYB80S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNhniJdJtCPE7hwb4rO4kEJtB24O1r0vXiH7WmETWpE=;
 b=lIdMSM3c+mmoDTn+xSu8jcKmczmSZeSLxCQ+xYKNYdySkzS/AeDRyuSYtMLG3EMAgTdf3X
 ufjfB54jR5QEfInMJ8AcwVTzCN35f1pmb9Z1NFlbH1Bt4E3EeDOHqDwyrz57gFFMc4ysbY
 HhPPszYdOT2iB61C/1j2QKDayPC4PEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNhniJdJtCPE7hwb4rO4kEJtB24O1r0vXiH7WmETWpE=;
 b=qYkYB80SxapEbC0bWbjrHA83wuDYzOEZNat7mVnuZ23HPETTlvPO366d1Bo4Bp8Dq7TwZ4
 Lk3XTFtav3oUHyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20EA013313;
 Tue,  9 Apr 2024 14:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eHRGNuNXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 07/11] block: Convert bdrv_query_image_info to coroutine
Date: Tue,  9 Apr 2024 11:59:13 -0300
Message-Id: <20240409145917.6780-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5215E20A78
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

This function is a caller of bdrv_do_query_node_info(), which have
been converted to a coroutine. Convert this function as well so we're
closer from having the whole qmp_query_block as a single coroutine.

Also remove the wrapper for bdrv_co_do_query_node_info() now that all
its callers are converted.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/qapi.c         | 16 +++++++---------
 include/block/qapi.h |  8 ++++----
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 7b1cf48246..5e263960a9 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -304,7 +304,7 @@ bdrv_co_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
 }
 
 /**
- * bdrv_query_image_info:
+ * bdrv_co_query_image_info:
  * @bs: block node to examine
  * @p_info: location to store image information
  * @flat: skip backing node information
@@ -325,17 +325,15 @@ bdrv_co_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
  *
  * @p_info will be set only on success. On error, store error in @errp.
  */
-void bdrv_query_image_info(BlockDriverState *bs,
-                           ImageInfo **p_info,
-                           bool flat,
-                           bool skip_implicit_filters,
-                           Error **errp)
+void coroutine_fn
+bdrv_co_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
+                         bool skip_implicit_filters, Error **errp)
 {
     ERRP_GUARD();
     ImageInfo *info;
 
     info = g_new0(ImageInfo, 1);
-    bdrv_do_query_node_info(bs, qapi_ImageInfo_base(info), errp);
+    bdrv_co_do_query_node_info(bs, qapi_ImageInfo_base(info), errp);
     if (*errp) {
         goto fail;
     }
@@ -353,8 +351,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
         }
 
         if (backing) {
-            bdrv_query_image_info(backing, &info->backing_image, false,
-                                  skip_implicit_filters, errp);
+            bdrv_co_query_image_info(backing, &info->backing_image, false,
+                                     skip_implicit_filters, errp);
             if (*errp) {
                 goto fail;
             }
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 76be9cc3e5..5f7e3a690e 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -38,7 +38,10 @@ int GRAPH_RDLOCK
 bdrv_query_snapshot_info_list(BlockDriverState *bs,
                               SnapshotInfoList **p_list,
                               Error **errp);
-void GRAPH_RDLOCK
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
+                         bool skip_implicit_filters, Error **errp);
+void co_wrapper_bdrv_rdlock
 bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
                       bool skip_implicit_filters, Error **errp);
 
@@ -58,7 +61,4 @@ void bdrv_node_info_dump(BlockNodeInfo *info, int indentation, bool protocol);
 void coroutine_fn GRAPH_RDLOCK
 bdrv_co_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
                            Error **errp);
-void co_wrapper_bdrv_rdlock
-bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
-                        Error **errp);
 #endif
-- 
2.35.3


