Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F209C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdSn-0007bo-V2; Fri, 04 Jul 2025 06:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSl-0007WN-69
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdSh-0006t6-Qz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:16:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso8375125e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624164; x=1752228964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hGQxE/nkF7+o6yQ+EIWRMLcUDg7UbkORknvxDV9Va8=;
 b=F/mZ66zqhc0EEWHsp2EMrMVqdcx0KVkOkiTIiHGrQeFpP3s2KbDuqPg7rqswjRrO9l
 dUh92ltHAmBG1qn/wh9veTk6c+2XCbnhwnaUk1+KDjHfkjWgekErj7+GBVxU4NFbY3jh
 kqrhLaCOPKHmbxA9/fZZvMOxxdeMp5x8tPc0igOrpFnpKMBzhC8pGpzF6d7cMjCFeGOs
 nHXS9+6qz1c+I3hwtwQbSj/mP5qCmrqMeUC8BuexXUef3TUEj0w1cwuAnM9J1FVkgaqm
 cYFydAm0WqQpWc4L0cjUOcPNVcwLZsU7gH/OfYItTw5SUMvST48QkAw5jcCEziGH7Y0n
 h4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624164; x=1752228964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hGQxE/nkF7+o6yQ+EIWRMLcUDg7UbkORknvxDV9Va8=;
 b=dXSjTt0TFj89JcyjGtnet0El9exSxl1c7eusxZmFUuAzBq0ijFViABdT4dw931qldj
 z32CRBtbucx8pHKv/SBz9gWAftdSJlVBUUrgO6ij7nd8t4IwU41lM2Fe2yEK7UvckSVc
 el08YjSMj1QeHC03Es+up1VO/I7SDc3v9bIexj14WVYmB8vevNTl0+dYumDgp3XoZuZD
 27vP/odpmRpc5x15cOv2C6aTsU6hqAR1wHTDpYF9H3nZxrhelG2/vJzCyp29lXIgWFh8
 +ixPEdUoSdXUnVGsIY0xTAZpb8JMv4qQnMmVEuOAl58FIKKTUWy0nuEVPWunjLdrUTsL
 Cg4A==
X-Gm-Message-State: AOJu0YxHvOqkgOl1YIirRynYkPoZhCvjQyxxNihRA1cwA444OqRjsKkC
 D1IyiP4cNQ3QGjfn1NGuocgzvvOF0fFFBj4SmpLQrXv8cHRhubtwrbnVOvkL43c3CZL72Fq4kRw
 X8EqI/jA=
X-Gm-Gg: ASbGncuJtnotmEJbN+hO9ISVUGMJJBNhBy/3ju049LBTJwZGD1fVFpWrV+VcHpvXA+b
 c3SIUEmSKjKWbnnBB3wMwZgbUUDQgq2gHX8OzPhu2e8lLU17oOAPF3/RQCmXyGfbo8TYy6WiXtI
 7d5WzVAiU06BOW8GL5mxSRZb8nDJO0QA7Tg/88F+zzheksmwCnhh/5si+5VD4BRN2XSbwoo+cad
 PFVMag5meuv37XSkO8RXUwEVbSORPaMS4Ev2KrtKAmAWBP8Pv5OrHYbyLmn3nMKM26oYKJu/2yP
 WqkvwG1X0fFPpzRtCTUah7bxZQstTlLKPHouwNAdQLJX0xFRs302QF2jjw1asqrh+TUFgaVbPWS
 epcGJNkNnuxFbxuIbwkR+O02oav7a+IJzrK3F
X-Google-Smtp-Source: AGHT+IFgO5yTQmiiu8p9KK4SH12rMRpiUyADuCIMwW+DkrTt+rZ4yzNhETPxk0kkcjyXhg4EoNZYxQ==
X-Received: by 2002:a05:600c:4689:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-454b819befdmr1541635e9.0.1751624163869; 
 Fri, 04 Jul 2025 03:16:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b966cbsm2071216f8f.49.2025.07.04.03.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:16:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/31] accel/whpx: Expose whpx_enabled() to common code
