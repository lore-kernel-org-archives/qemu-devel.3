Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C72BCD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 18:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpuNO-0001by-OH; Thu, 28 Mar 2024 14:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpuNN-0001bm-Cj
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:21:21 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rpuNL-0006CZ-QA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 14:21:21 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5a467dae51dso447513eaf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711650078; x=1712254878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pFViSSelBLDC7jQWPNWKQ58HUVyc3Kf8+NgXdrfBUc=;
 b=WC3v60+U1hM4ve9DWcPktZrRGR4r2g+wsfK+xEMRZKZcpSmP+FqvLnoVGdajW8o1a9
 sTaWeSiIC/RoH45Be+0WBds0PrJeeJMmpsNHHdvEhMEcUC5hcjE1LDCB7yyey+PNp4J9
 +MLk265IlOQHBEwZ98bDkiTB17MR3bYeWC3HkBMKKUPw3x3hFCuUs/ZRipolCHjbkeNj
 +kCqEB+IRPdOjjfPGjBWEoSwbGgOAXGP6YzYToMTXUxlyOaZ0oZPb3XCcqpMan6dW6Jm
 zCbfxNyE+4OUEvKZleYALcGZkXQCDwDAjtVTIIxGaaBuQNoM6MmPVLcyyal2eSF+knYL
 3V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711650078; x=1712254878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pFViSSelBLDC7jQWPNWKQ58HUVyc3Kf8+NgXdrfBUc=;
 b=vQcfF0Le5dpcg3M7C5k+hihkRFfPBQfjasVcXzEX1jeb1YRQs4eBG8rQ3TrjalavGU
 Vo7En4vSbrSnpC4/8P49uUZUVZIMVgB/xbDuIhXk8I4hIx+//uD7ZGs9qdCku6vbnFqw
 5lteZ5Bb+4CrW0OLHVL3gBlJgHwvdgvD3sjcKmfnmJA9xqongJ7sx7bge0XTD2zhn73B
 VFNLpW2On8mov4hp739I93WK9BGfxRckkkpvc+SAs3SLmYuUM6E5K9VoxAYEfLO/gmmW
 xJP/pr/0p7dr2eNQSd9K0zNCkTqBz8XgoNtOBTvF846eiWzZ+uQiugaIIgPVj6R4jU+p
 LxLg==
X-Gm-Message-State: AOJu0YzD2NlCO4kvTiyHJ4iB4ri1DHVOdfFYsKLRIB9JDtkg8zaWg/DJ
 lZPg9zqrEqVfugBy/4hMfZBVGifFwVGflcMMQspIt2eBAu1+CUt5npi9jtv0lZ23Kh3Goc9DQo9
 M
X-Google-Smtp-Source: AGHT+IGs2Ka0Kr3GCEHdm9bJ87bbsHyQ86uZAy4wPOpZ5pVbPs2x2EPiCGHUKYu4uAfkMbLm+2tcqQ==
X-Received: by 2002:a05:6358:2612:b0:17e:8ea3:83cc with SMTP id
 l18-20020a056358261200b0017e8ea383ccmr137852rwc.24.1711650077994; 
 Thu, 28 Mar 2024 11:21:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a63aa08000000b005d6b5934deesm1594374pgf.48.2024.03.28.11.21.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 11:21:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.0] disas: Show opcodes for target_disas and monitor_disas
Date: Thu, 28 Mar 2024 08:21:15 -1000
Message-Id: <20240328182115.1437442-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Fixes: 83b4613ba83 ("disas: introduce show_opcodes")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/disas-mon.c | 1 +
 disas/disas.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 48ac492c6c..5d6d9aa02d 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -34,6 +34,7 @@ void monitor_disas(Monitor *mon, CPUState *cpu, uint64_t pc,
     disas_initialize_debug_target(&s, cpu);
     s.info.fprintf_func = disas_gstring_printf;
     s.info.stream = (FILE *)ds;  /* abuse this slot */
+    s.info.show_opcodes = true;
 
     if (is_physical) {
         s.info.read_memory_func = physical_read_memory;
diff --git a/disas/disas.c b/disas/disas.c
index 17170d291e..7e3b0bb46c 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -211,6 +211,7 @@ void target_disas(FILE *out, CPUState *cpu, uint64_t code, size_t size)
     s.info.stream = out;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
+    s.info.show_opcodes = true;
 
     if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
         return;
-- 
2.34.1


