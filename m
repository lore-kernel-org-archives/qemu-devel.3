Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2A1CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4d-0007p4-RB; Mon, 13 Oct 2025 15:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4b-0007ji-Re
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4Z-0001uo-UD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so27455415e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383145; x=1760987945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WnbAZzepaRMWzlpCUMsot+yvnYOzsKGcRhhXaoGje1U=;
 b=WtxW+CNzAGe0/iUCCkiHS7QdfQAdFo1qHOceWeQTrlkEEcHXjGOLQ44HZfzAJKWAzV
 RvnEjDka+gWQcpoXU5zCLbSzCJzO9TxQESWvr/jR1EHw0U1bcsckube45VzW03X3w3xD
 NRInEtKl5XiAR8pYGh8JBF98osesAQEqFnkB8LbtlOOBCRF4ji0iCU+UMf2BXqzRyPFn
 jyIGB4CWCUKXpEIMaO4kc+ZrVCx/8BpAH7wZ8klMvfRUbu1c5G0JY6YtQ8wQY5xj/mzr
 7a9LjC0Q8MVZeYrHMr+Z0GzZ2boqsVohelDUb3Mh+6KIEBFTPea/BnLlyZb9biSJEnRa
 5WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383145; x=1760987945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnbAZzepaRMWzlpCUMsot+yvnYOzsKGcRhhXaoGje1U=;
 b=rlm85/TYPE7tdLsTxo8gcaVVgE7To4367NeCKB8wKRKplFAQy2a09VSfuXXXSp6HUG
 DAersifkiN81eV4QsUktrO0i43mOyiy2WuRQDDiUXcLgXQzKTg9JDLRHwYRZdM0ouCAu
 mFbdqWEEO1i7Q8qaU6MbnZ9hMtoGOjzjzyyWPClPla4V9aAuXfzYS1Flr4ynQyZ7KoTq
 y7mXs8MRhafa7PV5fT6k+P36HEqzaCuKIpIi4YcdPWc1wllUtacVxYdx0bmJQKWkKJjT
 gLGRSxXM0/C3lRP5RyaEqzyqWBkQAz/j+GOXAJOJB9td/eLnFo0PPsnaC7/Q8Kaa2nhm
 VT6Q==
X-Gm-Message-State: AOJu0Yw4Dk0h1VOKLLKGF5dGEut11i5ymAT5JwlkuVHa0G1HjiGsQhIC
 TB30kYfpI2CysvEInlX9U5OZZgTRnA/wBCkzOwUyz+oAaw9tekdUrY8+sGMcz0ISJE/NDHiPyEk
 2/X8aNuS7DQ==
X-Gm-Gg: ASbGncvTu3TfsiwgSD8lDTta/XoQbH5yVK9pNZdGVoBuAy3GCFZbHqoRQTStKS+naYg
 Unj652nw9vF1vZ/f2+FNhPFWspLcx4+ZcjtTkcbd7anQBGSyOGyuJj0Nyh4YlUgXquc7FSA1xSx
 g51dBKfhM1OfkQsztdC0C9yRn25ustZjbldXE2wCAjcL6+20/XHZOVcqBaTdz87fUWdTse+zw7N
 irze0372P03ig0ZmctdTI00Qm4e78B+sQ/U/WBItmt4A4+/IofugLC9QrHO2ZCreL+G5A9J8mzY
 sUA4g6qreeAyWNIJWNCy3potRdTCW6fXz0pIZtAMKy3BhMrwM2Ha/WMMrHmwoRzIWM/Ig0fziP3
 3IYLBmmHIhSOE3+TDFpBBctKF12VyWLg2tDD1XBbuEF2bcnr3Ln9lwiU8nrXBb8lShruGwPnWge
 Ezk/uxx+ihFYEdZeudesqnNHGYzcWtFw==
X-Google-Smtp-Source: AGHT+IERRofb8xri21ebdCSHVjcN77IIddjz/PPJPaRghO/Pqld/+xwhHvwZs3hYsDSHfFgl1dvHOQ==
X-Received: by 2002:a05:600c:4e0c:b0:46e:4c67:ff17 with SMTP id
 5b1f17b1804b1-46fa9a98d8cmr135269265e9.14.1760383145007; 
 Mon, 13 Oct 2025 12:19:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ec3ab5f7sm965892f8f.43.2025.10.13.12.19.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:19:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] hw/hppa: Reduce variables scope in common_init()
Date: Mon, 13 Oct 2025 21:18:07 +0200
Message-ID: <20251013191807.84550-13-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010061836.45739-4-philmd@linaro.org>
---
 hw/hppa/machine.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c8da159a114..cddca69b938 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -352,16 +352,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                                         TranslateFn *translate)
 {
     const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
-    const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
-    char *firmware_filename;
-    uint64_t firmware_low, firmware_high;
     long size;
-    uint64_t kernel_entry = 0, kernel_low, kernel_high;
+    uint64_t kernel_entry = 0;
     MemoryRegion *addr_space = get_system_memory();
     MemoryRegion *rom_region;
     SysBusDevice *s;
@@ -431,6 +426,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
        firmware on 64-bit machines by default if not specified
        on command line. */
     if (!qtest_enabled()) {
+        const char *firmware = machine->firmware;
+        uint64_t firmware_low, firmware_high;
+        char *firmware_filename;
+
         if (!firmware) {
             firmware = lasi_dev ? "hppa-firmware.img" : "hppa-firmware64.img";
         }
@@ -467,6 +466,10 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Load kernel */
     if (kernel_filename) {
+        const char *kernel_cmdline = machine->kernel_cmdline;
+        const char *initrd_filename = machine->initrd_filename;
+        uint64_t kernel_low, kernel_high;
+
         size = load_elf(kernel_filename, NULL, linux_kernel_virt_to_phys,
                         NULL, &kernel_entry, &kernel_low, &kernel_high, NULL,
                         ELFDATA2MSB, EM_PARISC, 0, 0);
-- 
2.51.0


