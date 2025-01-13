Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9D6E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8do-0005i9-1L; Sun, 12 Jan 2025 19:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8di-0005ZA-Rx
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:11 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8df-0000pn-FS
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so43336365e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729346; x=1737334146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=su8YQ62jiF27pz91SJxKESXAn2Zc/gs5SKJu03lzVqM=;
 b=bqWomXuOdaDWp9sRA7NBDq3GCviUsg6CCXuhoxGwgfVfZIBnXG4512lz2cxImyTwTq
 s3CzoOQiNOvum1RVflfI2YmnmVaaDiOa1zUT9YFHhtsaHfJCva9Txjlk2RXjtUIiVK/t
 GkNXY9nIlz5Nobhj6zaO8nnS9TvpqOe71Uir2q8rN0nAhK+LiDUtABc48x6j961jl00l
 NmUq+A4lcq5Kng2zMA3CmmMbPyiVGd6Vrfcm0UqPH5oeZGZOEKO6S4LF8IM+M+Ife0Il
 Uf19jpnkGQhQL+VSgA7IUg1RAQSq64DgjZqq6rQ48df8+5O9tcD9bHj958xlhxl+H7Fe
 8d4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729346; x=1737334146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su8YQ62jiF27pz91SJxKESXAn2Zc/gs5SKJu03lzVqM=;
 b=bNjH00i0XnDH96vwshhHlBKe1Hf88Xm0pKL3xIdHdWxcPYPoUlxpVZ+TjZg84QAwz/
 lmKEaJCEitMyQ/nLii5tv5UPe9alCbGpqvyVE02t32FumT0916TqkJbtPnK+m7sbqBwr
 AvOkTVbb+GUVicuR5771e+0JCK8Z5g27AXu0U6jZr7tbjhsFd6nwasUMy8wdg3y6styM
 g3Ed/0pjh0CJy80dGwWND3WG3daGDdBqKCr7ItUccpJmdUjWNIsBNPE5V1n2e1WQuKBd
 dvRnz93vERzUD5FryJbOizR2D/yYVcbHASC1MDgdTU7GBV+wgbResM6lFSK0RLhy4bpL
 gwiQ==
X-Gm-Message-State: AOJu0YzGO6YW9c5EoBRcUvZ9mv1QX8BREPeegxEPyibETWRNMk1zIwVC
 tqCboKHYXCJjN6HiPo5V/pL8N0XUugF83tagioClmFkhkLgMDcCAWBKmSUKo0oIUB29QL2bAY9B
 obe8=
X-Gm-Gg: ASbGnctOKRXZBKu/k1vg/51/GN1gkqT2e4tkeitMvGBNoTVTXH/Y3T7xVpKkgAjEeyz
 cdu7XdP2fEQ28388PNjBzYHM3+0EMCqBBkqjOH/Yi8qP5Jz3zgvsldTuTEaEjSdxYgY2h3Mx1aK
 YI+oU9jhkY/uKTSZ/Rcdg0OoB6LcgRaSIqEWLL8yc2vOhP8f+DjEHL65t+D8xDXoJZvk4/ke6hh
 uCGJ/i+QYLMKcM+4Gwjnc4RJEuHeryHFjTjHWDYcarbr0UsKHTrw08DzMlUGZeKp9d6nYrRcY8H
 UgPlmwY+j4x+97mr2iYQZHuGPscqXL0=
X-Google-Smtp-Source: AGHT+IFH9WnqMtRyLxabXGOhDZ2NX53Xz7ac5GJS8gscvkym9iC3lEIcFeJgnGlQmwKMDo+KQ1Dmtg==
X-Received: by 2002:a05:600c:46ce:b0:436:6ddf:7a27 with SMTP id
 5b1f17b1804b1-436e27072a7mr151422095e9.23.1736729345696; 
 Sun, 12 Jan 2025 16:49:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436f04df606sm94008945e9.12.2025.01.12.16.49.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 13/23] hw/mips/bootloader: Propagate CPU to bl_gen_jump_to()
Date: Mon, 13 Jan 2025 01:47:38 +0100
Message-ID: <20250113004748.41658-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_jump_to() function.
Include "target/mips/cpu-qom.h" to get MIPSCPU typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h |  3 ++-
 hw/mips/bootloader.c         | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index c32f6c28356..daa2b92e249 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -10,8 +10,9 @@
 #define HW_MIPS_BOOTLOADER_H
 
 #include "exec/cpu-defs.h"
+#include "target/mips/cpu-qom.h"
 
-void bl_gen_jump_to(void **ptr, target_ulong jump_addr);
+void bl_gen_jump_to(const MIPSCPU *cpu, void **ptr, target_ulong jump_addr);
 void bl_gen_jump_kernel(void **ptr,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index e29eb5e92f3..6f055228392 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -249,11 +249,11 @@ static void bl_gen_load_ulong(const CPUMIPSState *env, void **p,
 }
 
 /* Helpers */
-void bl_gen_jump_to(void **p, target_ulong jump_addr)
+void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
 {
-    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_T9, jump_addr);
-    bl_gen_jalr(&MIPS_CPU(first_cpu)->env, p, BL_REG_T9);
-    bl_gen_nop(&MIPS_CPU(first_cpu)->env, p); /* delay slot */
+    bl_gen_load_ulong(&cpu->env, p, BL_REG_T9, jump_addr);
+    bl_gen_jalr(&cpu->env, p, BL_REG_T9);
+    bl_gen_nop(&cpu->env, p); /* delay slot */
 }
 
 void bl_gen_jump_kernel(void **p,
@@ -280,7 +280,7 @@ void bl_gen_jump_kernel(void **p,
         bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A3, a3);
     }
 
-    bl_gen_jump_to(p, kernel_addr);
+    bl_gen_jump_to(MIPS_CPU(first_cpu), p, kernel_addr);
 }
 
 void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
-- 
2.47.1


