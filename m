Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F38CC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USY-0004dQ-9K; Thu, 03 Apr 2025 19:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USW-0004Y7-EO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:56 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USU-0002Tg-2o
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:58:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so1284996f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724732; x=1744329532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHY3m/5NH5MFZKDP2KzFtiCvD+X/0rIoNr0k1W0yLjQ=;
 b=kRVhJMVWQ1PQLCYStDb9oDZmOCZOVMDDOM02AnKFDwRU8G6u8jpQ4JYY0EVqkiGOcS
 3X4n0LDIqRwpNKSjv6Pi+j7A4ugmIKDnVmKP29sr4XcLI5Vx9A1w4EtEGjLgIXUuX661
 7cbpmQo+CnkMXfAifzA0uKikuRpVTMrjjAndWsdUsc/FWrpHMRfMsqhFIQ/VKznwmAxI
 6MyhKgFsHk2exim8o9XaI4Iih7BewbwQ6UwG688dnztuWfqxOHvlporgjhLwLgxYV9QK
 s9jA0IQMrqQ9HR+DI0PJGzZVZ9NN1QWLysO50qbCnnA0KLctar0/P1iQAft2b/gjjrq1
 BTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724732; x=1744329532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHY3m/5NH5MFZKDP2KzFtiCvD+X/0rIoNr0k1W0yLjQ=;
 b=g/bkindPJDKw/eci0Iyd5YX1Brq4YuhNAE5AjGDx6HgWQOct1UWc345KPqV2lyFbxF
 zeQxkHz/5V+2NtQYLJVqJo1lL5f2uMfi7qMqjR0A47+k+MIpWpuumejGWgSHKuep9vUY
 O785fzM/lSs2S35YxwaIqixl1vZFmRz8nXFNbzfKfFr92Kb9hktUsjFe3+9nNbEgTJtc
 s+vpvJ0MwS2/YN22fGGEE5teXgH59mSQaWpeQV7IGU9ql1bvQZGUqYEbCSzHUapM2/il
 2Ii/oQAgm3wAyYqBOuIGlhG6gCKKpIV4jFSG6PgH0zG+sdOWf6F66dMmb6ERvlFEH5+c
 oDzg==
X-Gm-Message-State: AOJu0YxuASOTDZ637XruhE+/f4VTs1uk3Cgyj7hNf7ynaq4MFCPWZ+AX
 YgLZwHIj+eroTCwiC2uQl8EZ0OJuWeeBWxzXkIc5tNGGUzIsD2Oqm/LUmcfXBpyKUgMZeD5sopq
 B
X-Gm-Gg: ASbGncuixb4jRL2M9mvJ8SxHBUdYx/Z+N8nHRR9tmaeVbtQC2qxvChbdLLu+1L/qKKG
 eZnhfh8nt6kkNFCJuBdDBQi3/Nk0GnzCzWoaVu5R21hkWoA60xDuwa6UW98ThXblLF2mhob30GK
 IoCxhZw1rJ5adRIQVd3vcwPFxdD1K7YrrNbPR+kAezC41fq0I66qufw8y+sysx0Cp1akDLJH7ga
 hFoZS4skq8MF7/5qRtUCMw2BbxXoZGUg6TyEpnFw11lvxIg2M/FZHgzTUYJPX4tRiLZZsbAD1vg
 mGHyqFyatdqm7KBGVkeHGV1uvYG75Y+LBYOinSq+wjFCvICFnZWpZVIiwCONCEUKNyre1zEjsqz
 y3sIHB564SYo4UkypXxA=
X-Google-Smtp-Source: AGHT+IEnAQvNvviTrIzjNCRUtCxL8YUO4afUTpUEZAztEetCzEZZiGDhHgPK9pg4B0cXv0Vg9HhS8A==
X-Received: by 2002:a5d:64a9:0:b0:391:4bcb:828f with SMTP id
 ffacd0b85a97d-39d0de1233emr464307f8f.14.1743724732148; 
 Thu, 03 Apr 2025 16:58:52 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6608sm2949903f8f.23.2025.04.03.16.58.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:58:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 04/39] hw/arm: Filter machine types for binary
Date: Fri,  4 Apr 2025 01:57:46 +0200
Message-ID: <20250403235821.9909-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/b-l475e-iot01a.c   | 1 +
 hw/arm/collie.c           | 1 +
 hw/arm/exynos4_boards.c   | 1 +
 hw/arm/fby35.c            | 1 +
 hw/arm/highbank.c         | 2 ++
 hw/arm/microbit.c         | 1 +
 hw/arm/mps2-tz.c          | 4 ++++
 hw/arm/mps2.c             | 4 ++++
 hw/arm/mps3r.c            | 1 +
 hw/arm/musca.c            | 2 ++
 hw/arm/omap_sx1.c         | 2 ++
 hw/arm/realview.c         | 4 ++++
 hw/arm/sbsa-ref.c         | 1 +
 hw/arm/stellaris.c        | 3 +++
 hw/arm/versatilepb.c      | 1 +
 hw/arm/vexpress.c         | 2 ++
 hw/arm/xilinx_zynq.c      | 1 +
 hw/arm/xlnx-versal-virt.c | 1 +
 hw/arm/xlnx-zcu102.c      | 1 +
 19 files changed, 34 insertions(+)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index c9a5209216c..f7fb6c54395 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -131,6 +131,7 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
