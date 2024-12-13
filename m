Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96104E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3j-0005xV-KO; Fri, 13 Dec 2024 14:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3V-0005bt-Sh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:31 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3S-00071x-8f
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:28 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e163493efso1027284a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117025; x=1734721825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t1hIg4oc5GY14Zd4SHmDtJmfPLkCBWu0upl9dxEz8/g=;
 b=wusnv8ahmN3PpSSBE/ov7vXZTh9qCvnnVvhIXXnxRWWatcXhO1pGqTGQ4f6wmkbU0c
 blRDpu3/m9aXMcTIwwh7rzfmDKo5esQBYcpHwhS0vSZSeqQuZvn8yoRQlc8+JkTyF8ho
 2qrTCpNH6UrNGO8kpl+FrH9wNpQ/9yiAQM2C2QYZHZbDQUwPREMh+OIwCVURja6mXzmg
 GByoagGP63MN8QKTm3Fq6eWHe/uo3bSfvygWwYX9LOjC0LVHpy+bX689p5lCxrLms1Ol
 Dpt8jTCOsxAdNH510f9neEhElZF0HFzOTuFLaivaUqdyU/HMsw0MNWC1auSlI2ASP3py
 k1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117025; x=1734721825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t1hIg4oc5GY14Zd4SHmDtJmfPLkCBWu0upl9dxEz8/g=;
 b=IytUgGwv1t/AJWVodk9vvWC9YEQCLlRAjlKzAP4my6rXNG+ZkwbTRmZ8oEyiUz919a
 gmsa9mqv5HyRxZjGHeZ9q0MLRMyX9DKO2xgesa7NtKN2daSA//J9aa01uxs2BmxB+c6g
 2a+jsHFCB/82z1ZVb7LUDlnTj7qlldc5ZFKkWKKZtDHD9I7EN4f55cAn9/HjJCaRWmVw
 8a5cZq/L6E9GDiKOLc8ARv25LtTxn8Bcxa+gDfYzkPaa7dlrd7eKXZH9TjsTObwCGMQ4
 n4JziS/B3JaNQVrBD13jFmWvttcPLq/8KCO5crw9rkIfOmWX2zLJDMYurzLIGj8yHyU8
 L96g==
X-Gm-Message-State: AOJu0Yw+dxkaOAlIw0GRjDsv/DBYiLUx/LDfDYrK/+0YBhri8LVlDOOk
 5/8188PwrzTFjAV5LjDTs9XLvTGxIqLKR7TaDsTHtEVgfJlrXE9cGJFtLD5wpoln5hkyxJ/kUdw
 I2fEQVBfO
X-Gm-Gg: ASbGncuszzqjU+KsIFcL0DdHTh4rOZsxxCHKtloSQ2L71pXXiV1cxIUYADe0d8VynOV
 LFhuKA0sZmJ4frVJ4sNiqybzbNrrvT9qdHiLwuVFWU7i/nzkqVVYVIfWePtQcxiT4AJwSRPg7vg
 eaNjwOdIVBwHW1VS8Qs0TnkNdJKe2T0h2bH6CAiOvDe+nX6bHvIQo+Ygf08OYj4Xcx9Le52k71C
 AyfUNe0lz7jFVVxshrPUKpA1WFzlUCzJ6LP6lJ44Do5FK1rO/bdmfJpfOGHdcp5
X-Google-Smtp-Source: AGHT+IHwfk+yWhygf0MTMKyExMm9RZrHBdGyaRiigL/H+X/LC3MhVRZSqRde0AcS403E+WEtKhsmHQ==
X-Received: by 2002:a05:6830:700f:b0:71d:ffa2:d34d with SMTP id
 46e09a7af769-71e3b879bbbmr2283286a34.16.1734117025113; 
 Fri, 13 Dec 2024 11:10:25 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH 29/71] hw/i386: Constify all Property
Date: Fri, 13 Dec 2024 13:07:03 -0600
Message-ID: <20241213190750.2513964-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/i386/amd_iommu.c        | 2 +-
 hw/i386/intel_iommu.c      | 2 +-
 hw/i386/kvm/clock.c        | 2 +-
 hw/i386/kvm/i8254.c        | 2 +-
 hw/i386/kvm/ioapic.c       | 2 +-
 hw/i386/sgx-epc.c          | 2 +-
 hw/i386/vmmouse.c          | 2 +-
 hw/i386/vmport.c           | 2 +-
 hw/i386/x86-iommu.c        | 2 +-
 hw/i386/xen/xen_pvdevice.c | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index af0f4da1f6..ca3e62a244 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1668,7 +1668,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     amdvi_init(s);
 }
 
