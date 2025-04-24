Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964CAC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u838a-0000fo-Cz; Thu, 24 Apr 2025 16:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u838C-0000Pk-2P
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8389-0005Dg-Mi
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:25:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso10643055e9.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526307; x=1746131107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDnRsco8X4925YTV8UTDqMtG98oA60/dC49QTKfKMmw=;
 b=gBvBYkeHpyhw8e+sOcKcg0xM0MMb3Jv2BGbAzIOX1yriTqawWH51LMTKE4YMQ+YcCh
 CZIadNKcw+TbYlir0JMLB2z7+Vgm4D1mRLvPSKBvMyCxVXCr//NtfZrxxBVSn2CQT7kQ
 AMJEMWk7/IFQqIDpkIqqVg50fsubrQnUoewIejfmoJrVBMjE66qQQZjdNTbt7JNUeKkq
 pdo2hfcgOqsGYI5QNF5MeXMpW8KzILrLdktiTKBU3oZKJM/yPiLBmE9zdMuE9QjAty58
 s2WJ33DywpMv2dHQ7dLTxMekUquGDVlDlY9YTq30SjgIEDUWUmlGM1mdPLeG8hEurHV3
 qypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526307; x=1746131107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDnRsco8X4925YTV8UTDqMtG98oA60/dC49QTKfKMmw=;
 b=TMXV6dIWJybmcrIyQrz6lpXQcUrW1BTRszI3rihAl+F3e1/yqs4S6dzaMN4uui07eF
 Mi6y1qA5pi9eac2B7YglY8k9aMvhAh3Wp71fGwxnj9PAcF+0OBUGpaRagrPMJUJLKJbw
 Qbz9a6Rre7WXzkctvZy3Z5vHXuleSQ/YXYRcmnTVrTV/0Q5FU+R5cd5RnZV9AlpICCrp
 1hDFG/Bki/xepF4GgaljF2lsLK8hH4yxL1pH9pXRQWwzAHVgxAQQStXvU6KvFN87Gmge
 u/3FawCvIyVD7jyf86RniVsSGyuLb3Tj367gB1Y8BqMHI9cqzauviYHkcG5k3dVHBMki
 z/QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSEh4oMsa0ayshXfYRSWg4f48Q+vhDl8k3y+rLpwZISb4PZHXClDEGvY7Q/KRVL6eMTgRblzwf4jxi@nongnu.org
X-Gm-Message-State: AOJu0YwuUi+yQwpJCFVOhiYsr+F+8E8DuycI9MToV8MtjzeKT/CgK2s8
 eynOFM3zNWgWeRd69CdFzESfhVCLyvqlRwMdYnNxvO7exiiWef6UPQ7cEM5mh5g=
X-Gm-Gg: ASbGncvjEGs1YcGRwXaaYUhGfA5Ke0Ml+mVYbplrg5vuCUCAEs+rRv1J9HE7299lU53
 uU3cViD5GJmI6R238Wa6PjEzXEWHO9tHF8KrGeGBpDNH35v+UxHi0kgLbQE23LqxCbotE0cKbmL
 +yX1e+ml8dEs5DbV8hCevwYYY7apigg5VL5hhtBeD5Y76VP0cNH48eOc1Tx9kOg6cNL2gNDMEmF
 5fFZ5KzziuZPpZ+HzISg7liuCGjUlVxhVzAISsi+3uc5+5Uso+UppBLuN8WCcjLStVxdYcvg/xk
 GpgiJBlPt8r6IdjymFiw7gQJTPc6OL4buC3m94mpkBaJNMc2B4s31Vs2B1uYZsckRBMgAQf5Qfz
 FP743Tj6DamW6fIfVbmEP5eiseA==
X-Google-Smtp-Source: AGHT+IFOKuU3iQB66cmrgnvlskzQPtUQIB4xHVVyYN/BBFH0GBw/GY8IT30Z9dagI8n7wta/en4Fjw==
X-Received: by 2002:a05:6000:40cb:b0:390:fb37:1bd with SMTP id
 ffacd0b85a97d-3a072bb51a6mr568656f8f.46.1745526307256; 
 Thu, 24 Apr 2025 13:25:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cb2acbsm290110f8f.40.2025.04.24.13.25.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:25:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/13] physmem: Restrict TCG IOTLB code to TCG accel
