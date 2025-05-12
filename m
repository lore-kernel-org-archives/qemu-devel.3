Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C38C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXdu-0005zt-Qy; Mon, 12 May 2025 14:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaG-0001aN-EE
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaD-0000TF-CG
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso6532534b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073336; x=1747678136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN9bpcu/hK+eTVDHriw8+8GBLuzv6l51ao11Y0jPFbk=;
 b=ihjoNJT9iVIv+KBFT56cdsu/uB/OQU0EiO/gYfZ1qQ4hyg6MAzfoV2NYZ6zz2davso
 g1w5lEIMRKApYePZLaaeOqRCkKY6dlC5S340AH1M3lSJ4/PqoES1G0aSC1Sz4OC7aR4f
 pSrxecjC67J26fxGM74nm4FTacPJabFFN1xPHQGrI1s5B5Awm+Lb4MhmYCMrfnCUxjtq
 6HQ/aoa0fXwk0TUQlPR/M8UGbfo6e9UNP+m1gnmHaNq0M5W3EhCOEdvUMhk4e7fjDLfJ
 CMDJN2CXvUwi+i65wpNz3SOL7M5pxw4W2rRQpNmbIvMpodzpHAaG8XeAb9YAixLDkP7+
 Y1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073336; x=1747678136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XN9bpcu/hK+eTVDHriw8+8GBLuzv6l51ao11Y0jPFbk=;
 b=FkJTNCPQ5LX9ss9jQI+Hq4v+MoF+TF1HM76BYOFPSLGwSFEuIKYykg0QGasCWMGPa6
 /FUAkvWQCqF0vh6AJbt+z7GHBB8xtumA/fhjcIL0U0gBjU0LDLgREK0M9HqhKkDl0t2C
 9y2SKZb9C7NJItQzR+Q9GZEJa0V1Z4+ByMrVgKs2MFJPXRwC+LROXjjYza1eOj454HBF
 Fs/UpiGyrUoZroRwtwEpKvK5ywvdq21KeBf7ObxXJw7Gu3JOiEWdRuxi8Ev+LM4nYCbl
 9370SbQAoW6sMYlqKI4AfQhFdttZmV6R/y5faPnHriB17LX7d8b5uqQQr9thmeWBkpGr
 xnZg==
X-Gm-Message-State: AOJu0YxVISQtAR+PFHErsjrvlDkgE4Jvs89oza9/4VcSxqhNnHRfmseN
 bFcKXmzKUhTQsNQLqdaA5Fsbl6jyGQYYeqe9dKEj6ukRIP6884N817CZQLflo1PQ4wOmu5h9Q8n
 v
X-Gm-Gg: ASbGncsM0lOzAb+TqcIr12ZQa3jQKpJyydeJ9PVx3DMp/6CMn8k1h4x7QNZT0GON+Mz
 DJNAf19KJTcmLgfnoUXCiMEGJJiDqVqxObGsSCoCbyQVTDT2fqM/LmRr3CPLmoOsRqcllL0T1op
 jZRTbsicGCsv23DdOh28ehJKwot42mEhbdjHNSBBnT/0zUsGBty6v1uzUxjgjTTVzvNIlWYjUQJ
 M6acBOf1CFxyT0gTFqwX+8ydclj+MVfpK7YI4O5uy8A/ki8WoAQ6UY5VLWjE148Jh/PJwLixQFL
 5wkBzLu+Gk+hrlA0VwPtk4JvdbshcxI8yWSvshAboZhP90haJK0=
X-Google-Smtp-Source: AGHT+IG+BeGr4IuBP8TMSOSX77hezFOtRuiKEwjWd9/2pXAZfzUtVZDsMPzzrQ073yba+JGvzQT+/w==
X-Received: by 2002:a05:6a00:9286:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-7423be7d6d0mr18600353b3a.14.1747073335760; 
 Mon, 12 May 2025 11:08:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 44/48] target/arm/tcg/tlb_helper: compile file twice
 (system, user)
Date: Mon, 12 May 2025 11:04:58 -0700
Message-ID: <20250512180502.2395029-45-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/tcg/tlb_helper.c | 3 ++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index d9e6c827d43..23c72a99f5c 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,8 +9,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index af786196d2f..49c8f4390a1 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(files(
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
-  'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
   'arith_helper.c',
@@ -68,9 +67,11 @@ arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
-- 
2.47.2


