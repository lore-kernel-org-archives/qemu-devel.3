Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E646FE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEz-0006GU-2d; Thu, 19 Dec 2024 20:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEj-0006Dn-Sn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:31 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEi-0004RT-AG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:29 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so953641a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659727; x=1735264527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mfeHtTybRUkjDJln1nTcWdtnoTUOCr05hly+5Fj3xA=;
 b=MEkOmQFjY/ZpBTBViO3JHhIlpMlMZ97i9GIIL6tygA1wcTD+TQq30TuUghh1qtri+T
 GjnAAJjXkNOhlrvurphMRqWDf0HUFSCgyCwjx+vNv3onDtHI9XQncX5rqEuQLCNEc4EK
 ZLocoStCKdC063jA/mxNFxsfjV5otoyIweBjtc2oLl9KcKAAiL/Ie3Yi+6C/GFAsLzIn
 Lwk8SNh4Mj69eqCHXdil32ISP5RLwe21I15/vJuIyd1YJhkylgEgXirmrLisfOUUTVtu
 j9Q6y/7KFPa2PTaEaPffJFMCs/Wh5WTTL1I8uaf3TFdvP/7UsdmzC74PWbWRvrC9gmaL
 oEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659727; x=1735264527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mfeHtTybRUkjDJln1nTcWdtnoTUOCr05hly+5Fj3xA=;
 b=au7CdOfs5HwbN9YkVDht7xqDNoQ8zwxk4/Bv60UDj5Amr61FyV3GG18eBh0J+z0fDE
 bht34lpA9gnxAOtav2wsf4qOzOdlugLh9+JgWPvlbIpbYMD0TNz6EoREu/5YpHN2lEiY
 a/duhEbZDK+0Hqgh8apqA7T+YElcpYQnneOIdeFlJufsXiV0iC9169UnJWf9d2JXbQaZ
 kuXaEZBaR9AsTIv6FRO8TAhiXfqvPRfgb4e1mtAHIppQ6C+5fZDLXdGhfCMCO3fWYGG3
 hPEvInRe3tKnZbUtpL1LQYM8GlokVnNHHWI+InJZ2Wki/KWuy6SoVUsThf4dpm2+Si0z
 bTTQ==
X-Gm-Message-State: AOJu0YwD/M0AuuEwVpefljRtXJpfdsfdIyQnH009NdT0mlj/qKi+4DE5
 jsWNUm61DDr4nTXUxXj2NNbkHOe0gf/ZmjOO8x1aYXIdOV+rULjnwC2YWaBA
X-Gm-Gg: ASbGnctTR5ni1L2hcnLSOJvLZdql0BbvD8xZgg2H4E4ejAzEjY9M6DqsWzynPP2Qe25
 9otWyG9/9zzxbe21AiLPZ23HCESJKfu6BzDgI1wkq9nAbPLpCTt1boJR3rkEYqeKvDqRXMixkaX
 /Cgw1APyVtFkCNXoN+YVPr/hUCJedp3nU3joUo7sZUrLUSFpCaUp9p79z5q3mwQcqcBM2gmmsAC
 kHKtjTlhYAflH0PFzpYmQLLUr93mhJ1UKGIO8bEDMMEcHliPcjTB3fem3y3vGv6ze0rhA76yneB
 9jsZO3bknCaA1WBp7bLHFhvaXUI2n7ECKOHfS9nsOVLOhGC9IdcRM+yAIq66cMM=
X-Google-Smtp-Source: AGHT+IHb4Fei05oNKgk8uSTMzd2r2u/G74PyFlY4NJbyCwhnyfCpA7e+mh6oc2t/azP1dmpH2+Cm2g==
X-Received: by 2002:a05:6a20:7f8b:b0:1e1:9f77:da8b with SMTP id
 adf61e73a8af0-1e5e07ffce4mr2076587637.36.1734659726770; 
 Thu, 19 Dec 2024 17:55:26 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:26 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/39] hw/intc/riscv_aplic: rename is_kvm_aia()
Date: Fri, 20 Dec 2024 11:54:11 +1000
Message-ID: <20241220015441.317236-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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


