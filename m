Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE5E64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8N-00007p-MN; Tue, 03 Dec 2024 06:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8H-00006Y-K6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8F-0000Z5-KS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so46125695e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225513; x=1733830313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+svFV1xcdJrlV8NyDIn4cv3Yc08EHLS4Zn1tNR/Xs0=;
 b=mrzAWRLF6D/PaefW0z78aATHb/wCSsckXrzwMxZ52XD1RKvAGvYUo3hBiU5sOtxfnd
 TTUU6NCJzX6GdotkOHYSRI0mIeMKYZDt2XpDzYE9N3iWRNxSVOLysGpohVri33EUU58+
 OX4q5bG8qk1VGHM/8vkoPVGswv7YUWfJwF7YJnO9x/2Ylkru/i8VA6QpsqWOGMAkXLan
 DLIVu+5jh+Jqijzez+kDr9NncTTnzwewk2CC+5OY5vs7nUKVXI74fgSANYeNN7sV1b/9
 7iv/b73Heh2lwbMSEVCDPrZ5Z45E/az+s8rtfbj6HEW5Om22nzUlTIJ1BXPX/W63jRWC
 ghTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225513; x=1733830313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V+svFV1xcdJrlV8NyDIn4cv3Yc08EHLS4Zn1tNR/Xs0=;
 b=unV8ie2B8OyXIGWBlfWUM+p6XwQ/xsSCNp24tXHuvbCXCRlqjmVtm14pmCMElT4+EA
 5UJlMhiKB9leVuJ+Ia1BS6/bwcN4lyQXrN0h/C97YNOxWnK+ToaNR7dDYYtF7Tbuiqt4
 ZeviWjwqoGDZBKXrDoYgHBWdf0ZXq5qY5/AqeQQpw4lZLk+Dg7Ln8B+PNncxD44LU4gz
 /q0Ypcpsrr6CuABnNhdoh/0fgaasKj17oVVDIifFygTx07OjKkzrMCY/HiLCo4LetqoC
 mqCT8bd+sPCDX9gRcZZeVSFt5z0yjJo+xRnE+ivl8cohvi/GLmZ6pbhLX3Y3GMVWV8Hx
 zTCQ==
X-Gm-Message-State: AOJu0Yx0SDTPhGXKWU8QN5a2p6dolKWihAMWsoKEaKRcX6CNbrTlSbV5
 zNPZN1v0fgwVGwiPgPMIa8k44vZAvY5rZxIcumI0Wa+Rx1mz4/nY7iEaX3SopyIVxLDO+6YOXfG
 hA1k=
X-Gm-Gg: ASbGnctfWg9dU4UrDZJs0pcerBmUkOaTNkRAXfsiPigBYyj0omw/D9UOgUhl2hmes41
 bPDsgkX3YlJgeQgxAvkFVf3izxhe8aBdbKsG6IWz8m2/W1d1NDuNHQSD7AHSMGEtDdT76P8SLPK
 5CeqSuW0cM/+peZb0eGJmMb3uTpIwyi+uT1oadcrZzERiVOfML6oNqmBedRCU3Pzjj7hcgDSzsZ
 eoCoglSoVr+XbeE0xRV7Ie1jMBDh4Es4QLhRNQP5x/KnY5kXuUq+NaLL9zxpUlY0/WsScGY
X-Google-Smtp-Source: AGHT+IFGC3rv91P3cacUsLumBgAVWHgDONohZwYD6IePZL4x7nYFXOxPx0JbEAKDibmeZBkLs2DIlA==
X-Received: by 2002:a05:600c:4f12:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-434d0a1d4admr16898285e9.27.1733225513545; 
 Tue, 03 Dec 2024 03:31:53 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d04e7380sm18163625e9.0.2024.12.03.03.31.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:31:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, qemu-stable@nongnu.org,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/13] hw/openrisc/openrisc_sim: keep serial@90000000 as default
Date: Tue,  3 Dec 2024 12:31:29 +0100
Message-ID: <20241203113140.63513-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

[stafford: Change to serial0 alias and update change message, reverse
 uart registration order]

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Stafford Horne <shorne@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20241203110536.402131-2-shorne@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef1..42f002985bf 100644
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
2.45.2


