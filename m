Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211C5C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8e-00089z-NT; Sat, 15 Aug 2026 16:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-000889-UH
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8T-0008Fl-4r
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:37:47 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so2062006a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826264; x=1787431064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xpi+58NLvsNGE5roXXmz2yeQ2sLTmSOVbtvh5q+nBos=;
 b=jgoCNRYvKoHMjLVl8EppgSe84GSLFa/GaWoqDpsZwZClgDBCPZ8BeUANhq6wJkUyo1
 qJ/7B9pJgUKOI0fzIlCYCaLJST85qbtE+Arf8MA1hzQmW3XPWu7+vFkMBkVwaxWkmX6D
 qg8Zvu+PvjC0NNkAowvl5PwVDNMrLXVpZu8U8Mav1PiU804MHxcE1Vq5JmVEBqg3a9hw
 g1IBJzwv1YHXjjRRWL7pjKRmNqNpEnByY/Y8swNwL2l21gyd61StJcF2E2aGvyCQ8Rjn
 Y9JG0aZS0lNNue4yssU2ghgir0TpZ3wb8EZ2V08RKiRFxaQGeVMN0ytefb/GEZH67Ea+
 Wlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826264; x=1787431064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xpi+58NLvsNGE5roXXmz2yeQ2sLTmSOVbtvh5q+nBos=;
 b=HYHajh6MkY+OF3oDkU+uXbbUtFv1qfyS+2J0WLxZ19qt4QQofeebHvngybOSdBhYma
 AhicGw1sj22z3Ynb+GwwtcQuPKq5i7i8nGF+dE0eB64zq8mhehzHaM7hYbKU2z2F+X4c
 oswLExJe3m2uqc+ecukG1gysGl7xo/1n8nyAp7swBICAoyNtdP7VuLxq0hfyGA1volCd
 V9ZrSxZjLsbfwIp8vgKKK4f4zuifDdDCNEyNN5wkOzJlQjZTeSJsGQqcfin7o/riGh3E
 IyERVGHvNBI1uMU16Sy6yV4SV0unNihZO/ib6cvlTCG7bLZ6sqIXhMO38eRfq3L0kCcV
 guXA==
X-Gm-Message-State: AOJu0YzO7SuM7bLahK4C2sZGrTEdeskilyzs+TzrTsghQxNHwJX/HcMX
 3fzmVErqmtSHAcrEzTAsJsFaZSOKIwTPZiZsTNLHWs/uFdaeXT2+EAz2IA0nmcy6e/quKrkI1xA
 5Od0h
X-Gm-Gg: AR+sD12skMLBkKcKRR0Z0PyBJx5T3mm7mVgc2NoX58VBAZiTQxH26jPznVwAfsXqnU/
 LOJ3lgx2/JAMSh2cE+t23e7V6paX8eMz82q89Zxx1WSa4xtE9vb6kY2Vfkeea1jI6KIS1P3uqoQ
 jwg+daSKEILkNYfV3h58sFIjesMgwbXA8BLKMiFtTwrEN/17P2bCUtKuNOqsqq0Trfww/lrOXwV
 AZqxr8kJOcgyf420s4T7+w1RS8Et0VA5TG26XhgSwz0gyQyjqGYPkbp8m5nLfZYAGJGIlupJxb+
 uxme7jUxAp3up7sk3qaRfkXsZx633vKYeFIptgYo1RaJxP5klYnqoLe/ipa02/LCV/NWbH16V8I
 zyqpFPQpaJ++J6HS6CFKdobNlC9fey7HdZi0JlzCAK/4bd1RkL2nPxMhDNsHuROjrULP4Cp+Z9c
 p5nKgXaSv8GCd3dthG515H+gMFlTzCmkp/y7puGUSAsq9I4mVLLEJwqXvEk7v95A2UJxfNVubkt
 mbVAXWYO7WA8ISCN3j6
X-Received: by 2002:a17:90b:53cf:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3933bd204d0mr16889988a91.3.1786826263584; 
 Sat, 15 Aug 2026 13:37:43 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 06/18] accel/tcg: Drop fault_size from user-only
 probe_access_internal
Date: Sat, 15 Aug 2026 13:37:18 -0700
Message-ID: <20260815203730.1468365-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This argument is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a35aca7889..3724e5d98e 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -749,7 +749,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
 }
 
 static int probe_access_internal(CPUArchState *env, vaddr addr,
-                                 int fault_size, MMUAccessType access_type,
+                                 MMUAccessType access_type,
                                  bool nonfault, uintptr_t ra)
 {
     int acc_flag;
@@ -797,7 +797,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
     int flags;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-    flags = probe_access_internal(env, addr, size, access_type, nonfault, ra);
+    flags = probe_access_internal(env, addr, access_type, nonfault, ra);
     *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(env), addr);
     return flags;
 }
@@ -808,7 +808,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
     int flags;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
-    flags = probe_access_internal(env, addr, size, access_type, false, ra);
+    flags = probe_access_internal(env, addr, access_type, false, ra);
     g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
@@ -825,7 +825,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 {
     int flags;
 
-    flags = probe_access_internal(env, addr, 1, MMU_INST_FETCH, false, 0);
+    flags = probe_access_internal(env, addr, MMU_INST_FETCH, false, 0);
     g_assert(flags == 0);
 
     *hostp = g2h_untagged_vaddr(addr);
-- 
2.43.0


