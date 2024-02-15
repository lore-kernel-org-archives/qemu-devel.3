Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C91BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag3H-0002zT-Sh; Thu, 15 Feb 2024 13:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag3A-0002qB-Sg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:33 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag38-0002VQ-Ds
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:32 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so175743266b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020088; x=1708624888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VB2HvOhj++MQuV2OC6cpVOGxVaetf77tz8Ps5+PnfHo=;
 b=JzyX1D1EIt4/krNzw6j5g5htFeR7YEbAUgRfXQFfnIMzInSPy7ugN5doIIMhsGWdsT
 evNocsCn1mumw/ZCBni3xhgOz2f9vNwTMStbfzGqHWD5eq+AtruZ99crTtJlAzjH8fpt
 YeIOxEVu+slVEec8OccYEH5J1FIiWjjKENhtqtHj8oWGFF6ZIw8Xg0Po/Skm2teBoza2
 bMMICcHW+Bh+P2HVkJaC3ZI7B+YaKcSh1OmfOPk8iN3E51EU+RGqrZb2DjEFB4vnXLfN
 fOEPW4XDnLDJPlxDOiETONJfXzilYlTrRZIrml9L7RpLIrelibV1SjeXPaU8cfniET+A
 zzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020088; x=1708624888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VB2HvOhj++MQuV2OC6cpVOGxVaetf77tz8Ps5+PnfHo=;
 b=fJboswfgtjWKR6+ssyqEstcTcMI3UuvkiRWE2j2arP59YWTqjW3Szq/A/6kN73av0A
 BFtVhftggSXvc1Yxftsbj8Rs0IZ2AA+arARZtiH3uD5PecSt2/PYSaKHP4EHQXtGbdzY
 5aBdH3srb5TGJ3PehSOvcS75tUHDcBD5lZSfyZwDgewYk6BsYN/RXXoZgPZM+gawzinj
 byXfkKycCt/8aC/0gzTFOU5fADzPIwJJZq9wbZMMbG2UzHZLX5ON3GRSfXgbiBzLVUGM
 lEdRGEv0bXjlbRRXRqV18JAIV7VhNBvNcck/nmE86QELOvylEyLDibGO4fhylQNfHdVz
 32wA==
X-Gm-Message-State: AOJu0YylpNU1oMt60E4WI5A6GIOGCA3DIsfPyUi8VoPe+jo5cwF0xEMN
 MA+uGl3wXJxqIwxpyCfCMxSQNYOsIVJPC11wUTm1SQlrswyW4DNqr5Kiutk5zprieK0tVm+95+3
 6Pvk=
X-Google-Smtp-Source: AGHT+IGLjYXXn47agCKkDasZ8sqbAnzvkM+d+mq/LLVoEFmWhes1gzf4+LC/PgvosYBszWeMDN4qqw==
X-Received: by 2002:a17:906:2b55:b0:a3d:624d:3e7 with SMTP id
 b21-20020a1709062b5500b00a3d624d03e7mr2042719ejg.45.1708020088563; 
 Thu, 15 Feb 2024 10:01:28 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 kt22-20020a170906aad600b00a3d07f3ac61sm789679ejb.101.2024.02.15.10.01.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 32/56] hw/sparc/leon3: Have write_bootloader() take a void
 pointer argument
Date: Thu, 15 Feb 2024 18:57:26 +0100
Message-ID: <20240215175752.82828-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240215132824.67363-3-philmd@linaro.org>
---
 hw/sparc/leon3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 5c670b92db..fa4fbe4b30 100644
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
+    uint32_t *p = ptr;
 
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
             reset_info->entry = LEON3_PROM_OFFSET;
         }
     }
-- 
2.41.0


