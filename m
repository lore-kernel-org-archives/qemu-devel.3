Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF34C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfR-0001vK-3F; Sun, 09 Mar 2025 20:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfP-0001ud-Uv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:47 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfO-0007L6-0m
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:47 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bcc85ba13so28999095e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565204; x=1742170004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQS2FpqOs5TSI58lEsf5ODh6U5Cq4SEzmJ94sUa1jSg=;
 b=hDtuaXB+7emPGfX07HSZgKmQPenHFt1Ikhz69OYJPeMkJobeRLLTq+Ypf6ntonqor/
 q86+VPYQG0lAKu12tQN4/i9fNN6XWdrslzIszwIj8Pl4WPKCBwUXHDXaRSjfDIn2qkul
 X67GUpq/VLP8Dp0EzkRIZ3AT6BaH8/2xMXw56cNUvEjs4kYGJPZMAtcbgNdUMs6869Lm
 z3ZW9MylhPNjOxqTRK+J3/YWJkSZCvuIeKIiTP4ZKAKoNL75Ds0yYdsTG1iUlt7jRwYO
 24DK4+xSfuHXr/gCssgbhzYfjjWOUuakbaGkcdzKoUAWwDVnMHfrlQKYZI5MGJLbht0z
 hFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565204; x=1742170004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQS2FpqOs5TSI58lEsf5ODh6U5Cq4SEzmJ94sUa1jSg=;
 b=UZz1SMnG1owA2ck+aELL2/eABq6LoaxA3ra2c3DBGlEhM5XXVcpaCh3mK63f0gmkun
 Kong9JAKqgJISuAA9VhlJ0EZTK092gYEq4zDGbChu7/41Gsxdd+q1O92ZJWE3btsndWD
 S7S1n7sZ+oU/BWozmdP97/60wy7kdpaKkMmJK+9jLRh7Ca6eVYiC97vmHOwtA4K5oca8
 v9MPT/5ga3r4okRnSY3nazN8rdFekzhzIOcknZ3wsATrclm8JQWQD7fcQvJBVkyltAu4
 iEIa4ADJLP7nyFsYSQ9we2vcDMCrBGPx4FiMYHZ2DxoZw+Jb3Z3rGmGcLD6ue4ymVFLh
 sdSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwM9WqMp8GhSOUQ5CF0CIsdQ2YYytkt7eiNIVbpton9qwTfIuLC6PhNpG1LpFTvPOaSgG2hyvpXC/6@nongnu.org
X-Gm-Message-State: AOJu0Yy8Xfro3JzL3V6+8XNcyP29O3vt8Uw1VqejP9jw6S1EsnZHuplP
 tUjMgUfFufaCWut5Wfhjv9fnvD1+gdOaEWVsRs8+OsFSxdPg7QXImUcJmHug7uA4CwdBbUTOV/5
 asqQ=
X-Gm-Gg: ASbGnct7RcJ7Emr90/AC7Ik6L+HXHku7KQlMOn5nnSTpG2cAXBqvqoD7eEYS8QhCaTp
 Ilja6mPktgsYXbRjXqeqlxcQNGZz16T/gkKSwje1nEiZb3ckfNg6rYL23zizsTlYG017Dw1+W7b
 Q/mZWjp2sLiMQ7uFXrQr4M5r0au6nL22NfWDO4LgsWHDPoX14CAPZrrCmOEwA7x5Mn0vturEAd7
 vySGQzRqFpiW57TWLLqGQObf52n4CwSPk4v9EFquZQtKv+0qLLGGstfufebEo9yaFa1I008a16t
 AZOi42N7j512YPQeAe+RITctpwb5ZlTP2uxW/oPvZoEtPYAixqt3sj2/ywikUy4v1syoHJGouvp
 mUX1wTgwcVr0frxCHzwcIU2pppEFndw==
X-Google-Smtp-Source: AGHT+IFr14s6HjqqrWZZrFGpCXSJytRcV6kVf92IRNM60n81pYTKgxi5dkVIFwWd6bTQjQFryczrGw==
X-Received: by 2002:a05:600c:5129:b0:43c:f689:88ce with SMTP id
 5b1f17b1804b1-43cf6898affmr12074285e9.20.1741565204360; 
 Sun, 09 Mar 2025 17:06:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8db6c7sm127555375e9.22.2025.03.09.17.06.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 04/14] hw/sd/sdhci: Include 'wp-inverted' property in quirk
 bitmask
Date: Mon, 10 Mar 2025 01:06:10 +0100
Message-ID: <20250310000620.70120-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Import Linux's SDHCI_QUIRK_INVERTED_WRITE_PROTECT quirk definition.

Replace 'wp_inverted' boolean by a bit in quirk bitmask.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 16 ++++++++++------
 hw/arm/aspeed.c       |  2 +-
 hw/sd/sdhci.c         |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 096d607f4b7..d2e4f0f0050 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -30,7 +30,14 @@
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 
-/* SD/MMC host controller state */
+/*
+ * SD/MMC host controller state
+ *
+ * QEMU interface:
+ *  + QOM property "wp-inverted-quirk" inverts the Write Protect pin
+ *    polarity (by default the polarity is active low for detecting SD
+ *    card to be protected).
+ */
 struct SDHCIState {
     /*< private >*/
     union {
@@ -99,11 +106,6 @@ struct SDHCIState {
     uint8_t endianness;
     uint8_t sd_spec_version;
     uint8_t uhs_mode;
-    /*
-     * Write Protect pin default active low for detecting SD card
-     * to be protected. Set wp_inverted to invert the signal.
-     */
-    bool wp_inverted;
 };
 typedef struct SDHCIState SDHCIState;
 
@@ -114,6 +116,8 @@ typedef struct SDHCIState SDHCIState;
 enum {
     /* Controller does not provide transfer-complete interrupt when not busy. */
     SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
+    /* Controller reports inverted write-protect state */
+    SDHCI_QUIRK_INVERTED_WRITE_PROTECT          = 16,
 };
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 98bf071139b..daee2376d50 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -412,7 +412,7 @@ static void aspeed_machine_init(MachineState *machine)
     if (amc->sdhci_wp_inverted) {
         for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
             object_property_set_bool(OBJECT(&bmc->soc->sdhci.slots[i]),
-                                     "wp-inverted", true, &error_abort);
+                                     "wp-inverted-quirk", true, &error_abort);
         }
     }
     if (machine->kernel_filename) {
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 1dc942a0e06..19c600d5bfc 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -274,7 +274,7 @@ static void sdhci_set_readonly(DeviceState *dev, bool level)
 {
     SDHCIState *s = (SDHCIState *)dev;
 
-    if (s->wp_inverted) {
+    if (s->quirks & BIT(SDHCI_QUIRK_INVERTED_WRITE_PROTECT)) {
         level = !level;
     }
 
@@ -1555,12 +1555,12 @@ void sdhci_common_class_init(ObjectClass *klass, const void *data)
 
 static const Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
+    DEFINE_PROP_BIT("wp-inverted-quirk", SDHCIState, quirks,
+                    SDHCI_QUIRK_INVERTED_WRITE_PROTECT, false),
     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
                      false),
     DEFINE_PROP_LINK("dma", SDHCIState,
                      dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
-    DEFINE_PROP_BOOL("wp-inverted", SDHCIState,
-                     wp_inverted, false),
 };
 
 static void sdhci_sysbus_init(Object *obj)
-- 
2.47.1


