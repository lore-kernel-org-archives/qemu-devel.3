Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C545C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyET-0001cl-CJ; Fri, 31 Jan 2025 16:07:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEO-0001L0-5M
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEK-0007vm-VL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:14 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43618283d48so18729465e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357631; x=1738962431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dBa5vP504u7Bs/d2VQaxQJTRjHJp6RrrnCJ8DKVHjY=;
 b=CpqGAAB2A619HeF0f/zbxjVu3Ogf0FzlA7qg4G6Ty0ZXu2x831/3vlQRcr0l8mGsSn
 r0jUZ8R1m/wYUIpTTUjG6U/8DAkcnIqzsGxGaS0BmqjpWrLLADlF29SMXnGboPb/Jl+2
 8ntISXx3puZcpU+npvdOFed4pWQG6z1/YhX2dgWa/nWXc3yt4FC5dsJwh1IUcD0yRd12
 I5uptMp3av+F/g/uVyo2N52WM9Gaf9nFmcZ9HiTFq/Qrs4qD190vU3BWcPqA/UBvqdTw
 kleQ5Muq4/G/afPRF9/kNNW/Qwdw/V1JkcBUq+uw6uq1zXzVmO2x29JxCBD+z8SAL8/W
 MBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357631; x=1738962431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dBa5vP504u7Bs/d2VQaxQJTRjHJp6RrrnCJ8DKVHjY=;
 b=RPmswBd48mPFhGCJ8d9umozhvRe+V4nPv6TET3ob3lGIWBLZSavseVuYfWbNtxoGRS
 n2gTz2pQpnqu/ajSVM0ZISJtmEL2tJGY4K48atAXwSLpWitT2JiZ+ZXYlIwWuYYIjJqz
 O0QqiHKHfJJyFC2+fKepV3s0E4l6jY+5Z3Kv28IFtNfrWucRVhhjv1jY7U3IlwBDprgS
 iKddPfjBdBuaFbraFEWcWyyvhBX3uSLdiejRUVpExcbWj7anAiklVx2y7iGNT116vKql
 poTyYtr2VfQUj907b2eCfWWkvmVyYYEu58X2JiCGz2/yaep91XD2+qhKcT9X6saGbEtZ
 sBNw==
X-Gm-Message-State: AOJu0YzmuiIg9VQ24+srmS8OqmHtgNlA/NWipn2Rd0fP7Bl6uoRNBb1K
 wMfEeSULg+UQkYay7ikrLXFHzuxhjMJx61tHSZyman70aDvBazSD1zvOvMvLzapDOnv46o09rvM
 mC0E=
X-Gm-Gg: ASbGncum1ONBoLy9dFsWB5q190pPdIUeIlRlD6LpvbvWBPGp1AsJ4+hx0KX8DuXcYTE
 I9+KW8raeARpV7WXStpDQPaFNlrI3KZZUXbftBJcuvOEzbeeLdx+l4L90w8WO5BoiVXG0vDKUIk
 HXRUSNyAcrR3vdJ9GMMdI7t5WYFdWyzrUKYl28u6rIuTJ1D2Xoa90pvp2t9qNzeIOYQTyx5V8C/
 3rpIivtD7968oNuLRoy/au+ntqu1zG5NrPy7hTD3KmcPYxSENN5raYt5NRY/Uz4FhLFpcPLOTNS
 wXzjA8/YRF1V67rp2yrav4/hDbkflYBKkbAL4uQV/KL1rDWyGMK/UN6+feYZub4lew==
X-Google-Smtp-Source: AGHT+IFKt1i2NEOzEbkgjQhemn4f4Z9zy1ixJrmgsjN1OX6HtAbkyMejdU80W+TEy8Uo4A7g1cT6Gg==
X-Received: by 2002:a05:600c:3c86:b0:434:a529:3b87 with SMTP id
 5b1f17b1804b1-438dc3c2413mr132950885e9.10.1738357631266; 
 Fri, 31 Jan 2025 13:07:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm101782795e9.37.2025.01.31.13.07.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/36] hw/loader: Clarify local variable name in
 load_elf_ram_sym()
Date: Fri, 31 Jan 2025 22:05:05 +0100
Message-ID: <20250131210520.85874-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

load_elf_ram_sym() compares target_data_order versus
host data_order. Rename 'data_order' -> 'host_data_order'
to ease code review. Avoid the preprocessor by directly
checking HOST_BIG_ENDIAN.

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250127113824.50177-4-philmd@linaro.org>
---
 hw/core/loader.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index ead10fb6cb5..de6b173f4a1 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -443,7 +443,8 @@ ssize_t load_elf_ram_sym(const char *filename,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
-    int fd, data_order, target_data_order, must_swab;
+    const int host_data_order = HOST_BIG_ENDIAN ? ELFDATA2MSB : ELFDATA2LSB;
+    int fd, target_data_order, must_swab;
     ssize_t ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -461,12 +462,7 @@ ssize_t load_elf_ram_sym(const char *filename,
         ret = ELF_LOAD_NOT_ELF;
         goto fail;
     }
-#if HOST_BIG_ENDIAN
-    data_order = ELFDATA2MSB;
-#else
-    data_order = ELFDATA2LSB;
-#endif
-    must_swab = data_order != e_ident[EI_DATA];
+    must_swab = host_data_order != e_ident[EI_DATA];
     if (big_endian) {
         target_data_order = ELFDATA2MSB;
     } else {
-- 
2.47.1


