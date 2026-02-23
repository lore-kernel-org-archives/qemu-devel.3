Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D60EC1114
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKE-0001KK-5f; Mon, 23 Feb 2026 12:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKB-0001EN-GK
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZK8-0008Uq-HG
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so43123495e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866139; x=1772470939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VtZnSTrAdZDYVk7EjD3fTK7vrjYFNEe+1oEHJx6dAb4=;
 b=ORJeWMUwYwWwhIkC7Ohyb5f5c8IAqUPYy2WNQt97+sWcZNM/Ef/IAZJ5sOECokygmi
 S8mpCLhawXZcRWAAvsSKNsCMJ9VkCm7mJvCMtGXXl4w2rr8s5jfMwEe7LuJt3E/1egUC
 bKeU2oS0osNZoGXX14niwodAv7y2qD5S1IKBY3hnndiaFRFz4OCnQipfWLu1+NiaG9Qt
 MQjHwkZSOTXTEOsj/D4u/OXNTK8bNtfb3C/G6gMjTbVUtLpqadsveymcGPe1i25h5Fm3
 YVvyPkwJDO7BE7dehaXoMDudisrMrsaMLeZP4nFrH0PXepCy0YfwhRXq8NdohUjaOtBg
 tn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866139; x=1772470939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VtZnSTrAdZDYVk7EjD3fTK7vrjYFNEe+1oEHJx6dAb4=;
 b=WDcEWtGJeBmcMUQqVr8Ty4maearuYirQRZ3C48jGaWatIQuHOQ/8yYia9fB8cSqGW1
 UXePAB+TXxitbzze7SXEnPjiQIyQN0Q5jqhwh64HH8RkGxq6D1lU4fvYrvDh/hyMGsq8
 uDM01hD0YYjJiOslQXYy62LhJdKOsUlgAywabvpsaAYvIkz1Rkd2KSkeNj8rLd6j+X70
 eWNNuA/awEvyjZip/FYDhhqax3MTkRlGvHCF1+CpEiOx0ZtDvBt8KSEnDz0GBq1mFpN/
 rZ1D6EOOkDGE47Yz8W73JwUAYTD0eM68lYv5LbjuXXZgD65NpmtJbdehhNrzGAwBfyQ3
 X3sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL7hW1bJTIi2iVIHj3RpTuQziR07+6ApEpqPkcz+uS1DEtnjFE95urwTfiN3w9UhMxy7mWm67c/lwu@nongnu.org
X-Gm-Message-State: AOJu0YwVK5v2cAUr2TFnDMJGlCDN+o+tvNclXiRlQ66h2w5jYBBEQy7g
 ZjvHkzBPZrb0OnNsDI/23MKOOwz9NOoAGjFgIDEWo2Nxza0i2NnO6fU02Yjo/EGkDO4=
X-Gm-Gg: AZuq6aJTVKBLjYAy2mat9dtRrMXVom2ICtGO539Zbg1aRj8kwXE7HWjX8LggWOhw3qe
 6xJh20ejQcjPcdnr5zIFYvPdsVRSS8GsBI9Ax2EI83Nfw+sJJE0613X5mZvaEQ5VWkB+/A6hMJF
 Seh/cGl8YL21ggxVS0ZcpXkpfb0vRIu/caEtu3+u6CZWXbfbnr/4OY1DckNzzXaDHHo82WTKGpR
 U1FHCmzmd4N5c6nm2T3d0iIErXHQzo0RhMiy+novwmBRZFaW6HXyVIDoUDKPXcDfs9sfk3x0IMn
 +ELcHR8mlJ7WMZkJndz3JaRrQF60/hLaj459v4eyzI/Gzuy97b8vUociphHv5OMLGDtJ3uCkt3a
 4DOuTkpvPpfESvyDFFhsmTCX3aK4Yz7t/y9NIkyYWRCFG5v/wWF1MV0HGznIwg0jNZdmFnrtKWZ
 M0IWYOEX2au4jQGeJGKh1Aa6HFgn9r6/eQjutPo62lrxga3guiqob13mIj5nTwcb7K64u5AmIhk
 Vg2MZBbU2n2HhD/WVHuYtPfrnpf/TQ=
