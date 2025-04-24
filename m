Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AA2C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lGz-0005cl-Er; Wed, 23 Apr 2025 21:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFQ-0002hY-Sy
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:29 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFN-000799-Dm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso372904b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457563; x=1746062363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tkF0mLdUKamGU6WMR2w37sZaplycdM+4ocMcKEopH7U=;
 b=zySMuK7kL+9uY1NwsSZ3SVXC2aDPpquSLIhPfxne7pRjvqOY82iCskKw5hXf6WjfrW
 sJM0y0CAAyHeKJPkrvAFXKxRJjnPH0hiD+ypscUaX334OCZMe9DBhnI2dCLZpku5jYR2
 Du5S80cz+azHJ7VqDcVGtxLd2o6GMXr09z/TItxpG1F8faYehvgEIByKZSVWhXPoz000
 SBQNYaldBG09XHrm6D5qjV27y+rw0oV3vjxUcSyQBm2SkHtD9xyaVQwnht0LGTtCkCfP
 M9nYiZ0D33LxZNiXkZbqeCgsDnjTJUKTUnoo0novJQwWUYrAZwwVW9ZJrTQX+ntIaib1
 xhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457563; x=1746062363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkF0mLdUKamGU6WMR2w37sZaplycdM+4ocMcKEopH7U=;
 b=B4iKLZuOHq6PQOuBJbqLyUDBFjTO4Dycy/2U66OG/z1+b/0FP+iQ80P58kSJUZCF7t
 xK5czP8cobY8eLg252ZvroUMQjc/NWHfv/zhdHGGSb4YSb5N9gRQ2fQWq/aTfwvC4a0g
 ZI0YlN3Z4yqQHTqT/0C6rGAiAp0U1mJScLqAK+SyPeAQ1czvHTIEasI8qBmPkoagUU0h
 YyrSyFcBCqA3n1Aa4uDBqaVZI5YQJtEiLFKyZfL3LDgKH1L11mkhApB9UbDs/3KYFJw9
 0EoqRls1IUPUXliC7VDMjNYlqfPIXTQAIDTo35NKSuYidm2ODQzWzXNMbwLDrxZDKOB9
 d1UQ==
X-Gm-Message-State: AOJu0YyJh+abhPVVTx8NCr4cJN/m6aGxIzATuUgmiA3BwlDVXfgpyhpa
 yHl2emVR+cZjadX60fAd8boN9xNSOuutMfdIC46z5u/n+lQpfNJ8T8Q7xyFT4ABjhcgZvt1zjh8
 p
X-Gm-Gg: ASbGncuS7cI/b72pZN2l3mzXHaqXjSsyFvPnAKgawDECjZLms+3xWnZg7MjVWTvdyH0
 VIj32WWPVnH+0nl+qSeXlwJnzojun+PrYNJ71Es+vt6kktkiE1/LyKMSB1nbj62q3dC/qw0enTX
 z0jObsobVKsXwl8EIiDp3D1DKEcdqlROT66j21ka2hhLuUaBWrCdzUuNLKC/t+r7g5i4IB/oQsX
 VjSwWQ4GYWjfqHa2GQJEO4vHaXlQaQd7wZA25+nzw6qMf7ZsVXIeXH134XfvJAxl0rAgS654jLr
 zMqlWFlK3PhejL5QHPUp60yXk2wDSDBj6RVR9TfxT3p01RvkC3V8RfunMJuSLlSQW+rU/cnQ+Hg
 =
X-Google-Smtp-Source: AGHT+IHwSXdxPt1j3PypzRQD84SRNPlQ1hqKRO+QXQPlCb87JYg18gKUsb/KS6zV2Pe8EisxO02uOw==
X-Received: by 2002:a05:6a00:3911:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-73e2680bcdamr774368b3a.8.1745457563419; 
 Wed, 23 Apr 2025 18:19:23 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/15] accel/tcg: Add CPUState arg to
 tb_invalidate_phys_range_fast
Date: Wed, 23 Apr 2025 18:19:09 -0700
Message-ID: <20250424011918.599958-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 5 ++---
 accel/tcg/cputlb.c      | 2 +-
 accel/tcg/tb-maint.c    | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 1078de6c99..40439f03c3 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -45,9 +45,8 @@ void tb_unlock_pages(TranslationBlock *);
 #endif
 
 #ifdef CONFIG_SOFTMMU
-void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
-                                   unsigned size,
-                                   uintptr_t retaddr);
+void tb_invalidate_phys_range_fast(CPUState *cpu, ram_addr_t ram_addr,
+                                   unsigned size, uintptr_t retaddr);
 #endif /* CONFIG_SOFTMMU */
 
 bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d9fb68d719..ed6de1e96e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1340,7 +1340,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
+        tb_invalidate_phys_range_fast(cpu, ram_addr, size, retaddr);
     }
 
     /*
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index df31322cc4..345a7a473a 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1210,7 +1210,7 @@ void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
  */
-void tb_invalidate_phys_range_fast(ram_addr_t start,
+void tb_invalidate_phys_range_fast(CPUState *cpu, ram_addr_t start,
                                    unsigned len, uintptr_t ra)
 {
     PageDesc *p = page_find(start >> TARGET_PAGE_BITS);
@@ -1219,7 +1219,7 @@ void tb_invalidate_phys_range_fast(ram_addr_t start,
         ram_addr_t last = start + len - 1;
         struct page_collection *pages = page_collection_lock(start, last);
 
-        tb_invalidate_phys_page_range__locked(NULL, pages, p,
+        tb_invalidate_phys_page_range__locked(cpu, pages, p,
                                               start, last, ra);
         page_collection_unlock(pages);
     }
-- 
2.43.0


