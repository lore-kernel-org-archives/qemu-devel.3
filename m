Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD80DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag3y-00048V-Fo; Thu, 15 Feb 2024 13:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3J-00032w-J6
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:45 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3F-0002Z0-Gs
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4121aa78aa2so6120985e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020096; x=1708624896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOBFGHotMZNhpz8RBtUCz5soAiP+H2PcJ6i2ywIfEBI=;
 b=vSVy1YA5FttZ2OLuHH3kNoZAoH8H9anDU+amRUzZhfeS87/wYkNTd3EO/CjZjX6Prs
 ANG6JprVzeaMAdGhpO72xCMf370ZyNRbRLH+XMfLyoqJNFIHmL7DbpnS4qzDVE80MRI8
 wjyAAXna7MzKt8ukj9dcma6KIAhwmQPCU8q70fpYaFmw9YdhfVkXxjzJSwUVVYJUGiH9
 GhD69BuWdRoBHuQYZlzCyOpxnZpV8TMsPZolKDA1jf64EEEAeXAoIEu6AT0LNzSAyYdi
 npwyAlV+mH+R7D2QvtHYJY9ly96OvXLsLn3VNbsiblL1yWRn8rrynwnHxloM7W5+J+nk
 gI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020096; x=1708624896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOBFGHotMZNhpz8RBtUCz5soAiP+H2PcJ6i2ywIfEBI=;
 b=IcE4reNWTt65uRsK8FnigjrozGgJ2haOa7TnNyBPmJ0hDRLZlJ0g0Fc/ZuX4+4QXiU
 TFL5l0lQVKhAXPl7r1MCFyGAGOMBF4j6OFdrHuP4G7hqVsWezaAvyND+pokKqBY4L2OQ
 3H2dGGIy5I6GG02RosGqjk2lIGWecDYzlxYyBhrn3b2hZsxFxl5JZQFVFA7sTSHSE/BV
 sOi6SzJderwu57S5JmFlD0gfsOhpx8jhwzc+PfniPivS+yT8jMjDFsvl4vxHqSJPD9jm
 eOB+4h3ikXyO6GuG6PvU0G09k9zgG/RRAGf6fVpGnFFC8i1A7cn8YVLPp0kJ0CJJ8MYt
 AZcw==
X-Gm-Message-State: AOJu0YyJWkWZxnZjN5ZOBfjAxMU2lOxHlZUbHWtVPFwvi+QOHOwuAFnL
 ZWFBmjfKiBo7HdzGEJ+HHte/9EeuRPlsrG9qOer8UfE5wHmVuoG2jh1JWUJE0vbdRBwE2/oxfS/
 lVdU=
X-Google-Smtp-Source: AGHT+IEX1q7FcMAyK+Gjt7ue+YbxE7I+QLyWxxt4qJbXz0jxLCJo6jfcSw5NTw5tX5mCv6mGvVzJlw==
X-Received: by 2002:a05:600c:198f:b0:411:f8f8:a0b1 with SMTP id
 t15-20020a05600c198f00b00411f8f8a0b1mr2001688wmq.2.1708020095497; 
 Thu, 15 Feb 2024 10:01:35 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a05600003cb00b0033d07edbaa6sm2087249wrg.110.2024.02.15.10.01.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 33/56] hw/sparc/grlib: split out the headers for each
 peripherals
Date: Thu, 15 Feb 2024 18:57:27 +0100
Message-ID: <20240215175752.82828-34-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Clément Chigot <chigot@adacore.com>

Split out the headers for each peripherals and move them in their
right hardware directory.

Update Copyright and add SPDX-License-Identifier at the same time.

Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240131085047.18458-2-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/grlib_uart.h                  | 32 +++++++++++++++++++
 .../hw/{sparc/grlib.h => intc/grlib_irqmp.h}  | 16 ++++------
 include/hw/timer/grlib_gptimer.h              | 32 +++++++++++++++++++
 hw/char/grlib_apbuart.c                       |  6 ++--
 hw/intc/grlib_irqmp.c                         |  6 ++--
 hw/sparc/leon3.c                              |  8 +++--
 hw/timer/grlib_gptimer.c                      |  6 ++--
 7 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/char/grlib_uart.h
 rename include/hw/{sparc/grlib.h => intc/grlib_irqmp.h} (86%)
 create mode 100644 include/hw/timer/grlib_gptimer.h

diff --git a/include/hw/char/grlib_uart.h b/include/hw/char/grlib_uart.h
new file mode 100644
index 0000000000..7496f8fd5e
--- /dev/null
+++ b/include/hw/char/grlib_uart.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB UART
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_UART_H
+#define GRLIB_UART_H
+
+#define TYPE_GRLIB_APB_UART "grlib-apbuart"
+
+#endif
diff --git a/include/hw/sparc/grlib.h b/include/hw/intc/grlib_irqmp.h
similarity index 86%
rename from include/hw/sparc/grlib.h
rename to include/hw/intc/grlib_irqmp.h
index ef1946c7f8..c5a90cbb3e 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/intc/grlib_irqmp.h
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB Components
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -22,8 +24,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef GRLIB_H
-#define GRLIB_H
+#ifndef GRLIB_IRQMP_H
+#define GRLIB_IRQMP_H
 
 #include "hw/sysbus.h"
 
@@ -36,10 +38,4 @@
 
 void grlib_irqmp_ack(DeviceState *dev, int intno);
 
-/* GPTimer */
-#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
-
-/* APB UART */
-#define TYPE_GRLIB_APB_UART "grlib-apbuart"
-
-#endif /* GRLIB_H */
+#endif /* GRLIB_IRQMP_H */
diff --git a/include/hw/timer/grlib_gptimer.h b/include/hw/timer/grlib_gptimer.h
new file mode 100644
index 0000000000..e56f1b8bf3
--- /dev/null
+++ b/include/hw/timer/grlib_gptimer.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU GRLIB GPTimer
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2024 AdaCore
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef GRLIB_GPTIMER_H
+#define GRLIB_GPTIMER_H
+
+#define TYPE_GRLIB_GPTIMER "grlib-gptimer"
+
+#endif
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 82ff40a530..515b65bc07 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB APB UART Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -26,7 +28,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
-#include "hw/sparc/grlib.h"
+#include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index 3bfe2544b7..11eef62457 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -3,7 +3,9 @@
  *
  * (Multiprocessor and extended interrupt not supported)
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -29,7 +31,7 @@
 #include "hw/sysbus.h"
 
 #include "hw/qdev-properties.h"
-#include "hw/sparc/grlib.h"
+#include "hw/intc/grlib_irqmp.h"
 
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index fa4fbe4b30..e80b9410d4 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -1,7 +1,9 @@
 /*
  * QEMU Leon3 System Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -40,7 +42,9 @@
 #include "elf.h"
 #include "trace.h"
 
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
+#include "hw/char/grlib_uart.h"
+#include "hw/intc/grlib_irqmp.h"
 #include "hw/misc/grlib_ahb_apb_pnp.h"
 
 /* Default system clock.  */
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 5c4923c1e0..4990885451 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -1,7 +1,9 @@
 /*
  * QEMU GRLIB GPTimer Emulator
  *
- * Copyright (c) 2010-2019 AdaCore
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2010-2024 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/sparc/grlib.h"
+#include "hw/timer/grlib_gptimer.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
-- 
2.41.0


