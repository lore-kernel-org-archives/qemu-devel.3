Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4727CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDn-0006lY-Fz; Tue, 19 May 2026 12:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDe-0006gL-K9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:58 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDc-0000hy-SN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:58 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e4de538f83so2225457a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207775; x=1779812575; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fkzFn/bWS3NMM2yiowce5yNaZJIo3NGIidCKxRI0gLU=;
 b=omWd3LWeIO/PubzrirbX8JtsFy3Z5A8LNaVIBxVNFBgpEd9vDN/ubY5HmRNaXNbtLH
 uhwWyTXpylySulnnC1iDJsMs65lHfF4bnV5L/Y+NXxXN9+wA3S5BtFjJ2de452pwOxE7
 w+A4E0nSEz1Zrn1CZY/mxnQUSs4osaLgzlsDs0zrAsVj6Rc1ZW8JiAhduDO8QNnCLr0L
 +ZGike/RPHTq9aoFf6BJ6bFWkw7/ysSpZRpjxNJDx9Sijs/c1LlTnYG+fX35hv35CcV1
 xBqzwfo7XOu05TzAOI9QsSlxAzgYPtH1Cr4nB5+6QMGr5TdR7RrjwjXggC2N2zwK56xo
 cZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207775; x=1779812575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fkzFn/bWS3NMM2yiowce5yNaZJIo3NGIidCKxRI0gLU=;
 b=sW0MJrunq6KL+jwKh5Ft0GeszcF6eY1nZg+8518fKN250+dgmzUeoAhhrCXCNNmJA5
 QA7WIQpI8M2alPExieks1cFf7LFvyU7WhH48wqUHDpBi5MW7m7fLXNFkklkJFmM+Q7eR
 Q1/T6wWtSfZg+Yu9kXGi6moo85WCpVyWxM2Xu5PTHj0aVbgarPoWio5DYojewTnpakVG
 hDfUDA19fATcvCn9T4WsFXxMdodqTjtflLNBu1hjbrqhKeh2DcIgd1ZqvkXwrNYb7w+Z
 S1lNR67fYv4Blegu/2ph6L1dktR3Txf1+UhokktYa4BH3vBex+gzO7TXXn0Sp3V3eL4Y
 dSqQ==
X-Gm-Message-State: AOJu0Yzm0xwORvs3G4Eu8joP9DQ26WtVEIVPV/yoc6kvAjzzmC8XDVjM
 uVvKdduFfUM7AzAQPl1Q650bAtRdKjegNoNWzQBG8xE1aMNiF2IFyrAR
X-Gm-Gg: Acq92OGT9I//7TLsKaA0e/nr+sVlnMitJRa6y8Dhle+/j+mP0ZrVuK6vu9UQd1RZ/Ae
 G9N7IplR4C235mcEk6bGAaIaWl3z695vr4HwxKxwzxBPWJ2jzYclIpRRjneHYm3GMLM6kSOq13z
 aluucC9NCu/elP0JeL38Vv/Xt6CG9ERUcm6bBjUfjcJuQl35MQgoJDH7jjaEtApNykf1VtUy+vh
 VTgMPxr62o7eRfdDUzc2P83cnvh1+H/bm1KbTTZ44UGQhjjESlYrSNWFQ9Z4lXWnUzsdpIgZa3J
 +oBCcqbJUWE6l+j1d1jaSObMLVbBvuLQfIxC2SGiAq4YXmxryJiWdRtO7wm6k2uvt1EV1RCSS5X
 HCAvn/idbzNI2rqlRgjcJosOEgX5s9St+JqjQB5uvOuTsVt39r7B7ewnNapYS+6/F/m92f5ouzp
 plwhVxFbSCQF2VoZ2rVyg72I65QiyKINdPVCubIRFucvo8bIo3v40zf40uApuDCBmMls1ta35xQ
 vh1+6S6dgP0PCoJu3t3R8IkBguMz3dC2P4VG+cdrfOsYt2EwuiidVOavTAg2RLSw1Tw
X-Received: by 2002:a05:6820:f01:b0:694:a02f:75aa with SMTP id
 006d021491bc7-69c9c05bcabmr12138000eaf.57.1779207774621; 
 Tue, 19 May 2026 09:22:54 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:54 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:22 -0600
Subject: [PATCH v9 20/40] target/mips: add Octeon V3MULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-20-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x334.google.com
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

V3MULU extends VMULU across the full Octeon3 multiplier state, adding rt
and queued partial products.

Return the low result while shifting the remaining accumulated limbs back
into P[0] through P[5].

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split V3MULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 MPL3-MPL5/P3-P5 high lanes used by the two-source
    MTM/MTP forms and Cavium SDK/runtime code.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator with
    tcg_gen_addN_i64.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index f9c32e1dee..4d0ad05834 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -57,6 +57,7 @@ MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
 VMM0         011100 ..... ..... ..... 00000 010000 @r3
+V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 10fd4e9ab2..d57724e903 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -316,3 +316,43 @@ static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
     octeon_zero_partial_product_state();
     return true;
 }
+
+static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
+{
+    TCGv_i64 x[7], y[7], z[7];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    for (int i = 0; i < 7; ++i) {
+        z[i] = tcg_temp_new_i64();
+        y[i] = tcg_temp_new_i64();
+    }
+    memcpy(&x[0], z, 6 * sizeof(TCGv_i64));
+    x[6] = tcg_constant_i64(0);
+
+    /*
+     * Z = rs * mpl -- 64x384->448 bit multiply
+     * Compute even partial products into X and odd partial products into Y.
+     * Include RT into the odd partial products, which are 0 in bits [63:0].
+     */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    for (int i = 0; i < 6; i += 2) {
+        tcg_gen_mulu2_i64(x[i + 0], x[i + 1], tmp, oct_mpl[i]);
+        tcg_gen_mulu2_i64(y[i + 1], y[i + 2], tmp, oct_mpl[i + 1]);
+    }
+
+    /* Sum even and odd to produce final product, plus rt. */
+    tcg_gen_addN_i64(7, z, x, y);
+
+    /* X == (0 : p5 : p4 : p3 : p2 : p1 : p0) -- x[6] is still 0 */
+    memcpy(&x[0], oct_p, 6 * sizeof(TCGv_i64));
+
+    /* Y == (p5 : p4 : p3 : p2 : p1 : p0 : tmp) */
+    memcpy(&y[1], oct_p, 6 * sizeof(TCGv_i64));
+    y[0] = tmp;
+
+    /* (p* : rd) = (0 : p*) + (rs * mpl + rt) */
+    tcg_gen_addN_i64(7, y, x, z);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}

-- 
2.54.0


