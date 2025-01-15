Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C87C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqY-0006re-EI; Wed, 15 Jan 2025 18:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqP-0006iD-W3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqM-00054s-Fj
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so2560555e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983830; x=1737588630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BRQx0SkOCPWyQiRMduvrQcrReIn+M/C8yaM71k53eWQ=;
 b=MD072fNfggVuLh8kkvaHTJ9t46asxgcvx/iQKupeijLdAfgr3uqxGCcl6K/4iuk+Uy
 xacoYB6k25MCnRlij/yxPj5LFSTdUR8jhmWby4ANpElufdmKFiRvg3aha4drJ6/9rQz3
 cuEK117e7NXQaoQ5WPVLACiZBGlomMQOMQxdZHb99AR6BULvhQFc6rm6ci+LQLGapHO4
 cBDFWC9VcpokF4ejhCsWADdQSpGnrLmTtt5l39VmXuPp3AbsxXOmk1xB0g376DeaRFHq
 VjGM+GgkUyHpmG7qcOTQJwnM7LCLk4YNTYapFuxzHO52MP86FSAkCoPAaaZkCkMRNa9x
 7exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983830; x=1737588630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BRQx0SkOCPWyQiRMduvrQcrReIn+M/C8yaM71k53eWQ=;
 b=OIojuwl2b2Ugnxb05/CWGHMR1RsD3fS9QgASJpcgKYgUNRFREk7+F+12GIVjIZxrIG
 5TeV++tkNBkeiUEai6KgZurThle04aHbnq94ngh2vxMFxw2fuIBHUqGHOEi+TVCcuX3w
 AMLJyyUcnF2TZBI6MlM3+f2AJRQh1MsSy+KFsfqZPpEn6ZSYt+fSh0oCh7KKJC1nyRbR
 Qp53c3fsdkiyOL3C8PInPd/fnBH2JgVuFzEe3Qi4cIf03xDUdVTepBEKkvcHwtosQNRe
 34g/Xam/YZ86c44KzTTaLE3sk/1sI+GjjAx5bhjzwyV1/36DbH9bpj5W/SV+ao+0V4nv
 5l4w==
X-Gm-Message-State: AOJu0YyxfgWZckzU+A0awig8PZ/80u9HIIBJ4bsTcO9yZ+s1EXsXk8zf
 9qftM+71CYGDMG7ON5FFSsSRwiEzQQq0FvMzCU+tj+9kEh7kGbbbRt8A9DTd4xDgnjpD1uPEe92
 gv3Y=
X-Gm-Gg: ASbGnctjoEbQmkel9ZahYevi9LgcH7oiDe584DGZzHEAW/EkDeSPCrRKQAYUMG4O3w2
 2rsdiGnzxJ14K5i2HoNilHmXAJN2YK1g9eYIpc9pG0upq7nZVh+q7oSabNSOydg00oJeyBx0d9k
 1qAq7fLRcyrwY+k5Fnu2wFEroF2fGBAIyUlz+XfJbw8DvOZTXXGyc8oHGojt/ZFyXBFiqgIzqcY
 NrmwmvIBFY40kCSkjAsgxyePfmpF8NHMHeOZoED6NxO10j0s0J8WhKasjAYLXRESPWRQqobcen1
 SVKYTUGLuTJRZjWNnGGT0j+yzY19uJc=
X-Google-Smtp-Source: AGHT+IH6GvWohGKr1oWh06khHkQDZX6EiyaZ7GIFVzj8Xgtb55wE8/gSn9Kv4JxvIbKxN7Pm0dDEAA==
X-Received: by 2002:a05:600c:3ca4:b0:436:6460:e680 with SMTP id
 5b1f17b1804b1-436e26c3331mr272373125e9.16.1736983830075; 
 Wed, 15 Jan 2025 15:30:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm39595935e9.20.2025.01.15.15.30.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 07/11] hw/mips/loongson3_virt: Propagate cpu_count to
 init_boot_param()
Date: Thu, 16 Jan 2025 00:29:47 +0100
Message-ID: <20250115232952.31166-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
---
 hw/mips/loongson3_virt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 93700a1612e..46b298f6d72 100644
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
@@ -642,7 +641,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
-        init_boot_param();
+        init_boot_param(machine->smp.cpus);
     } else {
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
                                   machine->firmware ?: LOONGSON3_BIOSNAME);
-- 
2.47.1


