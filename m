Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE5DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqe-0007KV-6X; Wed, 15 Jan 2025 18:30:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqX-0006rN-Ri
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqV-00057K-DT
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:49 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso2310685e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983839; x=1737588639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPfEuWSADruS/h30T44F0SKsyqf+Ay7mwCICSC78CDM=;
 b=gTuRMLt939VkP72k11a48XpbFTX0cKKLjK3VcXYqrkvEeXPiTbK2FxwTAVdtU8kg/r
 WJ0eyZ6tG72KJz7QrFdllx+6/02RJHNlGhE4Lz5ydA/EnQhYTNl+I5urpEHoPXYooMF5
 Vw+l9f+2zNDyOWhylCj8M7RUBgqRHjdd4+PpZbJ6El2/4R9rQ1iY0zo3edFCllPccKDf
 R8Iv0VOOF6SIwb2BIazSWgxl0+PQIb00J6IYC9nHMkRpnHWd5FtmoZBaUvXTOkdOirmo
 bHf7lrE2AMy+01Fa6iNMwdB8xMv2GCijA4C4vu8SBM6BP1n2N+o/drQQmgRtoa/OMv6H
 ohTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983839; x=1737588639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPfEuWSADruS/h30T44F0SKsyqf+Ay7mwCICSC78CDM=;
 b=AkWugjzyL5YsBY1baR2mV8x8KuhM48N6QJib1k+fC8XqkjyOluWuQojIdHggLvH99g
 q6LIAv6KNmr8BMCbVSDxJchtQbvBdJqDsOHuEpDbcWZpUFKLoP2LSv6c0+6YP+6yF7yf
 IsiTtvZYTe9+uH7ehZmb5/ljDskSPwW0bktjr/mF7qJZ7j7EASCVxuVJJBdDNlYETcRo
 g6/Cn1DONnaNKb5O9aao36fJdU4dDyADthmUV4wHZCTvLfRLGjBLdy1SxPfT46ykW3VD
 9lXxIIEubd8rAjlSjEg2lbCuiKM6V3NTBLd70Y8wolxIkQfFgh06/FEve3zVbfqjUxYt
 UyoA==
X-Gm-Message-State: AOJu0YyvPh2coe9bPtFzTsrCKK8FCeKX/t3672tZ6GoIZ6gdQhQPTQd4
 /hzly0pAo6EJkutDDTeaN4uoF/Rc+bU9wlvcApz/ZGjvnlLcg51qRF5V8U8tp4jgpMf4pxntiFn
 AkgM=
X-Gm-Gg: ASbGncuPqXwg6J8v+WYofLuvM1bq5mGjnBcOYBmjBMGihuzmMfvzpwRjYH+Skdfc8gq
 1o0FoawRPafNLfKxTO8ih10Bni4n2b6GnTrB4eCFEzPQlHJgQuiG1QPQtOJ1IZL+PNcyPn4DS/B
 OvJ3ka4AF5lqygv6m5MNau3h8Gg3Jm7fWgF73Y07y1OblgDue9VUUygKYLerCVRDrfsMgkfkUxU
 UD/7+lcx/gKnQbbCVjoidApDvttLaRjiV+ZnpwMK41f5Ftd1K6jl3NO0VftquzL1MVqK3oIgNtZ
 WmJw9/rXi8AJ2p6eb73OsKhZJUXjWxw=
X-Google-Smtp-Source: AGHT+IFkYieEgvAkCaAW0lBC7oadYK/agKj99REyjPiW4Wdbkx4U0xW5R9uvhrpNbu8Vj3C9fQD/ow==
X-Received: by 2002:a05:600c:4455:b0:434:f623:a004 with SMTP id
 5b1f17b1804b1-436e26adfd7mr241108485e9.16.1736983839148; 
 Wed, 15 Jan 2025 15:30:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c4751sm38628335e9.19.2025.01.15.15.30.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 09/11] hw/mips/loongson3_virt: Propagate processor_id to
 init_loongson_params()
Date: Thu, 16 Jan 2025 00:29:49 +0100
Message-ID: <20250115232952.31166-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 46b298f6d72..4924ea88eda 100644
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


