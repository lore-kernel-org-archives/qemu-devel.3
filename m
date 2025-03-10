Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E971DC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfb-00022b-LB; Sun, 09 Mar 2025 20:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfX-00020f-7c
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfT-0007MJ-OM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso12639525e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565210; x=1742170010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtO10CroBFmuxTQ9PueWoinPmmKwM9K54hdlvVGKzAE=;
 b=BCNszlUosgkoC0FflU7TUIVgnJwJEjU70ZlfSChey97FnYKWjbcnJp9hHIL7ob7nCj
 i3IIeLieE4oX0uMr/tR6xKqrxucI0mHWiptKlx2P4SoAa6aYa+DW3CJYgAU7fkwRGrwq
 TThsrhVIgN69nP4V6ibRomM4QQPJodZptrrHN5oaD+vLuDft+xl3cQGvtltjLPWJD/8D
 4FJZbDIFhefL9f9wkJ1IwcGJ2YQUi1CRkh0vxOcEJWfpHxpaeAy/WI/c9wfyKkATciTa
 kir5AylEdZqfTzw81u3jKHDTMX7FfbAryDFpHZsuFph6C5zx2frdD/YwGMfN0X0Glnu0
 240w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565210; x=1742170010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtO10CroBFmuxTQ9PueWoinPmmKwM9K54hdlvVGKzAE=;
 b=Ks9Z7fe326/AvMZOP6yZcLTjb3LxGOxJpIQ82mDESE9ZGlThwqvV1IfFZO1p/vofD9
 IhqjwqQlJoViqWiZWMZX8bbApo0jjOdxU2rhDApsft7KGCyKjV4kLFW8BT9FRyYfbjkv
 VDS0SKoPY9bPXsbUWXJjZNGOvjIl+x0U7s7u7UYaluFAvFs6WsYaB8dz93PvVWfNXkcO
 q+08uHkwDTAAr4lJK++AXTL7dEmilKv2XxkPtfoYjZT11gqJnZrnYr8lW54UovBWACZB
 gQCOWkgH4nozmgH125AVW2ZUak++mh/Fkuwem4rOau4CcyuC1hApxwRY/nGn0vRYXFN9
 /mYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbtRvJRNMX2N8rEwqFHlcRrUF2ifXNW80/qlongrwqZN6YZdI9pUBYPZExMjGFdWQNHICmPm9pODsW@nongnu.org
X-Gm-Message-State: AOJu0Yw0LqRsY5kTK6m2HX5GZMOLgrSMloG2bxAvSjwGum6DOKYQ09TQ
 3Ck6JVz8fCcIWa43RzZ2XF2tB2+tgZ21rYKIDv1SH0UwTBMaEN8QHf/UZOdt+yjbvpj7o1Id5uq
 MsFc=
X-Gm-Gg: ASbGncsJs6lec8ETNJ81Rtppni3DZ456pQZvcIU/xCEtyH99bgSrdBMd5RySZjoFesh
 h6esMn1qTTY4rCbVKUT3iKYPjNIcBUpMxhdSV8NPJGtFeYvUCiQUQBcQf2E22UiSK1XX994RJb0
 ClqRFaZHtgoZhy7mk9qBtSrRMDERcJtXQIvuBSbbEOpOhDjQZ6ux3RBbS9VnrKa+1iMpWeCp5Kb
 fp37DDHbp99dkjCqzmHAYsBepdwwtLCq5YHPm+DMuCn+9mbpIKCU5u8ab68Ezmr9nMUi+JT/HOH
 Op9dUkRP6pd8IoVTQa3Kr6/95NA8IisqTDqVPzjzT/OjqAu+ATycyNKZbs0yKuMfQH3CRB9H7Fh
 9bnxHbtVCXMtvbcj/FAE=
X-Google-Smtp-Source: AGHT+IFhNGrH+72dBBuvE39rw4Xrbpi7OKmGDcXtRHzlYrrJp2PqWtacezAZubHFNdsjwdLBS5eItw==
X-Received: by 2002:a05:600c:3ba1:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43cfbbf7eb2mr1844265e9.30.1741565210286; 
 Sun, 09 Mar 2025 17:06:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm13082199f8f.26.2025.03.09.17.06.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:48 -0700 (PDT)
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
Subject: [PATCH v5 05/14] hw/sd/sdhci: Include 'pending-insert-quirk' property
 in quirk bitmask
Date: Mon, 10 Mar 2025 01:06:11 +0100
Message-ID: <20250310000620.70120-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Import Linux's SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk definition.

Replace 'pending_insert_quirk' boolean (originally introduce in commit
0a7ac9f9e72 "sdhci: quirk property for card insert interrupt status
on Raspberry Pi") by a bit in quirk bitmask.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sdhci.h | 5 ++++-
 hw/sd/sdhci.c         | 8 ++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index d2e4f0f0050..2e6e719df7b 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -34,6 +34,8 @@
  * SD/MMC host controller state
  *
  * QEMU interface:
+ *  + QOM property "pending-insert-quirk" re-enables pending "card inserted"
+ *    IRQ after reset (used by the Raspberry Pi controllers).
  *  + QOM property "wp-inverted-quirk" inverts the Write Protect pin
  *    polarity (by default the polarity is active low for detecting SD
  *    card to be protected).
@@ -101,7 +103,6 @@ struct SDHCIState {
     /* RO Host Controller Version Register always reads as 0x2401 */
 
     /* Configurable properties */
-    bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
     uint32_t quirks;
     uint8_t endianness;
     uint8_t sd_spec_version;
@@ -118,6 +119,8 @@ enum {
     SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
     /* Controller reports inverted write-protect state */
     SDHCI_QUIRK_INVERTED_WRITE_PROTECT          = 16,
+    /* Controller losing signal/interrupt enable states after reset */
+    SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET        = 19,
 };
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 19c600d5bfc..d1b1b187874 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -320,7 +320,7 @@ static void sdhci_poweron_reset(DeviceState *dev)
 
     sdhci_reset(s);
 
-    if (s->pending_insert_quirk) {
+    if (s->quirks & BIT(SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)) {
         s->pending_insert_state = true;
     }
 }
@@ -1307,7 +1307,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
          * appears when first enabled after power on
          */
         if ((s->norintstsen & SDHC_NISEN_INSERT) && s->pending_insert_state) {
-            assert(s->pending_insert_quirk);
+            assert(s->quirks & BIT(SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET));
             s->norintsts |= SDHC_NIS_INSERT;
             s->pending_insert_state = false;
         }
@@ -1557,8 +1557,8 @@ static const Property sdhci_sysbus_properties[] = {
     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
     DEFINE_PROP_BIT("wp-inverted-quirk", SDHCIState, quirks,
                     SDHCI_QUIRK_INVERTED_WRITE_PROTECT, false),
-    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
-                     false),
+    DEFINE_PROP_BIT("pending-insert-quirk", SDHCIState, quirks,
+                    SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET, false),
     DEFINE_PROP_LINK("dma", SDHCIState,
                      dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
 };
-- 
2.47.1


