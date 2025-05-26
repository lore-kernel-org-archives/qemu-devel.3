Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DE2C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTcQ-0004TN-Dq; Mon, 26 May 2025 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcL-0004RZ-5y
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcI-00082o-1D
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-442ea341570so14229465e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1748249727; x=1748854527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsA9Af5XiTSdhlVAJ+Wc36kCuXWDKrIQJ8AeHaEqroA=;
 b=HbQOutO9n0Lak3Dq/yPLfVjxx5/wvRXYZ/S/JvuFl5uFqI8uaiTBrVrq9mBW4RPB46
 875/y3pxdMBfmPgxa5eDfVua5+VY0JNOpNaVocR9goh6EhA97CSx+vJF1QoU1O4IK1tO
 2Dk5PqFk8Q5Ib7jHv+uJ4O29ahzxYqcJF3pPyXFOc1ErEffvD3lj70FygLMNN+Mt9xJI
 u3rouy3Z7m4iAEjLCs4l+o3mXT4qPVYRVC2eINkCVBzT9Lnf3DAMpMnKxhd8QcIfasjL
 tL8GGrRz2vNRGpDRi2ZO+h0XEziLOw6rjiCd8A5qCccqGmy9jv7FAu9m75HQx8ouNIOa
 uvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249727; x=1748854527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsA9Af5XiTSdhlVAJ+Wc36kCuXWDKrIQJ8AeHaEqroA=;
 b=P4r7+7EFPGVw/cob46z1KLO9Ij1J2aE+fY5Dj/AvfBMJgw4xdjoV1EqX4u7iCTT3uQ
 7yYYsbvmGdmDMteK2uo0UqsgTs9MXRm2O5NqGt+nUdi9u+b0GGcSrfsLK0xKwfkvgo+n
 IgtCz+9tm7dfdFUqz173Wz4Zi4U43xrzv+Hk5Ohqr/6XD75OufTM3GUyorfLdUTFV6H9
 +5H4yn3yFH+Ro+EcKBNN1nuwlcr8S+0Cfgustnmg/L5EKE46Uf+BuiaMlzHwJDkKeTD4
 SwamTJCW2vCWQwjlzjg+j0nSQj+JBHgdv+rpeJJ3PKaPlIUFM7ITmImnLXTUXRe/pxuG
 Ku8w==
X-Gm-Message-State: AOJu0YxnC+PEmx0r/tHUkS1KC6GIyE+shkgne0QkxBqv4KB63iK6Hbtl
 y482SwEjB2ESwItgmkEsKWgd+k8AO9zOZ7ChAWA8x+1KzmiQDJVg4ko+qo4gc1UVVlgWP4yCAhb
 deGU=
X-Gm-Gg: ASbGnctGofANXA6dsGJJC02SE0QYHrR2a9X/5X2RI+YA7JjVvhv1aS2LoFLh0xo6vBv
 Z7/bN7RlU5FzIgT9lfCOoN9Gu38JPBzxpuIZCsRFJuctn8p2c4NKC4gg/XMUPA66nNwnby+S8cG
 HHOiOqaM3f17V5bxadM7xo6TxO+hy8PfnCtta2IT9WHnbG+dqtpjeaqm1AhIDhhbli0we2INloF
 g2kLeN7f/fVxOg91VC1qbwvmLsTR8t3/F3GCkUvQW3brq2wSe3mp9wGmORLdRrmkzyynp5ekyjd
 fXaPTOl1TpHvljtkJHVGyfpwBHviO/QNe8Hqk94ad20Xg6B4vvIFNQyHlr5IpwtTUrX6hg0cCfS
 a6OMTDmsNYlmgy0vxa5qk9eOnPanVIGuGcoiiTflbKszXkyd7rnJKiV/r9Ms=
X-Google-Smtp-Source: AGHT+IE175WlYxPHQnCslR4EFbg49+SeHVODMFjTOzymzXSM6WwQofwZ2ip6RPi+LaLSz6zfhBpNkw==
X-Received: by 2002:a05:600c:620a:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-44c94c28b8fmr57056995e9.28.1748249727569; 
 Mon, 26 May 2025 01:55:27 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm238911675e9.17.2025.05.26.01.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 01:55:27 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 1/4] hw/arm: make cpu targeted by arm_load_kernel the
 primary CPU.
Date: Mon, 26 May 2025 10:55:20 +0200
Message-Id: <20250526085523.809003-2-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526085523.809003-1-chigot@adacore.com>
References: <20250526085523.809003-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently, arm booting processus assumes that the first_cpu is the CPU
that will boot: `arm_load_kernel` is powering off all but the `first_cpu`;
`do_cpu_reset` is setting the loader address only for this `first_cpu`.

For most of the boards, this isn't an issue as the kernel is loaded and
booted on the first CPU anyway. However, for zynqmp, the option
"boot-cpu" allows to choose any CPUs.

Create a new arm_boot_info entry `primary_cpu` recording which CPU will
be boot first. This one is set when `arm_boot_kernel` is called.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c         | 15 +++++++--------
 include/hw/arm/boot.h |  3 +++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index f94b940bc3..8da4c67fa9 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -743,7 +743,7 @@ static void do_cpu_reset(void *opaque)
             } else {
                 if (arm_feature(env, ARM_FEATURE_EL3) &&
                     (info->secure_boot ||
-                     (info->secure_board_setup && cs == first_cpu))) {
+                     (info->secure_board_setup && cpu == info->primary_cpu))) {
                     /* Start this CPU in Secure SVC */
                     target_el = 3;
                 }
@@ -751,7 +751,7 @@ static void do_cpu_reset(void *opaque)
 
             arm_emulate_firmware_reset(cs, target_el);
 
-            if (cs == first_cpu) {
+            if (cpu == info->primary_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
                 cpu_set_pc(cs, info->loader_start);
@@ -1238,6 +1238,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     info->dtb_filename = ms->dtb;
     info->dtb_limit = 0;
 
+    /* We assume the CPU passed as argument is the primary CPU.  */
+    info->primary_cpu = cpu;
+
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
@@ -1287,12 +1290,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
             object_property_set_int(cpuobj, "psci-conduit", info->psci_conduit,
                                     &error_abort);
-            /*
-             * Secondary CPUs start in PSCI powered-down state. Like the
-             * code in do_cpu_reset(), we assume first_cpu is the primary
-             * CPU.
-             */
-            if (cs != first_cpu) {
+            /* Secondary CPUs start in PSCI powered-down state.  */
+            if (ARM_CPU(cs) != info->primary_cpu) {
                 object_property_set_bool(cpuobj, "start-powered-off", true,
                                          &error_abort);
             }
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index b12bf61ca8..a2e22bda8a 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -132,6 +132,9 @@ struct arm_boot_info {
     bool secure_board_setup;
 
     arm_endianness endianness;
+
+    /* CPU having load the kernel and that should be the first to boot.  */
+    ARMCPU *primary_cpu;
 };
 
 /**
-- 
2.34.1


