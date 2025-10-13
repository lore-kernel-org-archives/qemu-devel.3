Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6691BCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4Z-0007Wu-6K; Mon, 13 Oct 2025 15:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4X-0007K6-7d
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4U-0001uJ-Pi
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:19:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso2784166f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383140; x=1760987940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z3OmPpMLr5a1yvZb58CoYa8yVy1NYMyFvJnwaus/3Ok=;
 b=kYB2UAa9Ab13jkeGKUF/Shwsb5kDZ3NVxPndqdLQeClnLLBkHmOdCx6jrAG/iffAp6
 KdCiB3goD4tDRu/zsfZtOliPuZlV+km4qeEQeyGj5eKevpU4LX7g/b+el3fq7rGAuE/r
 UZe9+F1NzRNVpqrMT7puHwZlLd0CcU5xXZsyLKIAEojBvkKm5c3caSKJMObmTe9asD6h
 ti62QcX1B+UGdnNefHkCdJG1c/cMENvknOfSf46GyrnZBLsWEXZChAXoc1WTbVZdB6kl
 Gekm30zWGZiQZEChDSsUhg8JuMf5+idBpUBoiDtrRC+WAybpDfNXZZeNPC9MM4m0kVtp
 Mjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383140; x=1760987940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3OmPpMLr5a1yvZb58CoYa8yVy1NYMyFvJnwaus/3Ok=;
 b=T5Ms+08jEfNcKgtinsalzJ854mMlrNyJFlMX+xfAPcUb+wpnU/EH4B1DPtHnDXCd8y
 lvalBS6d9Ao8eqHsiASpjvw3CfdM2NL1MZukdIZguERu5BVKJ7cpK7BygIunFu5YOGVL
 8Q1WW7HOrlYVM0TC5o2N7NznOgldVUHj33pmA6BhVbuVy7ljtfTefDW9IYrl1SetgxHN
 SCq19nBqC3juU92LOVxsuJFMNnjWS6LAOnFI539UDasP6UGQAGL2OyvTvWYwQqmYZvKl
 ShG9A7hbK93i5H17yUWOqrMz6AkrvXfh/9W4x2doOTMEL2uieZaivZdya5zd3QIbnfJ+
 eJyQ==
X-Gm-Message-State: AOJu0Yzq4QKVScnADvwHR2ZV5BBY7c46BdjEactlmmUkWjYB4XwApVy8
 x3dHS1e5IPagCq1LuQExlKrY06qAptYwtmB4FiaGQ9HlxMCtbCBmMSnNYx8VLW6AlKao035G+cZ
 QQhd8cnxu4A==
X-Gm-Gg: ASbGncsRZymElWDqZ+YDswyCgCg99pKuKv5IaQoS+vdzHBhVcSqCMOOkbOapGWamC+e
 YLqB6mSSos9TE5d5PV43S2OzAlHTcoS4YQ2f7SE/MuG0tGgN/flW485ej4fSbhDg5eMCrAqM2c/
 l+M+7H0b0i5BQj2/I7uiz4deXg9C5ag6dZcvTO0HZBLlDAVt3TYKx0atTS0CdEKTl+UJBWj3BUo
 sw1gOkGgSjv+ngJM4JYY76efCFSWvkXzjNABelNDcT3nqczCf4R/MamsxRP5IfG31GpBE/GXbDp
 vQfR5qq4D2YtdQl4noqqyZfbH8pwMcgIaZ8bIezSSQWkh8+QyWRqBnh6ZDTLe8+o+2g3+xWqGpZ
 OY4jhX367hHxSKFXAIvqqjXSoGQye6bwIaLfxj/+yJ33I06t/APY2EwXeh0KcjkfikWubPSDeDM
 YYvfRcw8lNJtQVo/5DnfU=
X-Google-Smtp-Source: AGHT+IHAxGuD9lYVfM5Ei4GyR/TO2HxvXtPOe/VG9qVDgyQm5Wd4eLiE+VUH3kwBdHnm/GOZVstxFA==
X-Received: by 2002:a05:6000:230e:b0:3ea:5f76:3f7a with SMTP id
 ffacd0b85a97d-4266e7d6b9bmr14846273f8f.22.1760383140477; 
 Mon, 13 Oct 2025 12:19:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583424sm19444347f8f.21.2025.10.13.12.18.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:19:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
Date: Mon, 13 Oct 2025 21:18:06 +0200
Message-ID: <20251013191807.84550-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009143106.22724-4-philmd@linaro.org>
---
 hw/hppa/machine.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2ab5fcb471a..c8da159a114 100644
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
@@ -683,6 +690,22 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
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
@@ -690,23 +713,13 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
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
@@ -716,42 +729,34 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
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


