Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54997C021A5
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB66-0002L2-OW; Wed, 12 Feb 2025 06:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB65-0002JT-7B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5y-0000k7-E2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dc33931d3so3007944f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360395; x=1739965195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lnuOrrxbUSsaSab52olqEN/RXFUH57MkuMIqAsCkZo=;
 b=PaWW6vcML2v/AvWInuS73asjXgaw1QZ3Z1vUQ7sPr6BY58LiOo4jSJbq40Pqaz4ahZ
 RvC+aeu2JD1suGNnJFYBT/dR0TDXxYJEYsEtpTpcNt8s/xlw4QWSGTO54GMsVMGPo0S6
 8SI+WBcwWB5zu+yBlHHobMJ4/TgtdRnPOqG+FoxX7YMXfKu/GrPaQa/EuvSmbiRrNgK7
 NnNiVo+ujGT20gZEsvgRrsbUxc+/z28QO552fFfoS7BSEyJDDGTqfxyfpKGtkEkxIuZt
 InSiDlCpAtknMLwk+6uITWYqSCpqSb2ZFgRKGanwwcEIOzIeAJlxhVmqzC+cwcScyv8P
 MIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360395; x=1739965195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lnuOrrxbUSsaSab52olqEN/RXFUH57MkuMIqAsCkZo=;
 b=iLd5gT2goOMEL+DIwCbBp0NVfRjij6aUx8mW3VWGpdXgYs1Ven43kfps3vmXeciizn
 HQDPdLkQE+RncLD/uowUX8Xhlm9WX7OE3QRUvdhA2zIjC6BMmaYlEDIwaazoFTXIXMNE
 /F67MPXoGLYNllGEH4/cxTtg9Ljzqk2gFtUwmlKoWJTPMjkX5GRVbShrLM8ijW5WyHXZ
 rlEGO/gTX17CbnbTcxbHEcKJscv0KdzmSw2JqJRZ94GAf2BGBp9+StGPKnMWsb1+nhiV
 8oAHoLhktboyN+gPAPBruc8OzB2uT4D6q3x3XTOrbopbY8oH1glkEXEFEwelx0ca+cxD
 bksg==
X-Gm-Message-State: AOJu0YxnA+rsWgOBFl/mirxvmIyNc6e0rM44uZ15jlUcu4bWOTiA32Qw
 IftWQ572YBLIIptjRfjn8LLGZlVwOnNDgSCgWsVZraY1+K1nDJll/AKpNv74b71ZsM1dto6b0BN
 vcvE=
X-Gm-Gg: ASbGnctq60wyunD5gyL6dlKmx4bKwSNuTfrueabuhCibcILS8TOGGhGMb8bblSPVOqp
 /Vw3Yd5V4OTKQDXY8hVkqyflswm9wksHlWmDkEKelhXVzkLLLk4Z1xMAwvoWm8esu+fKbSDmsuE
 tHKJYGMxanV9IJvsfxTACij6WRDz7GdTuMyLBhpTgWwkFHGfAgR6RjMLK7BPmTbd3h30eNIughd
 ZmXUJsKXF5CKJSEeSQw3mpHxWmyMcZrh0dore8RIyY1EC2CXnOFdhc+1vl63rlqmDw4Z/T2y/0p
 z6yzo6wEj3qFgVdT6ltaaTTzwyeWkP0ijII2jAOr8qAgJ73Epy5LjseMfk6DFuNKQw==
X-Google-Smtp-Source: AGHT+IFpCgVnslnqMK8CyUwlyYytAiqmjP5ad+0n33alxtHrUPlNe4kvk0qN+ZqDYo9HSjkEjcpw/g==
X-Received: by 2002:a05:6000:4029:b0:38b:f44b:8663 with SMTP id
 ffacd0b85a97d-38dea2e0aa4mr2536329f8f.55.1739360394937; 
 Wed, 12 Feb 2025 03:39:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055859sm17379705e9.10.2025.02.12.03.39.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:39:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 3/5] hw/mips: Mark Loonson3 Virt machine devices as
 little-endian
Date: Wed, 12 Feb 2025 12:39:36 +0100
Message-ID: <20250212113938.38692-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
References: <20250212113938.38692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The Loonson3 Virt machine is only built as little-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 831fddb1bd7..db1cc513147 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -144,7 +144,7 @@ static void loongson3_pm_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps loongson3_pm_ops = {
     .read  = loongson3_pm_read,
     .write = loongson3_pm_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1
@@ -560,7 +560,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
                    qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
-                   DEVICE_NATIVE_ENDIAN);
+                   DEVICE_LITTLE_ENDIAN);
 
     sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
                          qdev_get_gpio_in(liointc, RTC_IRQ));
-- 
2.47.1


