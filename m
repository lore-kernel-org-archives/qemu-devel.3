Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B18C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39g-0005yR-Cq; Sat, 08 Mar 2025 18:00:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Z-0004cp-QL
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Y-0005Ni-24
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:19 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2234e4b079cso53775525ad.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474757; x=1742079557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SM3YyEYj7om0b8jrExKW6zZqdC5bOOIBOd/A+S3re7Q=;
 b=Yl5FVggx56xhOEKI3VTKFitQpbQWcLTcNT7OWtINwINbA0cbyw7B8g0aXfFzlhvJ4I
 XFLpmwF5lCQ7kOifDfZAj2A6A2CmjNDEebrLbCTJuAHskbGmAmBKWijb/PpwAUnEC38f
 LViMl+JL4XeGhNb9BpDW06iR+VNXGhkORB5Pye8BOrwRgrTqr0qs7+ZQg3xNWjx/nvSG
 UY/tgtMd00DBMCsKHoZwctXzC8rvB7tNt7Abtv/8MQ61EYPrx2zr+QmGYzev5k5MhAiS
 37U7xlz/4BFE2U2Z0sZcwTnUQzBMpBx2zjz2/ZrprcvJaVhTzezT+06MtQp0aY5q/Mvs
 s7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474757; x=1742079557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SM3YyEYj7om0b8jrExKW6zZqdC5bOOIBOd/A+S3re7Q=;
 b=FqIPHKDs0qCAoHjMWPyrw29M3U60+VcSdUsLNx8ZwkoHBmbWHZ81uHLAdI555utMEX
 qvEZJmHmm8umyu10XjbkWExedHd4yMlzZ4rQSC/T72SW0IoqpL1cIZ4cWziyb7VboVdS
 LpUTkeMr+kAR7DVhg5FFT7M2qzxJn0I/gbGqxRqvDtOk0P/G7Am+Lksw/QIMMo+3/iKh
 Ze4eFuan84r6klba9L9jjk8jFh9Pr03R2gDNwn+dHguJb1ibrbiFrh0BS/TVnxAzi4NU
 rO1WKisfOiRO9FE+zcpuUcRNhca0QRgUdylm8LfDGd+n0Snt8ryGDlpQY+vO09HI2JI+
 LrkQ==
X-Gm-Message-State: AOJu0Yz2daI/3oRF8i3/ZCINcar00I7dnwXmd8hTlKCMimAq9x6LD8yV
 0vatznvMdkbkZJn4KAOUUsR3JEznyWbqycCRfV9YHAuyufg1vvmS1pES1zeSQs/jZ1MGPVvRXoS
 G
X-Gm-Gg: ASbGncu7/hCnbjE8XoR8vIN41cvMDbBN1R/2pQkXjh5WJYvfKNWUx1j8NwGeZaNqmz4
 x8d3tCCWiODwHRslR3SrIsmZjKqUHn4uLWy1L6C1oUfJIU4+j4EJfmb1TqR8tY75HoUSMjzQwzJ
 KcDUDCkxhGVI7P9fEeGnxP9c8Ju7OhbMK6FZf59gtqCEBFiUG0POdDkWO21yJyyZFQKRCDybeg+
 7he5fem1s3bCrM9NYdpVuG4yGB85scXk/56YlqxDkIRxa+Vae12hnhfZQurNi0KZKUV2h9txl8S
 sL7K3Mfr917iKTbqC5Yukv8V2zZW6IjL+no6fwl+QEx8t5qZ/vPxRtxhkX1xzTTf6wfxr8F0YMf
 6
X-Google-Smtp-Source: AGHT+IE4GsQGC7Z/Ax/v4k7mnyQzA0lZjnuAlEKhJj654Muy25kX/JMcDjohwciqQY+VMQItg0uSqw==
X-Received: by 2002:a17:902:d488:b0:224:e0f:4b5 with SMTP id
 d9443c01a7336-224288866a4mr113585755ad.7.1741474756842; 
 Sat, 08 Mar 2025 14:59:16 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/23] qemu/atomic: Rename atomic128-cas.h headers using .h.inc
 suffix
Date: Sat,  8 Mar 2025 14:58:58 -0800
Message-ID: <20250308225902.1208237-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 139c1837db ("meson: rename included C source files
to .c.inc"), QEMU standard procedure for included C files is to
use *.c.inc.

Besides, since commit 6a0057aa22 ("docs/devel: make a statement
about includes") this is documented in the Coding Style:

  If you do use template header files they should be named with
  the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
  being included for expansion.

Therefore rename 'atomic128-cas.h' as 'atomic128-cas.h.inc'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241212141018.59428-2-philmd@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h                       | 2 +-
 include/qemu/atomic128.h                                        | 2 +-
 .../generic/host/{atomic128-cas.h => atomic128-cas.h.inc}       | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename host/include/generic/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)

diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h
index 58630107bc..991da4ef54 100644
--- a/host/include/aarch64/host/atomic128-cas.h
+++ b/host/include/aarch64/host/atomic128-cas.h
@@ -13,7 +13,7 @@
 
 /* Through gcc 10, aarch64 has no support for 128-bit atomics.  */
 #if defined(CONFIG_ATOMIC128) || defined(CONFIG_CMPXCHG128)
-#include "host/include/generic/host/atomic128-cas.h"
+#include "host/include/generic/host/atomic128-cas.h.inc"
 #else
 static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
index 88af6d4ea3..03c27022f0 100644
--- a/include/qemu/atomic128.h
+++ b/include/qemu/atomic128.h
@@ -58,7 +58,7 @@
  * Therefore, special case each platform.
  */
 
-#include "host/atomic128-cas.h"
+#include "host/atomic128-cas.h.inc"
 #include "host/atomic128-ldst.h"
 
 #endif /* QEMU_ATOMIC128_H */
diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h.inc
similarity index 100%
rename from host/include/generic/host/atomic128-cas.h
rename to host/include/generic/host/atomic128-cas.h.inc
-- 
2.43.0


