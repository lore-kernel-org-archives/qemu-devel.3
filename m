Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4919CC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVeG-0007G7-A0; Tue, 02 Jul 2024 01:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeF-0007Fg-2U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:47 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeB-0006LC-0Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:01:46 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-363bd55bcc2so2007035f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896500; x=1720501300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0vVUZjdAMW7HsHuqmfd1tmncJKZdQ/oTZ2omBZVrOo=;
 b=yPikcMYtGKssUb/NsdZ1mBuqJxMc0sKY9SsujIhB/5EA3NDQa79cChrh/MzQL+99La
 lugdTX3wKlBiHjA+AOYPMicEgLmhhV13+qEcUE2upCqEquXkBj6K50vmfHtzDXFRhgNk
 0qnxMJaUHH2iRc1I/Pvqfhkh//s19MygZOSZM/XJa0ljPZjOlEv4jvY+STXzMCDgPwXB
 rpWJNhj4/cS5xJnk78stIW2k53+0T89ow5cGVGu50QLE5FvGau+oXuPq0t2+FP1aKLSN
 KbcroijCkbhWaEWS7uxLYjBoJMvmwqcvZ87BJrlxDoICyl3xpXNPyl07HmD2ODlj1p8J
 Z76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896500; x=1720501300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0vVUZjdAMW7HsHuqmfd1tmncJKZdQ/oTZ2omBZVrOo=;
 b=czN8COy58tjlxu+xbXV40sExff2XLcyS6MetnbQpBesaYngqTN2QVwitTV6RKxpQAU
 MsNI7QbPmpJbWU7PDn2z8WVLQy8yb97O2B0rKQ/GgvZuIyE7Ex2aUbb46ImOP++T0MTq
 gG9eMIJ1flCEmDDrFkGIHrrSVfMxwSVXmT3l5X7zpIWoR9QmoMXTGkInmC4CoQERzBq+
 sQMqHxTrJKcLj9TXWw8qv3YyCrgwoG8xC3/iI7JeG9k11y6MmbKNBPyPV9yJ58cwS7Io
 a0thaJsiaNw7CvE3lrSXIW67P9gIu3E8gceJLFeyzLZQp3v7e5n7J8cSiOubSiMeiI41
 Rggw==
X-Gm-Message-State: AOJu0Yy7Gf+E2rCKPsqZ+DgL8hZPhjZJJ0EvyYtWoe2eOe9KTxmhbSkj
 CDDBQTKKtIiSJRdflQ+QFsRd4m0MeseghibD+nDD1cguypmGkoWLgtOxaVekqLjTcapT30uTzoP
 r
X-Google-Smtp-Source: AGHT+IHQXx8nHiNe4t6gvp0i+xl/GBtTrxWxTCW3guMtX7KmB5uAuMS6dDCM+tnMzce/qGuDWSigrA==
X-Received: by 2002:a5d:45ca:0:b0:35f:ed0:9582 with SMTP id
 ffacd0b85a97d-367756a9285mr4907420f8f.16.1719896499987; 
 Mon, 01 Jul 2024 22:01:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1108b0sm11914511f8f.114.2024.07.01.22.01.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:01:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/22] hw/s390x: convert 'ccw' machine definitions to use new
 macros
Date: Tue,  2 Jul 2024 07:00:54 +0200
Message-ID: <20240702050112.35907-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
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

From: Daniel P. Berrangé <berrange@redhat.com>

This changes the DEFINE_CCW_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number twice in two different formats in the calls
to DEFINE_CCW_MACHINE.

A DEFINE_CCW_MACHINE_AS_LATEST helper is added so that it
is not required to pass 'false' for every single historical
machine type.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-4-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 100 ++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index cd063f8b64..380e9e2e5b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "exec/ram_addr.h"
 #include "exec/confidential-guest-support.h"
+#include "hw/boards.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
@@ -817,35 +818,44 @@ static const TypeInfo ccw_machine_info = {
     },
 };
 
