Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29154C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtGX-0004Au-0M; Tue, 13 May 2025 13:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtGB-0003vq-8W
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:17:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtG9-00012y-7s
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:17:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so67537275e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747156659; x=1747761459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=92VKl5M8N6yTo/u89ILBeJrAILC8Bk1ppBFcXFhcPnA=;
 b=ETlutBe/WIsRQRzQZ87BUu8nOP/1GETkc/LnNP8Pg54ZOGueSB2NLu2uqWb1G9Pxd1
 um6a9cl4k3OdqhOyUeh7cq47kmvO7BDzdGZGuuVybuLZgJBNdRfKbE4TC+XMiXzrOggr
 wycox++WIf7X/rHzlWSr3cH287ElTXYXXMZFTz0xEcONSyXdpztDBwlcvHQQJdaqpYTe
 LVZJYxOv5teZT1a4pgiHtpR/srAoYm09j+48hhu3LwD/VPNiFEKYdoZQNeNZ7hrJ7gQ2
 aNsVf4iBPdmEExjE1hz/9IdiU2WcdSnMQs9WMJlRGplYVjvArwCo42aFfuC56i+E1c5T
 K9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747156659; x=1747761459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92VKl5M8N6yTo/u89ILBeJrAILC8Bk1ppBFcXFhcPnA=;
 b=aVuNe1AOx4oZyHAnmDkAN05JtKl9jTks/eNr81YzQbQd+fDL5xgl7VXnl61y52alaQ
 XxYCLiBsiaLM4ehY5pQfQiEZhmrz/pOK9PKrYojAb8qK0IgPerq4aH9wjC/FXHONV6rg
 WIJzYHJm1Vn2LzWm5g1Hkkx6ekjdVB0/13mYiKOKSfAx0dXq80mRoh5mfp9nICbR0Ehj
 uC/FOkVG9ty0gTwtY/mPIAa5eKXjRBaQX41vcl3F+Wb3dDrK/tshqxrH/kHfi6cpsyIX
 iOgheQOBMe9HQMJSLv450h9tF182/PcqgF1lGDB747LWHp6hc7h9gPXGlCaI6nZICpGg
 FNHg==
X-Gm-Message-State: AOJu0YzIamZ7t7EtHNsB627YtR+BC7rPTXTkkBfrHp93+aQR8FLIrbDQ
 WKnvBuzhrpot6zUY4c5l1haB4oYsa+tidJM6aesGjq3rKhZkzCfk+kH+oUNiSm8I1ig4AoS1vHc
 52cg=
X-Gm-Gg: ASbGncuYFmRsv9CqpQU23OGFaUZPpWc3/M1LOBKSmE6SrwW66xqj3i6l3Jmullp14tL
 ptoB5z4w5uREsh9vHRxnA5i4tGb+Y1GNUUfk6Aa26Ye1v7PB64cfZSClcOoeFhrwByysNIdw0zq
 p4ld46zMMjaFSaEyK6luSEOdxN1b+Sr73z9jtMRSJPSSjODPRh1+fSruQ/pnjTkFoqiAqe+CgwR
 au3oFKBMWnBgJ2vFtvcE94vcfc1uKrIi6KmZPGDAX0nd/wkgMyX3V3LrEQQpjzCCQSJajpdKL3L
 eVpKQl3LEyb5R8T73QBR/OzBadzsxci6ftucoxIIN95l+goZmHhJMmeHueX54QZw4oyuQ+oNW5C
 8afqhb7nwNFghilCF+6VXr1TpQNCY
X-Google-Smtp-Source: AGHT+IGED3JpQ5xEpvL/Oky0PnXrRKLiZd+XWUI48ZshRzl+T/zGt/gx+JUq/R41rmN+QUIOmWMLfg==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fdbe:4398 with SMTP id
 5b1f17b1804b1-442f20bae9amr1785765e9.6.1747156659284; 
 Tue, 13 May 2025 10:17:39 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm219095405e9.39.2025.05.13.10.17.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:17:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony@xenproject.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/xen/arch_hvm: Unify x86 and ARM variants
Date: Tue, 13 May 2025 18:17:37 +0100
Message-ID: <20250513171737.74386-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
---
 include/hw/arm/xen_arch_hvm.h  |  9 ---------
 include/hw/i386/xen_arch_hvm.h | 11 -----------
 include/hw/xen/arch_hvm.h      | 14 ++++++++++----
 hw/arm/xen-pvh.c               |  1 -
 4 files changed, 10 insertions(+), 25 deletions(-)
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
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 4b26bcff7a5..1a9eeb01c8e 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/xen/arch_hvm.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
-- 
2.47.1


