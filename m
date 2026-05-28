Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD78CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbCe-0002lf-Cf; Thu, 28 May 2026 09:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSbCd-0002lN-4J
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:55:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSbCb-0005Xa-0I
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:55:14 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A1516AB08;
 Thu, 28 May 2026 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779976511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mvt8HAbeb+vfwDW+p52H+L0MhfCz/9ML0WXyabvacX4=;
 b=wFajWEClzRkxvBuJQPDWMSgZiDzyv7Q1ApR2ApeaD0uM2YmuJypckfYN57q8+Lm5AD8gm4
 5gLwYBKjJHW5PCDtARtfqKP7zy1cRkZWvh608+DUQnlsKwtYC84EiJrb2YG5mkxqqSrFQU
 BuS2z5XWO66VoUssqIpr8CFGyyUmcdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779976511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mvt8HAbeb+vfwDW+p52H+L0MhfCz/9ML0WXyabvacX4=;
 b=h1cnSJRR0GxOy1qI86XCEtshcsqjCj8wBZ0EUyDz07GLhQzt0uZk0oLIcpqtsR0NjsiTBk
 pYiopjtcPj99E8DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wFajWECl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h1cnSJRR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779976511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mvt8HAbeb+vfwDW+p52H+L0MhfCz/9ML0WXyabvacX4=;
 b=wFajWEClzRkxvBuJQPDWMSgZiDzyv7Q1ApR2ApeaD0uM2YmuJypckfYN57q8+Lm5AD8gm4
 5gLwYBKjJHW5PCDtARtfqKP7zy1cRkZWvh608+DUQnlsKwtYC84EiJrb2YG5mkxqqSrFQU
 BuS2z5XWO66VoUssqIpr8CFGyyUmcdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779976511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Mvt8HAbeb+vfwDW+p52H+L0MhfCz/9ML0WXyabvacX4=;
 b=h1cnSJRR0GxOy1qI86XCEtshcsqjCj8wBZ0EUyDz07GLhQzt0uZk0oLIcpqtsR0NjsiTBk
 pYiopjtcPj99E8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2CA45AE02;
 Thu, 28 May 2026 13:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B+OWJD1JGGq0WgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 May 2026 13:55:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v1] qed: Don't try to drain during INMIGRATE
Date: Thu, 28 May 2026 10:55:07 -0300
Message-ID: <20260528135507.485-1-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1A1516AB08
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It's not possible to access the image file while there is an incoming
migration in progress, the QEMU process doesn't hold any locks to the
storage at this point so nodes are inactive. Attempting to drain leads
to an assert at bdrv_co_write_req_prepare():

   assert(!(bs->open_flags & BDRV_O_INACTIVE))

The issue is reproducible by running iotest 181 on a host under cpu
load. The migration must coincide with the header already containing
the QED_F_NEED_CHECK flag.

The sequence of events is as follows, with the respective call stacks
referenced below:

During block device init, bdrv_qed_attach_aio_context() starts the
'need_check' timer. The timer will not fire during incoming migration
as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
comment indicates).                                                   (0)

However, there's still bdrv_qed_drain_begin() which uses the fact that
the timer is live to decide whether to start the
qed_need_check_timer_entry() directly.                                (1)

The qed_need_check_timer_entry() eventually calls into
qed_write_header() -> bdrv_co_pwrite() leading to the assert.         (2)

Since we don't have an API for checking if a timer is enabled, an
alternative is to skip this logic whenever the runstate is
INMIGRATE. This actually matches the setting of the BDRV_O_INACTIVE
flag at blockdev.c.

The stacks:

