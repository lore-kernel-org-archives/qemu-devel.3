Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E7C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPY-00034E-M5; Sun, 28 Apr 2024 17:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPW-00033y-Ds
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPP-0001Iz-92
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2db13ca0363so59890321fa.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714341005; x=1714945805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vkuOqkqjEkB9PdGqDT2q032XYrx9jU6/rWVH+r61ws=;
 b=dbOj8tNPy8Wo+JN3IQ4HIDARKLVOD2WQjE/2t0JU+D4p8nExcfD/hdhLA2Lkk/LPIZ
 m6OhfOwGeUAUBSWu6ZKEFbV9gWADGAZUP2ccZkveT0ZZanz8ZDLGnhfjiS5G1EsV5pbQ
 Uc8CxwuA+TiuM/jYK0Q7lx6+7OxlWhqMKouGGiACyd1tI1YUlqnN5yOPvCDwJfIvpkPx
 zjDPu8LGhM9c+TCIg0jrGCvMc1UgxmP+qN47qVC/uD/CPxpOEk80uDnXYqAYJso1oK1t
 267B5laN0h2vwrG+D7Zq//4OTKowIOleld7M+5ttwNtH5kblgKhtOlz8zEduooWqMHiq
 5l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341005; x=1714945805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vkuOqkqjEkB9PdGqDT2q032XYrx9jU6/rWVH+r61ws=;
 b=XcWW1d2VxqKXXJtLOrI4zWLEfD9dKUglkBVfG5EGrjxRDeAO3ObVjKw0YhmVIEUaos
 j6fO4+5Oq0Ku/f7Hn9jHlsldgpqGaH2aoz3B7tganODskIuYR0yx/3Jk96I7MRFK3XjT
 Xf0OkwXGeyxV3QZu4iZZ0gXOv4FWDaQvqSUW3/Mu2uZlmdZYhSirHvyoYZPDIegixjEo
 Tx7qHcbKnIkuPJVy3w+y9oqRrMc3usuGheSr6kz4UewClcMv4po3cMsydvKZDXM6oR7M
 mMlWfpdQ19dD2AWcbGv6T/J7kP2jkBMHOdI6MyIMT9YKzBqJhKP1I4uRQX4Kd0kpBMdy
 zMAQ==
X-Gm-Message-State: AOJu0YyGUE4da7yk57XB9poiQQXNwgWouGU+Eti2H8P52xcePKmaykcK
 7py4ygz/qXKAS1ba43mqEHOnzxxwg3ElHampCHnnO+HT6kEBIG54GKwQxTzsQFISuaKZ44bPchP
 Q
X-Google-Smtp-Source: AGHT+IFBqId7RMP6FaPLnSRkNZkwDW8NhJuf8sYNV8bRXBMAiBURPqgrD0siJpSXrnlHq/MANuf6Pw==
X-Received: by 2002:a05:6512:45c:b0:51c:2c7e:ac92 with SMTP id
 y28-20020a056512045c00b0051c2c7eac92mr7068746lfk.23.1714341004957; 
 Sun, 28 Apr 2024 14:50:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a170906434d00b00a51e5813f4fsm13361600ejm.19.2024.04.28.14.50.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:50:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/12] accel/tcg: Use cpu_loop_exit_requested() in
 cpu_loop_exec_tb()
Date: Sun, 28 Apr 2024 23:49:11 +0200
Message-ID: <20240428214915.10339-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

Do not open-code cpu_loop_exit_requested().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..c18a7e2b85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -900,8 +900,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                     vaddr pc, TranslationBlock **last_tb,
                                     int *tb_exit)
 {
-    int32_t insns_left;
-
     trace_exec_tb(tb, pc);
     tb = cpu_tb_exec(cpu, tb, tb_exit);
     if (*tb_exit != TB_EXIT_REQUESTED) {
@@ -910,8 +908,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = qatomic_read(&cpu->neg.icount_decr.u32);
-    if (insns_left < 0) {
+    if (cpu_loop_exit_requested(cpu)) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
          * will also have set something else (eg exit_request or
@@ -928,7 +925,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-    insns_left = MIN(0xffff, cpu->icount_budget);
+    int32_t insns_left = MIN(0xffff, cpu->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
-- 
2.41.0


