Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4F510ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Br-0006Vv-7s; Fri, 27 Mar 2026 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Bg-0006NT-RB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Be-0007iO-5o
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:17:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b9144790dso1094565f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610229; x=1775215029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+a1vwfitmUycYoLhCWK2VU83xMZoXvp5UmVsl5NDqE=;
 b=lEylRPecf3ETM0SZpitVH3iRx5+8a0lGeOD2Esb82yb6HuBZZ1l+QYe7JBN91hULEI
 3HBLmtm/jAHLkxv+ytquagJkohv5z5CSghE0YT7U/prR13ImUxEa70F434OI1wHFjbNI
 jtifb5Dmc5O6B0T8e7rtHH7bDrY7NYTIrTcW7No6mWPCGsZv+PmGzNNUrJGenF7yz8/5
 mE8/kYdxDdNWEwHmt2iU7rXNhaHRchxppViNmZ1pxbFhhtzrWNycOCMwfbx1+IGi5Lom
 jnznG5sCMXNMQKdAHg3TglbVyVDu543At6hCbkMYnHJIZCypnmqerxzszCbGJqVfutYN
 EOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610229; x=1775215029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+a1vwfitmUycYoLhCWK2VU83xMZoXvp5UmVsl5NDqE=;
 b=rDYFyV+IqJhQ1IPR+bMfsE5T7AFBEPKWVw1VafUQj00T3mAz3b0LW5TG9dwHu561Cr
 Riy7Ygkky3MyKPyUaJts2DHWZlAkXem+ASLfVTX1gW5EEQMWUeuckLwsHUXf3+a8Dds2
 JUfobkFTMzoHNBfo826iqdaBj7HqFF/VLlZGy2oGO2t1ijFGK33942l3ZYzEz2yh9VFj
 OMEZZ0vuj4HW4tVcnzovKfBwkiU50ipW0Bo1niH1UH0qvmK3VEN3IIBQwUZWPEcQHhFl
 J2JdSPlECfkai+NkksUrNbqsJoIGMHD+LVMBkFzJMLvyyKEiqMe1NeH7AE1CRduEHS6F
 hyvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdW2qX3BAREO9k39cjVTqGXqoQsUn/alQdRs1ig3QegOpsldpoK3RZvEgVy+lbvdnKCFirHU9Nmnck@nongnu.org
X-Gm-Message-State: AOJu0YxfEOvApBrmG+J5KVxeksDR+ZRPOEGafkkl95i4lQXt/BcW8BD9
 k6YlAVW0SYMns6gkoUEe8n+Sg7XXeCUx8lWRyuhnm/Dxmd1O43i5RytgYgqy70h0iEEt8Szih3k
 HVGCFyno=
X-Gm-Gg: ATEYQzxREGyK6hzzppVt2fdMMzBBlc4bBd6fjOMJtX3jkpX8+ymD62OGc4KyS1DJAeS
 c921VoF70LnP3z8D46r9iDZQeXBbdjMXr1r7jHNQUslnVb59FC+vpFCyQj7+KPF+l+KpP2yLnI7
 7PshchhwBgWCxHMa2BDmR/YFb1HmXGUtWwGWIFk18zcmORny3qIL0mNuCORNeKEZmkOX3It6d4I
 zL23G4Xql1x0QhpUewROjvtIzOwJkHhvDdMqZBpM6wDBWbaZ/WM3b1Jd53XXm1DXEFLjyVzSVDj
 7SuUJVRF7Bkn30YKDzA/OhVgJfM0u7YMzeqvxmquey2acmaziWXrMN2UEUtAtC38M0bmJUJYorf
 J26gLBsSM/L/Il3IN4ppIq8tpWMlfgU/peGv+uEsrZsVnPUtbj519TcM+4mIWuMJ3MrgRg4SLmA
 YLfO6gNFTvNthcE6Xy6CUdJ9ZToJYp3WmVu67TUCHGRERjZZoqfDwkqUyBVunR2SvZbgB+DZ6Zz
 NCWjcB9p/FDcicnpLZv/9rdi7a9dj0=
