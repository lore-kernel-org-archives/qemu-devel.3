Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F626D6ACC4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzE-0004lg-NZ; Wed, 27 Nov 2024 07:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGz0-0004dQ-Uj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:33 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyy-0008NI-FK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:26 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38242abf421so4453221f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709842; x=1733314642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBB0CLhlW2tPrLDje8K+xxZrR9BoLbGaTyc8yxD5eis=;
 b=ekfz73OnZ1zAv5WMLVJRgf7I15usIUT9am531a3vipJSljnu9ZSd4UNxUsakibxI/W
 bB67nWeYLGJKTWUVV5Ez9+F+bSNcx4b9JNcQApw8caVrT/VNnT5T+l/sUIIFnk5qHeEO
 TeuyrW/LiePScfty6QpjYnMl5hOA/Pb823dmnxxps4W/ns++IIPdI2vveoC5H++LQ9j3
 0twXXzX/OZAQs7oCCvClOSkKMI4CQbCe+CQyOHatVAkkefgyWgsPaFgwaHUE4KLIa748
 BGCvuidXsTKo1h9f+j3Wu4YggWMG/BOUcL1B0phXpHGkIrOB4xzL6Wvgu3uowR3Rpshw
 DHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709842; x=1733314642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBB0CLhlW2tPrLDje8K+xxZrR9BoLbGaTyc8yxD5eis=;
 b=ok5mevwBXgTQvaD28Y5Q3rqUzX7IP0Cqa7/vy3X7FG5xRy07n6tLv9yhsRI2hr23w9
 g2dB4T2QEvKVnHoRmZUxgTqxRw0Y3AhIKuBC008yBvB4Yi70dgbB+5mEDHlktd8F8HAL
 rALbdFbjXqzWtV7QR5/HzbhRvoF5e7OZXG7xuqDiAROrA5gM4Kq6crKODYF9Rjq2TK+e
 rRgXpNftnNDy7CBLqbr8ZtVcvJ3dbblXP8r7lZM4iA85RMUUgpQnlFqvR21BkWo17XxL
 wanz9iDf9ugB1dKZF3FTZlnf/KHfIH6VcvUhP3eK1TRpMwC/zUgPs8KcvrfmNVgUfvkx
 Td4A==
X-Gm-Message-State: AOJu0Yx8XoJV9Y/muE3snDl5SnXa2uqt6eNlA5CI0meo+ki+fXcBGmuV
 0tcvwCMaDAKjwq6doWkcygOodC8Yqd2+6PVXg+SY3ZCYc+/ghLfHTiNu96zHTwBdd8MH+6oM7A2
 t
X-Gm-Gg: ASbGncuosQubcIP8C36dW0MlqNG0P1jKgvHSRprYA/+0pUCjhxPfC5zigdiUVD6aSHS
 FPppQjXArfFxR4v3rqGCHDGqdlL6/WvfwjiJ1cZjzFIchLrhm/j8xG7g+iU+z3Bp1RfA553iaDH
 jvWi/EUG1yHaf5LgAMbc57tTgHUeB852uGLSHwZexLmyktLpKmbd/+pmhvBK16rlrYGBGeGTP2M
 n+41XeZFruPORCO9cZpvXkJTEDusbg3RetkXG2VFiASdDyQqst7GgGNt6EYNnSYxzT22f05woCL
 Ax5pvpCaXWD9Z/4TTf+SIuNtzRzplpfwyUm5+bTOWNY=
X-Google-Smtp-Source: AGHT+IGlJcyJloS/k80XIS4nRahMikb9xI88w5GQVp7kXTMsTD2lTuLnuM8CvjznA+RnkFudC4O3Aw==
X-Received: by 2002:a05:6000:4188:b0:382:49f3:4f8e with SMTP id
 ffacd0b85a97d-385c6ebcdd1mr1351182f8f.18.1732709842163; 
 Wed, 27 Nov 2024 04:17:22 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e33afsm19165815e9.36.2024.11.27.04.17.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 4/6] include: Expose QemuArch in 'qemu/arch_id.h'
