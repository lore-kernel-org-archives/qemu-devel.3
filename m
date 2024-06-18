Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA978C2BA18
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLc-0006j5-8M; Tue, 18 Jun 2024 12:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLZ-0006dL-9P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLX-0007k2-7n
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4218008c613so42804085e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726767; x=1719331567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bnMf30zvDwvxbd6Rx2qugerMz4GF67L/Ogj3GpoZRCs=;
 b=M/4m5+4lCsT9kwLPYf4cRncvvu4lwXQSlSXq4I5OfUFz8ne2XylcilG0e00hSeMtRY
 Lm+ULQZEDvVUttbXAmJ5Mx0mT0tlQMt1HpspogSZQPgS817DN5sQ6q7zvEb0qNOWLnF4
 nykq9tEz/LmDmq9ygOauLFjJhyWYo2pMmGQZ4d3dQQCHy8y2ESt7S84zsFd/sDeC3Ly/
 t8rD9lvHoJd2O0NPuuTVIo/dIE2x6a0e6kjEN5m75OQeae9dtRC+GmjKu7R+/1tiO/MJ
 Gy7vSARBPba+0nWGURyeC1/OPLtqFHrPbr8R092eTCxeZiGh5+DFS9/zYJsxFSa6a6c9
 8V8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726767; x=1719331567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bnMf30zvDwvxbd6Rx2qugerMz4GF67L/Ogj3GpoZRCs=;
 b=u9/tviXzzoe5NesMxLvLScTgryb9QXNdsH5LXV3csm8LZjU6wucksi+IUMNtavkoza
 6acaSDZzbYYnoMS/ubUBaMUZhX1lKeCM18ibanOD0X20VfGoHlVYX8i31T08d281JZkN
 lYIeIN3b68ZjQWydH5XknG73RLuN/9qot3w7i6PyJG2J4mVw8sATvUwPnbk2CdWg7TLn
 8ILS0YpSVrStUV3eu27vtRbcIKWTDf1dYVPMqejboQt12xVkWRdUZO7gcA5pfMLjwo7m
 8YVS0KfVOgw0h0iANx49dl2qtYqZWCyXmvzfZRiFhENzN6RFUxflXbyW3VhG5cQWAsu+
 goTA==
X-Gm-Message-State: AOJu0YwzyQDWjBVKNFhdSja+wq8A346uTHdrTGK1PvlG2WCoAnmoRfQE
 aSur5WwbvXZuxBl9p4TV/7BsKDlZrME3M090TVXw2vuspDuHUQTv4PYk1POnwCGSFj3/ROBvpJD
 4
X-Google-Smtp-Source: AGHT+IGJW5qMOb6Sr9bGHXvch1hmGOZSir4EArLdqcguG3NefJAYwYc/Nvwaf7MB96D49AqE45Rzzw==
X-Received: by 2002:a05:600c:3b05:b0:421:565b:e71a with SMTP id
 5b1f17b1804b1-4230482278emr88215265e9.5.1718726767490; 
 Tue, 18 Jun 2024 09:06:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f22absm14649703f8f.79.2024.06.18.09.06.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 56/76] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
Date: Tue, 18 Jun 2024 18:00:18 +0200
Message-ID: <20240618160039.36108-57-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
mandatory and remove the fallback handling that calls cpu_has_work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240603160933.1141717-4-peter.maydell@linaro.org>
[PMD: Add assert(cpu_exec_halt) call in tcg_exec_realizefn]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h |  9 ++++++---
 accel/tcg/cpu-exec.c          | 12 ++++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 099de3375e..34318cf0e6 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -122,10 +122,13 @@ struct TCGCPUOps {
      * to do when the CPU is in the halted state.
      *
      * Return true to indicate that the CPU should now leave halt, false
-     * if it should remain in the halted state.
+     * if it should remain in the halted state. (This should generally
+     * be the same value that cpu_has_work() would return.)
      *
-     * If this method is not provided, the default is to do nothing, and
-     * to leave halt if cpu_has_work() returns true.
+     * This method must be provided. If the target does not need to
+     * do anything special for halt, the same function used for its
+     * CPUClass::has_work method can be used here, as they have the
+     * same function signature.
      */
     bool (*cpu_exec_halt)(CPUState *cpu);
     /**
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 6711b58e0b..f7f8683a1b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -682,13 +682,8 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
     if (cpu->halted) {
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-        bool leave_halt;
+        bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-        if (tcg_ops->cpu_exec_halt) {
-            leave_halt = tcg_ops->cpu_exec_halt(cpu);
-        } else {
-            leave_halt = cpu_has_work(cpu);
-        }
         if (!leave_halt) {
             return true;
         }
@@ -1082,6 +1077,11 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
+        /* Check mandatory TCGCPUOps handlers */
+#ifndef CONFIG_USER_ONLY
+        assert(cpu->cc->tcg_ops->cpu_exec_halt);
+#endif /* !CONFIG_USER_ONLY */
+
         cpu->cc->tcg_ops->initialize();
         tcg_target_initialized = true;
     }
-- 
2.41.0


