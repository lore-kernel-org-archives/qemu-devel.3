Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ED3C9EC99
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 15:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJKA-0008C8-PW; Mon, 12 Jan 2026 09:55:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJj-0007kX-8U
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:51 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJe-0001YO-PC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:50 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8714a52072so183440266b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229685; x=1768834485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ8E/vLXW/n+4mH8Q0iJxaZz9OiFrfoLpfuE5uF7VSk=;
 b=CN2H+i3MDRtsZeQF2HNHqA3OFkPX48k/GibIgdl5KCyaziTW5lccoYNnAFL3hH5/j7
 a/6nUgFAqXG9ViMF5plNQw6aU/bnadbnQcd31Bu7Q2UCcYWcP5CaERP5F1x9QZYrwarT
 gUvRRNY7qCh5g4f3t2sxTp64ASLP6tYf8mvnlfn5ki2s1HeNXAcv6BZsPVCNlyR5RZeL
 WxTnKjOSKquAJaYQh5NeFAzYRs/AuesIvSbibulIbWV/d+NNG92XTvsf8DvgcbB4Y6kt
 5iAazAluVlbtQiAWIybGV35Hsoq5TiAsB9V0u1hv1Ywb0bg0txzt5AA9aga77po9l5If
 XRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229685; x=1768834485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZ8E/vLXW/n+4mH8Q0iJxaZz9OiFrfoLpfuE5uF7VSk=;
 b=RZCA0drxwZ8ia++yq0CmhwWESTV7TR97eA8hVfwBY3kP7O7P5HcQq5Hoid5eenlGpq
 fQQ4oUDRRP4ZMs7PPGCO9x1s6vCWPXsh65ywD9CYuBvWsyH6fggYpDoqcYRfcpELN15c
 W79ycF0a0ZOzOYmcEslR/GrQQz1c7XBm47+LdFTE63sQIKctevoH4dWtgCpHMgszMfqi
 MOooJqaV3xwh2Yky9S9vwS3W9WP19XFqlbkIs4UcLQ31bK22Tobe/483GJU3Jprlgfot
 mp39Z95apsQkaOooYmdqD+RUJRrDwkpIyelCxrMpMhZFNj5Scu8YxwehM1aCz+jkOh61
 Cnhw==
X-Gm-Message-State: AOJu0YwfWb/lD8ML+KMQfE+cqeKM8roX3tboyRarJcTOFWOmgY6pZTd/
 qHicuS3eLGTblD7WuG04N/nmLI+er2Nr4mIlnCLZgbZ7L5goK2S1CGnAXTkRbxXX
X-Gm-Gg: AY/fxX5KZiDps3Al/u6Itw9xzjq2jU5AGQ6Hhx2eHwcT5ORqjQfPMx/05+lqqkUOT9J
 m6IKC/J5vecE2q3iC8GD/NYmxko92DPViUkPXgB7HrS0/DRrgbDSr7Hir0wHtNT7roagLc6aP7t
 e1C1WHkXcN5cyiIUwtnLuy88Y5IJhSHJ1prjs2Mb5QTkOcEljDErov5/OCZQIaZkkxKJz5E3MIi
 HqpAcs1HxTWeRia4UuuZ7a8HnmalL3lC1b85g4L99Qp5BLxqO7ajwVJ47Tz7oVTXD0CPK3W4Yn9
 cLd8t/pJIlLjAblcJq4sQTyVcgPppSBWiMc3NL6ItkupeOdfk2kj/NwbOaCPlZjN8fd7djXAoNP
 94z8IGqxQuVanFnJw0P2Welg2HFnRUtcbKbqnCNkW+lqAT2KLg/tajATpRxIABkfEU29O/jJRks
 V92BXGgHXF9D1Df9+OuXovF9ihoz7YgSJyrds3s17/IfQN5BN8d4L6F9LrZn/STG9MfB8Vm2/C
X-Google-Smtp-Source: AGHT+IHsRslvJQAddX3envb+UZTEs4NgJTW38nwMX013zXf1mqEFwfqYAI4cCC+kyWDYSBBNCsEBDA==
X-Received: by 2002:a17:906:f58d:b0:b87:1b23:cad3 with SMTP id
 a640c23a62f3a-b871b23cd09mr283903566b.9.1768229684803; 
 Mon, 12 Jan 2026 06:54:44 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:44 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 07/14] hw/sd/sdhci: Rename usdhc_ functions
Date: Mon, 12 Jan 2026 15:54:11 +0100
Message-ID: <20260112145418.220506-8-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The next patches will introduce eSDHC device models (big and little endian).
Prepare for that by renaming the functions. Also, this makes the code have
similar conventions as in Linux and U-Boot.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 779f411bab..531dd3c291 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1659,7 +1659,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_PRNSTS_SDSTB              (1 << 3)
 #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
 
-static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint32_t ret;
@@ -1673,7 +1673,7 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
         /*
          * For a detailed explanation on the following bit
          * manipulation code see comments in a similar part of
-         * usdhc_write()
+         * esdhc_write()
          */
         hostctl1 = SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
 
@@ -1716,7 +1716,7 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 }
 
 static void
-usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint8_t hostctl1;
@@ -1872,8 +1872,8 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = usdhc_read,
-    .write = usdhc_write,
+    .read = esdhc_read,
+    .write = esdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.52.0


