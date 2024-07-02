Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E2CC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeQ-0007Ib-ND; Tue, 02 Jul 2024 01:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeN-0007Hq-Qa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeL-0006mY-VL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so2165123f8f.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896512; x=1720501312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjoCJaWMopGjgFAzmTclEaniscPXZHqfmSK68jrTLyM=;
 b=tC7dyutbH5JHqfsRbdsPQY5DIzUZhaVwxcovDr6/gtlronkHa0guRwqBzeI/ze6YR+
 EgE69iMhfO3Y/t8vRrkB+Orqlo7Vx0LFjxnE0mfcEb+UtWVjRmtkFNjPOm09fsl47yJy
 47e25ig+m3xRa+v4D7/MATMTJMZnSFO1BWynsVhkDpL2NRDG0LmUTSFS5uimsWv6iB00
 HMzysAedDTaZ+mnioIzJQP7YFYjtUJYbga8OOvd4k8EvjiGGUw2ImBhnHoPDoyjuNx6l
 ktpGt87OyY//ljzzGUQudFiahCeyH1qJ/ymTgoDIhVRvVfSN/5mPBELDn0A56YGhELxn
 PqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896512; x=1720501312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjoCJaWMopGjgFAzmTclEaniscPXZHqfmSK68jrTLyM=;
 b=X5o7a3ekLe21bl8/0LewguQKBBonzbk5neWiFpkMHCSiIfXpzoVOLAVxBXbv8YXLNv
 MAGh7JLxGIGdY0mDkCngZoHaSW5y/1REhFKJ4Jreij0avEFlxVegRfN5z9A9kG+3pfIV
 QMYW6KLQQOLlD5BZDcg2RECQhbvL7pLuusdEoJznmik8TTwXvtK0GzOn9F2fgmb16UmB
 ewCS2csAP63sJnEXl1uJneGHW7V3zw1A6+Iv5CgPm6v2chy23yeOXcJ7j9SoMxBxKgQ1
 RfTBd+U/45amFwOJ/g/STfS/AISXPcYQfPyHu1OswVA8QwrqnmRCCOUPoOmUEz1siYCq
 KQuw==
X-Gm-Message-State: AOJu0Yx++MvDKy7Rqe4EhAY0HklU2cH05V53el+uHsNHpcvSc9I+QZY2
 iGVxhhLwpeDAwhSv9sTcaLJ4WuahpwBPMUwYzBxvGp/pVXO/Ob/xao9W1MpGRCW9IxRdMu6usbE
 U
X-Google-Smtp-Source: AGHT+IEWoY0XqSvKofa1fbUE4Fl+5mMRMiXkR4AvYoQvx/XxuYgPOOle06C2ajdVLbfYP9VJQCHxLw==
X-Received: by 2002:a5d:6c66:0:b0:366:e991:b9ac with SMTP id
 ffacd0b85a97d-367756a3423mr4193492f8f.14.1719896512188; 
 Mon, 01 Jul 2024 22:01:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e141esm11844150f8f.58.2024.07.01.22.01.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/22] hw/m68k: convert 'virt' machine definitions to use new
 macros
Date: Tue,  2 Jul 2024 07:00:56 +0200
Message-ID: <20240702050112.35907-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

This changes the DEFINE_VIRT_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

A DEFINE_VIRT_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-6-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/virt.c | 55 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 09bc9bdfef..cd6ee692f7 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -335,99 +335,106 @@ static void virt_machine_register_types(void)
 
 type_init(virt_machine_register_types)
 
-#define DEFINE_VIRT_MACHINE(major, minor, latest) \
-    static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
-                                                    void *data) \
+#define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
+    static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        void *data) \
     { \
         MachineClass *mc = MACHINE_CLASS(oc); \
-        virt_machine_##major##_##minor##_options(mc); \
-        mc->desc = "QEMU " # major "." # minor " M68K Virtual Machine"; \
+        MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
+        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
         if (latest) { \
             mc->alias = "virt"; \
         } \
     } \
-    static const TypeInfo machvirt_##major##_##minor##_info = { \
-        .name = MACHINE_TYPE_NAME("virt-" # major "." # minor), \
-        .parent = MACHINE_TYPE_NAME("virt"), \
-        .class_init = virt_##major##_##minor##_class_init, \
-    }; \
-    static void machvirt_machine_##major##_##minor##_init(void) \
+    static const TypeInfo MACHINE_VER_SYM(info, virt, __VA_ARGS__) = \
     { \
-        type_register_static(&machvirt_##major##_##minor##_info); \
+        .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
+        .parent = MACHINE_TYPE_NAME("virt"), \
+        .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+    }; \
+    static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
+    { \
+        type_register_static(&MACHINE_VER_SYM(info, virt, __VA_ARGS__)); \
     } \
-    type_init(machvirt_machine_##major##_##minor##_init);
+    type_init(MACHINE_VER_SYM(register, virt, __VA_ARGS__));
+
+#define DEFINE_VIRT_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_VIRT_MACHINE_IMPL(true, major, minor)
+#define DEFINE_VIRT_MACHINE(major, minor) \
+    DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE(9, 1, true)
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
 
 static void virt_machine_9_0_options(MachineClass *mc)
 {
     virt_machine_9_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
-DEFINE_VIRT_MACHINE(9, 0, false)
+DEFINE_VIRT_MACHINE(9, 0)
 
 static void virt_machine_8_2_options(MachineClass *mc)
 {
     virt_machine_9_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_VIRT_MACHINE(8, 2, false)
+DEFINE_VIRT_MACHINE(8, 2)
 
 static void virt_machine_8_1_options(MachineClass *mc)
 {
     virt_machine_8_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
-DEFINE_VIRT_MACHINE(8, 1, false)
+DEFINE_VIRT_MACHINE(8, 1)
 
 static void virt_machine_8_0_options(MachineClass *mc)
 {
     virt_machine_8_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
-DEFINE_VIRT_MACHINE(8, 0, false)
+DEFINE_VIRT_MACHINE(8, 0)
 
 static void virt_machine_7_2_options(MachineClass *mc)
 {
     virt_machine_8_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
-DEFINE_VIRT_MACHINE(7, 2, false)
+DEFINE_VIRT_MACHINE(7, 2)
 
 static void virt_machine_7_1_options(MachineClass *mc)
 {
     virt_machine_7_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_1, hw_compat_7_1_len);
 }
-DEFINE_VIRT_MACHINE(7, 1, false)
+DEFINE_VIRT_MACHINE(7, 1)
 
 static void virt_machine_7_0_options(MachineClass *mc)
 {
     virt_machine_7_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
-DEFINE_VIRT_MACHINE(7, 0, false)
+DEFINE_VIRT_MACHINE(7, 0)
 
 static void virt_machine_6_2_options(MachineClass *mc)
 {
     virt_machine_7_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
-DEFINE_VIRT_MACHINE(6, 2, false)
+DEFINE_VIRT_MACHINE(6, 2)
 
 static void virt_machine_6_1_options(MachineClass *mc)
 {
     virt_machine_6_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
 }
-DEFINE_VIRT_MACHINE(6, 1, false)
+DEFINE_VIRT_MACHINE(6, 1)
 
 static void virt_machine_6_0_options(MachineClass *mc)
 {
     virt_machine_6_1_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
-DEFINE_VIRT_MACHINE(6, 0, false)
+DEFINE_VIRT_MACHINE(6, 0)
-- 
2.41.0


