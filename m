Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AF4C282E5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqrm-00018L-Ka; Wed, 05 Mar 2025 10:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqrc-0000qe-2E
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:52 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqra-0002cu-3T
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so6925465e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189248; x=1741794048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vtQIxIHxpXveYUhgNWWXCgOpU/U9ptA2e3UaY3frqU=;
 b=Ev19cYtPzA4UrckDtxwZJjqeKKN95r12kjAydAWAdn9FidWY2fK9Jln7WzibXFEgts
 ylK/vfovFDFu/V/foL7KFSoOX3BrgoRpZfNhhyHegRjOohCBb7PHypgCAr5buuEMYZFZ
 rNUusQudXXIFjcpRMTcdReaBN53F9kt/P1MBfm8IlMKW1cva17g5yaSfH9TwcAockSRA
 I3womS+vttfK/G08TkeaRHi8/a+GsMaZptrI63y3cKluBKNblVQ75JpfGyRIJhAAfeEu
 ZgKX2BAihtqMcGxtkaf6DcHMw8e+8Cj77QsokAGpmaPOpVV1wFUlhChRBvdfncioI274
 caWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189248; x=1741794048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vtQIxIHxpXveYUhgNWWXCgOpU/U9ptA2e3UaY3frqU=;
 b=EVyCkdNxwJY8C6xDXLanxs7WuMJUeOjDhWB93H2PHOQJR0wig7zsCEL001rEWIoNoR
 E7tGc7qKFVFmQjkU5Gl7LnvFJFyxnOaANPeRctwPSMphEqeXJkAHy31ptnX5Yoz6h7vL
 6eS13hrEb5+JSa6o6YKEmDr1Ba1dDhf7zt4YrMbLCD2RgcAv8sjqGvWdpQ/eKDpHAP/t
 zDME+Ph8U2p5NzoE9UFaLCML3d8+zdM4y627WBb3JWd5YTKajWED4/Di2M8M51kgb0Nq
 lWzDtoJ7iSpt8bZs5ZgpHSfiJKZMPGURW74A1Lsuh2/6HwxSwtwzCcjZ8+xf8t4RSU0H
 oGcg==
X-Gm-Message-State: AOJu0YzGOLe68J85HnRN2GPUllSqR2efY3W9QVKxbaPpHWu/gEcPC/nH
 LbZf05ekNaxc8usWrSTU6LKRQ1WD/WFdS63+jo6Dva6PxbLOuAyupnsB5ncu5S6g+XdbyOzpXCU
 r9Hg=
X-Gm-Gg: ASbGncuVRjf8mfZehSv1BS8C7BzN6SU1U30EVpdVP7kbS6j9Q/etxuxD9gtls9QKyi+
 I5EUknHqkKTP2P4EzchSiQLnbka+yUFnmlTRVO9tkV42+aMPHLX4hhXRHVVYOIXSBCpxndlxnON
 UvK7DqH7upnB/Uy0IB59uClK7BP9f4FzqUYhv8PuTbQZDWnq09bJTidKvpSLJZrT8ZZgRKp7myK
 zlCdiHT19675oXKbxVExtIKxJ/rbKimZEBTOixYg/3b1zNkEkbCgq4bcnATIDOtQSK+pyecwKX4
 Ct8ncIN+qoAZVHkLFrNU3OYoVqqU5fq7exAbiHZM4AhNNL45UiKxFntenZ5eFimxjrQPIdVnbFF
 Gu6dSa342jdYTLKmGT2k=
X-Google-Smtp-Source: AGHT+IGNuYMnXF6rBDXaLT19GqJ/gNbsa16vAYpnR8cczTS6BrISULUSR6Buy3vVTyHNK+Bwa7jrLw==
X-Received: by 2002:a05:600c:470e:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-43bd20ba1c7mr28944025e9.8.1741189248150; 
 Wed, 05 Mar 2025 07:40:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd6530fd6sm14836865e9.6.2025.03.05.07.40.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 16/18] hw/microblaze/petalogix_s3adsp1800_mmu: Use
 legacy_binary_is_big_endian
Date: Wed,  5 Mar 2025 16:39:26 +0100
Message-ID: <20250305153929.43687-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

For legacy binaries, legacy_binary_is_big_endian() is equivalent
of the compile time TARGET_BIG_ENDIAN definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index bdba2006b72..12d4d6c336f 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -71,13 +72,12 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
-                                              : ENDIAN_MODE_LITTLE;
+    EndianMode endianness = legacy_binary_endianness();
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     object_property_set_bool(OBJECT(cpu), "little-endian",
-                             !TARGET_BIG_ENDIAN, &error_abort);
+                             endianness == ENDIAN_MODE_LITTLE, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
@@ -135,7 +135,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
-    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
+    microblaze_load_kernel(cpu, endianness == ENDIAN_MODE_LITTLE,
+                           ddr_base, ram_size,
                            machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
@@ -145,7 +146,9 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
+    mc->desc = legacy_binary_endianness() == ENDIAN_MODE_LITTLE
+        ? "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (little endian)"
+        : "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800 (big endian)";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
 }
-- 
2.47.1


