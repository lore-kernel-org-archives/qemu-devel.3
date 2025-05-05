Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3521C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4U-0002lz-3i; Sun, 04 May 2025 21:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4L-000240-HC
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:33 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4J-00037E-Le
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:33 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so3138865a91.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410190; x=1747014990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TH/D4KCEFHBYkSCcvDFfFBdITHDf8vFzzXvCaqLo6XY=;
 b=QTrCyoAoZYdjEVElvln1UKf/bdHHIt5yIAtV38O6g7/jxy+925RWXcNbdwNvT+sMH2
 6d0V5Im4PllbJxEQtL4UaHzr5vfJMez/woFBUM43dxFz3I238/8nG+fz3if2IF8iuPhh
 tya8OTv6dHXsiEqxpItYgOBSvwAQOm7d3NjkcdNRqP7TN30fT8nxT8J9idYMwdyuXHHg
 sZ5U8q9hyKZQv7s7PoH5H0zw7rheXz3tLqvZMrKHFCE34fbg0uVTvp1N9XVrbUxOCyZg
 AYJPjUXchQ0GD4ANzPmJQuc7P8FHehI2nAWJdiuv9mANIg24cZSlb2GXQbT9IhEQErCE
 J7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410190; x=1747014990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TH/D4KCEFHBYkSCcvDFfFBdITHDf8vFzzXvCaqLo6XY=;
 b=KE3/Fi4X/1LN+WGm305ADCAE4ldklR1iMUSQ8urTBOlAOR96Ylh/OQSKLcU7+bs9St
 OT0KU6KaZYyCuGAl5ioWKNebpUPltHftDnp6gB42BPBWL5Z/F8EFY3ZL8CPwExWDFmJ+
 7aI/j4zo3adQcwKZJrfr3Qavg6G1+F4j70FTEsxb6JJzbC/+Lp4Ys1xsNwTJbz66846R
 mtlmHeUtQSI/pfg///wGGq8rpJKqBHHHskDocK+MysXzUiTsgsL8Cy1WGL6kWNg4TxR8
 JpEmRliZommBnegJGEASWtajqY7e5xoDcv4alTuzbZjTiLYImdzJlE1S0t4pufEN0iZS
 jJnw==
X-Gm-Message-State: AOJu0YzoBTy1krxbMxdCdcLq2bUIz2bglN7a/TrzM+wWi3uiKMnyfTmM
 PzsQkQhEhLaDi8bgMXHvNB1ewcjKf/KGgxEMgnrkN7qM3MmtelwFoEwSCGHDDNdyIFh5M6h+mSn
 Nx1M=
X-Gm-Gg: ASbGnctpZResAJPaj8vE1yMUpwrww/US4qLXtS/JsxQaGJ7cyt2XkmACveYRlCLhohX
 /VyRvWJCHNqthKqERVElF/irjdA8J5S/7CQEvY15E9/wrt7m7+ejrF+AFc/4YhDFTYwOGF+Rtku
 FfhyRJegOAGsxCCVuo8uTKJSA462Db8fH0IvhrWWZIoMmrJf0KraGIqYRSPBNflb77p32uVMjYU
 J5OQyLS2/8bwZAc3NLTaSE+Yp4WJnYMvU3Xowf3g6mBY5RfDQGXugyr4aZSMlYm4gyVChWmxJK+
 yoFj0HEqEvguSnn6WUEajGUDhUTlWUOzE7F6+u5T
X-Google-Smtp-Source: AGHT+IF0Ds40ZHzk08K/DrLbhYF01+YRnck2UbWKHsPrY2Ni7NasWl6bG7xvvtKEwRf6w0IbqqPYqg==
X-Received: by 2002:a17:90b:5704:b0:2fc:3264:3666 with SMTP id
 98e67ed59e1d1-30a4e6914cemr16806185a91.30.1746410190151; 
 Sun, 04 May 2025 18:56:30 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 47/48] target/arm/tcg/arith_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:22 -0700
Message-ID: <20250505015223.3895275-48-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arith_helper.c | 4 +++-
 target/arm/tcg/meson.build    | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 9a555c7966c..bc3c78c5011 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -7,10 +7,12 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index a5fcf0e7b88..ad306f73eff 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'arith_helper.c',
   'vfp_helper.c',
 ))
 
@@ -59,6 +58,7 @@ arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_system_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
@@ -67,6 +67,7 @@ arm_common_system_ss.add(files(
   'tlb-insns.c',
 ))
 arm_user_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
-- 
2.47.2


