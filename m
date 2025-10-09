Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3EBCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgH-0002MD-Bs; Thu, 09 Oct 2025 10:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rg8-0002KX-Ds
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rg4-00031g-JC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so5808785e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020287; x=1760625087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnULxl1nc/+onQALJYBkRQ6S/r+kyq2mZM+b+Qs2hhE=;
 b=nrLkSsIcUydo1WkfRHkgr4w3E08Wjqo90K4eX5au9F8XEnkr3GEl9hwMFGbz/rmhuK
 BMGRLvU/Tx0y6Kvv27gah+6zLoO7zvRAhUaknv1l/Y6zFpSklhHJYJeeoEz5aYmhEWI0
 QgHVsels5E+IFj35ECMS/6UEgkZ6bLEO5b0O6nEQRpl8m+NX6lOPrI6sfSX2Hj0vmB/T
 HPE7a1w4y5oodFGwUBoTAuE8uHvBLrYpCPOzVJy4Nyghh3o2lWZof10DsoLTPAhw+Ejc
 7PbcB8prigo/GUSHieuO8hThR/e7hcwLAmscs2uwIsodYvfIS8ol7iFibY3Kqjz3M6J5
 5PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020287; x=1760625087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnULxl1nc/+onQALJYBkRQ6S/r+kyq2mZM+b+Qs2hhE=;
 b=tcVUPJPYce19ckCI1gzfU2Ix1BHXAkzB96LgJ5MMI148aadK3DQ97Tsyq7eXTFZz2c
 YWQauXXnI6LB6Fj77xdwkVtr4z7MCuH9yHINmdW2S8jhrzxnlEhBzzW79aMms9ifCgg8
 cL7sLknErCdVsXz+zeekpV1eJSsc/xJmJwNCV32oFf7wO9hwEfr9QZ0WMuRPm0A3iHA6
 0X/NKvhXZyeJMgq8U46CdaYqa59MeuaOxikAcy8O0CXXJPm3rJWTsflRJwKiNcD3yxl8
 80zSm2bk6k0vaTNuYBRfO0voEZx+lrVQtIydYEYD5sA6Jluqa1ecNSAdflmheruhOzmZ
 2qaQ==
X-Gm-Message-State: AOJu0YwhI2D04PK3uqt/pSwsk6ETXAMl376Fc7pwvjoNNQ4oVq0C1RrY
 gp3/prIrh/0ntnyEKYPYCuxm070l8e7l/nVEPt26EgnpfpbIdWD/BNgG1II+hy1wDmOFvDFUAlq
 tXplqeMB8jMBe
X-Gm-Gg: ASbGncuxhf9MifTyEs0Rnlayf3X0l+ADN7QhHt9mCmmp8n3iR91LmlKInkA1eLD+vUS
 zFN9e71pEMwBU+6D57uQYkm6m3z/Kyaq1EaALm6x1za7GetMZrZPv+zVnxMjlmPzNucnW0YC0TK
 kHTcd3EpmgFnEQXmy0C5KWwwAfurgipKDaB/plAJ25Ofaqn70piNtVKJM/fYM26agpS/rv13CKm
 AMnCWrslHdoxx75Ok8nS1dv1AXPzEZ4RGegWOAE4wNEEP/I4bs9uT7nC0KdJkvPXylp1Yr3MNBT
 Vp3bDbE10izglzlvAXKvwSQz0LKAom41ofy/bJYGOfqvsJMfcxf1I0dzkThBTEkpX/QzbNkTB/W
 ZFRskGziBaQGob63kbn4D58H+BMqyDXP6IdCqYzg3gclKSjXTIHQtPUnNy5sB0KwZr3MBX8Txrt
 xJFAMVHK/ZCixskWGNhS9vB/Qh
X-Google-Smtp-Source: AGHT+IEDBovvG+vahWcTz/2c7xGgzoUV59ybKxtDVSMIspRsEbcgIic6oTnFsrqdECw6U82vWqmaUQ==
X-Received: by 2002:a05:600c:4ed4:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46fa9b13b04mr47445505e9.37.1760020287529; 
 Thu, 09 Oct 2025 07:31:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb484f5e3sm228785e9.18.2025.10.09.07.31.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] hw/hppa: Introduce HppaMachineState::boot_info::firmware
 structure
