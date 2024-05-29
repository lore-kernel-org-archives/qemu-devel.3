Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFC0C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBgz-0004Go-Ci; Wed, 29 May 2024 01:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgx-00043t-VB
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBgv-0005Wh-Iz
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-354be94c874so1331577f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959856; x=1717564656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP6fxsGZMQuY/R3P1rynlKMgDKQeym4TwOSFHOfHWmw=;
 b=hNhA/2UcXj2owBqyM9UlrcQrl2AXgsiSibVnw+E5MlNHz9t3LJZEG/mXzbmgAKBUMd
 c1NL1vWU0sPLMck4SZ1vxcsxuErxbXPTyjsUGSp4nxGdgvx9PLiLt7b7gNzAtu/NOgkC
 B4uS33IBNWF82JS3OgtB+5RLj/wJ4G43OPKTiEddu5SciNjHVSNGzBCP1ht3+rusJbf6
 FspfrqAk0RMI+UF10slccj9GIoeB3GAh/tOvr/6wc8Rv/guLLV69VcR3iueHl0fzOGUq
 5HmUckg6jnislvVThumSRHSY4/Y8RFNhNIhV1kZQ6U1iZuXCRSgI77CHHHI18ufIDgG8
 C1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959856; x=1717564656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iP6fxsGZMQuY/R3P1rynlKMgDKQeym4TwOSFHOfHWmw=;
 b=Kk17WcWT6BCb6KxCyC8S/TpUjClihOjonzc4pBE/v4uvQx/7IQlGbfB5AP/PefY7mP
 blJD7aJDqMsJfHCP3rOl20fOs4ChYUONOI/5Wd/I/sT/3qidv8snbQcdyCTPX+GGKZEj
 SXjk8NNEiCCODnrqzkWaeez/0ysayltyxcf7MHxR2VNGRqpElZMIGeLqcIvV2FYAT6Ze
 tLksWzdkJ0MjYcXz589CvE3xHnlg/vLgndj/iWyezHMyylI2xQ0HfTRxGNXCeS2SpwlU
 wm9FK6ulsLa68y2JAZopJyMoPFqNXImO2IT6Un3aoUl1il3M9wtIxXfwbS5VLYi0t1GR
 ya0Q==
X-Gm-Message-State: AOJu0Yw9w2QGazH1G02XsL7AYGa7CAviNJP+kfM0wgL8lEdJHE4Wcm8t
 mr4fZ5jeQCw720qZIg178jlPmulHPmoWmHL3DdxRnqpPu0dUoYwdsZcsp6wU2zulMRqDedRyYMF
 B
X-Google-Smtp-Source: AGHT+IHp7AEvzio9AoTUzxx9usWHXTl0IJhK6rgnk6S7Vc74KH/5MSsjGGlfLlkIiJH32S68uzlyqQ==
X-Received: by 2002:a5d:5983:0:b0:359:b737:51e4 with SMTP id
 ffacd0b85a97d-359b73753dcmr8667678f8f.2.1716959855694; 
 Tue, 28 May 2024 22:17:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089ae981sm166974185e9.32.2024.05.28.22.17.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 21/23] hw/i386/pc: Simplify DEFINE_I440FX_MACHINE() macro
Date: Wed, 29 May 2024 07:15:37 +0200
Message-ID: <20240529051539.71210-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 hw/i386/pc_piix.c | 62 ++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 217c749705..e7f51a5f2c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -452,13 +452,9 @@ static void pc_xen_hvm_init(MachineState *machine)
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
@@ -496,7 +492,7 @@ static void pc_i440fx_9_1_machine_options(MachineClass *m)
     m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
+DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
                       pc_i440fx_9_1_machine_options);
 
 static void pc_i440fx_9_0_machine_options(MachineClass *m)
@@ -512,7 +508,7 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pcmc->isa_bios_alias = false;
 }
 
-DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
+DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
                       pc_i440fx_9_0_machine_options);
 
 static void pc_i440fx_8_2_machine_options(MachineClass *m)
@@ -527,7 +523,7 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
+DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
                       pc_i440fx_8_2_machine_options);
 
 static void pc_i440fx_8_1_machine_options(MachineClass *m)
@@ -541,7 +537,7 @@ static void pc_i440fx_8_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
+DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
                       pc_i440fx_8_1_machine_options);
 
 static void pc_i440fx_8_0_machine_options(MachineClass *m)
