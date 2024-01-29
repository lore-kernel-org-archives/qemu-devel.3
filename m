Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AB9C47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUaiZ-0001wF-Pp; Mon, 29 Jan 2024 18:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeL-00071t-UL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeK-00006w-CM
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:45 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ceb3fe708eso1893948a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569363; x=1707174163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMqE9xBix0QLmyhH8Xqft/09pdbioiePfeACz0Kfp3o=;
 b=GxVbeobXyukq/7EU/PumPAVCcRQEAtbkUoERBWlN9Zh0ewen2iAgU1Pfsl/EUXFSdz
 DJW07cnUw4W+l5IY0YXG4xQI9YoSocW7T4GqcWjYR11EaBGHkYWnKs8ihNdO9hFA045a
 aSoJ/rjlb18Sxgrvehe8vLg6nllFksIdgFp0vB+2YVvDahWAiT+O0Fa+BDBl5iXdARhN
 aJ0F2PmLMgQhBmhKgc8ADndtflsdf43+uk3Lh+1wkq8PExJLQfPF4UC94wRqAFR3e27a
 UMiuh2HGGqNIh2HcCfNXh+d4AcIpDdPX1QLsxbyICHqzVhFfHWNV2QFxdFg78Dxr2wDc
 msLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569363; x=1707174163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMqE9xBix0QLmyhH8Xqft/09pdbioiePfeACz0Kfp3o=;
 b=LtaXZyJ6Ez+LQoEnJz97rCcm4W4ohrTxK5c9g3czBkewz18/+pZF5XDOHEqTLRMjUP
 ZLtxW27LJ/2JXpsjX5nWw/GxmY+4OSuaoiwqwqJo0OjocbMsUdmGEGY9ywKnfc5W8swM
 CVfF5W1rrE3yGKI4R+AAoNf3YLnCr1GuL8jI4v1yMvbHyonke1UMnEqbNxoCUmBs9Pmm
 uMUObowpciezFCQUxFtJQw07ETCs1ma/91V3/SbwsgmFKwKQ5fOuJdNWWqqvK4d5fFFg
 JwOEgKpxto22cd7R/KO5i78M1ADrxyCTPUoWPj82OQzlUj+5DEoxD2zIuW0TehJgvpP1
 aRPw==
X-Gm-Message-State: AOJu0YzzaeLkT5HkYF+ieYh5gow9IbibpfNJWTVUx+yJRYOUxn4SX/4k
 EUVqfFIUFctwi34tEEplgXegzO4yXNv58PbAVaIa0rREGjnQSrhUGTuagIYzAK9RYsqN6w56VBY
 gou8=
X-Google-Smtp-Source: AGHT+IG+R3LTB6yCd/x/bYgAbylxb7xk4a6uga4FWdmXFQvteacb6JBPJVZMR3wlJP7QZyLTugS0Fg==
X-Received: by 2002:a17:902:654e:b0:1d8:d583:1811 with SMTP id
 d14-20020a170902654e00b001d8d5831811mr2756844pln.38.1706569363053; 
 Mon, 29 Jan 2024 15:02:43 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 30/31] accel/tcg: Introduce TCGCPUOps::cpu_exec_halt() handler
Date: Tue, 30 Jan 2024 09:01:20 +1000
Message-Id: <20240129230121.8091-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to make accel/tcg/ target agnostic,
introduce the cpu_exec_halt() handler.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240124101639.30056-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 2 ++
 accel/tcg/cpu-exec.c          | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 013867b890..bf8ff8e3ee 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -112,6 +112,8 @@ struct TCGCPUOps {
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
+    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
+    void (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 75f7ba7bed..82627b12b8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -664,6 +664,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
+        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
 #if defined(TARGET_I386)
         if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
             X86CPU *x86_cpu = X86_CPU(cpu);
@@ -673,6 +675,9 @@ static inline bool cpu_handle_halt(CPUState *cpu)
             bql_unlock();
         }
 #endif /* TARGET_I386 */
+        if (tcg_ops->cpu_exec_halt) {
+            tcg_ops->cpu_exec_halt(cpu);
+        }
         if (!cpu_has_work(cpu)) {
             return true;
         }
-- 
2.34.1


