Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10D1E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSEz-0006GQ-8B; Thu, 19 Dec 2024 20:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEs-0006F6-Jp
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:42 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSEq-0004Ty-WA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:55:38 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-801c7e6518eso926367a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659735; x=1735264535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glX1WNaZVg1PdlZhn4XDQ7Ut5WPNd/6zc0BskqcuADM=;
 b=Wtg6Clsp50MsX3c7rk/xcy4HvqsQpX/R5D7E5gX1gxmb9anX1en5IXYC/saGbw3t3U
 dBT4oR6abfq7U3gKiUR32+K3abrR2sXPDzdCeoxFChlSqzj1Kltxz8Kh3qZprVSbCQMU
 u5pnVrUv7Ar9tUdBXHJG31SGOHEwkIF6GPJ5DqhKhNJLhb8+f7ZehnJLZje9fH+WcPrC
 DAwsxdjM8kM8rHTxPm22fJYkKlSxPVc0QG8nHoMwAQTGuUkhzqrDFRR9iHkVlVpsCY29
 IgYugNL3OC4aFqNPB7NllhveO82xmbJx/m5SYh9j0r5tpvmLHEObOx6NSkvLAMCRoLNy
 O7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659735; x=1735264535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glX1WNaZVg1PdlZhn4XDQ7Ut5WPNd/6zc0BskqcuADM=;
 b=M+Uig1ra3ryEi5K7PV+SVELgpOYEuycn0rh3QGDgEzJTrbJeN/zRfTkifU0ao30mbZ
 T2dtAvgXgHZ6ke0fjSMJzyV/eTsl0wyTiNgLuBZYQuuEUb4WHqDxS0LnJwQii1HNK1jI
 v9IB0h1CYgwB3fBGqrbzHFI7PRqnXTglioVC0WDV+Z8kN2CALXCT39sYzrsAar6kAtp1
 dseLizGJ4cFVMJE96DbMRYLr5KZuHeqIldoctztMOqReTVp0d5La8IgOuka7PAYywgsv
 fVBu3tNAlIGUrgSPcScFJjxHx2FJ5ybtinFqOb+wSCwWqkYa1Lwf19VdH/u2ZrDrq4yf
 e54Q==
X-Gm-Message-State: AOJu0YytKI7r8Dsacr7L+35mzeucos41hDo07ZJk8FLRL/YEwNSnQdzU
 OAOwlzJoLzC4Iub+Z8ZWOoA0NxBby+2A5HeDJrTKnxwmq4qeSzwCEw1UT4zW
X-Gm-Gg: ASbGncvU0dbaPI+pxyKaxEZj6f1QYbuDvQOyTkM7bzQoUW7RDRGfgoCRZeFhbmMjySd
 0dDtp09MAMo/9rFKvdmibwPqtgDOWVF4/zBTNO+LGfuJhEKSyWfJwfB8rXEOYdrvkPAOlHQQplH
 OZImSqqh389QFatYzTLaooJADJCu6kbFUd7pFVY2O7crfzlzQuFBKX1q2PV7XUoPXzmuV0fODFH
 cz6ERTcK+pkMAhkzNaWJC1XRflIcf9VCrIJod9katFF9DQvLEB7Qy0PkmMLJTGV3DqUlyAKtYxU
 Y4ntecewRWR1GiEi0WR3k6qttEr38biHlL9kVRhLLbl/ChKGdVtzLGWnCrPwJlY=
X-Google-Smtp-Source: AGHT+IGe75LhePSRYCPbKaMIY4mZEjyfTAbm3yhN6/uLCEMOiqdkvkGIufb8OXqMwe+R9jnD3MBlgQ==
X-Received: by 2002:a05:6a21:2d8c:b0:1e1:c943:4e8e with SMTP id
 adf61e73a8af0-1e5e081ee88mr2201442637.41.1734659735502; 
 Thu, 19 Dec 2024 17:55:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:55:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 14/39] target/riscv/kvm: consider irqchip_split() in
 aia_create()
Date: Fri, 20 Dec 2024 11:54:14 +1000
Message-ID: <20241220015441.317236-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

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
Message-ID: <20241119191706.718860-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.47.1


