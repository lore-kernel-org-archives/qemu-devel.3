Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15885EE49BC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOqc-0000Xd-2f; Wed, 11 Sep 2024 11:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOjO-0005Zg-Nc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOjM-0007Kf-8I
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Jbb3zSd/FAyigLmm8Lyz5T3+QqcWo7wpMZLcIaqupo=;
 b=dkR4Fz7kS0LBnYfMQ7eUyVsUd6ibCM8UOiIzWtLPX5MAS7N7a2JDr+7XfZgvhgDto3kGCS
 0EXDngq7++dDYeUvi2VzS0HaGD/8bA9DpGVb/jcJHL71t81VcswPSvLtKHkX1Dk8MUS4Qn
 Cns+RXr86+X67sj1zmnqFeuxcddyb9o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-U_Vu12O9MAaTryrxCbcBUA-1; Wed, 11 Sep 2024 09:52:27 -0400
X-MC-Unique: U_Vu12O9MAaTryrxCbcBUA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c3c398b511so5902301a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062745; x=1726667545;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Jbb3zSd/FAyigLmm8Lyz5T3+QqcWo7wpMZLcIaqupo=;
 b=klS0f7B4hHHqs0K5I6tzo3JKoyf0V4oDB3tOUfCxfZhHoe8dwLAgXRm0c+pWGB2zzp
 JB1oqRajKo0dbq4YYl1GRude0cLaITDzUvOmtglQcKiJQ8DFKKvpX2nX2HimejMPsLcP
 m9rZx4XjQRcaZJJ3k3uxncuIU+N8Qr9guhbSaJrShMvCyyI2dPYn1gizJjSyjWRI6vO1
 +XiSl1vxA3bLihPO3riQU1pserOHSubkQZDg3mC/rJOiSUisiHTeKl5ZJCH8TtoBIQ5N
 wrcHqOdLFLjqM1UKIaxwitTuLr3kq82gZ/hWqiB1lJT7FJEw1h9S8WSPDaP2qK7sNw+v
 od9A==
X-Gm-Message-State: AOJu0YwnG5Ki1YMhlqP9VXmDSzQwT4U34QaaCXoKHngEnv2+OVtbZT1l
 YjSiX4L2XL+b+frU/d6HtKNhEqTzPyoaS/lqvPXudlLRU83wd6TtdpE2+95vDMWfc0BUkNYA5y8
 59B0xNw5KZ/tYtx1UcxxZvfTm4GI6ruKhDcM80ZZ8ISFVGKUjEISLVF9ykz6xzVmKuSArK2A9qR
 gbsdV5KmLUu8fargOkkVqpiE2ojcBbOw==
X-Received: by 2002:a05:6402:5188:b0:5c3:9fa9:1b72 with SMTP id
 4fb4d7f45d1cf-5c3e95335d1mr13501485a12.6.1726062745174; 
 Wed, 11 Sep 2024 06:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYbuGXOLRVFU4WvXWJNIWM/47EeOtk49Kxsno0na54m4y3am4dPgDW5XboDfLP1T0Ph57CpA==
X-Received: by 2002:a05:6402:5188:b0:5c3:9fa9:1b72 with SMTP id
 4fb4d7f45d1cf-5c3e95335d1mr13501446a12.6.1726062744563; 
 Wed, 11 Sep 2024 06:52:24 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cdf7sm5424056a12.92.2024.09.11.06.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:24 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Dominic Prinz <git@dprinz.de>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/18] hw/acpi/ich9: Add periodic and swsmi timer
Message-ID: <6e3c2d58e967cde3dadae298e81c5e8eb9fb9080.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dominic Prinz <git@dprinz.de>

