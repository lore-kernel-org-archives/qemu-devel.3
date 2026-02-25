Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22C7F55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 03:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv62g-0004jd-Cj; Tue, 24 Feb 2026 22:58:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62c-0004VD-Qi
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv62b-0001jf-1z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 22:58:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso46779135e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 19:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771991903; x=1772596703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65XW+i+4Aw+d+A8Xw0KKYnId/rPY4h2E5dPDgaUQvJY=;
 b=To4oOxLqE5uCpfSkPQm3/q/9j3gOmcpLOJVRgA2ye6m6Tm5u0HUP/4S5O47mj+yNs2
 Cd8o4zIO8yyO6BK6FC/odseyvqlSqyQdVrES4/CcZNGgSlNZPbjoI0339BtXlkktU/lG
 PO4/JwlceDVGFg/9vbywscCCeGPG7k4Mnw/UhprdBHLkOGDR2HwCJ+mMiaVF48M893uU
 FkZ0Hj3iA4KWwu0r2qku2dkwVxj1Q1XOs5VG7N6wr2P1/igpAoCCVOROuFymHZ3WiH1W
 XjMi4/jH9jirsmebE9qV6xjBXDXe3QPxctCe9RjIcJTViiT646Up+wY4bmvV5n/utVZ9
 rAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771991903; x=1772596703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=65XW+i+4Aw+d+A8Xw0KKYnId/rPY4h2E5dPDgaUQvJY=;
 b=cpAgmo3mKCGh12dxIJ3oonpBKiU+HbAQ1Vfi5YZsuViXZmv36KVMBHHOzGmeGEVvtA
 WJfdw4cBLYfAsNBWbRp4l2xhgsEmwmPZTC0jTrkiwpyteRMKuILrVopsaftCOiFYtpPq
 AwRS7QC9jLpz4xDk2J+a3YdFjes3S275I5Y+gZDdLV+mgC6zpXmYGDNBUH7DTBTulCKp
 yJgPMsjISLydKhHQTwh6idTWzK20QLiVA5xBwA9s7g9eTM9s157zlvJOnK1SfDuzKwQs
 gx7JOSxpSY2M5DIvulzfOfnvtyTXr9e1huoyhaICBnowswwLz9jBYznqbPVdHuGZ/epL
 1npQ==
X-Gm-Message-State: AOJu0YwOxIgGWxPv0Bd6yX78miQiRwralIrtSYMholnLfUGYFN9H2vnI
 Jx/vbXa5k7VI8YmsMzqmD9qgLPalGTjBO85g1K3IUJ0XdH/W9GH8VrqBu6MJNQAlVzTNoxKXFol
 O2CD1rgA=
X-Gm-Gg: ATEYQzw0IJIX0jPG16Bm6tTOWAmG+YIMCbemRxnaSRW7JUCTuWuovnU6mIUyKHSG89c
 7AMqNxDiJhApBTuPxoOg2TKaUYmqa2qMdOLf4C1ww14/kggCsEdDR7KwP6WyZrsI4a0mxEBRqu4
 TQfhu+hnN9dfyzOZWv/T4XJhgRA6c2isips1woNkmsR0ZMB7X0BmdFWPIJMUQ7lsGVm3KiqY9AV
 xWG4RU3QZD7SldvFPt+6Ax5RfUF3JWh628BvhQpGK7dlRdhKdHzpKY1Di1HHjOai8LuE2cuqDYs
 7d+SYZwONZNRnpt41EudG/IP+VMSJ2BQG1dDi4NsxaXt6rL0BepfYXlD0BG8NaxSqN04cGmPFAp
 bB+7mXRBlstD4lhCI+HQjebsFewl2NE1W4rmR2A8ULCVSYb69lPRtYCrpR1K+zUwe5dzEYV1K7u
 hqZiSd8+yRbXOq+lJEHadMYX9DryLtORQ9zq34XQMlweyOS6n+Ou7Zm5wV1dxd4rLpHyPovMXP
X-Received: by 2002:a05:600c:a00d:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-483a95bf2f3mr257328345e9.14.1771991903114; 
 Tue, 24 Feb 2026 19:58:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75dfaasm35076965e9.12.2026.02.24.19.58.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 19:58:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 06/11] hw/acpi: Build stubs once
Date: Wed, 25 Feb 2026 04:57:34 +0100
Message-ID: <20260225035739.42848-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Move stubs to the global stub_ss[] source set. These files
are now built once for all binaries, instead of one time
per system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/acpi/meson.build | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index e1e848327b9..1c5251909b4 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -6,33 +6,36 @@ acpi_ss.add(files(
   'utils.c',
 ))
 acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_true: files('cpu.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_CPU_HOTPLUG', if_false: files('acpi-cpu-hotplug-stub.c'))
+stub_ss.add(files('acpi-cpu-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_true: files('memory_hotplug.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplug-stub.c'))
+stub_ss.add(files('acpi-mem-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
+stub_ss.add(files('acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'))
+stub_ss.add(files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'))
+stub_ss.add(files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_true: files('pci-bridge.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_true: files('pcihp.c'))
-acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'))
+stub_ss.add(files('acpi-pci-hotplug-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
-acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
-acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
+acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
+stub_ss.add(files('ipmi-stub.c'))
+stub_ss.add(files('acpi-x86-stub.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
-system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
-system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
+stub_ss.add(files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c'))
+stub_ss.add(files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
-system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
+stub_ss.add(files('ghes_cper_stub.c'))
 system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))
-- 
2.52.0


