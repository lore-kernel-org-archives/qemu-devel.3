Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49342C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEdL-0001BG-Lv; Wed, 26 Aug 2026 10:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdK-0001An-BM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:42 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzEdI-0001v6-Hm
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 10:29:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0007B1F7F8;
 Wed, 26 Aug 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFc6hA/abHmRVaNgSz5gbCQGFsz9FdGFyIKHi0KIXlQ=;
 b=W7iPl918/iK3Vxlrg2tFPtzbLj9NcEM7tlwPmS0E+FsH8eobu1e6ojSalpCE/D5IrlYqmz
 Af2asn/1soV+9AUoQ7DAlz1IHj1f5A6ZtNB1mJTt6VekR4m/+7Wd0hxq6mOSjqA4LRRqsH
 VLkfiH0lHqEKg355n8Vk3uDVTRB1PUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFc6hA/abHmRVaNgSz5gbCQGFsz9FdGFyIKHi0KIXlQ=;
 b=i8usxq50KAzDAMYt4KhNbqsS2hI8T8zJbFrl/S9FPXII7jeS2dZqrkwwLQgWZsI+UqEhVi
 CrjBublyKwhqAOAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CNqepotz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0E8y9jB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787754571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFc6hA/abHmRVaNgSz5gbCQGFsz9FdGFyIKHi0KIXlQ=;
 b=CNqepotzv7wQGxQN9Dkc0gFIc4X4F9Eef4neDhtNVrWCJueeVZqCYL39hNDyl/fKtNUnh+
 1HZwmHG6BqcqG92/ZI7EoHjMBlJCOq00GbEa5lbqr8VaFQwHltwlaYxdkkKb37HkVya6LE
 z1tV6na2vKoxo53fyG9tmrQvcu6Bk2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787754571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aFc6hA/abHmRVaNgSz5gbCQGFsz9FdGFyIKHi0KIXlQ=;
 b=0E8y9jB5wiLLWDAGg5ylkIXk6FnUetMFV38+JqmM+qHfQop9O5oDil1VgCjrt+HjmMy/u1
 6/+P8r0zo8SzlsBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 103FD1361C;
 Wed, 26 Aug 2026 14:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MHanNEn4jmpTJAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 14:29:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Jinpu Wang <jinpu.wang@cloud.ionos.com>
Subject: [PULL 16/30] migration/rdma: Drop RDMALocalBlock.unregister_bitmap
Date: Wed, 26 Aug 2026 11:28:51 -0300
Message-ID: <20260826142905.2315503-17-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
References: <20260826142905.2315503-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.990]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ionos.com:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[ionos.com:email,suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0007B1F7F8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Not used anymore.

Reviewed-by: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/rdma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 63a8370be22..f9f39402568 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -198,7 +198,6 @@ typedef struct RDMALocalBlock {
     unsigned int   src_index;       /* (Only used on dest) */
     int            nb_chunks;
     unsigned long *transit_bitmap;
-    unsigned long *unregister_bitmap;
 } RDMALocalBlock;
 
 /*
@@ -577,8 +576,6 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     block->nb_chunks = ram_chunk_index(host_addr, host_addr + length) + 1UL;
     block->transit_bitmap = bitmap_new(block->nb_chunks);
     bitmap_clear(block->transit_bitmap, 0, block->nb_chunks);
-    block->unregister_bitmap = bitmap_new(block->nb_chunks);
-    bitmap_clear(block->unregister_bitmap, 0, block->nb_chunks);
     block->remote_keys = g_new0(uint32_t, block->nb_chunks);
 
     if (rdma->blockmap) {
@@ -663,9 +660,6 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     g_free(block->transit_bitmap);
     block->transit_bitmap = NULL;
 
-    g_free(block->unregister_bitmap);
-    block->unregister_bitmap = NULL;
-
     g_free(block->remote_keys);
     block->remote_keys = NULL;
 
-- 
2.53.0