This patch implements the periodic and the swsmi ICH9 chipset timers. They are
especially useful when prototyping UEFI firmware (e.g. with EDK2's OVMF)
using QEMU.

For backwards compatibility, the compat properties "x-smi-swsmi-timer",
and "x-smi-periodic-timer" are introduced.

Additionally, writes to the SMI_STS register are enabled for the
corresponding two bits using a write mask to make future work easier.

Signed-off-by: Dominic Prinz <git@dprinz.de>
Message-Id: <1d90ea69e01ab71a0f2ced116801dc78e04f4448.1725991505.git.git@dprinz.de>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/ich9.h        |  6 +++
 include/hw/acpi/ich9_timer.h  | 23 +++++++++
 include/hw/southbridge/ich9.h |  4 ++
 hw/acpi/ich9.c                | 23 +++++++++
 hw/acpi/ich9_timer.c          | 93 +++++++++++++++++++++++++++++++++++
 hw/i386/pc.c                  |  5 +-
 hw/isa/lpc_ich9.c             | 14 ++++++
 hw/acpi/meson.build           |  2 +-
 8 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/acpi/ich9_timer.h
 create mode 100644 hw/acpi/ich9_timer.c

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 2faf7f0cae..245fe08dc2 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -46,6 +46,7 @@ typedef struct ICH9LPCPMRegs {
     uint32_t smi_en;
     uint32_t smi_en_wmask;
     uint32_t smi_sts;
+    uint32_t smi_sts_wmask;
 
     qemu_irq irq;      /* SCI */
 
@@ -68,6 +69,11 @@ typedef struct ICH9LPCPMRegs {
     bool smm_compat;
     bool enable_tco;
     TCOIORegs tco_regs;
+
+    bool swsmi_timer_enabled;
+    bool periodic_timer_enabled;
+    QEMUTimer *swsmi_timer;
+    QEMUTimer *periodic_timer;
 } ICH9LPCPMRegs;
 
 #define ACPI_PM_PROP_TCO_ENABLED "enable_tco"
diff --git a/include/hw/acpi/ich9_timer.h b/include/hw/acpi/ich9_timer.h
new file mode 100644
index 0000000000..5112df4385
--- /dev/null
+++ b/include/hw/acpi/ich9_timer.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU ICH9 Timer emulation
+ *
+ * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_ACPI_ICH9_TIMER_H
+#define HW_ACPI_ICH9_TIMER_H
+
+#include "hw/acpi/ich9.h"
+
+void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable);
+
+void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm);
+
+void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable);
+
+void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm);
+
+#endif
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index fd01649d04..6c60017024 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -196,8 +196,12 @@ struct ICH9LPCState {
 #define ICH9_PMIO_GPE0_LEN                      16
 #define ICH9_PMIO_SMI_EN                        0x30
 #define ICH9_PMIO_SMI_EN_APMC_EN                (1 << 5)
+#define ICH9_PMIO_SMI_EN_SWSMI_EN               (1 << 6)
 #define ICH9_PMIO_SMI_EN_TCO_EN                 (1 << 13)
+#define ICH9_PMIO_SMI_EN_PERIODIC_EN            (1 << 14)
 #define ICH9_PMIO_SMI_STS                       0x34
+#define ICH9_PMIO_SMI_STS_SWSMI_STS             (1 << 6)
+#define ICH9_PMIO_SMI_STS_PERIODIC_STS          (1 << 14)
 #define ICH9_PMIO_TCO_RLD                       0x60
 #define ICH9_PMIO_TCO_LEN                       32
 
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 02d8546bd3..c15e5b8281 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -35,6 +35,7 @@
 #include "sysemu/runstate.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9_tco.h"
+#include "hw/acpi/ich9_timer.h"
 
 #include "hw/southbridge/ich9.h"
 #include "hw/mem/pc-dimm.h"
@@ -108,6 +109,18 @@ static void ich9_smi_writel(void *opaque, hwaddr addr, uint64_t val,
         }
         pm->smi_en &= ~pm->smi_en_wmask;
         pm->smi_en |= (val & pm->smi_en_wmask);
+        if (pm->swsmi_timer_enabled) {
+            ich9_pm_update_swsmi_timer(pm, pm->smi_en &
+                                               ICH9_PMIO_SMI_EN_SWSMI_EN);
+        }
+        if (pm->periodic_timer_enabled) {
+            ich9_pm_update_periodic_timer(pm, pm->smi_en &
+                                                  ICH9_PMIO_SMI_EN_PERIODIC_EN);
+        }
+        break;
+    case 4:
+        pm->smi_sts &= ~pm->smi_sts_wmask;
+        pm->smi_sts |= (val & pm->smi_sts_wmask);
         break;
     }
 }