-#define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
-    static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
-                                                  void *data)                 \
+#define DEFINE_CCW_MACHINE_IMPL(latest, ...)                                  \
+    static void MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__)(                \
+        ObjectClass *oc,                                                      \
+        void *data)                                                           \
     {                                                                         \
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
-        ccw_machine_##suffix##_class_options(mc);                             \
-        mc->desc = "Virtual s390x machine (version " verstr ")";              \
+        MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
+        mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
         if (latest) {                                                         \
             mc->alias = "s390-ccw-virtio";                                    \
             mc->is_default = true;                                            \
         }                                                                     \
     }                                                                         \
-    static void ccw_machine_##suffix##_instance_init(Object *obj)             \
+    static void MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__)(Object *obj) \
     {                                                                         \
         MachineState *machine = MACHINE(obj);                                 \
-        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));          \
-        ccw_machine_##suffix##_instance_options(machine);                     \
+        current_mc = S390_CCW_MACHINE_CLASS(MACHINE_GET_CLASS(machine));      \
+        MACHINE_VER_SYM(instance_options, ccw, __VA_ARGS__)(machine);         \
     }                                                                         \
-    static const TypeInfo ccw_machine_##suffix##_info = {                     \
-        .name = MACHINE_TYPE_NAME("s390-ccw-virtio-" verstr),                 \
-        .parent = TYPE_S390_CCW_MACHINE,                                      \
-        .class_init = ccw_machine_##suffix##_class_init,                      \
-        .instance_init = ccw_machine_##suffix##_instance_init,                \
-    };                                                                        \
-    static void ccw_machine_register_##suffix(void)                           \
+    static const TypeInfo MACHINE_VER_SYM(info, ccw, __VA_ARGS__) =           \
     {                                                                         \
-        type_register_static(&ccw_machine_##suffix##_info);                   \
+        .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
+        .parent = TYPE_S390_CCW_MACHINE,                                      \
+        .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .instance_init = MACHINE_VER_SYM(instance_init, ccw, __VA_ARGS__),    \
+    };                                                                        \
+    static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
+    {                                                                         \
+        type_register_static(&MACHINE_VER_SYM(info, ccw, __VA_ARGS__));       \
     }                                                                         \
-    type_init(ccw_machine_register_##suffix)
+    type_init(MACHINE_VER_SYM(register, ccw, __VA_ARGS__))
+
+#define DEFINE_CCW_MACHINE_AS_LATEST(major, minor) \
+    DEFINE_CCW_MACHINE_IMPL(true, major, minor)
+
+#define DEFINE_CCW_MACHINE(major, minor) \
+    DEFINE_CCW_MACHINE_IMPL(false, major, minor)
+
 
 static void ccw_machine_9_1_instance_options(MachineState *machine)
 {
@@ -854,7 +864,7 @@ static void ccw_machine_9_1_instance_options(MachineState *machine)
 static void ccw_machine_9_1_class_options(MachineClass *mc)
 {
 }
-DEFINE_CCW_MACHINE(9_1, "9.1", true);
+DEFINE_CCW_MACHINE_AS_LATEST(9, 1);
 
 static void ccw_machine_9_0_instance_options(MachineState *machine)
 {
@@ -866,7 +876,7 @@ static void ccw_machine_9_0_class_options(MachineClass *mc)
     ccw_machine_9_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
-DEFINE_CCW_MACHINE(9_0, "9.0", false);
+DEFINE_CCW_MACHINE(9, 0);
 
 static void ccw_machine_8_2_instance_options(MachineState *machine)
 {
@@ -878,7 +888,7 @@ static void ccw_machine_8_2_class_options(MachineClass *mc)
     ccw_machine_9_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_CCW_MACHINE(8_2, "8.2", false);
+DEFINE_CCW_MACHINE(8, 2);
 
 static void ccw_machine_8_1_instance_options(MachineState *machine)
 {
@@ -892,7 +902,7 @@ static void ccw_machine_8_1_class_options(MachineClass *mc)
     mc->smp_props.drawers_supported = false;
     mc->smp_props.books_supported = false;
 }
-DEFINE_CCW_MACHINE(8_1, "8.1", false);
+DEFINE_CCW_MACHINE(8, 1);
 
 static void ccw_machine_8_0_instance_options(MachineState *machine)
 {
@@ -904,7 +914,7 @@ static void ccw_machine_8_0_class_options(MachineClass *mc)
     ccw_machine_8_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_8_0, hw_compat_8_0_len);
 }
-DEFINE_CCW_MACHINE(8_0, "8.0", false);
+DEFINE_CCW_MACHINE(8, 0);
 
 static void ccw_machine_7_2_instance_options(MachineState *machine)
 {
@@ -916,7 +926,7 @@ static void ccw_machine_7_2_class_options(MachineClass *mc)
     ccw_machine_8_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_2, hw_compat_7_2_len);
 }
-DEFINE_CCW_MACHINE(7_2, "7.2", false);
+DEFINE_CCW_MACHINE(7, 2);
 
 static void ccw_machine_7_1_instance_options(MachineState *machine)
 {
@@ -940,7 +950,7 @@ static void ccw_machine_7_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     s390mc->max_threads = S390_MAX_CPUS;
 }
-DEFINE_CCW_MACHINE(7_1, "7.1", false);
+DEFINE_CCW_MACHINE(7, 1);
 
 static void ccw_machine_7_0_instance_options(MachineState *machine)
 {
@@ -955,7 +965,7 @@ static void ccw_machine_7_0_class_options(MachineClass *mc)
     ccw_machine_7_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
 }
-DEFINE_CCW_MACHINE(7_0, "7.0", false);
+DEFINE_CCW_MACHINE(7, 0);
 
 static void ccw_machine_6_2_instance_options(MachineState *machine)
 {
@@ -970,7 +980,7 @@ static void ccw_machine_6_2_class_options(MachineClass *mc)
     ccw_machine_7_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_2, hw_compat_6_2_len);
 }
-DEFINE_CCW_MACHINE(6_2, "6.2", false);
+DEFINE_CCW_MACHINE(6, 2);
 
 static void ccw_machine_6_1_instance_options(MachineState *machine)
 {
@@ -988,7 +998,7 @@ static void ccw_machine_6_1_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_1, hw_compat_6_1_len);
     mc->smp_props.prefer_sockets = true;
 }
-DEFINE_CCW_MACHINE(6_1, "6.1", false);
+DEFINE_CCW_MACHINE(6, 1);
 
 static void ccw_machine_6_0_instance_options(MachineState *machine)
 {
@@ -1003,7 +1013,7 @@ static void ccw_machine_6_0_class_options(MachineClass *mc)
     ccw_machine_6_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
-DEFINE_CCW_MACHINE(6_0, "6.0", false);
+DEFINE_CCW_MACHINE(6, 0);
 
 static void ccw_machine_5_2_instance_options(MachineState *machine)
 {
@@ -1015,7 +1025,7 @@ static void ccw_machine_5_2_class_options(MachineClass *mc)
     ccw_machine_6_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
 }
-DEFINE_CCW_MACHINE(5_2, "5.2", false);
+DEFINE_CCW_MACHINE(5, 2);
 
 static void ccw_machine_5_1_instance_options(MachineState *machine)
 {
@@ -1027,7 +1037,7 @@ static void ccw_machine_5_1_class_options(MachineClass *mc)
     ccw_machine_5_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
 }
-DEFINE_CCW_MACHINE(5_1, "5.1", false);
+DEFINE_CCW_MACHINE(5, 1);
 
 static void ccw_machine_5_0_instance_options(MachineState *machine)
 {
@@ -1039,7 +1049,7 @@ static void ccw_machine_5_0_class_options(MachineClass *mc)
     ccw_machine_5_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
 }
-DEFINE_CCW_MACHINE(5_0, "5.0", false);
+DEFINE_CCW_MACHINE(5, 0);
 
 static void ccw_machine_4_2_instance_options(MachineState *machine)
 {
@@ -1052,7 +1062,7 @@ static void ccw_machine_4_2_class_options(MachineClass *mc)
     mc->fixup_ram_size = s390_fixup_ram_size;
     compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
-DEFINE_CCW_MACHINE(4_2, "4.2", false);
+DEFINE_CCW_MACHINE(4, 2);
 
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
@@ -1066,7 +1076,7 @@ static void ccw_machine_4_1_class_options(MachineClass *mc)
     ccw_machine_4_2_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
 }
-DEFINE_CCW_MACHINE(4_1, "4.1", false);
+DEFINE_CCW_MACHINE(4, 1);
 
 static void ccw_machine_4_0_instance_options(MachineState *machine)
 {
@@ -1080,7 +1090,7 @@ static void ccw_machine_4_0_class_options(MachineClass *mc)
     ccw_machine_4_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
 }
-DEFINE_CCW_MACHINE(4_0, "4.0", false);
+DEFINE_CCW_MACHINE(4, 0);
 
 static void ccw_machine_3_1_instance_options(MachineState *machine)
 {
@@ -1096,7 +1106,7 @@ static void ccw_machine_3_1_class_options(MachineClass *mc)
     ccw_machine_4_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
 }
-DEFINE_CCW_MACHINE(3_1, "3.1", false);
+DEFINE_CCW_MACHINE(3, 1);
 
 static void ccw_machine_3_0_instance_options(MachineState *machine)
 {
@@ -1111,7 +1121,7 @@ static void ccw_machine_3_0_class_options(MachineClass *mc)
     ccw_machine_3_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
 }
-DEFINE_CCW_MACHINE(3_0, "3.0", false);
+DEFINE_CCW_MACHINE(3, 0);
 
 static void ccw_machine_2_12_instance_options(MachineState *machine)
 {
@@ -1125,7 +1135,7 @@ static void ccw_machine_2_12_class_options(MachineClass *mc)
     ccw_machine_3_0_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
 }
-DEFINE_CCW_MACHINE(2_12, "2.12", false);
+DEFINE_CCW_MACHINE(2, 12);
 
 #ifdef CONFIG_S390X_LEGACY_CPUS
 
@@ -1148,7 +1158,7 @@ static void ccw_machine_2_11_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_11, "2.11", false);
+DEFINE_CCW_MACHINE(2, 11);
 
 static void ccw_machine_2_10_instance_options(MachineState *machine)
 {
@@ -1160,7 +1170,7 @@ static void ccw_machine_2_10_class_options(MachineClass *mc)
     ccw_machine_2_11_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_len);
 }
