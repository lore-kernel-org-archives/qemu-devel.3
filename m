Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DAAC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWu7-0007b3-R9; Thu, 15 Feb 2024 03:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtZ-0007BA-0Y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:02 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raWtX-0001No-El
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:15:00 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-296c562ac70so525664a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707984897; x=1708589697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgkwjOwkXeKSpsaCNpWivSMzmaRHOTSXYP4mzjDgWYo=;
 b=U3PDUSXX7ASKeyKrx7u2i7lRXYRDOkmyKhP4s9QRep0cTnZL+E636VURS7wO/NX4hh
 0ri8EghIHBvrPB1GL2+f2aHgMK6BVmGsuo/4H1AOp7lktXiGmHX7egobiw1IC0/zxVut
 V2nRCbzKv1zM7eKX6wqukGffnYDI+ch+fnn643/+9UXTN4T6bcbYb45UHrAMqqCMvYN5
 H97dcecGvX6wXFsCVLTTsxHEjWPcekit4zGhkXMhsDSCzgNP75rFJ3vKyt7ZVUwTeUCi
 Eybk4RilIwzFeT1W/s9J63ae26lKfIiaqdceAn3l+aLIYAu51rQUgDquDNZqFu8BOPQq
 C26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707984897; x=1708589697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgkwjOwkXeKSpsaCNpWivSMzmaRHOTSXYP4mzjDgWYo=;
 b=YUwPqN1Ass3R1dCkQs3zo7fyeVsx2rA6GqJltHNnJs3zAapSCabl1WF6mHu9RTQszT
 tNgWIifFZckrmn0jiIGWTPGeWonJ8Z2apfTTyA+R2k23ckTIHDqF/Tjmnc+egwWBXfhG
 bCvNRTqkYFXpW71Zu6W4O5wWY2ZoujrNl7ut8uXC/CCFJDL4/leAghZJGhTEB+2Ir8+w
 pXaziebKgltMMzqeTxrhT36y5Tbrf8EIIjM8tQBpftm+PbaJSxzQojPMWLYnyPDTc1vV
 phGRQle9ORLKOq4gv2XscJYhpt50VCbpAKGlKZpkrMY0GFJhzCBJiq+sHQO5pUoeINMR
 qnJg==
X-Gm-Message-State: AOJu0YzFE/O1K7njPuqEd11dONRXa2Uu8FRcHgZoEmXBKCv5fjvgIs+p
 Ld6Dnip9oly7O7mevqeZh/XWgVak8t89JUpnSXPEz/tpl9myxZgIq78hlEQJ7K6RoK5gBGZMRwE
 n
X-Google-Smtp-Source: AGHT+IG9zZ4k/AfypOCpWf54IbQa1Q+gp5GW5Kf1yF8LyFxnNpgLF8TnEShBmWh3tfG++Vr7IDAClA==
X-Received: by 2002:a17:90a:4381:b0:298:c136:2ffc with SMTP id
 r1-20020a17090a438100b00298c1362ffcmr860621pjg.45.1707984897218; 
 Thu, 15 Feb 2024 00:14:57 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 qc14-20020a17090b288e00b0029900404e11sm807755pjb.27.2024.02.15.00.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 00:14:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v4 04/10] util/bufferiszero: Remove useless prefetches
Date: Wed, 14 Feb 2024 22:14:43 -1000
Message-Id: <20240215081449.848220-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215081449.848220-1-richard.henderson@linaro.org>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexander Monakov <amonakov@ispras.ru>

Use of prefetching in bufferiszero.c is quite questionable:

- prefetches are issued just a few CPU cycles before the corresponding
  line would be hit by demand loads;

- they are done for simple access patterns, i.e. where hardware
  prefetchers can perform better;

- they compete for load ports in loops that should be limited by load
  port throughput rather than ALU throughput.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Mikhail Romanov <mmromanov@ispras.ru>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240206204809.9859-5-amonakov@ispras.ru>
---
 util/bufferiszero.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/util/bufferiszero.c b/util/bufferiszero.c
index 38527f2467..6ef5f8ec79 100644
--- a/util/bufferiszero.c
+++ b/util/bufferiszero.c
@@ -50,7 +50,6 @@ static bool buffer_is_zero_integer(const void *buf, size_t len)
         const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
 
         for (; p + 8 <= e; p += 8) {
-            __builtin_prefetch(p + 8);
             if (t) {
                 return false;
             }
@@ -80,7 +79,6 @@ buffer_zero_sse2(const void *buf, size_t len)
 
     /* Loop over 16-byte aligned blocks of 64.  */
     while (likely(p <= e)) {
-        __builtin_prefetch(p);
         t = _mm_cmpeq_epi8(t, zero);
         if (unlikely(_mm_movemask_epi8(t) != 0xFFFF)) {
             return false;
@@ -111,7 +109,6 @@ buffer_zero_avx2(const void *buf, size_t len)
 
     /* Loop over 32-byte aligned blocks of 128.  */
     while (p <= e) {
-        __builtin_prefetch(p);
         if (unlikely(!_mm256_testz_si256(t, t))) {
             return false;
         }
-- 
2.34.1


