Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D2BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeY-0007KW-M8; Tue, 02 Jul 2024 01:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeW-0007Jo-A1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeT-00078n-9y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso28815495e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896518; x=1720501318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iURupPRr5TrxEeyHkNHup/uc7tKrykkuVBAlwFQDkQ=;
 b=bFjC0vNwJKXkPYnZFSSHBL8uhHQ51LSHo5W80N6HftYA+494Q8zhyXNetVaSl7v35x
 U++6Tc0kSnxU+qsE13r0F4NUq7hd+hm+d8rjcz6C6GPpvXRcrn3m/vKZj2PU0pmO6Kc2
 LXe5EBFpBnJN0IaaMScKe3V8LWX6obPMzNfumtpT4dRQ4braY2WJoyKYW38c2ZcbFr6A
 u8n51HWnmfIGQ7qHlUegK2XGEDRII8agtULGWOb3Pov8PcdzmrvqtAGc2MhfQP73hNGf
 Ic0cwa64lUkUMDfqTbE06uwrUuVx60Wp6+HSuj9lDY4NFbXKlZIL6i6FHJFU87brBc0c
 PHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896518; x=1720501318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iURupPRr5TrxEeyHkNHup/uc7tKrykkuVBAlwFQDkQ=;
 b=Ws80oTaD6p+238eb7zSVJS8yroOJ+G7gY0saSu01iHar2fF7eQoqqK7u9hr3ci7dYN
 HEw6syAWVzJGP2j13UgFnLh0rkrzxd8bzGMRhKTrWV/b6+3+E1e4Hr2JIUn74cAb0eAy
 mBE8gZ1jNN1Q8RNh4uo+uRoyMtBMeqeYk4XAmfgnKsp/3w2WrROz5TTDEYBfROMDi2UK
 ssXYqAN8ZQlHmLFv3z3mPZ6j0fkciHj/cTst10xfmOkzA/5LRnRqkuPWX/6q8fvt3KzJ
 5TFTWtCb1s6fSIz3Yc8KYI1qtNs2JKHx5VwXGmmbVTocM+29xo1cDnj8DUA8ojeUMlod
 Ja1A==
X-Gm-Message-State: AOJu0YwCImKFIrjNST0q5r3bfc7Ms2Xbk4OEcnxo1slULJ0v21yjEXhC
 2K9nEJtpH2AJjZX8OgS+5J/pnJbndLy9x9Cg17lIvc7IUk9AlI0BCuy6trD1JXPYOHym8CpQehT
 M
X-Google-Smtp-Source: AGHT+IGDDZRMkaA2BAFFOdMTGfZStr9188/UPamxQjm3jCtAIDZZjop1vd9cYkKCwxon18t/RxN72w==
X-Received: by 2002:a05:600c:19cb:b0:425:6a12:bbe6 with SMTP id
 5b1f17b1804b1-42579fef0fcmr62364975e9.0.1719896518474; 
 Mon, 01 Jul 2024 22:01:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c1018sm179151135e9.40.2024.07.01.22.01.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/22] hw/i386: convert 'i440fx' machine definitions to use new
 macros
Date: Tue,  2 Jul 2024 07:00:57 +0200
Message-ID: <20240702050112.35907-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

This changes the DEFINE_I440FX_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number thrice in three different formats in the calls
to DEFINE_I440FX_MACHINE.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-7-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  26 +++++
 hw/i386/pc_piix.c    | 219 +++++++++++++++++++------------------------
 2 files changed, 122 insertions(+), 123 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 46bc411063..027c6f29f7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -317,4 +317,30 @@ extern const size_t pc_compat_2_3_len;
     } \
     type_init(pc_machine_init_##suffix)
 
+#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, ...) \
+    static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
+        MachineState *machine) \
+    { \
+        initfn(machine); \
+    } \
+    static void MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
+        mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
+    } \
+    static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
+    { \
+        .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
+        .parent     = TYPE_PC_MACHINE, \
+        .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+    }; \
+    static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
+    { \
+        type_register(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
+    } \
+    type_init(MACHINE_VER_SYM(register, namesym, __VA_ARGS__));
+
 #endif
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e4930b7f48..5705d6e155 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,12 +445,13 @@ static void pc_xen_hvm_init(MachineState *machine)
 }
 #endif
 
-#define DEFINE_I440FX_MACHINE(suffix, name, optionfn) \
-    static void pc_init_##suffix(MachineState *machine) \
-    { \
-        pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
-    } \
-    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
+static void pc_i440fx_init(MachineState *machine)
+{
+    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
+}
+
+#define DEFINE_I440FX_MACHINE(major, minor) \
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, major, minor);
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
@@ -478,21 +479,20 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_9_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_9_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
-                      pc_i440fx_9_1_machine_options);
+DEFINE_I440FX_MACHINE(9, 1);
 
