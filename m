Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D66E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5z4-0005KL-Gy; Sun, 12 Jan 2025 16:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5z2-0005Jq-Cw
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5z1-0003mP-0o
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so25552645e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719137; x=1737323937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8CQfnNBW2aJXtC3lFFPMQMP+NskiuKSnJ/i6XTzflQ=;
 b=TlTZOCrFk7zmCHIM+ubr8RiQ5gEblKvzp6ioXT8EzfxlDr43I5btiU7X5GG7DmQ2Lf
 xC/za0bRL3RIoU7E50aW8HLg6sLEMpHHQt4g2emcgvIu5waN4hXXT0PV2Mt4f17/RZQP
 jSTQA4XH269s9viYnl9vPt2r33/nPA4WgPYw9FgK4N0tko5UW6umj9H+Bygs09HmOmzX
 woG00cn7WLzT1Z5E2l8D9bf/iJYvnsRQzl667ZA8cB6YXGjgZkhGmAt3gJ2/XqWukYa/
 zcJwdFxHGSqpxgIcopaS8yAea6ziE/xjGWJmwaV1VSAj4DdJKJ2EKZ23MesAvTIPNfuR
 hMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719137; x=1737323937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8CQfnNBW2aJXtC3lFFPMQMP+NskiuKSnJ/i6XTzflQ=;
 b=vkjc9onrsNg0uRrgi34mS3Y75TRkx+btyjk8EKi6rbDdEF8Ow0iz+Niszwln0sWFvD
 duJqKi/pwiU0l8khQy0Tw0/0v5PFSXs8OBsz7SeaoZxnu/XLoFVz/Pc88QlocrdqQK5y
 oCfvDD0sWnGzleAmkCFLx8NykXhElC7z32rc2cOtSjIOWFf4jDm9ACiqBHXoClla8Lsx
 QwES89H/2gobqrZYiGwwoLeUMhlANu7Ihl8LkFN7itISc9ptrUo5q6F3NrwJkpWpZkhm
 lZb5ZzGhooGKx798ejd+F0MIitxXhVeC/fANjnNi4ZUetPyJ+SsdweSs8r5WZbijyM1/
 S2UQ==
X-Gm-Message-State: AOJu0Ywio/492sTZxFAtZm8t//upEHaOp/3tWvbTB/BLdjB+hZncdG6n
 N5UI2jSeakVbcaOgo7rdQV9TKbAjJGAStc0tLzw51+6kLz9qMLKry68ugK7HSm7kOmFISBuCfMa
 oQEY=
X-Gm-Gg: ASbGncv6TZWQC1lfOryeocnspNd3O0QxKjagqbcFvZRnup+ZhnohQ7F9ah7vtUN15jT
 mchr5Yd6szF1b26uI8e8MT1+ftDV98snpypbrbXlAhE/JBpnBDctssOjjzHPltbN69GfXAinr3v
 RuG88Ili476Ow88avR6IfIseGERDl/ipjyZf8ujk+tYnDpgUBI59cN9cDjghFsz7P9qrPcU/Iks
 gzR7cggkOQooXiLdGkukzBwO2r6HwTK3xtEbPjGoShBJvvntHySBCj2aG4+X3ynvRszCJ8wNiud
 ljed5QR962uwjJIGq/6/NqfGqWgic40=
X-Google-Smtp-Source: AGHT+IHgcuAbcAB9oqkFHWlY2+YSxCytZVWQbK0btSmNtySa4lZJM4KLbawNpNlY3aoppQKHrvJXsg==
X-Received: by 2002:adf:b183:0:b0:38a:888c:679c with SMTP id
 ffacd0b85a97d-38a888c6b21mr11461718f8f.42.1736719137137; 
 Sun, 12 Jan 2025 13:58:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b82a4sm10656350f8f.72.2025.01.12.13.58.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:58:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 04/11] hw/mips/loongson3_virt: Pass CPU argument to
 get_cpu_freq_hz()
Date: Sun, 12 Jan 2025 22:58:28 +0100
Message-ID: <20250112215835.29320-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Pass the first vCPU as argument, allowing to remove
another &first_cpu global use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 032ff92383e..078ad46174f 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -153,7 +153,7 @@ static const MemoryRegionOps loongson3_pm_ops = {
 
 #define DEF_LOONGSON3_FREQ (800 * 1000 * 1000)
 
-static uint64_t get_cpu_freq_hz(void)
+static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
 {
 #ifdef CONFIG_KVM
     int ret;
@@ -164,7 +164,7 @@ static uint64_t get_cpu_freq_hz(void)
     };
 
     if (kvm_enabled()) {
-        ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
+        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_ONE_REG, &freq_reg);
         if (ret >= 0) {
             return freq * 2;
         }
@@ -635,7 +635,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * Please use -L to set the BIOS path and -bios to set bios name.
      */
 
-    loaderparams.cpu_freq = get_cpu_freq_hz();
+    loaderparams.cpu_freq = get_cpu_freq_hz(cpus[0]);
     loaderparams.ram_size = ram_size;
     if (kernel_filename) {
         loaderparams.kernel_filename = kernel_filename;
-- 
2.47.1


