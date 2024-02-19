Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E216C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6g1-0001Tv-G2; Mon, 19 Feb 2024 11:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fz-0001TV-JU
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:31 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6fx-0002xF-O3
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412698cdd77so4570605e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360768; x=1708965568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHN0WwPF0EH6RoLWLYyydVS2IwI6/kKCgvu+Hk831E8=;
 b=Lwz6hbkWFbh8LMKWvjqaqdYZBj64xMBkroarhToBzNh7jTVIyZ5+MrCfFfdWFCbWdG
 CjairSSNxN0Ps9QJDLIyPXKlE8WOW2Gs1FFDtkKIGpbJlGqu0o0HbsyWDp2J1xlihmLh
 SRDg5H9oPZbw3XpPAal1lRHcn+S1PQwsXXy8bQ8TvrLNiP8lMprXQbvb8KnoJPQYW313
 CgQSqxYLuJXBf6clPyXtbPJKGC/InrQDrFYwVPjx9OqtcsY0kKjJ3Vdk1D1VrYMlTMdY
 mE4LuZKs3EWIMTH9B9LxSIBOnqtA18Apy7ZRRsk+eHaBSJ0BYCbx8YK04p1s31eFZbTV
 jR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360768; x=1708965568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHN0WwPF0EH6RoLWLYyydVS2IwI6/kKCgvu+Hk831E8=;
 b=gsnk5sn3HcuXrkaxpOhjzTJaYEU/WXF+MwNq6e/qhBkYWckmQA9rrbEA14zkONGURX
 u7csgOxFabRS5rKK5Gg0JUgRs7FHB/lbQWibDP95p0zn4tjncmaen3xyztyiud8aY0wl
 06oXOvRVmtMv54e466UyCLAwy3LB9MKqaG6W0nMWlImkVMGY5cEhxAIsoCXhn+gwxFOi
 KJHisTECtTbyLFnZlpHbOUvi0o/wHB5RzHYna6Ix610NdBMn111CS1zSo+70cFXp0iDM
 7k4a+gJ8bK9y3agZWS7EUctWE94phhsf8sJ7uMQ8+Ud8u4CHhYiV+uvL1yJcsFFIquUe
 jtGw==
X-Gm-Message-State: AOJu0YxI0p9Lfe2nghDZEb+0UyL0gVUNHakbPaA6IXEjQzHgia/qLdwd
 l6BNnVveFiCZuyjP8kfbBxpoq2IaXA0jYaUQ5JsF4U8cXVKe1BOPEaeySTKDGHcmJD7QpWaP1SO
 J
X-Google-Smtp-Source: AGHT+IEoHJLzHVLTyvEwbEyxFoRPNZDGp+cW+mz77MnRgCdXqHj3vgP1XNARDqQ9ooduA0YUS1oasw==
X-Received: by 2002:a05:600c:154f:b0:411:de5c:8023 with SMTP id
 f15-20020a05600c154f00b00411de5c8023mr11101835wmg.4.1708360767825; 
 Mon, 19 Feb 2024 08:39:27 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a05600c378100b004125f34fd7csm7131030wmr.31.2024.02.19.08.39.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:27 -0800 (PST)
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
Subject: [PATCH 04/14] hw/acpi/ich9_tco: Include 'ich9' in names
Date: Mon, 19 Feb 2024 17:38:44 +0100
Message-ID: <20240219163855.87326-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Make it explicit the following are ICH9 specific:
  acpi_pm_tco_init()  -> ich9_acpi_pm_tco_init()
  vmstate_tco_io_sts  -> vmstate_ich9_sm_tco.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h | 5 ++---
 hw/acpi/ich9.c             | 4 ++--
 hw/acpi/ich9_tco.c         | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index 2562a7cf39..1c99781a79 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -75,9 +75,8 @@ typedef struct TCOIORegs {
     MemoryRegion io;
 } TCOIORegs;
 
-/* tco.c */
-void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent);
 
-extern const VMStateDescription vmstate_tco_io_sts;
+extern const VMStateDescription vmstate_ich9_sm_tco;
 
 #endif /* HW_ACPI_TCO_H */
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 228ebc9a1e..660fa6a082 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -186,7 +186,7 @@ static const VMStateDescription vmstate_tco_io_state = {
     .minimum_version_id = 1,
     .needed = vmstate_test_use_tco,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT(tco_regs, ICH9LPCPMRegs, 1, vmstate_tco_io_sts,
+        VMSTATE_STRUCT(tco_regs, ICH9LPCPMRegs, 1, vmstate_ich9_sm_tco,
                        TCOIORegs),
         VMSTATE_END_OF_LIST()
     }
@@ -317,7 +317,7 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     memory_region_add_subregion(&pm->io, ICH9_PMIO_SMI_EN, &pm->io_smi);
 
     if (pm->enable_tco) {
-        acpi_pm_tco_init(&pm->tco_regs, &pm->io);
+        ich9_acpi_pm_tco_init(&pm->tco_regs, &pm->io);
     }
 
     if (pm->acpi_pci_hotplug.use_acpi_hotplug_bridge) {
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 81606219f7..dd4aff82e0 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -224,7 +224,7 @@ static const MemoryRegionOps tco_io_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
+void ich9_acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
 {
     *tr = (TCOIORegs) {
         .tco = {
@@ -250,7 +250,7 @@ void acpi_pm_tco_init(TCOIORegs *tr, MemoryRegion *parent)
     memory_region_add_subregion(parent, ICH9_PMIO_TCO_RLD, &tr->io);
 }
 
-const VMStateDescription vmstate_tco_io_sts = {
+const VMStateDescription vmstate_ich9_sm_tco = {
     .name = "tco io device status",
     .version_id = 1,
     .minimum_version_id = 1,
-- 
2.41.0