+        .interfaces     = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     }
 };
 
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index e83aee58c6b..c5bed6c7006 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -86,6 +86,7 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2d8f2d73265..53b79b893d8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -192,6 +192,7 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 6d3663f14a1..d4cc596fb67 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -187,6 +187,7 @@ static const TypeInfo fby35_types[] = {
         .class_init = fby35_class_init,
         .instance_size = sizeof(Fby35State),
         .instance_init = fby35_instance_init,
+        .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     },
 };
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 0f3c207d548..ea3621e4f87 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -363,6 +363,7 @@ static const TypeInfo highbank_type = {
     .name = MACHINE_TYPE_NAME("highbank"),
     .parent = TYPE_MACHINE,
     .class_init = highbank_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void midway_class_init(ObjectClass *oc, void *data)
@@ -387,6 +388,7 @@ static const TypeInfo midway_type = {
     .name = MACHINE_TYPE_NAME("midway"),
     .parent = TYPE_MACHINE,
     .class_init = midway_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void calxeda_machines_init(void)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index ade363daaa4..dd265d8cfb3 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -74,6 +74,7 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index b0633a5a69e..1f0a431adc8 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1463,24 +1463,28 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 6958485a668..e4763add3db 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -563,24 +563,28 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4dd1e8a7180..e9abbf00b43 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -634,6 +634,7 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
+        .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
     },
 };
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index a4f43f1992b..5d63a4e9ec7 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -657,12 +657,14 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index aa1e96b3ad7..bb676f63eb5 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -219,6 +219,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .name = MACHINE_TYPE_NAME("sx1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
@@ -238,6 +239,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .name = MACHINE_TYPE_NAME("sx1-v1"),
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 008eeaf049a..f81d084eb80 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -431,6 +431,7 @@ static const TypeInfo realview_eb_type = {
     .name = MACHINE_TYPE_NAME("realview-eb"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
@@ -452,6 +453,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .name = MACHINE_TYPE_NAME("realview-eb-mpcore"),
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
@@ -471,6 +473,7 @@ static const TypeInfo realview_pb_a8_type = {
     .name = MACHINE_TYPE_NAME("realview-pb-a8"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
@@ -491,6 +494,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .name = MACHINE_TYPE_NAME("realview-pbx-a9"),
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index aa09d7a0917..112cbbf29e6 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -920,6 +920,7 @@ static const TypeInfo sbsa_ref_info = {
     .instance_init = sbsa_ref_instance_init,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
+    .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index cbe914c93e9..b901683f78a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1475,6 +1475,7 @@ static const TypeInfo stellaris_i2c_info = {
     .instance_size = sizeof(stellaris_i2c_state),
     .instance_init = stellaris_i2c_init,
     .class_init    = stellaris_i2c_class_init,
+    .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void stellaris_adc_class_init(ObjectClass *klass, void *data)
@@ -1492,6 +1493,7 @@ static const TypeInfo stellaris_adc_info = {
     .instance_size = sizeof(StellarisADCState),
     .instance_init = stellaris_adc_init,
     .class_init    = stellaris_adc_class_init,
+    .interfaces    = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void stellaris_sys_class_init(ObjectClass *klass, void *data)
@@ -1512,6 +1514,7 @@ static const TypeInfo stellaris_sys_info = {
     .instance_size = sizeof(ssys_state),
     .instance_init = stellaris_sys_instance_init,
     .class_init = stellaris_sys_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void stellaris_register_types(void)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 35766445fa4..3cfcd56f06b 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -452,6 +452,7 @@ static const TypeInfo versatileab_type = {
     .name = MACHINE_TYPE_NAME("versatileab"),
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 76c6107766c..6cd8c42925b 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -850,6 +850,7 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -857,6 +858,7 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index b8916665ed6..8f2f0f35ff3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -480,6 +480,7 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0c6f0359e3d..e19c4d9ef58 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -833,6 +833,7 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
     .instance_finalize = versal_virt_machine_finalize,
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4fdb153e4d8..88b1eafab4d 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -303,6 +303,7 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
+    .interfaces = LEGACY_BINARY_QEMU_SYSTEM_ARM_INTERFACE,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
-- 
2.47.1


