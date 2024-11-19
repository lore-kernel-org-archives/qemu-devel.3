Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF0BD6C28C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTjD-0002mb-MI; Tue, 19 Nov 2024 14:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTjB-0002lq-NQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:33 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj9-0007g4-3J
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:33 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-724a96f188cso1632314b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043849; x=1732648649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et/XKpCq8FfunkNiTWjfwypcxxKP1J2/i2fCKASeod0=;
 b=eYpnRiErAWqKtqmVd4BnnoWJstZDA1Wp6jeCbJXMRK3bdmF/W/Nj32XgV3bAZlv9eg
 iKvN75W8RpTtzu5EE+3t7wKbnSQLfV5RA9gNYmlCCqFeseKbNY5KXm1qc4M6U6CNb4+c
 YBs8Cq4vPShEcnub5KRNqWc1fdLx0fjaCsYZE5vTh19eS5SFuQbot895ZcJf++ku9YS0
 F0nrAk4dqaPjXmZR3Y21sW1dzQZy3Pjm0OxYRYtKimHCgnPl4cmySofIOaAsOlYslFHg
 OnOj2u3SAJB+8aPGNtbGYqnaHL1OOb/XBn+2f5ABA4JjUeopFtbCiTIKH8BfhczbMphp
 e5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043849; x=1732648649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=et/XKpCq8FfunkNiTWjfwypcxxKP1J2/i2fCKASeod0=;
 b=PpReuYw/pz9i2QY6lTB5JqCNUCPDwM1KSbjE5z17lNBvPHbmwR37E0PKXqiF2db5FR
 VzxGpghIqIFsnQFvvi81VxtQEeQENSSV+21ClV/IIfqBIJLiFNI5D82SqfvM0Hb3YrSO
 r0gzxUNlv3K+3uy4+LWJbvP5ib6yuT1rOQXA0GCe1/Impwjj8NzuDXKfLNsDa/0Gtpei
 l97gq3FypSW0hkiMeDGPGvvuCkHAL9alJGMbgSOfdac5L1gkn6lNoNdxlTHbNpMd2aou
 VYwF1TQWKtZLgRIGkVz28FGb+5JMR/pV5yaWzJw/YOWjLlBzoszDpFLlTqz77ADHr0Fu
 Be5w==
X-Gm-Message-State: AOJu0YwGquZE6ZjVbFBFtz8bumZFZGN20FG2GSw3SxXQ8DXbt+5go5oI
 RLgjz4srQfBCC/P9ZWNx5yGBELk8uZJ+/I7embS84M6tbuKwjg/dS5r/8KTKI1i+CC2SvLa25Of
 x
X-Google-Smtp-Source: AGHT+IF2aBWtd8Mn1XU+YpwStt3yD/YqROSZx9NvYOIy5/mwcuqTEPhkDoMwFnzD3m0tbc8+T7QHNg==
X-Received: by 2002:a17:902:e5c9:b0:20b:ce88:1b9d with SMTP id
 d9443c01a7336-211d0ec0544mr221588405ad.45.1732043849548; 
 Tue, 19 Nov 2024 11:17:29 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:29 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 6/8] hw/intc/riscv_aplic: add kvm_msicfgaddr for
 split mode aplic-imsic
Date: Tue, 19 Nov 2024 16:17:04 -0300
Message-ID: <20241119191706.718860-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42c.google.com
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

The last step to enable KVM AIA aplic-imsic with irqchip in split mode
is to deal with how MSIs are going to be sent. In our current design we
don't allow an APLIC controller to send MSIs unless it's on m-mode. And
we also do not allow Supervisor MSI address configuration via the
'smsiaddrcfg' and 'smsiaddrcfgh' registers unless it's also a m-mode
APLIC controller.

Add a new RISCVACPLICState attribute called 'kvm_msicfgaddr'. This
attribute represents the base configuration address for MSIs, in our
case the base addr of the IMSIC controller. This attribute is being set
only when running irqchip_split() mode with aia=aplic-imsic.

