Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849FECCD18E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgL-0002Oe-5e; Thu, 09 Oct 2025 10:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rg2-0002Jh-CY
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rfx-00030d-TF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46faa5b0372so7045845e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020278; x=1760625078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOp3rKosIyx799fK4DaxcBNnF6lqgIhXIx3NHPcTKew=;
 b=QwvkFqypQDky7QeVvS3ES96Q4ix7jAuAp3rGBQEju4QD8DWXL7jROeMDsecBK988oC
 fKm97VhNJM3xXBVPrfsnTP9F57W7bS63cRC92THB0w1lRHiauzK9tA3AGeAw5c2kH3pL
 2YRG/HOAx6u/TuGSbiEctbnZZd6SQJ09fYzRV47Hj/rODJekpc0vMyQefmpjyR+zFi4t
 CsTuP4hDFjoUSLYxcCpyiaoQqBHhi3KSCQYDkmtFRl7n6TWSF4wThUZvZiKu5sGThe9W
 6znG7fzgeHB2yAIv6rVsB+tx7tAGMqQLr1KCiMqhbv4Chi7z/u5amTIjQKfXP1s8qt3G
 e8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020278; x=1760625078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOp3rKosIyx799fK4DaxcBNnF6lqgIhXIx3NHPcTKew=;
 b=rf58dp7p6oldRGckmKeAHcQDmXwyasg8Ffv4Mj4bzWIKjHS1tB9pxOOikLGXSaZ+JT
 /Q/RyHNnu2Y2RTzaNkhH6X+42KnrG/YT+hlxaXMKOn5UHMBnjMJPljWZlKZiipWc6z81
 OTK/4sm5YkqXgBA2tYLjZFjROKyEaGh3OigCYbaTdVfjGDDBIhTXtpSEPHz0OCUa+IU5
 Ypaw9O+RmsDSaNp+UDAKJfB8L1/xq0vXbD7T70BW6oXGvxwwvvgbUnNEfC8+aTt9gvSU
 YBKHmOnwz0WxADmBjLW7/Vhv7kEZgEDrfLLW7lvfzP7MA8oOMJieeVtEonJrvuTjNKz7
 5D6A==
X-Gm-Message-State: AOJu0YxIXQ9z8FU6i4DUOMAhcXoyb5/+RnzbmBupoHnCmNDwatug0d8B
 qfif9i0mX+lbqhbxZYNT/eFP8ibW1qev666v0misxQojHaHf0RJl5JI4A+lHdMsGvnG3sRnxeW6
 C3tTYCeWK6A==
X-Gm-Gg: ASbGncuJlaqVmE95D0sai2RT+HuZkFXmUul1rfWnuzjuSs+N8iK4b8NMPJfBoyQb8Hk
 PyQAWd3SYdfgHNXJul9vUrIVyJSWvUsq3r2bKuat6NrbmtJWb2rwsKHtWBgdxxpLA9vWXproi+9
 M0Nxn5RCXfNl8ZiNea2im/8Byz2GCotyia28cBh7dFQG3c+CRXpxIgqiui0nsWXxzcXNakqNafQ
 eGJmI1BK32LSsOTWVOw3z9qOgxg5L4kH76dlbWjoULeWU3521xBmV9Fi2Pi20SuFUvn/DgJzU3X
 jzpkRIabN8102ydJKijl4vuQguv5MDosNUWVJ1IUvRoLDIAygZ2u1veEgZ4Bd+3dgQ+5aV+sxcx
 jOsKH/G2ATJMqkyS9Xytz05DaNFD65Bsosi6pyT+CjanGK/+qdqWEnoidgkvc/2oZ3isRW9Ny5J
 UmTNhvtpKtbE4NjHDXigbtgz9/
X-Google-Smtp-Source: AGHT+IFLG1nnYSg/DKr4/FZlS4UWM9ZY/6sVwiWcR/kr1c0EnQJ1E0j6e2abCw1C0ZVDb+T/Ybbn4w==
X-Received: by 2002:a05:600c:3e1a:b0:46e:1d8d:cfa2 with SMTP id
 5b1f17b1804b1-46fa9af9842mr54538885e9.20.1760020277823; 
 Thu, 09 Oct 2025 07:31:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb4826160sm530825e9.7.2025.10.09.07.31.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] hw/hppa: Convert type_init() -> DEFINE_TYPES()
Date: Thu,  9 Oct 2025 16:31:02 +0200
Message-ID: <20251009143106.22724-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Prefer DEFINE_TYPES() macro over type_init() to register
multiple QOM types.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 1cce5c47b91..bbee70022f1 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -710,16 +710,6 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_B160L_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("B160L"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_B160L_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
-    },
-};
-
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -746,20 +736,24 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo HP_C3700_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("C3700"),
-    .parent = TYPE_MACHINE,
-    .class_init = HP_C3700_machine_init_class_init,
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_NMI },
-        { }
+static const TypeInfo hppa_machine_types[] = {
+    {
+        .name = MACHINE_TYPE_NAME("B160L"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_B160L_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
+    }, {
+        .name = MACHINE_TYPE_NAME("C3700"),
+        .parent = TYPE_MACHINE,
+        .class_init = HP_C3700_machine_init_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_NMI },
+            { }
+        },
     },
 };
 
-static void hppa_machine_init_register_types(void)
-{
-    type_register_static(&HP_B160L_machine_init_typeinfo);
-    type_register_static(&HP_C3700_machine_init_typeinfo);
-}
-
-type_init(hppa_machine_init_register_types)
+DEFINE_TYPES(hppa_machine_types)
-- 
2.51.0


