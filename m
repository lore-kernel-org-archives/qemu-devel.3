Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1735DCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZh-0007Sc-TM; Wed, 27 May 2026 06:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZS-0006qU-BJ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZQ-0001Ao-NR
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:33:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso33677085e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877982; x=1780482782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mnpbUXM6TIunToUX/5kcKvwY/pCMd0dDfqwatVRnPLU=;
 b=cbk2HQkCy4FohoYFdbgtr19sd9mciETzLz7OK6ZZiqwyAx98NCp+JBXOiMK+TKU8+R
 8gI02XM4x4gw5fvJWMYtEBAXmY1COwaBacDmrFlgB+h2UusT2WnT8hb3jiPvxVjJchOu
 KKznwnDBQnzNb74ZLUYCBvX3ZzOtOM2ryUw4EMU3gpRLgmfF8TuFSV1RRaRIUcPUTZS4
 KfNN5yOwAld8h+PQmRdbxe4KkbbbVYMzJIyhb4gBlN4MqV01HluArbcI1YW1m4qQSezb
 F0u1pMgpwLdZfXK9J9od+SQjZB3uWjxarVSq9fhPlta9LDHKRR3zIAa4kUyzWszKlbJe
 tI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877982; x=1780482782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mnpbUXM6TIunToUX/5kcKvwY/pCMd0dDfqwatVRnPLU=;
 b=fKgdbDPXpb9oHBGiWqqshcsaSF4C5pQuAmLWpY56Rn30ZbztqYO4uOWucX9iOueozA
 g+4XtiBdvXFjXzu/Dyri9PCQlrfAsq2yflU39VGJ0x4H2ma2GZCzcLMo2I8OghX5REMN
 PaDmCxtZj2AyUpYtehWI1nXfWYaZdCtYwPTLkC6kZIQ6tSL/6CP4PZSUiIW1O9Ii9l/C
 APWCKrrkHc6Gl08g/AlFCHGlHADD1UlgIZrOOwC7ntl5YwPEXce4P3URGLHiCdLF04Qh
 NI41oFnXioLeDkQZjD4zghCSw4nDttlBSTyw2R3RdT62TmrTkMk0Rsh+97phLOG14rTh
 lFew==
X-Gm-Message-State: AOJu0Yz04Ud7Xg1yxwfIv5LIb3mGpEzHmYNUsQarCZ5rrNpm+QoT33OA
 Kyi5ZIEb0Kq7xzQYwK9K7SUlTE4uPbP8l5TCdQ/VS89Bdw42ljZG4FIqN04XZB1my4rs4YQmPbg
 810WNDkG09Q==
X-Gm-Gg: Acq92OFS/mwS5DNnTuz7rANv8G01vOIQ1/vGMKUg/v4u9iJu8KioORxB5aje5v0DjIX
 IGwJVjFZTS7oTqYQFBGonUuwFFO0b7Y2A4Iwi0MKmg8mGaK6OX1eGjKQztjGXg9ydnQNErUOF7f
 Rg+u/90Xp0qnXZheP5U1MQKktFqa7lGsmA2je+pXsvee9LHACufYk5DsVCNCUMUKnl7pgQfmtp4
 PDC0z6JNA/BiTP3k2bt0y79mSuqyCjOIhVs70CHYaq3e9BLW6b/Lw3Dfyl6Hh06ILnWqajFii1H
 adLNlHwQnTePJA0aD4t1D0yz5tYDHnf+4OFrmKIYlY+IoY69/W+wJ+F1Clla6cZILDlw1z1hup8
 ASoBLZRVQQyAIYfcNyy3DNz+nyA03ES9pAOmCD6GT3SCmObJfvMAC2PklTN79IXHd6mwnGrlC/Y
 i6gjMLdDnK/Wya/RUa2Bnn0302xeexIq27CFJjetQ9T/MkXv75j5rzXnGnG6Q/9IJCHQ==
X-Received: by 2002:a05:600c:3b9f:b0:48d:35e:82cb with SMTP id
 5b1f17b1804b1-490428e93d6mr403771605e9.28.1779877981550; 
 Wed, 27 May 2026 03:33:01 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb549e79sm5447872f8f.7.2026.05.27.03.33.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:33:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max' CPU
 type
Date: Wed, 27 May 2026 12:30:25 +0200
Message-ID: <20260527103037.4461-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Commit 676624d757a ("target/arm/tcg: refine cache descriptions
with a wrapper") added the make_ccsidr() helper. Use it. Besides
being simpler to review, it also makes arm_max_initfn() more in
line which aarch64_a57_initfn(), which it almost duplicates.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-11-philmd@linaro.org>
---
 target/arm/tcg/cpu32.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 919ed8a6cf8..cf643ce43b1 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
@@ -756,9 +757,12 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR6, 0);
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
-    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
+    /* 32KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    /* 48KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    /* 2048KB L2 cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 
     aa32_max_features(cpu);
-- 
2.53.0