X-Received: by 2002:a05:600c:468d:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-483a95c8f2dmr164256725e9.13.1771866138551; 
 Mon, 23 Feb 2026 09:02:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/65] hw/intc/arm_gicv5: Implement skeleton code for IRS
 register frames
Date: Mon, 23 Feb 2026 17:01:11 +0000
Message-ID: <20260223170212.441276-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GICv5 IRS has one mandatory register frame (the config frame) for
each of up to four supported physical interrupt domains.  Implement
the skeleton of the code needed to create these as sysbus MMIO
regions.

The config frame has a mix of 32-bit and 64-bit registers, and it is
valid to access the 64-bit registers with 32-bit accesses.  In a
similar way to the various GICv3 devices, we turn the MemoryRegionOps
read_with_attrs and write_with_attrs calls into calls on functions
specifically to read 32 or 64 bit values.  (We can't trivially
implement one in terms of the other because various registers have
side effects on write which must only trigger when the "correct" half
of the 64-bit register is written to.)

Unlike the GICv3, we choose to expose a sysbus MMIO region for each
interrupt domain even if the config of the GICv5 means that it
doesn't implement that domain.  This avoids having the config frame
for a domain ending up at a different MMIO region index depending on
the config of the GICv5.  (This matters more for GICv5 because it
supports Realm, and so there are more possible valid configurations.)

gicv5_common_init_irqs_and_mmio() does not yet create any IRQs, but
we name it this way to parallel the equivalent GICv3 function and to
avoid having to rename it when we add the IRQ line creation in a
subsequent commit.

