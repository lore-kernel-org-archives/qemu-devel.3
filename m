Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BA6CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYP-00071c-HN; Mon, 18 May 2026 01:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY2-0006tv-9i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:50 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXx-0003TX-Eb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:48 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c35be031dso1372025b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082173; x=1779686973; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=kYlQ7RVIIlR0ShTjN6LxnXDwmmktIgkqOH8u/fXWrDGZmQvbJIRqIEJDyFBCubUzDJ
 acYpHExmcFr/abU0JuQhY1dcNhhzvpPzQw0KURdFP9qkKcbvU/DxdSJuWMJxhWUjb+Er
 gEPvGn+0glF1mdpbtKNczSZOdWr7GIbMd7J9oeV8WQjKkYZb2WUED2qkayiCJVJqm9Op
 4Z5EgYGnG1YIHFHgM80r7NX2yK27sTdO8IzZGPRWTJnVQp6dFkmM7t1KZVshuMRv8DZ5
 K27RX0ftZUO48wzHHqw2gWqBiqRZUV4FLnMgTjhOpmz7/nebWHOyvsMmsx1fSTu2Xmj7
 VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082173; x=1779686973;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=ffyCHk1Zb9wbGmtFtwdMhFkiuc2YRTpLKD6CA/CHIu8XQKK5jjHywb4w2R66+dGG9k
 ZBkMfF0/8QiRkGBAdfV1S8iPDS6kBc8bO3cbXQwArOOgx1Fbn/FlraOAo/UV+5MlcSTq
 zHpmNLwvD4QugI/Lc4gvxiWTFsnMw7ogELnOUx0sl66wpGtNeJB/ZvNgTCfhbXSWaRKo
 hsxkgnYUfR5vsUGdrA1M05NBApFzvRhWVfQZmn+LnbEKgg+Zolq5Ivj3Vdm67HsXLDba
 Hwa6R/ZatOteIKKKrtSf54GVmyLno3/juIuKdjO2VG76X31nvgjXyqkkyy4Uic//hFg9
 A3og==
X-Gm-Message-State: AOJu0Yyw3apFlNQ8/OaEK8sXUrE2bSDfW6jKsQDhRM9KK853bEFArpI8
 ZKX33McqPzhYixBbiDC89+903FSNgqjd7dLLU0jWseTrc2U6maQ5sBzT
X-Gm-Gg: Acq92OHoveKBPnyJlLfG8LJSf1AO4AkVYESgQAQ0Pe7Riie7ZzyK0/6A0Ffc08bWf2b
 OlEfdzifSp3Rm9gO+AqhVo81GMlTfYasgVgJdWtyL2jzdCSp15rJi253mrYp/w4ZAiCfi3Yye4w
 yufBqivsC70iJ7uppoZDiUGYu+C5Sv6rzhyXS6IFY+oiojku2y9BadeOuvFnS5+YeBbppaWbSGe
 Zxyj6RXpyLGvfjjYzx18vBF1L9nQzTJ0Ona5L+Maz+RhLImVvsTg1kBBnVhOqOfgzQ5sHXqHnRG
 kkehFQwEOXmDuZs/Wa1yrlDglayG8NjvbenqEIyFh/erryLsAQM/9Cg+bvxIQrZw/4DfVq0EmaD
 ijwB/V+cRZlqsUmhHAXI+Iu3CQG3x7B1R7jh6m4qgs9h2rBj1mBFgHzKBbIRxOWbXatgiruf1Q/
 TNkKz+acxuILUhYeET+v4lDEMuQy9zfWF7RhzRu4bRf1XOQlqYlXg76AzbF8Gdf5DDyFTOlh/IO
 SVW5TUZRNSen0sA5IeelDRPvDFIxpL5Wvsrt0Ha0DH++vGopxDqsBC3kQUa2xD/eYIVTRRTZv+I
 PbVJNg==
X-Received: by 2002:a05:6808:c3ec:b0:479:f370:fac0 with SMTP id
 5614622812f47-482e5611657mr9044871b6e.18.1779082173130; 
 Sun, 17 May 2026 22:29:33 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:32 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:08 -0600
Subject: [PATCH v8 11/35] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-11-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Use MO_64 for the doubleword atomic transaction; the signedness bits are
    irrelevant for a discarded fetch-add result.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.

Changes v4 -> v5:
  - Drop the Octeon+ gated wording/path and keep SAAD under the existing
    Octeon feature bucket.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f00692830a..d3dfef2e0c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


