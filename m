Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61FC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4g7-0001q2-0A; Fri, 13 Jun 2025 09:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4fi-0001iE-UZ
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4ff-0006GX-Gt
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:42:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-450dd065828so17499265e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1749822133; x=1750426933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWZIDBLsFhdR8GCNkB2CqLPUwwJ7URlhmr8AdedA46w=;
 b=jV+IU1xjMznxwsaYwDQOBPutJ2XMlPKvK6WEI3WOlsxJDSRGl4SkWAYPFVTiB+hVl5
 pZJ1fYPXLGM4cftNldiGlKF+flUt1glUJ11Jpi49ZkKGbp2etthFZbdcf2hrgzVXFmEn
 mpedvJAXQF1CD/pJgxJkjqtnNlPn0ejsxxxFubih5YUt8c8nyrgKaJOp3IHwU2E7LTtD
 PXHz1K+dkCuUs9SKUl/0pfPKPxKWti/lttRU4iL3VUhLgVwqlA3TfqP18vG9bF9dJQMi
 RmsUjkv9BK6pFjd1DF5pZkddtEXO+StoemruFxpz0A3so6O7kYbqE57L6LLdIKmgr3H7
 8Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749822133; x=1750426933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWZIDBLsFhdR8GCNkB2CqLPUwwJ7URlhmr8AdedA46w=;
 b=nKfDrJhGXwLgM5ej27DJpIv1d9DHoo/lbPFkeQFitgML17TM+GLqU6pIn66pdxS6xM
 pL7YuEHJV2chJth7BkxYv5iUpapUI4fmtw21n62w8/Hn+eOf3wlRHkcn+BXfRHf+CUEw
 XK3iEekIZ783iX8gFyYwMt0M50XqH3ckxRiJfoJwA8srxIGkYbwYtkpicwW2m3PwIbLW
 7eWkIppsAbxglLa9SffhoR31jw0xcSYETtJosgpPd8FdMSfhvATckrVOa36yGnlwFp7P
 IKZCOZluYbc/JLFL8srl1NpF2+smzOfa/OCN+Y5HvMh3wk+D2wEmpFKP4B5TWy++ZTHj
 eZRA==
X-Gm-Message-State: AOJu0Yx3OIE8DWeNZuuJPcJ7OamNYV+uol1frzZheAlRRjTfXrGH53DC
 0VSYs1IJ9w1jlPh+XiTvlRmGCzNErmNDtDkXoGuODnYGhwt0TyqFe2KR03pyqH/GGtZrqmR9KYm
 1WaQ=
X-Gm-Gg: ASbGncvF1RS0pWYxRyU3TqvSg2ci9Mw6AOhSt+qpTA6y01Wt57sefVqPBsBI/7EfVKJ
 4dn7pM5+YK6BpMnMKNPh5Ai7CnH3xhouWkPbTLFWHtKdxX5g3nznV7OjcYsSzXQZHKH1Fg1x8w0
 BJnNFw7qMrH1jK4ttfprWDd99o/x3CnbQhDor5c1UXq2rVxRUVfhEjfZQf2/fhd/57sxZZT5E5I
 QQIVYK0ALGz/6uk+t/89lqOcLX7Uh4GueToOB3v8Ph49eX7gq73v/sWGxV3LyiMhy7D94QJL0aD
 TI9+3E6eBEcmUiTi8h0RFaCHElDPNRBS8x2jTovuj31Sh7jcU8xVt1oQ12s4dnBFCmeELYY=
X-Google-Smtp-Source: AGHT+IGDKkhaJdWsplV/NODlTd3qrSVom6X+jZ2Qa68Lno8nVrKB9Moia/dUCPgefqQJijZiyR3Sdg==
X-Received: by 2002:a05:600c:4fd6:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-45334ae6432mr34861245e9.16.1749822133566; 
 Fri, 13 Jun 2025 06:42:13 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8100:3d00:9e4f:bbb8:63a3:78f3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224795sm53258035e9.7.2025.06.13.06.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:42:13 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 1/3] hw/arm: make cpu targeted by arm_load_kernel the
 primary CPU.
Date: Fri, 13 Jun 2025 15:42:06 +0200
Message-Id: <20250613134208.1509436-2-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250613134208.1509436-1-chigot@adacore.com>
References: <20250613134208.1509436-1-chigot@adacore.com>
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
index 79afb51b8a..3c93d87985 100644
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


