Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0EBCD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYup-0003xi-RF; Fri, 19 Jun 2026 09:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYuo-0003wA-Oo
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYuk-0003PP-FA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so6982585e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874341; x=1782479141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Il5WY7QfACzZ93YAvZWGe3XWn3xPIGhu97enE1XxJnA=;
 b=ZLIbRfbg3aaP2+iuGlC8wsCnw7rQRyaXotxuWfrlcXrVLZIv/rxiACn7kQIIlbQzFD
 RjT4JdVJPXJQqV9CbNmYSpRHEBal7DwmAozLQh3udn/RQPfPSnXwY1sZYmaaaAXBB41Y
 tGoSRGTVDHSzg3zvfC6RhgERuAHa46Ogvn7wSIwGXRNgDhzYRa9Zz+Y5zHvfbNtJ6phB
 UomThOgnJzpRhJPatLBBZx0Rj4LY45m6OLCaJNnaZDMwXcswBI8EGbMDxxpPJqS7eCMO
 r/llr+eKdgoSpTJBNquqTdCVR3xmHqA+H1O10zQcNaMS/wOaDvOwvyNNoYIdSRg9ILsL
 adRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874341; x=1782479141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Il5WY7QfACzZ93YAvZWGe3XWn3xPIGhu97enE1XxJnA=;
 b=K8z08J0dkjaNBUT3JU4lnFYZv30rP2jqr7K+YiHx6TtKoBY1BmGpgoMgFFqc84k5AV
 j2ria1C0/MzgXIXZoHlrLqhMM6/kGHoKjs2mLprKUd1LHzEXi9iGLBKxzpK70wxpUYJZ
 jKgDD3uh9+q62qsw1UT7z/ZmyDu1v3yh2X5aWh1Dc2+ADo/+wod47ho32gboC8xAux3T
 spfy3vYkUavN38jOiilDIkApwlAS9seHnvnnuZ6cuT038wIgFFgQqHdKu5UAKDauWTnB
 Mm3rXu0aeInXVRmuQo5fZJMsf63oC4Xty3L6c/4uUMnhmPUwT6Gr1IjJqhh6NNn+LZRF
 4Jpg==
X-Gm-Message-State: AOJu0Ywd18yeYW7vgh649/DxN8FeBbf3STviyMQMZoxC7Y7ye1ZZebRp
 iE76MsVLa5Aikiumy8S3ppx9i9RzCfYH6vnps+tsaQInG95nSqfwRHpV6x8pAeXDsXE=
X-Gm-Gg: AfdE7clijc0YA0qY/eSmEmhdE0GCIU4TAOrIng7S/mCkD+gBWbvV1ldmuqY/dej9BH4
 tlij6KKgdSWepJvNQ88u2oKPxJ9JVgi64nadbEFB+GWJ6J00KNsUq1LDCxq4cW9I5FKcwp1F0Jx
 IHcPhPwp6PdE+9F9XH465jWEB2+x4oF6or31lmzN/cqHzAVOsUTnwkCNZCAMFnw//O8LpKX7A97
 rw8gWO1mSoEF2hbz5LQzelQ27pdbAkNkgkhRltRPgP+58DP8gF8lJ9sLo/CzOweqBH9MFsVTLMZ
 K65CU+ypibgjn6DkU2Fp2I0tygJE1vKwxjRpS8zTPjns+x6CP9iU4OQrt4LaAl4EGpazrbXvvgL
 zMT6l6XAf3zErk9+IZuBZM1FejO2gGY1XscJuRoDq9Uj5AOIJoOtYyGrvjcre+4MvSh3tryVsYq
 917mlUfPBzE9AQ
X-Received: by 2002:a05:600d:4448:20b0:490:da12:f1fa with SMTP id
 5b1f17b1804b1-49240ea7f99mr46236105e9.31.1781874340737; 
 Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240efc160sm54997235e9.2.2026.06.19.06.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B58F5F946;
 Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 3/7] target/arm: do not clear halting reason in has_work
 helper
Date: Fri, 19 Jun 2026 14:05:32 +0100
Message-ID: <20260619130537.820184-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The helper will be called multiple times as we exit a loop and until
we actually restart (via arm_cpu_exec_halt) we should leave the
condition the same.

Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reasons)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 3 +++
 target/arm/cpu.c                 | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 8be6a84bd54..9a45596169a 100644
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
index 86aae36ae55..597e0626e7f 100644
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
 
@@ -878,6 +876,8 @@ bool arm_cpu_exec_halt(CPUState *cs)
         if (cpu->wfxt_timer) {
             timer_del(cpu->wfxt_timer);
         }
+        /* clear the halt reason */
+        cpu->env.halt_reason = NOT_HALTED;
     }
     return leave_halt;
 }
-- 
2.47.3


