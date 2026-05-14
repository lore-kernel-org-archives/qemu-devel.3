Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7FCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2C-0002NJ-4F; Thu, 14 May 2026 13:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa12-0000ro-CR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-0003pr-Rw
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:31 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-439712b3416so1624006fac.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780277; x=1779385077; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=qJhjdVQ0LT9Yx1/QGZljnyVAifU7qLaqvUdLtEnKj8fM9g6KGWl5a17fav3gaZOPY8
 Akw5qiZORIhbOZCPw+JjDbdBvklbU1YcBfvSa51YqLlScCmB8TmSG492A5UMO0VF9Mpg
 WyK3F17S8XQ2Mv+XcpBsTrXM4DModq+eEUemjMjvuSW8y3GJvOILnlq4BMdbd7fI4kk+
 4zbR2jizdPUsFVJ1Z1dsjT8e/JGccW6EZtpOT14qoGh7mKnl2qZnk1esggge6IsRuecs
 IIkxVS0N046xgM30vc6dDTuv5uURJi/vf51QBzmhzBxCk2SBpWyX51cG3QiAzDI5u7o4
 STVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780277; x=1779385077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a0YJCz/+Op9OtTioAKAD1sf9gr9b0ChAoB2bIjmnyqQ=;
 b=LCUtNVYqBFK3AciKaqT+lRG7DbVaeK4s5WHg7AxbHDz1n8JgVLKKFpQHazeHdoU1Fv
 DPxbl8M2PlcsMvYLo1PbXqH22a2d4Lm0EOSoMxmsqSOxDC3cOMQbvV3hMXj6JpsVPPhV
 B5BkIMEDvRBEZ/Ug3TJFcdyD4PkPRpyuvvtqP7TxxjRGtkyazjG9BDFkI59DBbzEicc+
 VSBaprNBMj2IR9Ds1xYeuNP/ZlG+rdd9DRfncRFKsMzoeiejdjeLm09MDSmJXja6TLnt
 1/LDNNnI6xmPu5yHZbhs/suP4hHtBk/w6hxTXXl9USTQdORkzWGDNXsdP97G514+m/es
 Nauw==
X-Gm-Message-State: AOJu0YwRosjKkt8D+gUDyJui5E5bEeKeiUfbxw1/01/Z2EMTuKFfRoXk
 UjqfZbkjD6v0suXJtpzb3iERTj6VPlZhTWDo5EHY2IlOasKscgF+pngT
X-Gm-Gg: Acq92OFNt+rWUixaVBgNQwBTkZLeXKtv9tza7buB6MiLSuqTzDxIcFmy/bNKuQMf5xO
 +B+QL7F90qzXBsMwIQQKeJKD5ibI6JM6LaDbsKfrXxSrRUywU1YoXZ+HtJ+kx7JDa3bkdAD/zz/
 a1dDw/gmefvbZC0ucZZ40tPGBcr0nd1eVquIT+XZgs1J8bDT6+yysCIAcY6PxCm/Y2Kz+QKt8KQ
 MRdFbpS1Qmm/on1FkZeh2IZTkoPegqCBwtdpXcUOElVyLRY+RTEP3J2bnhFeJTYzN9GcC8HazCj
 NoAxl1jrNO4ONvFG+DijNg3ShZQEc8rjQTjsHPdowyEHUUZr0Qr/+hJmyhSZHlZpkunU7bhu9xQ
 jff7+U4sphAr4Cjbwr40+VjI95xi0pOELzK7T3ml4Sj4RdP9qirNFkH/vWqvCgG+x8M0W02qT2a
 WVTAOHmrO1gOBizNMirJ4eVQs4e00hup3PL+s+k/Y/gXUEhkjVyC7RlPq3d3ehsg4iF/0yJYsOK
 1MO4nxyT6fAI4dzFFh8Q315ahD0uZp+kocbKVSoeyVnqlYyEXbRY8mQj+k4hhN2pmz5BYw422O+
 JAk=
X-Received: by 2002:a4a:ee08:0:b0:695:818c:e552 with SMTP id
 006d021491bc7-69c9c05b9c9mr196203eaf.55.1778780276798; 
 Thu, 14 May 2026 10:37:56 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:37:56 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:36:53 -0600
Subject: [PATCH v7 04/35] target/mips: fix Octeon arithmetic destination
 handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-4-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the BADDU/DMUL destination handling fix out of the Octeon
    arithmetic instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the rd == $zero fast paths and let gen_store_gpr() discard
    writes to $zero.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon_translate.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444a..4dd7626835 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 

-- 
2.54.0