-static void pc_i440fx_9_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_9_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_9_1_machine_options(m);
+    pc_i440fx_machine_9_1_options(m);
     m->alias = NULL;
     m->is_default = false;
 
@@ -501,14 +501,13 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pcmc->isa_bios_alias = false;
 }
 
-DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
-                      pc_i440fx_9_0_machine_options);
+DEFINE_I440FX_MACHINE(9, 0);
 
-static void pc_i440fx_8_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_2_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_9_0_machine_options(m);
+    pc_i440fx_machine_9_0_options(m);
 
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
@@ -516,28 +515,26 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
-                      pc_i440fx_8_2_machine_options);
+DEFINE_I440FX_MACHINE(8, 2);
 
-static void pc_i440fx_8_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_8_2_machine_options(m);
+    pc_i440fx_machine_8_2_options(m);
     pcmc->broken_32bit_mem_addr_check = true;
 
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
-                      pc_i440fx_8_1_machine_options);
+DEFINE_I440FX_MACHINE(8, 1);
 
-static void pc_i440fx_8_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_8_1_machine_options(m);
+    pc_i440fx_machine_8_1_options(m);
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
 
@@ -545,268 +542,244 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
-DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
-                      pc_i440fx_8_0_machine_options);
+DEFINE_I440FX_MACHINE(8, 0);
 
-static void pc_i440fx_7_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_2_options(MachineClass *m)
 {
-    pc_i440fx_8_0_machine_options(m);
+    pc_i440fx_machine_8_0_options(m);
     compat_props_add(m->compat_props, hw_compat_7_2, hw_compat_7_2_len);
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
-                      pc_i440fx_7_2_machine_options);
+DEFINE_I440FX_MACHINE(7, 2)
 
-static void pc_i440fx_7_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_1_options(MachineClass *m)
 {
-    pc_i440fx_7_2_machine_options(m);
+    pc_i440fx_machine_7_2_options(m);
     compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
-                      pc_i440fx_7_1_machine_options);
+DEFINE_I440FX_MACHINE(7, 1);
 
-static void pc_i440fx_7_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_i440fx_7_1_machine_options(m);
+    pc_i440fx_machine_7_1_options(m);
     pcmc->enforce_amd_1tb_hole = false;
     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
-                      pc_i440fx_7_0_machine_options);
+DEFINE_I440FX_MACHINE(7, 0);
 
-static void pc_i440fx_6_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_2_options(MachineClass *m)
 {
-    pc_i440fx_7_0_machine_options(m);
+    pc_i440fx_machine_7_0_options(m);
     compat_props_add(m->compat_props, hw_compat_6_2, hw_compat_6_2_len);
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
-                      pc_i440fx_6_2_machine_options);
+DEFINE_I440FX_MACHINE(6, 2);
 
-static void pc_i440fx_6_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_1_options(MachineClass *m)
 {
-    pc_i440fx_6_2_machine_options(m);
+    pc_i440fx_machine_6_2_options(m);
     compat_props_add(m->compat_props, hw_compat_6_1, hw_compat_6_1_len);
     compat_props_add(m->compat_props, pc_compat_6_1, pc_compat_6_1_len);
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
-                      pc_i440fx_6_1_machine_options);
+DEFINE_I440FX_MACHINE(6, 1);
 
-static void pc_i440fx_6_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_0_options(MachineClass *m)
 {
-    pc_i440fx_6_1_machine_options(m);
+    pc_i440fx_machine_6_1_options(m);
     compat_props_add(m->compat_props, hw_compat_6_0, hw_compat_6_0_len);
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
-                      pc_i440fx_6_0_machine_options);
+DEFINE_I440FX_MACHINE(6, 0);
 
-static void pc_i440fx_5_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_2_options(MachineClass *m)
 {
-    pc_i440fx_6_0_machine_options(m);
+    pc_i440fx_machine_6_0_options(m);
     compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
-                      pc_i440fx_5_2_machine_options);
+DEFINE_I440FX_MACHINE(5, 2);
 
-static void pc_i440fx_5_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_5_2_machine_options(m);
+    pc_i440fx_machine_5_2_options(m);
     compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
     compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
     pcmc->kvmclock_create_always = false;
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
-                      pc_i440fx_5_1_machine_options);
+DEFINE_I440FX_MACHINE(5, 1);
 
-static void pc_i440fx_5_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_0_options(MachineClass *m)
 {
-    pc_i440fx_5_1_machine_options(m);
+    pc_i440fx_machine_5_1_options(m);
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
-                      pc_i440fx_5_0_machine_options);
+DEFINE_I440FX_MACHINE(5, 0);
 
-static void pc_i440fx_4_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_2_options(MachineClass *m)
 {
-    pc_i440fx_5_0_machine_options(m);
+    pc_i440fx_machine_5_0_options(m);
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
-                      pc_i440fx_4_2_machine_options);
+DEFINE_I440FX_MACHINE(4, 2);
 
