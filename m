Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A483C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJRK-0003g6-Bv; Tue, 06 May 2025 10:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPs-0000Zc-6X
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJPo-0001C3-9y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:37:03 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ee682e0ddso3874547f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542218; x=1747147018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+ePe9xc1+7Hh1G4ScYYntuCTcijTJucTsY2+jDiMmw=;
 b=o7u/7wLaT/tZNmqmd1oElzWF5mXuTfpYzpJfOHfGNJgqW3hR5KKNOZ2OWnupUS0r5m
 ISooam33R/E+Wat6HBKSJTQfioij4YbGNTdjocybiZEtTb2gru1VPr6aK2cU1uqex+Iu
 9zlkBcS/Vzict20K1qmMrOUHYizm1OyUhH4Gg0z4jq41gV7qGXDSmlrtwKlBNy4nrtKd
 9Qt166qX8nvqlZzL8UWPFr4tShluEJhDVAF8YtLSKxLaytiME++BqwKLwiE1C8lzePEp
 yeWLBDLotRBY5poHQyL18rZmN4kd1j5wkk3EszfnOwPNtZ6rNg4eW6xJaPwCDH7bcG89
 QXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542218; x=1747147018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+ePe9xc1+7Hh1G4ScYYntuCTcijTJucTsY2+jDiMmw=;
 b=HGbu5+uN6s8ROa/7Te9LJahORZZJ2lVnWooTndDNqi54KDB5ku028GQq8/QmI+GVmR
 9Xz2qeSV8OMc/JNB7jxsuHoux28QRVOmG5xikbXHw4MNmVzXPLU6ePv95fu9HFlmvHkL
 4HvccDOPAbTSQ6k44Xzk+8EyxU/CqpXw3NtDERPYRUAKPA4RRVHrQYO4HbeHBENsQ5/V
 TRADamLhpoNphhs8rdZzCnoOL9K6vygN2JwXn2nP1XRuytk5SQRzepqDbDplA/CgUe+0
 fzSe3AM/DjGsUOfJUF7vgn3kb0+g0xRpafe0AWSn66LmYP/531J7Anj3R4m56krTVbM6
 S3OA==
X-Gm-Message-State: AOJu0YwfDHBieSzpgp5f+B/twprjJGmbzw/eSzSpL8MfqN1HKb7xBTrq
 j3rw7l1ovNIcJT3qaxM/WcZbKxOt0ssUAu/3Zyu34wSGFeUXvpBQeA1AFpzmcVyfhVRQ2/I0X+S
 E
X-Gm-Gg: ASbGncvSSImgzpzpbw+umE/sqDxCn7VcoJmwdONkW8l76WUwngQLZMtr8PnFlNNK+Q4
 PFNOjhekdjdqldFLEdUrflylXA1NbgIA1bdzKlsxN9ho8SlBRawvPjkT4PoCE2+TqWg214WEHif
 kmpKbDLGUdOGnX3WW5jAFq9z8l4zshYEwi+OwbS5ckbI+jm25yHb8SGvl3jdYLOIkAZzE1iK9/N
 KcKKRqMZPDvWYt20YfDctXCAwnUUghsX9o/mbJnx3LPSMT3juylaglWF2mipftxFmvWr2TZpReU
 qtQ8BwMYfa0YdHx4JD9O1mMSQIMhsqp46S8WLDWY9NJVAUCfS3oDHQf4pcJcTG68GXwdUqvKhPw
 FmZ6S0CjqLf72ICmd307+
X-Google-Smtp-Source: AGHT+IErTmQIghy8kHjnlcb7/vi0RtngPFaOZudEl5QBeEfz1iJweRYE6fnXrEd2nurJfugKEtbj0A==
X-Received: by 2002:a05:6000:22c7:b0:39a:ca0c:fb0c with SMTP id
 ffacd0b85a97d-3a0ac0eaa3dmr2709117f8f.28.1746542217769; 
 Tue, 06 May 2025 07:36:57 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0ffbfsm13649447f8f.80.2025.05.06.07.36.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:36:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/22] hw/acpi/pcihp: Fix typo in function name
Date: Tue,  6 May 2025 16:35:10 +0200
Message-ID: <20250506143512.4315-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143512.4315-1-philmd@linaro.org>
References: <20250506143512.4315-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Fix typo in QEMU's ACPI PCI hotplug API function name that checks
whether a given bus is hotplug-capable.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20250504215639.54860-10-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/pcihp.h         | 2 +-
 hw/acpi/acpi-pci-hotplug-stub.c | 2 +-
 hw/acpi/ich9.c                  | 2 +-
 hw/acpi/pcihp.c                 | 2 +-
 hw/acpi/piix4.c                 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ac21a95913c..a97904badaa 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpState {
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
                      MemoryRegion *io, uint16_t io_base);
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus);
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus);
 void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp);
 void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index b67b4a92da7..b7bc6e40a1e 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -34,7 +34,7 @@ void acpi_pcihp_reset(AcpiPciHpState *s)
 {
 }
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
 {
     return true;
 }
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index c7a735bf642..a07c9d115b3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -570,7 +570,7 @@ void ich9_pm_device_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
 bool ich9_pm_is_hotpluggable_bus(HotplugHandler *hotplug_dev, BusState *bus)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
-    return acpi_pcihp_is_hotpluggbale_bus(&lpc->pm.acpi_pci_hotplug, bus);
+    return acpi_pcihp_is_hotpluggable_bus(&lpc->pm.acpi_pci_hotplug, bus);
 }
 
 void ich9_pm_ospm_status(AcpiDeviceIf *adev, ACPIOSTInfoList ***list)
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 5f79c9016b4..aac90013d4a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -371,7 +371,7 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
-bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
+bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
 {
     Object *o = OBJECT(bus->parent);
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index b16d45f03e1..d98b80df6dd 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,7 +406,7 @@ static bool piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
                                       BusState *bus)
 {
     PIIX4PMState *s = PIIX4_PM(hotplug_dev);
-    return acpi_pcihp_is_hotpluggbale_bus(&s->acpi_pci_hotplug, bus);
+    return acpi_pcihp_is_hotpluggable_bus(&s->acpi_pci_hotplug, bus);
 }
 
 static void piix4_pm_machine_ready(Notifier *n, void *opaque)
-- 
2.47.1


