Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EAFC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 15:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thW34-0007GI-5a; Mon, 10 Feb 2025 10:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2j-0007Dq-51
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thW2h-0004hV-Ep
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 10:49:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so50859745e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 07:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739202590; x=1739807390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hQ//IdqEgE6/omsnCXSjledOx7ZAm6kjJCgkts3JmS8=;
 b=y9XY6+OE3w/wkQV5xKLnVRLHfE8RR628Tmoxga0YOAHfDnvgMPNC7Ekzk3rORnMS6G
 xD10goKctOE0M+MxVLpdP7X1Yr/3b6A2kjeCBPypyRHRsJpmdYJhZIGUa+6SmEe7dsbV
 c90zmgNVD3FZlOL1n+c3lxc1FN68LXHl9mG0RDFXQxJChyHsF1Cwd+3vlhNG38XVYh6W
 BqfHhl+RCRABvro9iQIyYmdNMKoYLZkAf4lxV2cqz+o9tVnUsRf5lgRdkN5fwVkTsHye
 qjccL9tr1Ldfdy9tpuuWIdUYJvhliA6ZXXZXiqVW6osnaHYFezAI8Y1B6/vVINyOpgtx
 GmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202590; x=1739807390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hQ//IdqEgE6/omsnCXSjledOx7ZAm6kjJCgkts3JmS8=;
 b=wXD37zfSf8Yf0b+/SEoFYUjce3E4UMVD2PUbwK8IJXP75vw3TJ/Z0yH1eHk+WMI3DX
 G9pjL8v0iq7aSQ0dlO9kkuJkEg4WzXbbsp9EebCFWTfcupKL7Yrl1sblnttPvOhZkxJq
 a0N8CoOjlj4AepXCSm/K7fLB0frf4SvYWiL6PtvKzc6MOvJ6c5EaXzuX43ckaNQj0r8N
 Jt9EjJnqtDHMJR9/qmA11dkszpzWtyTj8vyotjYeKwcj5pfF/GtAbqhUOBoqF6K6cqKc
 Qi3ppL0ZEHr1N29pZ6nMXu6Ie+KDLSaXrzKiV8SqaSuhsk9BnehbkPQpewNBObrHszr4
 twdQ==
X-Gm-Message-State: AOJu0YwX7H3r8fVm8vDEb8FaqZZVIbojxd6y/YCKQikBpRcZ72O+hIOy
 aNqpSizKy9kZ03MWw68yNfB+8BaeggsjRjZTixH2u6gPjUxUT0+xZ2So9KSSVWPB5/FkGQBNl78
 u
X-Gm-Gg: ASbGncvToljLyAXbtPPP82TCMSFdDnDWP8FKTi/C+B+x8eK1fmHOEKucQX6qrL7ctl0
 VtumkjjGptwEBrtwciCPUWxGnxtz+ePOVtL7cszyxPpMaGcEJ+oDlGZGGOtwEw8AMR4UK31OcN6
 Tm63kv0Pioi3+xeuxOkZaW1SWEVklwtyljrnf/Qbrj6U4h4yf2rSgJghScxiGC/hblIlU8BteJs
 N7om5+KcxO4n5EsE1hLiZx0Of6feAzTDjHib/At4+bbqKZE6K2UILGlHOqqVP+cn6Ee4OvXic4V
 OdFfzAYQ3qVFforfQaiE
X-Google-Smtp-Source: AGHT+IEFuStf5tJHf9n6fJSK2KZChOwV46Jb6Xwo4AAvRtvvtjwKnzScHupEWtexHy+KVHAcNMoHdQ==
X-Received: by 2002:a05:600c:4f89:b0:439:4b9e:45fc with SMTP id
 5b1f17b1804b1-4394b9e4883mr13260275e9.4.1739202589755; 
 Mon, 10 Feb 2025 07:49:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm150612845e9.38.2025.02.10.07.49.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:49:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] hw/arm/boot: Propagate vCPU to arm_load_dtb()
Date: Mon, 10 Feb 2025 15:49:34 +0000
Message-Id: <20250210154942.3634878-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210154942.3634878-1-peter.maydell@linaro.org>
References: <20250210154942.3634878-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In heterogeneous setup the first vCPU might not be
the one expected, better pass it explicitly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20250130112615.3219-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/boot.h |  4 +++-
 hw/arm/boot.c         | 11 ++++++-----
 hw/arm/virt.c         |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d7421..b12bf61ca81 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -160,6 +160,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * @binfo:      struct describing the boot environment
  * @addr_limit: upper limit of the available memory area at @addr
  * @as:         address space to load image to
+ * @cpu:        ARM CPU object
  *
  * Load a device tree supplied by the machine or by the user  with the
  * '-dtb' command line option, and put it at offset @addr in target
@@ -176,7 +177,8 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
  * Note: Must not be called unless have_dtb(binfo) is true.
  */
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as, MachineState *ms);
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms,
+                 ARMCPU *cpu);
 
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index cbc24356fc1..42c18355e85 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -432,13 +432,12 @@ out:
     return ret;
 }
 
-static void fdt_add_psci_node(void *fdt)
+static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
 {
     uint32_t cpu_suspend_fn;
     uint32_t cpu_off_fn;
     uint32_t cpu_on_fn;
     uint32_t migrate_fn;
-    ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
     const char *psci_method;
     int64_t psci_conduit;
     int rc;
@@ -512,7 +511,8 @@ static void fdt_add_psci_node(void *fdt)
 }
 
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
-                 hwaddr addr_limit, AddressSpace *as, MachineState *ms)
+                 hwaddr addr_limit, AddressSpace *as, MachineState *ms,
+                 ARMCPU *cpu)
 {
     void *fdt = NULL;
     int size, rc, n = 0;
@@ -655,7 +655,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
-    fdt_add_psci_node(fdt);
+    fdt_add_psci_node(fdt, cpu);
 
     if (binfo->modify_dtb) {
         binfo->modify_dtb(binfo, fdt);
@@ -1327,7 +1327,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
      * decided whether to enable PSCI and set the psci-conduit CPU properties.
      */
     if (!info->skip_dtb_autoload && have_dtb(info)) {
-        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
+        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit,
+                         as, ms, cpu) < 0) {
             exit(1);
         }
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c5..d23b14718af 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1746,7 +1746,7 @@ void virt_machine_done(Notifier *notifier, void *data)
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
     }
-    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
+    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu) < 0) {
         exit(1);
     }
 
-- 
2.34.1


