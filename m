Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2D3E6FE49
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 06:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snBPA-00021N-61; Sun, 08 Sep 2024 02:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1snBP8-00020U-Sg
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 02:28:10 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1snBP6-0003rB-NO
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 02:28:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so3680230a12.2
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725776884; x=1726381684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6R/TZIsXBzuReDabzK3J/0O6ds/Phifq4VURxFA64W4=;
 b=CEBYOE3LsDLJY/UNpFR6PAOlVdjV0MUAGYI+xF3OgrB+Gjb7s0J2sGotVSO1NfJKEd
 7PqWxpml+l03/SXca4Wioi6EnatgYbBWUgnnaqFUIvJ6lQDFRzRUQ/O4zHatrMD3d3JU
 bM+W59nI7M2N44H2AuPTddhnOCMEJNXMLeGh7M6zb70NKTVj8XSOirvhuXL2kd8K/6y+
 nABQioS1T8SYF7buWoHloVqNR2x/tCtA9sogGXshyqpdzLnBoEekhoBiBYIfGbRhUJjX
 VpyiK1BbVOh2I76b1GwT01HtT++1rnmBSBozMdVgEhwjaquRI+d0K575JU2pmXffLWe1
 8isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725776884; x=1726381684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6R/TZIsXBzuReDabzK3J/0O6ds/Phifq4VURxFA64W4=;
 b=buFq8RNGaA/gqa4ejA8VngkLhxZ7qCwmOiiBwDi7VO7bLRsIb/lF/uNZXDmKKXsjOm
 UZjItlUN4Z+PlAZEUFuGpTMExo0UjOzot6i6RPATJ+EbzwYknMXtp0geyFqAci5RmPrP
 qmxOHkgBvSDC05xsA3yPKvzntfCSfrgBjuRTZ1YX9RYU4SDRxf3gGsZY65/mNce8raws
 CiAFpPQOOZTOemIJYjHstLHnX2sHKmLqvuD1Kih+fXTOg7zikPnZKM7aNqCPdT/Xk8Fu
 uVCbDIld5N056PANph6MV4O5gIR6T2GzYPHJciOUNCKLJfxSfTfllzkKzXQKrgaz0PVG
 TPsA==
X-Gm-Message-State: AOJu0Yx26bzzHCzIWHzEThJTId7d1UOwd14eyZSmptsxTCphNG7bfmgu
 fVp6IXImCZlXRps0mlIXoALOVWLgNtm7Nu/oNcEnYNqm41UMRtmTr8npOg==
X-Google-Smtp-Source: AGHT+IEXtLQY4zAyGZeRMs7InslJorDB+smfhjNE6Mhlu+4SyU7e82Z7krjotibaE8yMBzE96kK1ng==
X-Received: by 2002:a17:907:968a:b0:a8d:2d35:3dc4 with SMTP id
 a640c23a62f3a-a8d2d353f15mr185933266b.18.1725776883314; 
 Sat, 07 Sep 2024 23:28:03 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25ced41esm159980966b.171.2024.09.07.23.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2024 23:28:01 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH v2] hw/openrisc/openrisc_sim: keep serial@90000000 as default
Date: Sun,  8 Sep 2024 07:27:56 +0100
Message-ID: <20240908062756.70514-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shorne@gmail.com; helo=mail-ed1-x533.google.com
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

 1. Define stdout-path only one time for the first registerd UART
    instead of incorrectly defining for each UART.
 2. Change the UART alias name from 'uart0' to 'serial0' as almost all
    Linux tty drivers look for an alias starting with "serial".

[1]: https://lore.barebox.org/barebox/707e7c50-aad1-4459-8796-0cc54bab32e2@pengutronix.de/T/#m5da26e8a799033301489a938b5d5667b81cef6ad

Fixes: 777784bda468 ("hw/openrisc: support 4 serial ports in or1ksim")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
[stafford: Change to serial0 alias and update change message]
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Since v1:
 - Stafford is sending the patch for Ahmad now.
 - Added 'Fixes'
 - Only define stdout-path one time.
 - Change alias name from 'uartN' to 'serialN'

 hw/openrisc/openrisc_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index bffd6f721f..2a15a3a4f0 100644
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
 
-- 
2.44.0


