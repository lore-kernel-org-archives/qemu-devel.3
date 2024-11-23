Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1AE6ADF0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 10:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEnXM-0003xG-NI; Sat, 23 Nov 2024 05:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXL-0003x4-MM
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:47 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXJ-0001Xt-W2
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:47 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-382378f359dso2001519f8f.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 02:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732358324; x=1732963124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soMaH1HqrIUeZXGpqxj4Ff7nwJBYPRniFswtXgwBnYc=;
 b=ImIa+QgfeAbSaY85J7iSw8m5A9BnGDmLSbKFWjhIQJwo8jN3Yd+9w/ZwKBTdbPxVcM
 SIAsmYu4RXs0mMqnAbcW2Re8/WD3qFofU0GtK/vOZj9bOYiXC3TSM1CNC1/R1r8yR6fv
 7AcB9KxtbXPM7dy3iYi7J1F5PTRueBt+YsX/7B/dSxADllWQ54zcxKuQfIktUoNwUv5x
 IxAczVI9NN6Sm8c7+TjCLtEraW3K9JMzvmRRQJozV7lj87H6jGgkc/4wjkdEdkQHbvE7
 6fRBJ1gKFGlpt6hQfDcQxHTJEJv09iNCzga0zJFSQYZNXk2QN9hl81yfwVOdDLmm7SFU
 9aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732358324; x=1732963124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soMaH1HqrIUeZXGpqxj4Ff7nwJBYPRniFswtXgwBnYc=;
 b=qEKQYDWwPrkhwmAw3+rUBNRfnEnaUTr4PAupx9ZpD1j+OcsuMFt9et1/7nhHZJ1l7u
 Jw9+IYpUdyuiXwHINo28yJ0FHYPgMkHjIDRgA10wA1Jbc1quDeLfvWAH0fgi4s9YMxP3
 gAR5Okg89Sb7sdJUpYCXIayvXM3gr43JFZNwh6oYF/lfA4Gz9gCn4Gm/J6Hun2IaqoSx
 eW3qaj2X+W0fcKXm4hCjBJRs9ab6X3RusGv95uD27SSzrPbmzO1GNntcT44LQ316tqAP
 /7XBQ8EG/mnnZWsVBHl5jiLwe5HXBiGOBx04T4gjyOK4ZKfAMax0EgTNxmexXKt/D0t0
 Pjog==
X-Gm-Message-State: AOJu0Yz6e9H4u1rskMWt2gAY8Z323ZsEBPf7u845OoML0N+sNZaoo+kA
 HIsHtJr5xW+PlQRye3ifW9b1vpGBHMBR57ESEMGLpK7FtIZxHQGExbYvSA==
X-Gm-Gg: ASbGnctl5MasDSTxGnB0ozo+LscR6AK891gP1KyzqYmeMoJfT9bQ+8vzS3XSktU95+D
 w6Z1Md6HYiOzkYvslhQLXOhbGaxRW/fcRD5hAyAnT6XtgSB11916hX4PJ+icO7sgRWsClANAGQr
 eatAFIAWYuQ9cHghsgBIQw1F16Gr3RqjphSgansGujnHutrQdxsAWIPzhRTNNPAJ3pYodlZz8rD
 ZCV0a9E9dDUv2N0WoIaTbYQyQgQVwp5/9w0Hx+YZ45mu5eUuJ7ng1+xxVj4qdP8hKU5AfKsa4G2
 kUpna9JG2iKk8A==
X-Google-Smtp-Source: AGHT+IEK4xzq1xuj+8JBJLwq8gwEciX+6H/l+n2X6aNrQJmqiiCQiWjYVOs4vtk7xJ+ftB2SZ+FzMg==
X-Received: by 2002:a05:6000:1887:b0:382:5284:989 with SMTP id
 ffacd0b85a97d-38260bcdbc5mr5741663f8f.46.1732358323843; 
 Sat, 23 Nov 2024 02:38:43 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3defsm5032463f8f.70.2024.11.23.02.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 02:38:41 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Stafford Horne <shorne@gmail.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 1/2] hw/openrisc/openrisc_sim: keep serial@90000000 as default
Date: Sat, 23 Nov 2024 10:38:26 +0000
Message-ID: <20241123103828.3157128-2-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241123103828.3157128-1-shorne@gmail.com>
References: <20241123103828.3157128-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x429.google.com
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
 hw/openrisc/openrisc_sim.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef..5ec9172ccf 100644
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
2.47.0


