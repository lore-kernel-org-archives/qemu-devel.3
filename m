Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFADD12D49
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVmC-00030G-Oh; Mon, 11 Nov 2024 09:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tAVmA-0002yO-I8; Mon, 11 Nov 2024 09:52:22 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tAVm8-0002AS-Lf; Mon, 11 Nov 2024 09:52:22 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DD991F38E;
 Mon, 11 Nov 2024 14:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731336738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wPf3EusIvQUP5CbuI5hx2eO4SVkYd5Ku04n6CjnmX4Y=;
 b=IoQiQDHS6A5rLAxA26fU/LAh+f9LHemlsRLF8bnorlSWTLWojkOu4d0f61Wp6Bq7RDBRch
 7ELUmHKTVHwdUmQVWIFBPAIPImX+A9xkBtj28i+693aMWfuxif1HxirK7tcOIo9DzHmI75
 mRkR7u2z/YRDuhHpiZXY6o9+euFPAX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731336738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wPf3EusIvQUP5CbuI5hx2eO4SVkYd5Ku04n6CjnmX4Y=;
 b=0AnMPpbx1PbGP4Xvn/ffH0if/fMz3rBJaf4hdZX2+cDIQe5F0AoGAoZBSFxhVnhrLJD/L1
 SQRA87weQR50giBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IoQiQDHS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0AnMPpbx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731336738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wPf3EusIvQUP5CbuI5hx2eO4SVkYd5Ku04n6CjnmX4Y=;
 b=IoQiQDHS6A5rLAxA26fU/LAh+f9LHemlsRLF8bnorlSWTLWojkOu4d0f61Wp6Bq7RDBRch
 7ELUmHKTVHwdUmQVWIFBPAIPImX+A9xkBtj28i+693aMWfuxif1HxirK7tcOIo9DzHmI75
 mRkR7u2z/YRDuhHpiZXY6o9+euFPAX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731336738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wPf3EusIvQUP5CbuI5hx2eO4SVkYd5Ku04n6CjnmX4Y=;
 b=0AnMPpbx1PbGP4Xvn/ffH0if/fMz3rBJaf4hdZX2+cDIQe5F0AoGAoZBSFxhVnhrLJD/L1
 SQRA87weQR50giBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D88313301;
 Mon, 11 Nov 2024 14:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lym5OCAaMmeSbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Nov 2024 14:52:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] block: Fix leak in send_qmp_error_event
Date: Mon, 11 Nov 2024 11:52:14 -0300
Message-Id: <20241111145214.8261-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DD991F38E
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ASAN detected a leak when running the ahci-test
/ahci/io/dma/lba28/retry:

Direct leak of 35 byte(s) in 1 object(s) allocated from:
    #0 in malloc
    #1 in __vasprintf_internal
    #2 in vasprintf
    #3 in g_vasprintf
    #4 in g_strdup_vprintf
    #5 in g_strdup_printf
    #6 in object_get_canonical_path ../qom/object.c:2096:19
    #7 in blk_get_attached_dev_id_or_path ../block/block-backend.c:1033:12
    #8 in blk_get_attached_dev_path ../block/block-backend.c:1047:12
    #9 in send_qmp_error_event ../block/block-backend.c:2140:36
    #10 in blk_error_action ../block/block-backend.c:2172:9
    #11 in ide_handle_rw_error ../hw/ide/core.c:875:5
    #12 in ide_dma_cb ../hw/ide/core.c:894:13
    #13 in dma_complete ../system/dma-helpers.c:107:9
    #14 in dma_blk_cb ../system/dma-helpers.c:129:9
    #15 in blk_aio_complete ../block/block-backend.c:1552:9
    #16 in blk_aio_write_entry ../block/block-backend.c:1619:5
    #17 in coroutine_trampoline ../util/coroutine-ucontext.c:175:9

Plug the leak by freeing the device path string.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/block-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 85bcdedcef..a3b7f00188 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2134,13 +2134,14 @@ static void send_qmp_error_event(BlockBackend *blk,
 {
     IoOperationType optype;
     BlockDriverState *bs = blk_bs(blk);
+    char *path = blk_get_attached_dev_path(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk),
-                                   blk_get_attached_dev_path(blk),
+    qapi_event_send_block_io_error(blk_name(blk), path,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
+    g_free(path);
 }
 
 /* This is done by device models because, while the block layer knows
-- 
2.35.3


