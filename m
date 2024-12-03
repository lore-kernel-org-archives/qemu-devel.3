Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A559E64A82
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQsU-00056X-VA; Tue, 03 Dec 2024 06:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tIQsQ-00055p-9n; Tue, 03 Dec 2024 06:15:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>)
 id 1tIQsN-0006xx-As; Tue, 03 Dec 2024 06:15:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so46140615e9.0; 
 Tue, 03 Dec 2024 03:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733224529; x=1733829329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7uJw3DTyZ88Bt6wUATk8Ywf/oXMSfHMQaSxgjAkjLo=;
 b=nb7wDeJ+1jo/k7Mokhxzx4fWx66M0k2nJEh9u4q9UDRNuOFY8bX1qWEHujyjCsKfKB
 86k1u431rghsrP8+OB5kauRMaGRVdlXjG1hV83p3P3Fo28r8phFKOqd5r6vaj15E0PxI
 WwY2IirYzWTwisxPpfKwtpOeXVSWE9GQiRIvPy/cZ46hgvfitZMWv27FTMwYvIGKzTyk
 qtGEsp9ZswsGASbIhGBZPr3J1ksYX4QlkI/guxUw3hRDwiQH1mAxin9ESDy/K6n7Redd
 Ww6BzowXVhLvMrNAH0Aap9Av5n+xkAOwNI9VMjtCQSsbly6YA6DldssQSAOoyunhQPEB
 jjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733224529; x=1733829329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7uJw3DTyZ88Bt6wUATk8Ywf/oXMSfHMQaSxgjAkjLo=;
 b=oUQfQMojWl95mvLnJeF7Yaaaz+qEbiYywgdF6JmYmcLK/uq72nDgoKIHEdfyRNDOM8
 7iMQ52Rc2SglBcnm3b0oQwIX/7bzsA6mtNF12BZUmTUE4ixQdAySlBURdQV6e0dSeD/z
 hT6ASJsyrfqyN9KOuIE1WkPuavHkC/EYniUF6HBfB/oM+OaTxMXCPhOZMekAz+Z1KDy/
 7EZaih4/C37oqbpU2hkxz4Cdq8AvZ83JooAkmYZnT9gegF02q3xzcUA+3GroqLfnI3fF
 wBFQzOhkwn14qX4hWvlf6xID/OKVV/c88a6NkezESD9ZWZ3+NQwOkz0+qHrgjBBP26DL
 jWJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRo6V2LgkrXWO0rvbLaff746SYY6OZJ7ap1oEVufs7TD8fYQOcIniFZb4AfT4OrK+O+eLUvsa9W924Bg==@nongnu.org
X-Gm-Message-State: AOJu0YyLQerGF9FuTWzjaQK853y4d3MZJGPWYF47CYke6DrYd+zu0fnz
 9F+CDwj181yvJ+0GoeEamNf5jPy7/Ptjwx+4ZBw9qpISt6O+aZHGxLrqeg==
X-Gm-Gg: ASbGnct5uYC7gfPnseJ/SONVxtwzs2m+0W+xSX07hXHP/eR0K213o/CqrepL1YQUQIv
 wds9v6rBz8KXPMolPHjjn9xlhIVa1ndjBKDM6RP/RkZTJ3VyTn4yfF017QVaZRb/mC8HPX/GN0a
 2agUyV+l6U+BinxgwjPZBA28rtDD0gbTcG/vGf/YZ8ST+5/b4z/pEpsyHTKK4ZoIIp0j/sanl1a
 xwPnuMaEY85wwFAtsnWovwucVkYkIJeMp5/IFz0CW5OS3s35YMYPoH0abOzRlhmiQ83FK2bv33F
 A6bVLHgANZbQUA==
X-Google-Smtp-Source: AGHT+IF62Kn6xQdjym+C41oGr3YpBbfF87nAZlec6eix18eggFx/N2Lwa7ZKe3Ov4pq45uTHURNIhA==
X-Received: by 2002:a05:600c:1f8e:b0:432:b38e:a048 with SMTP id
 5b1f17b1804b1-434d09c058dmr18062465e9.12.1733224528646; 
 Tue, 03 Dec 2024 03:15:28 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385f0158172sm6359571f8f.16.2024.12.03.03.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:15:27 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-stable@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jia Liu <proljc@gmail.com>
Subject: [PULL 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as default
Date: Tue,  3 Dec 2024 11:15:12 +0000
Message-ID: <20241203111513.402641-2-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203111513.402641-1-shorne@gmail.com>
References: <20241203111513.402641-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x336.google.com
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
Linux we fix three things in the device tree:

 1. Define stdout-path only one time for the first registered UART
    instead of incorrectly defining for each UART.
 2. Change the UART alias name from 'uart0' to 'serial0' as almost all
    Linux tty drivers look for an alias starting with "serial".
 3. Add the UART nodes so they appear in the final DTB in the
    order starting with the lowest address and working upwards.

In summary these changes mean that the QEMU default UART (serial_hd(0))
is now setup where:

 * serial_hd(0) is the lowest-address UART
 * serial_hd(0) is listed first in the DTB
 * serial_hd(0) is the /chosen/stdout-path one
 * the /aliases/serial0 alias points at serial_hd(0)

[1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[stafford: Change to serial0 alias and update change message, reverse
 uart registration order]
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
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


