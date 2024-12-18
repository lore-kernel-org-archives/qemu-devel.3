Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B20E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZD-00036D-M9; Wed, 18 Dec 2024 17:30:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZB-00034s-Ns
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Z9-0003Dk-7j
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21631789fcdso8759225ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561049; x=1735165849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mfeHtTybRUkjDJln1nTcWdtnoTUOCr05hly+5Fj3xA=;
 b=BQ6sXjEfDZSMWxSiEjVbcMS9ub21hfBoQon84h5F9H2vRXVnjd9iTcijE7B3w69NNp
 hoAYJbu9TDAQN9JFGiXB4i+1D2ufmRhfYEB+d0h1uA4b5AJsoU/tG93WB84UcIK32fwq
 qLiGfGkA42xgUOK67duky8Hl3kR/aKV/dNNV4qnca5M4IULK6dxHTN6m1IAmx0GQaNCD
 uE98qhRa9ELhthTcK/lzjso8ecLujpvr5rQdNGhmY7syKTcC53qGa0cfgKQBjvBSvesf
 yyJg39JqI1q63AnA0Axkwdlrk0bnuBMMKlCmt0cqKuYsiztm0CgmIjxCFxcnZ1FswAmG
 CPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561049; x=1735165849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mfeHtTybRUkjDJln1nTcWdtnoTUOCr05hly+5Fj3xA=;
 b=NJl7Y/ewdz5S0sWnfkQSrfsQ010gjPVZnHh1zPY+eSlvMDC2sC4GESg2K2ThS34Gr8
 tBohqp2s/gHinifd8gswM7+/M/Fv9vM3ED1GiawNYyYdnGlnimKFOPFoV0l56DD5qjJc
 HiZge2u9hIyNSqkH4mxW7HYdVWTgmU25SFBjrHDJIg4DIps4ph0ebdrznIR2V9ADY/B6
 S8JIwxSc0iC8Rl6bTLTGV9uawJ6RTXqZrcN61ul3DjMYdS2wsW6d4riPznil2kaA7Bra
 Q5PX/VYM7fbwST4uVcupJfZyjvdinY8aKU3M5ccRnK3YWJTMz/qMUkHBI+0yf2XpacWX
 SzxQ==
X-Gm-Message-State: AOJu0YxiYQwsvmGv84pzyPVXBuWkeFTmLpGtoKLx6U6rtuK4WXhhVgV8
 AMn50mJn0UlcrikQY6oDJMR8msYxUcZN2cdPtEV91TIkPDqh5rWbtkbuy9Q+
X-Gm-Gg: ASbGncseE1xckUIgbdaOFWX/6TXIT7x8E2hz1dQUdn0GzTINnzmrg1DJUGy5GFInqAx
 5GwTQDW2rBL9gAj0vb/pnh0K/hoTdoL2TQr/2sS2KEm3URCXZ2+D4exIVf8Aa6C2n99CZom4V38
 3zO2H1CgExJUozUe3Bzx94En8XIwvZHw6ouJXBXdpMUnQ0rN0A6yCcbeJQp4/rsb3nzTglUdEqd
 n9SLUGF+TX0WwTaGcf1hQBW2g1EeWK5SBeKzVO1MGgQ8rDJM25Owg30pg/hps4N94DQIypkupjf
 OesPWtxbxTUAmrfDcahdVoZwgBwbTynGUovQ3TJ8uC+jvFubNtRw83/M9LeipQM=
X-Google-Smtp-Source: AGHT+IEDAqrQA81Zg0wjD42x/hReGkJSzTGTpCc5aSawBjbjZAjxJ/nk9rCcp+9v0rjENHCZzZa8Ig==
X-Received: by 2002:a17:903:2347:b0:216:3e87:ca00 with SMTP id
 d9443c01a7336-219da8106ffmr14941985ad.28.1734561049277; 
 Wed, 18 Dec 2024 14:30:49 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:48 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/39] hw/intc/riscv_aplic: rename is_kvm_aia()
Date: Thu, 19 Dec 2024 08:29:41 +1000
Message-ID: <20241218223010.1931245-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

The helper is_kvm_aia() is checking not only for AIA, but for
aplic-imsic (i.e. "aia=aplic-imsic" in 'virt' RISC-V machine) with an
in-kernel chip present.

Rename it to be a bit clear what the helper is doing since we'll add
more AIA helpers in the next patches.

Make the helper public because the 'virt' machine will use it as well.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241119191706.718860-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/intc/riscv_aplic.h | 1 +
 hw/intc/riscv_aplic.c         | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

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
diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 3edab64b97..9f9814a40b 100644
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
@@ -857,7 +857,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
     uint32_t i;
     RISCVAPLICState *aplic = RISCV_APLIC(dev);
 
-    if (!is_kvm_aia(aplic->msimode)) {
+    if (!riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
         aplic->bitfield_words = (aplic->num_irqs + 31) >> 5;
         aplic->sourcecfg = g_new0(uint32_t, aplic->num_irqs);
         aplic->state = g_new0(uint32_t, aplic->num_irqs);
@@ -881,7 +881,7 @@ static void riscv_aplic_realize(DeviceState *dev, Error **errp)
      * have IRQ lines delegated by their parent APLIC.
      */
     if (!aplic->parent) {
-        if (kvm_enabled() && is_kvm_aia(aplic->msimode)) {
+        if (kvm_enabled() && riscv_is_kvm_aia_aplic_imsic(aplic->msimode)) {
             qdev_init_gpio_in(dev, riscv_kvm_aplic_request, aplic->num_irqs);
         } else {
             qdev_init_gpio_in(dev, riscv_aplic_request, aplic->num_irqs);
@@ -1025,7 +1025,7 @@ DeviceState *riscv_aplic_create(hwaddr addr, hwaddr size,
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    if (!is_kvm_aia(msimode)) {
+    if (!riscv_is_kvm_aia_aplic_imsic(msimode)) {
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
     }
 
-- 
2.47.1


