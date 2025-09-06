Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126CCCA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulK6-0000E7-KZ; Sat, 06 Sep 2025 01:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK0-0000Bs-Kl
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJo-0006oT-Qu
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3c46686d1e6so1934194f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135903; x=1757740703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNqFZV35YOrj/F9z9dCSnDx2HfCCFDbc6LDsUqT3M/g=;
 b=a5U9vOiPJLdU6NxidmKmqZrWV+VxgI+sprCPYxrMK9q2rOpZp88XkIIbAQxH9PQJQD
 rVcLO4A5kUFUwe3EJ80k3Bv23ef7Th37jZounM0Mw24leIGdw5ImJZN3uT8mwmT1cs+D
 nR6tpgknI9URQUYHXUYaiK4RKu/NFJYeH9khVtQzFzp1T6xL+G7DPy6hUlQ6vvPkTJqb
 mk69tkf4twK+mOg2e/azLAwYe1wj9wu3Mrak2wFiNLE1d5AnusNpn+7DysOAxALyCiw3
 m9Yt79aaGlqb6ARdKnfeZVAjyx9DWZCAMn5MBxY9T6Z6PwzJ0wxxaymJOQYGiErquwHQ
 1coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135903; x=1757740703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNqFZV35YOrj/F9z9dCSnDx2HfCCFDbc6LDsUqT3M/g=;
 b=V9brZLRz7wqbh4XS52+H4MdqhrHg/Kpvkz8pK7nprsAcKVzjZXxcHEWOzGSSwziiYK
 a0ZIQWlSBilN88JD6ZFhEO8f0GzHKCSy4J5rYgtKJmORjUWnn1oDB7wg5vAMh4p3hkNj
 Fr/2qup/1iqvlhKlNP6i8pSNquOQcB5tOYjUGY9h701/rXWEWx3cdEILxKQFD69t55ZL
 kIZJ80Iurj46cHrOJKo1us0XYXXCFMhKMSJxd6YNBei/EaXYLVXGgfs/5A29hs96wcET
 oOfNvrFpGwoH8rBSTelNKqBsEt82avnH+PrJhTrjOtglfvrq2Rxc9eqXEG3aBeBqd/6r
 0MnA==
X-Gm-Message-State: AOJu0YxxO8OnQD+tT/b6ajaz5K5ntIZfMKA5qfz3HXAOjHOuS68qWsYN
 lq2M5+cqFft223+CSp4v7DSgcGwCxQ5s9WXcCMbxnSYr5AbDXtD4nxkr/A5HroeT1dGQFYFiXrP
 AJl4QZrQ=
X-Gm-Gg: ASbGncsByIJUjq5BDi8UgfxaWHQtb3syklQF8uCjXBbNrjC6tRfT658zGQr7xvEuc0b
 YMiWRzVEcJX5/MQo5FXSX7jSynq6FaZaRn1DN3uSuqy3vsASXnODf7x4NHtb5OASYpkAw0YO09Y
 SiQc2HgGD+z6bWxXNczJ+LTFx+txL0WFh8MHp4oHA9x3sHpQob2lrfEHqNmbjxOj/sJgU7kukyE
 01SMTwNRW8JlztK4TLcLGtwvEDPUWMGokn46eoFsQAOmRai5Gtn25+XeNATZOGAjCvNIuFTD9TY
 hm1rDttg/AgbTtAhyaOBdelW1hYPtPxMcaVj5DjgcVD2srWZvMw181ty+CHLzRr23hlBMqFInl7
 lI3UFooBJb4qJQExa0oK5nz9zMEMAsmcdh04GW+z3zqR7ScTX+UZ+ARvuegigPuw+FQzT9GAGlH
 q4oQwSOg8=
X-Google-Smtp-Source: AGHT+IGtt5iyMs11Oc6J7K5A55NfbYz8ZigGo9LLRqb+A2698A9SnNL9xtaz5gvCXtH5IqlB1eoS+Q==
X-Received: by 2002:a05:6000:2013:b0:3d4:a64:6754 with SMTP id
 ffacd0b85a97d-3e643ff3b6fmr566630f8f.62.1757135903251; 
 Fri, 05 Sep 2025 22:18:23 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 01/11] gdbstub: Remove tb_flush uses
Date: Sat,  6 Sep 2025 07:18:10 +0200
Message-ID: <20250906051820.160432-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This hasn't been needed since d828b92b8a6
("accel/tcg: Introduce CF_BP_PAGE").

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/system.c | 4 ----
 gdbstub/user.c   | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 5be0d3c58c..df3514dc74 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -18,7 +18,6 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
@@ -174,9 +173,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         } else {
             trace_gdbstub_hit_break();
         }
-        if (tcg_enabled()) {
-            tb_flush(cpu);
-        }
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 67403e5a25..2e14ded3f0 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -15,7 +15,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
@@ -220,7 +219,6 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
-    tb_flush(cpu);
 
     if (sig != 0) {
         gdb_set_stop_cpu(cpu);
@@ -539,7 +537,6 @@ static void disable_gdbstub(CPUState *thread_cpu)
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-    tb_flush(thread_cpu);
 }
 
 void gdbserver_fork_end(CPUState *cpu, pid_t pid)
-- 
2.43.0