Date: Wed, 27 Nov 2024 13:16:56 +0100
Message-ID: <20241127121658.88966-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

While QEMU architecture bitmask values are only used by
system emulation code, they can be used in generic code
like TCG accelerator.

Move the declarations to "qemu/arch_id.h" and add the
QemuArch type definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/arch_id.h     | 28 ++++++++++++++++++++++++++++
 include/sysemu/arch_init.h | 28 +++-------------------------
 2 files changed, 31 insertions(+), 25 deletions(-)
 create mode 100644 include/qemu/arch_id.h

diff --git a/include/qemu/arch_id.h b/include/qemu/arch_id.h
new file mode 100644
index 00000000000..e3e8cf5e724
--- /dev/null
+++ b/include/qemu/arch_id.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_ARCH_ID_H
+#define QEMU_ARCH_ID_H
+
+typedef enum QemuArch { /* FIXME this is not an enum */
+    QEMU_ARCH_ALL = -1,
+    QEMU_ARCH_ALPHA = (1 << 0),
+    QEMU_ARCH_ARM = (1 << 1),
+    QEMU_ARCH_I386 = (1 << 3),
+    QEMU_ARCH_M68K = (1 << 4),
+    QEMU_ARCH_MICROBLAZE = (1 << 6),
+    QEMU_ARCH_MIPS = (1 << 7),
+    QEMU_ARCH_PPC = (1 << 8),
+    QEMU_ARCH_S390X = (1 << 9),
+    QEMU_ARCH_SH4 = (1 << 10),
+    QEMU_ARCH_SPARC = (1 << 11),
+    QEMU_ARCH_XTENSA = (1 << 12),
+    QEMU_ARCH_OPENRISC = (1 << 13),
+    QEMU_ARCH_TRICORE = (1 << 16),
+    QEMU_ARCH_HPPA = (1 << 18),
+    QEMU_ARCH_RISCV = (1 << 19),
+    QEMU_ARCH_RX = (1 << 20),
+    QEMU_ARCH_AVR = (1 << 21),
+    QEMU_ARCH_HEXAGON = (1 << 22),
+    QEMU_ARCH_LOONGARCH = (1 << 23),
+} QemuArch;
+
+#endif
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 5b1c1026f3a..01106de5bcb 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -1,29 +1,7 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+#ifndef SYSEMU_ARCH_INIT_H
+#define SYSEMU_ARCH_INIT_H
 
-
-enum {
-    QEMU_ARCH_ALL = -1,
-    QEMU_ARCH_ALPHA = (1 << 0),
-    QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_I386 = (1 << 3),
-    QEMU_ARCH_M68K = (1 << 4),
-    QEMU_ARCH_MICROBLAZE = (1 << 6),
-    QEMU_ARCH_MIPS = (1 << 7),
-    QEMU_ARCH_PPC = (1 << 8),
-    QEMU_ARCH_S390X = (1 << 9),
-    QEMU_ARCH_SH4 = (1 << 10),
-    QEMU_ARCH_SPARC = (1 << 11),
-    QEMU_ARCH_XTENSA = (1 << 12),
-    QEMU_ARCH_OPENRISC = (1 << 13),
-    QEMU_ARCH_TRICORE = (1 << 16),
-    QEMU_ARCH_HPPA = (1 << 18),
-    QEMU_ARCH_RISCV = (1 << 19),
-    QEMU_ARCH_RX = (1 << 20),
-    QEMU_ARCH_AVR = (1 << 21),
-    QEMU_ARCH_HEXAGON = (1 << 22),
-    QEMU_ARCH_LOONGARCH = (1 << 23),
-};
+#include "qemu/arch_id.h"
 
 extern const uint32_t arch_type;
 
-- 
2.45.2


