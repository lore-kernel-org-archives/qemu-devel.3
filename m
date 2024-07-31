Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDC2C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 21:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZGov-0007pq-Rh; Wed, 31 Jul 2024 17:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGou-0007nN-7B
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:16 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZGor-0002AX-Od
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 17:25:15 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f136e23229so46199901fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 14:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722461111; x=1723065911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmDycacciVDN5eRotRRZuulYkMaRluWb6sjuNguDD+M=;
 b=rDvtgVCKgwsQGA478CUXIzu75jL8QSrmVMfqKRotzBbS/sQvsQdDdyE5Wt8o9voY4r
 Zb+yT3WKMhFhHnTxo+WJHdku3SPr/By8aArsfFR6FWwT3x5XlNkxC4s28ynW4+iLx8wC
 Q5BugH45hl/VCRhej8ssh3KtbPbtJGuqQyXseRjeYn+Ajsfti0R2w8Y/EHoRwj4MLSn3
 qkNnS1COXWtEA8EPkoQo7UPop68Xh+IwjdtCWMcQp6Na+eMf/dnp3etSbxz/FlI7lEk9
 YPXF84DxDLgNglAOaCtvTIfk0XcWxfjz+dJztMJdqArcz30LRazOwtrko9r1B4RdG6g4
 x7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722461111; x=1723065911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lmDycacciVDN5eRotRRZuulYkMaRluWb6sjuNguDD+M=;
 b=bz6lD5TS9Q17+i14b3JhrLzIYN1t3bqC2COH4uPJGlM3kIAATHXSa6hmQENkgoMVTF
 GxkeCUyQp6gLDvZxFbxjBLJD7uJeQlHlm2KgoAic4NRnlYdnPi5ynd4ZRCRVD2Sok7vv
 ja91Hd2SAF5BgpxpfP98f3lbJlqqmooNJ6v/kGkjhQvvmcuTCuyp6leewtzM8qbOd7B6
 FJpq7gb9faxzqzUhZpTLusdF2GtXfLtjRPjynV6ix+a2GS3u7xffV7lesch3tUkKDkib
 470XaBHPDzKI9hRfShYvze9oJisnUhA+ir/91SXX5BO0jGlc3QxzX65LbkFMlgHQuk7J
 EL5w==
X-Gm-Message-State: AOJu0Yy24eOwMfrbpUZV8vb1qZmluNFftW5XPQFLlyvZj94eua56jCPg
 rRzBohMbWl9bi4dVaCFOT77ZtLpkV+wlQnFjgL74ylGA7Q/YI/zRUJD0RbdzUGGVUguB1pgeCnx
 6
X-Google-Smtp-Source: AGHT+IF21v7RXbC4zE2kKVBGAtlj6ogTZmPz2NG8LRoGfLj11Hq+90jT5dDgvIksgMVhMjCINs0qMA==
X-Received: by 2002:a2e:3517:0:b0:2ef:2b44:9977 with SMTP id
 38308e7fff4ca-2f1531027b6mr3324571fa.18.1722461111245; 
 Wed, 31 Jul 2024 14:25:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857d5asm17928671f8f.84.2024.07.31.14.25.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 Jul 2024 14:25:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-9.1? v2 1/4] hw/sd/sdhci: Reduce variables scope in
 sdhci_do_adma()
Date: Wed, 31 Jul 2024 23:24:58 +0200
Message-ID: <20240731212501.44385-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731212501.44385-1-philmd@linaro.org>
References: <20240731212501.44385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

All variables are only used within the for loop.
Declare them within it. In particular this resets
'dscr' on each iteration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 66b9364e9e..773f2b284b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -751,20 +751,19 @@ static void get_adma_description(SDHCIState *s, ADMADescr *dscr)
 
 static void sdhci_do_adma(SDHCIState *s)
 {
-    unsigned int begin, length;
-    const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
-    const MemTxAttrs attrs = { .memory = true };
-    ADMADescr dscr = {};
-    MemTxResult res;
-    int i;
-
     if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
         /* Stop Multiple Transfer */
         sdhci_end_transfer(s);
         return;
     }
 
-    for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
+    for (int i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
+        unsigned int begin, length;
+        const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
+        const MemTxAttrs attrs = { .memory = true };
+        ADMADescr dscr = { };
+        MemTxResult res;
+
         s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
 
         get_adma_description(s, &dscr);
-- 
2.45.2


