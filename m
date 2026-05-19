Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39678CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLjU-0001H9-Ij; Tue, 19 May 2026 10:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLj0-0000Tw-Km
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLiy-0007vJ-O7
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:47:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45e7c636e74so1640102f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202031; x=1779806831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVBWmui2gRqhhcBVAajrDH3fSaJghOrYunK4qpZkBCg=;
 b=X3GlQ4s3TG0r8N5LeU9FTTl+RzCy2yAseyMlngn+a1faAhn4espCssY/scTNXXbNdg
 VYTuffkcNag93s4jonIp9v86xW9dkRgNJBIPfc1x3E/IgToXLdR5OpbqE5ABtBLX3fE0
 RY0KZPVwfvMst9MdNkkeXgsSO9Lfb2xGC9dGsvgx7mXsytJ4WnTaVY5++BqdBQ0Ge9wn
 JyDe2214UOU70dO6pB7PYA5GRZcWTL+szYvHl/6ydVqhCYW+79CKOJ2iCkCYwtJmNDaa
 LPNU+N1pmtUfmuI7CAZhOcHIfo2fIrw3EzmrTfZEipduWvKN2BykF/QWTe5btr3zzckZ
 v/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202031; x=1779806831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVBWmui2gRqhhcBVAajrDH3fSaJghOrYunK4qpZkBCg=;
 b=mpkIjHKz3lQOUfZlO0GwOUcuJscSatia+rBIH70MSRMX2m5S+p5T4/5UG2aJqBIeE5
 ccrQ8KtiAE6mmqI/k2jS/4HYNbqhwSFJRLGuj8Wwt7d0rsn8uqxh2BCRZ+eNHKPhKk0G
 Ge1sRDNuqPsfUgkKKZiuLmlFCKNqDv6O6aAPjZOClJCpmwEao8LAP/DRe29L4aUaH1LB
 PgCml26oqDaIUG6wpKOj+sB3PgbiqRlmy5KNWePx0D6s1USbigrgUsRrkhTHeOpysbkb
 Ckj/wGNLS9CS2fQRedhOZdMajHJVVrgN1eJy6/05pGH1jM+DOxaJdDZkeuj9YUgD9Rv2
 j99Q==
X-Gm-Message-State: AOJu0YwKBBf5Z9EonaRXf8QQ3Z8a5nw+VogkJpHXwqU/cyXvxvWt3xg4
 iYrPkJ0mKrHrzivXN9L++eKHn/0bvUx6/M8ErQ4xiy7hC3jdJRLPUooji5UkKaoaBtHh7//K+yO
 G+xHEa14=
X-Gm-Gg: Acq92OESeoFMlvNmHYuuTlAYrbuT1U70XhuDw3qBbqa3LmR3WI5h04DdQwNptvlHdZ9
 JF7NtwptB2Mh/E8SKtF1Ot1qIYIgCBkC/SQXTs2XxBqYgUA9UpoQi73lljt1TCpXzUd+Ca+V+Ap
 ar3exsQ/oYQ7w7SpOPBNVVd+h74lPmZAM6h+jzRI8RHe+xW+VrZXMWQCr0QHWsHdfNXkiHhUP9c
 X0pRwdZrq4OjI/Z/tj3TGMHMbzC8POqFS6KDCxitw5R7o7oyVgTjEOvVKTHbTg18lOXKDvI/+hT
 fXJLv7WJAq9THqDIReNmCyq56w1UhGfPPHD3k5vGYVj/PojFpgC2uO8Av0qbrBWB3NbbfypmohA
 kyT87QaK9of9ClQOowavT6ALtPioxEpiym4q9tatdhih6fhAYZrkUKUh+sM8c9Fk9tS2qqQOVYn
 5wH9BQaiR/zyeelUmYcpl6sMTQt4l5C1B+IInEDtKsT+bDLFW9PF7me1Grzuq2IJTozt8+e80xK
 vKap+bPnVk=
X-Received: by 2002:a05:6000:4011:b0:441:1fa5:457c with SMTP id
 ffacd0b85a97d-45e5c5a5d38mr30735216f8f.5.1779202030772; 
 Tue, 19 May 2026 07:47:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm46645952f8f.8.2026.05.19.07.47.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:47:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 11/18] target/arm: Use make_ccsidr(LEGACY) in 32 bit 'max'
 CPU type
Date: Tue, 19 May 2026 16:45:46 +0200
Message-ID: <20260519144553.91483-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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


