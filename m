Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A3CCD18D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgM-0002Os-Va; Thu, 09 Oct 2025 10:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rg5-0002KC-79
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:35 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rfy-00031A-N3
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso967959f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020283; x=1760625083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwFIDtFtxNXLSEqUSWVPJnSjwK+TsqhfUr7EN1Jw144=;
 b=r+bZ2aJZuQEo1wswF92qM0/QSVdgl/bcz6qTacRxTORz0HOG8a5xf4BIJfY5dZBvg1
 alBmT0HfAV2T05/c/8mkiu5+hoTRi5IDq9NhF1ONN9s7dLsUjw5LkNLQmbbJFHeVoXbH
 jL0Mmbesh33ddsCJz5Qo66fkRX9DBcCWsBhb0zEhxuKYY+TE1igcL4KqPMGMIc6gdWH2
 fBGc1xycsy/GevO/wEEmolszOP//kr2laQkf1RvaQA5YVivQjCBu+cdQk06eUX0tp1L7
 Ja2u+hkxOIj1N3v0EwZQ4GkCILNnRn0ZssY9tCSLYxya9/18qWqz0o3bf/VikBRBpOwS
 s0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020283; x=1760625083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwFIDtFtxNXLSEqUSWVPJnSjwK+TsqhfUr7EN1Jw144=;
 b=r+HmgncCwTW38cQ3w0h06K9ntpfJ1obwg3PO3IQPbtZz3yAgEwSAdeRUIZInpsDm1z
 xzKsuallAwUVBcz53hDXtpeVgOzlfjqtUtLR0s3quI/Obr83DxNg4lYyDXW/741iJZgU
 ApOikMOCf4PcnPbnjPNki5Y4KOHq6UiGXJl7Cz+YeWWi7YFRYGGgzFvcWq7o7C4o0TdW
 /cMNmXfehIB4XtHsx2qRkkl/RZI78Kkt1bHLqVcbl9Y9ERW1QrJifWh+bA7EstoluKSI
 80axTrhs8XfoIa3cel6S0KAwaqbYN9/3aNNR4m4ekqyTix9U9EtVBbNjE/MAkGNEU5Sl
 6mRA==
X-Gm-Message-State: AOJu0YxaHmRW7uPUtPuGjbZj4/qQ94ulHN+6HouxyzhVNta6v/D8yfpk
 UXeWc//9NU679pQzFkNFiil9/K3zZMVgEixkFDv44gamhmnViJ+8vDk2qRU1bMyFTihLGqndBHf
 r9vDMKpU8VQ==
X-Gm-Gg: ASbGnctMvASBfJRWu3Rnzp3/+Mu2qGlLUZFsdEZBdIU0+fzD8mPTSuxsGDGITUdSyHK
 2jjvFsOIw7+mYLJRQV1MAus9a7iEaf0tcd1iB4C3UdbkI2LbXxCIjpEmyoejClonv7uYKW4lVo3
 eyYDJ4/78zjB6fEdLTU8QtHWDTvSIzr4/sgDiwfu38QHRXu0kcKHxnc/NGQE1cQIHZ5rD0l9DNd
 89kThXtO53OGIO8KwnJ1A9jRvUClHjrSWgTCBnL5wGZBvXDXOH0sWnvZ0qfnRGFdRVYrG0k/tCc
 YOlaATCE4u2uLbYRp+64/AVStekj3hgcqJ3qTWYEanaULIKsPPeptIsi3yDLtIfmHKnhN355vP+
 +xOEM0XzYyqMC7PYlNJ8Na8zTEAImtaEZ1MTqqt8V/NPeIjNftgBeMcz5y0w9Y2rs0uQWN3Tt3l
 YPiTAPuQwL1ZYUPHLYyyOpKUbA
X-Google-Smtp-Source: AGHT+IEO+VWavkgmGAbv6sBVzruWugFyJP0Esd9/LubTi2bH5V4gPC8QtmNio8t+96bL2nzHFumxiA==
X-Received: by 2002:a05:6000:24ca:b0:40b:c42e:fe39 with SMTP id
 ffacd0b85a97d-4266e8d8c7bmr5259785f8f.40.1760020282526; 
 Thu, 09 Oct 2025 07:31:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm35107042f8f.6.2025.10.09.07.31.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
Date: Thu,  9 Oct 2025 16:31:03 +0200
Message-ID: <20251009143106.22724-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

B160L and C3700 share a lot of common code. Factor it out
as an abstract HPPA_COMMON_MACHINE QOM parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index bbee70022f1..a2996ef7682 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -36,6 +36,13 @@
 #include "net/net.h"
 #include "qemu/log.h"
 
+#define TYPE_HPPA_COMMON_MACHINE  MACHINE_TYPE_NAME("hppa-common")
+OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
+
+struct HppaMachineState {
+    MachineState parent_obj;
+};
+
 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
@@ -684,6 +691,22 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
+
+    mc->reset = hppa_machine_reset;
+    mc->block_default_type = IF_SCSI;
+    mc->default_cpus = 1;
+    mc->max_cpus = HPPA_MAX_CPUS;
+    mc->default_boot_order = "cd";
+    mc->default_ram_id = "ram";
+    mc->default_nic = "tulip";
+
+    nc->nmi_monitor_handler = hppa_nmi;
+}
+
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -691,23 +714,13 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
-    NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP B160L workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_B160L_init;
-    mc->reset = hppa_machine_reset;
-    mc->block_default_type = IF_SCSI;
-    mc->max_cpus = HPPA_MAX_CPUS;
-    mc->default_cpus = 1;
     mc->is_default = true;
     mc->default_ram_size = 512 * MiB;
-    mc->default_boot_order = "cd";
-    mc->default_ram_id = "ram";
-    mc->default_nic = "tulip";
-
-    nc->nmi_monitor_handler = hppa_nmi;
 }
 
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
@@ -717,42 +730,34 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
-    NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
     mc->default_cpu_type = TYPE_HPPA64_CPU;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_C3700_init;
-    mc->reset = hppa_machine_reset;
-    mc->block_default_type = IF_SCSI;
     mc->max_cpus = HPPA_MAX_CPUS;
-    mc->default_cpus = 1;
-    mc->is_default = false;
     mc->default_ram_size = 1024 * MiB;
-    mc->default_boot_order = "cd";
-    mc->default_ram_id = "ram";
-    mc->default_nic = "tulip";
-
-    nc->nmi_monitor_handler = hppa_nmi;
 }
 
 static const TypeInfo hppa_machine_types[] = {
     {
-        .name = MACHINE_TYPE_NAME("B160L"),
-        .parent = TYPE_MACHINE,
-        .class_init = HP_B160L_machine_init_class_init,
+        .name           = TYPE_HPPA_COMMON_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(HppaMachineState),
+        .class_init     = hppa_machine_common_class_init,
+        .abstract       = true,
         .interfaces = (const InterfaceInfo[]) {
             { TYPE_NMI },
             { }
         },
+    }, {
+        .name = MACHINE_TYPE_NAME("B160L"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_B160L_machine_init_class_init,
     }, {
         .name = MACHINE_TYPE_NAME("C3700"),
-        .parent = TYPE_MACHINE,
+        .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
-        .interfaces = (const InterfaceInfo[]) {
-            { TYPE_NMI },
-            { }
-        },
     },
 };
 
-- 
2.51.0


