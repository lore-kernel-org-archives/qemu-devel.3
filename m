Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83233E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zU-0005NR-Gw; Sun, 12 Jan 2025 16:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zS-0005ND-24
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zQ-0003nw-Je
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:25 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso39227515e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719163; x=1737323963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8w5ajjS3xBqiW/N1pk3Nwe9kTdtGGtFNBW2HJEEjVmo=;
 b=Jw/292AIvNzwHLBg55FYJi43SFBoyJLKjZzqZ9tZdnTTI9HVi2Bpzse9wWKFcQZPJx
 YRNrnHIY+9kiggJahcVtEkEb6J7S7Pk0QhHeBgRGNhiCpK41zX96iBTUSd6Ayrsjxp54
 QxuK7+swZbZzgi96Wfir+/6RZcuzN9zZNxlBujhHfLObldtwzGHBcbIqX8+vMOzgmUeO
 dvM3gY02mkyiMq3WWfnR323PZ58jzbY9+3JFlRUFDJptFhE2qcnWd9bqWAJfruTTw2jB
 azpXGC8/qFITG41v3Q3xxpHuMFdGTcj5PfU0CrB55BWDf1KOaUbA+otOnb9hprk55Mv6
 flow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719163; x=1737323963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8w5ajjS3xBqiW/N1pk3Nwe9kTdtGGtFNBW2HJEEjVmo=;
 b=wPF+RDBX1DOR02sl+vdgaAptSWIDxjHMZK+2/E7FcLDVMBqK/OhWh3pYW/ypIUBrbE
 AxEkc24TT+iLtgf0rNKBd9+hOIMmygmDDsosZYaJZGC2NqRJ2OUPpJtt8paUXTJhvecl
 Bj+7XUQiZgCuewuhv1xYyML644ub8i7ZYmdFQUsFMwVw+ACDnjy0pF1weyql0thJ0z4L
 YSbxnImSnlF2WoXNoEOIUJwadfXKuPy7e1HrxDNfhbYNcPG+Eiea0Isf7MVbgDvkDIpA
 DmbUccVBIJkmuA2LQdRSCPCkyVdk0X3olnhy6kXVheVQk3yuuuJsiiR/zQTP51id2PBx
 fz/Q==
X-Gm-Message-State: AOJu0Yyx/zWGjTD/GhfxZtyHHC4YJSfoDhiXHP/clNwyjWeWWx5u+vBq
 oVv0RrenSj9x1dz0HiaXSjteU9yl65TNmCL0MgHQ35DbYcN3Lq4Tv99MaxXl5YvLeAmiSXLnpw2
 A2WE=
X-Gm-Gg: ASbGncv1rIbFCsZWmsShz59Be4VDLSlnygePx7+LD4rRJsNCVZwgiEomCi6gSyeCtGe
 xnrE2mM7YFo4zj7G3fBYMdvVRPn+K813NeFbd4ZhcIcAljqMEI6cKOVCsMXJAcoh1b9cd0Pweze
 sCEWYyS1SCNGETwBXaDIfBTCCyWdao78Ff6Y7Tx/PALqhzBVObiilzxHvxgZ5jVS4gQU0uDDRuH
 WRRTBAGCREydgwoVv1K606r/gqpUPzbjZoZZt35WI9Ja+uXjOuJTz0ZQ3LT9+Xi/9DpO+sfzyOf
 HKU6X+eC3YZbbVFcTKSs+VC59z3w2T4=
X-Google-Smtp-Source: AGHT+IE7lbl6fSw+7MSmH+8t01cR3dAUAVAFGXPiZerj/9ZwX8ES8PVGHOxsSYpPRFiQ6hYfJklPKA==
X-Received: by 2002:a7b:c315:0:b0:434:ffb2:f9df with SMTP id
 5b1f17b1804b1-436e26adf94mr176915075e9.17.1736719162985; 
 Sun, 12 Jan 2025 13:59:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89e14sm157776385e9.33.2025.01.12.13.59.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 09/11] hw/mips/loongson3_virt: Propagate processor_id to
 init_loongson_params()
Date: Sun, 12 Jan 2025 22:58:33 +0100
Message-ID: <20250112215835.29320-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Remove one &first_cpu use in hw/mips/loongson3_bootp.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.h | 2 +-
 hw/mips/loongson3_bootp.c | 5 ++---
 hw/mips/loongson3_virt.c  | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index ee6340e42c1..9dc325a8557 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -233,7 +233,7 @@ enum {
 
 extern const MemMapEntry virt_memmap[];
 void init_loongson_params(struct loongson_params *lp, void *p,
-                          uint32_t cpu_count,
+                          uint32_t cpu_count, uint32_t processor_id,
                           uint64_t cpu_freq, uint64_t ram_size);
 void init_reset_system(struct efi_reset_system_t *reset);
 
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 1aab26df69e..67812666c5b 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -23,7 +23,6 @@
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
 #include "exec/hwaddr.h"
-#include "cpu.h"
 #include "hw/mips/loongson3_bootp.h"
 
 static void init_cpu_info(void *g_cpuinfo, uint32_t cpu_count,
@@ -112,10 +111,10 @@ static void init_special_info(void *g_special)
 }
 
 void init_loongson_params(struct loongson_params *lp, void *p,
-                          uint32_t cpu_count,
+                          uint32_t cpu_count, uint32_t processor_id,
                           uint64_t cpu_freq, uint64_t ram_size)
 {
-    init_cpu_info(p, MIPS_CPU(first_cpu)->env.CP0_PRid, cpu_count, cpu_freq);
+    init_cpu_info(p, cpu_count, processor_id, cpu_freq);
     lp->cpu_offset = cpu_to_le64((uintptr_t)p - (uintptr_t)lp);
     p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index a240662016b..45cd348c14e 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -185,6 +185,7 @@ static void init_boot_param(unsigned cpu_count)
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
     init_loongson_params(&(bp->efi.smbios.lp), p, cpu_count,
+                         MIPS_CPU(first_cpu)->env.CP0_PRid,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
-- 
2.47.1


