Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736FAC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 20:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJfJw-00064o-0c; Tue, 18 Jun 2024 16:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfJs-00063j-Qq
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:20:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJfJr-00022C-2Y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 16:20:44 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-421757d217aso60947845e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 13:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718742041; x=1719346841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rVA+Vu4Mo6m4DphkREolWxSHwsbLZ4D72iVee/NbV7E=;
 b=rhbB7+UtEdt/LM9+BkR+pAyRZ5gVUzhPH8VIwyHcJSvQf6bgkjNcVSmfzDQOV/TLgx
 IxYObnjUKla+yDsGV9zdeg/96scIhgbQzN/zQVX4yLbm0WJ902IGYnXx04keHtdn8+FC
 1W0DWcDRwa+cDWtNb/NFjg6UM+KnTnDOI11xLfQdZZE/BzxX6gnSWEMKpPnGdmmqAcnC
 fzfjXvixZtCf7/mH2HzF3oA0LxLnB5tJy9Kb5KNwKwT4lUjQhAKKRdpOgXFuy5RtA3x/
 HFdaoFIceQnyygrF5agR6IQj3KiEHPku9zO4cGeotCG+3YciEHGoKFc5iud4r5RI3dsV
 Hdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718742041; x=1719346841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rVA+Vu4Mo6m4DphkREolWxSHwsbLZ4D72iVee/NbV7E=;
 b=gIuCCT3TRpzhQSSFJg8gPKpxXiibp3ZVk/VSJ8ILULJohJQAr9OvEGpg5brH/rtG1X
 2oQvlQxDhXqk35UoznAr9si/LXQVkcrMTU2a/GRT0TriQSn5Z2OGeGbTscCoojG3Sqn+
 xORCwYln+sBTuMpTVUNIB1bLgOqaI+wN4np9XAVDkBZPoxSXqu0gxt8Yi2vBOwWClju0
 c5uLWwoP5rtAd6a5cYgDwM67wRbndpOiVLpqq6HnXOKHxFOqJ4xVLzyR9H9eD9zLjfjc
 1smeaVdfGvNd9LUSSJi6MnJs/xhQ5/3znPDnkugRj24QkNvoSmyGPoBeU5D1W4PS/I6U
 AXMQ==
X-Gm-Message-State: AOJu0YwzbtUgeJEzw+5RWqU+IDJluu4drWG02ShxVdDadAkPPkUZMCyy
 j/v1sEH7Ebk4KopUBmSwZ+jOpIkPfNOsFkGJKaNg7+qnHm4/c9nVGwI46+zeQkdFVJ21K3TR2xZ
 N
X-Google-Smtp-Source: AGHT+IHi9/r42QzpcCLvOKqUsMDuWTTaM0YOXL5xWZzYrSEhbgqzlGKx9c34g1fnWi6eb9pRFJofjA==
X-Received: by 2002:a05:6000:11cb:b0:35f:2667:8b4d with SMTP id
 ffacd0b85a97d-36317c79fdbmr531891f8f.40.1718742040897; 
 Tue, 18 Jun 2024 13:20:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm15058039f8f.82.2024.06.18.13.20.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 13:20:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 56/76] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
Date: Tue, 18 Jun 2024 22:20:32 +0200
Message-ID: <20240618202032.40268-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618202032.40268-1-philmd@linaro.org>
References: <20240618202032.40268-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 9 ++++++---
 accel/tcg/cpu-exec.c          | 7 +------
 2 files changed, 7 insertions(+), 9 deletions(-)

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
index 6711b58e0b..8be4d2a133 100644
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
2.41.0


