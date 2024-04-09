Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3ABCD129C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 15:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCx2-00021U-Nu; Tue, 09 Apr 2024 10:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwt-0001rw-5w; Tue, 09 Apr 2024 10:59:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1ruCwr-0005w0-E3; Tue, 09 Apr 2024 10:59:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F247E33A53;
 Tue,  9 Apr 2024 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXN44mQf0i947fYSpOF7uoOsAHoUzjJX+q+hPuynvl0=;
 b=Op4JUdbzPtgd0mehCws6T22pvJkLVDcPnRJzok0oMBxkbT1K4d3gOav8oAyOqwmnH6tstL
 1+cTrqvqVXN/mnDBck2Ge85AQ/WdfYPHyacmXIk1KzC+aLlgrLXHaNgzslXmUFJL042eyX
 I3mSNkyv+SnZjXvQw5AFPpip6nXxHl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXN44mQf0i947fYSpOF7uoOsAHoUzjJX+q+hPuynvl0=;
 b=i2uHJ3Qbir2MhsGAGe98feMVT9ntKEp4kpUYY0gsHqpwqbzYpmJkA0sn6ZJaxXxYGQ9uRb
 y1ojRRo6CadYFBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712674783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXN44mQf0i947fYSpOF7uoOsAHoUzjJX+q+hPuynvl0=;
 b=G8gCe+JBnBPdlViW2DyXUQtRsPOoMTTxOm3W5YKlM8EDFz80zMUJ1/PD3KMomjH9x4Ixf6
 wxRm8A94m8ggUsWJjTWYvY3VzhTR+hy6o08suxPrqCJw3FDnOGbgD3HL6my/7cI/Yok4mz
 seFa2YyBAghAAz8ENMj17xOuQAdJ+7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712674783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXN44mQf0i947fYSpOF7uoOsAHoUzjJX+q+hPuynvl0=;
 b=9eHFKBhAmYiJAPeON3aqfv8W5C/RUJEYLgu0Rt0vCjPSnTqu9TpqS9uNWn5QCpkxDvrxct
 X+1qK1xRdn5d01BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5F5F13313;
 Tue,  9 Apr 2024 14:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uIXqItxXFWZGOAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Apr 2024 14:59:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/11] block: Run bdrv_do_query_node_info in a coroutine
Date: Tue,  9 Apr 2024 11:59:11 -0300
Message-Id: <20240409145917.6780-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240409145917.6780-1-farosas@suse.de>
References: <20240409145917.6780-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.988];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[12]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Move this function into a coroutine so we can convert the whole
qmp_query_block command into a coroutine in the next patches.

Placing the entire command in a coroutine allow us to yield all the
way back to the main loop, releasing the BQL and unblocking the main
loop.

When the whole conversion is completed, we'll be able to avoid a
priority inversion that happens when a QMP command calls a slow
(buggy) system call and blocks the vcpu thread from doing mmio due to
contention on the BQL.

About coroutine safety:

Most callees have coroutine versions themselves and thus are safe to
call in a coroutine. The remaining ones:

- bdrv_refresh_filename, bdrv_get_full_backing_filename: String
  manipulation, nothing that would be unsafe for use in coroutines;

- bdrv_get_format_name: Just accesses a field;

- bdrv_get_specific_info, bdrv_query_snapshot_info_list: No locks or
  anything that would poll or block.

(using a mixed wrapper for now, but after all callers are converted,
this can become a coroutine exclusively)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- used the coroutine version of the called functions when available
---
 block/qapi.c         | 11 ++++++-----
 include/block/qapi.h |  8 ++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 2b5793f1d9..26a9510345 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -225,8 +225,9 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
  * Helper function for other query info functions.  Store information about @bs
  * in @info, setting @errp on error.
  */
-static void GRAPH_RDLOCK
-bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
+void coroutine_fn
+bdrv_co_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
+                           Error **errp)
 {
     int64_t size;
     const char *backing_filename;
@@ -234,7 +235,7 @@ bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
     int ret;
     Error *err = NULL;
 
-    size = bdrv_getlength(bs);
+    size = bdrv_co_getlength(bs);
     if (size < 0) {
         error_setg_errno(errp, -size, "Can't get image size '%s'",
                          bs->exact_filename);
@@ -246,13 +247,13 @@ bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
-    info->actual_size     = bdrv_get_allocated_file_size(bs);
+    info->actual_size     = bdrv_co_get_allocated_file_size(bs);
     info->has_actual_size = info->actual_size >= 0;
     if (bs->encrypted) {
         info->encrypted = true;
         info->has_encrypted = true;
     }
-    if (bdrv_get_info(bs, &bdi) >= 0) {
+    if (bdrv_co_get_info(bs, &bdi) >= 0) {
         if (bdi.cluster_size != 0) {
             info->cluster_size = bdi.cluster_size;
             info->has_cluster_size = true;
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 54c48de26a..234730b3de 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -25,6 +25,7 @@
 #ifndef BLOCK_QAPI_H
 #define BLOCK_QAPI_H
 
+#include "block/block-common.h"
 #include "block/graph-lock.h"
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
@@ -49,4 +50,11 @@ void bdrv_image_info_specific_dump(ImageInfoSpecific *info_spec,
                                    const char *prefix,
                                    int indentation);
 void bdrv_node_info_dump(BlockNodeInfo *info, int indentation, bool protocol);
+
+void coroutine_fn GRAPH_RDLOCK
+bdrv_co_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
+                           Error **errp);
+void co_wrapper_bdrv_rdlock
+bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info,
+                        Error **errp);
 #endif
-- 
2.35.3


