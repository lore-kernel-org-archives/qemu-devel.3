Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D3DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDm-0006kH-6G; Tue, 19 May 2026 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDb-0006fa-OZ
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:56 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDa-0000hM-3F
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:55 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4042fe53946so1434826fac.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207773; x=1779812573; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mgKAzKnR77d/l6h+4Aftoi97MN3PXeprHi74gTNB9oY=;
 b=bguN7kp3K6AS03vCNCeuLjO31jLSSpDBPiQdRC86PGrQUhxIu17BuGpFlGr8gCmgXg
 RMBT5Kakp3N4/eto4y2JPCY8L+invxZF8KLJUMiw3h2nF/LWXarDdLQncAlZmkYb+eBD
 kKxLDq4EimcgPlgEh6tzjCR2MCajFBFoaNSTPy7MKjpa+4rrqvCgL8qdAucoqrhMsObV
 S9SGyEDbC2DuL8t6UxgVGkCRdVRW2+5fNBQRurbssmz8nKgVHhkR4QuUUXTJV0juG8AR
 rd5u/1QB0+Z2I8YkqdbXQbFv/Yu49PZam98FUhLuJMYTn7Ssh0voM7DZonkN9dwB+5BZ
 GKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207773; x=1779812573;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mgKAzKnR77d/l6h+4Aftoi97MN3PXeprHi74gTNB9oY=;
 b=hf41ZuKasUaqBi1G5uuZTRBQd0tc3yWVCaaHUMW4sS/4kn76pDCBw5qUI619qkG4q5
 PIBG/Pdfms1z5fF7ww5BHTyzYGjuyjZ8K24YHWkrchzKzDhRxpU/82pdrRMb0RzPN9jT
 0jvxb/GTmF0SotKC1jtddgDvPsLkxZd2p8/tmj3KweFyyc2b53VSp1evAxxp4mA6pqlj
 AjPXP0t4oG2UBC+IWkovdiBiXujrB7d/mQ+wPwyhkZPVxKjVAeAkInObxLHTnxJtZvgN
 P3CY/0tosa1VJqPSdvfqACTprfPSOs8/2jKtsbaRGmvdMe32WTdVfgViAqXoj+LIVpuK
 btIw==
X-Gm-Message-State: AOJu0YzoXwwt0V1MXl186GZVVpRe8bkT4C+t+y18IFa/yBphR0pZE7nn
 gGxjbzgr600QlrRWCm/AMYcsAhRRu1HQqbfv8SZMOEiJcbGqUmDSVURz
X-Gm-Gg: Acq92OEVCACSXPc/Tn3dbSO6KVW0b23nKGWyoM3oNYLblNInWCY1H4JicAWWO7HXPBD
 Df3toaD3TUZd2mcTI5yHIIPEPQLExqAJVJnCLfJYmnmxKCk3t9s6GdyG1F19e0pMg8rpUaV5Xg8
 i04nHu0wvtGHJaOqG87Tx6WnZEXRGsr6S1x19bUznT8YTGIMx3OssCNU4KoZTyU7jpB1SSu5Wg3
 l4vNIuVQIVMrUO7jrEtWKxY2WzClaFSf54PACar+ozSqCSLmTk6U3VnGYE2O54CQlkTUwKd+fmJ
 T9xKErzF9gRFe2IMsbe6t8jeBvMt0yvxVqh3GMVsqjBUtpGw7LLZniHX7xLUnpvsD1OWTcQ7thl
 PDsArOTZufjfLT13HZi/GdIvWj68j4FQdJYZeQeDGq2703E680A/PN1ywTMy0QQg7cf/cl+Zk52
 1nkWGN3t//2ZqLDIXc09GHG09absLJpr8OZ6Enc6ewimRlUZtCX9ZTKbfKC20geZTQHNhn9pLPP
 STGbzQjPv+/wzp6R50uefgqqeyX3jKFpxHqhuYFH2Fp2WEoGVtU5EddKxTYAIPb6R3l
X-Received: by 2002:a05:6870:1683:b0:42c:2c15:375f with SMTP id
 586e51a60fabf-43a2d90adaemr12421250fac.2.1779207772888; 
 Tue, 19 May 2026 09:22:52 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:20 -0600
Subject: [PATCH v9 18/40] target/mips: add Octeon VMULU instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-18-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x35.google.com
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Expand the two-limb accumulator operation inline with TCG so the result
and partial-product state stay visible to the optimizer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split VMULU out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v5 -> v6:
  - Rename the translator helper callback typedef for clarity.

Changes v7 -> v8:
  - Use Richard Henderson's v7.5 inline TCG translator with
    tcg_gen_addN_i64.
---
 target/mips/tcg/octeon.decode      |  2 ++
 target/mips/tcg/octeon_translate.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bb0a9f1d99..36ced0bb33 100644
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
index f778ca22f0..3216f2b2eb 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -265,3 +265,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
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

-- 
2.54.0


