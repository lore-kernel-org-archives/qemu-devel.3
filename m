Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C1DC021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0b3-0001gN-76; Mon, 17 Feb 2025 07:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ae-0001ca-Jc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:16 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk0ac-0002H4-6L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 07:51:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f265c6cb0so1919682f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 04:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739796668; x=1740401468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Cujq0JdaQMnA+2txZe7tmirzkEMEUejhzVFg8j4HZI=;
 b=h8hR6dXdj27ac+naQgTSuJwxhf4pe6F2W/Cl+sqjqJyCfjJkJ/m5sp7hET/AUsYyzc
 BP4ecWM53qceYD7b5mdSmLxkxex2Lhpm+vlwjaqbyhmQ6De7zLn79sg51JCPeANpyPat
 bunoxcwYdUOGJ4u3TYNsV9JSARVu0aKV+CwwOQCfmVQuuU91UPdpWctEs5xQz8rFX2je
 cI1yE0rQm4SBHdbQD8ewhwb/UHOpSdtz4s0w5bnQYiJOYTvrxq6k/xbYJDKizWlRfvp9
 +dzjy5cQWPvbJktrJ50re+8vPlyqy73zRFvPAstXZf9y8uN8jmh5Vgj91xs8w0d2JxJV
 WzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739796668; x=1740401468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Cujq0JdaQMnA+2txZe7tmirzkEMEUejhzVFg8j4HZI=;
 b=KqKxDc7FcL1YjIXpYbAw3naUJPEZxTl5hbx/T+FXvlmnisqfrFliHPj9levj1pH2lW
 pbncMFdKY4hUOEqr6nG5AGjy1f6Fb46vAd/W1HKjj4ZdyBc/STaj5FK5bwCupydbGw/R
 onzuDGh+f/Z3Cv0y6/z3koOic0K1QwzSsmVLVfzciPSc4sU084LKQd46Je2iesau/bFx
 YeruI8Curyrc+3MnGYpVgV1ZhdxUn4Ta4eyHZZzQEkbrcNYavsnC5ICZQgadP1MUTDEn
 uYgvJgYSMLa2ZvKyn0F5D3eyumG4DjKDBIolk8KZZMZsTWglsKuA/I6MUfVMMnmxipFS
 JMBw==
X-Gm-Message-State: AOJu0Yz7X0c0KXiEy2H0vVfZ6XVCXPOvv16LX1JJpvgcaoIOmL6Qxodh
 1glXS5DjYcyrcKgFPiQVLjvvu/wA1GReJtb4ozGQSiAXWhZgUhkeeyMTKABm5DmmcwkZXRTgmrE
 O
X-Gm-Gg: ASbGncsDZ16q83r8JVafHDuwMnVXCM28nss8FwoydxpCrnBF7PorRxXJSdr4sXVsmRv
 1M87erxa1gDaQoIdlD0b6uNJ5EbShtAE8crHKeSq5zuqnL8MtyV35Rlb+gmJgdsJIU9ChLDfYZH
 fV8+zH606yY/9FGEbZD/ha9lEMWnZ9tB8cCu150V+LRM9ywTJxXJ6mnk72xr4DFpJ0UB0HCHUpx
 E3POHKOT+WDN4wYLT2w4R5+Yb6GsQiYzB159ituggO9mkn5/H186c/U9QQIE4bQfHPCv8sNDLMd
 HQc86Nj0NEyHKAzhg1qbjQ==
X-Google-Smtp-Source: AGHT+IEpBsbtY0Aem+F0l68jtu6VlQLwA+tIq8owsFtd2HUh4YIGGsgGTjOrHvWeq3/orQdGdckEFw==
X-Received: by 2002:a05:6000:1f87:b0:38f:23f4:2d7a with SMTP id
 ffacd0b85a97d-38f33f43751mr9201569f8f.40.1739796667646; 
 Mon, 17 Feb 2025 04:51:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e84efb9sm3562455e9.10.2025.02.17.04.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:51:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 10/10] fpu: Build only once
Date: Mon, 17 Feb 2025 12:50:55 +0000
Message-ID: <20250217125055.160887-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Now we have removed all the target-specifics from the softfloat code,
we can switch to building it once for the whole system rather than
once per target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 3 ---
 fpu/meson.build | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b38eea8d879..34c962d6bd9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -79,9 +79,6 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
 
-/* softfloat (and in particular the code in softfloat-specialize.h) is
- * target-dependent and needs the TARGET_* macros.
- */
 #include "qemu/osdep.h"
 #include <math.h>
 #include "qemu/bitops.h"
diff --git a/fpu/meson.build b/fpu/meson.build
index 1a9992ded56..646c76f0c69 100644
--- a/fpu/meson.build
+++ b/fpu/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
+common_ss.add(when: 'CONFIG_TCG', if_true: files('softfloat.c'))
-- 
2.43.0


