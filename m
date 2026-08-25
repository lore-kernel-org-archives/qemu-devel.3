Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC44C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylFr-0006SY-Jp; Tue, 25 Aug 2026 03:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFg-0006Ix-4a; Tue, 25 Aug 2026 03:07:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylFe-0005vb-6h; Tue, 25 Aug 2026 03:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641595; bh=W91hr39DiLCkKXeRWi42shvf0GocZLHI9szdtnc9+OU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=t3GY/NjSwvlSonYT2+/0EJ5WpwbRmDcqDRXDgH8/IeQz9D+Ph3cmuDzQAwmT0Todm
 aopZE85wBqCaHj+G40SV8/nJm+DUM10HsLMoEZBPzLg33O+iKcPsh+Gg2wL78uggdr
 iB4mkPiYvbfY88hfg66b/yBwE52trHYhIv4iLhOPS6WOXhgt8RMGVOm0NV1aFHjeE8
 IMgfrQll2Dk8Dt/3itS56ygmf3x8RPN/IeZMalViZtWaRQ7UQ30hCofoguCB3r/dtI
 jOtvmfBr1Qkj5lec6q5QikZnRYvbpIMJ6CUYTLThYZrrQONFCcjYfXeDosq0ZjDjq5
 AmQQTrmQGK3Bg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E63CE1CE212;
 Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AAD4F415F8D;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6A27332404; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Chichkov <ilya.chichkov.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 45/91] accel/tcg: Allow overlapping reads in
 record_save
Date: Tue, 25 Aug 2026 10:05:17 +0300
Message-ID: <20260825070619.174584-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Ilya Chichkov <ilya.chichkov.dev@gmail.com>

record_save() assumed that a target reads the bytes of an insn as a
strictly ascending sequence of adjacent chunks, and asserted that each
read begins exactly where the previous one ended.

That assumption no longer holds for riscv.  Since f9eaa1542b
("target/riscv: support atomic instruction fetch (Ziccif)"),
decode_opc() loads a full aligned word whenever pc is 4-byte aligned,
even when the insn turns out to be a 2-byte compressed one, so the
record may already hold bytes past the end of the insn being
translated.  When such a compressed insn sits at page offset 0xffc,
pc_next becomes 0xffe, which is within MAX_INSN_LEN of the end of the
page, and riscv_tr_translate_insn() probes the next insn to decide
whether it would cross the page boundary.  That probe reads at offset
2 while the record already covers [0,4), and the assert fires:

  qemu-system-riscv32: accel/tcg/translator.c:395: record_save:
  Assertion `offset == db->record_start + db->record_len' failed.

record_save() is only reached when the insn is fetched from MMIO, so
this is visible on boards that execute code from a region created with
memory_region_init_io(), such as an XIP flash window mapped over a
serial flash controller.

Both sides of the collision are correct: the wide fetch is required for
Ziccif atomicity, and the probe is required for correct fault reporting
at a page boundary, per 00c07344fa ("target/riscv: Make translator stop
before the end of a page").  Unlike a86d3352ab ("target/riscv: do not
use translator_ldl in opcode_at"), where a non-translation caller had
no business using translator_ld*, the probe here is a genuine
translation read whose bytes must be recorded.

Relax the invariant instead.  Keep requiring that a read neither moves
backwards nor leaves a gap, but let a read overlapping the recorded
range extend it only by the bytes past its end.

Cc: qemu-stable@nongnu.org
Fixes: f9eaa1542b ("target/riscv: support atomic instruction fetch (Ziccif)")
Signed-off-by: Ilya Chichkov <ilya.chichkov.dev@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260814142159.3800744-1-ilya.chichkov.dev@gmail.com>
(cherry picked from commit 784b7f28e2761fbd3c753883be949eb3d1ffe228)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cd7d079fe05..57daded60ff 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -387,14 +387,22 @@ static void record_save(DisasContextBase *db, vaddr pc,
      * Either the first or second page may be I/O.  If it is the second,
      * then the first byte we need to record will be at a non-zero offset.
      * In either case, we should not need to record but a single insn.
+     *
+     * A read may re-read bytes that are already recorded: a target may
+     * fetch a whole aligned word to decode an insn (e.g. riscv Ziccif),
+     * then probe the following insn, which lies within that same word.
+     * Such a read extends the record only by the bytes past its end.
      */
     if (db->record_len == 0) {
         db->record_start = offset;
         db->record_len = size;
     } else {
-        assert(offset == db->record_start + db->record_len);
-        assert(db->record_len + size <= sizeof(db->record));
-        db->record_len += size;
+        int end = offset - db->record_start + size;
+
+        assert(offset >= db->record_start);
+        assert(offset <= db->record_start + db->record_len);
+        assert(end <= sizeof(db->record));
+        db->record_len = MAX(db->record_len, end);
     }
 
     memcpy(db->record + (offset - db->record_start), from, size);
-- 
2.47.3


