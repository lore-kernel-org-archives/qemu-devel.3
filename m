Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD91C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmbV-0005tF-Jh; Wed, 24 Apr 2024 20:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmb7-0005Hk-J9
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmav-0007uO-CA
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso3558665ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003447; x=1714608247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=jNOzx0469RKcDD960igYMYPF7lRm7mF4JI1Cmy731kke7Lf1vMq4NTh+oi3qGrif3K
 /MS/JKFw4/mp1mF6Is5VPd4kI6h7zBpxFHlgom8izYo/4fu2FlTMDPWelJjRbjfCxMP/
 36GCVC0mQBqvI0rehvvRowjEbyM7k0ScIoVgQd9/FU/l5KI8ei5ReQTYtd9itqXvyDg8
 zsaSoCHVF0VBsOxUb1126Po3KnGgY1akzx7zl9vQZOMaQCzb/akcyFL+d4Nwjj1udkfV
 JNWESVaFEux/Cn2vN8hPto+9M6Y/UhdlCPLIzQta1mM+AWF7+Q45zhaIsHC0KFyeA8Zs
 tnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003447; x=1714608247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=420RbZAGJjbzrfJsdBQyYhnJyXLQSLvrDO7PgYHuwLQ=;
 b=XWJ9Z1UlrshEdZJyG8TTSZLNpOyV01YEH7PuEks5JHFXb56FQ9eLddXXqsjnh6vLbr
 oFTBM2Bj3lUb7UJq8RVxPu/kigd+kH8B7EvqXJ0HYqqe7PgFbG8KKLqiUuz1MvFuH1mL
 g48rQ96VgGxxrf3rIfG15rQonIoJjtTJnbrxzV0QzHTjtww6sxzN2ZAFKnaZyD390Iv0
 nsDkEYOfurC6x3t3Xr0X+C/yTMoFraE3aNz7l5GPQk6aJ+3BpH36ZU/tO4LZGkNfuix2
 xQayCwy4RhMSxPXhJ6KwvrmYrJLAjki5xuBFCRqDMLGET0mm7IhnMfdxW748eQOc0MVP
 xhCg==
X-Gm-Message-State: AOJu0YxnBu4qyHzdmmOpI2RMp0XmGmOS1d4BH9gyH5GYzX/1LXWpCpV4
 KXMwJpLIsgXv8NE6ZkK9CzVEaGHfriaRgh5EXmqEHubu3i5DUK+dsoWELont1HT+evZjYLztyVK
 F
X-Google-Smtp-Source: AGHT+IGprq6QMt/5QTX8BcdHLWEHOTyKdle0JeyVtJJ4ehlAYLC1V0pQWJ+Dbu3LXUWIOWWhjughPg==
X-Received: by 2002:a17:902:e848:b0:1e8:2c8d:b793 with SMTP id
 t8-20020a170902e84800b001e82c8db793mr4555867plg.41.1714003447648; 
 Wed, 24 Apr 2024 17:04:07 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm12483717plb.296.2024.04.24.17.04.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:04:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 44/45] target/hppa: Log cpu state at interrupt
Date: Wed, 24 Apr 2024 17:00:22 -0700
Message-Id: <20240425000023.1002026-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This contains all of the information logged before, plus more.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/int_helper.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index b82f32fd12..391f32f27d 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -241,21 +241,22 @@ void hppa_cpu_do_interrupt(CPUState *cs)
             [EXCP_SYSCALL_LWS]   = "syscall-lws",
             [EXCP_TOC]           = "TOC (transfer of control)",
         };
-        static int count;
-        const char *name = NULL;
-        char unknown[16];
 
-        if (i >= 0 && i < ARRAY_SIZE(names)) {
-            name = names[i];
+        FILE *logfile = qemu_log_trylock();
+        if (logfile) {
+            const char *name = NULL;
+
+            if (i >= 0 && i < ARRAY_SIZE(names)) {
+                name = names[i];
+            }
+            if (name) {
+                fprintf(logfile, "INT: cpu %d %s\n", cs->cpu_index, name);
+            } else {
+                fprintf(logfile, "INT: cpu %d unknown %d\n", cs->cpu_index, i);
+            }
+            hppa_cpu_dump_state(cs, logfile, 0);
+            qemu_log_unlock(logfile);
         }
-        if (!name) {
-            snprintf(unknown, sizeof(unknown), "unknown %d", i);
-            name = unknown;
-        }
-        qemu_log("INT %6d: %s @ " TARGET_FMT_lx ":" TARGET_FMT_lx
-                 " for " TARGET_FMT_lx ":" TARGET_FMT_lx "\n",
-                 ++count, name, env->cr[CR_IIASQ], env->cr[CR_IIAOQ],
-                 env->cr[CR_ISR], env->cr[CR_IOR]);
     }
     cs->exception_index = -1;
 }
-- 
2.34.1


