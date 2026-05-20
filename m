Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478FCCD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgj-0001C3-JC; Wed, 20 May 2026 00:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgf-0001AW-SK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:41 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgc-0003ot-JV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:41 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso2244623a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251857; x=1779856657; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tj1tAFePwb3x6WJPDnrPkCU9+i9Y0BikrUfMDmD3ysk=;
 b=iaz7NzC9ZE8JNHEi5xA0GraBeDR1LnboPl+cRDYcwpVWCmWZFEGp4kFVw69dm/6VXf
 CtxiJP4ikGXL8bvmgQIU7Mg24sk62/9ZLVGp4d/y4x/dLZ853RyEBkjmRp4SsEnqAPFi
 7LCZUgtqYMXwEm1a6XXtAAzAZ4NlfOkIS9ZgsVAkpkq+GQw/BBLvMKpyV41Sc2ao9D67
 qAzcf5Rs5UA41tWzSwSpobaDLlibphlqOnbKiQL0zWalN6tFvfZWiC8OcbeL/yVNOm/8
 UGwZzuwmJCpUFH6BeBWrF0WvXQedSdgQ7VFEHiwExy4RbNBgIHzFGSaM6Z0WFlslZOlC
 csKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251857; x=1779856657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tj1tAFePwb3x6WJPDnrPkCU9+i9Y0BikrUfMDmD3ysk=;
 b=L2CSHBNt6sES2IzLry0vi9Zd3pxqgp3lpCjhXAskvF55sEK+MSvKPW04P72Jlk9Zk9
 WLVxgtjWuZHx34GUrroCdWkuvpsrR/jo50vYNRNnsQhJwBuoeqv4mmXrS3tmJrAKWC04
 Aq/FXFzk0/PzGv7qLGGpQ/RpOAp8ganXce8ZrEwKQczYYqmr+il5ucZXL8Osm98Yt0kO
 gtRo+YHo6Dj3SO4pDP1Uv+hGUVIzpPMW0jX8k62fiTFmLS3yZO0KeFi9DqK5PbttBG/k
 pJXeA7SBXXdiIsQd7Fn77UEp1nbkBeZ2PlYcmQemoFj+jKCyXfPehbJf5+OF6hkUsQxg
 OJzw==
X-Gm-Message-State: AOJu0Yw0BpNRIFpn7UH7RNQR4aQVlaMC4IHZCHOLj+8fleqwEj7t2kDv
 CL1CTo/bzaq6ns81ot4Qy18rTwHIzQ9JGxY5/gXsgWWfORm5nEd/wbkQ
X-Gm-Gg: Acq92OHDGbRsAyL3Bc46PrCwiiBbFNhrvzMljdnQXE8f5hkLz+5c7/3GhDantm5snst
 SaSt1IjgOi4FdCMNWqcJENuH3EjwQEzbAfpnv4jZ+R6OWWohvBk6p5JpDvEmFnvTeA8AjE2VNHI
 960JRdJplx5cw66/d1EF2KfHaHl4TiRSZV0sPcTpf39mSBrmN+a2BuygaugOgWTvxUZcjS5vmOD
 tZ+rfPxYnPmDzkjU5iR8nkgfGM8txrosqwiR20Oujen+pbL/oeOuZYK2SIvri1Qm2bYtrgzqK3q
 T13U1Dx2Y242pP0Z+Vvh3aZQ+JsU+B0+TtJ6flpWr2xgrPPbo+2Jveme/nR0aa6J17y7IJYAr4E
 +g5bhB1YDwYaLGA6OBtQZmKtFFsUD1M4uVi8IVJ4tORVfBY9SqC7DaauPw2DG4uIJoGuLhfl/Hv
 Ml4wvGFiK7qPU9wszGIr6vc/sflkfCJqQowF3h0555QERm9am05937X8Ybw1OOUvK/RDM7lSWSa
 F/f0V9xndMGHQlGBB4VXP3jHpUnbDG0MmiZgbZrCCTY6AYIdWFytz9OwKFbzTWkFox2
X-Received: by 2002:a05:6830:6d0e:b0:7d7:d100:2613 with SMTP id
 46e09a7af769-7e4ea03bfb3mr14110304a34.1.1779251856898; 
 Tue, 19 May 2026 21:37:36 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:13 -0600
Subject: [PATCH v10 19/45] target/mips: add Octeon VMM0 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-19-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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

VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
product, returns the low result, and feeds that result back into MPL[0].
It sets MPL[1] to zero and clears partial products.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

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
index 7b00bc994b..e51d3e6cf7 100644
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


