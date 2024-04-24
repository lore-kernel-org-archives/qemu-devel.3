Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6A7C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzlYP-0005TV-3l; Wed, 24 Apr 2024 18:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYI-0005PB-OE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:23 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzlYF-0001mu-Uk
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:57:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f0aeee172dso308397b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999438; x=1714604238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=dIkgolERSWYXhsFzfxo3/NE4n7/13xtTcWddkyqqpEeUF/kIAy1WPT3YZmjDbBi7JW
 jcuicdnEO55OeRrkYBZ746HmOR05Yx8PVrZ7CPjZarrfIlPn3SZvciBYBRLa8BNslgdL
 nInt77x7Syx9pD9hq5Ej06yYXvCsgx4A0PkWNiYYgWf5CwGms7cYUkM18xhs70tUPmx3
 oHQNKSM577JHubEVHshpn+u3i1vBCAZ4nkPy/VPx97cUbWiSf3RaRMqdcj4QgbhuqeXV
 tR8ftzQNqh753MroFVwPBxxFjSGFSiJvNJkSF7tg5F/5l3RO3IUh6hG84r8GFqHeve31
 c9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999438; x=1714604238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPMJ9Fq7Hagw2E+aglC+ITwqURcRV1FccXRLb5FLQFU=;
 b=F/f1AzC4ze12+Q4srNmvWFeoslxAsMBcDtzGyfK6TCx65FIIH49uExv3lNCwyhXnwM
 CrD/0M5AYFPr0qsK5D8fwOrMVKlV87p4rBkE4V3XwMs21E3oBHlY7fqY67m5iZ+flVoK
 NK7ZTOPxdagB6q+yWEzLgIhupUX11/vlN3joVbfy+myOAf2ES6xvgDA1oSvHtebgjTPA
 yYwGbfBcRc4P8wLsTuv799S7SNnFp6zE1XEQkCwnA2B0e9jUIB281nCgT1aKjBDVCLdP
 t3qN087/N6GJoFqBtbVXBFEDH+7PqQbgjWmPO0ONMeKdf6JcDGNQ2d6iBs1oKUSzryht
 kFVA==
X-Gm-Message-State: AOJu0Yy0LPLKox/hfMV7IPSo2kly1XIYZDh8boWhS16eL1seKIvHIVSe
 nrKOtNfvdUfFYLy0K8aZEybiRAPZGfFgl1F97oHHoGHTIe64PeWqW1l8fV0HeIGFQM0+HNfDNO0
 l
X-Google-Smtp-Source: AGHT+IG+aiJ52E4jFEMENwRPgtfatAPFgLiEoiDEeE6YiyQXQDoyP7NjMUUkkMZZdxkOiPsIyqJAsA==
X-Received: by 2002:a05:6a00:a86:b0:6ed:2f0d:8d73 with SMTP id
 b6-20020a056a000a8600b006ed2f0d8d73mr1623257pfl.3.1713999438469; 
 Wed, 24 Apr 2024 15:57:18 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 gu26-20020a056a004e5a00b006ed9760b815sm11947413pfb.211.2024.04.24.15.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 15:57:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
 Mikhail Romanov <mmromanov@ispras.ru>
Subject: [PATCH v6 04/10] util/bufferiszero: Remove useless prefetches
Date: Wed, 24 Apr 2024 15:56:59 -0700
Message-Id: <20240424225705.929812-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424225705.929812-1-richard.henderson@linaro.org>
References: <20240424225705.929812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


