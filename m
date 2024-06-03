Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBE4C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAFo-00021J-6n; Mon, 03 Jun 2024 12:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFh-00020B-JM
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:41 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFe-0000ZP-UU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:41 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b992fd796so69143e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430976; x=1718035776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+y2VUAaODGRx6I5aA9+iua3n6PE+xKIoh7aOmqQq9M=;
 b=LGshqUeL/1fb2cUS0ALjPU2MUlJ2sRnTHc2qQa0Tyfh3kTwFCNhlHrRLraRt4nDnyP
 tatm/bVL9NurrIS2NQ6Mqz0lkSxzlei27SBDQFZj57cl8Sf2y/jli+uMesa8RXdLkdN8
 THy8m11wjPW31dHXftNL09LY9rfzyWgaE8yE3hJW3iDw6tHObKr0+TKp+/PA6ynRoH6Q
 dR6Ess3iaAKpsw/EzYySP43z4ywGhnHplrgpl+A6PV3afGIpuVznyqWQDVq54743PFSf
 2W6bDjqG3HdAS7lbd9p8oAZd+j7Fu2V3bl7sYt2hWzAa1FONSZ9Hx7d6HQy9fFd83siz
 oCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430976; x=1718035776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+y2VUAaODGRx6I5aA9+iua3n6PE+xKIoh7aOmqQq9M=;
 b=GmTvLmc8loq2Mc9byrJsJ3U+UI9BJdQOgkW+tVZ0B9t7l+3kb/dr2L8irK8bBGXKs2
 LR6X+oi6KgNj3Suk8lln1XqDoqEyPe7lCMVeyWnnwRgLoXeRUvq7n4IADTYH8a6f4fQT
 zugNSu1dXu1lt+5TM+XPwFfQL7YT1Bt2wb1MQn7ER6SKkvmz0DUFh6yIwMJcNy8+qp2b
 EBfmWJyLj56WRKJHJlQpUj1+MzrgrH7ms129H7eW2GCpMe3TZYvrak31/v6mjNZV1OQQ
 /ZxVztUgYZAoWFchVNqS91uGQwWooN94WFNR4THm8ReonhxgP3oXSRniiTdNDngsbfgr
 EnnA==
X-Gm-Message-State: AOJu0YwtlNjyCCxbfqJQqH558AqR1bs4aDPunwnylM/aAzMmsvUEBi9v
 +1Y0fTE3SM1Lrl6nTY84tT7fKgytp0d5RsGjQrk797Ly6kQeE/NXnvDLafcI/42A60wk3ftE4i0
 i
X-Google-Smtp-Source: AGHT+IGfkuAGvac7mXyR0LWyUEdUCK2v84cqTqDJiP/QGmCOk5s6a5BJ9q3LbjiJl8UeGA/oDBRN0w==
X-Received: by 2002:ac2:4853:0:b0:52b:8877:30f2 with SMTP id
 2adb3069b0e04-52b8980aca3mr5781191e87.59.1717430976365; 
 Mon, 03 Jun 2024 09:09:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0649fb5sm8975858f8f.94.2024.06.03.09.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:09:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
Date: Mon,  3 Jun 2024 17:09:33 +0100
Message-Id: <20240603160933.1141717-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603160933.1141717-1-peter.maydell@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
mandatory and remove the fallback handling that calls cpu_has_work.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 9 ++++++---
 accel/tcg/cpu-exec.c          | 7 +------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 099de3375e3..34318cf0e60 100644
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
index 6711b58e0b2..8be4d2a1330 100644
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
-- 
2.34.1


