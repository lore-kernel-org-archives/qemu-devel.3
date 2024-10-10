Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE90CFC5F7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyRz-00060B-Hf; Thu, 10 Oct 2024 15:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyRx-0005zu-Ts
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:49 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyRw-0004iA-92
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71dfccba177so1968351b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587026; x=1729191826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYV54R/BWSeQo+PImwTWN+iYLjqQw2lOGsyCKuolLjM=;
 b=ZwieFGyBcHpShKoQUhpViIWdC0qkpDiNOT5ha4swRTBhWUbus3XCpIoX/DEX1UF5zR
 BeNkf2CrBLgPTPeRprm+yw3TqYu2gnbokdDbMW9WRQHXSJWtSGKHqOP5hbWBn6hAnIGB
 8Xxx8JUs/yQuaxOAoakKzBWtjllLdVq96SKU+AqXbS7LnvRV6hysmqtdLghrBbYcQZe2
 XpR2nA01JVtl+qNnM63FDJMemgAsB95sBHlMGjD111iPWmHMNeRgKM63oVCfhWhGEPIF
 ZGocB75rIaTzGNbtwT4cFhtWgh64bEJwCiv4Df2G8TT5a1wx/lhRIQL4cjcr+ozUmtIb
 DiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587026; x=1729191826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYV54R/BWSeQo+PImwTWN+iYLjqQw2lOGsyCKuolLjM=;
 b=uoa9vvlQh0nk45PceJ5o6RJ9wRtL16Kcd91Qon45YyFAQGzhkTbypGJUZYfwHI/8EX
 HnyHXPKuUUO399rWyeizhTjpeqzsCxrrd9zFMzK6tqFfhdgNYBphDFjFHghewYRNpWD/
 +Ol81Na2Bo6B8YLSuBInhIxE7CxRl8PcYeni4aJMVI5HoAxm5GqniHRiNgBniBxCyAkI
 n2u8ujJZ0kXejjdU+ta2UKQCD9x9+TxL7keeR0fabirJHvcGpKz+CmIHkOsOek6iTD8+
 0Xda4pwiSWzj5patf4N+sqpk0CTwySginkl42aCxO4rHbxihghMZ+PRb63RpEy8ylbnH
 cPgQ==
X-Gm-Message-State: AOJu0YzXYhQZXu0iv2PSP8i7Dckzk3I67R2//OvEKqRCwjYOamZwh+6e
 ESpy9uoX5t/eG4yqlBJDZZUkLtDa2MM8A+YEnGEyArEHeccfWv+BBNpmaljvXvzduJcv2HdO+B3
 9
X-Google-Smtp-Source: AGHT+IFe7kEQ6lQo3H3809DUzKA3DTiH1uv/PA+/BII/GunzoKdUuLo8qg210ZqyIQ2RjL/j0mNHSw==
X-Received: by 2002:a05:6a21:1796:b0:1d2:fad2:a537 with SMTP id
 adf61e73a8af0-1d8bc95b4b0mr202164637.18.1728587026341; 
 Thu, 10 Oct 2024 12:03:46 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/8] hw/intc/riscv_aplic: rename is_kvm_aia()
Date: Thu, 10 Oct 2024 16:03:30 -0300
Message-ID: <20241010190337.376987-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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
2.45.2


