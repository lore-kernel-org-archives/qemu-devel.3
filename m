Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6D6E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2Zo-0003RY-8g; Wed, 18 Dec 2024 17:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZL-0003Bh-Qu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:04 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZJ-0003Fy-Vd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:03 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-218c80a97caso1723445ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561060; x=1735165860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXDNoX4qOLwESPjPkWgs/x/mjCxJy7bzXdJnmiQehW0=;
 b=UIySsCg1e9a48Aummjg57OAQ1vnkzvuFE1GwuEBkt1d9mnFXsXVoIILZ6dRZByWrIH
 toomKRSJ8ZU3LDoZPKBLvWZA1dkQ1vnQzXbkPtLzDqXbLMHI7C6jGMDTG9BYyxQhVrgx
 pmkjU98RyMvnMPMZ/iHaypyRFVFBRXuMTiV8up8ozbzIdYih3mMj5GKjO3AeQqrPGfNx
 JoiV5k55R/+s9AoVmzUyy/9iBZrm7FQFF/z97K6gvlMn3JOkSvn4M8DLrtgeTVosFQhI
 rlVfJM93tpYTZfpfHTgevlfSWz+8jkCixZ2XIGs/B0PVM6ox6oUWZK84120nzEVg8Y7W
 p37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561060; x=1735165860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXDNoX4qOLwESPjPkWgs/x/mjCxJy7bzXdJnmiQehW0=;
 b=uX0PXvSTX0lEMWGUuIu+VAH8SsIS8EOuRb51zcDETz7CVjpJwX5xNG/vFLRB2Wlt3f
 WJ0A+1FsCo7PvW4BUeH0vkuhHGH6lISeF9aa4/I3lRImCcz8fFdcwk/0gH3SJxe9ANWW
 HJUJOUBkvbrzBYYJ9vGCzqXNpB3bDKLD1PZfk/ln0BEDKSLNL98wqDrfhr2+PRvEaL7z
 3f4JFwwfA8KoUVhj7AHzllI2xFrg8CKV0aajgZW9kGOKv2bILZx18PW6v/Qav0TIdm19
 lNccWBfp7A6aOnnQ5fw0RPCpwB+zNI5fVi/kONiGsk+QJpxn4fDLgnIvxZciyC+p1kmF
 S4XQ==
X-Gm-Message-State: AOJu0YwnIB8Zjjz6CWjsIYVQgWyyXERMoqldMFi2c9myDuBTIAv8XtaI
 eWPSWaYugmnrT7zXRD0ubcNsIFas5l6WIo3ihIHCQY18oZWIl01Re/FLcT++
X-Gm-Gg: ASbGncuiFLpCzHgg26vRq1/SwOUllhWc7c6iiQA5IeZG7LdzJZzXun/m6vTqo6M5/HV
 MUtERxEcKjQq1QJuJiHenUWg3kKxBDbxy4/U2cISvLHLXFPfvBdhzW1OD+8lXxqX/3wGU4eTVhg
 F6shInAMqQinSDaWVvd3K9r5hLczAdug0nVdWSVNbgMo1RwosbuHaX/Ga0Y2J9m0kzgJK508Yuj
 Mz14VH8+OdpiM4pgMThGVi5SLmhrIGOI5eLdGKX24DyFJyb5AyA/mBhlztCnq5nHUDEmo58YAhL
 mOEbMW7qPp+l/wDL/G/TplNPmIEWLiJMy13Yun6W3QpyOxMbsqVp4xhLdpBiPhs=
X-Google-Smtp-Source: AGHT+IEAieJ2i8P7XneeX0h5iNN0l2kXbxYFdCiQCrWlFwFC9+HS+rrZ0fGOLMHjAou/ez6xLJxV2A==
X-Received: by 2002:a17:902:d2c1:b0:215:7cd0:758d with SMTP id
 d9443c01a7336-218d725282fmr65856835ad.36.1734561060444; 
 Wed, 18 Dec 2024 14:31:00 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:59 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/39] hw/riscv/virt.c,
 riscv_aplic.c: add 'emulated_aplic' helpers
Date: Thu, 19 Dec 2024 08:29:45 +1000
Message-ID: <20241218223010.1931245-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

The current logic to determine if we don't need an emulated APLIC
controller, i.e. KVM will provide for us, is to determine if we're
running KVM, with in-kernel irqchip support, and running
aia=aplic-imsic. This is modelled by riscv_is_kvm_aia_aplic_imsic() and
virt_use_kvm_aia_aplic_imsic().

This won't suffice to support irqchip_split() mode: it will match
exactly the same conditions as the one above, but setting the irqchip to
'split' mode will now require us to emulate an APLIC s-mode controller,
like we're doing with 'aia=aplic'.

Create a new riscv_use_emulated_aplic() helper that will encapsulate
this logic. Replace the uses of "riscv_is_kvm_aia_aplic_imsic()" with
this helper every time we're taking a decision on emulate an APLIC
controller or not. Do the same in virt.c with virt_use_emulated_aplic().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aplic.h |  1 +
 hw/intc/riscv_aplic.c         | 24 +++++++++++++++++++++---
 hw/riscv/virt.c               | 14 ++++++++++++--
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index fd0e6427d9..74ae5d87b5 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -72,6 +72,7 @@ struct RISCVAPLICState {
 
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
 bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
+bool riscv_use_emulated_aplic(bool msimode);
 
 DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 9f9814a40b..ba4e802888 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -32,6 +32,7 @@
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 
@@ -159,6 +160,23 @@ bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
     return kvm_irqchip_in_kernel() && msimode;
 }
 
+bool riscv_use_emulated_aplic(bool msimode)
+{
+#ifdef CONFIG_KVM
+    if (tcg_enabled()) {
+        return true;
+    }
+
+    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
+        return true;
+    }
+
+    return kvm_kernel_irqchip_split();
+#else
+    return true;
+#endif
+}
+
 static bool riscv_aplic_irq_rectified_val(RISCVAPLICState *aplic,
                                           uint32_t irq)
 {
@@ -857,7 +875,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
+    if (riscv_use_emulated_aplic(aplic->msimode)) {
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -881,7 +899,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
+        if (kvm_enabled() && !riscv_use_emulated_aplic(aplic->msimode)) {
             qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
         } else {
             qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
@@ -1025,7 +1043,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
+    if (riscv_use_emulated_aplic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index a67ab80b16..937dfd1ef2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -66,6 +66,13 @@ static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
     return riscv_is_kvm_aia_aplic_imsic(msimode);
 }
 
+static bool virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
+{
+    bool msimode = aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
+
+    return riscv_use_emulated_aplic(msimode);
+}
+
 static bool virt_aclint_allowed(void)
 {
     return tcg_enabled() || qtest_enabled();
@@ -779,8 +786,11 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
         *msi_pcie_phandle = msi_s_phandle;
     }
 
-    /* KVM AIA aplic-imsic only has one APLIC instance */
-    if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
+    /*
+     * With KVM AIA aplic-imsic, using an irqchip without split
+     * mode, we'll use only one APLIC instance.
+     */
+    if (!virt_use_emulated_aplic(s->aia_type)) {
         create_fdt_socket_aplic(s, memmap, 0,
                                 msi_m_phandle, msi_s_phandle, phandle,
                                 &intc_phandles[0], xplic_phandles,
-- 
2.47.1


