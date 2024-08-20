Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81522C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 17:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgSLF-0003nf-No; Tue, 20 Aug 2024 13:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sgSKz-0003ln-MU; Tue, 20 Aug 2024 13:08:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sgSKv-0007bQ-NG; Tue, 20 Aug 2024 13:08:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73FE02001C;
 Tue, 20 Aug 2024 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724173679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLw0kKg9KVAuTkembzTxqyMpoF7BRWSo5aG/NLnlwpM=;
 b=OrzpHgqe02If0yDulW04EoFSjsXt6A9QZSqw0elFsMU49Q6tgOINh10oC1UswCTn0vY2vE
 R39nWah0abN/bbwkBRGdbHGSud+tFB3i46/OEx8kR/pYWSI7gcLghh2jW95beQPQjM6Ipt
 wziN7ddcFZvPVbFIzW7jCXIzs/kkLqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724173679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLw0kKg9KVAuTkembzTxqyMpoF7BRWSo5aG/NLnlwpM=;
 b=qvQPnR3Tc/vrh0jqvAvOW+hvJTDn9osdIMAVD4cA+W/Zvm/RjHZAgqeZZawKpO9s7uOIqi
 MSbml0oA7FkwAYCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OrzpHgqe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qvQPnR3T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724173679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLw0kKg9KVAuTkembzTxqyMpoF7BRWSo5aG/NLnlwpM=;
 b=OrzpHgqe02If0yDulW04EoFSjsXt6A9QZSqw0elFsMU49Q6tgOINh10oC1UswCTn0vY2vE
 R39nWah0abN/bbwkBRGdbHGSud+tFB3i46/OEx8kR/pYWSI7gcLghh2jW95beQPQjM6Ipt
 wziN7ddcFZvPVbFIzW7jCXIzs/kkLqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724173679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLw0kKg9KVAuTkembzTxqyMpoF7BRWSo5aG/NLnlwpM=;
 b=qvQPnR3Tc/vrh0jqvAvOW+hvJTDn9osdIMAVD4cA+W/Zvm/RjHZAgqeZZawKpO9s7uOIqi
 MSbml0oA7FkwAYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CED4B13770;
 Tue, 20 Aug 2024 17:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gMTcJG3NxGZfUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Aug 2024 17:07:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: [PULL 1/1] migration/multifd: Free MultiFDRecvParams::data
Date: Tue, 20 Aug 2024 14:07:41 -0300
Message-Id: <20240820170741.27055-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240820170741.27055-1-farosas@suse.de>
References: <20240820170741.27055-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73FE02001C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In multifd_recv_setup() we allocate (among other things)
 * a MultiFDRecvData struct to multifd_recv_state::data
 * a MultiFDRecvData struct to each multfd_recv_state->params[i].data

(Then during execution we might swap these pointers around.)

But in multifd_recv_cleanup() we free multifd_recv_state->data
in multifd_recv_cleanup_state() but we don't ever free the
multifd_recv_state->params[i].data. This results in a memory
leak reported by LeakSanitizer:

(cd build/asan && \
   ASAN_OPTIONS="fast_unwind_on_malloc=0:strip_path_prefix=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/../../" \
   QTEST_QEMU_BINARY=./qemu-system-x86_64 \
   ./tests/qtest/migration-test --tap -k -p /x86_64/migration/multifd/file/mapped-ram )
[...]
Direct leak of 72 byte(s) in 3 object(s) allocated from:
    #0 0x561cc0afcfd8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)
    #1 0x7f89d37acc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x561cc1e9c83c in multifd_recv_setup migration/multifd.c:1606:19
    #3 0x561cc1e68618 in migration_ioc_process_incoming migration/migration.c:972:9
    #4 0x561cc1e3ac59 in migration_channel_process_incoming migration/channel.c:45:9
    #5 0x561cc1e4fa0b in file_accept_incoming_migration migration/file.c:132:5
    #6 0x561cc30f2c0c in qio_channel_fd_source_dispatch io/channel-watch.c:84:12
    #7 0x7f89d37a3c43 in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
    #8 0x7f89d37a3c43 in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
    #9 0x561cc3b21659 in glib_pollfds_poll util/main-loop.c:287:9
    #10 0x561cc3b1ff93 in os_host_main_loop_wait util/main-loop.c:310:5
    #11 0x561cc3b1fb5c in main_loop_wait util/main-loop.c:589:11
    #12 0x561cc1da2917 in qemu_main_loop system/runstate.c:801:9
    #13 0x561cc3796c1c in qemu_default_main system/main.c:37:14
    #14 0x561cc3796c67 in main system/main.c:48:12
    #15 0x7f89d163bd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #16 0x7f89d163be3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #17 0x561cc0a79fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x561cc0afcfd8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x218efd8) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)
    #1 0x7f89d37acc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x561cc1e9bed9 in multifd_recv_setup migration/multifd.c:1588:32
    #3 0x561cc1e68618 in migration_ioc_process_incoming migration/migration.c:972:9
    #4 0x561cc1e3ac59 in migration_channel_process_incoming migration/channel.c:45:9
    #5 0x561cc1e4fa0b in file_accept_incoming_migration migration/file.c:132:5
    #6 0x561cc30f2c0c in qio_channel_fd_source_dispatch io/channel-watch.c:84:12
    #7 0x7f89d37a3c43 in g_main_dispatch debian/build/deb/../../../glib/gmain.c:3419:28
    #8 0x7f89d37a3c43 in g_main_context_dispatch debian/build/deb/../../../glib/gmain.c:4137:7
    #9 0x561cc3b21659 in glib_pollfds_poll util/main-loop.c:287:9
    #10 0x561cc3b1ff93 in os_host_main_loop_wait util/main-loop.c:310:5
    #11 0x561cc3b1fb5c in main_loop_wait util/main-loop.c:589:11
    #12 0x561cc1da2917 in qemu_main_loop system/runstate.c:801:9
    #13 0x561cc3796c1c in qemu_default_main system/main.c:37:14
    #14 0x561cc3796c67 in main system/main.c:48:12
    #15 0x7f89d163bd8f in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #16 0x7f89d163be3f in __libc_start_main csu/../csu/libc-start.c:392:3
    #17 0x561cc0a79fa4 in _start (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-x86_64+0x210bfa4) (BuildId: be72e086d4e47b172b0a72779972213fd9916466)

SUMMARY: AddressSanitizer: 96 byte(s) leaked in 4 allocation(s).

Free the params[i].data too.

Cc: qemu-stable@nongnu.org
Fixes: d117ed0699d41 ("migration/multifd: Allow receiving pages without packets")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 552f9723c8..a6db05502a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1357,6 +1357,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
     qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem_sync);
     qemu_sem_destroy(&p->sem);
+    g_free(p->data);
+    p->data = NULL;
     g_free(p->name);
     p->name = NULL;
     p->packet_len = 0;
-- 
2.35.3


