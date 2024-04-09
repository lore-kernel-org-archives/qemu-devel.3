Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECC2C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCx2-00021b-Pu; Tue, 09 Apr 2024 10:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCww-0001sC-VW; Tue, 09 Apr 2024 10:59:52 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwv-0005wf-A1; Tue, 09 Apr 2024 10:59:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE27220A78;
 Tue,  9 Apr 2024 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAYIpAd1qbdyRj+S8CALiYZ5ko2puswcHyLu7YCTDbo=;
 b=oTsapD+KuXzonp8KzH+4tneOvzh8oh4LNA3+U01KI2TPobeH6DDuXcuVkHD4kdleIKf3+H
 k1e25QEIO0Cw6lqAAwIeX3PAwk49SB8b1CtBQUmN3EAgsPlgjv/joQlezfbJ4eKiLtsut5
 G3ZuePJuRGb8YWu8S08sNTuBg/yBB8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAYIpAd1qbdyRj+S8CALiYZ5ko2puswcHyLu7YCTDbo=;
 b=lKhWATIs+hK0g8XYSlkFXwC6xJQt3uxPdB7RxiQM98hOQ66vCPMpQ8++CRcv3eHuY6mtaI
 FWet+QuSCQhQf4Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAYIpAd1qbdyRj+S8CALiYZ5ko2puswcHyLu7YCTDbo=;
 b=oTsapD+KuXzonp8KzH+4tneOvzh8oh4LNA3+U01KI2TPobeH6DDuXcuVkHD4kdleIKf3+H
 k1e25QEIO0Cw6lqAAwIeX3PAwk49SB8b1CtBQUmN3EAgsPlgjv/joQlezfbJ4eKiLtsut5
 G3ZuePJuRGb8YWu8S08sNTuBg/yBB8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674787;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAYIpAd1qbdyRj+S8CALiYZ5ko2puswcHyLu7YCTDbo=;
 b=lKhWATIs+hK0g8XYSlkFXwC6xJQt3uxPdB7RxiQM98hOQ66vCPMpQ8++CRcv3eHuY6mtaI
 FWet+QuSCQhQf4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7380113313;
 Tue,  9 Apr 2024 14:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CPYDuBXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 06/11] block: Convert bdrv_query_block_graph_info to
 coroutine
Date: Tue,  9 Apr 2024 11:59:12 -0300
Message-Id: <20240409145917.6780-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL14emxp6ck9fz14jedoy69s36)];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
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

We're converting callers of bdrv_co_get_allocated_file_size() to run
in coroutines because that function will be made asynchronous when
called (indirectly) from the QMP dispatcher.

This function is a candidate because it calls bdrv_do_query_node_info(),
which in turn calls bdrv_co_get_allocated_file_size().

All the functions called from bdrv_do_query_node_info() onwards are
coroutine-safe, either have a coroutine version themselves[1] or are
mostly simple code/string manipulation[2].

1) bdrv_co_getlength(), bdrv_co_get_allocated_file_size(),
   bdrv_co_get_info();

2) bdrv_refresh_filename(), bdrv_get_format_name(),
   bdrv_get_full_backing_filename(), bdrv_query_snapshot_info_list(),
   bdrv_get_specific_info();

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qapi.c         | 14 ++++++++------
 include/block/qapi.h |  6 +++++-
 qemu-img.c           |  3 ---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 26a9510345..7b1cf48246 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -370,7 +370,7 @@ fail:
 }
 
 /**
- * bdrv_query_block_graph_info:
+ * bdrv_co_query_block_graph_info:
  * @bs: root node to start from
  * @p_info: location to store image information
  * @errp: location to store error information
@@ -379,17 +379,19 @@ fail:
  *
  * @p_info will be set only on success. On error, store error in @errp.
  */
-void bdrv_query_block_graph_info(BlockDriverState *bs,
-                                 BlockGraphInfo **p_info,
-                                 Error **errp)
+void coroutine_fn
+bdrv_co_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
+                               Error **errp)
 {
     ERRP_GUARD();
     BlockGraphInfo *info;
     BlockChildInfoList **children_list_tail;
     BdrvChild *c;
 
+    assert_bdrv_graph_readable();
+
     info = g_new0(BlockGraphInfo, 1);
-    bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), errp);
+    bdrv_co_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), errp);
     if (*errp) {
         goto fail;
     }
@@ -403,7 +405,7 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
         QAPI_LIST_APPEND(children_list_tail, c_info);
 
         c_info->name = g_strdup(c->name);
-        bdrv_query_block_graph_info(c->bs, &c_info->info, errp);
+        bdrv_co_query_block_graph_info(c->bs, &c_info->info, errp);
         if (*errp) {
             goto fail;
         }
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 234730b3de..76be9cc3e5 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -41,7 +41,11 @@ bdrv_query_snapshot_info_list(BlockDriverState *bs,
 void GRAPH_RDLOCK
 bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
                       bool skip_implicit_filters, Error **errp);
-void GRAPH_RDLOCK
+
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
+                               Error **errp);
+void co_wrapper_bdrv_rdlock
 bdrv_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
                             Error **errp);
 
diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..19db8f18fc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2958,10 +2958,7 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
          * duplicate the backing chain information that we obtain by walking
          * the chain manually here.
          */
-        bdrv_graph_rdlock_main_loop();
         bdrv_query_block_graph_info(bs, &info, &err);
-        bdrv_graph_rdunlock_main_loop();
-
         if (err) {
             error_report_err(err);
             blk_unref(blk);
-- 
2.35.3


