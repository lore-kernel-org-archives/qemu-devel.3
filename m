Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800ED58D40
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 13:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFZ1R-0002QS-Di; Mon, 25 Nov 2024 08:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1P-0002Q8-Pk; Mon, 25 Nov 2024 08:20:59 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tFZ1O-0005nW-1d; Mon, 25 Nov 2024 08:20:59 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7f8095a200eso4129771a12.1; 
 Mon, 25 Nov 2024 05:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732540856; x=1733145656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++RLXladraE5Zh5mt6raxHmvjK/0jrojgoKwbS9gvZ4=;
 b=IJAOAPwCnA3d0meYZZwEu5J0yZ3ELem1Ael1MuUiJVYWZhBPjSNjiGUwVBalMdl6Pw
 6MQ1N97CnsqwYmFf7GaCl+sW36zdvayfbDoUnjG4XAxvrmMnBzPtqK9/rc5IgUqKydTv
 SVEmdy2aNTnLmJJHwcbEReGef5BckLx2TAQIVJhVoXaQRRjXKIKOnC3xpIkznqt/Ecij
 FAzUCJyUGHQOYY+ZQw9Q9+PNSwvjncYuN3DiR/3R47IyTn4PTgKl5UKQVBhe91lGgK0t
 Sbb1k8uaTSO36INWslZnYRNhqRJXCWLKpQqBrjAlCxuoa22j7QJfyGjATLbZG38QGuyk
 0TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732540856; x=1733145656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=++RLXladraE5Zh5mt6raxHmvjK/0jrojgoKwbS9gvZ4=;
 b=VEF6lGxtpmhMnunL0Wxb7ZaK1EXq7WSmTcj41+eafJU1t49t3zcQBBGc8prcHzbUyW
 PhTaEtTF6DVM5VbscNvenzqIdINgVuoZEpo2sUpdRENNyAxYOx/sQzhlEGXjXQrMJXeF
 bwVK0nliqE5sdH6Cm7FJcQTgPgVpcfZMHMmtqGyWMBGZ0LSJc0Lyh6R2GjBshN68cJQh
 rseDeF8/kzrJ98Ibh1wiNCwWHeBk0YXZwwT+KMM3w07/rOTVfI1I/Av3O066VFOUGT+4
 /gWrhdCwrUWZnik9IFjuikelmu6Po+RxquYlO8Vb4cgWgHMdp6f/qTG2zAFYrJEIoFf7
 1RSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrhJpCmi5QD7DCVNmWCXLGEcNkAxllrVaT934knUftm4Y/Uq3GjK3n+xRNEyu3uiUbp+bC7OAvnaGo@nongnu.org
X-Gm-Message-State: AOJu0YzkET2QPbTnHSuNcnRfO9PESjEZqBBWdwTJNAWZvNa1+99SyZFe
 eDrUtD8JFelmxGuXMfAh17hm9okzOX2ktyvnRFaWQkTDEWmIQECEQU9qPw==
X-Gm-Gg: ASbGncuAPy2lY3SGvGGdckTlJCdJP7mU/06OH57GHb0lxb81jg5/Jh1AlWGY4HIkL/r
 qAx2PIgnjzW0DWn/0VkRxLJYsH/NZXIq9UuyAY2b4kICh1NBEx98Ei0woSn62wz8eVoCBEFFmzP
 f3YO0b0zpdi1v7sDjjkzgcD/KkUCf1fVGzsKH93rjvZkfckv9uQ/LtEn8ZyHA+iUFelBtXkQeQx
 0be8W2abErvEYehYMrgJkIFGsQQhrBVbJESy1bdfC2BaGAvFCyOJ1CRDYUMtEsTg4f1bb78kEDa
 gfSBnQ==
X-Google-Smtp-Source: AGHT+IHbmHHnsis/G9SX0dDK2NXQDosw+Y8i7yqof1Fu9Pu59wCiL1yYiU6AY+qj6tFVQlOmkKeotg==
X-Received: by 2002:a05:6a20:2454:b0:1cc:e71d:ea10 with SMTP id
 adf61e73a8af0-1dfa31305a6mr24934156637.14.1732540856070; 
 Mon, 25 Nov 2024 05:20:56 -0800 (PST)
Received: from wheely.local0.net (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcc1e44d5sm5616721a12.32.2024.11.25.05.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 05:20:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PATCH 2/4] ppc/pnv: Fix direct controls quiesce
Date: Mon, 25 Nov 2024 23:20:39 +1000
Message-ID: <20241125132042.325734-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125132042.325734-1-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

powernv CPUs have a set of control registers that can stop, start, and
do other things to control a thread's execution.

Using this interface to stop a thread puts it into a particular state
that can be queried, and is distinguishable from other things that
might stop the CPU (e.g., going idle, or being debugged via gdb, or
stopped by the monitor).

Add a new flag that can speficially distinguish this state where it
is stopped with control registers. This solves some hangs when
rebooting powernv machines when skiboot is modified to allow QEMU
to use the CPU control facility (that uses controls to bring all
secondaries to a known state).

Fixes: c8891955086 ("ppc/pnv: Implement POWER10 PC xscom registers for direct controls")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

There might still be a bigger issue with how we handle CPU stop
requests. Multiple different sources may want to stop a CPU, there
may be situations where one of them resumes a CPU before all agree?
A stop_request mask or refcount might be a nice way to consolidate
all these.
---
 target/ppc/cpu.h  | 1 +
 hw/ppc/pnv_core.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 945af07a64..0b4f1013b8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1355,6 +1355,7 @@ struct CPUArchState {
      * special way (such as routing some resume causes to 0x100, i.e. sreset).
      */
     bool resume_as_sreset;
+    bool quiesced;
 #endif
 
     /* These resources are used only in TCG */
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a30693990b..cbfac49862 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -217,8 +217,8 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
     case PNV10_XSCOM_EC_CORE_RAS_STATUS:
         for (i = 0; i < nr_threads; i++) {
             PowerPCCPU *cpu = pc->threads[i];
-            CPUState *cs = CPU(cpu);
-            if (cs->stopped) {
+            CPUPPCState *env = &cpu->env;
+            if (env->quiesced) {
                 val |= PPC_BIT(0 + 8 * i) | PPC_BIT(1 + 8 * i);
             }
         }
@@ -244,20 +244,25 @@ static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
         for (i = 0; i < nr_threads; i++) {
             PowerPCCPU *cpu = pc->threads[i];
             CPUState *cs = CPU(cpu);
+            CPUPPCState *env = &cpu->env;
 
             if (val & PPC_BIT(7 + 8 * i)) { /* stop */
                 val &= ~PPC_BIT(7 + 8 * i);
                 cpu_pause(cs);
+                env->quiesced = true;
             }
             if (val & PPC_BIT(6 + 8 * i)) { /* start */
                 val &= ~PPC_BIT(6 + 8 * i);
+                env->quiesced = false;
                 cpu_resume(cs);
             }
             if (val & PPC_BIT(4 + 8 * i)) { /* sreset */
                 val &= ~PPC_BIT(4 + 8 * i);
+                env->quiesced = false;
                 pnv_cpu_do_nmi_resume(cs);
             }
             if (val & PPC_BIT(3 + 8 * i)) { /* clear maint */
+                env->quiesced = false;
                 /*
                  * Hardware has very particular cases for where clear maint
                  * must be used and where start must be used to resume a
-- 
2.45.2


