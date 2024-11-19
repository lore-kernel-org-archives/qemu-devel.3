Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3941D6C287
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTj7-0002k1-P8; Tue, 19 Nov 2024 14:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj4-0002jE-VH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:27 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tDTj3-0007dv-Ff
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:17:26 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-723db2798caso4801232b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1732043843; x=1732648643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFpahzsVJtnI1jlusgbxiTRns2vx5vCUwt4fV8qKZAY=;
 b=YyqQ/fajTT8c8Wxu1kU5c9aUTdex9ApcqqpGUo9Qo3iefnJUeQ+kDA2qycZ6CBnTnZ
 l3yF18f5cqB034mjg1jmUmUCDASnvPoMryEFEVKOpXIV48bFPUCADIlnvJ4mn9I2G9sa
 +hKvYpUXFP/AvZUFZwtNj3hR9t85c/bXfF6WFH3EYVG/s5igcPMIcRQg0mIkFk9YWTOF
 +Uw9fMit1DggifCLvcugiS3NS4hTgD4TXQCXwMDfQM7D3zZ6mBkxeoFrJMJexxs9Thmt
 ScN0M+ULqQQh6NfPfxrcA/zu0kW45XlqmJ47AZAUGSAD3f1hD+i+ukeiX/T7bti86yYk
 l13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732043843; x=1732648643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFpahzsVJtnI1jlusgbxiTRns2vx5vCUwt4fV8qKZAY=;
 b=tWkpJEOyB6HO/FyLWqU8u8N9nrBY0P8bMGf9iw/l54fdR4VlgI+obMcyzpi8QZqcHp
 6x3pbY3IvNYKIGJ9amjHPonp+evAVsy0EpLEu99Pkonm7es0pHxtrs5WvH/Z90jl/tFb
 YuLTKnT6mMNUqpx1IADMEImY+iAVqB9bavlJfeFF/74BZ5/6eCP6PI1GUc32W+LEqWcs
 r1IonUgLhxNG0W71R7VZnB1qZb0+d/3sekRFD1UICtllyWOaqnQg8lSRA9wMpkSh8T7e
 wbT3Rl8MnmKoxWODHI5mil57qpXxd3KKAFsiQOmICrAjZ3dn0xRR5L4AGRf6maed8B+w
 dLzA==
X-Gm-Message-State: AOJu0Yz8NZdbGcX2Evugpbzt1pSapZmW2SFCN7BYLmA2BxFZAWjmXw1n
 au/VyUreRfxxVfg6rxTD4Z+MaEDFWf7qAzlmrjpdeAmoP9Dp/hmdPBAyb4MaRcRl/Ppg5tnuLoV
 v
X-Google-Smtp-Source: AGHT+IEw2vSpxNg2KPu5e9uAY7tHDToOHkc1gwHplVYGS+E/PphGGpyPjjxfJut/TUppIXMxo9ZQyQ==
X-Received: by 2002:a05:6a00:3d07:b0:724:67dd:2615 with SMTP id
 d2e1a72fcca58-724bed54619mr157465b3a.22.1732043843494; 
 Tue, 19 Nov 2024 11:17:23 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724beeb82f2sm24271b3a.35.2024.11.19.11.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 11:17:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 v2 4/8] target/riscv/kvm: consider irqchip_split() in
 aia_create()
Date: Tue, 19 Nov 2024 16:17:02 -0300
Message-ID: <20241119191706.718860-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119191706.718860-1-dbarboza@ventanamicro.com>
References: <20241119191706.718860-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
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

Before adding support to kernel-irqchip=split when using KVM AIA we need
to change how we create the in-kernel AIA device.

In the use case we have so far, i.e. in-kernel irqchip without split
mode, both the s-mode APLIC and IMSIC controllers are provided by the
irqchip. In irqchip_split() mode we'll emulate the s-mode APLIC
controller, which will send MSIs to the in-kernel IMSIC controller. To
do that we need to change kvm_riscv_aia_create() to not create the
in-kernel s-mode APLIC controller.

In the kernel source arch/riscv/kvm/aia_aplic.c, function
kvm_riscv_aia_aplic_init(), we verify that the APLIC controller won't be
instantiated by KVM if we do not set 'nr_sources', which is set via
KVM_DEV_RISCV_AIA_CONFIG_SRCS. For QEMU this means that we should not
set 'aia_irq_num' during kvm_riscv_aia_create() in irqchip_split() mode.

In this same condition, skip KVM_DEV_RISCV_AIA_ADDR_APLIC as well since
it is used to set the base address for the in-kernel APLIC controller.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c53ca1f76b..a9680f2447 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1734,13 +1734,29 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         }
     }
 
-    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
-                            &aia_irq_num, true, NULL);
-    if (ret < 0) {
-        error_report("KVM AIA: failed to set number of input irq lines");
-        exit(1);
-    }
+    /*
+     * Skip APLIC creation in KVM if we're running split mode.
+     * This is done by leaving KVM_DEV_RISCV_AIA_CONFIG_SRCS
+     * unset. We can also skip KVM_DEV_RISCV_AIA_ADDR_APLIC
+     * since KVM won't be using it.
+     */
+    if (!kvm_kernel_irqchip_split()) {
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
+                                KVM_DEV_RISCV_AIA_CONFIG_SRCS,
+                                &aia_irq_num, true, NULL);
+        if (ret < 0) {
+            error_report("KVM AIA: failed to set number of input irq lines");
+            exit(1);
+        }
+
+        ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
+                                KVM_DEV_RISCV_AIA_ADDR_APLIC,
+                                &aplic_base, true, NULL);
+        if (ret < 0) {
+            error_report("KVM AIA: failed to set the base address of APLIC");
+            exit(1);
+        }
+     }
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                             KVM_DEV_RISCV_AIA_CONFIG_IDS,
@@ -1781,14 +1797,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_ADDR,
-                            KVM_DEV_RISCV_AIA_ADDR_APLIC,
-                            &aplic_base, true, NULL);
-    if (ret < 0) {
-        error_report("KVM AIA: failed to set the base address of APLIC");
-        exit(1);
-    }
-
     for (socket = 0; socket < socket_count; socket++) {
         socket_imsic_base = imsic_base + socket * (1U << group_shift);
         hart_count = riscv_socket_hart_count(machine, socket);
-- 
2.47.0