-static Property amdvi_properties[] = {
+static const Property amdvi_properties[] = {
     DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4c0d1d7d47..a5b268342f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3404,7 +3404,7 @@ static const MemoryRegionOps vtd_mem_ops = {
     },
 };
 
-static Property vtd_properties[] = {
+static const Property vtd_properties[] = {
     DEFINE_PROP_UINT32("version", IntelIOMMUState, version, 0),
     DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
                             ON_OFF_AUTO_AUTO),
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 40aa9a32c3..71150ed2e0 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -305,7 +305,7 @@ static const VMStateDescription kvmclock_vmsd = {
     }
 };
 
-static Property kvmclock_properties[] = {
+static const Property kvmclock_properties[] = {
     DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
                       mach_use_reliable_get_clock, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index baa4b39582..2933d3f458 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -287,7 +287,7 @@ static void kvm_pit_realizefn(DeviceState *dev, Error **errp)
     kpc->parent_realize(dev, errp);
 }
 
-static Property kvm_pit_properties[] = {
+static const Property kvm_pit_properties[] = {
     DEFINE_PROP_LOSTTICKPOLICY("lost_tick_policy", KVMPITState,
                                lost_tick_policy, LOST_TICK_POLICY_DELAY),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 2907b08164..217ff43b98 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -133,7 +133,7 @@ static void kvm_ioapic_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, kvm_ioapic_set_irq, IOAPIC_NUM_PINS);
 }
 
-static Property kvm_ioapic_properties[] = {
+static const Property kvm_ioapic_properties[] = {
     DEFINE_PROP_UINT32("gsi_base", KVMIOAPICState, kvm_gsi_base, 0),
     DEFINE_PROP_END_OF_LIST()
 };
diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d664829d35..c232e825e0 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -19,7 +19,7 @@
 #include "target/i386/cpu.h"
 #include "exec/address-spaces.h"
 
-static Property sgx_epc_properties[] = {
+static const Property sgx_epc_properties[] = {
     DEFINE_PROP_UINT64(SGX_EPC_ADDR_PROP, SGXEPCDevice, addr, 0),
     DEFINE_PROP_UINT32(SGX_EPC_NUMA_NODE_PROP, SGXEPCDevice, node, 0),
     DEFINE_PROP_LINK(SGX_EPC_MEMDEV_PROP, SGXEPCDevice, hostmem,
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 76130cd46d..da9c35c1ec 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -317,7 +317,7 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
     vmport_register(VMPORT_CMD_VMMOUSE_DATA, vmmouse_ioport_read, s);
 }
 
-static Property vmmouse_properties[] = {
+static const Property vmmouse_properties[] = {
     DEFINE_PROP_LINK("i8042", VMMouseState, i8042, TYPE_I8042, ISAKBDState *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index 7cc75dbc6d..cab6e72089 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -252,7 +252,7 @@ static void vmport_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
-static Property vmport_properties[] = {
+static const Property vmport_properties[] = {
     /* Used to enforce compatibility for migration */
     DEFINE_PROP_BIT("x-read-set-eax", VMPortState, compat_flags,
                     VMPORT_COMPAT_READ_SET_EAX_BIT, true),
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 60af896225..155f6262ea 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -125,7 +125,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property x86_iommu_properties[] = {
+static const Property x86_iommu_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
                             intr_supported, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index ed621531d8..e71483e6e3 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -115,7 +115,7 @@ static void xen_pv_realize(PCIDevice *pci_dev, Error **errp)
                      &d->mmio);
 }
 
-static Property xen_pv_props[] = {
+static const Property xen_pv_props[] = {
     DEFINE_PROP_UINT16("vendor-id", XenPVDevice, vendor_id, PCI_VENDOR_ID_XEN),
     DEFINE_PROP_UINT16("device-id", XenPVDevice, device_id, 0xffff),
     DEFINE_PROP_UINT8("revision", XenPVDevice, revision, 0x01),
-- 
2.43.0


