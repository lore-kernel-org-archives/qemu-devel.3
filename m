Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1575AC48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUaj8-0002Uz-Ci; Mon, 29 Jan 2024 18:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeI-00071f-CF
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeD-000063-NJ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:39 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ddb1115e82so2246348b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569356; x=1707174156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qg3ZIcWG7UYKvaB8+csAeQhagpxbl+IqGiAj8oTWzCY=;
 b=PSQjnajTyl9ULQX7bFv2kBA1oMwHCivUIbTfGCN2gAe+oMFDAzSeoTZLhmA7mRUvTP
 I5sPwSbOFvbB/rf21bJ+r2dpTf2Zf78qKRukIV8T8CR6vh/C4yKx75txJYPrcGxWMlek
 O5WBYp1kHgfGNSc1M5km9Yul/yht7Xy5HWQ3g+g+/2B7F3t1fRO/e6y1g1tLtKIrthjH
 uuS2BPVY8NYnrr1FH2TnaoRX91mEH9a7vjgDjWa9WQ7r+uQTzOgSpaHwtfu2sVYZGlMu
 v74Cdng3e+o7+Hldny/aYRDtfkO+YJBxIVKFVRq44S3W+e1ZSHBgF5HPqpByCydMFTse
 So1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569356; x=1707174156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qg3ZIcWG7UYKvaB8+csAeQhagpxbl+IqGiAj8oTWzCY=;
 b=GWxNwhFCBARH/ZQ5496YhRx0+61ILRZI2YbvCANQVx8ylxem9/67IohZfglSP6OQ1Q
 JAHn1iv8G5sgpWxpjgnUO+GdGzI5TmfCLazEWVwN8wcagoRM4ztPDZkjhNquGRLDBQSg
 9O02DhsIlBzE4Lq33cqlIVwb5HOLGo4uTmBUscZm7GqGk3ZXwN0Pd7uGWaHotJIRZfMu
 F9ub3wmbgr2WG8h2PZY767bHHMLqZe4UPxpldI+Ap2/2vplIe8Jf2umGqcoEfVAvJJ4u
 5phhX/qjWxIQe6xoSX84dNrEUriDPiUZ1Ix/a2FOsmk7OTf1fJhObzvMjq7B+ZXgb3dB
 JSlA==
X-Gm-Message-State: AOJu0YwP/1PbJqqecYOrwqYimzi8QdAdeiDRSO49VotfjNF3TDgaFgrQ
 1WK9wqY3FqzQQfhOwlbS/coLwkM4x1ezx7GO/Ei6oWk4SlrhHo+7Pn5OutUW1yaWeroRRgiIJJh
 DmgI=
X-Google-Smtp-Source: AGHT+IHOwt5Y2iUxnaANB/q8/PiNJll6Q7FnOty1Wca9G4vtbnbzVhPN/gwYjg70gOfbPxFk2ej/xQ==
X-Received: by 2002:a62:61c4:0:b0:6de:3b41:2877 with SMTP id
 v187-20020a6261c4000000b006de3b412877mr1265863pfb.25.1706569356416; 
 Mon, 29 Jan 2024 15:02:36 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PULL 27/31] accel/tcg: Introduce TCGCPUOps::need_replay_interrupt()
 handler
Date: Tue, 30 Jan 2024 09:01:17 +1000
Message-Id: <20240129230121.8091-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
introduce the need_replay_interrupt() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Message-Id: <20240124101639.30056-7-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 5 +++++
 accel/tcg/cpu-exec.c          | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 3ed279836f..013867b890 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -166,6 +166,11 @@ struct TCGCPUOps {
      */
     bool (*io_recompile_replay_branch)(CPUState *cpu,
                                        const TranslationBlock *tb);
+    /**
+     * @need_replay_interrupt: Return %true if @interrupt_request
+     * needs to be recorded for replay purposes.
+     */
+    bool (*need_replay_interrupt)(int interrupt_request);
 #endif /* !CONFIG_USER_ONLY */
 #endif /* NEED_CPU_H */
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3aebf46849..34d10eb173 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -771,12 +771,14 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
  * "real" interrupt event later. It does not need to be recorded for
  * replay purposes.
  */
-static inline bool need_replay_interrupt(int interrupt_request)
+static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
 {
 #if defined(TARGET_I386)
     return !(interrupt_request & CPU_INTERRUPT_POLL);
 #else
-    return true;
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
+    return !tcg_ops->need_replay_interrupt
+           || tcg_ops->need_replay_interrupt(interrupt_request);
 #endif
 }
 #endif /* !CONFIG_USER_ONLY */
@@ -864,7 +866,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
             if (tcg_ops->cpu_exec_interrupt &&
                 tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
-                if (need_replay_interrupt(interrupt_request)) {
+                if (need_replay_interrupt(cpu, interrupt_request)) {
                     replay_interrupt();
                 }
                 /*
-- 
2.34.1


