Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C645C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdQ-00078w-Bg; Sun, 05 Jul 2026 00:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc8-0004wQ-Ug
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEbu-0004BJ-73
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:37:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2c9bd2f8bf7so29047575ad.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226261; x=1783831061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/QoPchMBLEoPNwVaZS+xZRRFREK+x04Oz5t5RgPWdc=;
 b=Tf9aT3Gs3ol5ms8gia9ihB6o55s9u46Py3omuAAliBt8w2dIJETgppMjNEscfCbh6m
 3mjCNSQi2GUIkCQkElK6O6Cu63hGszNeDWe3vWw9bjNjc3J33DBuFk81oQvbqKDPlMcn
 UCIESibt35rvSLlawKd9WqSxhawWSpOXB6R14vDYJQF7ncSF8aT5tYhfVpn8n9/AWAJz
 HD3FHKN0ZgnPyy9xVsK/sR4Mp+C563GmBBi2fu6U+6J5crP+UERjoiG+/1iH6VA3Dame
 DO1AJ3OgHu3IRsThLRU4OBjogWw5fCB59htUlw1cGGB6CRZMwetcS68ZpWEmr31cWMSi
 9Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226261; x=1783831061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w/QoPchMBLEoPNwVaZS+xZRRFREK+x04Oz5t5RgPWdc=;
 b=XZ4ILvv9ygttgsWn/9ZhldbRB6UvWdDGBAUeLoPZzWXw36CQOMQZAWcKNbzFa341FC
 /+D1xBgJ5Ef7UzBU5IGnnV74XcM6bRdJt6exFTUUtQ5NAOp7rZWNvT9/qU7ED1O6xN/E
 fE/Qz61WGFn9Z0S+fATXEo3xNQpUrZm+dWNjIuUAWwvdgryJSRImSMknmbM/vhj9aYpV
 uQzv7YKICKGBNXrJC7jWbaF3R+GsX/7R7jhQTcnHizJpj9til919je0niP3TV7VFxZgr
 EE/xowxyze43+bz8w5htmMcNeaBlVzRKC8FFs+S5FwxgpKMWN+WjX1KMaQFKAprVdkCZ
 broA==
X-Gm-Message-State: AOJu0YztxJibDODsmFwokJDx7Aj0BU3A6TcZWRzPa28kYe5Dr4AWzao/
 I53krTavuTB/77sNsK7W8vvTTiuwInxajkfDTWbu+f9g6d6zdEakiXsJLM8IAJ7Kw+bCs4XEoq+
 q+AM/
X-Gm-Gg: AfdE7cktpP+Sg/Kny/qyIOULREx+ta+pThFzX4//bGTB8Vb9WP4kowmEZ366UNuVNZs
 kmwyh5VSApwNlgwRBXBZDxzSqKehNrYkEt2q8lwwZ/zyo66P6FNriPmv6thFVk7Vh2KmPGsNiLi
 ZpTaCIFtWoxxxsMHJDxKKZPjfTP93xqgwl8yGoUUM4V6xId7wmGpoVVmrqkcAWBQ0IQfmpHXruj
 dHZreVHN0hMuV4qjhkFxe0NaMXq3R/SdJktuyOMnW2DF4q+xyPqlUgNwjS38apYqU/SkaOhNcrw
 SZaxIpLXH2LGZ6nu/MCM2+XniovyMUizQ0gZtyD5OR4tWMgAiQiX664Hs/q7ChtQohhtNDo28GR
 /fQKXgFcApkt3QUSvV4p7CpI7O4CPIeujOd57KeXmt9ql9ImKkSPQwIu/Iz1+ICU4wv9JJf8o/Z
 O1I7jxrXIqZgL3NzLBhk5Fxa8TYh8yqEaFkCucL4qDHBZ7yVc=
X-Received: by 2002:a17:903:90b:b0:2c9:d277:2cdb with SMTP id
 d9443c01a7336-2cc08df17bcmr41444215ad.9.1783226260602; 
 Sat, 04 Jul 2026 21:37:40 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 15/46] target/arm: Use wp argument in
 arm_debug_check_watchpoint
Date: Sat,  4 Jul 2026 21:36:54 -0700
Message-ID: <20260705043725.1373137-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Use the matched watchpoint instead of looping over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 2389830b2a..daad2ac440 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -365,7 +365,7 @@ bool arm_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     return bp_wp_matches(cpu, env->cp15.dbgbcr[bp->id], arm_current_el(env));
 }
 
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *ignore)
+bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
     /*
      * Called by core code when a CPU watchpoint fires; need to check if this
@@ -373,37 +373,14 @@ bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *ignore)
      */
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    int n;
-
     /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
+     * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
+     * match watchpoints as if they were accesses done at EL0, even if
+     * the CPU is at EL1 or higher.
      */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
+    int access_el = wp->hitattrs.user ? 0 : arm_current_el(env);
 
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        CPUWatchpoint *wp = env->cpu_watchpoint[n];
-        int access_el;
-
-        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
-            continue;
-        }
-
-        /*
-         * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
-         * match watchpoints as if they were accesses done at EL0, even if
-         * the CPU is at EL1 or higher.
-         */
-        access_el = (wp->hitattrs.user ? 0 : arm_current_el(env));
-
-        if (bp_wp_matches(cpu, env->cp15.dbgwcr[n], access_el)) {
-            return true;
-        }
-    }
-    return false;
+    return bp_wp_matches(cpu, env->cp15.dbgwcr[wp->id], access_el);
 }
 
 /*
-- 
2.43.0


