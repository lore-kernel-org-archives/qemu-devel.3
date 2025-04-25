Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11122C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L1N-0003WH-Ds; Fri, 25 Apr 2025 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0h-0001Zy-Ls
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L0e-0003vT-Tt
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:30:38 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so16128385e9.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595035; x=1746199835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15v8jL3LCLtXh+M75p16dlGPvBB3CQJEUK4JwbtboS4=;
 b=bf08L0VZcfvhlHwFZX/ytTYcvLkPX6K4HEC/OGeAHLu0Yxh3Jpm9Uv2Bq3dlMwnDRm
 VP/pEHuRILdF05mB7XIrI+E1bcuM7EydkbpBH7OGnhDbhlIvyc3dQx82XdMMqdqiOrZp
 8O9Fs3ZMXD0Z7ROXM4lQtzA8lbX6Uk2xGFQeO8EyNCs4VitmUciyjs5d9b6pnKSggtEZ
 uXQod0UdPAyFtc4CbwR3YsTBLX/zh837LjvRwtFfYvm2pjZADEECcvC9FgeAuhinhiQf
 mSAqu1vTHQIx91cQFkMtBBu3DaLTtWDI+s6/sNyGl52tna79H6E3Yq/v7MfCuLHPq4kr
 Qd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595035; x=1746199835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15v8jL3LCLtXh+M75p16dlGPvBB3CQJEUK4JwbtboS4=;
 b=Tq01QitopuYvA6Py3h8PwYW5ezf8Kn1R0h4jHouz1QQUhRDlX+cfwTTnv+tIqV+MyH
 UgzZglQ+PjqKIj3VNCQ1N/TRuphW4YYKH4vEsR4PkBuUko/i65oSal9GBjcdCrn9hot0
 RDd9GEK+mf67/zSq7+dEueE50/k5n9837OcyiWOLykUzikvhJO1Iv9rD6QtmNaiQs8Uv
 lLwJh9Xv6i4TWq77GYYInOVezAPm04hZTj9JBQp5HUVNppY/wtL76vLxu5M49iLG3RCI
 1yKKxXoFU6hROcwovkews2GUdYsdf8UVLdMvTkqQg4JsseVZVwgdcnyUc6n90iDnXYWO
 4OUA==
X-Gm-Message-State: AOJu0YyW3C243pV54t8Cyokji7HcQl9Oa49EVrxcrPbc41WJC1LHQGO5
 WDJbgut3DVlnjFD7XSlmwcXQwdQUDa5LEtfOhLRFYxeKEPCCDN34MhZ6uV0pVIAe2O9iF/xdfZk
 l
X-Gm-Gg: ASbGncuBy6BDUDeMV7hNXdW8hLWS2POVD6acur4Oa1yQpakcQx7jgiWuyEX8D/Lpu3J
 Y+SSYpKEUrRlo15bgY0SjfKPWcKclBJx6P8prYXmkgLQfh8xFNMX1mz3hIrCFz/BbzDWXa/HTM9
 Jxf1nOTx7swwh140e0/kS46jL80AP4k5LXaYSvNoczI2xZEaPOV47fu8kvyIfhS5Ofe48axZq/Z
 Twj1YHwb2zSXqFuX5Z326Ml2l85fZHfpZ1LVqFWzv5RZy1nlA/g1ZRrgDScAAfY6cgvJ44Dezpi
 VFwz8d7hV1gYpXjuewEgmBhKQZnKM4xxzTckfGQOI5myS5UWzlXlti26IoItmU3cqadFGraXtwT
 seEj3eu1jS9bA/K8=
X-Google-Smtp-Source: AGHT+IH8SQHrkH0J2Ql8/NM4ppcaYbEctWS7ChLrkvx/JqhaEMY2tl5PTdT1IwEx2OdXrjW/U6u0wQ==
X-Received: by 2002:a05:600c:4691:b0:43b:c7f0:6173 with SMTP id
 5b1f17b1804b1-440a65cde53mr22838965e9.4.1745595035009; 
 Fri, 25 Apr 2025 08:30:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8c968sm2636951f8f.8.2025.04.25.08.30.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:30:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/58] target/arm: Handle gdb_core_xml_file in TYPE_ARM_CPU
Date: Fri, 25 Apr 2025 17:28:06 +0200
Message-ID: <20250425152843.69638-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Instead of having the TYPE_AARCH64_CPU subclass set
CPUClass:gdb_core_xml_file to a different value from that that
TYPE_ARM_CPU uses, implement the gdb_get_core_xml_file method in the
TYPE_ARM_CPU class to return either the AArch64 or AArch32 XML file
name.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250317142819.900029-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c         | 16 +++++++++++++++-
 target/arm/cpu64.c       |  1 -
 target/arm/tcg/cpu-v7m.c |  1 -
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index bed0e58f3c0..5e951675c60 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2658,6 +2658,20 @@ static const gchar *arm_gdb_arch_name(CPUState *cs)
     return "arm";
 }
 
+static const char *arm_gdb_get_core_xml_file(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    if (arm_gdbstub_is_aarch64(cpu)) {
+        return "aarch64-core.xml";
+    }
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        return "arm-m-profile.xml";
+    }
+    return "arm-core.xml";
+}
+
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -2727,6 +2741,7 @@ static void arm_cpu_class_init(ObjectClass *oc, const void *data)
     cc->sysemu_ops = &arm_sysemu_ops;
 #endif
     cc->gdb_arch_name = arm_gdb_arch_name;
+    cc->gdb_get_core_xml_file = arm_gdb_get_core_xml_file;
     cc->gdb_stop_before_watchpoint = true;
     cc->disas_set_info = arm_disas_set_info;
 
@@ -2749,7 +2764,6 @@ static void cpu_register_class_init(ObjectClass *oc, const void *data)
     CPUClass *cc = CPU_CLASS(acc);
 
     acc->info = data;
-    cc->gdb_core_xml_file = "arm-core.xml";
     if (acc->info->deprecation_note) {
         cc->deprecation_note = acc->info->deprecation_note;
     }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index fbb7e7b3d64..5135ef63cb2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -819,7 +819,6 @@ static void aarch64_cpu_class_init(ObjectClass *oc, const void *data)
 
     cc->gdb_read_register = aarch64_cpu_gdb_read_register;
     cc->gdb_write_register = aarch64_cpu_gdb_write_register;
-    cc->gdb_core_xml_file = "aarch64-core.xml";
 
     object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
                                    aarch64_cpu_set_aarch64);
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 7426aac0dc4..b34b6578574 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -266,7 +266,6 @@ static void arm_v7m_class_init(ObjectClass *oc, const void *data)
 
     acc->info = data;
     cc->tcg_ops = &arm_v7m_tcg_ops;
-    cc->gdb_core_xml_file = "arm-m-profile.xml";
 }
 
 static const ARMCPUInfo arm_v7m_cpus[] = {
-- 
2.47.1


