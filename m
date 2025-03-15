Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2CEC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 14:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttSV2-0007bH-0n; Sat, 15 Mar 2025 10:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSUz-0007QZ-87
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:28:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sjg@chromium.org>) id 1ttSUx-00040a-4t
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 10:28:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso7020995e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Mar 2025 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742048901; x=1742653701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=cBpSD3Hl1aBDcX0lxl7PBhvyeOmY13Z7eA2KU1yzifj4/dqFHXX5IFQ6eIkqH484yF
 HxqsSMotRy+/tphNePB+crTXg4UATHMhd9WsWLAVY9MB4a4d8BnoDqIPab+5pkVuJDZ+
 mqkk9LJe7u45hNzfqe3HamdlNWRw6fO5cPDrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742048901; x=1742653701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEe7q4w3SeigGu9Yyevoz5YHH/txq64uIVifPcLXvEQ=;
 b=cIAJC5RX0hLRA2ZSOuailQ15F1Yr/OM4DKNHSkEE8PYCbgG/aEpLlLNIG1A/ggSZ44
 MpQJbJ30wcn/fcP9nsiCRc+Z+BySxDT9q2Ps6wGDdQhtrFCr3X4YrX4zIcFjyJfRklAm
 r1JWFs/QPLCy4kEX6taqJSLPML/1OslCemRO+tk4L2yLaBcBQBhd9vXCHSRYvn8/fb2u
 CGf3d2vE23/g72hfRlERJV/FERtD+rY6HaBaQRjxlY6cikW+l88F+ZB0/qAKAyvYuf3p
 cLkdcQh/KBesDOqvMQpjXUPeNPdxMAqMYNYkkNGmPO5EgTdgxdptK7M1VdAiJ2wbsXCE
 ECQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfOUuiIFi3MQQngF8Ci1dt2cwfaFnoyhjmUOQIAalPp8Buf3FsuZqo0n2atglj9CdnbdqyT6y0OoCE@nongnu.org
X-Gm-Message-State: AOJu0YyzTAdvcq458ysIyw+Y2jjOuNMZqPWWSQ7Bu6AKhUrJmFvDIyj+
 LSOMoa1YO48cEl4bXbMtmkpsCWxMyrBt4UHDQrQxnoQGpSfWNy5P9vjD+Y94SP9q4aw43XF0E7F
 5Sw==
X-Gm-Gg: ASbGncvwdvZ/34XysI17GCKBu/vYHuHigkyYPJ5Yvq94mwlCwEIm4NYT32WddMhNMN5
 zMvQ2Tp5FuoTewb+561K/3sWeZVRJHx/rYC6zQOZYN8NRURt3BjAQt4lluLq+7Sdv5vT4jSBjvE
 1AKa3AT6pfwqMLbLf6Fn+bXXlQd+yuuZ+Slhpl7M3gjcRKmGERe7IpSgMxiU/LlB9glXBS4Gkxx
 C3R10ENnXnvLcQ35j5STA5dOsvGLTwd6QbD5zxxYazF3VGB2YtiL64JLAihcwEA6LMHO8/qdiEF
 PKzYP2DxQx/bgZrzRLtq5+qnwARLNm61GLVNlCNF3g==
X-Google-Smtp-Source: AGHT+IEr/rk4+ZqxB/vjG33oC+nkbbgb4MWMhTWMbsM1Uzr/n7zqJ4nmA0F9IvDYTmQerbiybDabKw==
X-Received: by 2002:a05:600c:1c03:b0:43d:db5:7b21 with SMTP id
 5b1f17b1804b1-43d1ed00187mr78758145e9.28.1742048901501; 
 Sat, 15 Mar 2025 07:28:21 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe29386sm52105055e9.17.2025.03.15.07.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Mar 2025 07:28:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 34/46] x86: qemu: Use the new e820 API
Date: Sat, 15 Mar 2025 14:25:54 +0000
Message-ID: <20250315142643.2600605-35-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=sjg@chromium.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Move over to use this API before making the code even more complicated.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to use the new e820 API

 arch/x86/cpu/qemu/e820.c | 48 ++++++++++------------------------------
 1 file changed, 12 insertions(+), 36 deletions(-)

diff --git a/arch/x86/cpu/qemu/e820.c b/arch/x86/cpu/qemu/e820.c
index 17a04f86479..2b0ad179489 100644
--- a/arch/x86/cpu/qemu/e820.c
+++ b/arch/x86/cpu/qemu/e820.c
@@ -19,51 +19,27 @@ unsigned int install_e820_map(unsigned int max_entries,
 			      struct e820_entry *entries)
 {
 	u64 high_mem_size;
-	int n = 0;
+	struct e820_ctx ctx;
 
-	entries[n].addr = 0;
-	entries[n].size = ISA_START_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
+	e820_init(&ctx, entries, max_entries);
 
-	entries[n].addr = ISA_START_ADDRESS;
-	entries[n].size = ISA_END_ADDRESS - ISA_START_ADDRESS;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_next(&ctx, E820_RAM, ISA_START_ADDRESS);
+	e820_next(&ctx, E820_RESERVED, ISA_END_ADDRESS);
 
 	/*
 	 * since we use memalign(malloc) to allocate high memory for
 	 * storing ACPI tables, we need to reserve them in e820 tables,
 	 * otherwise kernel will reclaim them and data will be corrupted
 	 */
-	entries[n].addr = ISA_END_ADDRESS;
-	entries[n].size = gd->relocaddr - TOTAL_MALLOC_LEN - ISA_END_ADDRESS;
-	entries[n].type = E820_RAM;
-	n++;
-
-	/* for simplicity, reserve entire malloc space */
-	entries[n].addr = gd->relocaddr - TOTAL_MALLOC_LEN;
-	entries[n].size = TOTAL_MALLOC_LEN;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = gd->relocaddr;
-	entries[n].size = qemu_get_low_memory_size() - gd->relocaddr;
-	entries[n].type = E820_RESERVED;
-	n++;
-
-	entries[n].addr = CONFIG_PCIE_ECAM_BASE;
-	entries[n].size = CONFIG_PCIE_ECAM_SIZE;
-	entries[n].type = E820_RESERVED;
-	n++;
+	e820_to_addr(&ctx, E820_RAM, gd->relocaddr - TOTAL_MALLOC_LEN);
+	e820_next(&ctx, E820_RESERVED, TOTAL_MALLOC_LEN);
+	e820_to_addr(&ctx, E820_RAM, qemu_get_low_memory_size());
+	e820_add(&ctx, E820_RESERVED, CONFIG_PCIE_ECAM_BASE,
+		 CONFIG_PCIE_ECAM_SIZE);
 
 	high_mem_size = qemu_get_high_memory_size();
-	if (high_mem_size) {
-		entries[n].addr = SZ_4G;
-		entries[n].size = high_mem_size;
-		entries[n].type = E820_RAM;
-		n++;
-	}
+	if (high_mem_size)
+		e820_add(&ctx, E820_RAM, SZ_4G, high_mem_size);
 
-	return n;
+	return e820_finish(&ctx);
 }
-- 
2.43.0


