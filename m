Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558DECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUu7D-0007XG-BY; Wed, 03 Jun 2026 18:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUu7C-0007Wz-J4
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:31:10 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wUu7B-0005vi-0G
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 18:31:10 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D6A86A80E;
 Wed,  3 Jun 2026 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780525866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Qeo7Y2gRYxrMiI/rFV1bSRa4NhH7u6R/B+Va6qNK70=;
 b=xArdlvHBzylEDo7Y0MLANmHXUrZ2OxDuOnJ6J18rBFrDVk3bxr34+KA9Ok+2uWoLTVE8za
 S+JuTllLc2e1GD+l0JFJBjg705esQ8JZ46om6Cpb18y3oy95eTdqG9qwvSCdysBe92AFsk
 Qwu0AetLutJqAJD2EIaNIfWwbJaVRIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780525866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Qeo7Y2gRYxrMiI/rFV1bSRa4NhH7u6R/B+Va6qNK70=;
 b=XX4q249UJU40JcHNJEFc3x70Q6UedDAbCb4EBYwDJ8F8pJD+BMnS7Feairiw+X+kMfJkNK
 TtJg+rL+dozjO5Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780525866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Qeo7Y2gRYxrMiI/rFV1bSRa4NhH7u6R/B+Va6qNK70=;
 b=xArdlvHBzylEDo7Y0MLANmHXUrZ2OxDuOnJ6J18rBFrDVk3bxr34+KA9Ok+2uWoLTVE8za
 S+JuTllLc2e1GD+l0JFJBjg705esQ8JZ46om6Cpb18y3oy95eTdqG9qwvSCdysBe92AFsk
 Qwu0AetLutJqAJD2EIaNIfWwbJaVRIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780525866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7Qeo7Y2gRYxrMiI/rFV1bSRa4NhH7u6R/B+Va6qNK70=;
 b=XX4q249UJU40JcHNJEFc3x70Q6UedDAbCb4EBYwDJ8F8pJD+BMnS7Feairiw+X+kMfJkNK
 TtJg+rL+dozjO5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA347779A7;
 Wed,  3 Jun 2026 22:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JdjKimrIGpRQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 03 Jun 2026 22:31:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tcg: Silence ubsan error on tcg_splitwx_diff causing overflow
Date: Wed,  3 Jun 2026 19:30:48 -0300
Message-ID: <20260603223048.2574846-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

UBSAN complains:
runtime error: addition of unsigned offset to 0x7bc06e1f5000
overflowed to 0x7bc02e1f5000

Cast the pointer to unsigned integer to perform the arithmetic and
silence the error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tcg/region.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index 5d4be1453b..b405fa2ecb 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -112,7 +112,7 @@ const void *tcg_splitwx_to_rx(void *rw)
     /* Pass NULL pointers unchanged. */
     if (rw) {
         g_assert(in_code_gen_buffer(rw));
-        rw += tcg_splitwx_diff;
+        rw = (void *)((uintptr_t)rw + tcg_splitwx_diff);
     }
     return rw;
 }
@@ -121,7 +121,7 @@ void *tcg_splitwx_to_rw(const void *rx)
 {
     /* Pass NULL pointers unchanged. */
     if (rx) {
-        rx -= tcg_splitwx_diff;
+        rx = (void *)((uintptr_t)rx - tcg_splitwx_diff);
         /* Assert that we end with a pointer in the rw region. */
         g_assert(in_code_gen_buffer(rx));
     }
@@ -200,7 +200,7 @@ static struct tcg_region_tree *tc_ptr_to_region_tree(const void *p)
      * a signal handler over which the caller has no control.
      */
     if (!in_code_gen_buffer(p)) {
-        p -= tcg_splitwx_diff;
+        p = (void *)((uintptr_t)p - tcg_splitwx_diff);
         if (!in_code_gen_buffer(p)) {
             return NULL;
         }
@@ -763,8 +763,9 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
     /* Request large pages for the buffer and the splitwx.  */
     qemu_madvise(region.start_aligned, region.total_size, QEMU_MADV_HUGEPAGE);
     if (tcg_splitwx_diff) {
-        qemu_madvise(region.start_aligned + tcg_splitwx_diff,
-                     region.total_size, QEMU_MADV_HUGEPAGE);
+        uintptr_t buf_rx = (uintptr_t)region.start_aligned + tcg_splitwx_diff;
+
+        qemu_madvise((void *)buf_rx, region.total_size, QEMU_MADV_HUGEPAGE);
     }
 
     /*
-- 
2.53.0


