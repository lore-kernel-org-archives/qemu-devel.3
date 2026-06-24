Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC61DCDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtB-0002jF-Oo; Wed, 24 Jun 2026 06:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsi-0002Xs-Rd
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsf-0007gd-Fc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso995234f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297052; x=1782901852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps+nLp3Q4CfPMJGduuipgUZanX4xJ5a30/iMTqcTrBM=;
 b=QCL3NZQH2tmHZ9aNB+OApswDgsZ2C7amI8SWMObbHG5C9F/rZZjgHDxGFrZH5lqZp2
 NipG4bYPSTQVYYhgJQx4og3NIF1lx4UlAEEeL7TXLtfoTuton5uIAmhWDQHL/C+yGvSy
 KXeRxXiD7vtLxVaxfTtiTVnHmFR1QqQf4jO7rXOZDeW+vQoPLrTCRh64arvjRGq1qf8d
 w9jxWQTyJ7aG7qwO3ZR3fO3J2BO7E6kZap2Q+MXFtT/cOG9bbOSx58x6IqBwkGcCB/Ne
 hRrlSXYYOOjIDG1lukQ6fyKp5j+QBuTZI1QpE1S3STgHF39IUpq5W77emEdkTfF2is8C
 pMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297052; x=1782901852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ps+nLp3Q4CfPMJGduuipgUZanX4xJ5a30/iMTqcTrBM=;
 b=CzPXD1mmh+YYeqkt6Jk6bP2r+FdBM/99qjbV41u+Fj7a7lIVWCNtnhsUXOzWKmyGXg
 deHg5Jq8EH/sia0/letRUWqYKtrKbskl36oFmA/knBd0NS1G/uHFeoJp09rxscDzU+xN
 vxAMhxFhi3c4L3+v6xzZWZpl7f+e+xxy/8XuEPhOQk5uKpx6a6WOi2ZUpQJAptbjcY7m
 tvRyskDo61GijzCMG7H13o3SyRsvrDudhTCGRgSU26BXJRUOfBoUvkCP6VsZWsmxqPx2
 lrpw8TR0ebnw5fSBDsDJTprWDiZ7eHXUDsYagby9d4F1vXOdlzuvVk2/yfFJt9z9deY7
 pntw==
X-Gm-Message-State: AOJu0Yxcwn597ip5e596l/F8Tw6ZDfqaRNs9hABax5V2qkyhu53ikaO8
 VZA6elg7APWYzWWEt5V8XtoXHj5SJOT1C+rf4fGMmeXZzVou5vyQcMlVDWr3fcFuBHw=
X-Gm-Gg: AfdE7cm0wlHEVeoQp5bZv4g5/NTfIeDVPR+5+b4V7xD4W7e1JdlJne/jGnhnFeEKDeL
 jNYASnR9F1SDg53R/OPKibGeUZoaxeSs61EtETXAiQYlNaxJOPz5c1SFX4KTdHEMd8GXx0RCORB
 Y9Ny28pT51eIEiR6Te8162Z7kPlNRCwTH5JNj5r12gSe1gH70rMToNaVdQh/oMXn9YNNPWdMVQQ
 Gn/e5hwczX1Cqo67ImhRb8bgefOvmuKGexsuFya6uzvX15Pi+3E/RR6nSMVtRLT1Av2sBOYylBi
 0Zj3qMiFesXmACvqGQylTWdqAB5/8UJZv1xe47n5ga/vsq4KMcL6Ib4J4lDI9wxyH0FzSGoJU4G
 TIHoQ3YgJrR4hT6LRKbnv1kZWmsxbVd+PF4yXOu4Fbne6VGc7KeOxjN9xbEMeJUEjXC+C8hPms2
 IMQI43WvJgjV/SAtogiUNXFDQ=
X-Received: by 2002:a5d:490e:0:b0:461:a169:f965 with SMTP id
 ffacd0b85a97d-46c0b8b182bmr2896485f8f.34.1782297051850; 
 Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d9405sm6263592f8f.22.2026.06.24.03.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 021645F9CD;
 Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 3/7] target/arm: do not clear halting reason in has_work
 helper
Date: Wed, 24 Jun 2026 11:30:45 +0100
Message-ID: <20260624103049.884930-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


