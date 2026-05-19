Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6637DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDk-0006k4-TV; Tue, 19 May 2026 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDf-0006gq-GP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:59 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDd-0000iY-Oq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:59 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7df05fc49e5so3961270a34.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207775; x=1779812575; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HrebxwzUBDd0SY3zdVVezouUr7mNIVnHEblwsK+x06o=;
 b=FZc22upW8O58x0S4YFzQt5OG21TRuRdC8ItunaBnjj3WeypWULX+rzx7Un53kR8V93
 Sb/03M0Nc9iilmLwkcppk4BYfs+pWoU7gpA2mwW7S7ptIYzXvjjiKZ7ZziGD40yrBKdo
 NbG9izlgdnz38cMlG6QhVOIqc32KKKbl41CJgLj86z+TjD+jdhI2KKw5fWz+FkXLh8LF
 L3zHHSc6V8TDjma5/P7Fp3XTc+HxcsLLmc39BpFzRV0xxhWAAKkNBs2RENCXL8juovJc
 6UrclvYSBSQeVTcTcjrhftzeplhUYq4brpIGSUIizIb7w7SWVegVWd167EEFN68LhJQV
 Y4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207775; x=1779812575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HrebxwzUBDd0SY3zdVVezouUr7mNIVnHEblwsK+x06o=;
 b=Jt4UznAxKm85s13U5mPTlo/bdsrMMmy6clCZjjKJGUVFv+svmUSLU81SzLMekwAAfT
 bydH6sDfOcubBa1VeknacgcyNX7nck7+yPvH/g5AxuUMhbP5UAhtu5HPSd7SminY1LRN
 q9Oph4j0/xEpX2oxMLjUVSJCtDx6mbtz9rR228YjcFYsNByOSU7kRF/R9uinGEj/Q7XI
 ilnw7O27Q2/CO5rOHK9YAQA76XDLR7Cm7BDGGaPoFLGwnQaJUtGh07xjZHWv8HNEwICu
 deP5QdZ7dnCfi/Cr5PAfM5jbVzMrl/liwxY984SdYt5tor/gj5BYHPl/I/4mSwpSoBBU
 Ja0w==
X-Gm-Message-State: AOJu0YwFXgtjjtW99YJGZvh7v76cc3vs/ieaxlDz/PpdaxeLQYUZAMT9
 yBoaj633U0QOkssCNz+6/LrbUtrYNjS/T9yt3b7s9dGzi3QwWGgcENz8
X-Gm-Gg: Acq92OH4eFcg8/MDV5u8MHMbHcbXyKKYfZCd5Vj7ey2laxwZw8+BFIUxOpgKRkGyj+V
 CVqz9GX2bsp0ktfxm2lLTo+OgaVHkTem+WQgEkUE5N7/ACl/UiCTEFTz9BZwVxUqnVsoTT6V1k6
 NY9qHxiZM6aj/q5rBYl90rvs9T0YIl57ZBRd5XSpZGwBXUslkVF3BF+ZFKQM+zhUoNqWpobkEyD
 EcLwa8zIw/Sz85IDfc3r2611aX5HFJJZybGOI97yN/muK51L+L/yUaGvlrs8USUTC7zBPmJhYLY
 zqQZhMaVU9J6yPCQFp94ZPMj5z2xfEzeyvVr75KLth/FQZbddLkWDL8bea2mN/NQUoPb9o4byW6
 wAsfp4Duj+e4aPIIawKZw1Jhoq5RUdIVvkh/2glXI9WYgL2/da71cLvFE3awAbKRv7U+5vXGYIa
 7AE01tBGr7EQOYXCxlG3ufnZ/+z1Ggz/K/GZ+D4GTOfAgXuTYGiNu5TI9luojMnXI8yAOh+fJpo
 l8Ofz2uh02NR5qK8B0aTdFmsANAqmozZQeU3KHnS6xCnw5uIk3MzRG1Hf65UZOuDxxh
X-Received: by 2002:a05:6820:f005:b0:694:9c71:2772 with SMTP id
 006d021491bc7-69c942d9802mr14114527eaf.16.1779207775554; 
 Tue, 19 May 2026 09:22:55 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:23 -0600
Subject: [PATCH v9 21/40] target/mips: add Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-21-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
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
index d57724e903..d484b4ccdb 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -356,3 +356,63 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
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


