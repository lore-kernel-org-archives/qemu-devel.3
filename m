Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DEFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYR-00072Q-9n; Mon, 18 May 2026 01:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vL-RF
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXz-0003Vc-HD
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:51 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-484cf882ce5so645346b6e.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082184; x=1779686984; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvSi7n9DmrpdrnGIYb4tS6C3IDcMDrvkLnzD8UjiT5Y=;
 b=qo647C89i2OjKurx9IMxy8YJLcTUq8kMWOibPPgX7F9tk+9W3CL4YfcE1iqYxOcNAq
 i1AmeKRYNdG5zhMiFgxyrqU10TY/zGFSqEFfOXj1a7gAedu8bHKzEK4anrg/bzkOH9uz
 TSOIrHFphCT1dBTKw90WP+JLZL2wQKTGdtk2NbD8vv2y+hmbj2/+vNmxIQZeU1B+FEJh
 DGIZevXlp08Bk2kC0zx3JOYkAYtUrjpOXjMtzNxQ2cBZlkuyNAEstHE2VpmZZGXVXiAN
 a6r3ZY4G+WYdwuqfhiwulGaVzcIHruev0HeHojBkrbJW9FxZqiUr5rYvpuIauHvUam+N
 kqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082184; x=1779686984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UvSi7n9DmrpdrnGIYb4tS6C3IDcMDrvkLnzD8UjiT5Y=;
 b=Ky15vWIUGoXnmxdWnnHdPm0fDJhdlFYSZnSwFx3zdYGgDTJf8H/uGK+y2vZXD8Xjva
 gCnLCEf43ytw4A5OM61TyGHDRwJr+67rgeCLRMiDkae62ymYBFBh0DwmfWgU+xoTRmCZ
 NiLRSOCmiTO3pNtq6v9Ye9Pnk2xlebiPTc8ksNBo/SUz4evvlNtfF9EYqGFvRjqHrH40
 sgUfc7R5LInwgtcYNumtZEdnPyJB/SJKYuZ/hlCnVl9NPVYcZPoSfd1bMUD8e9rl+jTw
 Yz7yljlcRgIhWUAk1dY+IOz68d09iHM5yKFt0ZEDt61Huf0vqW9T6fo1HqkHpXTv08aK
 61+g==
X-Gm-Message-State: AOJu0YwqT/PDXCxUtavgBNo4BiuRNx7JbK1eF05zc1TFTnYWmZpNx7Hc
 w2WoabdYohHuh3lUx9/q+CIThY1qPT640YDPxC78JLpdi3mdS5I2ddMe
X-Gm-Gg: Acq92OHh4dEE1CKy7px+YtTjK/1ic9rHgZQaigWer7vm1SxmM0fAT8/XknruaKaDb9q
 NA8PNXAoBNPvbuJo8VTxRszBb8dnvME0y6AzAbZWcJ9GOe+HMAK+R4e6JYsQCnlKXoZXaOYrEHE
 9pPe/m3zwi7MJGv4ewwgpot1eILJSFHv/FGEQ/Q4Met6vOUyB+et6JGGNiePlb/ybX6cdWOR5mC
 sGgv4yK4ezhw8ix0WKrmAy3wVR43RLJLR5zltJnJNTwdCq8iE1fnRAhgZA9oF8pxqXLTY4L+v3c
 PrZCQgapiGpGh+asaU43OevM7DZ0tJlszO7fIOlNbQ8c415JC+MKQqGumLb4NVgDULPwFjclbPK
 RTa00ADyrPG+mo/t99SiQNeyn0v/OoMauyMv9Sb6PWrKjr8Aw5fU/qQiFhTcHJU1ad6GwiEVJZb
 yywGqxlkFQsPeh0rVJ0jcV3CSbH6L4+V4ts1NWeiDhGLAKj4u6AFL8dNP+7WiDW4Ihv3igkwMd9
 F5LlMSzUt2eeCyjA6xegdbbtYYo8MboHSZttjjyofLkt5VIwJ1zHEfKn/5+KmwhOsOdViY=
X-Received: by 2002:a05:6808:c162:b0:482:86c5:3e9d with SMTP id
 5614622812f47-482e5771df1mr9044385b6e.38.1779082184607; 
 Sun, 17 May 2026 22:29:44 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:44 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:18 -0600
Subject: [PATCH v8 21/35] target/mips: add Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-21-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane from
rs by rt<15:0> and accumulate the Q31 product into the Octeon HI/LO
accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v5 -> v6:
  - New patch.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator.
---
 target/mips/tcg/octeon.decode      |  4 +++
 target/mips/tcg/octeon_translate.c | 60 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4d0ad05834..2d02b4e0bc 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,6 +28,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 &cmpi        rs rt imm
@@ -43,6 +45,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010
 
 &r2          rs rt
 @r2          ...... rs:5 rt:5 ..... ..... ...... &r2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 30d6f14ee1..028430f3ae 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -358,3 +358,63 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_QMAC(DisasContext *ctx, arg_QMAC *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /* Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff */
+    tcg_gen_smin_i64(t0, t0, tcg_constant_i64(INT32_MAX));
+
+    /* HI:LO += t0 */
+    tcg_gen_concat32_i64(t1, cpu_LO[0], cpu_HI[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_sextract_i64(cpu_LO[0], t0, 0, 32);
+    tcg_gen_sextract_i64(cpu_HI[0], t0, 32, 32);
+    return true;
+}
+
+static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /*
+     * Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff.
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_smin_i64(t1, t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, t1);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+
+    /*
+     * LO = sat32(LO + t0)
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_ext32s_i64(t0, cpu_LO[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_smin_i64(cpu_LO[0], t0, tcg_constant_i64(INT32_MAX));
+    tcg_gen_smax_i64(cpu_LO[0], cpu_LO[0], tcg_constant_i64(INT32_MIN));
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, cpu_LO[0]);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+    return true;
+}

-- 
2.54.0


