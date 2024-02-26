Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F460C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYwP-0000Z3-DT; Mon, 26 Feb 2024 06:14:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwN-0000YE-V0
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYwL-0008RJ-UW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:14:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412a7b68809so2833045e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946072; x=1709550872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/Fkfjcs9G3hXZQ2TEH/vNoM6jNLvzBhoSDBD5uo4Kk=;
 b=L+/E72lbE36HRYDZ716YqG53D/dDcfpPwdG0mP1NSLOpBJSBtTBoWi4GYvGFDc98VH
 BKT9a+hIOGWxvLC4JUj1qaarIF1huVZVoz29CYs+QLeoGyp+MIW+HShA2nBS4e4JEbuz
 e4ydxWtk9cPVKv/9H+2fwxTmN7O23IcOY1o5rwkLC+uwVZyqusJlVvtP0l4uNBLjggj/
 dQDihewvDFJZvdgb8MB/kRfdoQj8ctjNmIn5jsXiE7wbrIXjSgw86qwIjtEMsPNUogMW
 m7M2Jk/66p2Xmh+COkFw/AS0trip4lr9xtwD/Cks4L5robNpUXXHxA8n/EedoZKipd9a
 RN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946072; x=1709550872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/Fkfjcs9G3hXZQ2TEH/vNoM6jNLvzBhoSDBD5uo4Kk=;
 b=v9I8ezgfZ7hLoRFBncz3+LfJyWX14bonSDxNkvDdHg+kA+sYzyl6u8NEhRj2+Rw1Y7
 y57J2N8/l7t8yCfHeF7bMY3hUI+Bs9Oe7AllSpqbFnxGOCfKRrOHnZKbLlg2QBmFDTrP
 EvTT6bjubhLnbn5FEV5Ug+m+oLw97ejgoXf6heVdCZ68+rK0NW459V/odXHoICAHn0Em
 HvnZP11tWZTegaAgIgvGFZyJLTmrI7fuSjdv1Okqz1VaB9y5G39Q7wexy8HenF6NwQGh
 kc9aHOxjCDEUAlHk/VeiwqR9EPT9U6sVmPmy42Z+NVc9oKfcqDuqPVQvTqEqUpthZyQi
 ymkA==
X-Gm-Message-State: AOJu0YzMRgcMVa5gqPKEGZf4Xn2cTwUXfxIhP8bfUYGIfBGIWNU5iyCQ
 VUO84OiUL8hB0RRKamsjLi6LHFd2KTHknLq+QOOOPUfSqvSWQiOhwdwJC4kJU5OVOXdvGsAH1ZM
 D
X-Google-Smtp-Source: AGHT+IHP5Q8sS+F9kh0R4zB3EkKL/sIsggBdSvD7ilGLTi6JTskd+qYlvCOtweIZ323QHzCgbo/WYw==
X-Received: by 2002:a05:600c:5493:b0:412:f24:560a with SMTP id
 iv19-20020a05600c549300b004120f24560amr5140259wmb.11.1708946071905; 
 Mon, 26 Feb 2024 03:14:31 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a05600c219900b004128c73beffsm11638564wme.34.2024.02.26.03.14.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:14:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/15] hw/i386/q35: Add local 'lpc_obj' variable
Date: Mon, 26 Feb 2024 12:14:01 +0100
Message-ID: <20240226111416.39217-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 hw/i386/pc_q35.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 45a4102e75..dcad6000d9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -124,6 +124,7 @@ static void pc_q35_init(MachineState *machine)
     X86MachineState *x86ms = X86_MACHINE(machine);
     Object *phb;
     PCIDevice *lpc;
+    Object *lpc_obj;
     DeviceState *lpc_dev;
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
@@ -223,6 +224,7 @@ static void pc_q35_init(MachineState *machine)
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC),
                                 TYPE_ICH9_LPC_DEVICE);
+    lpc_obj = OBJECT(lpc);
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
@@ -231,7 +233,7 @@ static void pc_q35_init(MachineState *machine)
     }
     pci_realize_and_unref(lpc, pcms->pcibus, &error_fatal);
 
-    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+    x86ms->rtc = ISA_DEVICE(object_resolve_path_component(lpc_obj, "rtc"));
 
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
@@ -239,13 +241,13 @@ static void pc_q35_init(MachineState *machine)
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
 
@@ -255,7 +257,7 @@ static void pc_q35_init(MachineState *machine)
                                    "true", true);
     }
 
-    isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
+    isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(lpc_obj), "isa.0"));
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
-- 
2.41.0


