Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ACC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthQ-0002G3-1c; Thu, 11 Jul 2024 09:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthD-0001YH-RB
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-00063u-B7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42795086628so5716065e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703912; x=1721308712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vyZll+1B9ZVexjTDYnpEmOSbqEikHHbpXaR8VQUCSuc=;
 b=Axun5N3lsVTSBvNjJdw4ZscloJod/qmZj8XSd4Hnoz4jsCOfMOotZhvylSPjqnhhaL
 NEf2fBQj37LgSyn8SoEcWlrW4XZlg02BLNGrtU3r2A8Da6hEQeA4Le9XK8Fwt0ncZOQP
 6s2ctIaVstZjdfN7uJH1DQr6syO0DFGw+j3LZmodbMwT675cOPaQQ+7WBORh1EgvsGym
 LQ6Bk4G6Zb7hoOtIAQtCdXiO9psmUY/HfWWGSGhOKIrIvGOUebzUsBm+31txIXIAtzts
 2Dm+3kX42jDiruhAqJGw082Jd838ZSxaNbg6oAaRmjQkHAnODOHP7VRtaTyA705zb76n
 DSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703912; x=1721308712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyZll+1B9ZVexjTDYnpEmOSbqEikHHbpXaR8VQUCSuc=;
 b=RC+KpzY9SvbWL0kzsmWMpaCzSjLl8D7r/ARJLT1cetB2HneNtaLebZ87KO+cQPxXxC
 USdInO6prD/mnKhPrAY7EI3jq7UBdEZ/ZSMLQvf488y/UXd3n1b7l2Zn5B/rfVkqQMcv
 3pMRtxFBUI2oy+5UgNgbxEHB31tCVoOSlR2HRcLzHo36X9Vktlyi0xdbEg8EgzdSFGBT
 Bm+nsKTki70ubMR3e5Qgqc8a7pTOk2gxaBx4kMuHIVmPiRBq3xM64a9RzQTGb8VVoCiY
 hLWBWjSraRvOa+lr+wrskjQ6RleXhM9Og2Cj2Cwf01Xl2YfA6fY5skAC+GCfJUBUkIDA
 5Gnw==
X-Gm-Message-State: AOJu0YxRWlpKM8uq2NYgtNABWYAzA8ms9PCSyR8r8iYoa5j/KFHE9ysq
 b/1tfvYhynCCyTGDv0VB/FlAf1TW8hkL+PFzBBb687GbpqLpA6dzD+HJSVP+1CQjuGQTImPSr2O
 B81I=
X-Google-Smtp-Source: AGHT+IH4EX55+tBx04YC1QOZ1hPRouUg8cPAGiH9UPisC2mIV0qCJ7qsBVEFc/mt+If7F7fmyt2PQA==
X-Received: by 2002:a05:600c:5345:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-426707d8a90mr60422765e9.16.1720703912231; 
 Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
Date: Thu, 11 Jul 2024 14:18:13 +0100
Message-Id: <20240711131822.3909903-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h |  9 ++++++---
 accel/tcg/cpu-exec.c          | 11 +++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

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
index 6711b58e0b2..245fd6327da 100644
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
@@ -1082,6 +1077,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
+        /* Check mandatory TCGCPUOps handlers */
+#ifndef CONFIG_USER_ONLY
+        assert(cpu->cc->tcg_ops->cpu_exec_halt);
+#endif /* !CONFIG_USER_ONLY */
         cpu->cc->tcg_ops->initialize();
         tcg_target_initialized = true;
     }
-- 
2.34.1


