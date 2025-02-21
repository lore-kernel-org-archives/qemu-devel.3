Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E656C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 19:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlYPe-0006Pp-Qf; Fri, 21 Feb 2025 14:10:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPZ-0006M7-KZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:09 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlYPX-0004Hd-8h
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 14:10:09 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso2119554f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740165005; x=1740769805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cBaUtQexwmvEbDOtV7dWohrzipVVAW8wPhNQo0ILWHg=;
 b=urxSt8Xtr9lPNgx8IyxukbV3cptOcMmFT3F2dp2wlWZgaOdMrxa++D070bVECSSIk8
 njd8FDlulNQVr2WgSYMyYIoBObjVSSajLgkf33ZveE00m/UC2N8FQyKR/WPpv5K1qmEA
 /yJWg6/FEPm0BbFcXh661WGg24aoCF8eDDCq6Y7mG7fFDDp44rQBb3cKdhvoDGFBHZGz
 4oPheiWm5szBQhDeA/t4EbH++AsqoMqC9kJ+QhadVZENFcCQDa+av+5bSp3c/6aHU8sB
 vuYgN7cLbOBDD5sJZxpROwZ+RPpk4D3sW3nT+GO0+6+8XsRg3NM8PmYA7TPNyUJdtBaP
 WsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740165005; x=1740769805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBaUtQexwmvEbDOtV7dWohrzipVVAW8wPhNQo0ILWHg=;
 b=Vhyy6wF5V8CiUAllnia8kpGPVNx5vC+TrGdE0jdMCdX++FsOa7/fUvHYT032E/YpO8
 QESGaYguuSwv2bWqfL3w0cDySXfoPPPlWHOL/mx2Qq3ErT/E+vcr4xwyaHjwSHaxkmqo
 ObZ/DTX5MY9k8FGcLo4WitWDx+O1Al/Mwu09orzq85ZpuJdrmhRCLW7WDGcINtVXEblA
 9KNmQrhEajCMHF9J4VQPSmqRox3kpQlPGwTFYH1fiDWfQl+QrWgWbiquTVXKb+80fs2J
 Q1QHiIm6xmPBRhFmCyHO9ArYQAVGDCmqpp7nd2SnpwO3PQTpFsBCHQv66v+oGj1fVdH3
 78ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3+Nojy6/6/t5LQUGW88O1wi/k1cVbtCWBwySmlPr4oFrcWBkABrH7YSRgOZA18MkQW9Dkove5QMaG@nongnu.org
X-Gm-Message-State: AOJu0YxAtF+76H/TbPXXP4KRFOgrKQY1UMiE+R/TaERlwYahX9kHMazu
 cuQbqbI5vEAXZgW1VbSxrfSelBn2YuVPtOZQrDKELPG786UitCPK02+3TZRtoP0=
X-Gm-Gg: ASbGncv/2oZDFzpipBx7JFScPWKAs0bdh3n1HgCOGzq/fHPxZSwSdlev1GHzlRegKrU
 FSsCtHd63G5l2b6vbmuqMa3FcTW/xcjnx/L2XiR2EPv696eoU3LK0SFKg6osHXxgdZqagDRpSLL
 BhcCdcrJLrR3oqwSKbDa33vSnc+QvFVCWq0NiJcxyH56gKfB/UEFRkLzrgluAA9FopxEdoW/BwL
 GF3Mrc5NUeq/NMILO+3QGmH7Y1DCad0t1FXYX22IN8KaMuYguR8uK+qtbCJ4PS0ifpX9eImBlRG
 r3+E4NKHEemcNaF6jv+ARORaFJlnoJtv
X-Google-Smtp-Source: AGHT+IGdspyBIRbq6mTAtalDYzGPOq6CvfMoE28lFDQ+OYEowJGrWoCqfRNIwTLTZUwQlb0QVUNz+w==
X-Received: by 2002:adf:f003:0:b0:38e:65db:517d with SMTP id
 ffacd0b85a97d-38f6f097eacmr4193414f8f.40.1740165005242; 
 Fri, 21 Feb 2025 11:10:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm24392478f8f.39.2025.02.21.11.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 11:10:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/4] target/arm: Rename vfp_helper.c to vfp_fpscr.c
Date: Fri, 21 Feb 2025 19:09:56 +0000
Message-ID: <20250221190957.811948-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221190957.811948-1-peter.maydell@linaro.org>
References: <20250221190957.811948-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The vfp_helper.c in the target/arm directory now only has
code for handling FPSCR/FPCR/FPSR in it, and no helper
functions. Rename it to vfp_fpscr.c; this helps keep it
distinct from tcg/vfp_helper.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/{vfp_helper.c => vfp_fpscr.c} | 2 +-
 target/arm/meson.build                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename target/arm/{vfp_helper.c => vfp_fpscr.c} (98%)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_fpscr.c
similarity index 98%
rename from target/arm/vfp_helper.c
rename to target/arm/vfp_fpscr.c
index cc0f055ef0d..92ea60ebbf2 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_fpscr.c
@@ -1,5 +1,5 @@
 /*
- * ARM VFP floating-point operations
+ * ARM VFP floating-point: handling of FPSCR/FPCR/FPSR
  *
  *  Copyright (c) 2003 Fabrice Bellard
  *
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 2e10464dbb6..3065081d241 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -4,7 +4,7 @@ arm_ss.add(files(
   'debug_helper.c',
   'gdbstub.c',
   'helper.c',
-  'vfp_helper.c',
+  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
-- 
2.43.0


