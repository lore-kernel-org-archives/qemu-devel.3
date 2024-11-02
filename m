Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BFEE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0l-00035G-2l; Sat, 02 Nov 2024 09:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0W-00031w-Ro; Sat, 02 Nov 2024 09:17:37 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0V-0001vl-Dv; Sat, 02 Nov 2024 09:17:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so3637984a12.3; 
 Sat, 02 Nov 2024 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553453; x=1731158253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSUXdq93xqCIzRVUO2sgZ5ZRdMkGuWMIHhF5tQTYyjM=;
 b=GpNQd3URHhYBFKKzC8pM3uRGkgJk63PNl01wPUAn+DaQiWWmZ2m5dcuK5OUBiK3q+u
 DIUSxmHlh5NQ91Z6JaVYsJA8PLSJuzCXi0c4gtlo0hpT0x2oGC1iNTR1EEdiO6kijJ0C
 chW8tmeCxNjP0W5snJIhzS8ihGjVfepIEofPegu5EriB1xGMJPdUaI6/L0mQz8nfivxg
 qHK5GaSpoM1DkSSOudjmE9dEaqvbmR+QUoDbfBLF8Bezi5Yk3Mp5I2cEvC4JTtR1Tl5T
 b1c801Cpd3yFb09Ad3zZiOzFsqoXQf7zgnYLkdmMX8ei/Wsqgd1F8WFojybWi8l6jhsY
 XfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553453; x=1731158253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSUXdq93xqCIzRVUO2sgZ5ZRdMkGuWMIHhF5tQTYyjM=;
 b=Y/xDjZUZZk6MdVa60Slduww6II+j3SKXbdmBawtCgQUoKkxvZti2CQyYLGhHvF5Vpr
 P9I5lORMfbDxSseuz3WN8yiCOiumfcHwijdJwNbbbSY+JrUXV3gc0/NyxEsAJr47Wjh+
 ePGhcXW/bMmI4uahdMwtDmGp+lwhb09mz6fGJ9qgDuANWYZCcMNSiidb63A2li9DZVoE
 MV9gSo6RFKFksK+4+U6Y3Yocr6odhqqzV4r778/82X5H01Zl7CRx/PVtKQSTeZwoPPyB
 fPhijCxMsudwgE1VtyZXiP8GGyIZR47STpALzXfWHzt/VMFm91aK9Iz6eHkrYsk/uLim
 fm1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCntg48hLDW4WQKGBoEGliT7wUQjxzEUZsDF44J9OABw1SnpFw1ccv87XMNtDWdXvu9CttfUDAqvc=@nongnu.org,
 AJvYcCXqRhEXDguhDTZ8gDyBjJqv3NLECYYtgLA0/cWsV/U8aqiuavGhq5Lu92y07H4WkYm34uWTx6KEv8A/@nongnu.org
X-Gm-Message-State: AOJu0Yw/fRC+lkBANSM+dDeiuhv2dh1POT+Ciyqiwk2jHqkqhoJBgnhP
 DnxiX0TvMaD4dyy3sARS0KGgLe+ZZNlT0t64mcj27HDDMeL0ryFFw/tHCg==
X-Google-Smtp-Source: AGHT+IH9iMH8Zk6eJd0GZHF92V5rajOnLefPmjJoVEEB5eOKd8KPpQDyTXQlQI4L2GZFB/Ga/wCTrA==
X-Received: by 2002:a17:907:2d0d:b0:a99:61d1:348f with SMTP id
 a640c23a62f3a-a9e655b9703mr610653366b.52.1730553452566; 
 Sat, 02 Nov 2024 06:17:32 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:31 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 02/26] hw/ppc/e500: Remove firstenv variable
Date: Sat,  2 Nov 2024 14:16:51 +0100
Message-ID: <20241102131715.548849-3-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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
index ba83f33033..0683629ac0 100644
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
2.47.0