Date: Fri,  4 Jul 2025 12:14:20 +0200
Message-ID: <20250704101433.8813-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently whpx_enabled() is restricted to target-specific code.
By defining CONFIG_WHPX_IS_POSSIBLE we allow its use anywhere.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-26-philmd@linaro.org>
---
 MAINTAINERS                 |  1 +
 include/system/whpx.h       | 27 ++++++++++++++-------------
 accel/stubs/whpx-stub.c     | 12 ++++++++++++
 target/i386/whpx/whpx-all.c |  7 +------
 accel/stubs/meson.build     |  1 +
 5 files changed, 29 insertions(+), 19 deletions(-)
 create mode 100644 accel/stubs/whpx-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c73468b2422..0fd8b2a4e61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -540,6 +540,7 @@ WHPX CPUs
 M: Sunil Muthuswamy <sunilmut@microsoft.com>
 S: Supported
 F: target/i386/whpx/
+F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 
 X86 Instruction Emulator
diff --git a/include/system/whpx.h b/include/system/whpx.h
index 00ff409b682..00f6a3e5236 100644
--- a/include/system/whpx.h
+++ b/include/system/whpx.h
@@ -16,19 +16,20 @@
 #define QEMU_WHPX_H
 
 #ifdef COMPILING_PER_TARGET
-
-#ifdef CONFIG_WHPX
-
-int whpx_enabled(void);
-bool whpx_apic_in_platform(void);
-
-#else /* CONFIG_WHPX */
-
-#define whpx_enabled() (0)
-#define whpx_apic_in_platform() (0)
-
-#endif /* CONFIG_WHPX */
-
+# ifdef CONFIG_WHPX
+#  define CONFIG_WHPX_IS_POSSIBLE
+# endif /* !CONFIG_WHPX */
+#else
+# define CONFIG_WHPX_IS_POSSIBLE
 #endif /* COMPILING_PER_TARGET */
 
+#ifdef CONFIG_WHPX_IS_POSSIBLE
+extern bool whpx_allowed;
+#define whpx_enabled() (whpx_allowed)
+bool whpx_apic_in_platform(void);
+#else /* !CONFIG_WHPX_IS_POSSIBLE */
+#define whpx_enabled() 0
+#define whpx_apic_in_platform() (0)
+#endif /* !CONFIG_WHPX_IS_POSSIBLE */
+
 #endif /* QEMU_WHPX_H */
diff --git a/accel/stubs/whpx-stub.c b/accel/stubs/whpx-stub.c
new file mode 100644
index 00000000000..c564c89fd0b
--- /dev/null
+++ b/accel/stubs/whpx-stub.c
@@ -0,0 +1,12 @@
+/*
+ * WHPX stubs for QEMU
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/whpx.h"
+
+bool whpx_allowed;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 5001afad3a7..94fd5fc7849 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -242,7 +242,7 @@ struct AccelCPUState {
     WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
 };
 
-static bool whpx_allowed;
+bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform, hWinHvEmulation;
 static uint32_t max_vcpu_index;
@@ -2688,11 +2688,6 @@ error:
     return ret;
 }
 
-int whpx_enabled(void)
-{
-    return whpx_allowed;
-}
-
 bool whpx_apic_in_platform(void) {
     return whpx_global.apic_in_platform;
 }
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index 4c34287215f..9dfc4f9ddaf 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,5 +4,6 @@ system_stubs_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_TCG', if_false: files('tcg-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_HVF', if_false: files('hvf-stub.c'))
 system_stubs_ss.add(when: 'CONFIG_NVMM', if_false: files('nvmm-stub.c'))
+system_stubs_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
 
 specific_ss.add_all(when: ['CONFIG_SYSTEM_ONLY'], if_true: system_stubs_ss)
-- 
2.49.0


