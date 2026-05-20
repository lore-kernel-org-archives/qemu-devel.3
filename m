Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357CFCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgB-0006mW-My; Wed, 20 May 2026 13:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkg2-00069X-R6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfy-0004JG-W6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so30663735e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297944; x=1779902744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MX+Dcj7tJOGLesyog421ZA8oGf70/8pl06vVpBZTDo=;
 b=i9afm1fn66KHpXhxL2gt+OiVfYBgIFCgFKCfydTRg5n2VndruTj94sH6jZaZTib/xh
 0a9q8YwPaMkP3cRSJdqiITYlWuAtN0grkTEBtS8AlQvUWE73lMs+aYzaD8NwZZQTYkbk
 axASohOvQmxcLoXG02jX7Ij2SpKiGOuwY2oJLYda91GoInlmPcVF2j/65Yq7CbVOaxPx
 lknDBMihNPxvJp0AD7wmByaJqCrS3jyoZ/VaxDmgF/3k455Rb9ae673V79og9N4DbVxR
 Du8g5K6vqd41OvjtHw9anhWdqhz184AJtKQFLnb+8ekKfddyPzDGfWwwVTLZq4p1empJ
 VUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297944; x=1779902744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MX+Dcj7tJOGLesyog421ZA8oGf70/8pl06vVpBZTDo=;
 b=QAiSmVIBI6HiyecrNkgrQI3duTfJc6AItLk3edaCcLByaQ+f02WIxszBw2V6/Vdcd5
 t71wVyZQhS3ObrQLwmPpXm5nqfsjEs6QXTvhkdmvfx00M/dKoK+mRjro/1Bkrp8PCD9c
 WVtO3fdRI08OzMH4KXw55Ro4IceUAFUrDbSeSsBHrS8qzGRW4wK4kxYjBsQVsgyYkFV2
 ykVl5yTGpjOi/VpD1CVh5Pblmf0mJNl4kmu5PC0vFx6YSGbiIuluOLO/tDWIy8pAKv5C
 oLMngXwUFKN29RqjJwno8XTEQNJYfrw+YraOG052yrK8s+WmCSpNJ6y8DzH7dxMzoxcM
 vMEQ==
X-Gm-Message-State: AOJu0YwIL8zUB8q9/2QHmQcsI9ivJSdxX/ajmC7hd3OeNzBS2/bPbxtc
 hxg3F+HrXe33U6dMxyN1txa9eQu3SqLLo57bBvH/O+L5KnkfuqezsDW+3hU//GSXjifyk5rh3h5
 RhbTzrU8=
X-Gm-Gg: Acq92OH7OCT4zDh+Mh7ZQSbiyMORHMkkWJJ6g6BblFXfjc7vIKgqvQQFd2uOQIF7kmO
 q66mrzZRQf2FdWsiidDNAa565EgeyUJaMSQGWatT6fFy81CIvBWu3WPlY8NQd6+RurZ0SSPRNz1
 M4adgO9nPJX+4F4Duj+MsPuF38Z3lvuuIfpYZ/qHw8SgFXmIW+ke9lMST71YOUIfalPnZPseZUH
 TIz0Cqkh9O3JtdL4UV6Puqd9IxziNg3qxIuPJnEeUrC5nY3SPujYaz2rBS3cGApEFz4AHYBdVoi
 t919HE96KeQOxQrRNj5+LRpROWwjJMhuLulpLm3K1Of73T5AxHCDho8zDLdvDT7/Rs0q1CKW+jo
 x3N/79yY+VvKMCpRbxaMh66HoLb7NVI1NNJKkr9zGgbVrTfcB74u8+hIn0C37oSeckHQLs8ufkz
 Vd1gQWPKtSuE3ONlt0WJeq8rvv/Qje8rfckkybMei3ljqmzWl5UbTkgBPJCXFcE/kPPhVu+E+h
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id
 5b1f17b1804b1-48fe60e5537mr301998955e9.1.1779297943989; 
 Wed, 20 May 2026 10:25:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d9ee3bsm5078685e9.14.2026.05.20.10.25.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 20/24] target/mips: add Octeon VMULU instruction
Date: Wed, 20 May 2026 19:23:08 +0200
Message-ID: <20260520172313.23777-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Expand the two-limb accumulator operation inline with TCG so the result
and partial-product state stay visible to the optimizer.

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon multiplier instruction paths.
Include hardware-backed regression coverage for MTP0 P1 zeroing.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  2 +
 target/mips/tcg/octeon_translate.c            | 35 +++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 49 +++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bb0a9f1d99a..36ced0bb333 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -55,6 +55,8 @@ MTP0         011100 ..... ..... 00000 00000 001001 @r2
 MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 10c7d18ad4f..a21f96b5c2a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -264,3 +264,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+
+static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
+{
+    TCGv_i64 x[3], y[3], z[3];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    z[0] = y[0] = tcg_temp_new_i64();
+    z[1] = y[1] = tcg_temp_new_i64();
+    z[2] = y[2] = tcg_temp_new_i64();
+    x[0] = tcg_temp_new_i64();
+    x[1] = tcg_temp_new_i64();
+    x[2] = zero;
+
+    /* Z = rs * (mpl1 : mpl0) + rt */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    tcg_gen_mulu2_i64(x[0], x[1], tmp, oct_mpl[0]);
+    tcg_gen_mulu2_i64(y[1], y[2], tmp, oct_mpl[1]);
+    tcg_gen_addN_i64(3, z, y, x);
+
+    /* X == (0 : p1 : p0) */
+    x[0] = oct_p[0];
+    x[1] = oct_p[1];
+
+    /* Y == (p1 : p0 : tmp) */
+    y[0] = tmp;
+    y[1] = oct_p[0];
+    y[2] = oct_p[1];
+
+    /* (p1 : p0 : rd) = Z + (0 : p1 : p0) */
+    tcg_gen_addN_i64(3, y, z, x);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 3c3802ebfee..4647e47f371 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -86,6 +86,53 @@ static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_mtp0_zeroes_p1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000a\n\t" /* mtp1 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (0ULL), [p1] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -95,6 +142,8 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_mtp0_zeroes_p1() == 0);
 
     return 0;
 }
-- 
2.53.0


