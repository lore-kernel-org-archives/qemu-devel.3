Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2377D6100A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJ8-0002Q9-Bn; Thu, 29 Jan 2026 06:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIn-0002Ch-Ts
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIj-0007wi-N3
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806b43beb6so6695765e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686504; x=1770291304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InrpoKttAgPvW62kHr9xgGsggByur+EYqp0VZlf3YkM=;
 b=qSKF6xbIpHYrqpaohqXb+l7cCvk9qYbc1CISCRsLIf7VmHz5rLo3ZgvUOC3f6jZCpV
 tUe1+RxVM7LL4rEiMTEmGeD872WkkHNr9RJqKKNncRWZPQ0iuR/YLhUZYGGDbow3u5lJ
 z1JEIqwVypsSags4F/1uWvDhUzxqIZI9qCAzWs13acF6s+w7Dq5HDH4o2LRYixo+i+Aq
 MdOub2yF8sO5xrmUaFEHTw6NqzgdOF2B13gxPLT9tcdzkF3DdOshBPspVqja/Ebaqbso
 Mt9SNa0YRTcx9h4YTbMDOay9Bvnk0N9v3+WPtmFYC6bN/XYPJZ6LiWw1Q4keFnQgQW+t
 H+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686504; x=1770291304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=InrpoKttAgPvW62kHr9xgGsggByur+EYqp0VZlf3YkM=;
 b=l/vK7noL4GA1PpzI/5fmSNXm81Hagej7P0V4uzxBKaeDmursaPll+HM/LKUBraGIiW
 rZlq5jytAciyqHSVL5EyvV6Pngv9u4kYEKImAmc1+me8M79ioyqKiKhyA2j3bQ+UnkGK
 hmkRyIRAtb05uPsyU9mhZZbzJ6zbQ7IDk296D+pHH9PrKIFVCusObJHMgOV33HWrb7Jp
 B84rNhSZMDz2Hy7wQxnWmQxC7URmErB8ge7LTAQ5uWwrjQD6BpjTiaTVFy/ZRPsc9CHw
 sikqU76gB/46j4xy8A8eTyQvdlkrpj/GowgxXwTz6C5+XZdZpoVLY6NUW22T/m9HqA4+
 YcEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6EUeyFi376gdY9s4FhQqJ8y5fU+sx0T6SlYmpO3G7anUW8YnSaIVGTCZIxGljK7m+9taGOXFB92au@nongnu.org
X-Gm-Message-State: AOJu0YzR0gMHgfK6EbM6TKHM+GBbgHOhLNWZSVteG5ntHe6/7fvc6Sks
 UcgTQazFtrdS8duBQE9T02QaMELLe5osCjMkkvlQIam3/izOf/NuTu4hWITTnXrRNwA=
X-Gm-Gg: AZuq6aICvu0FY5JpN94XLs71nA0nlQ3uVRXeIjqWiV/ctNV9Xf56SzLjvEIvSLdC9I4
 AqCA0zlGIceQlUwSQ7GZcvxL0eqKsoyf0YIXcwHOJkpWyf2JtLUpucocsNGWRQV0786bjF/d35G
 C4A6MiB1zBqOcxsHBRZ+/GU6M2GyL0MFU2pPi+bghirkCo3iok5gSJ6SJIphA26+d92nwqZsR5O
 OmHvAKs9MVGVf6nWbg1e5gx1OeM9GeRIQrsuhEslAd8UhQjf8rRirrZQSK6dRoTDolEcLHZMS3w
 J8iOXEktxxmZtUV0gpRTtfw5y/DjlHMv1sD4TQhNd1zcH6If/+8Z14+LTIztHXHg6Jm+0GYUF9e
 RcOW2TxBdL2WnZQsBqhSwWXifIw5vLnn9zn3CEOl5Xe9US2s0CWnkQYnRfwIQvv6HyXqNu1pQIo
 vbvUg1FsB6On3YznzX0R+TSaElHYL6wg==
X-Received: by 2002:a05:600c:350b:b0:477:9976:9e1a with SMTP id
 5b1f17b1804b1-48069c0def9mr112433535e9.6.1769686503824; 
 Thu, 29 Jan 2026 03:35:03 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:35:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 5/6] target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not
 present
Date: Thu, 29 Jan 2026 11:34:54 +0000
Message-ID: <20260129113455.1283266-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129113455.1283266-1-peter.maydell@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

FEAT_SME_FA64 allows Streaming SVE code to access the whole
SVE instruction set; it requires FEAT_SVE to be present. If
we have a CPU with SME but not SVE, squash the FA64 bit in
arm_cpu_sme_finalize().

This doesn't have any effect at the moment because we don't
let the user create an SME-without-SVE CPU, but we are about
to lift that restriction.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf30381370..e8c56fc81c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -363,6 +363,11 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 
     cpu->sme_vq.map = vq_map;
     cpu->sme_max_vq = 32 - clz32(vq_map);
+
+    if (!cpu_isar_feature(aa64_sve, cpu)) {
+        /* FEAT_SME_FA64 requires SVE, not just SME */
+        FIELD_DP64_IDREG(&cpu->isar, ID_AA64SMFR0, FA64, 0);
+    }
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0


