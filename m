Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828B0C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 22:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKo7-0006pS-Dg; Wed, 12 Feb 2025 17:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKo0-0006mF-Vg
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:05 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiKnz-0004Sh-3R
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 17:02:04 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f9f6a2fa8dso385328a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739397721; x=1740002521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/3NCvQhsPJBcYgbNLjU/IfQtvrFLzD9kkC7dHgef6s=;
 b=Dab35d7UoGWbmz7mPvGaEpLvMCLljOMY4DrttgUjDs3pNwesfmGEO7p9cSxxNBU3uN
 IL6Q2oElQGtUxFvzkSoKXY/5mrS1SlobDLDB9N+eDExXixCviRRtdPCm9fymUZjp6r3R
 l5hNmkdwrmj1CaGocmU8CQVK+Publ9nhWoVLrZ4NskPqrIwXjY2u9lxVfBvkSn2f9iOa
 mMQB7J2KSHiRqQ2jLmqKsNP58fR4jXEbs7Jtt7ZnCMvJQwMi9j6c1ZK8FV5qFhJXJS2Y
 aEpgfIyVa2N38ZEtI1b0bLE8hJ0n//0UC12/ajzfFCpPFrsSPgYDdCjQXNCRNRJgyUt3
 tRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739397721; x=1740002521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/3NCvQhsPJBcYgbNLjU/IfQtvrFLzD9kkC7dHgef6s=;
 b=KL6EI5PWO5QdCpDtIN2u9s+8uOJQ3h4ZeG+kSBlDFBhX8dBnU+uCtuA3LokLeRE/5h
 HwS1aVSGZuPGoudWDEcz0u7ylmYt1kzwEoRL2fHJ8fyHDcSuhtrvNQlKEEnXR2F/qb/i
 3jD7asIssVaXnu4GEwMxpSiTLZcXa42Ael+9dcDk1PDYk86+ka83/R3Tu5GZ65VVntYU
 vgiLZ/ifQNuaWiWuDEmfuo+LjTGZ7j20Ts5nNJkmWrDdx8Zctpb6m+8GOX5L7jzUtpkl
 Es7T8ZRHsneUQfhcWHDqxgbF7cJO1r/0hmz8vbw559lQBPCnYjODcn0jj7RvmOKgvVj2
 qy9w==
X-Gm-Message-State: AOJu0Yzynpb2fXZEjvEveN5pxhRE3Hdc8/pbSjxwJVbnDqzHdnGuC/nG
 Kt9KOOdbEE7LoRKOZgT1GCh2+izNTa4QsDwE+HpE1fqcHel+l8TqU8qJIrhuBb467Dv2tNQI5w9
 P
X-Gm-Gg: ASbGncscTmnK+pCIklabz5mcxOso3sSOTa6jdE0qbJh6V/k5O5+n7baKOXWLl9TXem4
 WQhQJeqBBUJaETlOYzjqR60z2w670ZdbWuWy+vQWejqgWz8I3xccyQ9KHH8lP+dAlXU/7ag2MbI
 75BTLqobSLjXBV/tPCuMcFJTlVRyqHMvqfqdSqcx0gCIA6sw0BL36dcVdvO2RfS5E345emeGIZq
 TRKjtBaNsePYcfE8ni0Z4YVuTIcSFZECuzAhFKU0C0phQT69dMDv1A5X41baGI+Xskv0F2/rv0r
 VbePXVqAxpLZuHqWKi7sPOclPb5+3St4rSlmPRQFV+wXKQ8=
X-Google-Smtp-Source: AGHT+IEjCxoifaKA/oGwLW/HdyLDhpQe7sDdL2Iexp8O/PsOK5oeJ8Bj9wZ2aUFNPlnrUkW2E94MkA==
X-Received: by 2002:a17:90b:5241:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-2fbf5c29b11mr6950540a91.21.1739397721539; 
 Wed, 12 Feb 2025 14:02:01 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98b4c52sm1964837a91.4.2025.02.12.14.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:02:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com,
	philmd@linaro.org
Subject: [PATCH 6/9] target/microblaze: Fix printf format in mmu_translate
Date: Wed, 12 Feb 2025 14:01:52 -0800
Message-ID: <20250212220155.1147144-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212220155.1147144-1-richard.henderson@linaro.org>
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Use TARGET_FMT_lx to match the target_ulong type of vaddr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 2423ac6172..6152fdafd5 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -170,7 +170,8 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=%" PRIx64 " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
+                  "MMU vaddr=0x" TARGET_FMT_lx
+                  " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
 }
-- 
2.43.0


