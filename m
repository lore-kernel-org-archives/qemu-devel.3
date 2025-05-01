Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5C5C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANKz-00059r-Hn; Thu, 01 May 2025 02:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKu-00056S-R2
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:56 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANKs-00070j-2z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:23:56 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-afc857702d1so655903a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080632; x=1746685432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=TWXtPp/Ad3ixc17TBgANmvmp5JIs2m52XHE6X9d4Rnmjd8pkInc0fKqBwhVaIChFyL
 jojrgLxIM6vHMfLXNc51QBU8EYvbNcfTd+yLFl23T478ssfVwHd2Jh0A9jufgrNPKG5N
 Dm2V2a5VIyq9O6YZRk5fqysMCEytZM4QsPNCHH1E57Pk4hO5j3j9SGSWv7MU0DoNh7XV
 bEzTysALqDXIYz0hXloABFGCGYkIsh1JT8kmw8yooHbzfBfxkLVYRZ+BzA915Z1pxvA6
 vrZWtecxSpHJ90zILY8B1wHTI0AXEEkuxCufr+7epJOQtiohRQSlOAh0atAUoPzHddfJ
 0CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080632; x=1746685432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1JmSJqnxYquNU/v4UOEtwOcqbxnEb6aDiKyyBWqJ6s=;
 b=t9f71DazmdJY/eWyulvpEYJmxwMGI08b23XrZtAVls3pewlJjHZjnlSj5E6Ok7ZeUQ
 H7IXijetmnlhKGQpDiP3beDXUF3IoQaGqSqYudiUNFE8R0QrFZC45torxyPMAbIAhtz2
 CiqRckdteW4DFWWFsiLq5YdxkyvG7YEik0Ee7ZEk0sre2S1xJ66tpQdnR/lYd2SWmCDk
 IAKE4twq2V9z/3cxiH6EXz9WaPML75vAEnkUNv/RzudBZ/qIvM4QkvAeA26WPrW0Q5P7
 1SwyUseVMiJXfDOjoxad+RG/JhzVdJUe84jOrWtXIQH3OtyMphE/G51fSHrUzLbyhbUu
 m5GQ==
X-Gm-Message-State: AOJu0YwvqS5DbhrKu300M5O6xglyXq1wjhhiZbn9GqhTZcyK44RcN/Sl
 Ir/FmlrT9LeQ9aD7QhZ0gqB2YgYHW2Lz9zLdNDn2zPA8O3NT5lIr25wqUcEnoUkbiT1YJPu/xha
 W
X-Gm-Gg: ASbGncvLHvKK/fmBFKhhwQP8ixVLUNTuWWBL43VSSGaemLYcLzJzWutX2h00NJJQoHd
 yCD/UP+WKsvEohz7bzA6Hs7JdVcxbh2A2yyC4pX2t11qkMpiEfv3BckVjoHxvMRxcOdGLY3ED2e
 aBpRFidC77IfglHyD7FunTAhe29hqQuGymUSNYZx8eosdkq4yXTtjir03PxJUrhZYSE83XyPvzZ
 n4ymBuavcdxBHTDEZRPR1Iowe5eacQbj5MFS/7VvqiZYY/KnoMz7VaDXX8JkaxQUEnap7lKREAd
 lPkuRQfeWmHBxYeZsFTPQXfHn/BMti+YoHffZwwBeXBKQWFxol8=
X-Google-Smtp-Source: AGHT+IFOfDiSKDNI2z7vj3bMYhWzkjC1FmgVSWCJcnFqyW6oYKX9smD6/m/Yr79c3SgHzyGvhdUaQw==
X-Received: by 2002:a05:6a20:7d9b:b0:1f5:79c4:5da6 with SMTP id
 adf61e73a8af0-20ba6a181acmr2684589637.5.1746080632405; 
 Wed, 30 Apr 2025 23:23:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:23:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 01/33] target/arm: Replace target_ulong -> uint64_t for
 HWBreakpoint
Date: Wed, 30 Apr 2025 23:23:12 -0700
Message-ID: <20250501062344.2526061-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

CPUARMState::pc is of type uint64_t.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d3d84ffebd..c30689c9fcd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc);
+int insert_hw_breakpoint(uint64_t pc);
+int delete_hw_breakpoint(uint64_t pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..4d8fd933868 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(uint64_t addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(uint64_t pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, uint64_t pc)
 {
     int i;
 
-- 
2.47.2


