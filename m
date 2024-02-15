Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853BEC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabnH-0004oD-TU; Thu, 15 Feb 2024 08:28:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabn9-0004ht-Fo
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:43 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabn7-0004oZ-SM
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:43 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5118d65cf9cso1049592e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708003719; x=1708608519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bseUpOju7YvUN3+/fm6a697urfBk+5lMG7vEa3ydvK4=;
 b=PK67UTuwczeTU1trXoRyNCSN/xJiZMA+c4p2+tMwAxU9qpw6jB4RTt3SOHj1dzaSB8
 cCuwRX6nXlg2RKNZdFoC5mL0QGsnkDKrUIPqBdMrn7jKIvJpLaYk5zZv4YLtyUcEulaj
 Tt2p11Ff0u+GtrYN4x1082jTrXfvPVRLFeIRJb0rO7IMbng/7TTffhArHAkGf8PlSxKy
 cqWYEHfUrfA1qN+IpIxsZiNZBbGSIWRq3RPQiPF6isR7W96WnzI5aoosUJSCLeXzZjJl
 0JKQ4KhYOCdmrO4lzA9gXCjof7mTvqmw81K+PzDIeV02ps89oqJk6RA0/aNErRsiGrXO
 VpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708003720; x=1708608520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bseUpOju7YvUN3+/fm6a697urfBk+5lMG7vEa3ydvK4=;
 b=IaqLOcvJ4huk+uZQLxXKARRwug5rKut6JE8eHnMcd27Aw0OoY6ithXnY4HIJPq1AN/
 iRqOTAMrcRsW9Q/Rt9IOf4oO0PKRRjxsKEBUUULaBGDTBATafwetv5QUF0VILCdAOGE0
 EvGlUXx7eTpYXHoaq6QCb7hA3SqYwAp3AuycQm86XagG8eZ//r1sHiuONeWxq/xkUOto
 CJiNKt6u8Kt8EKzMnGRTfLbBXe0wPrVnX110U6FPaarB6nFqt5EYvS3lta5KPyt9+DRr
 e8ZH6r8uE7eivHiXhBkdtxks4mZYi1eG9QxFdVRG9N1hf+jxQG4YVuFb2rRWDen/Vf70
 TPtg==
X-Gm-Message-State: AOJu0Yzv0/Pq4efn3QJ/o52gwsv/K/Pjm66SYrkz22XjzBrHRlLqfzVg
 EXQkaYiRrhPdvNnZFhKVBTAZUP4/0+9J4en+Ijr1YKve5XLwPhhI4e6H4zcOETYK2kVOIaXRXoK
 jEIs=
X-Google-Smtp-Source: AGHT+IHlEe+sqHcp4OzsmVcMHIJGeWmZh6qN5MdhWX4VeKaegGjcgZdvHngXnvb1M56Yl/F9lLT97g==
X-Received: by 2002:a05:6512:3baa:b0:512:88b2:abff with SMTP id
 g42-20020a0565123baa00b0051288b2abffmr1271397lfv.6.1708003719656; 
 Thu, 15 Feb 2024 05:28:39 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 vx2-20020a170907a78200b00a3d9a94b13fsm446246ejc.136.2024.02.15.05.28.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 05:28:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 qemu-trivial@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/sparc/leon3: Have write_bootloader() take a void
 pointer argument
Date: Thu, 15 Feb 2024 14:28:24 +0100
Message-ID: <20240215132824.67363-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215132824.67363-1-philmd@linaro.org>
References: <20240215132824.67363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Directly use the void pointer argument returned
by memory_region_get_ram_ptr().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d096fb04cb..8717c72e77 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -94,9 +94,9 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
  * state (eg: initialized by the bootloader). This little code reproduces
  * this behavior.
  */
-static void write_bootloader(uint8_t *base, hwaddr kernel_addr)
+static void write_bootloader(void *ptr, hwaddr kernel_addr)
 {
-    uint32_t *p = (uint32_t *) base;
+    uint32_t *p = (uint32_t *) ptr;
 
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL = UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
@@ -338,10 +338,7 @@ static void leon3_generic_hw_init(MachineState *machine)
              * the machine in an initialized state through a little
              * bootloader.
              */
-            uint8_t *bootloader_entry;
-
-            bootloader_entry = memory_region_get_ram_ptr(prom);
-            write_bootloader(bootloader_entry, entry);
+            write_bootloader(memory_region_get_ram_ptr(prom), entry);
             env->pc = LEON3_PROM_OFFSET;
             env->npc = LEON3_PROM_OFFSET + 4;
             reset_info->entry = LEON3_PROM_OFFSET;
-- 
2.41.0


