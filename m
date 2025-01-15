Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E7C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCqW-0006nx-AW; Wed, 15 Jan 2025 18:30:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqP-0006iB-Vu
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCqM-00054y-FQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso1603225e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983834; x=1737588634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM8QVpnVbNxu0PP9F/y6d561pLUgSoGsgnDh4Rg5A+E=;
 b=OnxdvwQjwE/deAOnM1K7e8f6Umekr7xUzo6Uvh6dsvpRUTePSNQ5g4r0aqhkrMPwnP
 oU+KZzIcTFCzCBjSuXF7/096Lb3T8h/wZqr8nRDDDkgrGONh3qirRUNMEJhUsVdj5ju9
 yChAva72d4oJvYWDriu+OaTj9Yy61E6aDP7tGBIGraYLrGgznP0/w3NScCIRxvvrCQac
 Snn47jblud2k2J7uk4cb3RhjQ+cmmeZ4/5e4Ub4sSgY1ME1r5YxE9DSLwDFzXeBwS+Xy
 ZdO2jiiiKTGJ+03gmTLsWm+TtVphVpmo8Izr91wuhGWCqukpmh7pZlFpY+JEduVFWmFW
 zwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983834; x=1737588634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM8QVpnVbNxu0PP9F/y6d561pLUgSoGsgnDh4Rg5A+E=;
 b=AfVieOnPaGdTZJZewIAzMwu4neOCCAxKXPl3VUFXxqxFmIphOg3IharQStPmy1HJu9
 ku2ddT7pFoN3tutoPmAgzLTDJJda9IFeVYOc83jZKI69zkneRhuZ3rn4CdHHeeBc7Cfc
 iihqyB8I+RX9RFqrGLkuaqyA1ci6EYm2i6hWESTLO85rG3BimoHs1l0js4kttZ5Q1gjU
 EP4EKnwdWWUfMbYrUQvcoEUwTyJlUoHFkwqsghMI3K7HyP6ZhAhVYfHLgqFNHw6Y7JFg
 8DDYdNd0XW2VXlB74k4Kdjh8AzRsPJ/zgJRnUSnf7R/DKe8s8oY+xscDxNmLauZqAteH
 SPRg==
X-Gm-Message-State: AOJu0Yxo6FrGkU66OVaiXSLDfZoPymkvLGxaOoU6/UKAnnUBtCBC+VzJ
 hW6+v53L3XtqD5RZnTLeyIUNzrq/+f9RVDO+dGurGvrQU+MnQk6D6ySrLPfRpKOVlYShlQ9+Sth
 WXaE=
X-Gm-Gg: ASbGncsValyjgZZDWQmQCTBbr37H46MhzuzK57HQsNk+0jOuhhOOCQmwOGXz/O4b06x
 a5D0GWa2L5nSaZJ2CkoLrl+9FEIs4yG2tsJPqfp5I069C2BW2B9GnbbcgZpfJl/jOglpaGJ8Fwx
 RW0epHiZ4uiTsglqWjYfJl4R2NqjRKRwcoida4p0xBqfcwPfWz8aTy/4ZdssigIEUS928pN6JtY
 CdmJQ6Q0oDY9Wus1wFkj3GrQ6Al95su1czZN1gL6ZdT+ou6am2QNoX72Ja3KAQgM7HpLaBAqDyP
 HCCEXWPtV70VLkM0PXLnI38cvVIDP2M=
X-Google-Smtp-Source: AGHT+IG5Rw3meZcPTpFQZvHiTYRV2SIeQt5p2vF2D6q5+u7IY8f0TDR/BQd1Ppa5RxgJXAtHKm2pjQ==
X-Received: by 2002:a05:600c:4744:b0:434:a7e7:a1ca with SMTP id
 5b1f17b1804b1-436e26f043dmr261071995e9.20.1736983834635; 
 Wed, 15 Jan 2025 15:30:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753caf3sm38034465e9.38.2025.01.15.15.30.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 08/11] hw/mips/loongson3_bootp: Propagate processor_id to
 init_cpu_info()
Date: Thu, 16 Jan 2025 00:29:48 +0100
Message-ID: <20250115232952.31166-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
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