The arm_gicv5_types.h header is a little undermotivated at this
point, but the aim is to have somewhere to put definitions that we
want in both the GIC proper and the CPU interface.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 193 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  35 ++++++
 hw/intc/trace-events               |   6 +
 include/hw/intc/arm_gicv5.h        |   1 +
 include/hw/intc/arm_gicv5_common.h |  50 ++++++++
 include/hw/intc/arm_gicv5_types.h  |  28 +++++
 6 files changed, 313 insertions(+)
 create mode 100644 include/hw/intc/arm_gicv5_types.h

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index f9dab710d3..0eb4348e81 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -8,9 +8,178 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/arm_gicv5.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "trace.h"
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
+static const char *domain_name[] = {
+    [GICV5_ID_S] = "Secure",
+    [GICV5_ID_NS] = "NonSecure",
+    [GICV5_ID_EL3] = "EL3",
+    [GICV5_ID_REALM] = "Realm",
+};
+
+static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
+                         uint64_t *data, MemTxAttrs attrs)
+{
+    return false;
+}
+
+static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
+                          uint64_t data, MemTxAttrs attrs)
+{
+    return false;
+}
+
+static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
+                          uint64_t *data, MemTxAttrs attrs)
+{
+    return false;
+}
+
+static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
+                           uint64_t data, MemTxAttrs attrs)
+{
+    return false;
+}
+
+static MemTxResult config_read(void *opaque, GICv5Domain domain, hwaddr offset,
+                               uint64_t *data, unsigned size,
+                               MemTxAttrs attrs)
+{
+    GICv5 *s = ARM_GICV5(opaque);
+    bool result;
+
+    switch (size) {
+    case 4:
+        result = config_readl(s, domain, offset, data, attrs);
+        break;
+    case 8:
+        result = config_readll(s, domain, offset, data, attrs);
+        break;
+    default:
+        result = false;
+        break;
+    }
+
+    if (!result) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid guest read for IRS %s config frame "
+                      "at offset " HWADDR_FMT_plx
+                      " size %u\n", __func__, domain_name[domain],
+                      offset, size);
+        trace_gicv5_badread(domain_name[domain], offset, size);
+        /*
+         * The spec requires that reserved registers are RAZ/WI;
+         * so we log the error but return MEMTX_OK so we don't cause
+         * a spurious data abort.
+         */
+        *data = 0;
+    } else {
+        trace_gicv5_read(domain_name[domain], offset, *data, size);
+    }
+
+    return MEMTX_OK;
+}
+
+static MemTxResult config_write(void *opaque, GICv5Domain domain,
+                                hwaddr offset, uint64_t data, unsigned size,
+                                MemTxAttrs attrs)
+{
+    GICv5 *s = ARM_GICV5(opaque);
+    bool result;
+
+    switch (size) {
+    case 4:
+        result = config_writel(s, domain, offset, data, attrs);
+        break;
+    case 8:
+        result = config_writell(s, domain, offset, data, attrs);
+        break;
+    default:
+        result = false;
+        break;
+    }
+
+    if (!result) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid guest write for IRS %s config frame "
+                      "at offset " HWADDR_FMT_plx
+                      " size %u\n", __func__, domain_name[domain],
+                      offset, size);
+        trace_gicv5_badwrite(domain_name[domain], offset, data, size);
+        /*
+         * The spec requires that reserved registers are RAZ/WI;
+         * so we log the error but return MEMTX_OK so we don't cause
+         * a spurious data abort.
+         */
+    } else {
+        trace_gicv5_write(domain_name[domain], offset, data, size);
+    }
+
+    return MEMTX_OK;
+}
+
+#define DEFINE_READ_WRITE_WRAPPERS(NAME, DOMAIN)                           \
+    static MemTxResult config_##NAME##_read(void *opaque, hwaddr offset,   \
+                                            uint64_t *data, unsigned size, \
+                                            MemTxAttrs attrs)              \
+    {                                                                      \
+        return config_read(opaque, DOMAIN, offset, data, size, attrs);     \
+    }                                                                      \
+    static MemTxResult config_##NAME##_write(void *opaque, hwaddr offset,  \
+                                             uint64_t data, unsigned size, \
+                                             MemTxAttrs attrs)             \
+    {                                                                      \
+        return config_write(opaque, DOMAIN, offset, data, size, attrs);    \
+    }
+
+DEFINE_READ_WRITE_WRAPPERS(ns, GICV5_ID_NS)
+DEFINE_READ_WRITE_WRAPPERS(realm, GICV5_ID_REALM)
+DEFINE_READ_WRITE_WRAPPERS(secure, GICV5_ID_S)
+DEFINE_READ_WRITE_WRAPPERS(el3, GICV5_ID_EL3)
+
+static const MemoryRegionOps config_frame_ops[NUM_GICV5_DOMAINS] = {
+    [GICV5_ID_S] = {
+        .read_with_attrs = config_secure_read,
+        .write_with_attrs = config_secure_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.min_access_size = 4,
+        .valid.max_access_size = 8,
+        .impl.min_access_size = 4,
+        .impl.max_access_size = 8,
+    },
+    [GICV5_ID_NS] = {
+        .read_with_attrs = config_ns_read,
+        .write_with_attrs = config_ns_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.min_access_size = 4,
+        .valid.max_access_size = 8,
+        .impl.min_access_size = 4,
+        .impl.max_access_size = 8,
+    },
+    [GICV5_ID_EL3] = {
+        .read_with_attrs = config_el3_read,
+        .write_with_attrs = config_el3_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.min_access_size = 4,
+        .valid.max_access_size = 8,
+        .impl.min_access_size = 4,
+        .impl.max_access_size = 8,
+    },
+    [GICV5_ID_REALM] = {
+        .read_with_attrs = config_realm_read,
+        .write_with_attrs = config_realm_write,
+        .endianness = DEVICE_LITTLE_ENDIAN,
+        .valid.min_access_size = 4,
+        .valid.max_access_size = 8,
+        .impl.min_access_size = 4,
+        .impl.max_access_size = 8,
+    },
+};
+
 static void gicv5_reset_hold(Object *obj, ResetType type)
 {
     GICv5 *s = ARM_GICV5(obj);
@@ -21,6 +190,28 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
     }
 }
 
