Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE10EC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDI-00065g-P6; Fri, 31 Jan 2025 16:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDG-000655-IG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDC-0007pC-LC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so1527428f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357561; x=1738962361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=koaWsx2CJvSpNwxzge4pdAu0nar8Q5iI+ZLR1t56ap8=;
 b=SrblB4EY7fBPCMgNtT5od37+ruI8TsvttfC3dIC7XkbRqhxzong+bp4VvwrL3d0HG5
 EZLO/9N/zXKXSnch6KJPHokehSr4IUf9NtrqbRScPc4BUAHRjj+Y4duVYBr1qSpQsanH
 Tu6cb57ZcSUa9bhWjn+PzpCRyWitvBp6Mpbnnrt5yUuzYTFR3o6rKGPXOZtcg1dvoYkO
 zYBvgCv2abxsojyHKR0muHRzKPGNX2dEz/n5C5E2ejj4siuOHWlDHNdNKcP1Beyj4IEv
 GyrsvYTH+/TMmj9WwCoXWHjtd3q1FBXbpH0UMUd21y5WqvGJU5VU9ls3PJWgVkiRECjq
 2taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357561; x=1738962361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=koaWsx2CJvSpNwxzge4pdAu0nar8Q5iI+ZLR1t56ap8=;
 b=ATfZqTWffyHDxrQQEb/6Tdyh5qGdMCDGGwe4CB7DbNGss0xenObN8HsST6uhmZ1sEo
 EcFC6Iw8Ef5Ks6ihYVWuzRGNxX7x7KitvbHLirMd+1QngtRc6DgyxDksHkPPlkWIm+vh
 umifAqWeaJOLpoz1wduOtHeBEhHqTn5r+9NZ08k94UjEWOaGEb5YBa9neZDJ/qpWAsZJ
 elQaf35YUBbreNCoa5xMVM3SL3Ieoh1KSlDDdeXzUu/d3Yri6NdJeZKo6DGw4mo0RlF3
 tzijsTIZJTmy4KtSn0v0SgdU1Ytu4nsCuQ1ZEcABmvxmIsmo2fTR+N7ekzBrMeOf6mB5
 ynjA==
X-Gm-Message-State: AOJu0YyibR6aidNH4/mogXhGaWL8U5veU7YzWQAZycGg4otDFQqnY9Rs
 RScMbLl9j5Uoo1kg1ZKYPRQMnNMOkQs0BFdllxvhuNXJu+XHevX38+9z/HL3vWWsGkXIqrbquGu
 /L/M=
X-Gm-Gg: ASbGncsuXMrLjrsD0lar5zD+CUdRjYEYPRCTeXKMcOY74N3XDbyz6Ly+iM5HbTfI1EF
 RkLwERvV6ZoEIC9ob53IVvZMiF8pOKbv8/flpRB1TvboIDiiyeyO5sMqL38i+R9EJa2emQyeP+n
 un1Defq3TKELxDFo2MXXR2f3zNb4sIuPHrXKMt/nksw44UldP+NpC14TxGWvw8b7gmTEetpy1kw
 DKE50ByYRtKR+IdBBBz/B5F7WCktlgIQ20hRwfLrUzm59M1qaLlZe+9NGMW02BN5rGEXnjevGZk
 fm1ucRr2sTUdmfZZ31EliPpFJwx9+Zo5jUeT6yt3d5tSY3pdBld4KaViLworQP2xDQ==
X-Google-Smtp-Source: AGHT+IHN/qZIyLROde4loDglmUHB1MPrD6latbYsRKT2IxH6MCJfxHJ3LaVr5+4VW9YGLpDG+x4fEA==
X-Received: by 2002:a05:6000:1564:b0:38a:88ac:ee69 with SMTP id
 ffacd0b85a97d-38c60f2638dmr3770270f8f.13.1738357560865; 
 Fri, 31 Jan 2025 13:06:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc265c0sm101799615e9.10.2025.01.31.13.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/36] hw/mips/loongson3_virt: Propagate cpu_count to
 init_boot_param()
Date: Fri, 31 Jan 2025 22:04:51 +0100
Message-ID: <20250131210520.85874-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
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

Remove one use of the 'current_machine' global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-8-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index eb2a6a248d8..5fe5bc6fc03 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -173,7 +173,7 @@ static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
     return DEF_LOONGSON3_FREQ;
 }
 
-static void init_boot_param(void)
+static void init_boot_param(unsigned cpu_count)
 {
     static void *p;
     struct boot_params *bp;
@@ -184,8 +184,7 @@ static void init_boot_param(void)
     bp->efi.smbios.vers = cpu_to_le16(1);
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
-    init_loongson_params(&(bp->efi.smbios.lp), p,
-                         current_machine->smp.cpus,
+    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
@@ -643,7 +642,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
-        init_boot_param();
+        init_boot_param(machine->smp.cpus);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1


