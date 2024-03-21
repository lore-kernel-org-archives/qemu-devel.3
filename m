Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A794C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgg-0008Eb-00; Thu, 21 Mar 2024 11:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgc-0007sa-NG
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgY-000201-RX
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:34 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568a53d2ce0so1551729a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036229; x=1711641029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zDd1vJ1m0kg+6reKiJJAv3Gd7RU3RjeGbW9KAoTqqc=;
 b=u2rQNocduOI+t1ABSpdjW3mvJpfffGYmGgPrJVlFVeDA3vtsDLVcP5Cxx93Tr7L9qz
 hTNbCMpaZ8cvsb/UbkofxlsdwT3hdM+rwC4+61rTStbUCPyniEOZIPeqTStEzlN6OM5T
 vTrY7zF8tGoLmWPFpo67vXHHMTQOCBgE7bfWVwyeJ05NDA4370uH+HAdvNwi0FqlVP3/
 okWJcwPgn5lEC3tu/ADITvHQtCkkL7sx58fnHs5rVQth2bBcDzFur8DtMqyMvUljBu8+
 aZbFK/ew7Z8NBibcoevMEh5Cm4gDB4qwCNH1Ty6GXCe3FDrVHaNEpoLhs52dFqFttGyd
 bZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036229; x=1711641029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zDd1vJ1m0kg+6reKiJJAv3Gd7RU3RjeGbW9KAoTqqc=;
 b=Ku5ToJc+3RH/nEmi4KPjO1DX4PjhO6joE6GvCrCFq9jeTjaKq5ZhhRxMk4wVbXNqgF
 TG5dfBO7M3MVMog6hbKMMalqpN87AfMld7yQxk9JrkANfq3rjtFEKyIdt0AfQBxzkqb4
 ivxOfnZn3AloBsRxBF96C3o5kOnpyPtrnpQFhzASXRL4BTqA50m3STQX1mAlrIvG3cgW
 yexsqRxv+AVJW6k+UMByxRvZG+LVYDGSS0qF6Px2H/beQ4tOz9SAhu5619uGGIkwBE5t
 BCDsELUuACPQX5WprHsghYIGnrzxsdXDsA3wVGqNbelOmTVgzSiopFGP6atKWL7IfS9Q
 yjUw==
X-Gm-Message-State: AOJu0YwefEHyTM4H5oQO4DI0PgTkoizOBsKTnM34o0GYM301Ldwq7QIU
 vS1QjvkqbhL/DtTztTSkycLkxHrxLMuDWAQPeUxWbKOXYi7KsRXVF4dKppPigTG4jgQYw/6MQ01
 6/RA=
X-Google-Smtp-Source: AGHT+IE2nkP3/s+ZVl7OIbnsBZ7cJXuE1J4tybtt6Fys94AA+96zHcj+6baTb+fsUqIjIJvE7tyf0Q==
X-Received: by 2002:a17:906:a44c:b0:a47:e19:81c7 with SMTP id
 cb12-20020a170906a44c00b00a470e1981c7mr1678931ejb.21.1711036228996; 
 Thu, 21 Mar 2024 08:50:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a17090637da00b00a46e68a1fa0sm54362ejc.53.2024.03.21.08.50.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 14/21] target/sh4: Extract sh4_dump_mmu() from
 hmp_info_tlb()
Date: Thu, 21 Mar 2024 16:48:30 +0100
Message-ID: <20240321154838.95771-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

Extract sh4_dump_mmu() from hmp_info_tlb(), replacing
monitor_printf(FIXED_STRING_WITHOUT_FORMAT) by monitor_puts().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/cpu.h     |  2 ++
 target/sh4/monitor.c | 22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 9211da6bde..4e2e9ffd66 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -385,4 +385,6 @@ static inline void cpu_get_tb_cpu_state(CPUSH4State *env, vaddr *pc,
 #endif
 }
 
+void sh4_dump_mmu(Monitor *mon, CPUSH4State *env);
+
 #endif /* SH4_CPU_H */
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426e..1befb42b07 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -39,20 +39,28 @@ static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
                    tlb->d, tlb->wt);
 }
 
+void sh4_dump_mmu(Monitor *mon, CPUSH4State *env)
+{
+    int i;
+
+    monitor_puts(mon, "ITLB:\n");
+    for (i = 0 ; i < ITLB_SIZE ; i++) {
+        print_tlb (mon, i, &env->itlb[i]);
+    }
+    monitor_puts(mon, "UTLB:\n");
+    for (i = 0 ; i < UTLB_SIZE ; i++) {
+        print_tlb (mon, i, &env->utlb[i]);
+    }
+}
+
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
-    int i;
 
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
         return;
     }
 
-    monitor_printf (mon, "ITLB:\n");
-    for (i = 0 ; i < ITLB_SIZE ; i++)
-        print_tlb (mon, i, &env->itlb[i]);
-    monitor_printf (mon, "UTLB:\n");
-    for (i = 0 ; i < UTLB_SIZE ; i++)
-        print_tlb (mon, i, &env->utlb[i]);
+    sh4_dump_mmu(mon, env);
 }
-- 
2.41.0


