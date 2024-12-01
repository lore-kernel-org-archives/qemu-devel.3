Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B429D7360C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 07:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHe5p-0004Pm-C2; Sun, 01 Dec 2024 02:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tHe5o-0004PO-18; Sun, 01 Dec 2024 02:10:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tHe5m-0002xO-1Q; Sun, 01 Dec 2024 02:10:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a852bb6eso28803695e9.3; 
 Sat, 30 Nov 2024 23:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733037003; x=1733641803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z67w08get4bovTQQ1G5Ug+E+ZtU/ia88isv0wL6KP50=;
 b=av6umawJ73XhAgLWVMLSgnu00j+idK1bthBMMhO8gydhF2BHgruH3frjex5baEGD8g
 66hC+EyG5Vp0pqGkmQ6FOCYgKILBRjnS/DS+G6GU8qanoLPGPtisJFd52BmyZNS5b9Jr
 T5W/SKsMeWgymvq21+LM0mTu4puWjjq3MntK35pdMnUMypV+XrXB46GLrWdS4SSSlJ6a
 ksvx0WZgdTp9b/3XppRCeDqt/pLLzEvTNZ3XPeIr3skXC+R0r8VmcqfD+bRO3HvAVZ2M
 8RovZCNuD8cPd3I3lcIFAifRG19JgMLu6oGSWLT9Oai19+u/QtqgbhMwvJyCuwt+DsjQ
 yWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733037003; x=1733641803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z67w08get4bovTQQ1G5Ug+E+ZtU/ia88isv0wL6KP50=;
 b=byUCMdQcvllGya9spCm0KDnEE+P7LRctIUuDnl7bKoM5afWogzUgOH3qcTqUapXkfV
 pbTJayqzt1cFHVy2LtyOcUD8V8hseqib3o+SrKsPW48Hz0cCbXpuq/RsszHYO/s66kQB
 RSW4LbkZ189Ej3VfO96pIHKkukAkjpzGKCGoww/5LdaVAbwnLSXgRBgzHR7ZUMYiBPUf
 +pHyArlNFFzRLcaBXTA3wL64uYViTInGZgJi4DHb7VGxSyWYldxY54DE0MBlgyhabTCV
 wnPccMbzXWj4mcyKXI1wWI/UEFKv9s+pyyOYrtohNy5nsea3GljY86h/pMR8VQJhVGmk
 XPbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqq+1UklP7Ont/2sjyR4UZ1zCpYfqUgFaVSRA1Wo1No10X8zGPsudmn4/4paISuhDAD4a90MUtojKu6A==@nongnu.org
X-Gm-Message-State: AOJu0YwdE2U5mW9AVKxGH5SkPJkSGrkSFS3EdgbdtwPmovxyhxcJ9Cmv
 Anb0gLu9rKvE7WE4PtxiwtgLH2MB23yP3LZpe7oEBrRHPbn0e5uqi9wbDg==
X-Gm-Gg: ASbGncuRPcJOTFfacFJ8ag7AEWEdhnQAQTlB4ZeEoj0XrQhGy8p3+aaL0CEhSxHlDfG
 LHLI0mzW/R2KBq9MysWwSA1ZvLc0OlUuqjdT60dJiIkMl4kYEnp24AKncuTeoi5McN8cnyeSGMO
 ekLmOAzFIdfM75FRuO/2Ane6yQ1sMPLicLMQ2aNFG68PIvFvdAaX0VpHLkI2BilKIA5E/n3qsGW
 PCKNsEFzZia5t+ytlvrRI2u4HyZ0BvEG/z5x0kGKNzobnPZYBXAAr1BHE/sK+QPX666fQ30zK1e
 r6wMiSXfhqxzzw==
X-Google-Smtp-Source: AGHT+IFg7N5JM+wcKi0YoZkz7Fy/9bNuAEHz4Znsd4FugxQi3MvNp8nep1rhUBHdnYBZ5Amqouz2Ng==
X-Received: by 2002:a05:600c:205:b0:434:a5b3:8fee with SMTP id
 5b1f17b1804b1-434a9df26b3mr139259335e9.26.1733037002966; 
 Sat, 30 Nov 2024 23:10:02 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc637dsm106642085e9.19.2024.11.30.23.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 23:10:00 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-stable@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Jia Liu <proljc@gmail.com>
