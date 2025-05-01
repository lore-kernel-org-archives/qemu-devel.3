Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03238C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLw-00016G-7u; Thu, 01 May 2025 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLo-00011P-5E
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:48 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLm-0001aL-9k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so906522a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134504; x=1746739304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BWKAEDoduJo+vm6H9IfI7womewKXVIoZxey+PglUhc=;
 b=MJGDxJOA/n83hS5OhDMX7g/sINtWgI0g11D51+ErTfXehh+BGm3/0M/TRXqDfsDlMz
 x6mbH38SLYMbH31NKABcfqE/1+kqQWQSXDEf+ita5mo/URMqU1RK80DLj0b8uHMulxrG
 snEvbGkm4jszsZXvfMnVaCGpU5aloW0SVkxVByxQ88zUW7jRnGdOOz7OA1pHwkf2QNji
 7eRbsqDlByw4PtURGKG0Px41d3rnN6B/5rcyB+6LAs0Upgo0AnYxztV2FGjAABTS18Hg
 SKwaJM7b0plZ80xqhGrGJIFHgrmu8ephkAD1oECGaeKWTDdCbYQy1DkOYIudrys9yya0
 bZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134504; x=1746739304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BWKAEDoduJo+vm6H9IfI7womewKXVIoZxey+PglUhc=;
 b=khCenCoZuiHTeMiv3rr1CtNBSail2b3tebL6gq3P8//tYzuoN1bcKojxfYtQb76M/D
 w4Th7XdHpzWkitReXYIlShF1enkp5lVgEcImHuGx9RQeIdd5x6pi4EQa2yuGCrO3fB9H
 cHBeR9l+UJ5mZf2Hb39+RwP8R19xG+rxd0mzE6tIAgDqTJ8p0TUdlgVlJYU3k9O0J0T/
 /j7FEqYNx/dQ1oMy8R8cQNJtTt3Gi4AiyF3ndf43TqipliilN628wackUM7aW+busU+Q
 6FcqxKOSgITv+/pVjzVJvHY2IDy/EsxwcvAgcoMIKfP/N2qQ8ZZuClbNOygCE9AL5z03
 04TQ==
X-Gm-Message-State: AOJu0YxKnjKa+VjYKY5vaNhBCHEBzpoiXgn87/EgK8sd1JgQalrymYjP
 Wv5Ol6SKNHGMdcU2Xc0yeaWep633kA2eKwDyTPt37OoYeQ/Aob49e+ZQ+rhtaZBw+Kc3YtJh4/5
 a
X-Gm-Gg: ASbGncsY0TY2kapsCzbp9A3G4z4fG9Zp6GtkQ/LYstIx2rZ2NlQTtg2SACtcRrVGoSq
 T/1977KDjpjEuGAfns7dp/c7EqzJ1SgPuHyitscglAJ1sFx/zvQxytGiEqv9sgFWihh6Qg9m1Vk
 fkSqlEHC2lPv/6g2vxZzXkSwJppj0IJYO3V0ghXk6wZ8ySqk1ndnrZvJSdSi+3h7LhWJTxPSVai
 hD2XNr71un7fjSkIH6nmD1J31C7sIqeCz0EuIYciJe5VnFrPpoWO+JUmpjzqsKp62ORFZCE/09A
 ZADUe6mQ+/x8UjCXdkhE+PfyhwdIs+qV3c/O/lEDrQ9e3DByF+uwfCU3LcDMwG7ade2Y9kSRzEs
 =
X-Google-Smtp-Source: AGHT+IGbqklZpscOflIuOeqhb5KfdVTJBYoWGWZM8LlhQEcCxjTnb4VTMZ65Sp+yuThSH7DJPKUK1g==
X-Received: by 2002:a17:90b:5208:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-30a4e5b2c3fmr986404a91.11.1746134504454; 
 Thu, 01 May 2025 14:21:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 36/59] accel/tcg: Use TCGTBCPUState in struct tb_desc
Date: Thu,  1 May 2025 14:20:50 -0700
Message-ID: <20250501212113.2961531-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8e6899950e..4ad84c2db8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -150,12 +150,9 @@ static void init_delay_params(SyncClocks *sc, const CPUState *cpu)
 #endif /* CONFIG USER ONLY */
 
 struct tb_desc {
-    vaddr pc;
-    uint64_t cs_base;
+    TCGTBCPUState s;
     CPUArchState *env;
     tb_page_addr_t page_addr0;
-    uint32_t flags;
-    uint32_t cflags;
 };
 
 static bool tb_lookup_cmp(const void *p, const void *d)
@@ -163,11 +160,11 @@ static bool tb_lookup_cmp(const void *p, const void *d)
     const TranslationBlock *tb = p;
     const struct tb_desc *desc = d;
 
-    if ((tb_cflags(tb) & CF_PCREL || tb->pc == desc->pc) &&
+    if ((tb_cflags(tb) & CF_PCREL || tb->pc == desc->s.pc) &&
         tb_page_addr0(tb) == desc->page_addr0 &&
-        tb->cs_base == desc->cs_base &&
-        tb->flags == desc->flags &&
-        tb_cflags(tb) == desc->cflags) {
+        tb->cs_base == desc->s.cs_base &&
+        tb->flags == desc->s.flags &&
+        tb_cflags(tb) == desc->s.cflags) {
         /* check next page if needed */
         tb_page_addr_t tb_phys_page1 = tb_page_addr1(tb);
         if (tb_phys_page1 == -1) {
@@ -185,7 +182,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
              * is different for the new TB.  Therefore any exception raised
              * here by the faulting lookup is not premature.
              */
-            virt_page1 = TARGET_PAGE_ALIGN(desc->pc);
+            virt_page1 = TARGET_PAGE_ALIGN(desc->s.pc);
             phys_page1 = get_page_addr_code(desc->env, virt_page1);
             if (tb_phys_page1 == phys_page1) {
                 return true;
@@ -201,11 +198,8 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, TCGTBCPUState s)
     struct tb_desc desc;
     uint32_t h;
 
+    desc.s = s;
     desc.env = cpu_env(cpu);
-    desc.cs_base = s.cs_base;
-    desc.flags = s.flags;
-    desc.cflags = s.cflags;
-    desc.pc = s.pc;
     phys_pc = get_page_addr_code(desc.env, s.pc);
     if (phys_pc == -1) {
         return NULL;
-- 
2.43.0