@@ -286,6 +299,8 @@ static void pm_powerdown_req(Notifier *n, void *opaque)
 
 void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 {
+    pm->smi_sts_wmask = 0;
+
     memory_region_init(&pm->io, OBJECT(lpc_pci), "ich9-pm", ICH9_PMIO_SIZE);
     memory_region_set_enabled(&pm->io, false);
     memory_region_add_subregion(pci_address_space_io(lpc_pci),
@@ -305,6 +320,14 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
                           "acpi-smi", 8);
     memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
 
+    if (pm->swsmi_timer_enabled) {
+        ich9_pm_swsmi_timer_init(pm);
+    }
+
+    if (pm->periodic_timer_enabled) {
+        ich9_pm_periodic_timer_init(pm);
+    }
+
     if (pm->enable_tco) {
         acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
diff --git a/hw/acpi/ich9_timer.c b/hw/acpi/ich9_timer.c
new file mode 100644
index 0000000000..5b1c910156
--- /dev/null
+++ b/hw/acpi/ich9_timer.c
@@ -0,0 +1,93 @@
+/*
+ * QEMU ICH9 Timer emulation
+ *
+ * Copyright (c) 2024 Dominic Prinz <git@dprinz.de>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/cpu.h"
+#include "hw/pci/pci.h"
+#include "hw/southbridge/ich9.h"
+#include "qemu/timer.h"
+
+#include "hw/acpi/ich9_timer.h"
+
+void ich9_pm_update_swsmi_timer(ICH9LPCPMRegs *pm, bool enable)
+{
+    uint16_t swsmi_rate_sel;
+    int64_t expire_time;
+    ICH9LPCState *lpc;
+
+    if (enable) {
+        lpc = container_of(pm, ICH9LPCState, pm);
+        swsmi_rate_sel =
+            (pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_3) & 0xc0) >> 6;
+
+        if (swsmi_rate_sel == 0) {
+            expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 1500000LL;
+        } else {
+            expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                          8 * (1 << swsmi_rate_sel) * 1000000LL;
+        }
+
+        timer_mod(pm->swsmi_timer, expire_time);
+    } else {
+        timer_del(pm->swsmi_timer);
+    }
+}
+
+static void ich9_pm_swsmi_timer_expired(void *opaque)
+{
+    ICH9LPCPMRegs *pm = opaque;
+
+    pm->smi_sts |= ICH9_PMIO_SMI_STS_SWSMI_STS;
+    ich9_generate_smi();
+
+    ich9_pm_update_swsmi_timer(pm, pm->smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
+}
+
+void ich9_pm_swsmi_timer_init(ICH9LPCPMRegs *pm)
+{
+    pm->smi_sts_wmask |= ICH9_PMIO_SMI_STS_SWSMI_STS;
+    pm->swsmi_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_swsmi_timer_expired, pm);
+}
+
+void ich9_pm_update_periodic_timer(ICH9LPCPMRegs *pm, bool enable)
+{
+    uint16_t per_smi_sel;
+    int64_t expire_time;
+    ICH9LPCState *lpc;
+
+    if (enable) {
+        lpc = container_of(pm, ICH9LPCState, pm);
+        per_smi_sel = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1) & 3;
+        expire_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                      8 * (1 << (3 - per_smi_sel)) * NANOSECONDS_PER_SECOND;
+
+        timer_mod(pm->periodic_timer, expire_time);
+    } else {
+        timer_del(pm->periodic_timer);
+    }
+}
+
+static void ich9_pm_periodic_timer_expired(void *opaque)
+{
+    ICH9LPCPMRegs *pm = opaque;
+
+    pm->smi_sts = ICH9_PMIO_SMI_STS_PERIODIC_STS;
+    ich9_generate_smi();
+
+    ich9_pm_update_periodic_timer(pm,
+                                  pm->smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
+}
+
+void ich9_pm_periodic_timer_init(ICH9LPCPMRegs *pm)
+{
+    pm->smi_sts_wmask |= ICH9_PMIO_SMI_STS_PERIODIC_STS;
+    pm->periodic_timer =
+        timer_new_ns(QEMU_CLOCK_VIRTUAL, ich9_pm_periodic_timer_expired, pm);
+}
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ba0ff51183..8d84c22458 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,7 +79,10 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_9_1[] = {};
+GlobalProperty pc_compat_9_1[] = {
+    { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
+    { "ICH9-LPC", "x-smi-periodic-timer", "off" },
+};
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
 GlobalProperty pc_compat_9_0[] = {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index bd727b2320..ab17b76f54 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -43,6 +43,7 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ich9.h"
+#include "hw/acpi/ich9_timer.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/runstate.h"
@@ -531,6 +532,15 @@ ich9_lpc_pmcon_update(ICH9LPCState *lpc)
     uint16_t gen_pmcon_1 = pci_get_word(lpc->d.config + ICH9_LPC_GEN_PMCON_1);
     uint16_t wmask;
 
+    if (lpc->pm.swsmi_timer_enabled) {
+        ich9_pm_update_swsmi_timer(
+            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_SWSMI_EN);
+    }
+    if (lpc->pm.periodic_timer_enabled) {
+        ich9_pm_update_periodic_timer(
+            &lpc->pm, lpc->pm.smi_en & ICH9_PMIO_SMI_EN_PERIODIC_EN);
+    }
+
     if (gen_pmcon_1 & ICH9_LPC_GEN_PMCON_1_SMI_LOCK) {
         wmask = pci_get_word(lpc->d.wmask + ICH9_LPC_GEN_PMCON_1);
         wmask &= ~ICH9_LPC_GEN_PMCON_1_SMI_LOCK;
@@ -826,6 +836,10 @@ static Property ich9_lpc_properties[] = {
                       ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT, true),
     DEFINE_PROP_BIT64("x-smi-cpu-hotunplug", ICH9LPCState, smi_host_features,
                       ICH9_LPC_SMI_F_CPU_HOT_UNPLUG_BIT, true),
+    DEFINE_PROP_BOOL("x-smi-swsmi-timer", ICH9LPCState,
+                     pm.swsmi_timer_enabled, true),
+    DEFINE_PROP_BOOL("x-smi-periodic-timer", ICH9LPCState,
+                     pm.periodic_timer_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db90..7f8ccc9b7a 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -24,7 +24,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
 acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
-- 
MST


