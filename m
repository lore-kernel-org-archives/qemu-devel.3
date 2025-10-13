Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE645CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O4R-0006qG-9k; Mon, 13 Oct 2025 15:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4P-0006l3-Q1
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:58 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8O4M-0001sp-T9
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:18:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so39131735e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760383131; x=1760987931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ezt+z2zqy28XBUfCShfQnBxAW4qjR8fLU+BoSrNZSxI=;
 b=WX99JstGgjuox25nwf4Buie0902h/jJ+HdDNJ+ul3QAOkNbQGZaoIu/HXUVC7ewKlg
 5NC2gWZ9zynSoHrG54MCs7WUSeodcNcn71CRySlv25WwwrXv3AaSG2EnIt1yn1kiQ0MH
 oqCpCi4jPhPAkvVBezbIWMFcxwchIWD7PfmlWdG68kPLP2/vidvB7hCgb6qLzDx0By3H
 3yFT1cFn4y/QD9bXb2T0+g/sDQS/NWcm0VpzRzLwajMXppup2bslsG9rhibaNN2DyDOE
 LVvqQDmZwtWJV5SXIp0Jy3z+oRujVYdvdCJjJhQTIJmjcrm/FlO6DVdm9zGIDU4O04x5
 IzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383131; x=1760987931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezt+z2zqy28XBUfCShfQnBxAW4qjR8fLU+BoSrNZSxI=;
 b=ekmZmRzvuDvWmd0sX7nBDC9v/VifVrLcEjfiYjVb+izY2K/BJYxyGgoZCCgEgWCJ1W
 8Ip9trT6oHMWcMHik+fKA5SOYZqWBSdGm6HtBldqq9mSqMdP0Mio4Od+MB5wDKkvesav
 8MTAq6lSpW6rc6vNYM/6Aj25LzmZTfEjVnm40lsj16GU22hQHdupiqTTZZmM97X+lTy4
 aRytJZWNFDApnevmnwopwAwRmTMIs1CApwCzl2IGxNTnrn38HQCgXhMFVHfqVjkHUMHm
 TZ5Lqy9rjG31ilN9Nj03H8PrqYSwRAqOKdFih6ezvBy1btsfT3vhc9AZVBd+p7tnuTZS
 NKsw==
X-Gm-Message-State: AOJu0Yx2d1ujxHsbYB6dcpY8/YOHjRlEkTsGGSWW2iAr7vywba1Rthgi
 FiBak7a7gZnvemKfNiNI5p2jkrPKAzm6dDACBUpPG5Uut5583ARNYtCZ8W0C7g/bJ8g+p+Aj2UI
 nTeIzDXFwog==
X-Gm-Gg: ASbGncuXvieTtMLvGLyK44ZJmmjwXU7OuVIw7ti0XW7d9/hPCjBIPd3EOGQOu8teevz
 LstBi/iBuVTl3StpZ7Fx75el0LYZQwt7wr01kQXxUVqW3XeqMm6/OQe2qAIFOBbYVf4Vcb7TSM4
 gnQkjKifWhEOqQsVuvahj//PQpFDB4oHZ6JFnKsSL7dfjnJwSznKokH29EzqyhcO+1Yc5RxOs82
 Mirj+5Q6aXwFvfliu6Z0CuZQfnGzGye/cyj+ZYB+Y5xcINzcUTFtXghN/gPPO7UUCT0HBfP3Qeq
 I89j2RgDDFI90Vup6ZM5bPdjMPutUCYuwJm0pgVVPy0WFfgj/q7XDHcVW+3sLiBwzN7Xkmw3CVZ
 jB9sRuNmuKhAt6ENj8jSC3U3+fwZcd20MLYi+vPJAb4h7JUilug0q+JzOGCGk/cpfexfnr1ce18
 zHoOviU6xfj/In87DYRNMlb4Wtyxntwg==
X-Google-Smtp-Source: AGHT+IGt3D3aRphYd2Zw92sEQIv24gJhiXDWK4kDBC2x2zTnGqbiEQ1WzJvKSIwNzg4uiQ6zsYIoeQ==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46fa9b11794mr156207145e9.37.1760383131482; 
 Mon, 13 Oct 2025 12:18:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab633cdasm133419805e9.9.2025.10.13.12.18.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Oct 2025 12:18:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] hw/loongarch/boot: Remove unnecessary cast to
 target_ulong
Date: Mon, 13 Oct 2025 21:18:04 +0200
Message-ID: <20251013191807.84550-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013191807.84550-1-philmd@linaro.org>
References: <20251013191807.84550-1-philmd@linaro.org>
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

Reduce initrd_size scope. It is already of signed type (ssize_t),
no need to cast to unsigned for the comparison.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251009201947.34643-2-philmd@linaro.org>
---
 hw/loongarch/boot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index a516415822d..3dd48cb8aab 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -306,7 +306,7 @@ static ram_addr_t alloc_initrd_memory(struct loongarch_boot_info *info,
 static int64_t load_kernel_info(struct loongarch_boot_info *info)
 {
     uint64_t kernel_entry, kernel_low, kernel_high, initrd_offset = 0;
-    ssize_t kernel_size, initrd_size;
+    ssize_t kernel_size;
 
     kernel_size = load_elf(info->kernel_filename, NULL,
                            cpu_loongarch_virt_to_phys, NULL,
@@ -328,7 +328,8 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
     }
 
     if (info->initrd_filename) {
-        initrd_size = get_image_size(info->initrd_filename);
+        ssize_t initrd_size = get_image_size(info->initrd_filename);
+
         if (initrd_size > 0) {
             initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);
             initrd_offset = alloc_initrd_memory(info, initrd_offset,
@@ -337,7 +338,7 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
                                               initrd_offset, initrd_size);
         }
 
-        if (initrd_size == (target_ulong)-1) {
+        if (initrd_size == -1) {
             error_report("could not load initial ram disk '%s'",
                          info->initrd_filename);
             exit(1);
-- 
2.51.0


