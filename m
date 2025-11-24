Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C37CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTGl-0004wH-4g; Mon, 24 Nov 2025 04:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEc-0004TB-6R
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:55 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEa-0001aa-1M
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:49 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso2499633f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977906; x=1764582706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zl/AIacwr5jsJ7XYe78HGxVDkS5eQOZDNQOxismbb0k=;
 b=vehp4ary7Z8jTixCxtSwJLoYqllmkBagAfRqkKcJtEu4mqYJ1IJYiK9eFNbAsQZG3g
 NRw5UsTf8RTQ5Y6WDI9a72PdzgogzuIfFt5heMLFWAnwuAtYFScaU4oNuNtRtCJtzert
 8nwR0ByNyyNHxPfrgPuS4s9uc3EyQdrM5rnvTyMIh/GcwFcG5ax9KBi9pObofMu8iAWu
 KE6COhZjwPSOLVgM1+zd0Mztvkeluxrb2x7x7MDQs0l4BLvW+lY9vcovon7q17DyPkd/
 jcol/xLxB9yRZz8rENYdjnydFhD03APTn+zajAVxXReXVcrHjj9niWqCpNgbEg9b+ZjW
 Yp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977906; x=1764582706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zl/AIacwr5jsJ7XYe78HGxVDkS5eQOZDNQOxismbb0k=;
 b=sYhh2fcN92ERmm7ZTPbrerZAKp2Q4JQil/0NmPPMpAA2rPCmLWUfO/9jHi+8UnmBy5
 OLux19wLvhxzByfE9IHCEKcjsl4Uq0vtCcHMNbGlRFqSAoYhEH2toWamhDRtAE/LQs7+
 Z9aCDrhEd2evg7VKq3tYKuJw6PbA+FUNGKKBHUtxtw5fqzcA01xHNDtlN1vjaECmVQq5
 DEW3i0qEA55tV32T64IuWXJtm2KRurlF5x7IRL+P/fyQ92csxAc3Sd8SYhHWUtk8kp/J
 MHvhq0Mc/SToBUEwnzhtSW9KtUZetLjwhMUTS1pmmX2G9leJj83qSFBn0HaDoo83eWz9
 VOlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbjlje/FSaxdxpeoozdcwCSISanEGtVRvCPWzxxfWvTVOvBxAG5bRxeSBv8wRLkILbyxYg5mFygc6R@nongnu.org
X-Gm-Message-State: AOJu0YwZFzBzxNKO1cemCQn7Q6Mn7+TDu/yLAIPUNeiX5tSei9n6+2Re
 Aw1Ku5URV0OW5jTzqr1BEyOYw14HOHYxxXjCvzsRUmeCkSvaGqoMcepjlwBtmoHT4YE=
X-Gm-Gg: ASbGncsrtRTlJiNqqTHy7jFrCD+sDsOdTDU3nvOVq8n9ffk3mZ3MPLZnuYFzmCIH4Tn
 yjFm0Bgt8feVdziPowibTPtrvdNUy9ZIaqEWdHf3VvBqbxMd13c7i92efpFSWk4opMaoiW5V2PY
 KaGOc4eE5C6783/YDVp7regVFtwkidlfc1UXZdOWjeH+uofRB7AQKQS2z71QiEheECa3Yj5sgnp
 EsquqCo2yZK3wV2IqNuY98vM0HNiWHII8lbg849iGqs4/IktuKTFetkV9e8ryZ3EA/h4I90MhkK
 sFkaNyoAU6h7JdQNck7tNsrBEjXPOCwXJJcz6iiubzOPtsdSL6K82PGu9+GdBO/t92M2AiqZ6yo
 M8eJSJ8JBCXBlYQxSbz5opQNm0+B7ZRb0BVB+EctFPqLocLq1w29gepQaNv5g7/gdSL56E3hGip
 6ZUhutdCI7Cn3WMkMB0jKZjitfjVRvyTapkmCse0w2ixiQGFqO1C5qKpVt2LRQ
X-Google-Smtp-Source: AGHT+IH2/Tv+fYRvsmzCyDv4i5xGEwkB280/ldIObZgBEBwxUUrorxkuBeLcQgzx2S8cgQ0tEkjQvw==
X-Received: by 2002:a05:6000:401e:b0:42b:4139:579f with SMTP id
 ffacd0b85a97d-42cc1d08990mr10764023f8f.25.1763977906311; 
 Mon, 24 Nov 2025 01:51:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8e62sm27291542f8f.35.2025.11.24.01.51.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 05/13] hw/sh4/r2d: Reword SH7750_BCR1 and SH7750_BCR2
 initialization comments
Date: Mon, 24 Nov 2025 10:51:00 +0100
Message-ID: <20251124095109.66091-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
---
 hw/sh4/r2d.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 5fd06b3b731..9de4944ecee 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -350,10 +350,12 @@ static void r2d_init(MachineState *machine)
         }
 
         /* initialization which should be done by firmware */
-        address_space_stl(&address_space_memory, SH7750_BCR1, 1 << 3,
-                          MEMTXATTRS_UNSPECIFIED, NULL); /* cs3 SDRAM */
-        address_space_stw(&address_space_memory, SH7750_BCR2, 3 << (3 * 2),
-                          MEMTXATTRS_UNSPECIFIED, NULL); /* cs3 32bit */
+        address_space_stl(&address_space_memory, SH7750_BCR1,
+                          (1 << 3) | /* Areas 3  accessed as SDRAM */
+                          0, MEMTXATTRS_UNSPECIFIED, NULL);
+        address_space_stw(&address_space_memory, SH7750_BCR2,
+                          (0b11 << 2 * 3) | /* Area 3 Bus width is 32 bits */
+                          0, MEMTXATTRS_UNSPECIFIED, NULL);
         /* Start from P2 area */
         reset_info->vector = (sdram_base + LINUX_LOAD_OFFSET) | 0xa0000000;
     }
-- 
2.51.0


