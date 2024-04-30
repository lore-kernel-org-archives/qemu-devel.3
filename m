Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4291C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNX-00072Y-8t; Tue, 30 Apr 2024 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNW-00071u-1y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:02 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNU-0006kX-Cw
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:01 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-23d5df2d600so100186fac.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506179; x=1715110979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=N88rQM1c5IUmb3VjDJolYhKegfgxGmqPMMbu+0FWDIQrqxKsuCZzuV3NsMQQ6r8tpw
 QU0nvpEkSfA2n+oTSXj7eLh79KTOgXx6hIfEId7QNaFn0Ii202ESF20HYoxirvOhZ0dQ
 /+IrzKpeiROS567MiI9ikyBQytt/FjG6gHWh2E0zYOEzOS54fZmCpcuBpM/NpGWFk8pH
 lFBKEtpoCF1fZiN1/ua/McB4F84DPY27lsIvrwLjr+6QXSdDrV8zFD4CuaOavg3sONWE
 pKDbZ1aK3iue5L09HBd7SJhPuGs07w7Hu/iPwGIHQ+7t5K9kOArowM0Araei7SZc3/X7
 7vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506179; x=1715110979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=LAYreS7BB7OrJ1s1J0w9E53SImG5id2PL58BIAiQIp8s6axrRIdQpMJuv0g0wcBhWX
 GKuPpw48IiFWxA3JjspVeNGDOt3STfKuaW040uuzdALpwcrmdB0YebKwe+NgDlE1DwXr
 xNPwofbY9KwBkuDZzmSg/QyS1W/G5pL/pD0wIgfle82bcisxFaOhiGpJNsAXbDiNysaZ
 oRUKRhEOBIBgPhmaswHrmTUie5QCKPlDzeK4DheXsS5qtmMaM97BrStYfzB0ekJEQ6K0
 YJBDSb5SyWRcP9C27pK4j8VxpawTJmS1ZHTTWgm/RQ1xJVXL9opQ/IL6Pb3hh7kDeZe4
 xIMQ==
X-Gm-Message-State: AOJu0Yxaaubal0baRynM1iZuvPPGffrrD9ZpjoPrhZnS8P9CYw1C9tJ6
 EocGpMEFDHsEBFEBIpm5wzuO629Gc1A06B2tIum8587lYAWRXakgKMHl3xp8DAcNwJmBk/ez2Bm
 s
X-Google-Smtp-Source: AGHT+IHXUDkbeTVDUcOkhKlPSaRFPDoPPT519MAu5Y8RY+CyHt/ZdXA5t8gpSl1qv1+uYCp71AcpFQ==
X-Received: by 2002:a05:6870:4153:b0:23b:f2d0:7b9c with SMTP id
 r19-20020a056870415300b0023bf2d07b9cmr521780oad.24.1714506178861; 
 Tue, 30 Apr 2024 12:42:58 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:42:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v7 04/10] util/bufferiszero: Remove useless prefetches
Date: Tue, 30 Apr 2024 12:42:47 -0700
Message-Id: <20240430194253.904768-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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
index 972f394cbd..00118d649e 100644
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


