Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54ED1C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgE-0007Hg-Mw; Mon, 29 Jun 2026 08:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006vc-0M
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfa-0007P2-Fx
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so2283921f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734456; x=1783339256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rI+HS35xOsQlDFg64FvBF7DCHZ4OhMqSz1As1ax8qfU=;
 b=HGCFc0dfwJlke5eUvVeh//3LJaesjgd+S2PvaQSsmsWEOAW7mF8DGhpmg2bfXodrya
 5reILBxglx9uzd2VqzZ+V7WaLT1wxT0B0P8HQAzWUv7w3BHBrZiZW9SLox0kECzxMFPu
 HZB7QG1DqBa8cc5ofzqIcEAaYNa54qWOJgzwVaheKxsM0WsfXQruncyNB+PTacUD7NEk
 9wlYNMsiafik2xkcP8M1xf2BfwWz7n8vbA6i/7HroRUbY0H2yZaCIyvQKwTmRWogNEia
 n8MllrcLl5sNQDs8qiW7Ed+V83DnqI4M8rXfAPgjQOrNcJToQYNe4tIT7rWaxaFqHZmD
 TB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734456; x=1783339256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rI+HS35xOsQlDFg64FvBF7DCHZ4OhMqSz1As1ax8qfU=;
 b=qwNYHxkTO0TxPzlRO9FIIO3L72T/fAVih1IYotTzHwV06bJAZILzQHrYGO/VKSCejU
 kNUgTbDIIE8O+sL+D/crYkSauwqG+fqsQDOVcpLIUiPI2NWTemWU3awfNTZGijG1hm93
 iiL2TqkuTR6QNgdGgxAzoMSIR4TgcxoEyJOwASbGWdN3lgZc1wy3YRxlzOHT5yGZmC6+
 MG7OXXez1Mn6MoErLeG+amHIUJkuwTAg6ESc46Dox3Pkgwjm2PuDRObSQHsfGM9QELTD
 ofPWy736vb9GoGDyWXzkO4+uyL7kZQDoxN5iWBlCw7DMGu0TDUUBAyNQSrbqP0kKWkJg
 0qsQ==
X-Gm-Message-State: AOJu0Yxk4XZk95JbTHMTMKISJg4Skc+XwZYe+b485lW+nwt3XUvrXr80
 uJzK2CqySlusb4Ob6uaC7x5RWWlj43xMgH4vhROOjc7eMBqSoeKGlf42N0KXXiA9GB6sC5wiKgr
 n6oYZ
X-Gm-Gg: AfdE7cmS/BkTtNviHcQG6KrKFcyOrCVzlepxEWDATQDFyuXr5xinUjZrF00GHih7YYI
 ZRILqsKWC5USj/fEBLwPTKUUqKQocV/wEu4vB2fWJHOmO31tbpzSZQ5+R/gj+wDTw5iGKCyDMHc
 MZrMG5tKHItgYb7yBwaNi2vLyi2bm37WoDGAyIvCj3P1cAP+ZtJpgE18tgW8HNrUB02dLR3N2Uz
 E8cl7tW8CN/TmgI+yW/5Q7CsLt2a98pDSOLm7AGjdeGvd+QnFdfYU3xeqCyKG8XJDAJP8rJQ1nF
 PclS+rT4tWojUB+SZyITawCWc9cM6RCExVThLyXWINhKusqtgODwJLMBYUlhSPpoMgxINC/br69
 A/7tQ3CQXijwiGyR5xjIi8ewL/bjeEo7QdwC65q/JeV9gMjOa/IDW5zwGLt94aMn570SICycqwR
 VEHk7n68W21p8bY5CcjRM9/uZtKu+mBec8P8ONjz4ErddG6h3krLBY3IBxe/To6TNL+iKI+6AD8
 2/g2R2ARqo3YQautqmHQWj2Kv8eWADQ
X-Received: by 2002:a05:6000:2512:b0:46f:f12b:e45a with SMTP id
 ffacd0b85a97d-46ff12be583mr14736952f8f.23.1782734456213; 
 Mon, 29 Jun 2026 05:00:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/54] target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on
 ICC_PCR_EL1 write
Date: Mon, 29 Jun 2026 12:59:59 +0100
Message-ID: <20260629120032.1645265-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

When the guest writes ICC_PCR_EL1 we should recheck whether we should
be signalling IRQ or FIQ, because we use this priority mask value in
determining whether the highest priority interrupt should be
signalled or not.

Fixes: 9bd90bddb79b ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260615105029.2898872-3-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 891cb2d3b7..09c3fdda61 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -565,6 +565,7 @@ static void gic_icc_pcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     value &= R_ICC_PCR_PRIORITY_MASK;
     env->gicv5_cpuif.icc_pcr[domain] = value;
+    gicv5_update_irq_fiq(env);
 }
 
 static void gic_icc_pcr_el1_reset(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.43.0


