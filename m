Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483C0C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublka-0002gc-QH; Tue, 15 Jul 2025 15:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublai-0001oG-9D
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublag-0002f7-0N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so43739495e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608723; x=1753213523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YI4WZbbT1bZzd2LYFBB3rNk/YqQvkBiNRUUbw7uKvvU=;
 b=LrT3iNjN7B3KpEW/Qy+u9cQNMjrtEGPKHnAbxDzWvBTGG3rwn0IW3lFu1HpeC8BU+S
 tjbw3p4tH27zN453TQHKNf6N23SCsWTEHRaFQAJnw6q/ra9oybKtNIiZPIwvbhUIpvD3
 XpWMoWpzXbmNy+xbYbWSVpbhGPoclAaBczbnVyFHHT3+XGANmWQ9CiK1vsvP3aNsUWzO
 3gs13Oi5uz6g6MVVfz9mPYdIbKYWMyukjJoUvWCRSXiIi7TKZ8jUigmFQNtMwAhUOTnb
 p9xjtTHJ0fhxA6pwKwnV94UX/JuWjAzqGbfL0vFWUeXokvqJdWcHsdGWwaI1eR4X0vyV
 nsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608723; x=1753213523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YI4WZbbT1bZzd2LYFBB3rNk/YqQvkBiNRUUbw7uKvvU=;
 b=TGTxcqZ+JROm5pUgZw5l+Rto1+StsfY8HlyVuHwYm4RPmcjixlKf6+5mrU0We9Ed7n
 mHeiGtjdWsQ5L8ozCMVdXi5qTfzoJIPdiExiEN5ijJE7iERYsQ+VkTU6VX3JQMKGwZLk
 YuIyYmVeAR5sknZjqrkzcaFcZ1l4x4TcAf9+s7j5Dldfl6uyzRHA4/pMT7zfVGCkL5on
 7xFs/wQoMXu/dw7wH5tgqeNxiYvrKIch1wGlthSgCu219a3uP+WOROMBAP012MCeQ2vr
 J7F9u5a2jUMtfCQRu4CEecFXnAYA91+fbeE+oSECPKlgJhu4IjxNdADAxgx24fuBlEfv
 l8zg==
X-Gm-Message-State: AOJu0Yz//oA5R2HVIlXrcrXyt3Pq016Zh+y63VZYXfG/Y4344DAMhIt3
 DoPq49vQQLCeQHQk+iD+lLuVyVTd/BL+JrPH5tSIaAslTSAAwk7QMIR+2QvHqbzgGD1CG3HJeIs
 FaKsM
X-Gm-Gg: ASbGncs8WV5Aolff1C0yOQVy/P72Mad5hKo9UZx+GV19rHRJ9/H1b0LPYHSx64HIXSo
 D3ykfvlUxo/0dJwi2Geg/XoKkfV4weT7FZ0eJN67+iApfkOMyhUh7yIgcgenc27rvvJz1gB+KUv
 npnU/F6EVp/Ikgd4fFaBNvq7yXDVX+4ZaXDZzBjNDmQa6M85Z7KptsyU7pqI1ku8FH08DlkX+YS
 up4awHPS8bBX/fEMm6Z8L0quFPXNL7p6rgzZIqxN6Fg/9JoMo1P1LUgirXUULMsWFUm4GNozmKB
 4f7C0DG6/sRjnGrPcbDI/14xAqMo1WS8ZiJp89WTraRma19fo9rYwhmYWY+eVn7gMlR+l/FZb1+
 YG26MXZL6a6dVGlWoOtYJXh7BUeYbQaGaCAHCu0s09dG7TunroiuhipAkJShzTpsk1V6WUoK6Cc
 SBuw==
X-Google-Smtp-Source: AGHT+IGsnUWm531ir9pIYoF/zMU1qwqlDqdFaAWqt6c/pcjoUI3ai7E+ZaMlKDkeIU+RoL2Tt7yGDQ==
X-Received: by 2002:a05:600c:3b11:b0:43d:3df:42d8 with SMTP id
 5b1f17b1804b1-4562e364770mr869885e9.6.1752608723049; 
 Tue, 15 Jul 2025 12:45:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562bacfa41sm9294755e9.40.2025.07.15.12.45.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] hw/xen/arch_hvm: Unify x86 and ARM variants
Date: Tue, 15 Jul 2025 21:45:00 +0200
Message-ID: <20250715194516.91722-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

As each target declares the same prototypes, we can
use a single header, removing the TARGET_XXX uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Message-Id: <20250513171737.74386-1-philmd@linaro.org>
---
 include/hw/arm/xen_arch_hvm.h  |  9 ---------
 include/hw/i386/xen_arch_hvm.h | 11 -----------
 include/hw/xen/arch_hvm.h      | 14 ++++++++++----
 3 files changed, 10 insertions(+), 24 deletions(-)
 delete mode 100644 include/hw/arm/xen_arch_hvm.h
 delete mode 100644 include/hw/i386/xen_arch_hvm.h

diff --git a/include/hw/arm/xen_arch_hvm.h b/include/hw/arm/xen_arch_hvm.h
deleted file mode 100644
index 8fd645e7232..00000000000
--- a/include/hw/arm/xen_arch_hvm.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_XEN_ARCH_ARM_HVM_H
-#define HW_XEN_ARCH_ARM_HVM_H
-
-#include <xen/hvm/ioreq.h>
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void arch_xen_set_memory(XenIOState *state,
-                         MemoryRegionSection *section,
-                         bool add);
-#endif
diff --git a/include/hw/i386/xen_arch_hvm.h b/include/hw/i386/xen_arch_hvm.h
deleted file mode 100644
index 1000f8f5433..00000000000
--- a/include/hw/i386/xen_arch_hvm.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef HW_XEN_ARCH_I386_HVM_H
-#define HW_XEN_ARCH_I386_HVM_H
-
-#include <xen/hvm/ioreq.h>
-#include "hw/xen/xen-hvm-common.h"
-
-void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
-void arch_xen_set_memory(XenIOState *state,
-                         MemoryRegionSection *section,
-                         bool add);
-#endif
diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
index df39c819c8f..8bacaa4ec41 100644
--- a/include/hw/xen/arch_hvm.h
+++ b/include/hw/xen/arch_hvm.h
@@ -1,5 +1,11 @@
-#if defined(TARGET_I386) || defined(TARGET_X86_64)
-#include "hw/i386/xen_arch_hvm.h"
-#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
-#include "hw/arm/xen_arch_hvm.h"
+#ifndef HW_XEN_ARCH_HVM_H
+#define HW_XEN_ARCH_HVM_H
+
+#include <xen/hvm/ioreq.h>
+#include "hw/xen/xen-hvm-common.h"
+
+void arch_handle_ioreq(XenIOState *state, ioreq_t *req);
+void arch_xen_set_memory(XenIOState *state,
+                         MemoryRegionSection *section,
+                         bool add);
 #endif
-- 
2.49.0