X-Received: by 2002:a05:6000:613:b0:43b:8766:600b with SMTP id
 ffacd0b85a97d-43b9ea11981mr3393090f8f.49.1774610228476; 
 Fri, 27 Mar 2026 04:17:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:17:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 07/65] hw/intc/arm_gicv5: Create and validate QOM properties
Date: Fri, 27 Mar 2026 11:16:02 +0000
Message-ID: <20260327111700.795099-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Add code to the GICv5 skeleton which creates the QOM properties which
the board or SoC can use to configure the GIC, and the validation
code to check they are in range.  Generally these correspond to
fields in the IRS ID registers, and the properties are named
correspondingly.

Notable here is that unlike the GICv3 (which assumes its connected
CPUs are the system's CPUs starting from 0), we define a QOM array
property which is an array of pointers to the CPUs, and a QOM array
property which is an array of integers telling the GIC what the
IAFFID (interrupt affinity ID) for each CPU is; so a board or SoC
which wants to connect multiple CPUs to this GICv5 would do something
like:

    QList *cpulist = qlist_new(), *iaffidlist = qlist_new();

    for (int i = 0; i < ms->smp.cpus; i++) {
        qlist_append_link(cpulist, OBJECT(qemu_get_cpu(i)));
        qlist_append_int(iaffidlist, i);
    }
    qdev_prop_set_array(vms->gic, "cpus", cpulist);
    qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/intc/arm_gicv5_common.c         | 80 ++++++++++++++++++++++++++++++
 hw/intc/trace-events               |  3 ++
 include/hw/intc/arm_gicv5_common.h | 25 ++++++++++
 3 files changed, 108 insertions(+)

diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index bf990bfa54..3448734686 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -8,9 +8,15 @@
 
 #include "qemu/osdep.h"
 #include "hw/intc/arm_gicv5_common.h"
+#include "hw/core/qdev-properties.h"
+#include "qapi/error.h"
+#include "trace.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(GICv5Common, gicv5_common, ARM_GICV5_COMMON, SYS_BUS_DEVICE)
 
+/* Any value > 2^24 is out of the valid range for this property */
+#define GICV5_SPI_IRS_RANGE_NOT_SET 0xffffffff
+
 static bool bad_frame_accepts(void *opaque, hwaddr addr, unsigned size,
                               bool is_write, MemTxAttrs attrs)
 {
@@ -58,9 +64,83 @@ static void gicv5_common_finalize(Object *obj)
 {
 }
 
+static void gicv5_common_realize(DeviceState *dev, Error **errp)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(dev);
+
+    if (cs->num_cpus == 0) {
+        error_setg(errp, "The cpus array property must have at least one CPU");
+        return;
+    }
+    if (cs->num_cpus >= (1 << 16)) {
+        /* We'll hit other QEMU limits long before this one :-) */
+        error_setg(errp, "Number of CPUs exceeds GICv5 architectural maximum");
+        return;
+    }
+    if (cs->num_cpus != cs->num_cpu_iaffids) {
+        error_setg(errp, "The cpu-iaffids array property must be the same size "
+                   "as the cpus array property");
+        return;
+    }
+    if (cs->irsid >= (1 << 16)) {
+        error_setg(errp, "irsid (%u) is more than 2^16-1", cs->irsid);
+        return;
+    }
+    if (cs->spi_range > (1 << 24)) {
+        /*
+         * Note that IRS_IDR5.SPI_RANGE is a 25 bit field but the largest
+         * architecturally permitted value is 2^24 (not 2^25-1), hence
+         * use of > in the range check.
+         */
+        error_setg(errp, "spi-range (%u) is more than 2^24", cs->spi_range);
+        return;
+    }
+    if (cs->spi_irs_range == GICV5_SPI_IRS_RANGE_NOT_SET) {
+        /* spi-irs-range defaults to same as spi-range */
+        cs->spi_irs_range = cs->spi_range;
+    }
+    if (cs->spi_irs_range > (1 << 24)) {
+        /* Similarly IRS_IDR6.SPI_IRS_RANGE */
+        error_setg(errp, "spi-irs-range (%u) is more than 2^24",
+                   cs->spi_irs_range);
+        return;
+    }
+    if (cs->spi_base >= (1 << 24)) {
+        /* IRS_IDR7.SPI_BASE is a 24-bit field, so range check is >= */
+        error_setg(errp, "spi-base (%u) is more than 2^24-1", cs->spi_base);
+        return;
+    }
+    /* range checks above mean we know this addition won't overflow */
+    if (cs->spi_base + cs->spi_irs_range > cs->spi_range) {
+        error_setg(errp, "spi-base (%u) + spi-irs-range (%u) is "
+                   "more than spi-range (%u)",
+                   cs->spi_base, cs->spi_irs_range, cs->spi_range);
+        return;
+    }
+
+    trace_gicv5_common_realize(cs->irsid, cs->num_cpus,
+                               cs->spi_base, cs->spi_irs_range, cs->spi_range);
+}
+
+static const Property arm_gicv5_common_properties[] = {
+    DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
+                           cpus, TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
+                      cpu_iaffids, qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
+    DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
+    DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
+    DEFINE_PROP_UINT32("spi-irs-range", GICv5Common, spi_irs_range,
+                       GICV5_SPI_IRS_RANGE_NOT_SET),
+};
+
 static void gicv5_common_class_init(ObjectClass *oc, const void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     rc->phases.hold = gicv5_common_reset_hold;
+
+    dc->realize = gicv5_common_realize;
+    device_class_set_props(dc, arm_gicv5_common_properties);
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index edd3c49c5f..54777f6da3 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -233,6 +233,9 @@ gicv5_badread(const char *domain, uint64_t offset, unsigned size) "GICv5 IRS %s
 gicv5_write(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 gicv5_badwrite(const char *domain, uint64_t offset, uint64_t data, unsigned size) "GICv5 IRS %s config frame write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u: error"
 
+# arm_gicv5_common.c
+gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
+
 # armv7m_nvic.c
 nvic_recompute_state(int vectpending, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d vectpending_prio %d exception_prio %d"
 nvic_recompute_state_secure(int vectpending, bool vectpending_is_s_banked, int vectpending_prio, int exception_prio) "NVIC state recomputed: vectpending %d is_s_banked %d vectpending_prio %d exception_prio %d"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index b7a17aac31..ea01b2a1db 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -12,10 +12,24 @@
 #include "qom/object.h"
 #include "hw/core/sysbus.h"
 #include "hw/intc/arm_gicv5_types.h"
+#include "target/arm/cpu-qom.h"
 
 /*
  * QEMU interface:
  *
+ * + QOM array property "cpus": CPUState pointers to each CPU
+ *   connected to this IRS.
+ * + QOM array property "cpu-iaffids": array of uint32_t giving the
+ *   IAFFID for each CPU in the "cpus" property array
+ * + QOM property "irsid": unique identifier for this IRS in the system
+ *   (this is IRS_IDR0.IRSID); default is 0
+ * + QOM property "spi-range": total number of SPIs in the system
+ *   IRS (this is IRS_IDR5.SPI_RANGE); must be set
+ * + QOM property "spi-base": minimum SPI INTID.ID implemented on this
+ *   IRS (this is IRS_IDR7.SPI_BASE); default is 0
+ * + QOM property "spi-irs-range": number of SPI INTID.ID managed on this
+ *   IRS (this is IRS_IDR6.SPI_IRS_RANGE); defaults to value of spi-range
+ *
  * sysbus MMIO regions (in order matching IRS_IDR0.INT_DOM encoding):
  * - IRS config frame for the Secure Interrupt Domain
  * - IRS config frame for the Non-secure Interrupt Domain
@@ -47,6 +61,17 @@ struct GICv5Common {
 
     /* Bits here are set for each physical interrupt domain implemented */
     uint8_t implemented_domains;
+
+    /* Properties */
+    uint32_t num_cpus;
+    ARMCPU **cpus;
+    uint32_t num_cpu_iaffids;
+    uint32_t *cpu_iaffids;
+
+    uint32_t irsid;
+    uint32_t spi_base;
+    uint32_t spi_irs_range;
+    uint32_t spi_range;
 };
 
 struct GICv5CommonClass {
-- 
2.43.0


