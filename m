Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24CCCD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps8X-0001ei-70; Thu, 28 Mar 2024 11:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8L-0001KC-Ir
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:43 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8J-0002ny-Rx
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56be32b9775so1376425a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641458; x=1712246258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrzkMtkcnF1yss3niHYQFeUj6lW7JvFYG513ZWQp60s=;
 b=uIgXU92Ol/NISoRgpNbzf/PzWEwBgS3/kVomi69bd5HXFLehCuA3Afao1WjECHViPF
 Cnkfnb7ihYF9IrUjgsom4QAbZxpwDE6CqMYds/+sDDnM1oEzgt5F6dLuZcHvz3erkJJS
 wG8zE10FrhUGKDIDtxtUEVaWBrN+99eT254X8mIZV3CNuaNipG0eag5TwlTOG8JLO9k5
 96DeHATjs3LvNAyutPTQ9f4YSVeRn9rQsyCEw7qM9ugyGHt9T/QljWOoyd6rvr5WilTc
 SSnVHVz94s9UkPsLVqd/S3f/RgFgSFg+/ph8KfZ7Eim92gOMxb6Nnr52Zht6Kerr+oaS
 nUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641458; x=1712246258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrzkMtkcnF1yss3niHYQFeUj6lW7JvFYG513ZWQp60s=;
 b=vEv1yVhmlUmQd3IoS9o0NJ67fQZGBiNRMezeUOIEZyUMCLeO7FmW/Ve2jTP3UwM5RE
 vdI3iUS+Wg4ij5gKuOQ3Elai91FM7DIBbHcqDJbTpj0KB5iJf0l78gYbOfFBPhgNQbyq
 TastFBpLyJ6a4c022MMGXOv5gB9hXzw1/A97muVE2eZNn8IeUMm45BKa92UgksQSoWeR
 1QP0KbUsxCeqhKTY9g/yLkcInwrNTwhAhqbnWe9Cv5r643skvuwOImafsVohtJ6RbrKt
 uUpcLyNJi6eFt5Iv1yBdhtLz2RbNeCXH8fzyjQ5swafje8bo8I70wprkbIwoBUeonNER
 J79A==
X-Gm-Message-State: AOJu0Yy5QdshH5bLce00GOrE7cwClqRjIJDEbCOFLlFG4Sc0xvr4SQyE
 wOKirrFWtGK+CtHS8U7jlX4p11ycQ+sYl8yCqN89LiWB2B49VbgWdnCeNSbvaeE36N9S55y9boN
 d
X-Google-Smtp-Source: AGHT+IEc3JVavZ6Yb+b8wnDqhR3/uKAR+Oeu24avwh9VyWUhM3fQrZfwqOBt+dWLPG1vVVlO5yf/BQ==
X-Received: by 2002:a50:9b0b:0:b0:56b:dce0:c795 with SMTP id
 o11-20020a509b0b000000b0056bdce0c795mr2044180edi.4.1711641458009; 
 Thu, 28 Mar 2024 08:57:38 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 ek25-20020a056402371900b0056bdc4a5cd6sm959160edb.62.2024.03.28.08.57.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [RFC PATCH-for-9.1 28/29] hw/i386/pc: Rename pc_init1() ->
 pc_piix_init()
Date: Thu, 28 Mar 2024 16:54:36 +0100
Message-ID: <20240328155439.58719-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

pc_init1() is specific to the isapc and i440fx/piix machines,
rename it as pc_piix_init(). Expose it in "hw/i386/pc.h" to
be able to call it externally (see next patch).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc_piix.c    | 8 ++++----
 hw/isa/piix.c        | 2 +-
 hw/pci-host/i440fx.c | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6510914803..9a11835b7e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -163,6 +163,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
+void pc_piix_init(MachineState *machine, const char *pci_type);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4f07476cfa..4a3ae72fe4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -111,7 +111,7 @@ static bool gigabyte_align(PCMachineState *pcms)
 }
 
 /* PC hardware initialisation */
-static void pc_init1(MachineState *machine, const char *pci_type)
+void pc_piix_init(MachineState *machine, const char *pci_type)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
@@ -437,7 +437,7 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, NULL);
+    pc_piix_init(machine, NULL);
 }
 #endif
 
@@ -447,7 +447,7 @@ static void pc_xen_hvm_init_pci(MachineState *machine)
     const char *pci_type = xen_igd_gfx_pt_enabled() ?
                 TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
 
-    pc_init1(machine, pci_type);
+    pc_piix_init(machine, pci_type);
 }
 
 static void pc_xen_hvm_init(MachineState *machine)
@@ -472,7 +472,7 @@ static void pc_xen_hvm_init(MachineState *machine)
         if (compat) { \
             compat(machine); \
         } \
-        pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
+        pc_piix_init(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn, \
                       TYPE_PC_PCI_MACHINE)
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2d30711b17..14dc9e78be 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -432,7 +432,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
     k->class_id     = PCI_CLASS_BRIDGE_ISA;
     /*
      * Reason: part of PIIX southbridge, needs to be wired up by e.g.
-     * pc_piix.c's pc_init1()
+     * pc_piix.c's pc_piix_init()
      */
     dc->user_creatable = false;
     device_class_set_props(dc, pci_piix_props);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index add99e4f76..9f47d5507a 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -374,7 +374,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
     dc->realize = i440fx_pcihost_realize;
     dc->fw_name = "pci";
     device_class_set_props(dc, i440fx_props);
-    /* Reason: needs to be wired up by pc_init1 */
+    /* Reason: needs to be wired up by pc_piix_init */
     dc->user_creatable = false;
 
     object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
-- 
2.41.0


