Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A4C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwU5-0004xB-0E; Wed, 02 Jul 2025 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwU2-0004vZ-I8
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:38 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTo-0007D8-MB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:38 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3743877fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458941; x=1752063741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0lOyAHGfdwVrVagI3IBAJ8avsxWv+VgaY92gqB8lM0=;
 b=G3goi1vcMmuBgTjiSnPcfp0cKCxPosUutjboZYSMJI7U84zOgE5sc1LYh/lIFDzOPg
 vDZDP7sEd34KrLG33ZwHCa+zDkFktRwBlhJVeXjvsNO3XlEIEYllznbb4t2xfsDhzehw
 tQGumBxoebADGhKS4D7u3l6gniW3UeXg8PT3Ga97QNOgLjGDsoGeff3E+pgUb8JVkDVD
 GFtzp/kb2dVAsEfQRgTV9BqHRrc0IGSSrF8hYV7vb9qyTQU+JdhedTeTaXB6qFzHuyzT
 jvQSvkIsKp7gGNKGtXf1/tECU1wYOtReBeqi/jIGjDDH5/uNthsGjMYRBpZgLORw4reJ
 0p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458941; x=1752063741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0lOyAHGfdwVrVagI3IBAJ8avsxWv+VgaY92gqB8lM0=;
 b=I0p7ae0f2m+eBqTPraWzitfL8n39WEj417d7aLX76jZtY0+aVZsJXKPMk7IQWvSwuv
 L0eEKjxrFzg+fTXTQvTzfFo0qQQeVzuNVS7307K5u1znGsiv4nHm7XeEs816n54iH0zS
 vnlk1Kzm770aagVYO+8LCQpLy39uhWCVCDGdjxG5S0OpG4Dk4LzfMuIjxRQZmzmqZVy8
 XJXp3rWE7sooiM0Gba6XuB74C2FfEZJtouMHPZA689kkiEYpQuxYVBBL9qP/+2EAXA9c
 JRwLcpcgAUnQ8kBq6/aEwOExitAJpgbHNLXLAdBJLWByyHkZg2HXmqY+Fom8iGIWVTLz
 p+Vw==
X-Gm-Message-State: AOJu0YwiDZSaHz3CkDEKE3tuyGuYpq6BVnWHKU9t1+eMkR7P2qb8vhGW
 ThjzwPXbAHMFDJD7ur0fSJN0WtCALyvdvTjhlBNn+ZNcaJxqBa9gBFgn+Zz7MZEtcTQj+rKjXtR
 1/IAd31A=
X-Gm-Gg: ASbGncvKBz1hMY8ImbYhBphZ0nxRzqyDqUkhQIUqCgIT/toEkEmM4cTRElHu7mpHe0u
 DTTiQVmr0+3i6IloVVLxlFIeQAZM4r7PmHhfm5jUlYpFcRPddImxcXTRgCph3vvt0P2LMrDx/6D
 2maALQsu48UxIfWuUiuyVINBFpW3Mvnmwra0oE2TERy4XJbbz6+2GUqjuooK+TODTeQf9MwrLRw
 3XjQKqpgEb9D37ZjOEUXIK3ySvoRiCIb3HY3dGBe+271OWYhN3Ffzop5x5MIbteZ7NYjaaIlCrr
 HiTadc9++hqnyJzgcEfyFgfIsptoSJD+YzWavzNuaFHgnsCZA79bjZcKXPnBpz7XOZW9Ww==
X-Google-Smtp-Source: AGHT+IH/WXDzTMlzCxAuwP43kQHnbJP3++519fAOeui32y2v7WRNtWr0vvOw5X+s9U+7TnB2mBvmwg==
X-Received: by 2002:a05:6870:6f12:b0:2e9:fd62:9061 with SMTP id
 586e51a60fabf-2f5a8c83c06mr2028914fac.32.1751458940998; 
 Wed, 02 Jul 2025 05:22:20 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 04/10] target/arm: Replace @rda_rn_rm_e0 in sve.decode