-static void pc_i440fx_4_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_1_options(MachineClass *m)
 {
-    pc_i440fx_4_2_machine_options(m);
+    pc_i440fx_machine_4_2_options(m);
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
-                      pc_i440fx_4_1_machine_options);
+DEFINE_I440FX_MACHINE(4, 1);
 
-static void pc_i440fx_4_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_i440fx_4_1_machine_options(m);
+    pc_i440fx_machine_4_1_options(m);
     pcmc->default_cpu_version = CPU_VERSION_LEGACY;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
-                      pc_i440fx_4_0_machine_options);
+DEFINE_I440FX_MACHINE(4, 0);
 
-static void pc_i440fx_3_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_3_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_4_0_machine_options(m);
+    pc_i440fx_machine_4_0_options(m);
     m->smbus_no_migration_support = true;
     pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
-                      pc_i440fx_3_1_machine_options);
+DEFINE_I440FX_MACHINE(3, 1);
 
-static void pc_i440fx_3_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_3_0_options(MachineClass *m)
 {
-    pc_i440fx_3_1_machine_options(m);
+    pc_i440fx_machine_3_1_options(m);
     compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
-                      pc_i440fx_3_0_machine_options);
+DEFINE_I440FX_MACHINE(3, 0);
 
-static void pc_i440fx_2_12_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_12_options(MachineClass *m)
 {
-    pc_i440fx_3_0_machine_options(m);
+    pc_i440fx_machine_3_0_options(m);
     m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
-                      pc_i440fx_2_12_machine_options);
+DEFINE_I440FX_MACHINE(2, 12);
 
-static void pc_i440fx_2_11_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_11_options(MachineClass *m)
 {
-    pc_i440fx_2_12_machine_options(m);
+    pc_i440fx_machine_2_12_options(m);
     compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
-                      pc_i440fx_2_11_machine_options);
+DEFINE_I440FX_MACHINE(2, 11);
 
-static void pc_i440fx_2_10_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_10_options(MachineClass *m)
 {
-    pc_i440fx_2_11_machine_options(m);
+    pc_i440fx_machine_2_11_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
-                      pc_i440fx_2_10_machine_options);
+DEFINE_I440FX_MACHINE(2, 10);
 
-static void pc_i440fx_2_9_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_9_options(MachineClass *m)
 {
-    pc_i440fx_2_10_machine_options(m);
+    pc_i440fx_machine_2_10_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
-                      pc_i440fx_2_9_machine_options);
+DEFINE_I440FX_MACHINE(2, 9);
 
-static void pc_i440fx_2_8_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_8_options(MachineClass *m)
 {
-    pc_i440fx_2_9_machine_options(m);
+    pc_i440fx_machine_2_9_options(m);
     compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
-                      pc_i440fx_2_8_machine_options);
+DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_2_7_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_7_options(MachineClass *m)
 {
-    pc_i440fx_2_8_machine_options(m);
+    pc_i440fx_machine_2_8_options(m);
     compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
-                      pc_i440fx_2_7_machine_options);
+DEFINE_I440FX_MACHINE(2, 7);
 
-static void pc_i440fx_2_6_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_6_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_2_7_machine_options(m);
+    pc_i440fx_machine_2_7_options(m);
     pcmc->legacy_cpu_hotplug = true;
     x86mc->fwcfg_dma_enabled = false;
     compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
-                      pc_i440fx_2_6_machine_options);
+DEFINE_I440FX_MACHINE(2, 6);
 
-static void pc_i440fx_2_5_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_5_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
-    pc_i440fx_2_6_machine_options(m);
+    pc_i440fx_machine_2_6_options(m);
     x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
-                      pc_i440fx_2_5_machine_options);
+DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_2_4_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_4_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_2_5_machine_options(m);
+    pc_i440fx_machine_2_5_options(m);
     m->hw_version = "2.4.0";
     pcmc->broken_reserved_end = true;
     compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
-                      pc_i440fx_2_4_machine_options)
+DEFINE_I440FX_MACHINE(2, 4);
 
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
@@ -833,20 +806,20 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 #endif
 
 #ifdef CONFIG_XEN
-static void xenfv_4_2_machine_options(MachineClass *m)
+static void xenfv_machine_4_2_options(MachineClass *m)
 {
-    pc_i440fx_4_2_machine_options(m);
+    pc_i440fx_machine_4_2_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_4_2_machine_options);
+                  xenfv_machine_4_2_options);
 
-static void xenfv_3_1_machine_options(MachineClass *m)
+static void xenfv_machine_3_1_options(MachineClass *m)
 {
-    pc_i440fx_3_1_machine_options(m);
+    pc_i440fx_machine_3_1_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
@@ -854,5 +827,5 @@ static void xenfv_3_1_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_3_1_machine_options);
+                  xenfv_machine_3_1_options);
 #endif
-- 
2.41.0