@@ -556,7 +552,7 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
-DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0", NULL,
+DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
                       pc_i440fx_8_0_machine_options);
 
 static void pc_i440fx_7_2_machine_options(MachineClass *m)
@@ -566,7 +562,7 @@ static void pc_i440fx_7_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
+DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
                       pc_i440fx_7_2_machine_options);
 
 static void pc_i440fx_7_1_machine_options(MachineClass *m)
@@ -576,7 +572,7 @@ static void pc_i440fx_7_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1", NULL,
+DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
                       pc_i440fx_7_1_machine_options);
 
 static void pc_i440fx_7_0_machine_options(MachineClass *m)
@@ -588,7 +584,7 @@ static void pc_i440fx_7_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0", NULL,
+DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
                       pc_i440fx_7_0_machine_options);
 
 static void pc_i440fx_6_2_machine_options(MachineClass *m)
@@ -598,7 +594,7 @@ static void pc_i440fx_6_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2", NULL,
+DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
                       pc_i440fx_6_2_machine_options);
 
 static void pc_i440fx_6_1_machine_options(MachineClass *m)
@@ -609,7 +605,7 @@ static void pc_i440fx_6_1_machine_options(MachineClass *m)
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1", NULL,
+DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
                       pc_i440fx_6_1_machine_options);
 
 static void pc_i440fx_6_0_machine_options(MachineClass *m)
@@ -619,7 +615,7 @@ static void pc_i440fx_6_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0", NULL,
+DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
                       pc_i440fx_6_0_machine_options);
 
 static void pc_i440fx_5_2_machine_options(MachineClass *m)
@@ -629,7 +625,7 @@ static void pc_i440fx_5_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
+DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
                       pc_i440fx_5_2_machine_options);
 
 static void pc_i440fx_5_1_machine_options(MachineClass *m)
@@ -643,7 +639,7 @@ static void pc_i440fx_5_1_machine_options(MachineClass *m)
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
+DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
                       pc_i440fx_5_1_machine_options);
 
 static void pc_i440fx_5_0_machine_options(MachineClass *m)
@@ -655,7 +651,7 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
+DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
                       pc_i440fx_5_0_machine_options);
 
 static void pc_i440fx_4_2_machine_options(MachineClass *m)
@@ -665,7 +661,7 @@ static void pc_i440fx_4_2_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
+DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
                       pc_i440fx_4_2_machine_options);
 
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
@@ -675,7 +671,7 @@ static void pc_i440fx_4_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1", NULL,
+DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
                       pc_i440fx_4_1_machine_options);
 
 static void pc_i440fx_4_0_machine_options(MachineClass *m)
@@ -687,7 +683,7 @@ static void pc_i440fx_4_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
+DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
                       pc_i440fx_4_0_machine_options);
 
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
@@ -701,7 +697,7 @@ static void pc_i440fx_3_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
+DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
                       pc_i440fx_3_1_machine_options);
 
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
@@ -711,7 +707,7 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
+DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
                       pc_i440fx_3_0_machine_options);
 
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
@@ -722,7 +718,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
+DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
                       pc_i440fx_2_12_machine_options);
 
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
@@ -732,7 +728,7 @@ static void pc_i440fx_2_11_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
                       pc_i440fx_2_11_machine_options);
 
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
@@ -743,7 +739,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
+DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
                       pc_i440fx_2_10_machine_options);
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
@@ -753,7 +749,7 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
+DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
                       pc_i440fx_2_9_machine_options);
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
@@ -763,7 +759,7 @@ static void pc_i440fx_2_8_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
+DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
                       pc_i440fx_2_8_machine_options);
 
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
@@ -773,7 +769,7 @@ static void pc_i440fx_2_7_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
+DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
                       pc_i440fx_2_7_machine_options);
 
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
@@ -788,7 +784,7 @@ static void pc_i440fx_2_6_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
+DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
                       pc_i440fx_2_6_machine_options);
 
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
@@ -802,7 +798,7 @@ static void pc_i440fx_2_5_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
+DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
                       pc_i440fx_2_5_machine_options);
 
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
@@ -816,7 +812,7 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
+DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
                       pc_i440fx_2_4_machine_options)
 
 #ifdef CONFIG_ISAPC
-- 
2.41.0


