Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D67C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqb-00076H-Sr; Wed, 15 Jan 2025 18:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqV-0006kV-LX
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqM-000558-Ss
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso1474665e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983825; x=1737588625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QsJrlKcmyvOLkMfarrkKos3o50mVd3SgHzi3eR8aV2I=;
 b=cUl8XFNnO852Ns/G1H0Vfb1U6cSGeW7ivwiGtrHeC4LWkHoSxLQ2zWfIEqtvf+IaAH
 1QGphKsMoNmZrnZwTwm8fpZxjNVmEElRt++sk/9LYE+rjMLCk38D/m5p0gR6zp/bQUJD
 bVptUqNr2xh4JU85O1+VNcYrHtTtM37o1QUAHSdexsfu9Enfhlip9a61OMKxFnOScULD
 AJmhGgsgM16jdQvnFPYQotn60Y55hVV9jctu5HyZUJ0+hTe7DMC6s+Hdj1wpqWu+/o98
 31GwrCYJ0rTeyBPml3E6/jpohm1zQh/3+SLshWcZXJFw9MvnqrdL9Xs58prCj5XHCjMT
 qgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983825; x=1737588625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsJrlKcmyvOLkMfarrkKos3o50mVd3SgHzi3eR8aV2I=;
 b=sVsUlhDXGDKKmmKnLPL2WQ8/CtLPCuowVhFwD0JisS0GBHkWnY+3Pxkzr6rMqWrs2+
 e5/D354fBt5kch55/5FSTUBlq+7sV/paG2a9XO2wnJmvbEhxlTL4iKQrWWBEASjmLVPR
 gAUCZvRkzsEGwRYpkhaD6ZIE4XpKHhxwfe2biTO7+JKcGdfHzLXKlTdJPpqdPdwMAQI+
 gRtNSc5L37WhbxggdyAv6pVvDEoy+YUqF1N2zAfueysivsXFLfdoyHruHce4YJw3+Rpl
 TyMu1lkBOJ/Xe8UD9nU5HRiEsyRJBCCtNDfNcMyg0SfRp4zyOvHkI0+oA8aADNfNhDhv
 vLdQ==
X-Gm-Message-State: AOJu0YwQ2eyNlzFOnMgsMxpg7vaKMspTNtSCm9FXYVk+fJs54CTnE+v/
 zC2PZ2Gb4selGP4aJh4t28w2HzRFCbD/E0gWLGV/ZKcyJX13c8ZFMbMHpRW3yJOjMQA00X6JWsv
 9msE=
X-Gm-Gg: ASbGncuTRy1+/A3NadzAuLK4v2zpV7DJSWRzB3SJDwqcNUddSqRu8Amn014cYavUKKM
 alF6Fqhzbc+SdsafFqBm1ipUJPlG2Pcr0uZETylhHzZ4pahwjtjFl7AhpVzQL3cxgUHtKm2Qt9V
 3YdiDUUm6j9LxoxRAuK22tYYtb2oswJXYkk46nIq8Soh8+0ePGcbVEGBuW05TJgSZ34j1hvBXrO
 iZtjoV6yxVcwwkTdxwiY1u4WROQx4v2EA8D0Tm6egNiHGHxdWQiE0wjUTkBU5ywOcLGIQjA0/1S
 /lApr3bILsh6cnnBRrtn3vFmHeSqxno=
X-Google-Smtp-Source: AGHT+IEoSTJBHsYg7leDeCnDocAEQmUZIj2fh0NU5NOQTVPXivbL7hvzH2SuuOH8+O7zwwgkDjLOSg==
X-Received: by 2002:a05:600c:3b2a:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-436e26a8c3cmr303390935e9.15.1736983825453; 
 Wed, 15 Jan 2025 15:30:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c749935fsm39454605e9.3.2025.01.15.15.30.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/11] hw/mips/loongson3: Propagate cpu_count to
 init_loongson_params()
Date: Thu, 16 Jan 2025 00:29:46 +0100
Message-ID: <20250115232952.31166-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index 9c2001295d1..93700a1612e 100644
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


