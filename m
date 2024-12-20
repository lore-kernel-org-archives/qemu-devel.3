Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F3FE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSF3-0006TO-1V; Thu, 19 Dec 2024 20:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEv-0006FM-BX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:42 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEt-0004UX-Np
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:41 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-728eedfca37so1546886b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659738; x=1735264538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXDNoX4qOLwESPjPkWgs/x/mjCxJy7bzXdJnmiQehW0=;
 b=HURvmOUH5VdK6S22CZTPAhoYwlKy1q2DCO6hOyDJwwvcp0i3khaswWoyKmLSA9exIf
 6MVKDmd0xBVUkTrWTPNWIrrCFpVFZas8K31TPFEF5tgOFe8cAtMabYxvRkyLhM4lPm0Y
 vLTzEwTtdkwYjHX7pUYBAh4y+YPi0raicu9hR9ow5ixdRsqTjkPp0p7gVTRwQBfqozrL
 LSTnPYM9Y+FsHZpmmefzqn1grvM0em6h7GblZzyb2f9Eom4aJAmmPePNpuUXA460NTFH
 nSVJx2k/zmM6LXFTDrxJ+JiVlhiD4qTiiQWrgyLrzrivqaginwEfnvI1lu2HMcfzN9ex
 trsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659738; x=1735264538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXDNoX4qOLwESPjPkWgs/x/mjCxJy7bzXdJnmiQehW0=;
 b=VFqqiTCh/CYom1AlcLOGs91Yb/UaqACKc+5eLJZjbsJ5Vip2PZchdmIA2h87DDoJh+
 qDgHLMEIK//pCd7k/g3SLSKL7ImnFABudt7Ig3NegoskB8GsvNiDbFt5QoYvCk3kWdQe
 jsKXB2JUme3wojdQ0wpx9+Q1hbQtP8sGinpRgmc2xpLFUmLHCIIHw8hKIlu7eJuikoH9
 S6QaXAYoJX2jZHRNEoc8eewQYCaMXnqGm8VxjPvBFUBz0TPlZY9cpFNUdeIOP5y6Qf4k
 yEv7w+3p1obX/iBDlYyjR0Lu+vjD09GKM9BqCpks0YTuu4tCdNV2Hg6lEJaSvYeQ9ARG
 38ow==
X-Gm-Message-State: AOJu0Yy1v2MuWFIE1nuVNNHLqRQTipL9P/mJD7sfSAErHWEDpWdIrGZp
 eW9250KJ9sMvCmFyFLPCvUX6//trstTKJwxmHH6baK7lvbbWHl0hFw6jDt81
X-Gm-Gg: ASbGncuITJppkxAMOT7LqNnomoMpfFu/jKhStVG4/CXS5lWfvvCLHRxKbDfmMQH9mug
 MTd31BJr9XWT90QVWcVY1aC3iAnwrun/4jSH52pzuKR04ed3I0IHgbFaqhb4sQzY5lgJkDZPyL3
 wa6PNQvu8jjTr2NS5+b7AZch98aGetuqLoMwbK7yldS8jj20ZDg9tp3skabkeEpuZV6ls/T30B1
 4FlH5tSPdIwQKDRbVLqGApo+45hKt/tem1p3MPK8oyDOuQuW9SCmhdNmEksaJkR15rPsSARbhES
 bAfeewqTiF9NJRsyE5/xOddR/WdFQ0Y+oCv4lYXn4cgOiF6sX/yNI9Dw86pLRFk=
X-Google-Smtp-Source: AGHT+IFxxDBYobqliCl9DXvxZVwyvpmVyk5hNENodJ/q+pukVGzikfu7vUmWkkG1eJM2FAUjea5OoA==
X-Received: by 2002:a05:6a21:998b:b0:1e0:b5ae:8fc1 with SMTP id
 adf61e73a8af0-1e5e0484570mr1999345637.13.1734659738269; 
 Thu, 19 Dec 2024 17:55:38 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:37 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 15/39] hw/riscv/virt.c,
 riscv_aplic.c: add 'emulated_aplic' helpers
Date: Fri, 20 Dec 2024 11:54:15 +1000
Message-ID: <20241220015441.317236-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42e.google.com
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


