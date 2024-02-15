Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DAAC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabn4-0004bU-CV; Thu, 15 Feb 2024 08:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabn2-0004XR-So
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:36 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rabn1-0004ni-DJ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:28:36 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-562178003a1so1082759a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708003713; x=1708608513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xv9D61ihW9+zNcqu4fMkz7lbwoA5M0MKjWkLl/a3sH4=;
 b=b1dmyyyu+6CtctGkew9IBvvJvdKHPrnMpvQQCfsPmQJzyONl/gHXaJsR/OyVrKkQB9
 sIgPOqk1tmtTUyRvU7NHdhEtJEHjJ/Ta+MtT+RpW35EFOLYoA3J12Cp0DpwnFUEb1u5/
 BTJS88VhGvgOXxQHUtBberzF/fwFdkjUzZh4lRZq4eb8j1WMBblEx1Zr0WF90hzKRGMP
 3Md0sVZvO6W7ogvnM6GYI3vHvo00fFnhRklon3sp1SeyTqk35onfnqjljQQ72oMS9lO/
 QtdDazEM0quOB+5/VZesMHhbmKaPwyTpPa4hcR8WFO+H7zSUiLL4C65naopYxotCqTFo
 cgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708003713; x=1708608513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xv9D61ihW9+zNcqu4fMkz7lbwoA5M0MKjWkLl/a3sH4=;
 b=A3JZpzjDpriNnEPg2uHEiXwoffICq4OeZcdTmyQdpz9MgvgZIJjm5qxjhnK7X7bzLd
 zeY9u6qYGvl5kur5RnftVBlUNIrGrXmdDMDSKnOYmBYxJO3Bsx6bK6zyqMaT1ypjdp2W
 AE7jDDlG5bPVdefutxw2ANuNPcXyMt3qbZaBwbQjspJZERoHVGhg88OgaQaGoR9VpI8i
 LyeFea/67mwd3x5zjxKsJPquHQPQommZtDeRv4Wt3LIQ6AeJkHAu3Pkis533mrzIsIKA
 ZaOX97oMPdHDU/gmqbbmEeC1fySbYpZ5FlVKyv12ONEre4znW5vhKM4MpE2Dr9oGUHgO
 G6aA==
X-Gm-Message-State: AOJu0YyW+D3/wo/XMHgAZf5YVMRaH8bpZm0qLbe5IvaPb/M/ZXaPqrCK
 ghX0hCVj9ncM45z/xY+waoPUPBPWON/hKoFDDPUbqU4kvtYdXVbEiN1muIhbDKPbPHUp5CNby2K
 QAYA=
X-Google-Smtp-Source: AGHT+IHRZG0uVLMUnAkSkwbNrAkhOBtL58gXaYgZEbJ2Qf+znEYKLmwo0vWWQnl/+hBxPY+BxyTXIA==
X-Received: by 2002:aa7:d354:0:b0:560:463:8cd7 with SMTP id
 m20-20020aa7d354000000b0056004638cd7mr1368500edr.34.1708003713718; 
 Thu, 15 Feb 2024 05:28:33 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ek5-20020a056402370500b00560c07f986asm538071edb.58.2024.02.15.05.28.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 05:28:33 -0800 (PST)
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
Subject: [PATCH 1/2] hw/sparc/leon3: Remove unused 'env' argument of
 write_bootloader()
Date: Thu, 15 Feb 2024 14:28:23 +0100
Message-ID: <20240215132824.67363-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215132824.67363-1-philmd@linaro.org>
References: <20240215132824.67363-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

'CPUSPARCState *env' argument is unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..d096fb04cb 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -94,8 +94,7 @@ static uint32_t *gen_store_u32(uint32_t *code, hwaddr addr, uint32_t val)
  * state (eg: initialized by the bootloader). This little code reproduces
  * this behavior.
  */
-static void write_bootloader(CPUSPARCState *env, uint8_t *base,
-                             hwaddr kernel_addr)
+static void write_bootloader(uint8_t *base, hwaddr kernel_addr)
 {
     uint32_t *p = (uint32_t *) base;
 
@@ -342,7 +341,7 @@ static void leon3_generic_hw_init(MachineState *machine)
             uint8_t *bootloader_entry;
 
             bootloader_entry = memory_region_get_ram_ptr(prom);
-            write_bootloader(env, bootloader_entry, entry);
+            write_bootloader(bootloader_entry, entry);
             env->pc = LEON3_PROM_OFFSET;
             env->npc = LEON3_PROM_OFFSET + 4;
             reset_info->entry = LEON3_PROM_OFFSET;
-- 
2.41.0


