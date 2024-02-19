Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F88C54764
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6fv-0001SN-18; Mon, 19 Feb 2024 11:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fs-0001RB-BK
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fl-0002vv-Ve
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso898234f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360754; x=1708965554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4FCzhBMxBMDZoobHoXe86blnQI4iLx/WEkq5NXhKrY=;
 b=JnyXsnuICmP5Jg8a/zmDVDVxQazwzX3Tv6u/RZpiIfm7eok2hFnOo5Q1kWJW0y6hxI
 TtjCSNJmnvfPNPTQqIk4UZvEkj6DqFoBM3AtIH+4e1rr2YUqbmJa5pO3HSsVEmwz107K
 oZZOuES1zVdRn2Gg5i9g7lHnY/GRy9i3b8Y8TFR0VDIHjbTNAAGLXydEkSqXUB2fuCUA
 jyAhuBskbiks4mOWPFmUA4W/8Ui/XAjhDem2eIo2YN0XZcSit0OWQT5OWcdAw8t4O6GL
 30r9lZaOVSgoxicf+guv6jEOUg5Zsn0h79WzcKLjOVhZtMDuk1nTZnrIDqAQg1EsCQ+l
 ET/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360754; x=1708965554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4FCzhBMxBMDZoobHoXe86blnQI4iLx/WEkq5NXhKrY=;
 b=rfM8Z7Har5IB2BG3hgKwzjH6JiMgt/SEJHumyRtT3c6fwbPIuj6YhfjVk4huVtsc1v
 x+cVwWtH9wnD8U4BdZkfHPr0qJm2sKDItGu0kwwhq9vwsOG5pYOqaKXNvYg0gbhrdt8d
 gOyThxvUp9r3YMSYQmpS1prQcxwsbvdPCODxP6uo2J1lf2OebXd2ZQwtk/AhhOBrZZuN
 dZp7NbCPyjjXVx94GrAvYP2Q45QLINeG+xp1rXh2RoXfttDXLZTpOAOkodP2DjtXaQaL
 pw87ZEhMScNUo3QcnrUYAe0DoQghcUjgxapUonrN1bptRF49+vLu2T9JzJOYFT1cdsMl
 bCCg==
X-Gm-Message-State: AOJu0YzSTU5wJ7I0mZwLWT/mCqvHxH0jgivpQS+3tCRvSsPowXFv21Pi
 bTLDterpUmCFIIRNIPDZtNxqoa8sT0EcD1+O1Xka98ksmy4fLM1xW6QXJHYtvjQ+vhZz2p2R5X/
 M
X-Google-Smtp-Source: AGHT+IFgBDkCLPS0L77lmL6b9/TMgs59h2x46S4M3Nc73nGqBRnmVDdlyQYzcd5a26zgtAyJ+Mv7qw==
X-Received: by 2002:a5d:5248:0:b0:33d:36e0:b9eb with SMTP id
 k8-20020a5d5248000000b0033d36e0b9ebmr3278810wrc.50.1708360754075; 
 Mon, 19 Feb 2024 08:39:14 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a5d55cd000000b0033b198efbedsm10733258wrw.15.2024.02.19.08.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/14] hw/i386/q35: Add local 'lpc_obj' variable
Date: Mon, 19 Feb 2024 17:38:42 +0100
Message-ID: <20240219163855.87326-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of casting OBJECT(lpc) multiple times,
do it once in the new 'lpc_obj' variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a91f414922..621661a738 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -126,6 +126,7 @@ static void pc_q35_init(MachineState *machine)
     Object *phb;
     PCIBus *host_bus;
     PCIDevice *lpc;
+    Object *lpc_obj;
     DeviceState *lpc_dev;
     BusState *idebus[MAX_SATA_PORTS];
     ISADevice *rtc_state;
@@ -238,6 +239,7 @@ static void pc_q35_init(MachineState *machine)
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
+    lpc_obj = OBJECT(lpc);
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
@@ -246,7 +248,7 @@ static void pc_q35_init(MachineState *machine)
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
 
-    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    rtc_state = ISA_DEVICE(object_resolve_path_component(lpc_obj, "rtc"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -254,13 +256,13 @@ static void pc_q35_init(MachineState *machine)
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             OBJECT(lpc), &error_abort);
+                             lpc_obj, &error_abort);
 
-    acpi_pcihp = object_property_get_bool(OBJECT(lpc),
+    acpi_pcihp = object_property_get_bool(lpc_obj,
                                           ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
                                           NULL);
 
-    keep_pci_slot_hpc = object_property_get_bool(OBJECT(lpc),
+    keep_pci_slot_hpc = object_property_get_bool(lpc_obj,
                                                  "x-keep-pci-slot-hpc",
                                                  NULL);
 
-- 
2.41.0


