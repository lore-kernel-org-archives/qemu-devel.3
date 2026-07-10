Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DEFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiIKG-00035d-3t; Fri, 10 Jul 2026 17:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIIQ-0000yE-4X
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:13 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiIID-0001xB-Iv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 16:58:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1237580a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783717072; x=1784321872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDiSL4skeBdw/QfZ4bPcuanFzLKyweW4gBYzMWPnN78=;
 b=SWigjjwV+adHRAHruT2Xzf4LIZ/QXekhl5kA0EvV/cGTTxJjhPwtaDkfEp35/n9uzq
 hQ+uKQ1Xjyxsykur9kI8zTq6EiDLtTfLKBzKd/mGCp8RdCe/ptxohScWZJDCqHhtTYPS
 0rfng+ByxQhUS9VgGypuw7XFDrF1nF362CFcaDX7D0jn9naGvnP9EySQ4ZqpJSS39TV2
 UQe/ldUZPvp5ZkAA7lDMeiU0+OFrfXQXDE8+EWYDFVahuhEoqxkkcPMF9O7e01RYS/mH
 BA/U2hJHub7wxTYbqX5GVahcN3+9gdVS7Do/wba1da75/Gq/urmZzIKrjcVFDw2kPOvP
 W/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783717072; x=1784321872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XDiSL4skeBdw/QfZ4bPcuanFzLKyweW4gBYzMWPnN78=;
 b=oMGpo7JCiHV4JbITCGKo4Mqla/1X0SyNU+qdLEmN8PO+qMUvfhvvQzhHVSoJFK7vty
 UUFdj5ZF04aXCVGEenoteMTUYx4G+Dghk7Pzv/xMzlFVRUjdT/tGIrEIaTiS3bBjLvCP
 3ZZAajizYzuCAZ74wXUCxQEaDzGLI/n7VvpH3sh5CZH6Ui25T0a2iM7v72ViKQb9Tb5v
 dJMU56cMcMK6JV8NuwBLWhBDPgYefFKv2Y9J6IZbG2dLcKmSs2J/k9JEoobu7+lEd8A/
 O8Wn8TXnSdhujea49uFNacXfM9wqT2ex/tbpdyhwSOxVt2u4x0u66hEVDZ6PmW2lby2O
 dcvw==
X-Gm-Message-State: AOJu0YzqKJKb6nIiS3u1PIJHFWQJdDAIqhgr1EJhYMXLdYsTzoNWelMK
 G0XKpZi/UOvAERggcyv2R8ZzK/E18O6+SNXN5nFV9uPRieh1CBROt7QcQvx+F5l4Qp5qjPY4rHG
 O9haY
X-Gm-Gg: AfdE7cn0sMUZeMkYgfb1Zg+8+BGACwS7TN8HjHUU/RT1RwNVh3TNIqYYsVnmmvTo+Iu
 QNKKhZCWaoajR5eLIvDjT/uHk2DNpqc90mi7ZcsdtpqJr0ZaeUgUVYhFn+UAHLpB58OpOGaUhYq
 6TZtdMlzU+8fmztkDK7OxGUfzexuNWHYyRwdgoYV/L0H+XUhYfBaegbDz/WzwIHwxi/noYbAcp3
 DtUqITz2LfR9LGiXazPjI5y4lQKHeqVGC0EpTnDgarkqxdXxZMrd+Cs7ihX8AaAno3gTAC1i9HO
 m8iNliAKIFUaOjsTY7RjxbNK0JY9dL8MRvq/MuzX+HudVUOgw4BNYz2yA6yfxmcnPZd7UfYWoJN
 f2aQo9yybFIa8A1p3UZZE70F2tqyB4c0NWr8BbVQKJX4GpaG3AMtN/WuSmDkBhbDZ5mj6JdfyQ2
 CoLpidJZvmOkRz46YKAw==
X-Received: by 2002:a17:90b:3806:b0:37f:e326:6559 with SMTP id
 98e67ed59e1d1-38dc7b37972mr513114a91.22.1783717071586; 
 Fri, 10 Jul 2026 13:57:51 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a58792cdasm3256221a91.16.2026.07.10.13.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 13:57:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com, qemu-stable@nongnu.org
Subject: [PATCH v3 48/51] target/arm: Be more defensive for invalid
 tlbi_aa64_get_range
Date: Fri, 10 Jul 2026 13:53:58 -0700
Message-ID: <20260710205401.836304-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710205401.836304-1-richard.henderson@linaro.org>
References: <20260710205401.836304-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

It's possible to program TCR_ELx with an invalid granule size,
which could match passing an invalid granule size to TLBI RVA,
which would then fall through to assert in arm_granule_bits.

Cc: qemu-stable@nongnu.org
Fixes: 3c003f7029e ("target/arm: Use ARMGranuleSize in ARMVAParameters")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb-insns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 1a0a332583..b24eb57788 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -854,7 +854,7 @@ static TLBIRange tlbi_aa64_get_range(CPUARMState *env, ARMMMUIdx mmuidx,
     gran = tlbi_range_tg_to_gran_size(page_size_granule);
 
     /* The granule encoded in value must match the granule in use. */
-    if (gran != param.gran) {
+    if (gran != param.gran || gran == GranInvalid) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid tlbi page size granule %d\n",
                       page_size_granule);
         return ret;
-- 
2.43.0


