Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3E0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXWi-0002Du-8K; Mon, 12 May 2025 14:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWf-00026t-WD
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:18 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWc-0008QW-8G
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:17 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so47379475ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073113; x=1747677913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wT6DnXqbX5AENDmRydoGeLBXcyCT3Vy8ui4SCalzaQ=;
 b=pkqKjBbQ94f7y1Pl8EaDNnURig+OF6zKpscWkZxjw3SEBl7marwaNKTkZaDZvUR92F
 uKwx4mSTmYTa+090htE2B2nJhqDiwETySuRp2bKnamzfrxFSb2893BALKoBBg6jeWNs5
 gEpTlspl8KzKIPuwEkscMgmlEu3MmVGREVxrX7WT1AhDht7NzAN9ue0xcxLGLWaDRvjY
 WCVCQc1u+gj2Y/Vzk9aIQGOeMp07FCNydgi+PNl9tyx3o6RQap4sYTBS1YEmKD7MTRO7
 5S4J1zbGyNHZZWDoVWaCyczknStNo2tnt6wDxRxLoM2Xqe+cVT8Bf18Z4lfmfX89m+O/
 g9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073113; x=1747677913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wT6DnXqbX5AENDmRydoGeLBXcyCT3Vy8ui4SCalzaQ=;
 b=nLeIOpwh0OK9k652VrtcdRiS3ZD5IlqKu7LJFzN0Ft6TQhrUNOXbRkVguUu9eafALo
 e1uENGKcG123MFR7z9wBSapp+hicmw3fO+09tbTNjuLWUzj5TpoY3i4toQ/duwYGJNhH
 z1WVcNNNdmnhpzaeSjXGgoecU57C+CiQsiYZfjOVHKz89ph7lcXk+uDiJrnubweKADzn
 2eW7j5I1Q6L8sZWSD0jHduzjyt0eNa1DCRPCx0KQKaGwWQes9HdWB+a6aInONrn16XPU
 Q7gMwQO8U5LtPlxzkjitneGjWSL7h0BARH5xoyIcTfOPD77V8CrzkJS5of7Q5baLP/y1
 L+0A==
X-Gm-Message-State: AOJu0YwScO+wxQoOlo6F/bs2mgPOngfcc5DChwMRfQLtbegYK45W1UoW
 3LyaiZYYyQrbYM/VUgolbPHuVT7gguGRNuLFdYISwfEbBXrqurNk67OYovNqE5puL989IQiDXmZ
 w
X-Gm-Gg: ASbGncsqIS9Gdc+sFeRf6/rRg2gZev3sfH/rE03hl+YtjlJdFdLOgQcjdvCpKP6rwV8
 6nozlJhg7XOaVEOX5hvg2MNLl+bBHJQUMU+W27llma7OlMT9M5PqfatMVUGlR4PwW2cW/5P0/K2
 CiugLqfrzwfzHVHhnaxdTf2xCsnHuLBLMxrjt+xtkZ6MhYLvNx1Fx8IHqQ1LMphSblaNRHpEErJ
 aR+JQQTVs90WxlsdbJliOnWv8Jhna7HHwaPr8qkgGRE5BPkA16RjR8iZXIXkUis/zX+WRDbC5+G
 1yM7JBBGPUydnyNCkfOMSJiw2uOkxNP5Fvv9nXPO5XBi4x5JeZY=
X-Google-Smtp-Source: AGHT+IHC9v0YNf7C0VB2fqmdISRjwl/2lgPQJoH5JAMzh04iqPHb+bGI5eSQIxgja1O4tGivjZuHZw==
X-Received: by 2002:a17:902:e84d:b0:22e:62cf:498f with SMTP id
 d9443c01a7336-22fc8e961a1mr224733145ad.38.1747073112762; 
 Mon, 12 May 2025 11:05:12 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 01/48] target/arm: Replace target_ulong -> vaddr for
 HWBreakpoint
Date: Mon, 12 May 2025 11:04:15 -0700
Message-ID: <20250512180502.2395029-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/internals.h   | 6 +++---
 target/arm/hyp_gdbstub.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 660d3a88e07..5b421bc4ecd 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1949,9 +1949,9 @@ extern GArray *hw_breakpoints, *hw_watchpoints;
 #define get_hw_bp(i)    (&g_array_index(hw_breakpoints, HWBreakpoint, i))
 #define get_hw_wp(i)    (&g_array_index(hw_watchpoints, HWWatchpoint, i))
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc);
-int insert_hw_breakpoint(target_ulong pc);
-int delete_hw_breakpoint(target_ulong pc);
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc);
+int insert_hw_breakpoint(vaddr pc);
+int delete_hw_breakpoint(vaddr pc);
 
 bool check_watchpoint_in_range(int i, vaddr addr);
 CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, vaddr addr);
diff --git a/target/arm/hyp_gdbstub.c b/target/arm/hyp_gdbstub.c
index 0512d67f8cf..bb5969720ce 100644
--- a/target/arm/hyp_gdbstub.c
+++ b/target/arm/hyp_gdbstub.c
@@ -54,7 +54,7 @@ GArray *hw_breakpoints, *hw_watchpoints;
  * here so future PC comparisons will work properly.
  */
 
-int insert_hw_breakpoint(target_ulong addr)
+int insert_hw_breakpoint(vaddr addr)
 {
     HWBreakpoint brk = {
         .bcr = 0x1,                             /* BCR E=1, enable */
@@ -80,7 +80,7 @@ int insert_hw_breakpoint(target_ulong addr)
  * Delete a breakpoint and shuffle any above down
  */
 
-int delete_hw_breakpoint(target_ulong pc)
+int delete_hw_breakpoint(vaddr pc)
 {
     int i;
     for (i = 0; i < hw_breakpoints->len; i++) {
@@ -226,7 +226,7 @@ int delete_hw_watchpoint(vaddr addr, vaddr len, int type)
     return -ENOENT;
 }
 
-bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
+bool find_hw_breakpoint(CPUState *cpu, vaddr pc)
 {
     int i;
 
-- 
2.47.2


