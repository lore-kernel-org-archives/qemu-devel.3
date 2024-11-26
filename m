Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B52D3B985
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 11:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFtgc-0007TB-RH; Tue, 26 Nov 2024 06:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfQ-0004A8-Eb
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFtfO-0002uv-Ez
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 06:23:40 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so14202005e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732620216; x=1733225016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KmjwRfDIQiUm8za7VsqVbrrytj9VplHKG4K4/ENa984=;
 b=BOhYvLSdzjt1xhenph6peYqQAZCaFEfgTDDtWJwzRS8p/m5xjIPCKAYrBQvIoc/h9C
 FPSJ4P/JaPdXdSLwTjzygzPr7h8oKKHAvq9ZPH2zbJEmTu9zSyKrAHfZIl8/wWciHG93
 dAo3KTAjE0AdvObLhPSF9XB7FVd0ohOHaA8chV5pyLOTrM5IY4ybwW8LgO2XXuhHc9L/
 YQy72N5VEAfHQlfLsfyIwo1yZId+5twyFUg15U6GXaCqX85BvzCC1yeK98yu3sNPY06R
 59HvK2OtTQOKUqoJSBREoo8nkupH1faqv3rH9vgPcusDID4pMzjQ0Al3YZA6NFp4N8wj
 FBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732620216; x=1733225016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KmjwRfDIQiUm8za7VsqVbrrytj9VplHKG4K4/ENa984=;
 b=GjCIBM3PyazSORUSsQgqkcwAMpjLJsmhbkHlcXpQm5SeaniYPwFEgRsv1u5RM3aX8q
 1wL1yCbAu3706FO6d779XaDNUzI+OeNj8cOoO/wUyyggOBZd9lEfSK0+316C24Aq12oK
 EHRSnSRsc2c14ZuStw2opOe00ziHvj4fAIn2ouPc6IVgBu1yMWjJalZYe37tYTggKQQN
 cYhcDZcg5lkgzCIR4OE8BN7uacGaNGiHkDuH3o0UJMAN/mTV+2yBNHfrfSz5oC5sO8qA
 IEgwZLD9/4Dq0vJjomxnNTlg9u6UazGsi2VRs5lmxurC2Jox9h4PQUA1WPxePo9tPZrW
 Uegg==
X-Gm-Message-State: AOJu0YxwQt42aQTsN3jXGgiXBj7eNqhRT65Oe250Sn/6KNkjzT5YssuH
 wAUeyyjN3VfppWcO90vnUrrV6kaUJERW73VfetoI6P2Wb0rLbj2I2s6qvkW0f5hXIwhu39AlY7v
 j
X-Gm-Gg: ASbGncvxWsVS8dWr0ma89xLibDODyC7PnECO4obhMbfOR517e0H6o32O3FTYJpH9t/k
 j6AoefyWtXXmKq1uZfyKWrcNZNztYqKCS5eRC8b3TOnfAvtEt03AwUiR98cwpOas9MBw2fh+lT3
 ZQihkA0tUAdIAQZMReIQ3X3Z7h5QaAoNEOGFjUOSI1oVFPUfP1jSHD8xAGYGl008eoi40Ma888j
 tS0iK8FmlF/kJLEnlaL61alGLB3fMMR9XLiCw2fhFyxJZi1V9/cuwCTpONvrg2ThF3ndth1
X-Google-Smtp-Source: AGHT+IGNwk5YaoQ3MtMRaeTJJiZlPzdpzODnHSlG5QE/xiL6kyITv2jIVbls5681MCpH5aDCJT12rw==
X-Received: by 2002:a05:600c:3589:b0:434:a4b3:5ebe with SMTP id
 5b1f17b1804b1-434a4b35f4amr28161585e9.24.1732620216243; 
 Tue, 26 Nov 2024 03:23:36 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e1188sm231855865e9.1.2024.11.26.03.23.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 03:23:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 v2 09/13] hw/ppc/spapr: Create host bridge setting
 bar_at_addr_0_refused=false
Date: Tue, 26 Nov 2024 12:22:08 +0100
Message-ID: <20241126112212.64524-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126112212.64524-1-philmd@linaro.org>
References: <20241126112212.64524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since all sPAPR machines set MachineClass::pci_allow_0_address
(see commit e402463073 "pci: allow 0 address for PCI IO/MEM
regions"), directly create the host bridge passing
bar_at_addr_0_refused=false to pci_register_root_bus().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c     | 1 -
 hw/ppc/spapr_pci.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c564..8af56bd68a2 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4600,7 +4600,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->kvm_type = spapr_kvm_type;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
-    mc->pci_allow_0_address = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = spapr_get_hotplug_handler;
     hc->pre_plug = spapr_machine_device_pre_plug;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index e6e8018c1cd..1d12c0b4112 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1886,7 +1886,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                 pci_spapr_set_irq, pci_swizzle_map_irq_fn, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,
-                                TYPE_PCI_BUS, true);
+                                TYPE_PCI_BUS, false);
 
     /*
      * Despite resembling a vanilla PCI bus in most ways, the PAPR
-- 
2.45.2


