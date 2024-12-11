Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEACE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxN-0006uB-OB; Wed, 11 Dec 2024 09:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxL-0006tT-KB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:51 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxK-0003sc-3h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so483708f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928288; x=1734533088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtTkwTKI52bcxg/lJzvBSIA6PD09skuET2+JQoRaIc4=;
 b=eR+VPz2y0lKC1kb6T2eM9G8BPt0evEq/KC2FMp2WJmoFV3Ck77b3UefbYOqdidglfh
 OGp1+1zteQ5dYhcGqZX5xJObM6VfEGc7plhqd8yYIq/zoLld060t3AgO2JKfetpCDReU
 N4cXvwLEnM2kXaRo3JN+7WYOHs917xGeyOCZhN1akWEx4apzwU4sV4Xi1ynRvj4R8UUU
 56g7DzzhJ+GLPFDPy4O/vTCwjWJq3/u/XkjApdp/tY3Y/r0VmBmvaOzZSAgaaV5fYW1S
 9cqRD76DKyCZ/WLj2Kvi+tauNikakYGsFqSIuEZy81dAWSRNn/LxGJnh3T4iG0X71yRZ
 69LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928288; x=1734533088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtTkwTKI52bcxg/lJzvBSIA6PD09skuET2+JQoRaIc4=;
 b=Y8C2kS7aj99rykQ/qpRblg3Ac9kar5Txzdv1JSmUV5MzhVcZ+RKglYhesPmOZ9BQHP
 Sbkc2ZOQ4OXPqH/47lrE3ZVrf6vVnVb9869c5t4PMHTqTvjXCTYFfzRuqFdTfIl+8YL4
 JqKyAofYfskdmufqypdG/YXAKYgEmE4Li1UYeHkpV99nC84ywgyOelhj40jiXVBT/E11
 yA0dZErAwGhyUhpII9A5ljcP/PjHDkU04wjndzldmVPGaKQ62etRQqgCqtIHyxnSsvOK
 kEyPuUKJ13AcHePx+AcK+sPLfBZnZD6s6yuhs/i8duDaJeaxouAPxpauzA6MXswZsZWo
 zwbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIT0S18QPNvqM5BCRlrnSm8LJ8qkLiAJEFgAKLF1TWlJJG0iBtTKzQ8Jsz+kp0oOqVjE46ZNBdo7C4@nongnu.org
X-Gm-Message-State: AOJu0YzEQ0p5Lh+H1ak9XrQdSYzt//+gAPPDgSBG5AybcTxDAOkTLd/y
 6IMGIsJHIog/4UDxVqMHrA4Bm6exRppg50gwH3QLQt9CKvLuGgz8fPPkeVP5BYI=
X-Gm-Gg: ASbGncs3/VAJ+2fBjvibPaDGLonHjiU5EglsFpe4ccVP1rZYV4ReoLlyxt4tzD+BPGF
 zb7N+1oi4pcAbHSjWiydHgSJyqg0am4/+eoqjVcl2nA8Y644BYf6bdMpZrvbvReEpSdozmXKpof
 2elVBTL/RgTNf5/VnuggnX0YPmGf+6SMfUKn6GXZiMLNN3JjD7mVZYV+/XTpdMeXR1DhVZyymiG
 OfnIHIltLt91J8HTG48ATU2kV5d9AU/EZn/qiq3qIwOI7Ldc2VU2UtDDHLa
X-Google-Smtp-Source: AGHT+IEc3+vF597N7ere9YiGlkmyldx4o90YrOiY4AxYeJr789FIgACB1I4kzwKdrHzsrTWV0IIKOg==
X-Received: by 2002:a05:6000:186b:b0:386:3672:73e7 with SMTP id
 ffacd0b85a97d-3864de9e81fmr2504639f8f.9.1733928288468; 
 Wed, 11 Dec 2024 06:44:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] tests/tcg/aarch64: add system test for FEAT_XS
Date: Wed, 11 Dec 2024 14:44:40 +0000
Message-Id: <20241211144440.2700268-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add system test to make sure FEAT_XS is enabled for max cpu emulation
and that QEMU doesn't crash when encountering an NXS instruction
variant.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
[PMM: In ISAR field test, mask with 0xf, not 0xff; use < rather
 than an equality test to follow the standard ID register field
 check guidelines]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/system/feat-xs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tests/tcg/aarch64/system/feat-xs.c

diff --git a/tests/tcg/aarch64/system/feat-xs.c b/tests/tcg/aarch64/system/feat-xs.c
new file mode 100644
index 00000000000..f310fc837e0
--- /dev/null
+++ b/tests/tcg/aarch64/system/feat-xs.c
@@ -0,0 +1,27 @@
+/*
+ * FEAT_XS Test
+ *
+ * Copyright (c) 2024 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <minilib.h>
+#include <stdint.h>
+
+int main(void)
+{
+    uint64_t isar1;
+
+    asm volatile ("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    if (((isar1 >> 56) & 0xf) < 1) {
+        ml_printf("FEAT_XS not supported by CPU");
+        return 1;
+    }
+    /* VMALLE1NXS */
+    asm volatile (".inst 0xd508971f");
+    /* VMALLE1OSNXS */
+    asm volatile (".inst 0xd508911f");
+
+    return 0;
+}
-- 
2.34.1


