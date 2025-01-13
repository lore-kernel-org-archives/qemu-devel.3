Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB9C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXl-00063x-Ct; Mon, 13 Jan 2025 14:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXk-00063b-Ax
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:12 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXi-0007TA-NY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:12 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so54212055e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798164; x=1737402964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkdKuqLsU14ZzZ0juxUu8/huKQ0KKnNGQSOpTw7EA2I=;
 b=iCANKKMBGIQt9QwbQZdSXgiocsjyMXu7CaCMvSA+OqANUt3YP8WYNS7ywFBIewO8Ko
 I39EAZ93R1pwBZcxr7dk+iZHp7WPWT2zFKhOq8C0P4alvgm69dkNeumKIi4XMfkqFQ9k
 IcKot4jcF11Ysoo5/2KUxmLczuYcaKxtDucM75fb/9UAi8I2cvgQCqIWcCdPy+WVkRL9
 bAYXN37+lNWureiabhIpNbJ2M5fRASofmZ+5B7J1cglLW7+eoLtWyGHwfOswsW9ypy2C
 zck132Fack6v1r4FgsdSmg4fc9N2CnWak7DuaxvUUfNmqfqLmz5IWiRuWR5ThirtUg0G
 SeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798164; x=1737402964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkdKuqLsU14ZzZ0juxUu8/huKQ0KKnNGQSOpTw7EA2I=;
 b=OtRB92Wkv5woXpru8mhQ8Q2ON9GnaztpvZ4JVF3M6/4cwAHB14T2ojf75qfOGDnArg
 +LzM5NH1vrTEFN+xFhlNdCHFFkKkKDOhYrVV9eeg1EX5YVYWGdavJeBO/+x448uNlzUZ
 Fn4l/7eXA3LkD0SnBXpoJQGGGuD8OBwSP4takCcv1UYYRrY6k/ferZIcFdygUIdk164L
 63UTTtnJEr2gOFd00PaWVBeYX8x86+gdspBu7vCRMk/pvZktx9F+dQn6X6R65UkhYgvQ
 snVMNFkMzd9uBwrAvFtOnupAvyfKAw1xQIIrNOAqyYzUKi6gsaqnmf+9gLOW+0y0dOrB
 iSDw==
X-Gm-Message-State: AOJu0Yz9c9NYDnXpLYJJZC4i/7E8L8EQ6Ah55buSp6b61jkFuXNXSa8O
 +KDyhaPxn6qnybFgXm3GoV3hih9FdmRoZINAqnLznLZNj942RnSoPaFhTV7VEnN+wNTfnOe31+C
 fsys=
X-Gm-Gg: ASbGncsnHpUCvWZjzPtGcpp7UQes6lE1t47GCCVU19RftMxsmdmFPh+9oFW/GHNUFOt
 +tV0Td0XeQChA2sHtzwFHSuNvouIHIZ+09IodbvFmxJakfwzCfaoZA83p42F5AFHrzvvqHAkrq8
 0n0S6ImujFi9Owf9sznsc75BoKeHJ/gxRHEO5jZHzcepe1Bg6kPNMV9KCNSIhHaZsNDgWzbpBXH
 bfTgZY+aAYEsPP2nzE/8CQ0Vb6w+rch2JeU/aCpqzC8WhrgRTb7ye7KPqjoUVjIwYYDeNRQblB0
 ilPtaUaVr/vaI5YMnQA6wykljFbYFcI=
X-Google-Smtp-Source: AGHT+IE6mkUK8jUWZFmJ0abY3ZUEJ9sVk4Ep2vdU8WOTGM/ir5n1SpD/UdlyEBlwfWZCbAzzUptnQg==
X-Received: by 2002:a05:600c:138a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-436e271bcb3mr221749155e9.30.1736798163905; 
 Mon, 13 Jan 2025 11:56:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d74sm153210325e9.29.2025.01.13.11.56.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 07/19] hw/mips/boston: Propagate CPU to gen_firmware()
Date: Mon, 13 Jan 2025 20:55:13 +0100
Message-ID: <20250113195525.57150-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Propagate a CPU to gen_firmware(). Since we expect the first CPU
to run the firmware, get it from the CPS in boston_mach_init(),
resolving it using its QOM path.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/boston.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 63dc654192a..491e1c4f7ea 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -323,7 +323,8 @@ static void boston_register_types(void)
 }
 type_init(boston_register_types)
 
-static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
+static void gen_firmware(const MIPSCPU *cpu, void *p,
+                         hwaddr kernel_entry, hwaddr fdt_addr)
 {
     uint64_t regaddr;
 
@@ -825,7 +826,9 @@ static void boston_mach_init(MachineState *machine)
             }
         }
 
-        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
+        gen_firmware(MIPS_CPU(object_resolve_path_component(OBJECT(&s->cps),
+                                                            "cpu[0]")),
+                     memory_region_get_ram_ptr(flash) + 0x7c00000,
                      s->kernel_entry, s->fdt_base);
     } else if (!qtest_enabled()) {
         error_report("Please provide either a -kernel or -bios argument");
-- 
2.47.1