-DEFINE_CCW_MACHINE(2_10, "2.10", false);
+DEFINE_CCW_MACHINE(2, 10);
 
 static void ccw_machine_2_9_instance_options(MachineState *machine)
 {
@@ -1184,7 +1194,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     css_migration_enabled = false;
 }
-DEFINE_CCW_MACHINE(2_9, "2.9", false);
+DEFINE_CCW_MACHINE(2, 9);
 
 static void ccw_machine_2_8_instance_options(MachineState *machine)
 {
@@ -1201,7 +1211,7 @@ static void ccw_machine_2_8_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_8, "2.8", false);
+DEFINE_CCW_MACHINE(2, 8);
 
 static void ccw_machine_2_7_instance_options(MachineState *machine)
 {
@@ -1216,7 +1226,7 @@ static void ccw_machine_2_7_class_options(MachineClass *mc)
     ccw_machine_2_8_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len);
 }
-DEFINE_CCW_MACHINE(2_7, "2.7", false);
+DEFINE_CCW_MACHINE(2, 7);
 
 static void ccw_machine_2_6_instance_options(MachineState *machine)
 {
@@ -1236,7 +1246,7 @@ static void ccw_machine_2_6_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_6, "2.6", false);
+DEFINE_CCW_MACHINE(2, 6);
 
 static void ccw_machine_2_5_instance_options(MachineState *machine)
 {
@@ -1248,7 +1258,7 @@ static void ccw_machine_2_5_class_options(MachineClass *mc)
     ccw_machine_2_6_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len);
 }
-DEFINE_CCW_MACHINE(2_5, "2.5", false);
+DEFINE_CCW_MACHINE(2, 5);
 
 static void ccw_machine_2_4_instance_options(MachineState *machine)
 {
@@ -1273,7 +1283,7 @@ static void ccw_machine_2_4_class_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
-DEFINE_CCW_MACHINE(2_4, "2.4", false);
+DEFINE_CCW_MACHINE(2, 4);
 
 #endif
 
-- 
2.41.0