Date: Thu, 24 Apr 2025 22:24:10 +0200
Message-ID: <20250424202412.91612-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
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

Restrict iotlb_to_section(), address_space_translate_for_iotlb()
and memory_region_section_get_iotlb() to TCG. Declare them in
the new "accel/tcg/iommu.h" header. Declare iotlb_to_section()
using the MemoryRegionSection typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS               |  2 +-
 include/accel/tcg/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 26 -------------------------
 accel/tcg/cputlb.c        |  1 +
 system/physmem.c          |  5 +++++
 5 files changed, 48 insertions(+), 27 deletions(-)
 create mode 100644 include/accel/tcg/iommu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 661a47db5ac..3a37cc73af7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -168,7 +168,7 @@ F: include/exec/helper*.h.inc
 F: include/exec/helper-info.c.inc
 F: include/exec/page-protection.h
 F: include/system/tcg.h
-F: include/accel/tcg/cpu-ops.h
+F: include/accel/tcg/
 F: host/include/*/host/cpuinfo.h
 F: util/cpuinfo-*.c
 F: include/tcg/
diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
new file mode 100644
index 00000000000..90cfd6c0ed1
--- /dev/null
+++ b/include/accel/tcg/iommu.h
@@ -0,0 +1,41 @@
+/*
+ * TCG IOMMU translations.
+ *
+ * Copyright (c) 2003 Fabrice Bellard
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#ifndef ACCEL_TCG_IOMMU_H
+#define ACCEL_TCG_IOMMU_H
+
+#ifdef CONFIG_USER_ONLY
+#error Cannot include accel/tcg/iommu.h from user emulation
+#endif
+
+#include "exec/hwaddr.h"
+#include "exec/memattrs.h"
+
+/**
+ * iotlb_to_section:
+ * @cpu: CPU performing the access
+ * @index: TCG CPU IOTLB entry
+ *
+ * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
+ * it refers to. @index will have been initially created and returned
+ * by memory_region_section_get_iotlb().
+ */
+MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+                                      hwaddr index, MemTxAttrs attrs);
+
+MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
+                                                       int asidx,
+                                                       hwaddr addr,
+                                                       hwaddr *xlat,
+                                                       hwaddr *plen,
+                                                       MemTxAttrs attrs,
+                                                       int *prot);
+
+hwaddr memory_region_section_get_iotlb(CPUState *cpu,
+                                       MemoryRegionSection *section);
+
+#endif
+
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 816274bf905..b9eb9bc4b63 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -21,7 +21,6 @@
 #define EXEC_ALL_H
 
 #include "exec/hwaddr.h"
-#include "exec/memattrs.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
 
@@ -121,29 +120,4 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
-
-/**
- * iotlb_to_section:
- * @cpu: CPU performing the access
- * @index: TCG CPU IOTLB entry
- *
- * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
- * it refers to. @index will have been initially created and returned
- * by memory_region_section_get_iotlb().
- */
-struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                             hwaddr index, MemTxAttrs attrs);
-#endif
-
-#if !defined(CONFIG_USER_ONLY)
-
-MemoryRegionSection *
-address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
-                                  hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot);
-hwaddr memory_region_section_get_iotlb(CPUState *cpu,
-                                       MemoryRegionSection *section);
-#endif
-
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index ca69128232c..d11989f5674 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/iommu.h"
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "system/memory.h"
diff --git a/system/physmem.c b/system/physmem.c
index ccbeae241c4..f1ec0902c78 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -29,6 +29,7 @@
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/iommu.h"
 #endif /* CONFIG_TCG */
 
 #include "exec/exec-all.h"
@@ -587,6 +588,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
     return mr;
 }
 
+#ifdef CONFIG_TCG
+
 typedef struct TCGIOMMUNotifier {
     IOMMUNotifier n;
     MemoryRegion *mr;
@@ -771,6 +774,8 @@ hwaddr memory_region_section_get_iotlb(CPUState *cpu,
     return section - d->map.sections;
 }
 
+#endif /* CONFIG_TCG */
+
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr)
 {
-- 
2.47.1


