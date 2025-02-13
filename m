Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD02DC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaKF-0005RM-GF; Thu, 13 Feb 2025 09:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tiaK6-0005MG-Qr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:36:15 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tiaK4-0000Pg-Hs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:36:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3A5B1F8BD;
 Thu, 13 Feb 2025 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739457362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8+8ru954tueiSAUG6cNssvTU2aDH5ZuhCuuZVHzEkBM=;
 b=UdkE9zi7jCSfevu0x9+qbtDPOwGLrrbxs7UIv1ZYRj6QGf/71EtxoQz54Nijb6kCVhvkEa
 E4iH9nIkRntobRRD48o7WH4zVbc4/k11OwC/yp6Xcs7b2XY9ODWimVm//GtRfdh/AU/yVW
 w1gkDMmRYE+sC2tWwTUtcSXo8niSgUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739457362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8+8ru954tueiSAUG6cNssvTU2aDH5ZuhCuuZVHzEkBM=;
 b=mOp26QvJXZi9vGdCqzvctrOU5cx33IEBLX8RGEwhBdhDUNTkT6RSAx4SvS04COmtQX+EXo
 J3reFUZm6gdD2KCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UdkE9zi7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mOp26QvJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739457362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8+8ru954tueiSAUG6cNssvTU2aDH5ZuhCuuZVHzEkBM=;
 b=UdkE9zi7jCSfevu0x9+qbtDPOwGLrrbxs7UIv1ZYRj6QGf/71EtxoQz54Nijb6kCVhvkEa
 E4iH9nIkRntobRRD48o7WH4zVbc4/k11OwC/yp6Xcs7b2XY9ODWimVm//GtRfdh/AU/yVW
 w1gkDMmRYE+sC2tWwTUtcSXo8niSgUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739457362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8+8ru954tueiSAUG6cNssvTU2aDH5ZuhCuuZVHzEkBM=;
 b=mOp26QvJXZi9vGdCqzvctrOU5cx33IEBLX8RGEwhBdhDUNTkT6RSAx4SvS04COmtQX+EXo
 J3reFUZm6gdD2KCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10A6A137DB;
 Thu, 13 Feb 2025 14:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GaUKMFADrmd+agAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 14:36:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dario Faggioli <dfaggioli@suse.com>
Subject: [RFC PATCH] elfload: Fix alignment when unmapping excess reservation
Date: Thu, 13 Feb 2025 11:35:58 -0300
Message-Id: <20250213143558.10504-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A3A5B1F8BD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

When complying with the alignment requested in the ELF and unmapping
the excess reservation, having align_end not aligned to the guest page
causes the unmap to be rejected by the alignment check at
target_munmap and later brk adjustments hit an EEXIST.

Fix by aligning the start of region to be unmapped.

Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
In the bug there was mention of the vdso landing in the wrong spot,
but I don't see evidence of this in my testing. Looking at the
addresses in the bug report, there seems to have been a mistake
because I don't see an overlap there either.
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a2c152e5ad..05ee5e74fd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3351,7 +3351,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     if (align_size != reserve_size) {
         abi_ulong align_addr = ROUND_UP(load_addr, align);
-        abi_ulong align_end = align_addr + reserve_size;
+        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
         abi_ulong load_end = load_addr + align_size;
 
         if (align_addr != load_addr) {
-- 
2.35.3