Date: Wed,  2 Jul 2025 06:22:07 -0600
Message-ID: <20250702122213.758588-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace @rda_rn_rm_e0 with @rda_rn_rm_ex, and require
users to supply an explicit esz.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve.decode | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 04b6fcc0cf..3a99eb7299 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -131,11 +131,11 @@
 @rda_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5 \
                 &rrrr_esz ra=%reg_movprfx
 
-# Four operand with unused vector element size
-@rda_rn_rm_e0   ........ ... rm:5 ... ... rn:5 rd:5 \
-                &rrrr_esz esz=0 ra=%reg_movprfx
-@rdn_ra_rm_e0   ........ ... rm:5 ... ... ra:5 rd:5 \
-                &rrrr_esz esz=0 rn=%reg_movprfx
+# Four operand with explicit vector element size
+@rda_rn_rm_ex   ........ ... rm:5 ... ... rn:5 rd:5 \
+                &rrrr_esz ra=%reg_movprfx
+@rdn_ra_rm_ex   ........ ... rm:5 ... ... ra:5 rd:5 \
+                &rrrr_esz rn=%reg_movprfx
 
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
@@ -428,12 +428,12 @@ XAR             00000100 .. 1 ..... 001 101 rm:5  rd:5   &rrri_esz \
                 rn=%reg_movprfx esz=%tszimm16_esz imm=%tszimm16_shr
 
 # SVE2 bitwise ternary operations
-EOR3            00000100 00 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
-BSL             00000100 00 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-BCAX            00000100 01 1 ..... 001 110 ..... .....         @rdn_ra_rm_e0
-BSL1N           00000100 01 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-BSL2N           00000100 10 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
-NBSL            00000100 11 1 ..... 001 111 ..... .....         @rdn_ra_rm_e0
+EOR3            00000100 00 1 ..... 001 110 ..... .....     @rdn_ra_rm_ex esz=0
+BSL             00000100 00 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+BCAX            00000100 01 1 ..... 001 110 ..... .....     @rdn_ra_rm_ex esz=0
+BSL1N           00000100 01 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+BSL2N           00000100 10 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
+NBSL            00000100 11 1 ..... 001 111 ..... .....     @rdn_ra_rm_ex esz=0
 
 ### SVE Index Generation Group
 
@@ -1450,9 +1450,9 @@ EORTB           01000101 .. 0 ..... 10010 1 ..... .....  @rd_rn_rm
 
 ## SVE integer matrix multiply accumulate
 
-SMMLA           01000101 00 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
-USMMLA          01000101 10 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
-UMMLA           01000101 11 0 ..... 10011 0 ..... .....  @rda_rn_rm_e0
+SMMLA           01000101 00 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
+USMMLA          01000101 10 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
+UMMLA           01000101 11 0 ..... 10011 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ## SVE2 bitwise permute
 
@@ -1602,9 +1602,9 @@ SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
 
 ### SVE2 floating point matrix multiply accumulate
-BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
-FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
-FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_e0
+BFMMLA          01100100 01 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=1
+FMMLA_s         01100100 10 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=2
+FMMLA_d         01100100 11 1 ..... 111 001 ..... .....  @rda_rn_rm_ex esz=3
 
 ### SVE2 Memory Gather Load Group
 
@@ -1654,16 +1654,16 @@ FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
-FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
-FMLALT_zzzw     01100100 10 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
-FMLSLB_zzzw     01100100 10 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_e0
-FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_e0
+FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
+FMLALT_zzzw     01100100 10 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+FMLSLB_zzzw     01100100 10 1 ..... 10 1 00 0 ..... .....  @rda_rn_rm_ex esz=2
+FMLSLT_zzzw     01100100 10 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
-BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
-BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_e0
+BFMLALB_zzzw    01100100 11 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
+BFMLALT_zzzw    01100100 11 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point bfloat16 dot-product
-BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_e0
+BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 ### SVE2 floating-point multiply-add long (indexed)
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
-- 
2.43.0


