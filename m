Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA166CD98C7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4un-0000Xb-3E; Mon, 15 Jun 2026 06:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tv-0000R9-Jc
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZ4tn-0001SV-0S
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:50:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so1963234f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781520633; x=1782125433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2VrJ5ZgsRdlINMUw7+Y3JTp3T0wQXEu4pb+cZQs4R6k=;
 b=CfFLU6ATwQdxFFk2Y8yD7irFfX+B7D/hZDdsVVb6Nf61vgKf+VmSgYT04/VsTS1cvM
 RZWRmXGFWD81wzzkFBSVlaYlQP6gADCinIo2gBRUGvO6JVmc6R+7Go9+xdEHN+MDZM+k
 VBz9dIKLy63SptjGYnoT79CYpdEY73lM4byajWU4jylBbwpFtpVso3Rc92C9eKlXrQGZ
 82LCaZRtZxZ2FxkLPF20ZSQmOfb3nE6sU3IenEQpzl/BghXUism1Bz4rkljWv+RSEhCu
 bhSzRCVzAVJQhBos6YcvrWpJE7vIsKq2xacXauxm0XEZjeRyxr2VH45rWN5RCDVWjcZn
 yBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520633; x=1782125433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2VrJ5ZgsRdlINMUw7+Y3JTp3T0wQXEu4pb+cZQs4R6k=;
 b=RaaYxuDjbgrALeMbGbiHbTOclUxqIPWKIXCyOjiDFccPgPbV+A+UHJgNypb9qUcG8v
 +9Sc3FV66gO/cd4XsymAy4jAtsEG+nHDI8eYMeI+0gtE5NanMNXrD8p/kRYoVMhYM7oD
 dzVkeIn/5B8ppBih4crYRj/pcLhWjAkXM23u45G67dR0Yprl0WAp9+TvWQ3DNW2+zHk5
 JsUXIRGU8QYCM9fiA5Ja7FGtAh/+VkcusFMJtYiZV8m2rJi4I/S2ZcYqpHP8fKv93DL3
 dE9yRKjFnYuHglDTN947q3HBRag/k+6mEjudImkuyd0koRDIiKjD5fJdazPXLmoqkgH+
 XJuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/9ILbA9OZ2reaWBOdKqR3jJBKMr+mbnbJ9XgEzS4NyFmyBPkOlZd9M+DjRdsyZ4Ht9abr9wuzsjvb@nongnu.org
X-Gm-Message-State: AOJu0YyrIbKFN4q0DMVyPG9jZl+Dep9oVrugeYTSMYCPBTnDV9NwSPUE
 6CE6YCnPwRlYY0cL2c14zc/+xHwt2kAx6rYHEllr4LtUxYYz+/uuqd7OnimetiTwwLk=
X-Gm-Gg: Acq92OGUpQ3T+JlhxM0JpT75LoZKXWRx8eEQRIJgQP3kplZMchu3jUQGXPwk+/fFFkN
 jUMk2w1UekkT5zxd9/t6dLx6cdXQYlbqGRHJFe4raascVPH1JIwBwflFqUFquGKkCQq7UMIpSOn
 rEBZMmgvxAWHIpUf2AsSdGi6+2fsSQygx6CYmTXy+Qu4eoVL5uFwVi3AndEIZOyAF3RhecmGFXt
 wHkBZWXAVba/75BcnOY8ySRVl7Htmv5IU7m1ZIQWPHQBsd3IKUhI8YTfG2eIoQUBcmVlsKMw7sG
 8WPKON9YdhT+WeMVm8NKHTTWUE9WLwWpDoUogTkdeP/ihGdkRij6tyZ6YK98RvJwQsCWe5cS2xa
 sXy32sIBE0ReK4OvIcRKXO2Z6aHcEvFgqHYmg5APIorui049wEtPPOWyua7P0DunA2FUWjmSo+S
 RGbR+b5QGxBQbHmg3fVKz42guEyP2std2f5ODb2J9fmj1NywWUJ9HHPID/s5B8hf8tumrwxei3x
 7FtxTr6KcRNlVQe+LsyoiwiMyDx8HsQ
X-Received: by 2002:a05:6000:2210:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-46074a8a01cmr14314126f8f.24.1781520632905; 
 Mon, 15 Jun 2026 03:50:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm33863674f8f.8.2026.06.15.03.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/5] target/arm: GICv5 cpuif: Recalculate IRQ/FIQ on
 ICC_PCR_EL1 write
Date: Mon, 15 Jun 2026 11:50:26 +0100
Message-ID: <20260615105029.2898872-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615105029.2898872-1-peter.maydell@linaro.org>
References: <20260615105029.2898872-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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


