Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8BEC48BF5
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8js-000666-Ln; Fri, 16 Feb 2024 19:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jr-00065v-Cq
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:31 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jp-0008G9-Mv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:31 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso2208161a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130367; x=1708735167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=s6Lt3QDf6aOIOcLl+25gn6fa4ukCa1aQIhcjxdY6QUG4BQm0ozv9YDcW/bd5pFmV20
 gPCxu2OAhJonu75T5dHDZhwZ+17dvH85a1n9xou0Fn+dg0sDwWey+xf+o4Km2A4l7wjx
 X/bVHzmCa8MY6qeHCCcddo1SWXmX4G9UBgqOJIYuktACIT5zzUi1fiBRC6o/uqmSW7v/
 Y2MizLqJf48dNC6Ok1gKpQeHF/UAB/JuxsPVWBaSUyAIEm0lsD3H1hmxHLbfjv8ygKOz
 cdX98190GfluMGbZaVtDQXknzrCfizSW6yTJ60GqrlqEqnyAFbkeSoqyZy3T/pjKisEF
 cZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130367; x=1708735167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=Lu3YHPPNFXOXpzV+f+D6OD35CACvAnUMnoI6DvzL842Q/ckBstFXDMqu48lUkLjzFs
 /AJyMAbVLi88uLC+H1MW5txw4k2ErfN4tck1CqgAgpS138TWGT72PNpaUCq4SdhRck+t
 xWCvjWbQZp0UeuEote7nInpYpZaT3KSy52KVg/jpN8Old+BU6Py51xthpWISDveUbycq
 bf6FF02zzTXu1ZUDjYAYayqbq86rp5dSPBAn+CqRSPhBEOseQmFuFxoxraIg+COwmAFw
 RHyddqvSwpr41kdLTGW7vP6rsK0M6WN6JOalVQrzlq5mg5pOSv0o7AUhKPF/YF4WZifM
 4kvQ==
X-Gm-Message-State: AOJu0YzJChpeNqqyWcOcNi6R6utnkjwxO9sCAD/m0u9re459ij0Rm16S
 GIQ2v6Xa0z/Fr7LMbFVU+nKyN7aog6fWuPhBwVvYGSg8oeeP3SesdyXnKr6arl9NcNXv1xSj6Jo
 r
X-Google-Smtp-Source: AGHT+IGH+gK4NNfMJG9CbRjG9aIJhwlaNzUBq/7+cxLRMnkRAndGw6qY5lyZK3ahs2uY7xCe3dLfYQ==
X-Received: by 2002:a17:902:ff0f:b0:1da:22d9:e7be with SMTP id
 f15-20020a170902ff0f00b001da22d9e7bemr6067832plj.23.1708130366822; 
 Fri, 16 Feb 2024 16:39:26 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 04/10] util/bufferiszero: Remove useless prefetches
Date: Fri, 16 Feb 2024 14:39:12 -1000
Message-Id: <20240217003918.52229-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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


