Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1F9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfAQ-00089L-AQ; Wed, 20 May 2026 07:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfA1-0007vk-Kp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf9z-0005Nt-R9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:32:25 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so786350366b.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276742; x=1779881542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=COrb5QL09Pm4BfpHqIgffL2R0OlEoncANH+QUqMP6yQ=;
 b=PVLIe1koqPp78TLIQNjoFlgcypWmJ0AOawbpq6PSHF6uEtfXk+Rw9zLPB7PkZzIUxv
 E/I1ShOmV3z/iscgBJFZ9xvnfl3SzRpQDVaOGSkmbSabI6Tp4uz6/pX825eS3v4O7nv3
 Ps/Dn5L5n7MIAzAELXDZy1jXfY8n3BG1JQCC0M8w/7VuonMyHl2rLIO0+wNGynMYnSkL
 jn+T22O9FxwrRrlh1k+FLzVJ1PVMM4fcCU4CsgpEifJZTXtniVjYu5vL/8sELgD/1Wb9
 /+WOoBWsd6vHMLSdfrfxMcFNSCejt/l2RsRcRQfU7MRRRg6PUsx9PUUIzjDkYE8W+403
 J5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276742; x=1779881542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=COrb5QL09Pm4BfpHqIgffL2R0OlEoncANH+QUqMP6yQ=;
 b=Migqy/IXglB/b87ThsJdiiljPP+/WHtgj33stQxR/TmOVyWVaM2CwVAONmSFhxLFqA
 kE1wDq9VdeT9P+WuPgVIcrhksKgefApKxNChw2bCT7N+IXI6vouimhzYVwjNfmObCu5d
 W34ETEio7MsuAlvSUmLYkIPLONqJMdDe+6NiLnCKiEDaWaPzYfS4BBE1nqHCRxsMJHzb
 wTIP7kbsIYa3PhEhyASEaNPXsDVs7D8AnXzJ4XX+fPm67P5pJDjPYH38ZpLZPaZVjyOH
 7LqRmEfJg6r7c85Q+v7G4bkBtJ9aELCvEmKu7EMPXB2wWjbJD5I8trI5UB9HY0bCD0Fh
 sHNQ==
X-Gm-Message-State: AOJu0Yz1rCyzkegXIaY65wCCL8ysxnGhx67CjGE2XWW1Vvt5h6AHV7w4
 p8iI7iMEFBiYTP39I9yGqTj9C/hESoo+DLGYrI2QpJFBqQ5RE79Mvq84GvTVGHsJsHRPwC5XL7h
 4nmAXtpg=
X-Gm-Gg: Acq92OHoNPcDyuUkPfHbYVn08PyPb5uM66qfPvD3xy3TxebTgb3fOYQmBDhhMsMsD5K
 XqKZcSFQTojOzUhOzRDoQeqiP6DEvnahhZ3tpLdRBs0bq3JfLDB4LunCrp6vTjiBGuxUClZRGci
 82rl9B8XDjxnByNxmnMCBcSC0V6Jpix+MZBEWuXgtZ6vDKovz4tP/BUqFDwHK+uuMS+7nCfecvs
 KkhB9l41euK5h/VUD2EYR3xKDA6S72vqTNr4ytwPwu7OFt15W8ZGpEROpRsbO0HQq1F/m+ic5xg
 yJVroD7alprtTQVazGbP0bO0YlQZSsjpxut9Hg0f4X0CXWKZZ3o3BdaZOx92L19ouVDjmwPYXTa
 koD1JtN0muMvz571Oo/KbxqUyMC9kw0Dp3tsSewoT7nt9Qp9BYYKc6w45KddjJ71AuJSzg1304A
 Re+AmWvVE4bk4rpYUI0yoeusig+kvXmopImVCrl+/MgZLn5HRzQQe8iXN3QecQr5NG0aCMs2KAI
 bs1XtEXe6espAZl
X-Received: by 2002:a05:6000:2dc2:b0:45d:4c20:7285 with SMTP id
 ffacd0b85a97d-45e5c5bbe46mr39557915f8f.6.1779272350113; 
 Wed, 20 May 2026 03:19:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19b1dsm52210237f8f.17.2026.05.20.03.19.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 08/24] target/mips: split Octeon SEQ/SNE decode
Date: Wed, 20 May 2026 12:17:49 +0200
Message-ID: <20260520101807.9971-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: James Hilliard <james.hilliard1@gmail.com>

Decode the equality and inequality forms as explicit SEQ/SNE
instructions rather than using shared generated SEQNE entries.

The explicit decoder names match the architectural mnemonics, which
makes the translator entry points and trace/debug output easier to
correlate with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
[PMD: Split SEQNE (this patch) vs SEQNEI]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  3 +-
 target/mips/tcg/octeon_translate.c            | 25 +++++++------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 36 +++++++++++++++++++
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860df..2c54901f77e 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -38,7 +38,8 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
+SEQ          011100 ..... ..... ..... 00000 101010 @r3
+SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
 
 &lx          base index rd
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b7531653e58..dfbb55e3fc3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -106,29 +106,32 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool do_seq_sne(DisasContext *ctx, const arg_decode_ext_octeon1 *a,
+                       TCGCond cond)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    if (a->ne) {
-        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
-    } else {
-        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
-    }
+    tcg_gen_setcond_i64(cond, t0, t1, t0);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
+static bool trans_SEQ(DisasContext *ctx, arg_SEQ *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
 {
     TCGv_i64 t0;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index f406726fc11..3c3802ebfee 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -54,11 +54,47 @@ static uint64_t octeon_dpop(uint64_t rs)
     return rd;
 }
 
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
     assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
     assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
 
     return 0;
 }
-- 
2.53.0


