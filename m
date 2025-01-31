Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B523C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDV-0006aO-60; Fri, 31 Jan 2025 16:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDS-0006Xy-Ur
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:18 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDR-0007qd-BM
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3863494591bso1329059f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357575; x=1738962375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RhExu0CcIw5AXAeV2nSvZookI/39bFtqH0Z7knUSKIU=;
 b=ILZpEgzlHrQo6DJ9mDpCkMdyOIu4bZMFvfTuvxG7NUYTkobK9/yO+7s50VNRWTX+Zn
 Khu0P5xH5h7nXGH4y5vOMbDcOfBGbteJGPnWpg5iUP+5rJ8zjsRYGM0HvK7tZf00DiRL
 aDhR85RwtQ/5nLsxflvotDQwUKQgEiQadqiTLSvOXzyBO0uhz/e0mPR/u5yaoZnE6dzu
 H15ODyDlMn/hVjRjufluwtxQbZHqdsLxECVpNYDIsJOBs3f2UcgbShU8Zj5v1n8yQSpW
 2/84cFEDYy2We66I12lZrDYTV4QLE0hkOjjbRIC+6nhiNdsS6/XMtZWZf8N/zsvFlWW4
 3ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357575; x=1738962375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RhExu0CcIw5AXAeV2nSvZookI/39bFtqH0Z7knUSKIU=;
 b=DzH9/kXZwpf0UQUIONAKanFsRQDXRGJeUEt8TKaRcwPc5PV2tvMqYOVbMlnGHuwyrx
 OQZBqZukD50e1zfvT3vW4B+P+IunktXLuFeqDtT7mnaYVWcioQ/eet4rGpXiXm34mpis
 lSBJr4MXdvUpVRE1Xou10ME8APlhAu3HpIg+dAxN31daDypAX5ymYWbBamdOtROrnGv8
 /wxtCrzDOmSQWkWQQc8oSzYftA2PB0/6P7McqYBatAp+1zrqgUTGdYcVP1hyKkg5ucIr
 SgC6sCH3GMbuhc91BeSRnWZaNVfjPwM3lpmEhlSOVHy7b10KtQh5LnW0d+el9SU355RA
 agwA==
X-Gm-Message-State: AOJu0YzjY8jhRSJH+qvYJRt+e3GM060SvduY2z1DgJiBxvwHJsuFyHAE
 SQWoM+g8Jt+mtX8oiVVTpI6RmuVNrgHQfCvrtin71vzokL/z3ETHAFlkigjcF2uFpVAky4mRx5/
 jH6Y=
X-Gm-Gg: ASbGncsmZNRXlfLotrETz7sLFRURtuoyFC8wyjwlhCgaPegVITgmzubK3dAEsMo6Lym
 XQKiu97WAPwi/nkzYClGa/aSsL/s/+TUYuv9OOqG+smQOUhFlQnPz7gpLZpiKjWd96Gu1SBlNcX
 gDCZPbSkksmsHJZEEdkSMzaxGhuM8RlM7xQwcMavLa2ZH4M3dJ9XZCDJ8YEJxE0XPDrYIgQHW96
 yKHp9YGFx8TZJYNXcEafSEhbts91ZyRMv0hksblIwE0uhJxkyQ4LpskQYxnEtNatTIApSyCMef6
 Ao7TIyH1mMouyzv3z9IFIfZK3e23A92hcyVIqLANxbgLEdGUL/262tXtRIK72SbsCA==
X-Google-Smtp-Source: AGHT+IEACWN5AK+G0mGkwedu0sabzJWY4+g+kebYe1wPjhvEY0U7EPHexWFxlMeBIOEOEI6wCBFcRw==
X-Received: by 2002:adf:f981:0:b0:38b:dbf0:34f2 with SMTP id
 ffacd0b85a97d-38c520bda40mr8324329f8f.52.1738357575450; 
 Fri, 31 Jan 2025 13:06:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438d7aac93asm100550515e9.1.2025.01.31.13.06.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/36] hw/mips/loongson3_virt: Propagate %processor_id to
 init_boot_param()
Date: Fri, 31 Jan 2025 22:04:54 +0100
Message-ID: <20250131210520.85874-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Propagate %processor_id from mips_loongson3_virt_init() where
we have a reference to the first vCPU, so use it instead of
the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-11-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index ee71fe9e9b5..85cf1f707fa 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -173,7 +173,7 @@ static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
     return DEF_LOONGSON3_FREQ;
 }
 
-static void init_boot_param(unsigned cpu_count)
+static void init_boot_param(unsigned cpu_count, uint32_t processor_id)
 {
     static void *p;
     struct boot_params *bp;
@@ -184,8 +184,7 @@ static void init_boot_param(unsigned cpu_count)
     bp->efi.smbios.vers = cpu_to_le16(1);
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
-    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
-                         MIPS_CPU(first_cpu)->env.CP0_PRid,
+    init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count, processor_id,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
@@ -643,7 +642,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
-        init_boot_param(machine->smp.cpus);
+        init_boot_param(machine->smp.cpus, cpu->env.CP0_PRid);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1