Date: Thu,  9 Oct 2025 16:31:04 +0200
Message-ID: <20251009143106.22724-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

Current code uses CPUHPPAState::@kernel_entry to hold either:
 - kernel entry virtual address
 - firmware interactive mode
and CPUHPPAState::@cmdline_or_bootorder to hold either:
 - kernel &cmdline physical address
 - firmware boot order

Besides, these variables don't belong to CPUHPPAState, they
depend on how the machine is started, and only apply to the
first CPU.

Introduce firmware specific fields in HppaMachineState, using
their correct type. Introduce the @is_kernel field, to allow
distinguishing between firmware or kernel mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a2996ef7682..138cd97efd9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -41,6 +41,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
 
 struct HppaMachineState {
     MachineState parent_obj;
+
+    struct {
+        bool is_kernel; /* kernel:1 firmware:0 */
+        union {
+            struct {
+                char bootorder;
+                bool interactive_mode;
+            } firmware;
+        };
+    } boot_info;
 };
 
 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
@@ -356,6 +366,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     const char *initrd_filename = machine->initrd_filename;
     const char *firmware = machine->firmware;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    HppaMachineState *hms = HPPA_COMMON_MACHINE(machine);
     DeviceState *dev;
     PCIDevice *pci_dev;
     char *firmware_filename;
@@ -481,6 +492,7 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
                       "-0x%08" PRIx64 ", entry at 0x%08" PRIx64
                       ", size %" PRIu64 " kB\n",
                       kernel_low, kernel_high, kernel_entry, size / KiB);
+        hms->boot_info.is_kernel = true;
 
         if (kernel_cmdline) {
             cpu[0]->env.cmdline_or_bootorder = 0x4000;
@@ -519,13 +531,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     }
 
-    if (!kernel_entry) {
+    if (!hms->boot_info.is_kernel) {
         /* When booting via firmware, tell firmware if we want interactive
-         * mode (kernel_entry=1), and to boot from CD (cmdline_or_bootorder='d')
-         * or hard disc (cmdline_or_bootorder='c').
+         * mode (interactive_mode=1), and to boot from CD (bootorder='d')
+         * or hard disc (bootorder='c').
          */
-        kernel_entry = machine->boot_config.has_menu ? machine->boot_config.menu : 0;
-        cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];
+        hms->boot_info.firmware.interactive_mode = machine->boot_config.has_menu
+                                                  ? machine->boot_config.menu
+                                                  : 0;
+        hms->boot_info.firmware.bootorder = machine->boot_config.order[0];
     }
 
     /* Keep initial kernel_entry for first boot */
@@ -648,6 +662,7 @@ static void machine_HP_C3700_init(MachineState *machine)
 static void hppa_machine_reset(MachineState *ms, ResetType type)
 {
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    HppaMachineState *hms = HPPA_COMMON_MACHINE(ms);
     unsigned int smp_cpus = ms->smp.cpus;
     int i;
 
@@ -668,8 +683,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     }
 
     cpu[0]->env.gr[26] = ms->ram_size;
-    cpu[0]->env.gr[25] = cpu[0]->env.kernel_entry;
-    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
+    cpu[0]->env.gr[25] = hms->boot_info.is_kernel
+                         ? cpu[0]->env.kernel_entry
+                         : hms->boot_info.firmware.interactive_mode;
+    cpu[0]->env.gr[24] = hms->boot_info.is_kernel
+                         ? cpu[0]->env.cmdline_or_bootorder
+                         : hms->boot_info.firmware.bootorder;
     cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
     cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
     cpu[0]->env.gr[21] = smp_cpus;
@@ -679,7 +698,8 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.kernel_entry = 0;
     cpu[0]->env.initrd_base = 0;
     cpu[0]->env.initrd_end = 0;
-    cpu[0]->env.cmdline_or_bootorder = mc->default_boot_order[0];
+    cpu[0]->env.cmdline_or_bootorder = 0;
+    hms->boot_info.firmware.bootorder = mc->default_boot_order[0];
 }
 
 static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.51.0


