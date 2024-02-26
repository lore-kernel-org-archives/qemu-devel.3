Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B4C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAi-00069V-IB; Mon, 26 Feb 2024 11:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAg-00065O-Fe
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:42 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAW-0006FU-1e
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:42 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d22fa5c822so48223531fa.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966170; x=1709570970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6KcXi7ub1LWF1H0fHJ1E8fzi9Cbgex9iIz41HyRMbc=;
 b=EsJYmrflOD26LJS/wXzRlmsdfyjuqIZABXSpJA2z53EEm4cUm21itVZ1g0xdCCRrdW
 KmSAYNgO1NCaflghcL+PRcCqvENPxTpVj8ANrM/eJfGWcXhimy7EYzE6PWVY779tmSEk
 rY2wTlD5ZobSVSUy6gHlFaY9rH2W4FpAFKqJJdYJx+D71K75p1knsqkXaE2NmjyMAFLV
 ZTaPog0o9VKSdNGuFVlD4cqglMdIuK6ePBMg8Ti9POx0gS+GRYyJLGe+fRGkfxa7Utra
 lNS0ymkqVx+Xy5Ql858uubgNiMPl5HkW/CQayUUN1Vheun+xAidef9VP+c4W06v7ksFU
 aUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966170; x=1709570970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6KcXi7ub1LWF1H0fHJ1E8fzi9Cbgex9iIz41HyRMbc=;
 b=OhR8PWq+NeKE0uLTdPD//ZOEVjz7VPlAIEcwDWvW5ZB7VGFKGgbg+1bv+XYCr3p4+c
 7+GfuTNgJd2ywpI+uOHgvw3D8EeHV/5F9jq3b7D+KhKfrGcH7SHENhNGc7mgsbRYQTyr
 sTLv3F05qpe/MVcSYusWmQ5s+tqQIqe10/xdVYxaJhuJJwiDn/24Ml2RySuo3duHPYrp
 UFCJLraama0YPeO0H+JXroyJ3zedo9mr1NsrfDTjfiv+Tqm4PD115h/4h+TqTqDQ++OL
 RJFEQ+Tb2MIBZ0OueXFwY1W3Bkz/ugRlUfE50TafRp86glDLNtzwotT8WORnjBBwRipX
 GiQQ==
X-Gm-Message-State: AOJu0Yze2c3uaMUBQOIS09Sb8Qm1NJpMWY6ugYas1O7TNkvwViGsCwRU
 DXHmGOBpTXpgpl/TeKLJtDf+J/CaWLG8wt3CQLj/xCGjIAFp4e9xoCxPAVngw/Ul9MX+1i4IcHy
 H
X-Google-Smtp-Source: AGHT+IHnpast/mEXTrJrNkX7+tF6NW5v7o3OTkGG3SWMa3Jg87IZlLHPQIBrDGZB/A9izdRwo7aPfA==
X-Received: by 2002:a2e:9607:0:b0:2d2:8a6c:3e54 with SMTP id
 v7-20020a2e9607000000b002d28a6c3e54mr2444119ljh.16.1708966170014; 
 Mon, 26 Feb 2024 08:49:30 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a1c7906000000b0040fddaf9ff4sm12391603wme.40.2024.02.26.08.49.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] hw/i386/piix: Set CPU SMI# interrupt using QDev GPIO API
Date: Mon, 26 Feb 2024 17:49:09 +0100
Message-ID: <20240226164913.94077-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
References: <20240226164913.94077-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use the CPU "SMI" IRQ, removing a call to cpu_interrupt()
from hw/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 2 --
 hw/i386/pc.c         | 9 ---------
 hw/i386/pc_piix.c    | 4 ++--
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4bb1899602..c8227e18c3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -148,8 +148,6 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 /* pc.c */
 extern int fd_bootchk;
 
-void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
-
 #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
 #define PCI_HOST_PROP_PCI_MEM          "pci-mem"
 #define PCI_HOST_PROP_SYSTEM_MEM       "system-mem"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 880e95de26..1df9f5ba90 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -651,15 +651,6 @@ static gboolean pc_init_ne2k_isa(ISABus *bus, NICInfo *nd, Error **errp)
     return true;
 }
 
-void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
-{
-    X86CPU *cpu = opaque;
-
-    if (level) {
-        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_SMI);
-    }
-}
-
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ce6aad758d..447130ade1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -345,9 +345,9 @@ static void pc_init1(MachineState *machine,
     pc_cmos_init(pcms, x86ms->rtc);
 
     if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
+        smi_irq = qdev_get_gpio_in_named(DEVICE(first_cpu), "SMI", 0);
         qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
+
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-- 
2.41.0


