Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F584C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 17:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryx8f-00067m-7G; Mon, 22 Apr 2024 13:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryx8b-00067a-3Q
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:07:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryx8Z-0004lb-0p
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 13:07:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso2644715ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 10:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713805645; x=1714410445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=39YtgjPga6zni7TyfrRqLQG7p9NAFXqRFglkaRLeOY8=;
 b=aXr/UAgiaEznS5InwxMHPbjpFh+7YYZ+f5gpIHUkED2Qf/sZYo6Y1UvZDlwKBGVM/D
 cpp5rPXAQ/BMKxCx5f6Bkh4g10AoP5OQbDfesp3WUgl2PPwSxtz9FaMX+yNEmwoG3fMj
 KNJLRg+Oy6tmwMCfrBgag4oISXV89zm8GbZlcxCM9IVMd6Ki5PfKL3dwCda82u029aQj
 nEXTlHxxzzygPeTOcjGeE7HFSWZLcx2btqVLDwmn70ZGpA28o8iXdAi4sTiSPI35nhMS
 j81LG3d2hwfsIUQRJWwsS6lsf/3fmSU7E6dK3lXQ9Uxvgnd5x1IuLb2RqnUt7hUa76zf
 67tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713805645; x=1714410445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39YtgjPga6zni7TyfrRqLQG7p9NAFXqRFglkaRLeOY8=;
 b=tJ+6arQhikTYJlaPeL2cUPi5l6Zb6wz6PDcA1YCpaQN660wpgjbW3EO86S36SZgryw
 uhxAlPqAO24LMRDVvvbtaImsfJyGm4hxGgc09OwWdgz9PNHCMK2WLzEJb/HzJWTH575d
 XNVJiuq/UlrIwsv6xun6o0V+xFTNb9SdT1e3C7yVLw9UN3aqPpDXu+dg5igFZtoqNeA1
 kOt3cFSycABE6L/98WxoMiwDsOm+uWO6G+F0T05FL32MGskhCdVWIv59dRqizlL5FGlQ
 6anv5G/gFNF4GosuL6T3M7Z4U0VhQgPOWq/EsHB+/bVQRZ+ErYARTIym8Skv4oui2jHe
 0oTA==
X-Gm-Message-State: AOJu0YwHTFIQ6mG9rFfBvafUU5a2jUreB6YbNxm8/y4Qq0pVeK1MTMH6
 6/q1pXZJhnN6TqIK91lHX+Y521uB10wYpMwMPBxtcKndRNE3bGjSSkV9+pxGmpYP6nClYuAl8En
 W
X-Google-Smtp-Source: AGHT+IE0xOE6q1dD+Qg+gGsyihA+x2gaw3WTCTsL0/qfmth/f3tv+C4S9yNAJRUuut1A/nOB53zPQA==
X-Received: by 2002:a17:902:dac7:b0:1e5:2a20:2d68 with SMTP id
 q7-20020a170902dac700b001e52a202d68mr13247523plx.47.1713805644975; 
 Mon, 22 Apr 2024 10:07:24 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm8350594plg.156.2024.04.22.10.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 10:07:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/arm: Restrict translation disabled alignment check to
 VMSA
Date: Mon, 22 Apr 2024 10:07:22 -0700
Message-Id: <20240422170722.117409-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

For cpus using PMSA, when the MPU is disabled, the default memory
type is Normal, Non-cachable.

Fixes: 59754f85ed3 ("target/arm: Do memory type alignment check when translation disabled")
Reported-by: Clément Chigot <chigot@adacore.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Since v9 will likely be tagged tomorrow without this fixed,
Cc: qemu-stable@nongnu.org

---
 target/arm/tcg/hflags.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 5da1b0fc1d..66de30b828 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -38,8 +38,16 @@ static bool aprofile_require_alignment(CPUARMState *env, int el, uint64_t sctlr)
     }
 
     /*
-     * If translation is disabled, then the default memory type is
-     * Device(-nGnRnE) instead of Normal, which requires that alignment
+     * With PMSA, when the MPU is disabled, all memory types in the
+     * default map is Normal.
+     */
+    if (arm_feature(env, ARM_FEATURE_PMSA)) {
+        return false;
+    }
+
+    /*
+     * With VMSA, if translation is disabled, then the default memory type
+     * is Device(-nGnRnE) instead of Normal, which requires that alignment
      * be enforced.  Since this affects all ram, it is most efficient
      * to handle this during translation.
      */
-- 
2.34.1


