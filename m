Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EE6C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDB-00064c-12; Fri, 31 Jan 2025 16:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyD9-00064R-DD
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyD7-0007oj-JA
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:59 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso24321195e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357555; x=1738962355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8kACQ9Ed0Np5IQUg9PPlvJM41JRwzX7hPUIJ5MOFlI=;
 b=ERV8tDU+Y6M9OqKrGhXBihwEUlM59F1Qk9eLlg92u8DRO2tF9hl8d0id69FSHHEgUC
 GmWe20lfW++WdbM5JBJi5ho6gi+4uFthrMyW28kC5jefKOzVyt0W2Aasjd3J21SDVuBe
 9rw3S3SFW6NZI+oeywsMdYRq7893qtnmSi9U4rHoHVJFGYJ88kQdNoL7ojwusvSldOF8
 Pc+rHjEeA1w+BqqzjksWg/tUUe/xo4uvklydc3FHaAOFpDj4lCMBAPlcwfy4/HFMeSb4
 iBrc13Gm7A2bEHB2lNN27P3WhpCjsWC2TIo0yzwkTQugXvf0cIZ9mrl1TTb4JMSuEghe
 hfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357555; x=1738962355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V8kACQ9Ed0Np5IQUg9PPlvJM41JRwzX7hPUIJ5MOFlI=;
 b=b5VxVLTaLAQ/UawDBtpdi6QkMmz1kYY2ML4S2ppb5aRDhC9pXrbnkaYJ73Iua18NoQ
 LLMOPO+652F39UZQ44vLFAQxvsb3LFDGEkWWCRsPPZG8HhOsQnJVQe3zoJLfQInTA5eC
 /WjjAEPAHlbufobzHP6ehqJF7e4HcKBMGPymwcwDzWDpcic5fEq854HJ0lpmsR/iz2mX
 ifpJ23WUpZpaHmmffK8CUwO/uLhLJ7v9x1kQ3n5ltVgq2SvStBDgDGPx60a46KG+OlaU
 MWX0HQKYw4kIVUgzPBaosmcvwrN4ovRtxGtQ9Ica0ns+51SWdDtfCHQVogmhrrcstrZH
 WzUg==
X-Gm-Message-State: AOJu0YwrgMwA89hYW4Za1loS/sUv4kPsqZ3VVCvr19EYGV812XfLmOMP
 uJK0q1/n8t6VExxIY91lJ7gJjWErFVLCzxFKyXr/w9OUYiZq3ZU+8JcbiG5WpxLo0Ntg07zAwbj
 dO3w=
X-Gm-Gg: ASbGncsaawRM+ZluLQhetQVaz0jaT6lMAJrFjM4WIi+zgrWYYlgTMd+S0DLLOzQ6KkZ
 aYTQHd3haFFvv4LyLvh0J+jS6Cl/eZVsdzZd92XO/muVnwmFxPGN+vWFBm/tVNPV5Px0gTeiNEf
 2IuT6TqybNBUR231oyOcC+X/qESVBSVpHRSi92RV95L35qbBLuIk4CTv0s66Eu9xUpJkhq0jjeL
 R4zUbKRMkS7aciD+Y7YzFJByj2knacYQv6xZZ27vfcRDiaEEcx5Ga01pkitzwQVxjlkXPA+qTyg
 XYAwHWtS5+WBAuKlwGI3J8Ir7g4Y0G8Nri5oUYtbGHX25e/MbUoJNFXade+tEeCesA==
X-Google-Smtp-Source: AGHT+IFHpAoUROA3fQEC8ePZFKJmnrZU7mqMoQaguU05A+9FwA1+r5irX/Acy3cwuhAv9LBlxqP4bA==
X-Received: by 2002:a05:600c:190e:b0:438:d9ae:337b with SMTP id
 5b1f17b1804b1-438dc3ca414mr117270525e9.17.1738357555538; 
 Fri, 31 Jan 2025 13:05:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf555sm5650545f8f.97.2025.01.31.13.05.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/36] hw/mips/loongson3: Propagate cpu_count to
 init_loongson_params()
Date: Fri, 31 Jan 2025 22:04:50 +0100
Message-ID: <20250131210520.85874-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Propagate the %cpu_count from the machine file, allowing
to remove the "hw/boards.h" dependency (which is machine
specific) from loongson3_bootp.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-7-philmd@linaro.org>
---
 hw/mips/loongson3_bootp.h |  1 +
 hw/mips/loongson3_bootp.c | 11 ++++++-----
 hw/mips/loongson3_virt.c  |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index 9091265df7f..ee6340e42c1 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -233,6 +233,7 @@ enum {
 
 extern const MemMapEntry virt_memmap[];
 void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size);
 void init_reset_system(struct efi_reset_system_t *reset);
 
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 712439c2575..91b58a71a68 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -24,10 +24,10 @@
 #include "qemu/bswap.h"
 #include "exec/hwaddr.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
 
-static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
+static void init_cpu_info(void *g_cpuinfo, uint32_t cpu_count,
+                          uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
 
@@ -40,8 +40,8 @@ static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
     }
 
     c->cpu_startup_core_id = cpu_to_le16(0);
-    c->nr_cpus = cpu_to_le32(current_machine->smp.cpus);
-    c->total_node = cpu_to_le32(DIV_ROUND_UP(current_machine->smp.cpus,
+    c->nr_cpus = cpu_to_le32(cpu_count);
+    c->total_node = cpu_to_le32(DIV_ROUND_UP(cpu_count,
                                              LOONGSON3_CORE_PER_NODE));
 }
 
@@ -112,9 +112,10 @@ static void init_special_info(void *g_special)
 }
 
 void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size)
 {
-    init_cpu_info(p, cpu_freq);
+    init_cpu_info(p, cpu_count, cpu_freq);
     lp->cpu_offset = cpu_to_le64((uintptr_t)p - (uintptr_t)lp);
     p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 9f6fdd0f287..eb2a6a248d8 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -185,6 +185,7 @@ static void init_boot_param(void)
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
     init_loongson_params(&(bp->efi.smbios.lp), p,
+                         current_machine->smp.cpus,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
-- 
2.47.1


