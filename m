Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0140C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDL-00066I-6O; Fri, 31 Jan 2025 16:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDI-00065x-Sf
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:09 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDH-0007pX-DS
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:08 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43618283d48so18724105e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357565; x=1738962365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgIad0rTApohRLqLlD+El5YcpAOLn2SiJIln+lUq5GE=;
 b=U2QqBmBvMU1HdhH6qF4RUJ23yJjm647sCozDMekwUe4YSWBKMnuO+obrQlaVyfSQ8j
 AoMuNqUdWAFFYyTstHE90Xk/2nZsuq+sVAhE8w5Pa0/uBkJZBAQ9FZu6zC0AJKjkK/yh
 Y4SNbBlD+KE8KkHSL6hHS+PftbMbfDhxcXUWdYMFFmEc4Nr046otL8Ucr0bE2B4z5bA1
 lxWteaHISe/Decyr7m/SOXEkgReE0JeKT4++m/OSgEGNCcDu5xGI66uLIgUdb1yHno+F
 +/CSrObX8d8SgNPwW4ydi86ml0k1rfQHtIgX5ClgLCq33h2V1AA393aSfYn33mb7E0wh
 zFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357565; x=1738962365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgIad0rTApohRLqLlD+El5YcpAOLn2SiJIln+lUq5GE=;
 b=trc2f38TxEDgizW9/5aTWrU45XyLbJzGdjC5QKwphhGR09r91ygwDS7tONa8ukEoVv
 5oCmblvWJggCVbWRRY54ZXGycVjIaNhWScPmzszAcLxKyrMdZhUUHMTGOXTHVQiTCe24
 uwlm8oC8zGUXGB6xx1tFy4pxezOxHKDwg3LBrZ3f7JF8q8qumgeIsllg+EfrDRQofHzf
 rdvr0BtobHelTczGHRlBloUltwGZ0S4bf4GeIlJkeDBDHBXHXVefVV5oNMiThcpBeIUL
 CjbcxCR3hjo3c+dZdfe19Y6CFIqTrgJb4UHP/b/0KPowWpXXP08wsBCZMFaMBUyt7f9c
 HM2Q==
X-Gm-Message-State: AOJu0Yw99Z0QgboJj15piBvcgnt+WGzKcG9pOGTYQqGAQt42H/bYC4iU
 tJswfD/TTcBPck5Vw3GUzdWyaeGunvQIc8XpUhLvtbDTBqL95PuYodsWr0eZ9rSGllzdwikTfF0
 uyCA=
X-Gm-Gg: ASbGnctKwULGnwLRkkmvs1eZpoQJyfSht1m1jRXlALNm8Y4TO+h5N4Jv6mKYWHqfWfu
 XUOLQ2Wd17ViUvhVqLcrJ/Mgda4dNSVmxUgROuGxGFGNZpoLyafM0BZwDSzwcAozSzFn2K4KV/6
 qMNA5P8BoxA0XUerY3aYrbCyUa9ZO7SghEUe7oQ5Y+ZcsFQau7hsQ0HUtnB+aR6/UtaYDEhAbaP
 buYARuuHSxC84GeHHTj3Q/ScE6S5sZLrx7xRE0rl5Kezk3SHd8gKcDZ3lr0Vg9twuVgtezNtfCM
 UHvfmGxImOjn40eCyRoqEox/VTy+bFjMoxLXKUKfEzZHdDkiwOnFp9q4FO3bDdwiqA==
X-Google-Smtp-Source: AGHT+IFb/zGvBknlLNv7/iy7hM97e3EtaKewrMVFVDku/l6KPKFwV1pXdZi+qFJZ9I4NMUv2jXwE5A==
X-Received: by 2002:a05:600c:3511:b0:434:f3a1:b214 with SMTP id
 5b1f17b1804b1-438dc41ef52mr96164695e9.28.1738357565539; 
 Fri, 31 Jan 2025 13:06:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c13a0efsm5658460f8f.60.2025.01.31.13.06.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/36] hw/mips/loongson3_bootp: Propagate processor_id to
 init_cpu_info()
Date: Fri, 31 Jan 2025 22:04:52 +0100
Message-ID: <20250131210520.85874-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-9-philmd@linaro.org>
---
 hw/mips/loongson3_bootp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 91b58a71a68..1aab26df69e 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -27,12 +27,12 @@
 #include "hw/mips/loongson3_bootp.h"
 
 static void init_cpu_info(void *g_cpuinfo, uint32_t cpu_count,
-                          uint64_t cpu_freq)
+                          uint32_t processor_id, uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
 
     c->cputype = cpu_to_le32(Loongson_3A);
-    c->processor_id = cpu_to_le32(MIPS_CPU(first_cpu)->env.CP0_PRid);
+    c->processor_id = cpu_to_le32(processor_id);
     if (cpu_freq > UINT_MAX) {
         c->cpu_clock_freq = cpu_to_le32(UINT_MAX);
     } else {
@@ -115,7 +115,7 @@ void init_loongson_params(struct loongson_params *lp, void *p,
                           uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size)
 {
-    init_cpu_info(p, cpu_count, cpu_freq);
+    init_cpu_info(p, MIPS_CPU(first_cpu)->env.CP0_PRid, cpu_count, cpu_freq);
     lp->cpu_offset = cpu_to_le64((uintptr_t)p - (uintptr_t)lp);
     p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
 
-- 
2.47.1


