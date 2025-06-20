Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B78CC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk3l-0000bo-Cq; Fri, 20 Jun 2025 18:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcB-00082R-P5
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcA-0006fP-22
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so16817345e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440800; x=1751045600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ee8LaeRodpj5Y59utJUbkpQXq+s3UXrcY7kjVMOzKm4=;
 b=Kjhk9ftXqWDDTjjgVDLgA2Wd5jC2gQ9tIHyC13n0o8JEL6Sxrc8sEMzfeIln2cofCf
 0J0xLoe5yV4skLMaoOFYMeyYIS2p0swdZb57jjOz3xaJHUQe/lQ8Y2H1iTfwC7rJRkQj
 BjtB/oh6u3rDOONcEGWYBOD3mOuqPTu/r+UP7Sx6GRUWRySl06VMZv/S8k1c85E7BOll
 3gVjiWkiJO9IGbuyw6R35rboLHRfJiDO/VY5nKnrjzyf6utKvdSNd3snpOVEGTwq3NYj
 yEwkURmkWBcwYYtotjfCTgoGSm4zBJPYLk6Tyrj7NbmwbxlXU7AJE0RGNaOFzWdY3IRn
 PQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440800; x=1751045600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee8LaeRodpj5Y59utJUbkpQXq+s3UXrcY7kjVMOzKm4=;
 b=vuC7lKAGvyS8q+gw4jLssjDUgqJxgPKngFJTJvO0ndlRyDB9zIcZwC5X3B+ZXcC2Ud
 +fau99UVRhyyyW9XPd6SQQKiCfWen1QCsIAjrHpgAq1wAKVexbz++x89x8e/zZ7EVeJa
 jlu90KDHilptBPDLmAY13+EIPVTwbNQlHHxeElaehPfrOJJB0MOi1m6jvgTn5QRYpRm9
 Hk6AXmDOlg3VGUHZjkgniYJdVhuKid4Y6e/gSMZeSeE0ty2IOwjqqgT46XQVya8bOaMO
 U8Ctits0ddUA03sQRx3GsPBaPNQiUENRy0fM1mmRXxWd6WNi9zbvco8l3OT5/5BbFsny
 mOVQ==
X-Gm-Message-State: AOJu0YzPl2ikdBsZ8QYoGjqq86pi+nlvs7aNnuUTwM/56KkJKDBT/XW7
 Ualf2F2NF6QRTKOrT91eN+oLCCyJ5LQmvPSDZI2g75KgX0T5pq9VIi8sPyKqqqWyFukfIUx0DgK
 8cKRcBu5pHw==
X-Gm-Gg: ASbGncsrm5T+c6674Ddpx3mpJuCNvthsupJOs9a+CB2PSMSWI6xqDZCz2TeMN2hte9N
 N+Rrgh+kwhzUgf2FHzc6cFsK0BeSUUiqGKNLYTk8Rraiap5iB32hpfKG72EXhUuKJP39hq1sTvE
 6XNTHNWBa+lERLeeKIFlFDf/9A0/Pwx54Llj3wiwruVxDcZdywj7EShY3l8E6uGIu0IRj3XtPwP
 aCB4/gs/SWNi6TbZ56h02Bc8pSw/miZ05RapCXUEEUKi0nS0hJoaxeqk4uX53hJOhkuSh7N2w5x
 FrIPGS5kqEJpqPpyuIpaEagPmwoXmrkA+mnxB0DV00WiZqmjNEQv4FW4afeBWZ4vwP7qnd2mH5z
 yLMe3pkAJbv7FlmKwsoUQjrslLgQ4rdhGWiFlrKQ2+j6Lzd2P7t5d9j7Q
X-Google-Smtp-Source: AGHT+IH8ZUfdUVwnVVjxW2LGFKTeS1zwGHu2Kjcblt28xo+0i0zDAnfcJrpXYI1wFBPB6Xol1LKxfw==
X-Received: by 2002:a05:600c:c103:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-45368787924mr14338455e9.19.1750440799956; 
 Fri, 20 Jun 2025 10:33:19 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead202asm65130995e9.27.2025.06.20.10.33.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 38/42] accel/tcg: Introduce
 TCGCPUOps::rebuild_tb_hflags handler
Date: Fri, 20 Jun 2025 19:27:46 +0200
Message-ID: <20250620172751.94231-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In order to allow rebuilding target specific TB flags,
introduce tcg_rebuild_tb_flags() which dispatches to
a TCGCPUOps handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 1 +
 include/accel/tcg/cpu-ops.h | 2 ++
 include/system/accel-ops.h  | 8 ++++++++
 accel/tcg/cpu-exec.c        | 9 +++++++++
 accel/tcg/tcg-accel-ops.c   | 1 +
 5 files changed, 21 insertions(+)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index fb265d0cefa..a3828e34145 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -54,6 +54,7 @@ void tb_reset_jump(TranslationBlock *tb, int n);
 TranslationBlock *tb_link_page(TranslationBlock *tb);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
+void tcg_rebuild_tb_flags(CPUState *cpu);
 
 /**
  * tlb_init - initialize a CPU's TLB
diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index dd8ea300168..bb047461973 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -67,6 +67,8 @@ struct TCGCPUOps {
      * Fill in all data required to select or compile a TranslationBlock.
      */
     TCGTBCPUState (*get_tb_cpu_state)(CPUState *cs);
+    /** @rebuild_tb_hflags: Callback to rebuild TB hflags.  */
+    void (*rebuild_tb_hflags)(CPUState *cpu);
     /**
      * @synchronize_from_tb: Synchronize state from a TCG #TranslationBlock
      *
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 29ebcf45928..20999033c89 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -71,6 +71,14 @@ struct AccelOpsClass {
     void (*synchronize_pre_loadvm)(CPUState *cpu);
     void (*synchronize_pre_resume)(bool step_pending);
 
+    /**
+     * rebuild_tcg_tb_flags:
+     *
+     * Used to rebuild TCG TB flags when a hardware accelerator transitions
+     * to TCG, prior to calling TCG %exec_vcpu_thread() handler.
+     */
+    void (*rebuild_tcg_tb_flags)(CPUState *cpu);
+
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
     void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 713bdb20564..7ded765889c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1028,6 +1028,15 @@ int cpu_exec(CPUState *cpu)
     return ret;
 }
 
+void tcg_rebuild_tb_flags(CPUState *cpu)
+{
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+
+    if (tcg_ops->rebuild_tb_hflags) {
+        tcg_ops->rebuild_tb_hflags(cpu);
+    }
+}
+
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
     static bool tcg_target_initialized;
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 0e4ef548f99..a141c4702e4 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -242,6 +242,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
     ops->insert_breakpoint = tcg_insert_breakpoint;
     ops->remove_breakpoint = tcg_remove_breakpoint;
     ops->remove_all_breakpoints = tcg_remove_all_breakpoints;
+    ops->rebuild_tcg_tb_flags = tcg_rebuild_tb_flags;
 }
 
 static void tcg_accel_ops_class_init(ObjectClass *oc, const void *data)
-- 
2.49.0


