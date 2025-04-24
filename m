Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2790C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tBS-00008v-9U; Thu, 24 Apr 2025 05:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBP-0008Py-D5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBN-0002bO-2X
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso577635f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488067; x=1746092867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDnRsco8X4925YTV8UTDqMtG98oA60/dC49QTKfKMmw=;
 b=hxaBNYaSW9y2IjC5ppfCotnAgZD5rY3SxJqeAWvkMjzMS1e5we2w1qMESn7u2Mumtn
 GS0jhEXx5AHt8DKcTwb1G+iAgmw1x9k6tCEzna5I9Wm3uSBxmV7QD3d0OaHmbZhQ6RtE
 SSELAHQFn4GMVqEtOw8JFo6VGiXolXSEFT0zU0hCSbv+UAi+s8Tl+IW5ID5Ms6WM+/56
 rwSkuPE/CRcBc8DNGwKm7ID8sVPUPLGdw8Ifg+autfaxQne+i/wQvvVn+RB0iBjqUq08
 qiwvpUt1Aook8Q1NWKr4yDm6o7FrJjUsN+iDbqKIqvZGxewr0Hdz23i0qKa6ExYQxrDq
 V4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488067; x=1746092867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDnRsco8X4925YTV8UTDqMtG98oA60/dC49QTKfKMmw=;
 b=Vt6qS7ousWLuJTzAxz1JWuAHmi4oktb47lZ4pT+OVYnZL0/xyVHD1B09Vuviowq0tC
 GHW8sdTTcucfeUtR7lbwHHTbiRadUE3j5p2OT+hy+Vp7vrO6Hj3984wY3qVW3w2iVfQq
 DgGrPiJoC7t/ZBcEEtLq7vBHk+OywxhqmzFyFk3szTnho+o/gShDa6DU36O5vSOo7Eie
 0N6uOS9WMORk4eO6VPSDl2h6XeJayUThsA6+uSm0Z3afT1IAEMcFkLu41PVduxCaff/5
 qG7rgTorfbf+JObtgFLU9TF1Fvggkhc4Z8EyqhP3xfZ5PjPt4w73l8juokmPG6IBcVDe
 3Lrg==
X-Gm-Message-State: AOJu0YxK0XNE56qubKWrhMqEPx4wUaw5SDXM4MMZSaNRWhb16IjpirzF
 VIhRbNhh01/Ekrdn+q54O3LN4qqMGqpw4ZuQyXKThD1GhAVcIHPWYvMmZTAug5Uh7btktP4ssBk
 Y
X-Gm-Gg: ASbGncsdr1pLp7ADDKZEsRxkeOapwGoB/QMMRaLbw1Iv4NiRathPHe21swpHCHwGKNa
 o3knMzyKVB8GJ6SAM7nLVbsRECATM6acXAmYNeqJnhat/B4diO7otJqISe0kVS4+euR08bQmK7n
 cX8TUkh24fJwIAUIBYQnQQydXTrdlRlN2qyBGnF/UDiiVFsLMisIiaOqKdcyfB785rT3bNbHwsW
 Da//6fSexJK7zOZ3c4Xtn0PLF5XBQAFYcKvy1/8C4fAw+qKM/pRchYUyx1CPtldqQHp3ufIi22o
 hUx4X6DXwIe5+gvJBbJg7Sawlhf0s+x6mX08ac7NGLBhOgv80jZCoGaSkPjVf17SlN8app+LQbs
 rtwm4pHvUquH+60QO0HzT
X-Google-Smtp-Source: AGHT+IHyRzhoJ/LZFYRidIgFo8SZDtR46NkMJ6q/iDSIG0yHNPSvsXwyTabomkHkYMhaqjSP0khSZQ==
X-Received: by 2002:a5d:5848:0:b0:39c:3122:ad55 with SMTP id
 ffacd0b85a97d-3a06cf5642bmr1373587f8f.18.1745488067003; 
 Thu, 24 Apr 2025 02:47:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4c5fc4sm1537508f8f.57.2025.04.24.02.47.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/13] physmem: Restrict TCG IOMMU code to TCG accel
Date: Thu, 24 Apr 2025 11:46:51 +0200
Message-ID: <20250424094653.35932-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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


