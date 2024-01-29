Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14D6C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUafU-0007e1-MJ; Mon, 29 Jan 2024 18:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeJ-00071n-OS
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:03:00 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeI-00006g-4N
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:43 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3be62ccda4bso738160b6e.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569361; x=1707174161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hwCZNX7r6WcP/DB6F59Yv2bYfXzcZik2wXoCrV2EBg=;
 b=CdT4eWumuD93e7Xp9Np0/b9qZ0wYgOLGpKeLbNRcMI4XOWDpLbfdi9bb9nhlrGzgjL
 +UdtBPmakmeEpaN9JN9oeNbFV0spiCSCa2PmFjRzAt41a09p9w3z2xbEiHZMdTprqCgt
 awgg7GBGSDGDmNS8vafpu00wbo0FAlytcoaRt6fdZVILutS47wfQhJioWEOIHwfGN2iA
 fMxHGAT0NoB2bRRz820wbgIUhjUYOlEQHkyKCS0rsr7F2VBev5fap0GboL7IWv9LZes/
 +/upB8V5KqA69IqEP+OCSQL6GH12QvXeKhlHwSemUFyGCQ495QcpNI11kh1v/vrES1/N
 79mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569361; x=1707174161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hwCZNX7r6WcP/DB6F59Yv2bYfXzcZik2wXoCrV2EBg=;
 b=OIV9b4Q4Ubq9z0cPHWSIcYfgWNAlj7W2CWUXoqtEO9jToIn8ys3jt2exG35b3BT5/U
 8tHaLi6sM9DqXEtlqcCxZ6FRX8gGGnDkOzu+ekYRDaRlOUNshBFsr/bj3zZ63z6uTeju
 CKWE///a5ob5Q3LZj10SV+CbdYcdXkflfGp0HL0t/3ibFUt5z6nUh5xWlqctFJAnP9CJ
 x8dD8tvXSGPxEnuFoj+zzthuFtken1Maxf7Xbcb/4Iuc84SFgS7FDEuJfHMfvNUzIE6E
 fLs9x6lOdgUADc11usi+mNfIPdDtWkYjuoTeO8RBBa/U4iNVKPUYnFtY2R9LiCA/X9IM
 4tow==
X-Gm-Message-State: AOJu0Yy8FPn29RXHH5KCuJDAD+g8RXSBM1d6B3UKfzNV9nbBAt73SSo4
 mlPTeAcBPm/pxCjBXGCsvKUlYSKRHEZtsA7Cv6jDBJ/855f2sS/yaI+Po4pKAzOwCz307xi029V
 aXnM=
X-Google-Smtp-Source: AGHT+IHA/Y5g49IFO+MhSt5OayanC5SuKfj4hRJbbi7ZUZDlKhrhV3YTNZx3yXfFitcmzqSwN8WU3A==
X-Received: by 2002:a05:6808:1b08:b0:3be:7667:4eef with SMTP id
 bx8-20020a0568081b0800b003be76674eefmr1963750oib.27.1706569360793; 
 Mon, 29 Jan 2024 15:02:40 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/31] accel/tcg: Inline need_replay_interrupt
Date: Tue, 30 Jan 2024 09:01:19 +1000
Message-Id: <20240129230121.8091-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

The function is now trivial, and with inlining we can
re-use the calling function's tcg_ops variable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 2eacd694ea..75f7ba7bed 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -765,20 +765,6 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
-#ifndef CONFIG_USER_ONLY
-/*
- * CPU_INTERRUPT_POLL is a virtual event which gets converted into a
- * "real" interrupt event later. It does not need to be recorded for
- * replay purposes.
- */
-static inline bool need_replay_interrupt(CPUState *cpu, int interrupt_request)
-{
-    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    return !tcg_ops->need_replay_interrupt
-           || tcg_ops->need_replay_interrupt(interrupt_request);
-}
-#endif /* !CONFIG_USER_ONLY */
-
 static inline bool icount_exit_request(CPUState *cpu)
 {
     if (!icount_enabled()) {
@@ -862,7 +848,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 
             if (tcg_ops->cpu_exec_interrupt &&
                 tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
-                if (need_replay_interrupt(cpu, interrupt_request)) {
+                if (!tcg_ops->need_replay_interrupt ||
+                    tcg_ops->need_replay_interrupt(interrupt_request)) {
                     replay_interrupt();
                 }
                 /*
-- 
2.34.1


