Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E33E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2a3-0003iU-Mf; Wed, 18 Dec 2024 17:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZI-00038b-ML
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:02 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2ZH-0003FV-6R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:00 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so1692525ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561058; x=1735165858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glX1WNaZVg1PdlZhn4XDQ7Ut5WPNd/6zc0BskqcuADM=;
 b=KZx4eS7oszlHVhSyIqg01W0iePDGzmgRtNkA8D6Hme0rwWpCmAI83kXoKLemF2GPHy
 MzbH3n2EJ9xlwvtIaBZHCuXP2a22FVk18kmycwlKTiQgZC93IT4WCHxGn0FZiZQb6OCA
 BQHYZjr7hnAGC3MOhEbDtRB4JlP+aImuWv2bsp83WmkeqFvvc1AA29R3jdbma2AjJLdb
 OHldKJxnW4ndLQQciP4Rt8zQlSLOxmzKnc5/sDeTKNnf4CyGWs2Ampv1GbAtn3v4dRtp
 oz5XM005c5XhXhXESZuoE142IHvO5Sv5jzKLuVoNZIoaz91cQUcdLodUHOrQYi+4ohph
 0ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561058; x=1735165858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=glX1WNaZVg1PdlZhn4XDQ7Ut5WPNd/6zc0BskqcuADM=;
 b=cp+jOhh/PWNsEpdN32jXTSiKV9BvkxAGwgWV/H+r2iW/omwRskfwidbaJviouYb8Au
 /bxlfr5o8y35nRs9Oy+ZinKbd+7rMYiYObk8nSCmYxeKBfuSn1N/NKEMU4HRXc8yTiKb
 IvHi5xG9JKejTzNhqKUjXandXjOV1nhTFKcdmZsfGOydeAfOj2vpBPOvVH1CojjeImg/
 HVkQqEB6L0LF2kkGIORZmJzO/fIrHZf8N0TgaFhzwe9s1VM81nJBm/xWs+AJl0SmQ8Ew
 Wru6TvDW0QZmPkmNhDXL0PmoXc2HkkFBD2cNFtwT9QwC/gWizZh13GazGhoFPxAJViZW
 kBhw==
X-Gm-Message-State: AOJu0YxWO/AWJWU1dUQLljsp2N83O0EeqP7aKjkLnJM8Jnf5QgbEzBQu
 BsDU0+6TYzp4Kipua6STfj97vf171q1iFzYXqZKa4du6f0lNcBXmN1KQ4qYI
X-Gm-Gg: ASbGncvodek2LJOlfF6EwiUO4WJODq1qiKEi3Docjr+4/J+UagF1wOZz1LDVgBS/cCx
 GZ0KjwJpd3cPwpNJttIfeePzIurfR56YpxfhAuW3/8NkLFdvVekHJXPmiPh6AoK8M/wH+yLcLtP
 7v6/UQBjf9FmirWAi1QqJrcH51GUYOiy8TYpAqQ1PS4cdBGi54BmC1F29es8WPnjRUhS9tOZReI
 DBsreWfemRyluI0UadnFFnxOlNx8LAtZs+fhZHy3uokks8nWwLozEKr1/HR9Q+Eeo70FKou16C3
 Y86OJApLlS477bZYIiWSIM7msnsgE4VODT4DpGeSebAtNBBy211PyTMXgU5R2qU=
X-Google-Smtp-Source: AGHT+IGrxtM9RkaUyKaeuJIAe4OLayFMp6q9apB7e7BfYRKVdrGG5vxMHBdEdfRXUlePvc8rL8UFzQ==
X-Received: by 2002:a17:902:f54f:b0:216:760c:3879 with SMTP id
 d9443c01a7336-218d7273bcfmr62683755ad.46.1734561057659; 
 Wed, 18 Dec 2024 14:30:57 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:30:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/39] target/riscv/kvm: consider irqchip_split() in
 aia_create()
Date: Thu, 19 Dec 2024 08:29:44 +1000
Message-ID: <20241218223010.1931245-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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


