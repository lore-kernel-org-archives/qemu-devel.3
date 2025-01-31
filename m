Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77085C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyDP-0006Oj-Pa; Fri, 31 Jan 2025 16:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDN-0006DW-Oo
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyDM-0007qH-2H
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:06:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1302711f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357570; x=1738962370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXLlGZJlx/2RsYn2bfi3IVqSbsLVgKErZZDglGqjRI8=;
 b=w4zVlrGt7ZtYHo2BXi5LpieOi257DlIwIwRS5gsX9vbVXPCjQcKisyrR5XMo/De8AV
 NxQn76y3sNSiu/YM4a+z6eOcP6xtlkxUmLj2MvYJpsSXL3rjnS7IUMlPh26ViWQykJZK
 yQHmPSKpvBkGK+UT72mpQ1j2wRdOo/hy3ZgxaUeXKL3Lleoz1eeaC9UY9kO3oNdgPiF2
 9UyC9QRGoK5CZq72ac581MlMgXa7Gc5Ufi8wG1pWQnVJCDSMeM9oTMqGTGf2+kKFYCyr
 CEJWOVJ/12KumVhmMr+GgaHr0D0C6XcQRhJTWGuIOIREeunLqt+c6kbqcUiMWjK+xO9d
 7lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357570; x=1738962370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXLlGZJlx/2RsYn2bfi3IVqSbsLVgKErZZDglGqjRI8=;
 b=K6EUgqj/DIvcmdxLItFuUBKALNEJw/MtEupNq+edoJuo6sNpgwM2b52YrgguTZ1eow
 85GnF0EsywC0o5mCAdRd2NRqUIFLna+Nm0pL3ZYXKAqahKlq7xLaQaEg7Lm2+dnMJqka
 uQn7bfOdRMMNoXmLb5VBeJXsrZru9PrWpt9cvUCKwKaI2mH6n5VVlHr0YdcwPYMB8rtv
 473e+ctyWTh4ewGX15VJCO9xmJ+5KO0iGDv9P4DlEas5DLFt4N/OvYWosvI+XHdOXiyC
 pNcqtSKI2BYTbsgKstHHtKGZi6r1sNm/y5IfowG2AHMm6M1vtA5Pk9P4U+4oCGkS2XKD
 MkAQ==
X-Gm-Message-State: AOJu0Yya0q7NB1cji6/DNE8VuPgnUTnj0wx7ksdUAAn3pvq6VLUuuHdr
 l7jOSs/2kQhe1Iwa05dCn20FMRfENt8WBwx+KU1QfA7RNPM/eYot1MpIBpRTkxGa1AUa1E3k2AC
 7JXQ=
X-Gm-Gg: ASbGnct+v89kYbWIpJ/iNQeX1GTcdzr+W06zKIA4E/P2DlsGV+YofwwFUSXgkn1Qi6l
 T2HYAc6FAN9znuNTQnyCEa8cUg8hOK/R71A7Hott/JAXgGipEU6ds/iXL5f7TlbpfyEVV8JTPVa
 eca4Ej4NYtQli8CBYUDEgXGfWN6fu3svj2HGF9XQmuPnm16IPRH/ZqdOVC7OZHs+VJOdARORLxC
 8YuRPpPxT3MRS3Ep9t5oh/JJp+Jzi7c5d4dq+al4CM9FL351Qte4+9L6ogTchR7rPpclw0nMYJI
 B955rG860aPYH6rO3K80TPW0hZHdLTbCjCyF2waFl3PQeuj2/TzgHzf0JBr+CSxgQA==
X-Google-Smtp-Source: AGHT+IHrEvIX9r6xjT9Q7mxOj5a9P1EbT1QvxDe7ZyFmCP6PjxJ1EHEFsdorXGtW5/8v27eA9Jad3A==
X-Received: by 2002:a05:6000:1f87:b0:38a:88bc:ace1 with SMTP id
 ffacd0b85a97d-38c520965abmr10893908f8f.34.1738357570172; 
 Fri, 31 Jan 2025 13:06:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122489sm5772540f8f.52.2025.01.31.13.06.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:06:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/36] hw/mips/loongson3_virt: Propagate processor_id to
 init_loongson_params()
Date: Fri, 31 Jan 2025 22:04:53 +0100
Message-ID: <20250131210520.85874-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
Message-Id: <20250115232952.31166-10-philmd@linaro.org>
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
index 5fe5bc6fc03..ee71fe9e9b5 100644
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