+static void gicv5_realize(DeviceState *dev, Error **errp)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(dev);
+    GICv5Class *gc = ARM_GICV5_GET_CLASS(dev);
+
+    ERRP_GUARD();
+
+    gc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    /*
+     * When we implement support for more than one interrupt domain,
+     * we will provide some QOM properties so the board can configure
+     * which domains are implemented. For now, we only implement the
+     * NS domain.
+     */
+    cs->implemented_domains = (1 << GICV5_ID_NS);
+    gicv5_common_init_irqs_and_mmio(cs, config_frame_ops);
+}
+
 static void gicv5_init(Object *obj)
 {
 }
@@ -32,8 +223,10 @@ static void gicv5_finalize(Object *obj)
 static void gicv5_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
     GICv5Class *gc = ARM_GICV5_CLASS(oc);
 
+    device_class_set_parent_realize(dc, gicv5_realize, &gc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, gicv5_reset_hold, NULL,
                                        &gc->parent_phases);
 }
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b0194f7f26..cb80c8821c 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -11,6 +11,41 @@
 
 OBJECT_DEFINE_ABSTRACT_TYPE(GICv5Common, gicv5_common, ARM_GICV5_COMMON, SYS_BUS_DEVICE)
 
+static bool bad_frame_accepts(void *opaque, hwaddr addr, unsigned size,
+                              bool is_write, MemTxAttrs attrs)
+{
+    return false;
+}
+
+/*
+ * Used for the sysbus MMIO regions corresponding to IRS frames
+ * where this IRS does not implement the interrupt domain.
+ * It's probably a board/SoC error to create an IRS and try to wire
+ * up this MMIO region, but if it does then the region will behave as
+ * unassigned memory (generating a decode error).
+ * These frames are just here so that changing which domains are
+ * implemented doesn't reorder which sysbus MMIO region is which.
+ */
+static const MemoryRegionOps bad_frame_ops = {
+    .valid.accepts = bad_frame_accepts,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
+                                     const MemoryRegionOps config_ops[NUM_GICV5_DOMAINS])
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(cs);
+
+    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
+        g_autofree char *memname = g_strdup_printf("gicv5-irs-%d", i);
+        const MemoryRegionOps *ops = gicv5_domain_implemented(cs, i) ?
+            &config_ops[i] : &bad_frame_ops;
+        memory_region_init_io(&cs->iomem[i], OBJECT(cs), ops, cs,
+                              memname, IRS_CONFIG_FRAME_SIZE);
+        sysbus_init_mmio(sbd, &cs->iomem[i]);
+    }
+}
+
 static void gicv5_common_reset_hold(Object *obj, ResetType type)
 {
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 018c609ca5..edd3c49c5f 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -227,6 +227,12 @@ gicv3_its_vte_read(uint32_t vpeid, int valid, uint32_t vptsize, uint64_t vptaddr
 gicv3_its_vte_read_fault(uint32_t vpeid) "GICv3 ITS: vPE Table read for vPEID 0x%x: faulted"
 gicv3_its_vte_write(uint32_t vpeid, int valid, uint32_t vptsize, uint64_t vptaddr, uint32_t rdbase) "GICv3 ITS: vPE Table write for vPEID 0x%x: valid %d VPTsize 0x%x VPTaddr 0x%" PRIx64 " RDbase 0x%x"
 
+# arm_gicv5.c
+gicv5_read(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+gicv5_badread(const char *domain, uint64_t offset, unsigned size) "GICv5 IRS %s config frame read: offset 0x%" PRIx64 " size %u: error"
+gicv5_write(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u: error"
+
 # armv7m_nvic.c
 nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
 nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index 3cd9652f6f..42ccef8474 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -26,6 +26,7 @@ struct GICv5 {
 
 struct GICv5Class {
     GICv5CommonClass parent_class;
+    DeviceRealize parent_realize;
     ResettablePhases parent_phases;
 };
 
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index d2243c7660..8ba2e5c879 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -11,6 +11,26 @@
 
 #include "qom/object.h"
 #include "hw/core/sysbus.h"
+#include "hw/intc/arm_gicv5_types.h"
+
+/*
+ * QEMU interface:
+ *
+ * sysbus MMIO regions (in order matching IRS_IDR0.INT_DOM encoding):
+ * - IRS config frame for the Secure Interrupt Domain
+ * - IRS config frame for the Non-secure Interrupt Domain
+ * - IRS config frame for the EL3 Interrupt Domain
+ * - IRS config frame for the Realm Interrupt Domain
+ *
+ * Note that even if this particular IRS does not implement all four
+ * interrupt domains it will still expose four sysbus MMIO regions.
+ * The regions corresponding to unimplemented domains will always
+ * fail accesses with a decode error. Generally the SoC/board should
+ * probably not map a region for a domain that it configured the IRS
+ * to not implement; the regions are only exposed so that changing
+ * which domains are implemented doesn't reorder which sysbus MMIO
+ * region is which (e.g. NS will always be 1 and EL3 will always be 2).
+ */
 
 #define TYPE_ARM_GICV5_COMMON "arm-gicv5-common"
 
@@ -22,10 +42,40 @@ OBJECT_DECLARE_TYPE(GICv5Common, GICv5CommonClass, ARM_GICV5_COMMON)
  */
 struct GICv5Common {
     SysBusDevice parent_obj;
+
+    MemoryRegion iomem[NUM_GICV5_DOMAINS];
+
+    /* Bits here are set for each physical interrupt domain implemented */
+    uint8_t implemented_domains;
 };
 
 struct GICv5CommonClass {
     SysBusDeviceClass parent_class;
 };
 
+
+#define IRS_CONFIG_FRAME_SIZE 0x10000
+
+/**
+ * gicv5_common_init_irqs_and_mmio: Create IRQs and MMIO regions for the GICv5
+ * @s: GIC object
+ * @ops: array of MemoryRegionOps that implement the config frames behaviour
+ *
+ * Subclasses of ARM_GICV5_COMMON should call this to create the sysbus
+ * MemoryRegions for the IRS config frames, passing in a four element array
+ * of MemoryRegionOps structs.
+ */
+void gicv5_common_init_irqs_and_mmio(GICv5Common *cs,
+                                     const MemoryRegionOps ops[NUM_GICV5_DOMAINS]);
+
+/**
+ * gicv5_domain_implemented: Return true if this IRS implements this domain
+ * @s: GIC object
+ * @domain: domain to check
+ */
+static inline bool gicv5_domain_implemented(GICv5Common *cs, GICv5Domain domain)
+{
+    return cs->implemented_domains & (1 << domain);
+}
+
 #endif
diff --git a/include/hw/intc/arm_gicv5_types.h b/include/hw/intc/arm_gicv5_types.h
new file mode 100644
index 0000000000..143dcdec28
--- /dev/null
+++ b/include/hw/intc/arm_gicv5_types.h
@@ -0,0 +1,28 @@
+/*
+ * Type definitions for GICv5
+ *
+ * This file is for type definitions that we want to share between
+ * the GIC proper and the CPU interface.
+ *
+ * Copyright (c) 2025 Linaro Limited
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_INTC_ARM_GICv5_TYPES_H
+#define HW_INTC_ARM_GICv5_TYPES_H
+
+/*
+ * The GICv5 has four physical Interrupt Domains. This numbering
+ * must match the encoding used in IRS_IDR0.INT_DOM.
+ */
+typedef enum GICv5Domain {
+    GICV5_ID_S = 0,
+    GICV5_ID_NS = 1,
+    GICV5_ID_EL3 = 2,
+    GICV5_ID_REALM = 3,
+} GICv5Domain;
+
+#define NUM_GICV5_DOMAINS 4
+
+#endif
-- 
2.43.0


