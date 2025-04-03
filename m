Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BD3C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJi-0000dV-IX; Thu, 03 Apr 2025 19:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJg-0000dI-W9
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJe-0000RY-PS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1243767f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724185; x=1744328985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvXkZVqpNEcQWld4uLHZD0xKtvIdCPqnGqYsj+ky1fo=;
 b=slI8isWncJywNxK8y4BI2RjTd5p0xiiXIFoAZnpJ1Vp3Qk7+ZnhLwBSCkWQKapifUY
 hrYOg1ZPXPtMVwtI4+E/Rn92MfFUwbu+qMp2EZbqQLpeC7KpOHBlKOAeu2rDPu8ldztZ
 mSuZ9QrkkLc/uwDrPlO7ua0yIaicta6VK+2R3Q1g+TAcQ9zWNmMLKXSYJndRxs+ueGVS
 IgW1x7rL5s+9+MIdlEFuzV7xXv+7MLTNVh7yvQm8yJ78c6jS0DPH7d1qvcJF/LwEsSPl
 Pe6rn7Vk2HYFTAFlG2IUvGYPBFb/h6ZgxLwVycd39PDLa0irCWX5z2A8bFNnTTLjRjUT
 6MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724185; x=1744328985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvXkZVqpNEcQWld4uLHZD0xKtvIdCPqnGqYsj+ky1fo=;
 b=QjsvSfNf6vDA2LJziSMc+CmedgIBqz9V1pJx9pDRRv8JoWV6j/o0kOtZs+DGX1rWWv
 mEqYdLFKj+zbHR9oCxly9zm9o8HsQhzHsOP+4owqJEunHZt2JcMUFkdCBiNuxNgSS9y2
 MmVtj0zkdoWxq1EBZVGBLZxiEaq9Ch5hC0hQKDK1v1yVto5FL/ktOZFyeQMjBMqo3UhX
 R63wxSyGLZUCwqbKEHQVhdhc7j4U9UT+nOXsbwN3DPRSY1q48nWzBJH0fl7nU9lKoY8C
 0uEp2ZYirmlHjcQRQ7Xq+K3ENgw55IwP5tkG4QS28N2sca9L0nJVHuDkV4xlMSrZOVHC
 mw4A==
X-Gm-Message-State: AOJu0YwaOoaHSHHy87ZVeP34dHpWc0cEa3TxCYhUkQpibX6V8XwAJSq5
 DiD1SnjYEuPpqik0tTQuwnvIhak/QEs+2I68RfaId0zSdtiJfuNYwHB4pdVk13YR274L6/blSMS
 x
X-Gm-Gg: ASbGnctQ9veEWgiTd7EMxlfXurvYDgkUKKabY0a9u6+5xXv6M48S0Q9LLUENn1TiqVr
 57ZO9K+nwfKx1ov0kDJokfV77nkyXY1sPttGd42PO0qlQ2WJrB+TZnP5y5KOwg9EHdUnGAPga2S
 rj/bqkaGtOEkvwFpsKxl+6L8VGfC+fm3yeZE3D9/y1aWxewnkTmpy0jlfKwURZm0WhLjf1lZgvd
 wllJM5gE2PivPcsbHHPGZQDcZvQCdqS/kNHVzqEf+M1ko7yeGQAAAK5y3mixUWFqMJ123vmSzPU
 CmunsBfKjn499c4b/Oi4JSFFggPfLsC1ZJMSXOtz/SZ1Z9yHlj6OwhePGTmB1WasRq1AaQMVvBx
 89rZfnAIuOPzFQfnsmrw=
X-Google-Smtp-Source: AGHT+IGG1bpNcdwMMI9/IGjSjrA5MHp+h6IIbhprKWNSzJT9VI1jHpT4EYZa7e3tm4/PDAdtnDlNjQ==
X-Received: by 2002:a05:6000:1848:b0:39c:16a0:fef4 with SMTP id
 ffacd0b85a97d-39cba9337ffmr954721f8f.24.1743724184660; 
 Thu, 03 Apr 2025 16:49:44 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226cf6sm2917081f8f.87.2025.04.03.16.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 04/19] qemu: Convert target_words_bigendian() to
 TargetInfo API
