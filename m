Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF910C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNS3-0005ym-D0; Mon, 27 Jan 2025 06:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNS0-0005wZ-RT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:44 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcNRy-0005D1-Hy
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:38:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so3475377f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977921; x=1738582721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onDlwj0ZIbN511qY5udeZ06adF9GhwMX2qPBrWPiGaQ=;
 b=p6b9siCsSdJOD0MwZLjwtjfuvcA0MKgin2SR84iYUEUAKrEzHpCBcRfEEKR2nW/gDB
 MHxXjBTvPIN3ukrggddqtYPHAhZrK82xtxGfzft4+uihXBLbbzNw2mF+YlVpq/vTIZrm
 8KK3bPdNm4MH30Vxnat9IHxwHRRd10jdBiAraVSnFffo/9nixLreHN5TvaPDu2IWE+Vh
 wDZZ8B94xvS1Fj/104troNFIhpjmsRSwoCefMR2dsbJ7ur/rW4KD+C1w3K4c8uBAUlco
 s6IJBJ6O6WX/TNwMzaHMI1FzIsVWUemdnUSgqJcjHuLYi2pQ8Pez3L8twEXqN9tSPYbo
 uJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977921; x=1738582721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onDlwj0ZIbN511qY5udeZ06adF9GhwMX2qPBrWPiGaQ=;
 b=I3ZYLmSnLUfD7genK/VSCPTEp80cNW/pxmvOHOo307cAEs4zjdTerWHCKLfcoix3Xj
 +nfibaapNc/2SP6qiEQ6rLRKAs57w+E5eq4+K4TBCzM0L8nm0OElG+TwMtOYqJudnH/8
 hWRkp+X80zl0vH9Fz2FiuSZ1iwy5Zt0mONty7B/WXoYS8hfIzum7t4RZsmj2HkN34qzr
 qVT9ZESAfKGyzJCs4J2By8qLiA/utHnmbeQV2VDHbZB4NWLXBHtGaWijJiwKjJFLIFhr
 zz0uRqWog9a0yOfLk6XSH7q1H6dj29wQsRiprro4C2FvPiMJ4bUhWmad7/60x0xqM8zY
 W/8A==
X-Gm-Message-State: AOJu0YxUYxUOlduO83TeIrOtIqCgATMiIq5hFgDyrLBdzfFXEcSzfF8w
 S0dOiMFYnqZaRmlITF+6mQa7XjMX6bRBagm5WXYeW1BorGyVgUpQFahCx32uqq56qaN+enO/lsx
 efd8=
X-Gm-Gg: ASbGncvaEdYzwVG1uuiuHPofmHN/FNEAU2mYopqQ8GmnsnRRPjE5T2ZCn95CSFjNqZh
 SKFfFjCTlqwXtebkfyj/PzRyonRT6vqdfCJNWbsxUjS7aaazWptb8dSP5mAC884ezTyjtUf0Dx0
 yVUk7CCizyFVqakWf7wpLdouU4MF4cC/Oa4oDUr6wDVITo6ZcJbmajcwtU7c7kizLGEYcZlWLUg
 9D6+f8yOCrm3QK0FVomKXUN0+jW3wyCWxNkLUNFzpvrlgHBCiw8PTh9kZhjAWb6fbHScCncC1E+
 2CPAvCrsReO3R0tUQUWe0XUibvOJ8CCy63MHGiPQYneV17tiK8nNOug=
X-Google-Smtp-Source: AGHT+IFpStaAQU/Zcz+8b/ryXl2lOaMGdc5Ak6pk/58DgVLm/FupfiIDULUi2ylM1Q4LA09jkdETAg==
X-Received: by 2002:a5d:440e:0:b0:385:faaa:9d1d with SMTP id
 ffacd0b85a97d-38bf58e8751mr31668234f8f.35.1737977920723; 
 Mon, 27 Jan 2025 03:38:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1baf65sm11004842f8f.64.2025.01.27.03.38.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 03:38:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/loader: Clarify local variable name in
 load_elf_ram_sym()
Date: Mon, 27 Jan 2025 12:38:21 +0100
Message-ID: <20250127113824.50177-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127113824.50177-1-philmd@linaro.org>
References: <20250127113824.50177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
to ease code review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index ead10fb6cb5..fc2e8f91267 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -443,7 +443,7 @@ ssize_t load_elf_ram_sym(const char *filename,
                          int clear_lsb, int data_swab,
                          AddressSpace *as, bool load_rom, symbol_fn_t sym_cb)
 {
-    int fd, data_order, target_data_order, must_swab;
+    int fd, host_data_order, target_data_order, must_swab;
     ssize_t ret = ELF_LOAD_FAILED;
     uint8_t e_ident[EI_NIDENT];
 
@@ -462,11 +462,11 @@ ssize_t load_elf_ram_sym(const char *filename,
         goto fail;
     }
 #if HOST_BIG_ENDIAN
-    data_order = ELFDATA2MSB;
+    host_data_order = ELFDATA2MSB;
 #else
-    data_order = ELFDATA2LSB;
+    host_data_order = ELFDATA2LSB;
 #endif
-    must_swab = data_order != e_ident[EI_DATA];
+    must_swab = host_data_order != e_ident[EI_DATA];
     if (big_endian) {
         target_data_order = ELFDATA2MSB;
     } else {
-- 
2.47.1


