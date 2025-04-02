Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01006C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hq-0007lV-8F; Wed, 02 Apr 2025 17:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Hc-00070o-6G
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:06:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Ha-0006bO-4W
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so1582075e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627957; x=1744232757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2CuFRMF8tGsrdfqJ5EAiHOu7bINkhnIQDSuUKCH5uiE=;
 b=Z61Wg0dIHWC34F4/1Wc6I4Wn4JnuN6PEdCo/rgvgYYhPLLu0Tt4Iw8tSdgKOsYahyw
 ZCMlZyNgc+dJ/PTd7j5+CVIHLGZcRpkFUs8s3FMRypcD7Cmdp+FLLpkaVhRY+90CcsAl
 ydK7z3Usr6wWVzoUvBefB6f/ZhDU7b3os52vsVHn+TbygQZzjaWXtVZi6QtB8PBj98GO
 xWFNnHTZZXZBidhHnYvXSFda0xdRXm7Ljbc+m3dKbReho6arKQ1za/CSPbZqp2uZzJtm
 G5cRr8VsD9KlHDm31M5UShCUaGXrUhFDyVwB5Fa3gtGL7N119MpJuSvmw/Y6cobaM6So
 P1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627957; x=1744232757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CuFRMF8tGsrdfqJ5EAiHOu7bINkhnIQDSuUKCH5uiE=;
 b=n6eRCUir2zrf/3lmC5x8sf2uRUqfxBPwoEP7oBHf161o+lE7RemAPzjT8TpImrcOja
 Tjq/WbfvFRqYMd6wuEaZk/anEwlaUXRAKUr65xoPIaqgLPIcTMJVaHLCp/5zwWdUvE5c
 HlgZnvciq10NBviWktDSOi4fLLBQ/8X5PXPdpWgvcCebc31KiaBvX38HzPxwIl3APalh
 z0nLtTNGIoOOP/zBw4O4+c/IYVGh+7Tw/+yhBkp8DbWSm5GuzAWBlo/eUWxJXFriXJMw
 smAjfT7KZBZnsJHZdi+uq58FP1gZN87K0gBfg+NTohTOkynprEHUgjhhQk8jqenOAcCP
 kZ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8okZ9A34jn3ru0SRp8hUhEFtmP9NfkY4QPmU7J1gIiRE2oDVHTxvezxUtHn7whR1UIso1rrqt1KgB@nongnu.org
X-Gm-Message-State: AOJu0Yz3SHcgOVIx283Xvug/ah8vvc6WcvadNg//aCE2xIOwe3lNtKeu
 pIALs/DDj87uKKVurRxUh1M0K/UgdttNBUq6fpUDQeQgx3s95TlVoCa84Bmx2I+U85lwmyI14cO
 u
X-Gm-Gg: ASbGncvg9DAZuhpBR6dx8hXJkmQQfckZ5SrHYStQ9EhYq+terQGYUUa3xI+u4MRAZOZ
 bycFAy2zlSYvKLkKrAt5cMjZSos8aj5u8dEi4ZUyKzupSNCE/IHeYAlZXn4hE6w9P3VODV7y4kH
 cERXUltsmXjlBF7bvnu/CkBglKhVNd2ENBOZcorVnNXk4GSU49aVLSsoJVDpI5jTkrOF6/yIXOE
 Guwk4/WO7pS8T4Jqxdvayol74XkwNzSXgixU2zw+SGlazZWKc+E2J28ENfCz9NTjR4sinn20XVR
 l3kTswChSmg2tr40U7cthaMut0DY/yC5CBpczmN9Ed5FotwMQql1SYDXJ26xGtj2gs8ChZd/Gjd
 G4iY+fabWmaY+lq9YU/c=
X-Google-Smtp-Source: AGHT+IFmVNF8ZLRNUURTrGxrJDg3M6ixisV63EIroyyYYd26NwDZyJMkanAaTgBDMI5XOtopsRG7vw==
X-Received: by 2002:a5d:6191:0:b0:391:3915:cffb with SMTP id
 ffacd0b85a97d-39c2f94bed8mr83463f8f.43.1743627956818; 
 Wed, 02 Apr 2025 14:05:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16a3aefsm2075535e9.21.2025.04.02.14.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 30/43] exec: Do not include 'accel/tcg/cpu-ldst.h' in
 'exec-all.h'
Date: Wed,  2 Apr 2025 23:03:15 +0200
Message-ID: <20250402210328.52897-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Only 2 files requiring "accel/tcg/cpu-ldst.h" API do not
include it:
- accel/tcg/cpu-exec.c
- target/arm/tcg/sve_helper.c
Include it there and remove it from "exec/exec-all.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h     | 3 ---
 accel/tcg/cpu-exec.c        | 1 +
 target/arm/tcg/sve_helper.c | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 70608a11b60..944b579d91c 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,9 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#if defined(CONFIG_USER_ONLY)
-#include "accel/tcg/cpu-ldst.h"
-#endif
 #include "exec/mmu-access-type.h"
 #include "exec/translation-block.h"
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 5ced3879ac4..b00f046b29f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi/type-helpers.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "disas/disas.h"
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 9b0d40c9e18..87b6b4b3e64 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
+#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/cpu-ops.h"
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
-- 
2.47.1


