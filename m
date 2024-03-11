Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D87C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl8d-0005yH-L2; Mon, 11 Mar 2024 15:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4p-0003D1-MN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:51 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4n-0000Lj-CP
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4132e548343so5407175e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184363; x=1710789163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zA+7vGcCZSBpL/CfvBeZ5mq0z2pduOK8cD9pB8ojouU=;
 b=y/8fuwwhNmAz5Xvk+C3xpdYWvrmwXN9NZnFPkJ/uQ/Y9gnX123VDtbUIDbE3bPT47n
 uLI7OLVefVMlFS23jjVXa0tsJ7Qld8nGqgiP1uxWrmAkpot8nxn/RiQ8OZTwxiOVTHmL
 rgXzafjZMPBJyR25MI5RS2OR56eB8vAFShoI607BOAQ2gdqPYLrzZBD7BpKs1kEK0QKl
 filw1BRinUdYv8S1E3iml1xljikbhoxv0Gft6Ku0R2VMiXBN4hrUQpAQIInZNaF6SOjZ
 jXX9EK6xLb4aH3IOgvyMIBlN52qmwOhPVrZxGPLy+Gf84rWrD781Sh8O+XlGQ9Q0fnwf
 uzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184363; x=1710789163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zA+7vGcCZSBpL/CfvBeZ5mq0z2pduOK8cD9pB8ojouU=;
 b=WZTIP1QhIf3p8Tixz/huRgtsjWGpEIzpmHWB1KZp/ofefGkWFqsbZEKPEiCsXTc2Z6
 jrotrWnBjmn55mCnmFYna9pdh1ocm7UDg6qvt5akr0TNVOgdChJR4D0SSNvTyer8g2tK
 FPxrHGKJ0UDu9vrsHZ4qEq/t7PqeBH/jCtEev3OjrzVBd0qJhX74N4uxmUHhFMHyQURs
 agsEUHzJv1Is9+ombFORMo/RIMv+6CP8n+cbOqhwYJUc6S3soGX8kF1AlMyeji/W9/Nl
 2yw0LZ+kUdJEj7GfQYvF+HbtFAme3rYJOLcv4HovLDEpIsWvpPx39km1o8POKz+pTNfa
 +eAw==
X-Gm-Message-State: AOJu0YzrwIYG39zEj0H19s6QzdW8I/DbGvgAFVxEg/AskpzTYkcU8uAq
 QNHnt9w60AtzqlLN1EaaJaLtyYTgvYieGBmCOKvDWUcjQP/A44I5T2/k3mi8duiGy2FnmTunIVE
 a
X-Google-Smtp-Source: AGHT+IHNG6tmUw+7xjWLQPFHsn4zu/hYDAsl2xitygxGHsl3J1BIlNLfnc/eEQOhTvhOkDsXi9Xv0g==
X-Received: by 2002:a05:600c:190c:b0:413:1139:3bec with SMTP id
 j12-20020a05600c190c00b0041311393becmr5211402wmq.35.1710184362973; 
 Mon, 11 Mar 2024 12:12:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/20] hw/arm: Deprecate various old Arm machine types
Date: Mon, 11 Mar 2024 19:12:22 +0000
Message-Id: <20240311191241.4177990-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

QEMU includes some models of old Arm machine types which are
a bit problematic for us because:
 * they're written in a very old way that uses numerous APIs that we
   would like to get away from (eg they don't use qdev, they use
   qemu_system_reset_request(), they use vmstate_register(), etc)
 * they've been that way for a decade plus and nobody particularly has
   stepped up to try to modernise the code (beyond some occasional
   work here and there)
 * we often don't have test cases for them, which means that if we
   do try to do the necessary refactoring work on them we have no
   idea if they even still work at all afterwards

All these machine types are also of hardware that has largely passed
away into history and where I would not be surprised to find that
e.g. the Linux kernel support was never tested on real hardware
any more.

After some consultation with the Linux kernel developers, we
are going to deprecate:

All PXA2xx machines:

akita                Sharp SL-C1000 (Akita) PDA (PXA270)
borzoi               Sharp SL-C3100 (Borzoi) PDA (PXA270)
connex               Gumstix Connex (PXA255)
mainstone            Mainstone II (PXA27x)
spitz                Sharp SL-C3000 (Spitz) PDA (PXA270)
terrier              Sharp SL-C3200 (Terrier) PDA (PXA270)
tosa                 Sharp SL-6000 (Tosa) PDA (PXA255)
verdex               Gumstix Verdex Pro XL6P COMs (PXA270)
z2                   Zipit Z2 (PXA27x)

