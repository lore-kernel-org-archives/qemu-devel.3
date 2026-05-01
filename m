Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FA6CD3425
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuP-00046N-F2; Fri, 01 May 2026 06:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuH-00042Q-Ku
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuF-0000D4-RA
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so15952085e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630534; x=1778235334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OInFSah93JMGYAyEONqdnm1Dp5zsBSy9UAN4mJo6cQ8=;
 b=HFstDFX6ePSfZnPF1jMRRZxJNzvohwXluI+l4rLRBopJ6/lM4rxWK/iTP+8d3jC9v8
 6mgRlx8MDJhdoqmyi0LVtaAuPe/RtQRloWnOMNsEDxiGSe7wuSGekUTypV5i+30UTncw
 p0RfnkyhWf2Bg+ixa61jGsftFtxzh7j0zAtJ2sckVmjJLWdgj1PNRqT5kFcG5BAPTXYx
 +9skUGAnkyakUS5Wd/nOjkRjFuSYbTFtG+zVeg7lV9d4ZyssJQrNkUXcLi0nJ0yEpZqV
 6ueJpTDl8/e3rPjf6Rf0M2RhYv3M1P8vTmmx/Rlho9jzQ0MxAGrDWAbE3fLTqWK64tjz
 fRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630534; x=1778235334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OInFSah93JMGYAyEONqdnm1Dp5zsBSy9UAN4mJo6cQ8=;
 b=JVCbYVk+LJpZnVcK4yfeQ8GCQapT4Bh35N+ShCM0riZOkyAbkc5hhMxNB5ozY6PAvp
 zVEPUz2JAv9y0/9fYQdMThgxWHo1UwhQcSaijDpK+TIK77bSElLwMMuxLBN9LCIl16Mc
 J9IDMXBWfG0ZFBaXgnKKjvwekMXH/40cqRwlW28PEalFVFNa7xtzjq1voYLBKKZpxtW/
 hfbthshvGO+AicWbb/l197USDIhYYJnGHy46dfdoSCEz6ivXvDx6PMRPJf/pZ58QIvsb
 wKDx9lKGl7neHEtaKOnWPnrdNRtNPMk1Dd/jGB3gWHPBh/RksuYD2buFJ2+ykFTdUJkj
 ueZw==
X-Gm-Message-State: AOJu0Yx3sfqB0/ZKDuG0NQswT2GOo08dZXMJLs9fqJATFOnEL3N7+un5
 F0tMzWNou1cuf9/UHjiDi4meCBwABEBlx2QmNnol/66Av11NkbpZp4ky1MA5lVNjkUNenivCK7O
 0Yi5e
X-Gm-Gg: AeBDiesT2UpHMA6pAkCOFElVaPDoRdUwkjFQjJeRVuPqpawlZO+RjC9P7eq2bkzVhJZ
 5Lypw8QYRAAheli1leCSxm1Nwdong6mcIHjNsgfml1JWf7y1qq1NDouG6w4Kg5w+XAlPH8Q/X7l
 6zWoH/bcsfaVla4AcV8itC3aeGchIQ38pE5GpMxOuKsIJRoD3xW+XwqdzNrNvj64JkST4/DkIlV
 ADsaF+Zf2uDJ0RxdjQeA4xb97T2vEEi6/pDiDswsUTE5+dXT89naOM/1eQu09lG8kb4sQi7Uxyn
 kTiYt6dtShfTGfNZK+IaWOo9/unkII2dGgvqPGynxKetHsSH4DLsjFEgxPrpzHiUAwlD7eW10Ll
 IBvDc/NSeY10rzXt2k/WmZ+ZtMXLixP3YXnBRdaXfbLgsQ2UXf9j13xOFsz5d/eZNlFUxqke3GS
 Yg2N9DXyIsp5AQ82Vd6QIVBiPXQbOeTfDXxxv9MrxW/uhZjgqzGdIGMnzR53k3zxcKDW4bQEJSf
 +pcBEb8QebWAXCtk5NYFMEY8bAPoNgoQnE63UaFAQ==
X-Received: by 2002:a05:600c:3b16:b0:488:9439:880d with SMTP id
 5b1f17b1804b1-48a8446406dmr108050065e9.29.1777630534438; 
 Fri, 01 May 2026 03:15:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/28] target/arm: hvf: add asserts for code paths not
 leveraged when using the vGIC
Date: Fri,  1 May 2026 11:14:59 +0100
Message-ID: <20260501101505.3485916-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When using the vGIC, timers are directly handled by the platform.
No vmexits ought to happen in that case. Abort if reaching those code paths.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-10-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 390a3529ff..38f88c1a80 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1696,6 +1696,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
     case SYSREG_ICC_CTLR_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_read_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -1986,6 +1987,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
     case SYSREG_ICC_SGI0R_EL1:
     case SYSREG_ICC_SGI1R_EL1:
     case SYSREG_ICC_SRE_EL1:
+        assert(!hvf_irqchip_in_kernel());
         /* Call the TCG sysreg handler. This is only safe for GICv3 regs. */
         if (hvf_sysreg_write_cp(cpu, "GICv3", reg, val)) {
             return 0;
@@ -2393,6 +2395,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         ret = hvf_handle_exception(cpu, &exit->exception);
         break;
     case HV_EXIT_REASON_VTIMER_ACTIVATED:
+        assert(!hvf_irqchip_in_kernel());
         qemu_set_irq(arm_cpu->gt_timer_outputs[GTIMER_VIRT], 1);
         cpu->accel->vtimer_masked = true;
         break;
-- 
2.43.0


