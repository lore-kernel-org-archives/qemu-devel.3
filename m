Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA11CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHc-0004l2-Mt; Mon, 11 May 2026 14:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHU-0004iu-W4
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:05 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHS-0002iw-RR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:04 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbec19732eso4288673a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523782; x=1779128582; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HVPSObz67Q1en6kF68iPYdaoC41Rm329SBVIhXooLco=;
 b=cKy3QeZVRd2KPkfcTyXgJy/wM7ypI3npHUkTvBuISkEOvf/ZKnb5sJ+k0z+Aa7mNbG
 vGJif+EOwd4hTYNVe9n2hpQJfGbQUHr+R+mraq0hK5KbnWV1VPh/tkSM/4rrldLHjsZ+
 K5B3TDdIOvXJo5N003pVAtHxNCnUQprbCBdNWEI1NJpd3dliRYVef/+nymXwB5SfLyKe
 X9d/p07zWJjlLQcocveU05idZBCemcQI/3Lu/qW7fpHSf3RHIQ9byAUasovzL3YTaB0Q
 MgoPTXBEt41//d5juvTn+et+aD0XfcCazCM2Iu+4UASUx3v0wX+havzViSMENGzLlFZT
 ghOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523782; x=1779128582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HVPSObz67Q1en6kF68iPYdaoC41Rm329SBVIhXooLco=;
 b=PuZHEpsXfO/xarBbG4zckRwG3/936iYaZ9f6JgTiXFfHdoUk35bLyqIpDyWuAtP+xI
 TMIilXwa0r/VY2QH3h15lXnCf0Iv7gdbrV2oURniduzxoWxDmfbV/t3//B2dMs+JhakF
 KXl87kR6KI5dg7emF2TA6O1JJesCi70ACZBwggnyFdafYl24/12wKYaQk3MOxSX2DqjU
 tFD/519ajkA0fGZKrmVjwgrEiVbO8YCzCT0dQOIXZMQV3GqmJeiSZ7C/uf8b+snuFTZU
 6h2phpJCFzbhEEuutllmQgfTZpvvEZTJ1xHfbAxk3e9TG7NJ8tDtK2tLsuhOARgXxCsN
 3JjQ==
X-Gm-Message-State: AOJu0Yw+ijxxmBlUIpzwN8WHFvFj0sM4bNOnE/3qyjnUAHfllqFGALWq
 z3xFZ4EB79NvbdxKyd1xbwnwQr6wjGXQuATKHeWuT3uRshCz6PlDW++y
X-Gm-Gg: Acq92OEy4KOY+mIn/yWMN+35BVVRG3NQPdhFJOPNnIiGDR4oSflqvNa7lDcWseYzwjp
 8+WLj9QoJTpxse6SMZajET1ykWxKNn6PYE3/7Ff3Lm2K9FCLBO0Kb8qJ0Z3aXYFIpO0FtASPis+
 kwf8Tj+lfBp+QndM7LPr4xbVoVCZdJvxKpv3wQfU+sQz7SSNaTsNtTk/LKvZIxTsUiYF8oU+b1e
 UtKwfNqoQ8XEJXREaZEWC2/VGrhxjO6ikz59nbaY+Coaj4HcEHID9aOILEgUWi096BedVo3taQm
 gKPbiOkVn95bjBgb9+iKgbLcU5GKZ9VrVl7XJXklkueL/1Jz58EVurnrGkIZYqcQpxRKH0vW5/4
 QEfv4wZ6HhEnk2fQn8xuBOUeSdcpEpLFMV+QKhzA5PuP8nc1BQ0AtXEcMhYKMOV1vubkms3vO4X
 6kn2UvCxXAB37YTxxH8cvURBccPJ0tE8Gr/lXbG5jXHMtlUv/e/FkPNRwuqRZf70ATAUA5t+Jrh
 /n5YnZJJBjy0AgMjlHZh3QSkUfOygwZNyRGriOjZ6nz6N0D1R6FX0B5rBjLEggjrj/u
X-Received: by 2002:a05:6830:82eb:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-7e1def1f614mr15669270a34.11.1778523781721; 
 Mon, 11 May 2026 11:23:01 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:01 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:42 -0600
Subject: [PATCH v6 11/35] target/mips: add Octeon SAA instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-11-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
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

SAA atomically adds rt to the naturally aligned 32-bit word at base and
discards the old memory value.

Implement the common SAA/SAAD translator with TCG atomic_fetch_add_i64.
The MemOp selects the word or doubleword transaction size.  QEMU only has
one Octeon CPU model today, so keep SAA/SAAD under the existing Octeon
instruction feature bucket instead of adding a finer-grained Octeon+
feature bit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAA out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Gate SAA/SAAD behind an Octeon+ feature bit.  (reported by Richard
    Henderson)
  - Use the i64 TCG atomic add path for both word and doubleword sizes.
    (suggested by Richard Henderson)

Changes v4 -> v5:
  - Drop the separate Octeon+ feature bit; QEMU only has one Octeon CPU
    model today.  (comment by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  4 ++++
 target/mips/tcg/octeon_translate.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index db7d5f55f0..d6b241de42 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,10 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&saa         base rt
+@saa         ...... base:5 rt:5 ................ &saa
+SAA          011100 ..... ..... 00000 00000 011000 @saa
+
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 401c4bd14b..441d71d57b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,20 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 value = tcg_temp_new_i64();
+    TCGv_i64 old = tcg_temp_new_i64();
+    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
+
+    gen_base_offset_addr(ctx, addr, a->base, 0);
+    gen_load_gpr(value, a->rt);
+    tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+    return true;
+}
+
+TRANS(SAA,  trans_saa, MO_UL);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


