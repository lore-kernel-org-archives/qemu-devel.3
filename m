Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBAAC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGYA-00041F-27; Tue, 08 Jul 2025 18:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGG8-0001Ig-NC
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGG6-0003Nx-06
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:53:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-453647147c6so46495755e9.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011628; x=1752616428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7IgGHEeRKsG0dre7n+N4g7EyPm5kGW3Qo9EDGG86lSM=;
 b=vKdxD2lX7jUT9PuFe8dTvhnxcm5/i2F5FeRcLAu2IGEst5XqkIGROInKsB6wZX+6g0
 zWPkN5sGhuEZGaJXgFAj+coSGGgH/YFt+rDhLrWR5VhS+ht+KsUEjt3iGPqrBkecVw+U
 cWwqNTNxaRlYTAORUbB4SM4+zSkVGFNyjBpUKzEJMM7MB0u5clhU175KrS+Y48ZlivFb
 IPI+yyF6a+oiP+jRpG8ecSbWOogDL6C8Bbq+N0eM0K3wwm3fZbmyGM+uaa6LAYVlhHzz
 xur9qM7aZepRgS3+YuTpIEOAGEzLyxq+F4QOxURDLh5lAMNPxsKEdsyYj8TEYOTim9Ua
 IOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011628; x=1752616428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7IgGHEeRKsG0dre7n+N4g7EyPm5kGW3Qo9EDGG86lSM=;
 b=Hs7DKkd00epWZTE+zuPicsFlEKGMcedDuMhgp0V3o0qUFqkfMnMViI2oxDHSzIaTyu
 a5peQ+o6dtUvU0dCal5DYzqRS9SPApetWA4w7ndSAUrtn9CGTBlM0SpVZJRmQM+BbKN/
 IS7oP3Qd6T3+DUF9tulTlX5As342hTzkgB8YxB4icUkHFr+Ds4mPot9gyWzfSr86t1pS
 nJEDBD5k7G7OoVYIJeyxgE0aQh1ahGgbctalyF6aAHaAXLzVQnVGIU0A9KNTSuSI3JeJ
 quXCVOHuU7XoIRjZ3c71oSC5O7sCfGGTYZub36j70Iw+iF6apjkzwlBE2jqQdYd0ti6R
 XLcg==
X-Gm-Message-State: AOJu0YyhT7qnsxaw7Mf6DdH4+mHNIxlZf2oW9HUFCfAjlFXlj0s4025N
 4XmoglRJKDH7sOM8UYKty6WESRS4oKIGuG+2VbyQ5o/Fki9fw/YjDzlv9HSPrjRSZA2xjaqhVZG
 9mkRw
X-Gm-Gg: ASbGncu938xae155ljKmIyFpCS+UydLluk1ir6E/CVsVsf8iv53u0ZJ6Y1eKGKjHdIH
 HQ9XiGWKEYJOlbGQPLGE5c+HkJVeGL9PJZR9ppxHqnMk/QWaPuMOadCtN7ZppE4L6JJXjeR+3S7
 Mn8VAOZi8WhiUUquMMmKEUC67LY7ERdd9NpdvMq05SR727RqagrivQ2CI476+ZoqeXyy2oauSoi
 HpDxSHFzh9qMtgsqjk/a1x1CwiykZRoH608/X5xTTx6DgzTRUaitJUu87QciT2tIp/tYAo14dof
 9L5fhSrehZpA9T1M4HzIG7YeHcjVgTwb3IL5AUQbnAJGu6fNYrBmxFizAL//JJtgI085w1j0swR
 czV/KHw6w7BtvpYFF0QTo9KOxnEfcOUe+Zb+IeJFhvQ==
X-Google-Smtp-Source: AGHT+IFeaWgOKj7t5yQFnUIXH0oo7NKnJrFXSy/62Kfs+U7jSOYUVIQsEOfGc3tdvvFn67udLJCFFw==
X-Received: by 2002:a05:600c:5020:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-454d3695a62mr14601115e9.31.1752011627689; 
 Tue, 08 Jul 2025 14:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50503c4sm799795e9.11.2025.07.08.14.53.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:53:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH-for-10.1 RESEND v8 5/8] qemu: Convert target_words_bigendian()
 to TargetInfo API
Date: Tue,  8 Jul 2025 23:53:16 +0200
Message-ID: <20250708215320.70426-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708215320.70426-1-philmd@linaro.org>
References: <20250708215320.70426-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tswap.h       | 13 +------------
 include/qemu/target-info.h | 12 ++++++++++++
 cpu-target.c               |  7 -------
 hw/core/cpu-system.c       |  2 +-
 hw/display/vga.c           |  2 +-
 hw/virtio/virtio.c         |  2 +-
 system/memory.c            |  1 +
 system/qtest.c             |  1 +
 target-info.c              |  5 +++++
 9 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 49511f26117..55ffa633598 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -9,18 +9,7 @@
 #define TSWAP_H
 
 #include "qemu/bswap.h"
-
-/**
- * target_big_endian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Common code should normally never need to know about the
- * endianness of the target, so please do *not* use this function unless you
- * know very well what you are doing!
- */
-bool target_big_endian(void);
-#ifdef COMPILING_PER_TARGET
-#define target_big_endian()   TARGET_BIG_ENDIAN
-#endif
+#include "qemu/target-info.h"
 
 /*
  * If we're in target-specific code, we can hard-code the swapping
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index dde0e7d968a..abcf25db6fa 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -38,4 +38,16 @@ const char *target_machine_typename(void);
  */
 const char *target_cpu_type(void);
 
+/**
+ * target_big_endian:
+ *
+ * Returns: %true if the (default) endianness of the target is big endian,
+ *          %false otherwise.
+ *
+ * Common code should normally never need to know about the endianness of
+ * the target, so please do *not* use this function unless you  know very
+ * well what you are doing!
+ */
+bool target_big_endian(void);
+
 #endif
diff --git a/cpu-target.c b/cpu-target.c
index 1c90a307593..20db5ff3108 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -22,7 +22,6 @@
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
-#include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/log.h"
 #include "hw/core/cpu.h"
@@ -85,9 +84,3 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
 #endif
     abort();
 }
-
-#undef target_big_endian
-bool target_big_endian(void)
-{
-    return TARGET_BIG_ENDIAN;
-}
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 3c84176a0c5..a975405d3a0 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,7 @@
 #include "exec/cputlb.h"
 #include "system/memory.h"
 #include "exec/tb-flush.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 20475ebbd31..90b89cf4044 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "system/reset.h"
 #include "qapi/error.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 82a285a31d1..0f4d28033d7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "exec/tswap.h"
+#include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
diff --git a/system/memory.c b/system/memory.c
index e8d9b15b28f..38da62f5052 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/qemu-print.h"
+#include "qemu/target-info.h"
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
diff --git a/system/qtest.c b/system/qtest.c
index 301b03be2d3..fa42c9f9215 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
+#include "qemu/target-info.h"
 #include "qom/object_interfaces.h"
 
 #define MAX_IRQ 256
diff --git a/target-info.c b/target-info.c
index a756c0714c4..3110ab32f75 100644
--- a/target-info.c
+++ b/target-info.c
@@ -47,3 +47,8 @@ EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
 }
+
+bool target_big_endian(void)
+{
+    return target_endian_mode() == ENDIAN_MODE_BIG;
+}
-- 
2.49.0