Date: Fri,  4 Apr 2025 01:48:59 +0200
Message-ID: <20250403234914.9154-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/tswap.h            | 13 +------------
 include/qemu/target_info-impl.h |  4 ++++
 include/qemu/target_info.h      | 11 +++++++++++
 cpu-target.c                    |  6 ------
 hw/core/cpu-system.c            |  2 +-
 hw/display/vga.c                |  2 +-
 hw/virtio/virtio.c              |  2 +-
 system/qtest.c                  |  1 +
 target_info-stub.c              |  1 +
 target_info.c                   |  5 +++++
 10 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 84060a49994..415781b2bcc 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -9,18 +9,7 @@
 #define TSWAP_H
 
 #include "qemu/bswap.h"
-
-/**
- * target_words_bigendian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Common code should normally never need to know about the
- * endianness of the target, so please do *not* use this function unless you
- * know very well what you are doing!
- */
-bool target_words_bigendian(void);
-#ifdef COMPILING_PER_TARGET
-#define target_words_bigendian()  TARGET_BIG_ENDIAN
-#endif
+#include "qemu/target_info.h"
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index 0cec211e362..14566e4a913 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -10,6 +10,7 @@
 #define QEMU_TARGET_INFO_IMPL_H
 
 #include "qemu/target_info.h"
+#include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
 
 struct BinaryTargetInfo {
@@ -23,6 +24,9 @@ struct BinaryTargetInfo {
     /* related to TARGET_ARCH definition */
     SysEmuTarget system_arch;
 
+    /* related to TARGET_BIG_ENDIAN definition */
+    EndianMode endianness;
+
 };
 
 #endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index 6ca36dae8a3..e84f16d1034 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -21,4 +21,15 @@ const char *target_name(void);
 
 SysEmuTarget target_system_arch(void);
 
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise. Note that in target-specific code, you can use
+ * TARGET_BIG_ENDIAN directly instead. On the other hand, common
+ * code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very well
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 #endif
diff --git a/cpu-target.c b/cpu-target.c
index 3f82d3ea444..761c2d28645 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -159,9 +159,3 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
 #endif
     abort();
 }
-
-#undef target_words_bigendian
-bool target_words_bigendian(void)
-{
-    return TARGET_BIG_ENDIAN;
-}
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 82b68b8927d..32700c49b43 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,7 @@
 #include "exec/cputlb.h"
 #include "system/memory.h"
 #include "exec/tb-flush.h"
-#include "exec/tswap.h"
+#include "qemu/target_info.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index b01f67c65fb..1883e03d3d8 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "system/reset.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
+#include "qemu/target_info.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce374..4ef56c183b2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "exec/tswap.h"
+#include "qemu/target_info.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
diff --git a/system/qtest.c b/system/qtest.c
index 523a0479959..6146a7bfdc0 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
+#include "qemu/target_info.h"
 #include "qom/object_interfaces.h"
 
 #define MAX_IRQ 256
diff --git a/target_info-stub.c b/target_info-stub.c
index 46a240ac66a..c1a15f5cc12 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -15,6 +15,7 @@ static const BinaryTargetInfo target_info_stub = {
     .is_stub = true,
     .name = TARGET_NAME,
     .system_arch = -1,
+    .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 };
 
 const BinaryTargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index be4f19009b3..22796dda543 100644
--- a/target_info.c
+++ b/target_info.c
@@ -31,3 +31,8 @@ SysEmuTarget target_system_arch(void)
     }
     return system_arch;
 }
+
+bool target_words_bigendian(void)
+{
+    return target_info()->endianness == ENDIAN_MODE_BIG;
+}
-- 
2.47.1


