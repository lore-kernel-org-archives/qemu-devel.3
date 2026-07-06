Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37271C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggip-0007UR-9G; Mon, 06 Jul 2026 06:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiJ-000717-3f
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiG-0003HY-DI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:09 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so31422185e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334287; x=1783939087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eg2eRwi8fXdXbVGfTtLDKdMU/uLApKIx4jIhkKqt32Y=;
 b=VNmvrYH/FzIITXk3etvMgIbCFDRAKGNtnxVe/XjFZXBsfLlg+hx/s/E4VBcJ8ayfAS
 gkjKKcLYMjrH0t5P6k2ZbX4p4eFWPiJjJEo+0ItO/Cv7yxIFCyFEAISCUfVWmZLbNCR+
 ev4F38YtqyBQkHhzc2jgoLOJikYp486uYwRAMzLAzpJVURBinJWJDi6qcvcVg3x0fKG0
 ShZ7glfD1WxJykcYEvn6Q2LOlKm50Ms5X5aMMY2azAS+kYpaefO10GlYy1gjQXnvyVYf
 zAli3uzv15ouQq9fpnUmf11nhszxrIgJXFLGOsn2mtetuEExJgPR4OS59MJ3Bq9BXvDq
 lvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334287; x=1783939087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Eg2eRwi8fXdXbVGfTtLDKdMU/uLApKIx4jIhkKqt32Y=;
 b=o5Uq9NnpzrhS7zhdBxqojoObVBs+008rY9dOFAXnol+odGEET0VAfX0i52KRjjLC5b
 KZ9zVQ78+fuYOLI/StZlh2l2BdvEY6A7RdFhGkMzl5PwyB22Vhy0CK8soGMZQqRu5t95
 +ppPm/ESRWS87hKGCyF5OJipjW6ocrDTHwtofffuREL3qCCuWP2Q0Ehllf58Iha/YTmC
 X2sQBJCeN1fVbrmFpbZ/S9LjwwVTySrQCIqXM7O8WrxsSgMfqEZzp7gRdFqaOo2thRCI
 5OrFBvGCISTigIbbcyDdlvTFORii8uS0Nhs+2rj1y2nGIVY4sk9AtTa5anMEdk0QDpUt
 u5aw==
X-Gm-Message-State: AOJu0Yx5Th9nRybOJivthELVNrAps6uH0hALaFPvgc67AcgwxRVELSh9
 dLx3qih0OMVptJYOvU29m0MU2mvdFtq4cOSORTkPdRQMDPkhMhHU0MBf26bkVUD0DxnkdjHS592
 yRBxOWzlW8Q==
X-Gm-Gg: AfdE7cmURFKSvhsDW4MwmMKPZYpjGiuE7mNj3GIfeqV6ryacPjHOVKUj4TLSfYOLP4/
 p9anW0mbytG7MRPvNcvscZ6jnzD6QcQikXgRvWYzNQmvlXrdigwKoi2JUvSAWXcZgrxhekhViQf
 qLtFJS46WkOYZ6MKIHhS0Qcxz7/okVMQEA9qTwtgkQY4wivV2pE2byuH2MpvUi6VyFtQQteRYmZ
 hvFQdFEVlzEnnORnMdREE5X8MTy1xXbPMA6GlOb5h0vDlimw54EEHW796IsYWfuzRr4LSTnXfBT
 Becf2YFZWvHS5xCt4+XA0aS7xHk3ZM1fUWJIYqQE1iKjFplXMD6V8SUKgkApk7YxyGqBZSTs0h0
 LTzoEHR8I/COVoJ1Zco1zRG8hXo58XUFMlMLcgFrYJCB6kHkJWQW6aYvotZQLLTGkbxbCsU/I3X
 rB3ammBgGduguG/wOBTiKSO3N9xGBmSBN3DXmcSID/M2XMZ84254uPDOPRsfGK8fV0Ha5ZmG/uP
 8ZpYZ+fINYGBZeiBtXq+A==
X-Received: by 2002:a05:600c:19d0:b0:493:b750:bd20 with SMTP id
 5b1f17b1804b1-493d11d7df8mr101826645e9.15.1783334286886; 
 Mon, 06 Jul 2026 03:38:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/49] target/arm: do not clear halting reason in has_work
 helper
Date: Mon,  6 Jul 2026 11:37:16 +0100
Message-ID: <20260706103752.320511-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The helper will be called multiple times as we exit a loop and until
we actually restart (via arm_cpu_exec_halt) we should leave the
condition the same.

Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reasons)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260624103049.884930-4-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 3 +++
 target/arm/cpu.c                 | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 8be6a84bd5..9a45596169 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -18,6 +18,9 @@
 typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
+     *
+     * This function should be idempotent (i.e. not change state) as
+     * it will likely be queried multiple times before a CPU resumes.
      */
     bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 128c78f6cf..26bd21aa86 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -158,7 +158,6 @@ static bool arm_cpu_has_work(CPUState *cs)
      * A wake-up event should only wake us if we are halted on a WFE
      */
     if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
-        cpu->env.halt_reason = NOT_HALTED;
         return true;
     }
 
@@ -170,7 +169,6 @@ static bool arm_cpu_has_work(CPUState *cs)
                            | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
                            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
                            | CPU_INTERRUPT_EXITTB)) {
-        cpu->env.halt_reason = NOT_HALTED;
         return true;
     }
 
@@ -882,6 +880,8 @@ bool arm_cpu_exec_halt(CPUState *cs)
         if (cpu->wfxt_timer) {
             timer_del(cpu->wfxt_timer);
         }
+        /* clear the halt reason */
+        cpu->env.halt_reason = NOT_HALTED;
     }
     return leave_halt;
 }
-- 
2.43.0


