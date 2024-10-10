Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B37CFC5F7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syySC-00065Q-1o; Thu, 10 Oct 2024 15:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS6-00063a-SO
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1syyS5-0004jO-9u
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:03:58 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71df4620966so1205180b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1728587036; x=1729191836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHs6BVOnj+BBK5pRrpEWmqd66QRch8McjjRjElv9XFw=;
 b=jfg09fap2F2QRN1rbW3u8fHDeMwh2pfJuu8DYhuNbDB/ARVp7kCDy8sxXbq0W0gDjt
 q1Zux0r7dGgxUWjNZM+ZWbrpO46pLs9DSFWtdKwafsqKls+DS+3cDFUC6+a5NyUMe0Gz
 LESoya/DqzwXjrpYb9POcNeDy5pkiT0FxMdCi34Ve8XBRaP0nghbUyLIL9IHc7yyrh+R
 kmvletrDubCkTWLFTPYT6k8ezcgoWRthxpBWV/O7xIRjLQWx8vKo2fc6ZMMlfyZhO3hy
 7d9DiNlQ8EvYKUgapv4hTKAs+NFv8CO4GosYA/B+q8ydEsU075ityKNlHVJB6fVb1MaD
 y+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728587036; x=1729191836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHs6BVOnj+BBK5pRrpEWmqd66QRch8McjjRjElv9XFw=;
 b=KTwDDrFPl2+hIJKiGEJrlc9WfHpwa5cX6o/9GSkcxaCyLtTND9CtDItRBysKylX6vV
 eroN5MjBgU3d4QY/b5GRxNAJNSs5/l5f8O20wYtlXt/LzL03Q9VMdyW7djJhPS1HPKLq
 h4ZEI/LwnugBByfoMql3/KseYUijjVDVk47nA64QBbpZkvkVVxASmqyQY9EBOYuh/LtZ
 gJI6zz9e0/rQFJIWtkPxTXKGf+EKiMzvJNuXH3a0sOAZf3+or2YEhO0Rp7PEUrB9Zc5p
 1I+1e4XOS7idAkPcHZD6NThcnnLdNWmRmZl5gQq1LPmUMJm7B21JPpbP8ys7O2MGag4P
 lk8A==
X-Gm-Message-State: AOJu0YxiHAeOn/ggCi11+YjHyRyCuq3favz29xPxRa/N8HZIXrYE9hBu
 QZshxGzlfXig8tkjTxm65WSM+nemVF67g+c6tMQXZB4BaxYNe7E2gwqmuLocNhMr8OP2cXRvFue
 S
X-Google-Smtp-Source: AGHT+IFe3jApTiLPDOcbhJA8fxJb0b29wQph7TvBOs0pZSODuWvlneFMpI4agag4hlOuKMWc3q0ZdQ==
X-Received: by 2002:a05:6a21:790:b0:1d7:5a8:379d with SMTP id
 adf61e73a8af0-1d8bcf124cdmr20657637.15.1728587035810; 
 Thu, 10 Oct 2024 12:03:55 -0700 (PDT)
Received: from grind.. (201-68-240-198.dsl.telesp.net.br. [201.68.240.198])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e2a9f5263sm1354532b3a.62.2024.10.10.12.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 12:03:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/8] target/riscv/kvm: consider irqchip_split() in aia_create()
Date: Thu, 10 Oct 2024 16:03:33 -0300
Message-ID: <20241010190337.376987-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010190337.376987-1-dbarboza@ventanamicro.com>
References: <20241010190337.376987-1-dbarboza@ventanamicro.com>
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
---
 target/riscv/kvm/kvm-cpu.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 8233a32102..a92a46694a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1725,12 +1725,28 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                      kvm_aia_mode_str(aia_mode));
     }
 
-    ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
-                            KVM_DEV_RISCV_AIA_CONFIG_SRCS,
-                            &aia_irq_num, true, NULL);
-    if (ret < 0) {
-        error_report("KVM AIA: failed to set number of input irq lines");
-        exit(1);
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
     }
 
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
@@ -1772,14 +1788,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
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
2.45.2