During riscv_aplic_msi_send() we'll check if the attribute was set to
skip the check for a m-mode APLIC controller and to change the resulting
MSI addr by adding kvm_msicfgaddr right before address_space_stl_le().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c         | 42 +++++++++++++++++++++++++++--------
 hw/riscv/virt.c               |  6 ++++-
 include/hw/intc/riscv_aplic.h |  6 +++++
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 0696e20ddf..4de458e395 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -177,6 +177,16 @@ bool riscv_use_emulated_aplic(bool msimode)
 #endif
 }
 
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr)
+{
+#ifdef CONFIG_KVM
+    if (riscv_use_emulated_aplic(aplic->msimode)) {
+        aplic->kvm_msicfgaddr = extract64(addr, 0, 32);
+        aplic->kvm_msicfgaddrH = extract64(addr, 32, 32);
+    }
+#endif
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -377,13 +387,16 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     uint32_t lhxs, lhxw, hhxs, hhxw, group_idx, msicfgaddr, msicfgaddrH;
 
     aplic_m = aplic;
-    while (aplic_m && !aplic_m->mmode) {
-        aplic_m = aplic_m->parent;
-    }
-    if (!aplic_m) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\n",
-                      __func__);
-        return;
+
+    if (!aplic->kvm_splitmode) {
+        while (aplic_m && !aplic_m->mmode) {
+            aplic_m = aplic_m->parent;
+        }
+        if (!aplic_m) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: m-level APLIC not found\n",
+                          __func__);
+            return;
+        }
     }
 
     if (aplic->mmode) {
@@ -415,6 +428,11 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
     addr |= (uint64_t)(guest_idx & APLIC_xMSICFGADDR_PPN_HART(lhxs));
     addr <<= APLIC_xMSICFGADDR_PPN_SHIFT;
 
+    if (aplic->kvm_splitmode) {
+        addr |= aplic->kvm_msicfgaddr;
+        addr |= ((uint64_t)aplic->kvm_msicfgaddrH << 32);
+    }
+
     address_space_stl_le(&address_space_memory, addr,
                          eiid, MEMTXATTRS_UNSPECIFIED, &result);
     if (result != MEMTX_OK) {
@@ -888,6 +906,10 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops,
                               aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
         sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
+
+        if (kvm_enabled()) {
+            aplic->kvm_splitmode = true;
+        }
     }
 
     /*
@@ -935,8 +957,8 @@ static Property riscv_aplic_properties[] = {
 
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
@@ -944,6 +966,8 @@ static const VMStateDescription vmstate_riscv_aplic = {
             VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
             VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
             VMSTATE_UINT32(genmsi, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
             VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a954ca2104..ee223f86ec 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1246,7 +1246,7 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                     int base_hartid, int hart_count)
 {
     int i;
-    hwaddr addr;
+    hwaddr addr = 0;
     uint32_t guest_bits;
     DeviceState *aplic_s = NULL;
     DeviceState *aplic_m = NULL;
@@ -1296,6 +1296,10 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                  VIRT_IRQCHIP_NUM_PRIO_BITS,
                                  msimode, false, aplic_m);
 
+    if (kvm_enabled() && msimode) {
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
+    }
+
     return kvm_enabled() ? aplic_s : aplic_m;
 }
 
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index 74ae5d87b5..489b9133c2 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -68,11 +68,17 @@ struct RISCVAPLICState {
     uint32_t num_irqs;
     bool msimode;
     bool mmode;
+
+    /* To support KVM aia=aplic-imsic with irqchip split mode */
+    bool kvm_splitmode;
+    uint32_t kvm_msicfgaddr;
+    uint32_t kvm_msicfgaddrH;
 };
 
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 bool riscv_use_emulated_aplic(bool msimode);
+void riscv_aplic_set_kvm_msicfgaddr(RISCVAPLICState *aplic, hwaddr addr);
 
 DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-- 
2.47.0


