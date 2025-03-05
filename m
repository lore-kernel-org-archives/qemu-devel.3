Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC34C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqr3-0008Sk-G8; Wed, 05 Mar 2025 10:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqr0-0008SE-TQ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqx-0002Lw-Mw
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:40:14 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc4b16135so21693585e9.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189210; x=1741794010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RHsIUy8sKMvdJC/jiaNf5NT96KaTYh580z1CwMPFXu8=;
 b=wDy7Pt6qy/l45gXtOt+d7wRwhG7cRfJXeP1LSoklQ4PhqbKzpiuCcBHfzmGexNM53W
 MQ7bLSkpmco19KnRaJ5K4K+SV8dtgQnGfs5aXsKSiySIr9dx1m+Z2BgeHrUn0n+OI0kL
 SGsduy/0VnJf+YRQDY76HgdUB2kNA1F4yaFO4wW4yZlciiXN0POABNKbf83paCvzOGg6
 uqln6Ppin9HhPc5ZAKxwPybYoDB3c6hLllsmSgOl1rEB2ET94AO5gTsX6e4eu2JPOX2m
 Ke23OyGSjujky8WCn8mZAAit+yfM+girGJYYn2g5rRhdtL0g6EZ9EH8Z7TcsR9EDupJk
 Eulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189210; x=1741794010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RHsIUy8sKMvdJC/jiaNf5NT96KaTYh580z1CwMPFXu8=;
 b=SvXMSpyKD5mmmRNSSQM4JF+DNG9QVbAxzXYr6INQIu47FtVruSY0r/ptq9k+Z6pjX4
 SPwoeW4iaVr1TsjdgeV/6cAwYaoBWQHJq85LuLtl25HVbtTGxLQtSbMZCdDlWi603ZEF
 C3DFv8KphXilD68XnfA/ALE/+oJdWQXglFOzKoI7jc9Fh/u/KVUC/oCmbplvQ2Gb/E1M
 E+9rY1UPD9U0TLKgh2pLEUchjiBUsI2nyoUDOxlTHrka2dzkw06jJWUQAkzHrCMVirdE
 2/skwt6r/r/OMVRlExZYtnWcGuiDVFighG7w55nPPBC79zuvu35MYShPvC0rSwQeKvX6
 TNPw==
X-Gm-Message-State: AOJu0YxejBjjKZApm6fkjAz8QByNkDNbkcpEZQQl7Y05ugt0B3g8T/kA
 KrA3HRSVTxnkAD7PKGceiuZTY5ohLi9OBYbeLODeXUMLtK/tdP0pwppvmSxQToH915z+7PIE66w
 Hf/s=
X-Gm-Gg: ASbGnct/F3d6fUQoI0XoaNg2/LqciktLiSZHG1GsH5GnyzQh6nEWw3kX0WO5Za/kRVk
 z00IdPAfbKbrXmCkOqZfgHyXyGKd3klMD8eQ0O96GqQ438cGW2k4ytZqFvJ1odRG6HvIid6FVSO
 kSHrNVXvV1ccJczA8qhbKnL96o+RDWlC7TonQV4Ia8I2JWT3Dlq23Q6JdCK7s1ZZtaepk9berI+
 ViGx/BH/MXIt5tWaVJ/jpRYEBEqLm8TLIv4h+BOyV7tPzMG6WqNWZYwNqZjGQZ86XoIfrhVMDmz
 6SbXLbBKVvZHWLj2cphFe2AbI8vpmGi5yR9dCOzALuWXirv6aaYb5PUiC4eemN8sSnn5MjB+mW+
 DcVFmdQ9mjICGjtezxqE=
X-Google-Smtp-Source: AGHT+IHOUVpD+bGIsn9N3xpYujRIAoxMaeIxhOt1BddFy+SOh08mb7/IAJ0D2a6iA7SvK7QD0LFQCA==
X-Received: by 2002:a05:600c:468e:b0:43b:bdf4:1c9 with SMTP id
 5b1f17b1804b1-43bd2af4b26mr26941585e9.29.1741189209779; 
 Wed, 05 Mar 2025 07:40:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42badefsm20744025e9.18.2025.03.05.07.40.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:40:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 08/18] hw/i386: Inline TARGET_DEFAULT_CPU_TYPE definition
Date: Wed,  5 Mar 2025 16:39:18 +0100
Message-ID: <20250305153929.43687-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

For legacy x86 binaries, legacy_binary_is_64bit() is equivalent
of the compile time TARGET_X86_64 definition. Use it in place in
machine class_init() handlers, removing the need on TARGET_X86_64.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h     | 6 ------
 hw/i386/microvm.c     | 5 ++++-
 hw/i386/pc.c          | 5 ++++-
 hw/i386/xen/xen-pvh.c | 5 ++++-
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0ab2e1bdb40..7f3c1ceaca7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2555,12 +2555,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define CPU_RESOLVING_TYPE TYPE_X86_CPU
 
-#ifdef TARGET_X86_64
-#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
-#else
-#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
-#endif
-
 #define cpu_list x86_cpu_list
 
 /* MMU modes definitions */
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d0a236c74f3..cc94e1408c6 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-visit-common.h"
@@ -654,7 +655,9 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->has_hotpluggable_cpus = false;
     mc->auto_enable_numa_with_memhp = false;
     mc->auto_enable_numa_with_memdev = false;
-    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = legacy_binary_is_64bit()
+                           ? X86_CPU_TYPE_NAME("qemu64")
+                           : X86_CPU_TYPE_NAME("qemu32");
     mc->nvdimm_supported = false;
     mc->default_ram_id = "microvm.ram";
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63a96cd23f8..936a770aad8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/legacy_binary_info.h"
 #include "hw/i386/pc.h"
 #include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
@@ -1794,7 +1795,9 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = pc_machine_device_plug_cb;
     hc->unplug_request = pc_machine_device_unplug_request_cb;
     hc->unplug = pc_machine_device_unplug_cb;
-    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = legacy_binary_is_64bit()
+                           ? X86_CPU_TYPE_NAME("qemu64")
+                           : X86_CPU_TYPE_NAME("qemu32");
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 33c10279763..f0080c83021 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/legacy_binary_info.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "system/system.h"
@@ -81,7 +82,9 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Xen PVH x86 machine";
-    mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->default_cpu_type = legacy_binary_is_64bit()
+                           ? X86_CPU_TYPE_NAME("qemu64")
+                           : X86_CPU_TYPE_NAME("qemu32");
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
-- 
2.47.1


