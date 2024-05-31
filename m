Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4EC25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD10A-0004dK-Tj; Fri, 31 May 2024 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zx-0004W6-NC
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zr-0003Wd-4f
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42108856c33so12123985e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157072; x=1717761872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgF5Wf6Hp5Ht9PVVSm61hfXQRRb2zA5bbpQ/5zgmatA=;
 b=uYSx0bquhiC56dXZhZBmt6vwFHEKBGvNFq3cgTJ315REVvb7tXIuZ5kbv4BgsazXxn
 F+RQYn9ZyosdwB2DbjlDO71xpVaHoFEhEvBCaKERDU8/GfmSX4O5pOCqpYUSIFEAzxpQ
 zeGF48CgYtTPzxyI9A8UFzwxCWEFTNqZKJ4fHUl/8sq2sWre8r9D7wTc16a5x4QNvTBO
 k7LzctPNicKfpbfgny7kqOIqR9H2Cdb7YoxoPpMIW/zzgS7pxXYXVZd8QDiDvXjRuFo9
 PONZEge2BavP8zgqxLnDNDi98m1jbhKftdcGmMS4jR+b4uOYvif122y9ftKDwYjWZ7c3
 20+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157072; x=1717761872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgF5Wf6Hp5Ht9PVVSm61hfXQRRb2zA5bbpQ/5zgmatA=;
 b=NZikzNqAlr2khJmsX58STJvqYyygMYRTYcLA5qeGHQKNERpIBNOsmIiZHhjvO5suwn
 q8j+v01ARVJWJue74tAfmjGn9nI1RSfA5LAKVEo7d3CfmyU1OQ8bDc+QCV0vrOZ047bd
 VhpYqpPOaxmb4VWECCm2/TiZdYXyMVV91hjKGKx6S3e84qeOUwmVBG7RTcIcztuLHi+7
 SdeeQRKy7kAh9IKmaDMuugppcNv4/amJpqvJjvBz0GJhLZp3Ck9MG24E687fDYfQeLJk
 dw/H2Ug7lGcZp/b7QDWsIUCghGJYlwbhMtyoaubFuP0cBvUCI/gk18jecXl/Nc75EEAe
 SZlQ==
X-Gm-Message-State: AOJu0Ywg9aPDC6vzm/Lqg7aNT2+P6X+yVfKxebi0cR9ZCQisMXzc3e/M
 Mnru4zm894v9P3iQRGJlSymJ0ZF6SgyTbrdCt/NNUkHuQxiTFIME8Q6mAmcpgDhxqnV5AgNMT2q
 W
X-Google-Smtp-Source: AGHT+IFCksmqOYL2Gv0zlLSP0mBaTat2+j0e88fLMA6kZaQZPvEJVT7pzpRfi6JCXWepBMy2PSd6mA==
X-Received: by 2002:a05:600c:3b16:b0:421:2974:c7bf with SMTP id
 5b1f17b1804b1-4212dd6df05mr15478755e9.9.1717157072598; 
 Fri, 31 May 2024 05:04:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/43] accel/tcg: Make TCGCPUOps::cpu_exec_halt return bool for
 whether to halt
Date: Fri, 31 May 2024 13:03:59 +0100
Message-Id: <20240531120401.394550-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The TCGCPUOps::cpu_exec_halt method is called from cpu_handle_halt()
when the CPU is halted, so that a target CPU emulation can do
anything target-specific it needs to do.  (At the moment we only use
this on i386.)

The current specification of the method doesn't allow the target
specific code to do something different if the CPU is about to come
out of the halt state, because cpu_handle_halt() only determines this
after the method has returned.  (If the method called cpu_has_work()
itself this would introduce a potential race if an interrupt arrived
between the target's method implementation checking and
cpu_handle_halt() repeating the check.)

Change the definition of the method so that it returns a bool to
tell cpu_handle_halt() whether to stay in halt or not.

We will want this for the Arm target, where FEAT_WFxT wants to do
some work only for the case where the CPU is in halt but about to
leave it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240430140035.3889879-2-peter.maydell@linaro.org
---
 include/hw/core/tcg-cpu-ops.h       | 15 +++++++++++++--
 target/i386/tcg/helper-tcg.h        |  2 +-
 accel/tcg/cpu-exec.c                |  7 +++++--
 target/i386/tcg/sysemu/seg_helper.c |  3 ++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 9387d387484..099de3375e3 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -115,8 +115,19 @@ struct TCGCPUOps {
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
-    /** @cpu_exec_halt: Callback for handling halt in cpu_exec */
-    void (*cpu_exec_halt)(CPUState *cpu);
+    /**
+     * @cpu_exec_halt: Callback for handling halt in cpu_exec.
+     *
+     * The target CPU should do any special processing here that it needs
+     * to do when the CPU is in the halted state.
+     *
+     * Return true to indicate that the CPU should now leave halt, false
+     * if it should remain in the halted state.
+     *
+     * If this method is not provided, the default is to do nothing, and
+     * to leave halt if cpu_has_work() returns true.
+     */
+    bool (*cpu_exec_halt)(CPUState *cpu);
     /**
      * @tlb_fill: Handle a softmmu tlb miss
      *
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index effc2c1c984..85957943bf3 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,7 +39,7 @@ QEMU_BUILD_BUG_ON(TCG_PHYS_ADDR_BITS > TARGET_PHYS_ADDR_SPACE_BITS);
  */
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
-void x86_cpu_exec_halt(CPUState *cpu);
+bool x86_cpu_exec_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2972f75b963..6711b58e0b2 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -682,11 +682,14 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+        bool leave_halt;
 
         if (tcg_ops->cpu_exec_halt) {
-            tcg_ops->cpu_exec_halt(cpu);
+            leave_halt = tcg_ops->cpu_exec_halt(cpu);
+        } else {
+            leave_halt = cpu_has_work(cpu);
         }
-        if (!cpu_has_work(cpu)) {
+        if (!leave_halt) {
             return true;
         }
 
diff --git a/target/i386/tcg/sysemu/seg_helper.c b/target/i386/tcg/sysemu/seg_helper.c
index 2db8083748e..9ba94deb3aa 100644
--- a/target/i386/tcg/sysemu/seg_helper.c
+++ b/target/i386/tcg/sysemu/seg_helper.c
@@ -128,7 +128,7 @@ void x86_cpu_do_interrupt(CPUState *cs)
     }
 }
 
-void x86_cpu_exec_halt(CPUState *cpu)
+bool x86_cpu_exec_halt(CPUState *cpu)
 {
     if (cpu->interrupt_request & CPU_INTERRUPT_POLL) {
         X86CPU *x86_cpu = X86_CPU(cpu);
@@ -138,6 +138,7 @@ void x86_cpu_exec_halt(CPUState *cpu)
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
+    return cpu_has_work(cpu);
 }
 
 bool x86_need_replay_interrupt(int interrupt_request)
-- 
2.34.1


