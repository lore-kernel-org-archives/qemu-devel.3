Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2113CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgC-0006tD-GA; Wed, 20 May 2026 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkg8-0006U0-4W
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkg6-0004Kw-5q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso33751255e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297952; x=1779902752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA7qLJwHyUwdD+HzuVX0t5HZjxEJazI/MyZxt4BIDYc=;
 b=UyWHmfeNp/1q6RGvobL4FNo40eO8rzl7tHGHzDv3dr4OmL3X5wcWt5llDad2KFSf3c
 PshUDYuZjESBUgSgQuOaEnvUMsWI5V7tRot2BcqKv+Zabg5rx/Et6sj0W0ZUNynRIncZ
 QOPT605marryzy3vN49rwZcXbSgCDrSY3gWFOsA/+QKlrW9b+0qF5xzGg3v3U9COkqqd
 mVx85ZkwshhvFKiz4Oyln+mQQ8N9iWI857DvS9CUml0HryxnwSOsuiQ9fVe1gb+i90tA
 NnH+WDCxLNVcPVDOdQehLKhYL0aiDtsN7mJif0zQ7KG93f89qZ6rW49mDlTDjs6r/h+7
 ZHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297952; x=1779902752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iA7qLJwHyUwdD+HzuVX0t5HZjxEJazI/MyZxt4BIDYc=;
 b=qKsz7zNdQIpstwtotDIt7mtLpAZJkxZPLrizDr1eUyopyBqob7kAtJvonH9yI+XAmN
 Kdux4nhvxs5zB4yfRt2coHyhWDo5VUjOjQy0H/Nx/dJLH0PsSHmjJ0+W197+oTeHxxbw
 Uew1zC7VpfGy6CIhsus/g975n5SexE7TujL+2RSmo9t9SCJpxwR5AmjmXo0K6ileDiJa
 3UHYOt0FgTLbVBYDlBb+jVbU+v94ZL2jnhzszHQBL+L8d8MyYOfW9xeU163SEqMVhXjy
 WyomUyil8LAvbpT/x+cOr98bDHvesiw6AHpXTczcY7kucbzmaywRmJbSWjgkMWQVf+ko
 E73A==
X-Gm-Message-State: AOJu0YzJkB9l6n3Eg2TRQxpHgZc9yZZHgICGcJDcto5L5uq/qjc5pd3C
 w8qTGghmPo+5uHxw0ze2J7AO9yMRNL7bvieFc3rd141K5c6sBlwHXWYQy8FsnuzvlJQNuyFQ9v9
 98NUIddM=
X-Gm-Gg: Acq92OFu3cM3HwVSHTNZ5vrDB2AUjkc8LPXinkZisbOENKh6XdSjX0V9UkdcCIFnhzB
 wHYD+Sy+bv7L8e86wQaxi9t/t85voTwz8+yOEc6IjWoFVQLjhC7xG+HLWhhdkLlvipURKYPwytQ
 YjTGQjsl9KPhUdjBfhZ0ZNiza2+v8jSUgHs04tl2TLNvJwnaGzk/3TLCy6JgCBjyiKyMlHkudI1
 /mvsqnK6a86J2wgC9coit9QAM8ViceXCnLG59rJLL8CfcsMN0SlP8hAcL3vrdJR8cNC3ynSDOSJ
 p6GwcLbIqHnL/QEm5Yp17HJiHPoh2mTlQL5w7pHYjBtVTneYO55yVXppyRi+cDhIQVamEMnUwLm
 mPFQ+r8ZuX82VKh40VwXfgB9wIvquAR+pdx9coSiy91OYG2jl1GWJX8f1axhPb9OyBjEiJ5mIHJ
 qe7Myw+Ex2k2pRrYA9Go+uirbRAuQtvF/Si1HukG+uHiAS/2Bfiw3+Z6Xiqyl/0Ilww/o/uufF
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a2 with SMTP id
 5b1f17b1804b1-48fe65148e1mr305030595e9.32.1779297952113; 
 Wed, 20 May 2026 10:25:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ffed68baesm138748665e9.0.2026.05.20.10.25.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 21/24] target/mips: add Octeon VMM0 instruction
Date: Wed, 20 May 2026 19:23:09 +0200
Message-ID: <20260520172313.23777-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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


