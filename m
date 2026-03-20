Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A24710987B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3d3y-000661-1X; Fri, 20 Mar 2026 12:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3u-0005xt-EG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3d3s-0001pc-HR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:51:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48374014a77so20327755e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774025459; x=1774630259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSEEhKxsgd12wtFnDcnrYqYBfTtK/Gi6UjxPHhN76lI=;
 b=u2gBms1MDycOyibk/jzpaYy0eU40CqIcrp5tBYjxH3D2Y69T+bCN5R/IM57BUbgMGv
 9M5ct+euRdzOb0VTVQ63pjx8wR5ki9WS9PVAuvDAMDa4/yyHGnedTkI7dJ604vnAWZUP
 mMUoUdOlKs4e0a+bjoWzH6oqoVtx1ZcB1XZ3RErMfSDc5iNlsGTf1+POLvtH0il8Qm1y
 iFCNlw/zcpeWbV0JFeCnSHqosT9u+uUAeG2f4pA8Wb40FKWRcvIbIQ+FSUNenXEDJg83
 xIrFt+w7J4B4N0Qvh3tUX7XMTD00AJJ3VihqWZWXwhZBryBqfwu55pPs8+J8ebLbXP+k
 zWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774025459; x=1774630259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSEEhKxsgd12wtFnDcnrYqYBfTtK/Gi6UjxPHhN76lI=;
 b=Pudos3H6Fgk7o7pfyOqWpzlVIqtsL0JA/UJjKjcEd4IiHbF0TMnXQuY0FaQlwbhAWi
 G8zgOYQtyv+KhEUBtoT2uLfE1JHwbtr697la3LA33NsklZUDFNzSnR7/23AAwONRV9IT
 TTKILU7ekyNq5M7wtrC92DJsyoEnEWv72NQQXhtaWH4fnk9886ObBLHUPtgv10nbYq2T
 Nro9fGcdOzNYid05nr8pLw9fcXSnuqfhKBHCVffs0n+un92hif+ZnWP+gAKcVduiNGGg
 7jPQoz3He43dKYPvSkOyffmHWVnRM1sJmcs7woyIi730G9bkYWMZEyByEzehD8zP8i5s
 sPog==
X-Gm-Message-State: AOJu0YycdoecD8fOiPcJgFCRyw6NR2Ezs+/PCptkgHoltF9VNv3szT34
 dVAYybvmrquSiujCeDHi7BW7/dG7/aQafMM9Oo6ALGcVUAdW+LgXS351EyQ9EJxFiUyeq/zcLZ5
 pxp9U8ys=
X-Gm-Gg: ATEYQzxdmmK8LEkAC5FyEHb5qjIxWTzqNGMuziqC9sZpC20R3XoALerMzqzCjOy3PP+
 OAs/ABoa5sDVVif6GzShFuRvx4/Po+aroxH+BJK67FrrBgaJ2pE5y2AKRQM+0oVu4Lb1TVnT2yH
 M7aJQ+8tnDf+PlIQiWK4p6wvIRVns1t/8vhtEBRZ6qsn35WaDyrIZKPKezhqQfs/aWHqJeZzybd
 f1qsryYoaseVWixkuQvhRTzYJEK8cAYXcjr5yS6xXhEmpaemQpQJp6X93/GGjnzjnjekMkZGzuZ
 c2Nm0eHSlLClv7QwzhI61csJPmQi0VajOaA0DMyznLjd10ED899O8w6zajWSuKQpzrsZQPLWKVw
 TfOJV2qK9n344k9owr1M6QzP8LLr6Ms7LAGvTF38ASj8x1hJQ4oWBxjwptKxJdwqa2RF/EerZsm
 rgF/y3IWozhUMCupLtwq1PZMwuXOEujSftKlf3o3tzVl3iEz6K9gw8bdbxnmYSNwIZGH6ose2A
X-Received: by 2002:a05:600c:4705:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-486fee0983dmr57740125e9.17.1774025458618; 
 Fri, 20 Mar 2026 09:50:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487004e7bc4sm22884685e9.2.2026.03.20.09.50.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:50:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 5/7] target/m68k: Rename dump_mmu() ->
 m68k_monitor_dump_mmu()
Date: Fri, 20 Mar 2026 17:50:18 +0100
Message-ID: <20260320165021.39521-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320165021.39521-1-philmd@linaro.org>
References: <20260320165021.39521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Rename dump_mmu() to avoid a name clash with other targets:

  $ git grep -w dump_mmu master | fgrep .h
  target/m68k/cpu.h:610:void dump_mmu(CPUM68KState *env);
  target/ppc/cpu.h:3083:void dump_mmu(CPUPPCState *env);
  target/sparc/cpu.h:603:void dump_mmu(CPUSPARCState *env);
  target/xtensa/cpu.h:697:void dump_mmu(CPUXtensaState *env);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.h     | 2 +-
 target/m68k/helper.c  | 2 +-
 target/m68k/monitor.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 84ffebe3890..5c45597375c 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-void dump_mmu(Monitor *mon, CPUM68KState *env);
+void m68k_monitor_dump_mmu(Monitor *mon, CPUM68KState *env);
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 2208b9a2ab9..7cdea555061 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -611,7 +611,7 @@ static void dump_ttr(Monitor *mon, uint32_t ttr)
                                M68K_DESC_USERATTR_SHIFT);
 }
 
-void dump_mmu(Monitor *mon, CPUM68KState *env)
+void m68k_monitor_dump_mmu(Monitor *mon, CPUM68KState *env)
 {
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         monitor_puts(mon, "Translation disabled\n");
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 38f925e5b16..eea5ae16a90 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -19,7 +19,7 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    dump_mmu(mon, env1);
+    m68k_monitor_dump_mmu(mon, env1);
 }
 
 static const MonitorDef monitor_defs[] = {
-- 
2.53.0


