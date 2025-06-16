Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776AC71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUZ-0001FS-So; Mon, 16 Jun 2025 10:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATz-00015S-I1
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRATw-00040Y-Vr
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:42 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451d54214adso35522155e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082799; x=1750687599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZqawsmPR4ehVDHHaDoceEn6Ki+J71wY97xtw/kIEj3I=;
 b=gekuyvyE+u9qZDPMCX29Nb04NYcvJGdQWfU/nnCKUzEPTMYMuc1jerYn/DUlqKow+W
 t2XmMeaIgxFljk2NSSXP7TMAxaYxdsgtxDra4RYBlzyJGArtXo4nO52JENay5xGJdoIF
 xIFKcpXlf/YN9BJ7YQuD62XU1yXkZiNp5iCO1t59L9jiljMlqPjZiIttUN7V1duK4cYm
 KgGl9bMGMiKwuGvydV+GmjqkBHoTdKkrXP5K22po/tGenhm1KwXw2YQKM+Dt08c38GCb
 qx1lu0owf6FjBFyp5JvLICANmStBrFHR1qtVVZoGOUyz5OblUkRwaEpGiBQK0od0PWBA
 aRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082799; x=1750687599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqawsmPR4ehVDHHaDoceEn6Ki+J71wY97xtw/kIEj3I=;
 b=CBDjtw8lDZw2uQF/8XDWp/V3fuFlaXoK1yFxhfc8j4S85AR+fipKvlp1xGnF0bO6lZ
 fNi9xTr1YuxIB1KVpXJ1kn6GP0R9O8cbhyxCX1LOQxH4IUbp3pWPUFjh9xK4joXr3zgg
 g2HXZKwoRzK4OrS6K617c1kPwJQmDnOpE//z4nrjnyzNS94NKG05MVC+2Zbuj3VOLNwH
 80IIwEImls5bVFsQtzNtEUoeKPrKPeMzoeJcoYq7k5pQX7ecOR1oynqLUEv+QE59Ys1K
 25G9m1Tf2hHmEWe9qziY4ZruVWpEE8zFUF3NDLQrXJQagVpYLXmUMadRoa64zF1GbJUt
 PeVw==
X-Gm-Message-State: AOJu0YyTOlO6Jedq/2upVqsoxYqmz1Ywxd5cDihuars1SMsBY6+3/FuO
 Io/+5zQcHAmnfCyjRmT/5RglZAkB7//OYBIge0TLqLa2JY7WehA99jppu7oPnAMcywXn3SJ6m8H
 1OuQh
X-Gm-Gg: ASbGncsYNn5lz8smqgVhJaag3RNk3tFyh5H6EPw/Y+Z/3FfZi9OJbx4SoZ+pAMuibJ1
 8axbKhu+87C9f/4hLnfNVdMWLJJoXC78OurUeKWXQ3AzzrYbojC+rPzpEo615Twf9sFh6iYKw2q
 nrnz2+V0wNgGPmZUWKTv8XbufAF9CUFRX2PxLujZ8zk5ofg/5P5bUSkndVmeHLMNg0kQmnSdq3O
 NSVavc7yvihhCU92PUyaBx3j/HPyw9pLSF+9Kd+opRji7TiXOMbgIMQlnnbcXe0iWP8TuU0Xiu0
 eCVCRZafQu7CeP15KAG6bFgyWtIqPKWe6crChAcJFTr0UZ4P/XwQefZVMAzuSgWj+dd+y4lsqxL
 bEP4=
X-Google-Smtp-Source: AGHT+IEX2DI7JYStwQFK2tnGjXV9hjUYzpRNHJ9YmF/RQgDa8LaMNs3abLEmTZxKc0gZb0Wm1buajA==
X-Received: by 2002:a05:600c:34c4:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-4533ca55a90mr96777105e9.13.1750082799247; 
 Mon, 16 Jun 2025 07:06:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/arm: make cpu targeted by arm_load_kernel the primary
 CPU.
Date: Mon, 16 Jun 2025 15:06:27 +0100
Message-ID: <20250616140630.2273870-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Clément Chigot <chigot@adacore.com>

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
Message-id: 20250526085523.809003-2-chigot@adacore.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/boot.h |  3 +++
 hw/arm/boot.c         | 15 +++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index b12bf61ca81..a2e22bda8a5 100644
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
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 79afb51b8a5..3c93d879857 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -744,7 +744,7 @@ static void do_cpu_reset(void *opaque)
             } else {
                 if (arm_feature(env, ARM_FEATURE_EL3) &&
                     (info->secure_boot ||
-                     (info->secure_board_setup && cs == first_cpu))) {
+                     (info->secure_board_setup && cpu == info->primary_cpu))) {
                     /* Start this CPU in Secure SVC */
                     target_el = 3;
                 }
@@ -752,7 +752,7 @@ static void do_cpu_reset(void *opaque)
 
             arm_emulate_firmware_reset(cs, target_el);
 
-            if (cs == first_cpu) {
+            if (cpu == info->primary_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
                 cpu_set_pc(cs, info->loader_start);
@@ -1239,6 +1239,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     info->dtb_filename = ms->dtb;
     info->dtb_limit = 0;
 
+    /* We assume the CPU passed as argument is the primary CPU.  */
+    info->primary_cpu = cpu;
+
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
@@ -1288,12 +1291,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
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
-- 
2.43.0


