Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB16CCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk1-0005Gz-VR; Sat, 05 Oct 2024 15:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk0-0005Ex-8W; Sat, 05 Oct 2024 15:47:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjy-0007cH-Cz; Sat, 05 Oct 2024 15:47:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so2347901f8f.0; 
 Sat, 05 Oct 2024 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157616; x=1728762416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYmazEU3qUCGZ66Yek0cGHflV4Zj7SZa461SxhER5XI=;
 b=DSwxMiGj6CcyILn27qfFBd4PgSmkyGllVwlCNaziFyvqbhGq8N0qSfdCRFBSt+/Em0
 nVvO6T4ahvgQyy/0hSP7LTEfkNQNEj4vJWZ5w3qENBnpGas3eADRTQsxHf+f3wM9+Xwi
 WjzpYBuVTOH4M9vPDwqvtyNRP7woHR2zi/YSc0zRjWoCwr12jybufIF7C48sYXDjfr66
 dANbN2NNi+rIQtWFEWAweY9TknXgH92mZADgsk0M/lQ5fYBeY83RnwSFXkBLJ5sNhKFu
 xfoXnF+3YaOARGlwN23mUvJXbrdQGci3W5i3/eH8Qrf9OloRFYzr72Jmbr2V3Ux0oZ7F
 umAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157616; x=1728762416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYmazEU3qUCGZ66Yek0cGHflV4Zj7SZa461SxhER5XI=;
 b=IvYbMTdT5f8HCAaagSGfO6bwpwc8HPXXGBNH0UinO7VUCoVKXPvEaOAIhHtnE35Yzf
 ymiu/xt7FwodoPyOTeMeY1JNzYe4ZkFhmIsW1Pc2jxh8ZC4tz9569RwOCek3/ReFQAPm
 JQkyLoH2xZMVbxDO5F8/awCvmIWcsJqW/mH5MKWwF7nkUB3+E1/0aFI/Lq2KW0Px4hCi
 wGol+ynOKVIG9y5+uCv9l6lA3ecAe7IOlqHMosXBo/w6QOsPRBZMWYI0/8V9dsLSA9pS
 2bxzq7e5bQBhpQ8Ycami1Lygudk22+ey0MDTfoo2ivPOAph5MOjQMckAAvr75MzQ7/zH
 927w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyKlNn+YsFvbilI8PWXUc3jU+veEclAFQzdjPj9DDTznjrIKUyoLHQwpAVzCUq1K3CfcWbjhVKcUs=@nongnu.org,
 AJvYcCX245mZyOAU4P6YpHAeGM6Enz+0i/HnAItIPcpBzh6zYgikyzs2xq9MJu5dRP/Kb1wIh6Q2+NPa/u5/@nongnu.org
X-Gm-Message-State: AOJu0Yy3FYowvN29dhH8tBCWqz/MxlQn+VXQ+37a+J8i/HSTbC4YT/C7
 s3CgFqyiYNT6d9i+CgPOvLo7EQX8R/57RyN2hukr5T5dGCqvZoD14TPQJw==
X-Google-Smtp-Source: AGHT+IFSI/0G9gVw12QLVvDnp5sSVKJ1jiHXw6CXivYnO5OxhXg8iW899DatuFN0nLBUssoJMa5CXA==
X-Received: by 2002:adf:f4c9:0:b0:374:c7cd:8818 with SMTP id
 ffacd0b85a97d-37d04a576e4mr6458872f8f.22.1728157615482; 
 Sat, 05 Oct 2024 12:46:55 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 02/23] hw/ppc/e500: Remove firstenv variable
Date: Sat,  5 Oct 2024 21:45:42 +0200
Message-ID: <20241005194603.23139-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The firstenv variable is never read, so remove it. The env variable is then only
used inside the loop, so move it there to restrict its scope.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 75b051009f..f68779a1ea 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -899,7 +899,6 @@ void ppce500_init(MachineState *machine)
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_CLASS(pmc);
     PCIBus *pci_bus;
-    CPUPPCState *env = NULL;
     uint64_t loadaddr;
     hwaddr kernel_base = -1LL;
     int kernel_size = 0;
@@ -921,7 +920,6 @@ void ppce500_init(MachineState *machine)
     IrqLines *irqs;
     DeviceState *dev, *mpicdev;
     DriveInfo *dinfo;
-    CPUPPCState *firstenv = NULL;
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
@@ -930,6 +928,7 @@ void ppce500_init(MachineState *machine)
     irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
+        CPUPPCState *env;
         CPUState *cs;
 
         cpu = POWERPC_CPU(object_new(machine->cpu_type));
@@ -950,10 +949,6 @@ void ppce500_init(MachineState *machine)
                                  &error_abort);
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
 
-        if (!firstenv) {
-            firstenv = env;
-        }
-
         irqs[i].irq[OPENPIC_OUTPUT_INT] =
             qdev_get_gpio_in(DEVICE(cpu), PPCE500_INPUT_INT);
         irqs[i].irq[OPENPIC_OUTPUT_CINT] =
@@ -974,8 +969,6 @@ void ppce500_init(MachineState *machine)
         }
     }
 
-    env = firstenv;
-
     if (!QEMU_IS_ALIGNED(machine->ram_size, RAM_SIZES_ALIGN)) {
         error_report("RAM size must be multiple of %" PRIu64, RAM_SIZES_ALIGN);
         exit(EXIT_FAILURE);
-- 
2.46.2