(0) == issues timer_mod ==
 #6  in qed_start_need_check_timer       at ../block/qed.c:340
 #7  in bdrv_qed_attach_aio_context      at ../block/qed.c:373
 #8  in bdrv_qed_do_open                 at ../block/qed.c:556
 #9  in bdrv_qed_open_entry              at ../block/qed.c:582
 #10 in coroutine_trampoline             at ../util/coroutine-ucontext.c:175
 #0  in qemu_coroutine_switch<+120>      at ../util/coroutine-ucontext.c:321
 #1  in qemu_aio_coroutine_enter<+356>   at ../util/qemu-coroutine.c:293
 #2  in aio_co_enter<+179>               at ../util/async.c:710
 #3  in aio_co_wake<+53>                 at ../util/async.c:695
 #4  in thread_pool_co_cb<+47>           at ../util/thread-pool.c:283
 #5  in thread_pool_completion_bh<+241>  at ../util/thread-pool.c:202
 #6  in aio_bh_call<+109>                at ../util/async.c:173
 #7  in aio_bh_poll<+299>                at ../util/async.c:220
 #8  in aio_poll<+690>                   at ../util/aio-posix.c:745
 #9  in bdrv_qed_open<+392>              at ../block/qed.c:607
 #10 in bdrv_open_driver<+327>           at ../block.c:1678
 #11 in bdrv_open_common<+1619>          at ../block.c:2008
 #12 in bdrv_open_inherit<+2556>         at ../block.c:4191
 #13 in bdrv_open<+118>                  at ../block.c:4286
 #14 in blk_new_open<+199>               at ../block/block-backend.c:458
 #15 in blockdev_init<+2011>             at ../blockdev.c:612
 #16 in drive_new<+3008>                 at ../blockdev.c:1008
 #17 in drive_init_func<+51>             at ../system/vl.c:662
 #18 in qemu_opts_foreach<+227>          at ../util/qemu-option.c:1148
 #19 in configure_blockdev<+350>         at ../system/vl.c:721
 #20 in qemu_create_early_backends<+343> at ../system/vl.c:2076
 #21 in qemu_init<+12483>                at ../system/vl.c:3778
 #22 in main<+46>                        at ../system/main.c:71

(1) == sees timer_pending ==
 #6  in bdrv_qed_drain_begin             at ../block/qed.c:391
 #7  in bdrv_do_drained_begin            at ../block/io.c:366
 #8  in bdrv_do_drained_begin_quiesce    at ../block/io.c:386
 #9  in bdrv_child_cb_drained_begin      at ../block.c:1207
 #10 in bdrv_parent_drained_begin_single at ../block/io.c:133
 #11 in bdrv_parent_drained_begin        at ../block/io.c:64
 #12 in bdrv_do_drained_begin            at ../block/io.c:364
 #13 in bdrv_drained_begin               at ../block/io.c:393
 #14 in blk_drain                        at ../block/block-backend.c:2101
 #15 in blk_unref                        at ../block/block-backend.c:544
 #16 in bdrv_open_inherit                at ../block.c:4197
 #17 in bdrv_open                        at ../block.c:4286
 #18 in blk_new_open                     at ../block/block-backend.c:458
 #19 in blockdev_init                    at ../blockdev.c:612
 #20 in drive_new                        at ../blockdev.c:1008
 #21 in drive_init_func                  at ../system/vl.c:662
 #22 in qemu_opts_foreach                at ../util/qemu-option.c:1148
 #23 in configure_blockdev               at ../system/vl.c:721
 #24 in qemu_create_early_backends       at ../system/vl.c:2076
 #25 in qemu_init                        at ../system/vl.c:3778
 #26 in main                             at ../system/main.c:71

(2) == crashes ==
 #5  in __assert_fail (assertion="!(bs->open_flags & BDRV_O_INACTIVE)", file="../block/io.c", line=1977
 #6  in bdrv_co_write_req_prepare  at ../block/io.c:1977
 #7  in bdrv_aligned_pwritev       at ../block/io.c:2099
 #8  in bdrv_co_pwritev_part       at ../block/io.c:2316
 #9  in bdrv_co_pwritev            at ../block/io.c:2233
 #10 in bdrv_co_pwrite             at ../include/block/block_int-io.h:77
 #11 in qed_write_header           at ../block/qed.c:128
 #12 in qed_need_check_timer       at ../block/qed.c:305
 #13 in qed_need_check_timer_entry at ../block/qed.c:319

Note that this issue is not exactly the same as what's been reported
in Gitlab, but given how easily this reproduces, I imagine it has to
be happening in that setup as well.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3515
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/2557314306
---
 block/qed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qed.c b/block/qed.c
index da23a83d62..ccf32bb4ae 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -21,6 +21,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/memalign.h"
+#include "system/runstate.h"
 #include "trace.h"
 #include "qed.h"
 #include "system/block-backend.h"
@@ -373,6 +374,11 @@ static void bdrv_qed_drain_begin(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
+    /* Nodes are inactive while waiting for an incoming migration. */
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        return;
+    }
+
     /* Fire the timer immediately in order to start doing I/O as soon as the
      * header is flushed.
      */
-- 
2.51.0


