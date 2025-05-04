Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3809CC3ABAC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvL-0002RJ-HS; Sun, 04 May 2025 01:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv8-0002DJ-N0
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv6-0004Oy-FJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223fd89d036so38307765ad.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336583; x=1746941383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=iFdwbngVLIclcTngU/ng/9HUYTOUIc3tl7WtDE3obltyknSdwumlF/ywEAX+bcUAcj
 eLR7gX7D/k2gFtW/VlPts4K46vZvmXte0aRzfiiXCJbxGKX6eooYuZVrW/yMzz+Ikcw/
 cHUm11zreoumRZ97JDRv02SZ71japeaWtGg866Xy2OKB43JYhY6n3mcBA59PDg+zMJSz
 42a39jrVHPbo/P6vTxFJNiWgLId5AdZ0Dn2xBZzBEwojtK4h2FU+7Fw4/lcqzrwkDLX3
 GVWRVJpLaYcZQYgDtrgfmXoo0IksQFNMXZJKo7QdwF8PRrDeSFQFY+8bfC8zA4gqsSiB
 gVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336583; x=1746941383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d146Pj4KjTAmT+769pG7plO/J3O67dCMeGHKPEFKjBI=;
 b=jqUpVy0eo+JG+eM06YEkG/wwHEFYQ2BwbkgsmsYrpMc0kcQMw7NkjitTMyKgDfshH6
 tphHy/4Rfiiuc3nbsqQxO9JeIrxgsC5VbnsrP/iAERBP1ut3hedPIrXYEjfi4yMLZFWL
 DI4Pz9IibM2Q0pxHNlIopcdj+Ijv9/EQCHAnwcbPlyudNJXG6dr5+nMpBywdXybTRgES
 lfChREur7FuOFhPLNygKOiX0/YGi5J2ps7FQ1hrKpCoWo73ctF79eUcNtg1cNAnfMBBo
 R0oq7dg+oUzKUUGM/Bbxolc3SqgdlNu4Pwf3EoyF4LWmAOxoDMyXUZvnT9kmAPqu55O6
 dMuA==
X-Gm-Message-State: AOJu0YxwUCL2C1PbFTJtj3lxSZ7Yj3rTijK3DFV1Zdq/u8wJTmoMc1ff
 hFqUm1fg7/5H4hfppw5ecqjK7rs2ruN1StjKW4BfC4YjXYeUcUFnDRTPev7b99gEjx5hRlCBESO
 qAqE=
X-Gm-Gg: ASbGncs8S7JTrq8js59j0ifnR18PZiRja6eZV6RnN/tpu0Hhf+3gMriJsQcfa1ALqL2
 KOkKFToAoDhlcFm86/2SQnmoNAQvvOwtl6g7Nco2OA9u7s4NboB95hJhjGzCbZb1+1n6y9D300G
 1V2rksCQK4LrtOn5MqkYB+vZ9vJtcePgsqqaAoO8qT7wrsdv580ltzGDOhqvqBON5oGKjjJC89E
 pgWKht2CyhwFNjno12i9wFXYza9WvVziE/GNSpL/lgrL13/lV2bsLeAaUOddT0MO+JHC82cV+8Y
 ryhZPzdYCeA5hJn4cZN3CpqNbIfS95SZdJxPt+s/
X-Google-Smtp-Source: AGHT+IHuftjvx8K+lKIONTdQb5rUxohknLqdDXqhEx93QHw1TFnNfxBlVnv/CW1cZSPZujSKICoonw==
X-Received: by 2002:a17:902:d2d2:b0:220:fe51:1aab with SMTP id
 d9443c01a7336-22e1ea4c3c3mr50378075ad.38.1746336582911; 
 Sat, 03 May 2025 22:29:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 26/40] target/arm/vfp_fpscr: compile file twice (user,
 system)
Date: Sat,  3 May 2025 22:29:00 -0700
Message-ID: <20250504052914.3525365-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index c8c80c3f969..06d479570e2 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,7 +2,6 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
   'gdbstub.c',
-  'vfp_fpscr.c',
 ))
 arm_ss.add(zlib)
 
@@ -32,6 +31,7 @@ arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_user_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
@@ -40,6 +40,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'debug_helper.c',
   'helper.c',
+  'vfp_fpscr.c',
 ))
 
 subdir('hvf')
-- 
2.47.2


