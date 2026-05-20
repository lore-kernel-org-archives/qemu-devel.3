Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8041FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZc-0006WZ-5P; Wed, 20 May 2026 15:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZY-0006N7-2y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZV-0002nO-PH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so38825245e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305231; x=1779910031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KqgGR6pc8UMFMnbMlZ+iVengJ0bhoyZNsG4J/Qy/r6A=;
 b=r/UbkQDVMA9i0NpotXmpQcd/pcl6FDxeHxyoL5Nw7Y0ksCaDhFpfkSUzIEJubJYIsW
 7hiYJlJemJG9SBCIjXF0mD1ojAWNGNEZwnJ5PRUyDAL+hAPjWlyT/UZyZbVrJJnaEqOv
 gbUivrmucQFS77MCEU60ZvJa/SHKwrbw3CDr0HThaQsVLxKNdEZQfI7Ble76BdNyObUN
 6772dq57cm6gyRxRBq0Ksg5JMr3zWCkTwRVEoLH4dXDJrO8PQZ4ZTY/bNefW6757r0JR
 9F5ZQJ+vgO/wgLW9AJi1oRmOaSXKf88CcSY4N+KtTFEbgsWBTVIwRR1W6Fo5zpEEWUTW
 GU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305231; x=1779910031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KqgGR6pc8UMFMnbMlZ+iVengJ0bhoyZNsG4J/Qy/r6A=;
 b=iEDenw7v99m2jvSWmFcwowNkModNYFuY3wxBzSmeOwYntqtFnyQrRI9X+/UUpxwl6s
 TUv1LwW/lIYW5ourri98ikjHJMwtPUsOpW5YZruFDZJ6zd/0wjKZij/655sJ5Sj9gAYe
 7niw6V7ut88MytBa4qHdb259y8/P5tKP67f0/ZULoJyVZj+jmHTgTBQ7Iq27a43PY8b0
 ZsDMEtwlRfqcHmdMl02UFc/mQLTG7RDl4u8Iwf1XwHReTTvnV/8Bs1sQgbqmmiVU192X
 c79I9Uowt2xakzY/E+PpqxIVsb+N3uV+b/rO1slm4jDpoUzYtc0bi9JvYfk+5viPIhrU
 RTvg==
X-Gm-Message-State: AOJu0Yx6CfLnjanUBTeDP2YKp7S/sARE8p/EM4lwmf3GZvedU5/hatsN
 AAdWPHBIJ3zw04Z3Y/j7hvtTM+/JQT5bO7KVRAKwTww1jKfBgxwLkk3AVY+qRtrH4aDSGk5WV87
 DM64SdSI=
X-Gm-Gg: Acq92OFq5Gg2jRxjilGoIaJkME6BWS8B/LJrx4Ojam8eQCBEHO/bGVYGImk+hqhIoKd
 DT7TALzWdxQNnJoLnUhP8WN2L/jsEk76IsXJy0POFyJY+Y7k4nDRoVWSJh5+t+oTCr+S6Ot7ZQA
 cUEnqY3U9UMjwTlkFgkvUIcEGkqC5ipFDMHxQT74Xft0LDwE97Of2w0ZQpbfkIgFlrnw7tGdljJ
 duy+7wu8PBNS1XYVTwFu2r2hcvhQsT4xgyzIw+Uou7dyRgDFHlsR7Xfh5XYqtaxPvGzqgxUs0cv
 VVWfa8DjyP4zxWb8VHK/pABFMkk/uSF7hf9iRlp/B7nG4OEco40h9ifUf1fgz9YjwSHj7OHdf1s
 m0LH6Z02EJNM/vlcGoH66I0hhToWPjX2pNk1qU2VghPwikhOtg0hBxVyfufY8+g3Swc3Uj9633a
 8v2dW6eaiixUV94T6+mzmDLpEN2Tvm1IcEOls/G0b+5kHDvRl6dgvUvLkbCGaOV4rAyShLLLB1f
 CxEXDx/f8Y=
X-Received: by 2002:a05:600c:4752:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-49033d8fee1mr9649095e9.15.1779305231597; 
 Wed, 20 May 2026 12:27:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3514esm13580565e9.3.2026.05.20.12.27.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:27:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/33] target/mips: add Octeon VMM0 instruction
Date: Wed, 20 May 2026 21:23:35 +0200
Message-ID: <20260520192338.40036-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
product, returns the low result, and feeds that result back into MPL[0].
It sets MPL[1] to zero and clears partial products.

Include hardware-backed regression coverage for VMM0 MPL1 zeroing.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-22-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  1 +
 target/mips/tcg/octeon_translate.c            | 16 ++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 55 +++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 36ced0bb333..f9c32e1dee1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -56,6 +56,7 @@ MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index a21f96b5c2a..94f3cf9edd8 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -299,3 +299,19 @@ static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_load_gpr(tmp, a->rs);
+    tcg_gen_mul_i64(oct_mpl[0], oct_mpl[0], tmp);
+    gen_load_gpr(tmp, a->rt);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], tmp);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], oct_p[0]);
+    gen_store_gpr(oct_mpl[0], a->rd);
+
+    tcg_gen_movi_i64(oct_mpl[1], 0);
+    octeon_zero_partial_product_state();
+    return true;
+}
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 4647e47f371..9153e37e9e0 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -105,6 +105,59 @@ static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0_zeroes_mpl1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[mpl1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000c\n\t" /* mtm1 $8, $9 */
+        "move $8, %[vmm0_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move $8, %[vmulu_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (1ULL), [mpl1] "r" (1ULL),
+          [vmm0_rs] "r" (2ULL), [vmulu_rs] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 static uint64_t octeon_mtp0_zeroes_p1(void)
 {
     uint64_t rd;
@@ -143,6 +196,8 @@ int main(void)
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
     assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+    assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
 
     return 0;
-- 
2.53.0


