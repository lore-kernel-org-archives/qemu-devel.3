Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781B2E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zZ-0005Wd-7L; Sun, 12 Jan 2025 16:59:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zW-0005SJ-RA
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zV-0003oC-Bz
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso39312955e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719167; x=1737323967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWtYnTZhf5ZsrR5uc4iwtRP3anUbXOom/qnSYQwviRA=;
 b=OMmZaOBPO+mU+2yIlKX2yCpmYVrCgGBZyj5/wHLiAEoSCDytt2a3gC7gqSlAXxlC29
 pdubCL/zOPJp4TwguK4g5Okfke52nngucLC7OVndkb0OiHfEpqRAiI1oJdmkus1PnfC/
 RB4fcznhbtCWx8EwDlSLzON/bHccOmOMmr9TuEl3YRr0zwWYp1CZTQAobD2ma1lKlufZ
 ZkEkdOm6z3q3cJhShqFEENn+YibEQ3a1dMc7TtHBigQqArqDLHOKd8K5EEaLWktFMRAa
 Rtk+oSb3ypZu2A0eWCKQ5wUabzdPdfywmiCHSn6KvuUzqfaVumU7bM18QbiUOhCK2bZ8
 AE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719167; x=1737323967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWtYnTZhf5ZsrR5uc4iwtRP3anUbXOom/qnSYQwviRA=;
 b=lPhheqJsgCkhSZJfqsgV4LjmMzAzhdlv5uyAALb083L6BPQFEKiJ7p8l9jzsOTDWsK
 E90/ojDe2R0H4ktsPIxPQW1O+2jgWh7MSbLdJ0X2wupmTFE5di1aGlcImdXgDY7kmd0P
 cjCI+5Yg4TmjEXsWRR2IR6dNkQVd5sP/USlUSVegGwW/vxpb2Q2hTsOjJShJu4XgkOWO
 6qdqMOI84g9YVBIN2iyPiVGEx/Il2jvSn6TQzGxPlsBYz5LAb9kSO/hQdX+IfxAqa+kw
 eTyo8FP+ZUaTa+ioePjO06EnS8gOmTR4RECpJISzYNlxbyLw0KS38Ar2huCrE9Uv0nmq
 BDOQ==
X-Gm-Message-State: AOJu0Yy6gNHRiiH/5XmuQfhMl6cViennaU8MhPGuGELAq2EIr1qfLRJs
 3vlt9mt2iDIkwgEKhCf6ZcJJxwp3QwgUNGlcWBu4/X3cJoyjZ9pphEeBsXmOioX0dKPNKpzSeFW
 wtns=
X-Gm-Gg: ASbGncuDj7OWcLaHVCLuU8IrDML1Vk4ouqRN4i7NGIE9POng6WNcNefURlH6FWxtwzQ
 athFwYEXCh8mzDgU5w4oiWS5Yy0YOZR2xWeIqnx07hWE1Sd3FjF508Enuz14E6BWZkzsAUd+Beu
 5wknBO45RTHwzWrSOtF5E5R0qug3Ro62aSH/yT9KF1MMaFscHYVKS7HjNqzDhw6JLQn2JrPcqV3
 ORN+/a9Da0lbcXLMPAqcfShLKqyuYnoUYw0V0rUKe/8Jvbuu7zepCXSMlJgwPWXWWjn6O6poKgj
 mP8LCu0lq8kJmsCepkulOB6ZSCvVC8g=
X-Google-Smtp-Source: AGHT+IG3oLyfjIOitgk9JbRhHvzeI3qgRxyzUPgsdJQBoo5Ivhcee4rBkn6yEm7uNemH5XccxangHA==
X-Received: by 2002:adf:a312:0:b0:38a:88bc:bae4 with SMTP id
 ffacd0b85a97d-38a88bcbb29mr10958500f8f.18.1736719167569; 
 Sun, 12 Jan 2025 13:59:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b82a4sm10657075f8f.72.2025.01.12.13.59.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 10/11] hw/mips/loongson3_virt: Propagate %processor_id to
 init_boot_param()
Date: Sun, 12 Jan 2025 22:58:34 +0100
Message-ID: <20250112215835.29320-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
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

Propagate %processor_id from mips_loongson3_virt_init() where
we have a reference to the first vCPU, so use it instead of
the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 45cd348c14e..59b1619df0c 100644
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
@@ -645,7 +644,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpus[0]->env);
 
         init_boot_rom();
-        init_boot_param(machine->smp.cpus);
+        init_boot_param(machine->smp.cpus, cpus[0]->env.CP0_PRid);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1


