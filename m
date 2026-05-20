Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AB2CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeZ-0004hl-So; Wed, 20 May 2026 13:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeY-0004hO-1K
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeW-0003e7-8D
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso2897591f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297854; x=1779902654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7thKSWIjg5/qhPYDC+RiNGQD44Efn4uAyXrn4XVW5U=;
 b=idxffmkEYsADuaiHy4AJTNF0hgNX3+mz1G+/1NY+I7+SHmNmlJLyPyuegR7f+4TTHu
 dbtGYwpLvweKqr/7mutpzm3r1/T0zSEKX4mn7ZJ/9UYMp8uLY6Zh9mgJxYFp1x5KwE1D
 9VFGYcx972gvoJWcyaT8XXaymhWByijnk46zpxF0iuaaE6lP0f5DPloCf3HqPPxJAmNc
 /jH37xJDEdvSxSAzvX8vzL+6nBlCjruyezxPX0GNcLOjDDiSXE9+KWW9Z+M8eGmjAqNm
 iTCSl7I8vJBihmXlJ7r8RjLBn+oIhCgoIoqf58NZU9Ppm7lME2kyJlo0anL+f+psG6tZ
 dWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297854; x=1779902654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7thKSWIjg5/qhPYDC+RiNGQD44Efn4uAyXrn4XVW5U=;
 b=mlLJOklCC5cWOJ+JJk+m7Vt4Gh0+RSEPKoWEgNG8lK6No9/YYQT7h9u33IjpVpenyf
 saaKy/8tu060qXuclVjkDBJbpgGXfhVQXcxp1h+gq+eXGi9KBECuUMc364enNfhHJtxm
 rScGcuQWO0BfGWzDwjqMNfL1/96cRS5KS+QZ65X7yCHspiG5u0vv8sraCls2M/ijiyDn
 NoJp0mfB4NCabpZC+N2beYGwf9plo3T65VsgnDrMheU33awQaiV0lgZE5Nsa9OXsAelY
 HVAIUQW/6cHvTRhvyqclNl82Ew0Eb4IHdVo9sbhp82GhQyoJJT3hbiULB6MwywU2dzqY
 y3gA==
X-Gm-Message-State: AOJu0YzZ/7zBvUdhnCw35PEsXmazc0ROAaX7BgIh4K/jROVQ5rFZYeNa
 SqEMZvzQy+3RWrgKrhbo4aaJQi0oOAKsTrg5nNg80AsU9qUkbxuIYIQHZ+hebRFQad/d+0YXQMC
 ogqX2hgA=
X-Gm-Gg: Acq92OFFGObgVBKtL4vAk95OXsHDOxUUaSfgDX7ZCkG/yz33uKFoXiHuaVY3ZdbqU5/
 0hOlhtJMH8QL43+m1KnqOCFXvnhjupjt4f5F35S4VVHkI9FhW9boivcidvwRf9HEGOl7nEVnK1s
 5ZNi1kaOIrmEb6U44yDoH0WKG9wT4n2qeR/m/3WFBIFjM+vvM3XAutUjElVmjQ4hV7lMo5Hmn3x
 rHcvy6l+FNHE2F25elVFZs5EhI9KUGphLILowq4gKrMObN5+vV4TihwjrNDDr9PhNwG7YgOcjcD
 lRukjUxMo0wtkyL6boTAUVA1t2T6bK3mq3gp2G6SIl3b1gsXgIq1p0sk7qTNaKQKQhco0qO+HTh
 8S5DAXHXCRVwqhaKC9VISbUzCqBqkL3l9oc1FVbWMEu/wZxMTdXIiTyMNSRRVQoObeiUnWZATE7
 43DGtlVTDg9pm/OSMNMz2lOIY7iEH8LrkaXEn+W/YmH8cSoF3gnw/VMaMGpQ5R4/7eDDXTcXOrq
 xi/P+EJhHk=
X-Received: by 2002:a05:600c:3b12:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-48fe61ed2cfmr366192695e9.22.1779297854350; 
 Wed, 20 May 2026 10:24:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d2fa0dsm6569005e9.2.2026.05.20.10.24.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 08/24] target/mips: split Octeon SEQ/SNE decode
Date: Wed, 20 May 2026 19:22:56 +0200
Message-ID: <20260520172313.23777-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


