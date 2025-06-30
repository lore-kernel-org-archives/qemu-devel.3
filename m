Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BEC8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEHw-0006c7-1m; Mon, 30 Jun 2025 09:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEH4-00065Y-5N
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEH1-0004HX-Hh
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45377776935so24245125e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751289013; x=1751893813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+FJk0a0cgOcCeztwLwPBBSDzF3OpAdthXdeLrgGRTg=;
 b=XTpQt4bvJzM3pVhKFj/Mk7MJGqCB079O7nMagqoF1LO2T3LfZ+eUvvys2YKTJ0xH0o
 AeBGgB3005wKKxRkhJNZbOjB0RpPA9TjtphpC6PYuRmucfNX0D3LimoXLFR80Ziwmmbu
 d6dLNFZaIKnxamcaftC3hUqlIOh4dp9F04Ut3MMHSjmlgWvXbjbBF4IF1uhoXDjH8f+P
 /K88FOW+zfV29hpctz9bfmswe5SV33kHiSDaJ8EH0zovkVFBPwmVyT4udkuWGRaGKemQ
 QyeQ+uS19ugBzRe4nZtlbBYv4dTPRw5Asf/WDG063+imJnbp7pIZv5wpZvH4m+592VcO
 1/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289013; x=1751893813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+FJk0a0cgOcCeztwLwPBBSDzF3OpAdthXdeLrgGRTg=;
 b=lVrVcrVxPPzhSKYOhrcg+MWuOrez/qoFR4NMdVKjTSb3RPlIAtkyaiI/uz8h8aBx2u
 ANdZE/bvgiyNZ4YJgwNWWQA0KpdJeMbxInztg9Edw8n2lpkDKYEr+bwiJw8fT7Nbgc/6
 aEoZBUAhHo1zBLEHPIJuDrLQsnZt0GNSHuBkjTx3aIpDm3pLSFR+p5JThhr4KQm4siax
 OOe+28qCbi17HV5jkGTAdAZtK6Sb+pNtK/rTJbKjXZT79mOj1mKz4XfqpzZvQ4j+sTO8
 S0V/tYQ+anmLGFDjjlHBUZWJK+o+RKaXwBFvegrOlSYHBEUzWXNDVMD3MGwltFBQ1k9H
 CGrw==
X-Gm-Message-State: AOJu0YxJXQ5EtUBV/1OUAreOd/q33FfraW6nyIY9Ky/FgvKBjjdFTKLD
 IeEx2kTeUDUlcQtrfvWG1xDKMLZ65tgvkwv0GGmjk8pS8jkbr+GNKruED1PuxjRM+MkD0aqsWvc
 HErFk
X-Gm-Gg: ASbGncv/GWbpE9dE/ciM4jfhxAPKeGXeGW2S+knEwiymhQ7bbrYF4mTRhtqVdQjsD8V
 YfJITfJa/U28xQrV6Yni1GuIrmMhQXa0+JFbc5PBVP7Qlmuj6o7im9sEfb5yG/cNRH85+EoC1D8
 8CLI3HX/gf1LmQGojgFENhTez2uhdCmpCxz6wumSAfJ6oPaYpYrsunvhlUUVWXNp5q3H2cuWSek
 R3xmI8bCPgVnF06lqivXmhnc5bx8VdP1MJRj+i0YtsgWeWfgylONIE1Ls+l4OAIELYml3/4xh5d
 ph1A/8gqDiJS/O6OYbH5RyVKks7hZW7XFOkEkfIOfiZykAJQ6J5Pst3G8xHRHzDjvFSRVvKZwTL
 c9reRMXvcsOIjwmCqyjeXwkiuck0P9oeMkEC+
X-Google-Smtp-Source: AGHT+IEByqu72FkfcvT5uo05D7E1vi0yvvlmhmF3Uteu/Agpq6RjqYSA3xSu6GHZbwfK+UN8hGdH/g==
X-Received: by 2002:a05:600c:c0d7:b0:442:ccfa:fa with SMTP id
 5b1f17b1804b1-4538f516210mr90896245e9.27.1751289012845; 
 Mon, 30 Jun 2025 06:10:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a35sm10549142f8f.57.2025.06.30.06.10.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:10:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] target/arm: Allow arm_cpu_tlb_fill_align optionally set
 CPUTLBEntryFull
Date: Mon, 30 Jun 2025 15:09:37 +0200
Message-ID: <20250630130937.3487-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/tlb_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5c..df04ef351d1 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -349,7 +349,9 @@ bool arm_cpu_tlb_fill_align(CPUState *cs, CPUTLBEntryFull *out, vaddr address,
                               &res, fi)) {
         res.f.extra.arm.pte_attrs = res.cacheattrs.attrs;
         res.f.extra.arm.shareability = res.cacheattrs.shareability;
-        *out = res.f;
+        if (out) {
+            *out = res.f;
+        }
         return true;
     }
     if (probe) {
-- 
2.49.0


