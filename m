Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF05D6C28B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTj1-0002hS-73; Tue, 19 Nov 2024 14:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTiy-0002gL-M8
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:21 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTiu-0007b0-Ri
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:19 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e61b47c6cso1104062b3a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043834; x=1732648634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfqPL2ceZbuv9319yPCtViJk/QQq83eorbQLKJC/kgc=;
 b=GK+PEsK94nwXDf9SSEgkVm43iorMau4OdW/cV+13NLNVteFWzopi/AonQVengI4ORQ
 7BJexfKcJiZDvOofBZqJ2mX/B4A4/eY4SMepp2fyfYPD6RDgXZfDcA3kpZ43DPsmT56D
 F9dZvn8PyXsiSWJ/1+gozHNyGSsLVQkkcYJyvtg6GVctCIJfLmA0YC/sp2oHYvxLFLLm
 VPJa9A9g21N+TQTBd4lCgE/dvb1MxtWE5DrCdX2Isdfrtx2AWHq1gFj+p8TQbNijK8xe
 VAZwppN7Vfmwx5M52XnByY7tK+zKAbJ4ySJ4nXcFDevTMxJjzLxi4J/BL6Ju3/0f6BC9
 CBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043834; x=1732648634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfqPL2ceZbuv9319yPCtViJk/QQq83eorbQLKJC/kgc=;
 b=YOMXjk0dj/R+GijoWb/TNJiwT/Qm+PUvCC7F+SPKBQOnO40xqg6ZAB2gs3l6HCAt/U
 fqXq8JW/NIujErohLVbxAL3OKR8+RGvHenVj4rM3Q5zSg97z3n9wSVPkFOlKGH1gGPXQ
 f4kP4cm2mc6LB1yGbXnOTSJ87nybaFEhVQ5xOyCZGkFYpMtD4l5jBIcXrek5Fceq5dmN
 uC8j8hzltFUlsPVh8kOiUT1Vkwe1/9tzWGy7u6R/femsVg1NGQF9PbvWvdGQDF+cl+w7
 8WZ9SnIJU09929OA5dXS6dHY1VElmV5T5TIKth4Zc/PhmlPhCJxwFY4eYk6ez3lCnTTF
 5mww==
X-Gm-Message-State: AOJu0YzU5vFVsoxc1XDJUEwYsiyYZ1zN2vcQKlCqLcILyC4JnVj/ejjx
 h+7tg7oYIrU8jMbpAJwRmDVrPjNbqaCmYlicxvr8vVFM1QrTMmXU0AJicIZSHHzLvhqOuUkKA5o
 V
X-Google-Smtp-Source: AGHT+IEOurxfnAW28OaXHwwOZ7jeUujAh8Ztn2FgTZzY5O8BY8LefV3tM19VwZBrbWgPIi/V7q770Q==
X-Received: by 2002:a05:6a00:3a12:b0:71e:5d1d:1aa2 with SMTP id
 d2e1a72fcca58-724bec9ad56mr141015b3a.7.1732043834575; 
 Tue, 19 Nov 2024 11:17:14 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:14 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 1/8] hw/intc/riscv_aplic: rename is_kvm_aia()
Date: Tue, 19 Nov 2024 16:16:59 -0300
Message-ID: <20241119191706.718860-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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

The helper is_kvm_aia() is checking not only for AIA, but for
aplic-imsic (i.e. "aia=aplic-imsic" in 'virt' RISC-V machine) with an
in-kernel chip present.

Rename it to be a bit clear what the helper is doing since we'll add
more AIA helpers in the next patches.

Make the helper public because the 'virt' machine will use it as well.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/riscv_aplic.c         | 8 ++++----
 include/hw/intc/riscv_aplic.h | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4a262c82f0..20de8c63a2 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -154,7 +154,7 @@
  * KVM AIA only supports APLIC MSI, fallback to QEMU emulation if we want to use
  * APLIC Wired.
  */
-static bool is_kvm_aia(bool msimode)
+bool riscv_is_kvm_aia_aplic_imsic(bool msimode)
 {
     return kvm_irqchip_in_kernel() && msimode;
 }
@@ -853,7 +853,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    if (!is_kvm_aia(aplic->msimode)) {
+    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -877,7 +877,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        if (kvm_enabled() && is_kvm_aia(aplic->msimode)) {
+        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
             qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
         } else {
             qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
@@ -1021,7 +1021,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    if (!is_kvm_aia(msimode)) {
+    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.h
index de8532fbc3..fd0e6427d9 100644
--- a/include/hw/intc/riscv_aplic.h
+++ b/include/hw/intc/riscv_aplic.h
@@ -71,6 +71,7 @@ struct RISCVAPLICState {
 };
 
 void riscv_aplic_add_child(DeviceState *parent, DeviceState *child);
+bool riscv_is_kvm_aia_aplic_imsic(bool msimode);
 
 DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
     uint32_t hartid_base, uint32_t num_harts, uint32_t num_sources,
-- 
2.47.0


