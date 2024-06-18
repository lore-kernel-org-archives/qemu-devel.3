Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63198C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbIV-0006oY-RN; Tue, 18 Jun 2024 12:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbII-00069J-BB
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbIG-00071H-5D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:02:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6f7b785a01so344951866b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726566; x=1719331366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGkKAdLR9B1vxvYwpNEkYfLUZGJGkx4Kl51VrhM57lY=;
 b=qC6sy+K7Max8cSiYf9miFGsxEGcneBUZ2rSnb7ja+dlSNTjLwjISrbuGXfkhlqK99V
 cLjXXGwWAe0NrwxK5dmfcwSkpYmJTe2rCrzTYrH1fBRvbJ/atqLZxhv1RZZZPyjufIZi
 xM1Iy0Rq2Sy4hmOlKGL7ne8zXNajmAyIw5HVmNS/9UCcJngAGM+bQsOeubp40OWi3GIL
 E5vDcgiAdmMtB91H7aizDfwNRaT8vP2CenkwhpsZMtXo+IyQjWgiei0ldG4tmHhXi1VV
 GfkzhKOZRnWGnp+pYSY4fC2BOxNIW7airgUjAx6teK34Fp7zQSNyIHLCuHtgk8K5KKvG
 BdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726566; x=1719331366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGkKAdLR9B1vxvYwpNEkYfLUZGJGkx4Kl51VrhM57lY=;
 b=QRQYerBbc/I/9QPAROO9tp0fYkE9DtS/1L9S+Vl2E61UGU8gG6H8KDgxGFNiEdg9Au
 3hq3IF/x+NpWusl8kQbJ+eVrAAmWMTK8NOwUy70SNASCV+l0NUeIAhuedPCcS+KI5tuB
 R2M6cQgMw6ThfKeohX+MJl5S23cPKIqLxMWQzMmZ7l1HjlhublNJcPdiLd7VV9+nZ8Vd
 E2ynzPyVXaHyTY+KtcWiG1ZlWXm4rVfNVGcqTdo0eR48i+sthEVb5G72SF014aANnU3A
 FF70zMuLpZsp9RBJ12v2PatQmlG7B4uBUe4w5fCSPxBetRwj27iACVlT7VfenBgrAH/A
 Tq+Q==
X-Gm-Message-State: AOJu0YwGVBybg8cs3pES2IDLCM7Yh8vLWrPex57ok7ptJQRE5E1SBMJb
 7SGN5cVuKQEhRRg8ghteou/PYVSFRJ0YJB0amhwI0tdFrBMJitsVeRNQmpOrxtapNDQLeoDYoC+
 l
X-Google-Smtp-Source: AGHT+IGOtCeqlqabrag0Up1ymLrxDhKpjrQQpb90ZyPjHMkb/ShmfqOdjopGjhdNcROptmg+2le3cA==
X-Received: by 2002:a17:906:3ec4:b0:a6e:a97c:fc93 with SMTP id
 a640c23a62f3a-a6f60cefd2fmr773735366b.16.1718726566481; 
 Tue, 18 Jun 2024 09:02:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa67ecsm621310566b.215.2024.06.18.09.02.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:02:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 21/76] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
Date: Tue, 18 Jun 2024 17:59:43 +0200
Message-ID: <20240618160039.36108-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Last commit removed the last non-NULL use of DEFINE_I440FX_MACHINE
3rd parameter. 'compatfn' is now obsolete, remove it.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240617071118.60464-22-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 69 ++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 40 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 217c749705..e4930b7f48 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -414,13 +414,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-/* Looking for a pc_compat_2_4() function? It doesn't exist.
- * pc_compat_*() functions that run on machine-init time and
- * change global QEMU state are deprecated. Please don't create
- * one, and implement any pc-*-2.4 (and newer) compat code in
- * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
- */
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -452,13 +445,9 @@ static void pc_xen_hvm_init(MachineState *machine)
 }
 #endif
 
-#define DEFINE_I440FX_MACHINE(suffix, name, compatfn, optionfn) \
+#define DEFINE_I440FX_MACHINE(suffix, name, optionfn) \
     static void pc_init_##suffix(MachineState *machine) \
     { \
-        void (*compat)(MachineState *m) = (compatfn); \
-        if (compat) { \
-            compat(machine); \
-        } \
         pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
     } \
     DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
@@ -496,7 +485,7 @@ static void pc_i440fx_9_1_machine_options(MachineClass *m)
     m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
+DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
                       pc_i440fx_9_1_machine_options);
 
 static void pc_i440fx_9_0_machine_options(MachineClass *m)
@@ -512,7 +501,7 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pcmc->isa_bios_alias = false;
 }
 
-DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
+DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
                       pc_i440fx_9_0_machine_options);
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
@@ -527,7 +516,7 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
+DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
                       pc_i440fx_8_2_machine_options);
 
 static void pc_i440fx_8_1_machine_options(MachineClass *m)
@@ -541,7 +530,7 @@ static void pc_i440fx_8_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
+DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
                       pc_i440fx_8_1_machine_options);
 
 static void pc_i440fx_8_0_machine_options(MachineClass *m)
@@ -556,7 +545,7 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
-DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
+DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
                       pc_i440fx_8_0_machine_options);
 
 static void pc_i440fx_7_2_machine_options(MachineClass *m)
@@ -566,7 +555,7 @@ static void pc_i440fx_7_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
+DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
                       pc_i440fx_7_2_machine_options);
 
 static void pc_i440fx_7_1_machine_options(MachineClass *m)
@@ -576,7 +565,7 @@ static void pc_i440fx_7_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1", NULL,
+DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
                       pc_i440fx_7_1_machine_options);
 
 static void pc_i440fx_7_0_machine_options(MachineClass *m)
@@ -588,7 +577,7 @@ static void pc_i440fx_7_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0", NULL,
+DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
                       pc_i440fx_7_0_machine_options);
 
 static void pc_i440fx_6_2_machine_options(MachineClass *m)
@@ -598,7 +587,7 @@ static void pc_i440fx_6_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2", NULL,
+DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
                       pc_i440fx_6_2_machine_options);
 
 static void pc_i440fx_6_1_machine_options(MachineClass *m)
@@ -609,7 +598,7 @@ static void pc_i440fx_6_1_machine_options(MachineClass *m)
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1", NULL,
+DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
                       pc_i440fx_6_1_machine_options);
 
 static void pc_i440fx_6_0_machine_options(MachineClass *m)
@@ -619,7 +608,7 @@ static void pc_i440fx_6_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0", NULL,
+DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
                       pc_i440fx_6_0_machine_options);
 
 static void pc_i440fx_5_2_machine_options(MachineClass *m)
@@ -629,7 +618,7 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
+DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
                       pc_i440fx_5_2_machine_options);
 
 static void pc_i440fx_5_1_machine_options(MachineClass *m)
@@ -643,7 +632,7 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
+DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
                       pc_i440fx_5_1_machine_options);
 
 static void pc_i440fx_5_0_machine_options(MachineClass *m)
@@ -655,7 +644,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
+DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
                       pc_i440fx_5_0_machine_options);
 
 static void pc_i440fx_4_2_machine_options(MachineClass *m)
@@ -665,7 +654,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
+DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
                       pc_i440fx_4_2_machine_options);
 
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
@@ -675,7 +664,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
                       pc_i440fx_4_1_machine_options);
 
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
@@ -687,7 +676,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
+DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
                       pc_i440fx_4_0_machine_options);
 
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
@@ -701,7 +690,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
+DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
                       pc_i440fx_3_1_machine_options);
 
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
@@ -711,7 +700,7 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
+DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
                       pc_i440fx_3_0_machine_options);
 
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
@@ -722,7 +711,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
+DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
                       pc_i440fx_2_12_machine_options);
 
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
@@ -732,7 +721,7 @@ static void pc_i440fx_2_11_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
                       pc_i440fx_2_11_machine_options);
 
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
@@ -743,7 +732,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
+DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
                       pc_i440fx_2_10_machine_options);
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
@@ -753,7 +742,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
+DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
                       pc_i440fx_2_9_machine_options);
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
@@ -763,7 +752,7 @@ static void pc_i440fx_2_8_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
+DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
                       pc_i440fx_2_8_machine_options);
 
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
@@ -773,7 +762,7 @@ static void pc_i440fx_2_7_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
+DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
                       pc_i440fx_2_7_machine_options);
 
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
@@ -788,7 +777,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
+DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
                       pc_i440fx_2_6_machine_options);
 
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
@@ -802,7 +791,7 @@ static void pc_i440fx_2_5_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
+DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
                       pc_i440fx_2_5_machine_options);
 
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
@@ -816,7 +805,7 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
+DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
                       pc_i440fx_2_4_machine_options)
 
 #ifdef CONFIG_ISAPC
-- 
2.41.0


