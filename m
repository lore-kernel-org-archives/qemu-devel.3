Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6058C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLjq-0005VD-71; Sat, 02 Aug 2025 19:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLi6-0000sj-7t
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:20 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLi4-0005A5-Am
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:17 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-30799a41109so1059331fac.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177535; x=1754782335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=959M7Q6IuKP+g65z4hBcFTVaco9+JWPJ3YTIq2edbMc=;
 b=MlsJZATYMYbHLGfHRWpOhbYToxoktG5Disa6nEDJgMTSvw2+VGa6cAvYBJ3zCFgx2x
 8hxqjpPRpG+RHW5jQSXWaMfzYimpoy7Ghx+fU8dIdsz8BXzg6ipcYWrvAvxV4JP8RQM1
 bcDjjshtWjhRLYjxlgRjIawZtYalmTYuNjVOGfWfq3c1i0FR3ka8W3AvLHVZi7QzcTB6
 DgXLtvVIrAHwHD8JZKesQbI9BfW5N/BmKORTPtDNNTommtdBBiVL5aUxvyclJfMQdFLP
 hqHaMoOCzqAKGKJJFwS89STSazxG0h0qMEngsEs+vadB+AtyzE65mieOlNzFnS1fiLTI
 DPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177535; x=1754782335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=959M7Q6IuKP+g65z4hBcFTVaco9+JWPJ3YTIq2edbMc=;
 b=TDFCwN6ySOm9jeaHlOMcD4xyBma6QCFyxR80LdZHhY2oIuOyhAU5R2StwYhuTSkTyH
 kCBrM0WGZFYjVXx3BvXvov/0MfxPgvbjIxWcR6UaRg3S0ZkvXsjU89dIKu8PJijAkexY
 BRKxXDGoesBZ0H5IetydD9Fpl5RR5kya+QYa/rCaVDKDTsCTo0aaGEXvwpNDgbnf2ZJz
 T9cimOQYSZIUp9ZIJ025jAWbdWsZz7mkzRAJk2pF77QGzF9/EZWOWwsjdAhX2YtRKzIa
 UtuHF0Papc0/J/ZmI+UqW0W8SnbINXN7RkMDPTqK/YqkxW0Mc1UY6AdA6wpHnulPWfEl
 EtmQ==
X-Gm-Message-State: AOJu0Yy88vfBs/6uzrNbYJbkqKczjRx+vTBwtfltVMvUnpNPhgQFhcnp
 yM8mO6UdDdqLUCKGrJiW35wwF2BQUl07mr6TFjs1mzbqpqPh1nvUpub3H//HVHGtCLMObX7lCuK
 5Lx7CJlw=
X-Gm-Gg: ASbGncsKv1OzU/TaxeDfEGsN0eIaHAqPhLvLuNMijJ9u+pDsibcLbtXGA+Q748K3Q1t
 /9477FMYo/GYzN7kXmrwaLKaretgsXmmmrZeWVa1CQWskcINQ5GveQxd4dD1i7zFncq4mvJvcZT
 Oy26dpOEdkmE0RKypZCboDQDf/x+FFJ51wJrBCdB+kjLGQoondDyCs6mWObILuUYNCSoznVb12w
 9j8Fm/POjPD6ui2H10Y67bHIBfu+Pq1mab9X+eVGvMABOH2807WI3ut4e+SrLW1LSEnQB4B8BcJ
 TfwPiTT9Qw7CJlyMR7oB70/zT69BWoM9vyR5IpnIAGo5GFAsrFO5MA35CSLDqYEGi8adQgDbywg
 jFINwvf9pUjaKCZSqGryCB09szsN82mDLPJUzfa3Gsxk1NANLHB+B
X-Google-Smtp-Source: AGHT+IGY+fVi2+ldJDyqTOHUDe5qcjUcbmXULIvVhC72cV+g1+sVHiEmKjnPOz6iBG9VY32gn7HydQ==
X-Received: by 2002:a05:6870:b289:b0:301:a823:9cd1 with SMTP id
 586e51a60fabf-30b6793c06emr2353982fac.22.1754177534856; 
 Sat, 02 Aug 2025 16:32:14 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 28/85] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
Date: Sun,  3 Aug 2025 09:28:56 +1000
Message-ID: <20250802232953.413294-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

This array is within CPUNegativeOffsetState, which means the
last element of the array has an offset from env with the
smallest magnitude.  This can be encoded into fewer bits
when generating TCG fast path memory references.

When we changed the NB_MMU_MODES to be a global constant,
rather than a per-target value, we pessimized the code
generated for targets which use only a few mmu indexes.
By inverting the array index, we counteract that.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 11 ++++++++++-
 tcg/tcg.c             |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bd835b07d5..23eb849a9b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,9 +594,18 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
 }
 
 #ifdef CONFIG_TCG
+/*
+ * Invert the index order of the CPUTLBDescFast array so that lower
+ * mmu_idx have offsets from env with smaller magnitude.
+ */
+static inline int mmuidx_to_fast_index(int mmu_idx)
+{
+    return NB_MMU_MODES - 1 - mmu_idx;
+}
+
 static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
 {
-    return &cpu->neg.tlb.f[mmu_idx];
+    return &cpu->neg.tlb.f[mmuidx_to_fast_index(mmu_idx)];
 }
 #endif
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index afac55a203..294762c283 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -425,7 +425,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
 static int __attribute__((unused))
 tlb_mask_table_ofs(TCGContext *s, int which)
 {
-    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
+    int fi = mmuidx_to_fast_index(which);
+    return (offsetof(CPUNegativeOffsetState, tlb.f[fi]) -
             sizeof(CPUNegativeOffsetState));
 }
 
-- 
2.43.0


