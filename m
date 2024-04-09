Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F6C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCxC-0002FT-Ju; Tue, 09 Apr 2024 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCx8-0002BV-8e; Tue, 09 Apr 2024 11:00:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCx6-0005zE-BX; Tue, 09 Apr 2024 11:00:01 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A08BC20A6A;
 Tue,  9 Apr 2024 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsAc/pCFXmSQb/9yLrhfsKxho44YarL6SfffbDN0XhA=;
 b=kXBH8NaN6dm1PnEOYCB0igdHZgZZtJaTSjHY3vpbrn2/2tCxginAik+ISLe02f8bA71u4X
 ADcmbhy1EN7+4D3JxW8UNdcXUZmI8ntaju+l9HJg9C2I+e6BirPkcZiqLMICmUM5mhamo3
 7VrmYIUIJOR1LcV4YxARnJY1IHu4AKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsAc/pCFXmSQb/9yLrhfsKxho44YarL6SfffbDN0XhA=;
 b=3mmxl236a9akO4gu/fp0fMPL1OozAkT1m5Qe4B05044Eip8oyLs7EN5LzoqNd1/GuJBtkc
 wwlTQARyATkBEXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsAc/pCFXmSQb/9yLrhfsKxho44YarL6SfffbDN0XhA=;
 b=kXBH8NaN6dm1PnEOYCB0igdHZgZZtJaTSjHY3vpbrn2/2tCxginAik+ISLe02f8bA71u4X
 ADcmbhy1EN7+4D3JxW8UNdcXUZmI8ntaju+l9HJg9C2I+e6BirPkcZiqLMICmUM5mhamo3
 7VrmYIUIJOR1LcV4YxARnJY1IHu4AKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UsAc/pCFXmSQb/9yLrhfsKxho44YarL6SfffbDN0XhA=;
 b=3mmxl236a9akO4gu/fp0fMPL1OozAkT1m5Qe4B05044Eip8oyLs7EN5LzoqNd1/GuJBtkc
 wwlTQARyATkBEXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72DAF1398D;
 Tue,  9 Apr 2024 14:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GPylDutXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 09/11] block: Don't query all block devices at
 hmp_nbd_server_start
Date: Tue,  9 Apr 2024 11:59:15 -0300
Message-Id: <20240409145917.6780-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL14emxp6ck9fz14jedoy69s36)];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We're currently doing a full query-block just to enumerate the devices
for qmp_nbd_server_add and then discarding the BlockInfoList
afterwards. Alter hmp_nbd_server_start to instead iterate explicitly
over the block_backends list.

This allows the removal of the dependency on qmp_query_block from
hmp_nbd_server_start. This is desirable because we're about to move
qmp_query_block into a coroutine and don't need to change the NBD code
at the same time.

Add the GRAPH_RDLOCK_GUARD_MAINLOOP macro because
bdrv_skip_implicit_filters() needs the graph lock.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- add a comment explaining some checks are done to preserve previous
  behavior;

- we need the strdup when assigning .device to preserve const. Just
  add a matching g_free();

- about the possible leak at qmp_nbd_server_add() unrelated to this
  patch, commit 8675cbd68b ("nbd: Utilize QAPI_CLONE for type
  conversion") mentions that the QAPI visitor will already free
  arg->name.
---
 block/monitor/block-hmp-cmds.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index d954bec6f1..9db587c661 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -387,10 +387,12 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     bool all = qdict_get_try_bool(qdict, "all", false);
     Error *local_err = NULL;
-    BlockInfoList *block_list, *info;
+    BlockBackend *blk;
     SocketAddress *addr;
     NbdServerAddOptions export;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (writable && !all) {
         error_setg(&local_err, "-w only valid together with -a");
         goto exit;
@@ -415,29 +417,43 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     /* Then try adding all block devices.  If one fails, close all and
      * exit.
      */
-    block_list = qmp_query_block(NULL);
+    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
+        BlockDriverState *bs = blk_bs(blk);
 
-    for (info = block_list; info; info = info->next) {
-        if (!info->value->inserted) {
+        if (!*blk_name(blk)) {
+            continue;
+        }
+
+        /*
+         * Note: historically we used to call qmp_query_block() to get
+         * the list of block devices. The two 'continue' cases below
+         * are the same as used by that function and are here to
+         * preserve behavior.
+         */
+
+        if (!blk_get_attached_dev(blk)) {
+            continue;
+        }
+
+        bs = bdrv_skip_implicit_filters(bs);
+        if (!bs || !bs->drv) {
             continue;
         }
 
         export = (NbdServerAddOptions) {
-            .device         = info->value->device,
+            .device         = g_strdup(blk_name(blk)),
             .has_writable   = true,
             .writable       = writable,
         };
 
         qmp_nbd_server_add(&export, &local_err);
-
+        g_free(export.device);
         if (local_err != NULL) {
             qmp_nbd_server_stop(NULL);
             break;
         }
     }
 
-    qapi_free_BlockInfoList(block_list);
-
 exit:
     hmp_handle_error(mon, local_err);
 }
-- 
2.35.3


