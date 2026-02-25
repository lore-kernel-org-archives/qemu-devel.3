Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C43FD45FB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOCo-0008Ll-1H; Wed, 25 Feb 2026 18:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCh-0008DQ-SK
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:22:04 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOCg-0004Po-AL
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:22:03 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43994aa265eso123688f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061720; x=1772666520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yUHHzNLW9fNVWSnAmzyP6tdjio2zMgW5rP98YdRZAU8=;
 b=F4/nZRTh5tPSMFFY8ucLqr0+PUAZ0ujGVkFplLNbCsT3d7UVZD1TWaNA/ebBH6N+2T
 /HjRtVPbo7BTCf+XW2aSuJq1W2WCEdEnX2mr0cmxFv3DKcq9jlobrg613yvIuLM0wg95
 hLRgmZHhfFF/Y/2ScdfzFiwxVmy4SX1E9trKOu2KpOm8Rp32GWMbw/IOu18AQEgxJNmY
 ostgdix0vZgvD31PN7U1l1ePVePRu4QdvY85na99B0FaEKApVTSUeP+UkIYXusZ5YxSQ
 elT157vsbhJK4BOhu8Gsycs/+7Jcijnyj1DDBVa9kimXvbFlea8rG2g0ELDPSoT2Vqes
 m4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061720; x=1772666520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yUHHzNLW9fNVWSnAmzyP6tdjio2zMgW5rP98YdRZAU8=;
 b=gAonXFXMSEkcYSfwYSRrYExVPIczx4mXHHMl9hE2puqzSJOMEgocZzhHsNg/DUoFMf
 jtaWIZZ6Nv9OsSItYLTDjIvlKreQ9rNXTANtjuI+EMpmdknXOd0tZV10vvyLjziF5Zhd
 N9ayf4XrTYxFe8CHPpQ73zNg4+ZCe28Qpg2kKKN8jCq6M2QtrPXFqUGycyN00NGyLY6m
 j8YCvLLBO4UIH1vk9rboGogUVB2JPnRahHNqbZHuYHh4lj44M5aODQVB2eziGojXHbWH
 qLu1YulUlnMEdW3b2m+NBY7KtvU8O0j0zn2eNghNZZZNm7iLf44vfdaMXMEI/kARmmo7
 iWBw==
X-Gm-Message-State: AOJu0YyFhc7ZSScxhAWbkb9OumKPo3jKr225Ep0xY2695VdNhdr0wZWg
 nQolGkn8u78HAhJkpT4xGzLXMrmddrZIyEcPXVJTCXNi1ZNBsTRGYa+K7ruE8n11A3440Ep3VnK
 5MUCl7kk=
X-Gm-Gg: ATEYQzxN0sBVwF1ejiYvlVVXcgArNS/on2ixbNQP7goq1W7ewaQzWcaCfwM/Zsmk6cR
 8bMG4U7LmEw91DS4NOzJuM52T/Ols02P6zqWx9AC/Miuh++bPjcbQys6gCReMxgagdCGknOq/3f
 +oyMJiMNurOLtAxdT0i5iyrervZ+HaOYmsXTuQI84OYPIs8SXhy6HKhH/BGrDe+N31RBg61cmVL
 Z9R5arrA9pSPpozzFO4vbwn0k/IgWQFc3LSePVtziFKuIfza+YtBVSSPU0JTm7d9+JaBjWot9Eg
 q8T0OoznJb1NYPs3GMZe/y2zqblJSSGRaycM92WX9T/zjDVGtEB791bAtlsAX2wewMEHnLK744j
 axlCRLzDjh0d4EW1D6uYa0uVx8LcMmx6KdIHDsuIXzz6EDddhYBysQDO/35PKWyVCLcyqwH7OY2
 gAulJQqBNTqKACAPgENwuRun5hj2oPpMBh/2piXoF/QMsz9lyaare1S7U5KZaLkwj3z3jV5HJG
X-Received: by 2002:a05:6000:290f:b0:437:6efe:94d2 with SMTP id
 ffacd0b85a97d-43997eda581mr539069f8f.4.1772061720376; 
 Wed, 25 Feb 2026 15:22:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3ff27sm38839465f8f.22.2026.02.25.15.21.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:21:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 69/70] page-vary: Build finalize_target_page_bits as common code
Date: Thu, 26 Feb 2026 00:14:09 +0100
Message-ID: <20260225231411.96482-70-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Use target_info->page_bits_init to merge
finalize_target_page_bits_common into
finalize_target_page_bits in page-vary-common.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260217095106.598486-6-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/page-vary.h |  4 ----
 page-vary-common.c       | 15 +++++++++++----
 page-vary-target.c       | 12 ------------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
index c4dc56634bc..f2d735bec2f 100644
--- a/include/exec/page-vary.h
+++ b/include/exec/page-vary.h
@@ -40,10 +40,6 @@ typedef struct {
     uint64_t mask;
 } TargetPageBits;
 
-#ifdef IN_PAGE_VARY
-void finalize_target_page_bits_common(int min);
-#endif
-
 /**
  * set_preferred_target_page_bits:
  * @bits: number of bits needed to represent an address within the page
diff --git a/page-vary-common.c b/page-vary-common.c
index b41137c644d..ddd08633788 100644
--- a/page-vary-common.c
+++ b/page-vary-common.c
@@ -50,11 +50,18 @@ bool set_preferred_target_page_bits(int bits)
     return true;
 }
 
-void finalize_target_page_bits_common(int min)
+void finalize_target_page_bits(void)
 {
-    if (target_page.bits == 0) {
-        target_page.bits = min;
+    int bits = target_page.bits;
+
+    if (bits == 0) {
+        const TargetInfo *ti = target_info();
+
+        bits = ti->page_bits_init;
+        assert(bits != 0);
+        target_page.bits = bits;
     }
-    target_page.mask = -1ull << target_page.bits;
+
+    target_page.mask = -1ull << bits;
     target_page.decided = true;
 }
diff --git a/page-vary-target.c b/page-vary-target.c
index d388c5c3d64..bc4d8931b68 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -38,15 +38,3 @@ int migration_legacy_page_bits(void)
 #endif
 }
 #endif
-
-void finalize_target_page_bits(void)
-{
-#ifndef TARGET_PAGE_BITS_VARY
-    finalize_target_page_bits_common(TARGET_PAGE_BITS);
-#elif defined(CONFIG_USER_ONLY)
-    assert(target_page.bits != 0);
-    finalize_target_page_bits_common(target_page.bits);
-#else
-    finalize_target_page_bits_common(TARGET_PAGE_BITS_LEGACY);
-#endif
-}
-- 
2.52.0


