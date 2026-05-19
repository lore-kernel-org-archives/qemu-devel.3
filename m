Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD110CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDm-0006ks-Rp; Tue, 19 May 2026 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDd-0006fn-1i
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:57 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDb-0000ha-4J
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:56 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-68470763896so1948072eaf.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207774; x=1779812574; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+K7GsPrs74NhySxVr9/jdD/zzn0n+VAvyT3Viig4CUI=;
 b=ESDT/9xahIk+zLcR+IId1/yzlL3W8HKEbt11vQO7HT63Dk9rnw7uwoN0Y8caTrbx68
 y7/NC/itDBH1Ynb3RRFNaNhzWzWaS0xn6w1SEK2QaAmDJ+8ZLJ0x58Rz/iGfI8fWwoT2
 8zLT3rm8rKMIYH5F7U2Y4Umfo4doine+xO2yVRCK0CDJdJ5aemP8DRe0+5jjmme9dqLU
 KFpGtJCABxkvIqw5oGRFprVnMyHNz9JI+hnQgosQMDQvDV3SXUT+bdE6B8OXlzFdy/wm
 P5jbEfyO4hJTIJhPF8e42orhg6t3ImUlY70CL+fJEAdjaYdqt+vr11/8zz7AcN9QlVUG
 xajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207774; x=1779812574;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+K7GsPrs74NhySxVr9/jdD/zzn0n+VAvyT3Viig4CUI=;
 b=hphG0DWvAYpPf/iXwd6obfyJhcfei+bDdXpOBb4DmndmZxpcKQFIt2WWhV0tQQSBDV
 9NQMFs/xIS4jfjxBJnG93X4Sq88CdqyX98EHxPuZWvYBnBH6Nft/FkxRgI+xxLQN6fMj
 2RnADzYBKtDytWzxrscfYKrtFaqTHGVSm37+SwjltwbVZDgtvjj42Ubr5/0LfIdWk8/u
 0Lqzoin6e7/MfphEwUHvKsm9M4AhCUWIFteOVizkhb6P6x2xE7iet2RN5K4WQlO3KUKD
 hPhTf57MFoQ4Xpq87ZJ3Z89Tan/0uP0GSwApjs+SCOLfqJRYWBlZcsCxsiEBFAnVIkfT
 fF3w==
X-Gm-Message-State: AOJu0YwlH2TixS9p+f0bwiC22tg5+kHXbypZvva/1c8lchVeqznzQrtM
 dekOBa2WVrqRQjb6sNSnzIaFw16C9mRLOD/RN32eQYuTzQn/UrWdmdyT
X-Gm-Gg: Acq92OFgcu81StWjqleIhMzLio3X7GKDRs7nMDrVz/FlZgmOfIjBnXzgPysCMgTc3uQ
 0Bg1AW8WVXreb9iinLnVn6zyZVipHbn/gKlKD4hR7HwgycUS6YmHnAYHr99Im+Uvj2ISR/iXw0j
 cHswlgxzVDcfI3SNmg3TI/M72elUag/uMAEW/8NX4Fq3UOzdG1xM7iRH/BMqCmaplnaoCfa4fsb
 ToMdjAMJ9mdJFx4+3Nk30ikMoWItHYw+aE69Z0SLq+/09tc9E7h0AJ8XffKw3trWZlrAHmS5jBp
 JwtLwflTg+9VG5FiWErKon27tWYayIfdlKku5Vhw3uov7fTY0GyG6AIM1dHfYDZDUjrojiNShMc
 kLRRVhCvSKXx9C0c87VwaY/DIlQbsL9zsMbl9YzIGNs3cR1BFnVDHY9bLEWgczyb07Ibh3Io75y
 NMKZqv68qQ9/Vj58DvK6AX3IDrsEDGcy8jGjeRS4zlGT+GGZ46kgXo2niU6mfYpaW+vZYOix958
 SzoozXNbVoET8qfpMFM0oeQ7O3jvEcqFVhmn07jihLDIrxjyzmtnhjvHLAunSvCWqP9
X-Received: by 2002:a05:6820:4deb:b0:69b:6d47:8181 with SMTP id
 006d021491bc7-69c942e20f8mr13849864eaf.18.1779207773721; 
 Tue, 19 May 2026 09:22:53 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:53 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:21 -0600
Subject: [PATCH v9 19/40] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-19-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc30.google.com
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

VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
product, returns the low result, and feeds that result back into MPL[0].
It sets MPL[1] to zero and clears partial products.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v8 -> v9:
  - Reuse octeon_zero_partial_product_state() for partial-product
    clearing.

Changes v2 -> v3:
  - Split VMM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Document the Octeon3 chain update behavior.

Changes v5 -> v6:
  - Zero MPL1 after checking the CN71XX VMM0 definition and add
    MPL1 smoke coverage.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator, which keeps
    only the architecturally defined MPL1 and partial-product clearing.
---
 target/mips/tcg/octeon.decode      |  1 +
 target/mips/tcg/octeon_translate.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 36ced0bb33..f9c32e1dee 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -56,6 +56,7 @@ MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 3216f2b2eb..10fd4e9ab2 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -300,3 +300,19 @@ static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
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

-- 
2.54.0


