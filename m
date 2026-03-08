Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1FCEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMiz-00028o-8G; Sun, 08 Mar 2026 18:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMix-0001zu-MY
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMiv-0003J3-NI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:35:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso89215865e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009344; x=1773614144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gk2rwwBrHZhMQrfODT1MQGRLgxz5V9+zQXEuJZbNKHo=;
 b=hP784BWY4babjGWVQj4+/aiy6rqrf5mcGHPxRq/hCOMtOE6JcqWICIFrd9en2HGDv+
 ClrwasEwFmJohyvkId5Fzr1da9R00jsaKTeahNZW7UAMw1nxFM4oD0yqibOYAFk3HOL6
 CaU0Lc2LgxDbPKjlLAie745eg7ubOI8PrFZ1AzPIzaCIOeFiIEgQ6SOmUPRq/b0l7vxy
 TQwL8wUdMVEZnY/9J/1J2Yp+vPsDfZpgI6bAu6eReErcVBcPbZOx1FuZ6orgj9P1ZIRb
 2obL1iwY+w/eJ+Lt6RwfisjlKnflh9mYPlZtfYQ9Xxi9vCesWyos5//aA7iHRF4N0bDu
 LakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009344; x=1773614144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gk2rwwBrHZhMQrfODT1MQGRLgxz5V9+zQXEuJZbNKHo=;
 b=wptoUkUIDOiVFeWFI2ghVR06qytP60MxbcOXBLZmGSaWL2/7Exxf5RZQYdC4s9TTOc
 KegM7mjHIsRyJTAxqQGhlJlj8nu90B5X9IqNA295G6hcYJiXsVvsf8ihiGUffd9TpLn0
 a8RRI+Vk2Sz0JGcZFFjTPQjvTGdl0FTcCM8ndj5OaUkuaa5Ww9VvMYD1wYzkYCbJrBgl
 7TIs3g4dAZ7ilYm7tOqGkmA/40UK34mKWqN0UCSIZOHs8hIRee0IP+3nFLVKajoK11wS
 5AgU1l2VRRYBf8OukvrBGn8z8RdPi1D/5Y94jOqDibzqdxdH1JXhZD99Hq6rpZFaEPPO
 F8/A==
X-Gm-Message-State: AOJu0Yxv3IM4i+huWpNhxB3BHxfSbFoFdLBrpLZeIXDb9h7/RTAipOeP
 GB9Ugm9LlkJMcc3E7yRYglz7D1SIGNSqQdEHSCkSnddsDDC/N1War7nMuCjC7UcgIv4W98e4sO/
 9jO4mMds=
X-Gm-Gg: ATEYQzw2G9PPdriNIWoNDXpoLA1y5dT0Be6LvLf7uKEQjEeqXtNY/AuqagAurGrMhWc
 4824dMSR30o+YFNoeX1Xb7vqvT5ka6acofzmQXLdQ8pNiUdi6gOxE6o9NOrnzKwTdGydZnU+uTV
 b7fRepSrxXdxqMcy9LJ7LUwgB3a1TVrD8a0SXf0IWAOkzj5MZgoYxM0TDywFd+W+7Jvosqh8z5c
 G+rq1m7LoKg0ptVczudnMViaexdeBDxB3+E8fw3pm0MUb94VByZtHKfsi54Ghw3d62KMZjqCPwR
 /oU9OH/8vEDHpUiiQgOyO6laymyjXyAGkKEq75V5RAxd4B/NQk1AOYGH+5r8AmnTgjOat4RJtbt
 6k6yNSpl0EAJ5aRrtMZJLnT4pOLYc/LTTu0llpqRm8o7J1Bj/yIegWySRMqPHrT2BCgSjs4dcHs
 ivi48kFcDBIisT/VRx8J9cxvMmURDU2mkiMqDV5LDJDGFZjcvjwBrET0E0fpOTbVjOdW75AKzK+
 BiUPQ==
X-Received: by 2002:a05:600c:4f55:b0:485:3c66:e230 with SMTP id
 5b1f17b1804b1-4853c66e4eamr10341165e9.29.1773009343560; 
 Sun, 08 Mar 2026 15:35:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852f6994a1sm114992955e9.9.2026.03.08.15.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:35:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/49] hw/acpi: Build stubs once
Date: Sun,  8 Mar 2026 23:33:54 +0100
Message-ID: <20260308223433.25503-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20260225035739.42848-7-philmd@linaro.org>
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
2.53.0


