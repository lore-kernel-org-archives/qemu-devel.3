Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC85C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLl-0000zG-Hv; Thu, 01 May 2025 17:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLc-0000q2-Df
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLa-0001Vv-9L
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so1026963a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134493; x=1746739293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XCisJMSzoKwJaTo6CumWuz7waKPmfF+7nJJv4gwzPo=;
 b=gQDFj0PRpNhuGnXOZiolqMs1sqL2o66utY1lkFVLoh9r5f7OJ12WK41XOAJlZec0fe
 JqgJ1+4LXbo6hHWxDNTRBuYQ5Ei8/jgpgdnqVMAHEV5jnbSFfDbRcP+/VZ2MDuaUH31e
 K9yZYGgWamnUH5JUOqjsHPgfVzNpQmr2umz0j7LVomhgPhocxeO+NytPYzeIXbxQVD+E
 qYBwH/dCb7TrVOEGKzhcLawUar6rVHD/KPJ9Gdl6sYxlsNjLti+nnmUCtt9UwzhVn3Kf
 NYvYApqC6LjBSY9YpKernje++42K2ZpUZ05IHjblLjYM8PJ1soPOa2pwB42Tu8IwFC2G
 wXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134493; x=1746739293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XCisJMSzoKwJaTo6CumWuz7waKPmfF+7nJJv4gwzPo=;
 b=WLb7cy7JKXpDP16wEPggVoH1c/a91g1fqotcqCT/gRXEw5cBSipTnZLtxpOePyMlHC
 u0z+BkJo997DdOWWr2KXWgUzHrbHrxsOj4wl/Ump1ie+K8gYM0+nSwg/Hn5GfAbIxcMp
 8qtLO41FkkTXhEX/GwlRc0BK7Sws69OquR+cGUCbCS4zuPNxvZFVWFhcqeV4p5xhm7fT
 KSzdBEW9EFyVFqxP/Au6uYQprw7mhL0mrqhrLxUPByCOEcqJLqlzYKvg1/pPOT1Gww16
 PzfR3iI+GyYx5urb7Vs5hSg9MyTRTFcjTC3cLC6tEdO4/qZfTbGfg9vi854hMOfsDtB2
 yaVQ==
X-Gm-Message-State: AOJu0Yw599CLfuoGHtc/ci4QHuJ5zywUWVfyq87liYj9PApXH86Ua7Bq
 M5Qx4n+8yqnDP3X5f4/KW/hGD6orTrQj3kvkvVYA6RXlsDUL3PbtuueD0nVSYWQTocer6Ou9gxs
 J
X-Gm-Gg: ASbGncsVr/rreehSsv6Rf4g92lVcJD6j79X9JR2ddTXPgm+hI1ur6f3BnlSpOB/YeVh
 yK5QO8S19fo6tgpBUd+NohaePTX6w+Rga7Szkj8tB+mTWt03dRriuChrQu6S02GukM5/RTd9t+6
 krKhbZixg1uH2es4HlMW15+Szw7CoVS0634vOAlnVoOtXcElUhCdwt+VcQRGNZD2BOf9ywiLn9o
 +PHMjwAI9kk9gzoajDrUMp2oxxtLH68B3bUZv9hXr54wEmzqY7I2JdxdBpkBW1R8142Z71iKTd0
 9e3grakVRWUYyW0UFPctjEIwFdPaP4LEJWZUUaC+pmXAIMIQ942//8q+3vHFFo+b4LMF0OLir98
 =
X-Google-Smtp-Source: AGHT+IG+B+fCp9BHXpA85+JfCT/B9Wm2aSQ+NGermkStlPIky2NclQgNsiOe3XGZz2AGANuwAIa9yQ==
X-Received: by 2002:a17:90b:55c5:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-30a4e6238fcmr790482a91.27.1746134492684; 
 Thu, 01 May 2025 14:21:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/59] physmem: Restrict TCG IOTLB code to TCG accel
Date: Thu,  1 May 2025 14:20:35 -0700
Message-ID: <20250501212113.2961531-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Restrict iotlb_to_section(), address_space_translate_for_iotlb()
and memory_region_section_get_iotlb() to TCG. Declare them in
the new "accel/tcg/iommu.h" header. Declare iotlb_to_section()
using the MemoryRegionSection typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-12-philmd@linaro.org>
---
 include/accel/tcg/iommu.h | 41 +++++++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h   | 26 -------------------------
 accel/tcg/cputlb.c        |  1 +
 system/physmem.c          |  5 +++++
 MAINTAINERS               |  2 +-
 5 files changed, 48 insertions(+), 27 deletions(-)
 create mode 100644 include/accel/tcg/iommu.h

diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
new file mode 100644
index 0000000000..90cfd6c0ed
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
index 816274bf90..b9eb9bc4b6 100644
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
index ca69128232..d11989f567 100644
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
index ccbeae241c..f1ec0902c7 100644
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
diff --git a/MAINTAINERS b/MAINTAINERS
index b3f9f2680b..f3f491c8c2 100644
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
-- 
2.43.0