All OMAP2 machines:

n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)

One of the OMAP1 machines:

cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)

Rationale:
 * for QEMU dropping individual machines is much less beneficial
   than if we can drop support for an entire SoC
 * the OMAP2 QEMU code in particular is large, old and unmaintained,
   and none of the OMAP2 kernel maintainers said they were using
   QEMU in any of their testing/development
 * although there is a setup that is booting test kernels on some
   of the PXA2xx machines, nobody seemed to be using them as part
   of their active kernel development and my impression from the
   email thread is that PXA is the closest of all these SoC families
   to being dropped from the kernel soon
 * nobody said they were using cheetah, so it's entirely
   untested and quite probably broken
 * on the other hand the OMAP1 sx1 model does seem to be being
   used as part of kernel development, and there was interest
   in keeping collie around

In particular, the mainstone, tosa and z2 machine types have
already been dropped from Linux.

Mark all these machine types as deprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240308171621.3749894-1-peter.maydell@linaro.org
---
 docs/about/deprecated.rst | 15 +++++++++++++++
 hw/arm/gumstix.c          |  2 ++
 hw/arm/mainstone.c        |  1 +
 hw/arm/nseries.c          |  2 ++
 hw/arm/palm.c             |  1 +
 hw/arm/spitz.c            |  1 +
 hw/arm/tosa.c             |  1 +
 hw/arm/z2.c               |  1 +
 8 files changed, 24 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dfd681cd024..0d074d1b29b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -245,6 +245,21 @@ to correct issues, mostly regarding migration compatibility. These are
 no longer maintained and removing them will make the code easier to
 read and maintain. Use versions 2.12 and above as a replacement.
 
+Arm machines ``akita``, ``borzoi``, ``cheetah``, ``connex``, ``mainstone``, ``n800``, ``n810``, ``spitz``, ``terrier``, ``tosa``, ``verdex``, ``z2`` (since 9.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+QEMU includes models of some machine types where the QEMU code that
+emulates their SoCs is very old and unmaintained. This code is now
+blocking our ability to move forward with various changes across
+the codebase, and over many years nobody has been interested in
+trying to modernise it. We don't expect any of these machines to have
+a large number of users, because they're all modelling hardware that
+has now passed away into history. We are therefore dropping support
+for all machine types using the PXA2xx and OMAP2 SoCs. We are also
+dropping the ``cheetah`` OMAP1 board, because we don't have any
+test images for it and don't know of anybody who does; the ``sx1``
+and ``sx1-v1`` OMAP1 machines remain supported for now.
+
 Backend options
 ---------------
 
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index d5de5409e17..91462691531 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -106,6 +106,7 @@ static void connex_class_init(ObjectClass *oc, void *data)
     mc->desc = "Gumstix Connex (PXA255)";
     mc->init = connex_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 static const TypeInfo connex_type = {
@@ -121,6 +122,7 @@ static void verdex_class_init(ObjectClass *oc, void *data)
     mc->desc = "Gumstix Verdex Pro XL6P COMs (PXA270)";
     mc->init = verdex_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c0");
 }
 
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index d2e2e68aa3f..3a6c22fddbc 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -169,6 +169,7 @@ static void mainstone2_machine_init(MachineClass *mc)
     mc->init = mainstone_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 DEFINE_MACHINE("mainstone", mainstone2_machine_init)
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 35deb74f655..35364312c73 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1430,6 +1430,7 @@ static void n800_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
@@ -1452,6 +1453,7 @@ static void n810_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 8c4c8316140..e04ac92eb7f 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -309,6 +309,7 @@ static void palmte_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = 0x02000000;
     mc->default_ram_id = "omap1.dram";
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 643a02b1807..62cd55ba914 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -1041,6 +1041,7 @@ static void spitz_common_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
     mc->init = spitz_common_init;
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 3ca2e4459ca..5891f6064f9 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -270,6 +270,7 @@ static void tosapda_machine_init(MachineClass *mc)
     mc->init = tosa_init;
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
+    mc->deprecation_reason = "machine is old and unmaintained";
 }
 
 DEFINE_MACHINE("tosa", tosapda_machine_init)
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index eb2ff8dbc84..fc5672e7ab2 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -347,6 +347,7 @@ static void z2_machine_init(MachineClass *mc)
     mc->init = z2_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+    mc->deprecation_reason = "machine is old and unmaintained";
 
     machine_add_audiodev_property(mc);
 }
-- 
2.34.1


