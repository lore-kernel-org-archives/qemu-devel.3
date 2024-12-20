Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E46E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF5-0006Xq-Np; Thu, 19 Dec 2024 20:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEz-0006KP-UQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:46 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEx-0004V1-Qz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:45 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7fcf59a41ddso832288a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659741; x=1735264541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TYqdC2K3zGvnkeyV3z/811UC20D+6gf+j2aj8oIckc=;
 b=CqF4bys126noRyrKA9I6bltWZkVJ3XXg4TLDP181Y7S0k8brjtjm+Pbnrn2HoK+sNn
 rhi48QmA8CS14GTrSGBdWdUrO34DMXEiYCr/dMO5D1I6Dll2sZNs8ks/3H6R///nRJmA
 i8QynkRW1mSgqJ8fY+G2/ii6UbCD5K5OcmSBxBkd5N6CVIRae/JJZ3CeEhpfI708VxXc
 k1n3zvlN7OIiiFOp8nNQH5xDN2+dPBkIXCoV3hNMQpY69UUr+Kh76kmnDyUvSUwvQMzW
 LXxTqoQblVjUsIkFalrIXkS7pvUw8lacb6fGwaWD92iwWPSheK5yjSKFdMKIinohWwCf
 Jptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659741; x=1735264541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TYqdC2K3zGvnkeyV3z/811UC20D+6gf+j2aj8oIckc=;
 b=aGNrAErqSLLR2q8Kirz2HSPIUOGoVD3NJmJ83gUmJnKLisHAcvTFdU5VAaPSjWvdS6
 h20oZqnjHlG1wIFNPQBC8Z3fR672IcoOpLAcK+V2nHmMTQv71pXVuTQ3g2XfclOtNyDK
 gGUMJR3oxflkXhtIDLvvYxXsZlPP8MZetVCIhuxAPQ9Uup1lyqsk1xD6pYtBSd++/lmz
 8/4Flqp57X1Cw6t+49niK73JvKCn3l0J4jYsAvGRFs023s2tSdyke2iVyDhzmVcDzZwp
 n0p2xCJL1WkXEr46J/EIpngAJcUfTXUjYcuj+usozxjUFIKEcMIV7vISZvKEmdKZv8an
 l7qw==
X-Gm-Message-State: AOJu0Yy3J+jKgdzMIOi7Zi9PQoe/FnAHDEw5wigFQuQDuPt6j7xKp28u
 hCX3F6Re2XiWlRNJwPLXWPbHxeEnWEADTB0dxm1vtnBTujgrObIKpDsuSEXO
X-Gm-Gg: ASbGncuPMtnS+k6TyzRaGyp9UPeItgK2vaw0ySOaaqXgyz8B69cFC8A1f5/uQ06pm1i
 kSH5QH8ed99BNQ/md4RedMaaffkKP2al2JMRd8z4EkUpNyF93T9dfYLbow7MgVEeKEkKcrfHa1L
 O0OfH8bLx/1gTLWl73FJLoELwjV+439gzPIeJkbQDI0gZTXObqL9Lr3HunAnp8divTE0ATAku1K
 473HuzHNGG6q8BBRyqICrAjXC5gGynEryf0w2prXclIrwFwQH0cjdTV1sfoG5D2QKE/heVIvNZi
 haNiLogI8060/Q4FfargiLTpPs3MUoHSRwu6JbsAgA5n/dAlMoOwo8NcgTimb4c=
X-Google-Smtp-Source: AGHT+IFDgxr7kPNH68yR1STWcSMDlClPeayQ40W2fQPIQ2rhRYXl+AIbVoW0lcMxKNj3SWuB6IYFhA==
X-Received: by 2002:a05:6a21:7896:b0:1e0:d9a0:4ff7 with SMTP id
 adf61e73a8af0-1e5e08011d6mr2244669637.32.1734659741023; 
 Thu, 19 Dec 2024 17:55:41 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 16/39] hw/intc/riscv_aplic: add kvm_msicfgaddr for split
 mode aplic-imsic
Date: Fri, 20 Dec 2024 11:54:16 +1000
Message-ID: <20241220015441.317236-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20241119191706.718860-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aplic.h |  6 +++++
 hw/intc/riscv_aplic.c         | 42 +++++++++++++++++++++++++++--------
 hw/riscv/virt.c               |  6 ++++-
 3 files changed, 44 insertions(+), 10 deletions(-)

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
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index ba4e802888..1e4cdb500c 100644
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
@@ -381,13 +391,16 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
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
@@ -419,6 +432,11 @@ static void riscv_aplic_msi_send(RISCVAPLICState *aplic,
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
@@ -892,6 +910,10 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
         memory_region_init_io(&aplic->mmio, OBJECT(dev), &riscv_aplic_ops,
                               aplic, TYPE_RISCV_APLIC, aplic->aperture_size);
         sysbus_init_mmio(SYS_BUS_DEVICE(dev), &aplic->mmio);
+
+        if (kvm_enabled()) {
+            aplic->kvm_splitmode = true;
+        }
     }
 
     /*
@@ -939,8 +961,8 @@ static const Property riscv_aplic_properties[] = {
 
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
@@ -948,6 +970,8 @@ static const VMStateDescription vmstate_riscv_aplic = {
             VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
             VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
             VMSTATE_UINT32(genmsi, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
+            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
             VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
                                   num_irqs, 0,
                                   vmstate_info_uint32, uint32_t),
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 937dfd1ef2..43a1c86c33 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1300,7 +1300,7 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                     int base_hartid, int hart_count)
 {
     int i;
-    hwaddr addr;
+    hwaddr addr = 0;
     uint32_t guest_bits;
     DeviceState *aplic_s = NULL;
     DeviceState *aplic_m = NULL;
@@ -1350,6 +1350,10 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
                                  VIRT_IRQCHIP_NUM_PRIO_BITS,
                                  msimode, false, aplic_m);
 
+    if (kvm_enabled() && msimode) {
+        riscv_aplic_set_kvm_msicfgaddr(RISCV_APLIC(aplic_s), addr);
+    }
+
     return kvm_enabled() ? aplic_s : aplic_m;
 }
 
-- 
2.47.1