Subject: [PATCH v2 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as
 default
Date: Sun,  1 Dec 2024 07:09:53 +0000
Message-ID: <20241201070955.223360-2-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241201070955.223360-1-shorne@gmail.com>
References: <20241201070955.223360-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32d.google.com
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

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

We used to only have a single UART on the platform and it was located at
address 0x90000000. When the number of UARTs was increased to 4, the
first UART remained at it's location, but instead of being the first one
to be registered, it became the last.

This caused QEMU to pick 0x90000300 as the default UART, which broke
software that hardcoded the address of 0x90000000 and expected it's
output to be visible when the user configured only a single console.

This caused regressions[1] in the barebox test suite when updating to a
newer QEMU. As there seems to be no good reason to register the UARTs in
inverse order, let's register them by ascending address, so existing
software can remain oblivious to the additional UART ports.

Changing the order of uart registration alone breaks Linux which
was choosing the UART at 0x90000300 as the default for ttyS0.  To fix
Linux we fix two things in the device tree:

 1. Define stdout-path only one time for the first registered UART
    instead of incorrectly defining for each UART.
 2. Change the UART alias name from 'uart0' to 'serial0' as almost all
    Linux tty drivers look for an alias starting with "serial".

[1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[stafford: Change to serial0 alias and update change message, reverse
 uart registration order]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Fix commit message and reverse registration order as pointed out by Peter.

 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef..42f002985b 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -250,7 +250,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     void *fdt = state->fdt;
     char *nodename;
     qemu_irq serial_irq;
-    char alias[sizeof("uart0")];
+    char alias[sizeof("serial0")];
     int i;
 
     if (num_cpus > 1) {
@@ -265,7 +265,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
         serial_irq = get_cpu_irq(cpus, 0, irq_pin);
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
+                   serial_hd(uart_idx),
                    DEVICE_NATIVE_ENDIAN);
 
     /* Add device tree node for serial. */
@@ -277,10 +277,13 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     qemu_fdt_setprop_cell(fdt, nodename, "clock-frequency", OR1KSIM_CLK_MHZ);
     qemu_fdt_setprop(fdt, nodename, "big-endian", NULL, 0);
 
-    /* The /chosen node is created during fdt creation. */
-    qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
-    snprintf(alias, sizeof(alias), "uart%d", uart_idx);
+    if (uart_idx == 0) {
+        /* The /chosen node is created during fdt creation. */
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", nodename);
+    }
+    snprintf(alias, sizeof(alias), "serial%d", uart_idx);
     qemu_fdt_setprop_string(fdt, "/aliases", alias, nodename);
+
     g_free(nodename);
 }
 
@@ -326,11 +329,22 @@ static void openrisc_sim_init(MachineState *machine)
                                 smp_cpus, cpus, OR1KSIM_OMPIC_IRQ);
     }
 
-    for (n = 0; n < OR1KSIM_UART_COUNT; ++n)
+    /*
+     * We create the UART nodes starting with the highest address and
+     * working downwards, because in QEMU the DTB nodes end up in the
+     * DTB in reverse order of creation. Correctly-written guest software
+     * will not care about the node order (it will look at stdout-path
+     * or the alias nodes), but for the benefit of guest software which
+     * just looks for the first UART node in the DTB, make sure the
+     * lowest-address UART (which is QEMU's first serial port) appears
+     * first in the DTB.
+     */
+    for (n = OR1KSIM_UART_COUNT - 1; n >= 0; n--) {
         openrisc_sim_serial_init(state, or1ksim_memmap[OR1KSIM_UART].base +
                                         or1ksim_memmap[OR1KSIM_UART].size * n,
                                  or1ksim_memmap[OR1KSIM_UART].size,
                                  smp_cpus, cpus, OR1KSIM_UART_IRQ, n);
+    }
 
     load_addr = openrisc_load_kernel(ram_size, kernel_filename,
                                      &boot_info.bootstrap_pc);
-- 
2.47.0


