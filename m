Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E89CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprD-0006yX-IP; Tue, 13 Oct 2026 23:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprA-0006oz-55
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:44 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr8-0001fN-Fq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:43 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-cd60c5da24cso1520020a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949241; x=1792554041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fwbjr1m8WtrQ/Aa7wVElqbsirpE225vewLAnJ1kGdRo=;
 b=MZF0Q/LjMyAyVkdaALS7ZyL19RP2zBpc35kFOipZave/uzKyM1KhLRJ4LcxVjJdNqm
 g7PxYfZLwb87A0LrLuHAWFqQNXM7UMSpSecxTShUwhIvk1jGjUOLAqDRAS5gZAZCsjM1
 5xqqtfZnbUAXMEcqzq8Y6KqBGJN1feF3VOxmlinLdTug3M68Qcmg9m2bY+Ht+jBSP63f
 yFHUMludmvr+l+vEWANqfxosQBauRdOH2hObAgEDU8fZFwSc3gUfQYgIQ8U6NkTGh/jW
 6xtU3+5nAGPwMDYaEEjSIaLwKrw8kyxU5ElztxVNqNNmwrs5QAiyK5U20e+reRQeCswQ
 HJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949241; x=1792554041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fwbjr1m8WtrQ/Aa7wVElqbsirpE225vewLAnJ1kGdRo=;
 b=1YyQkpTyZ0NSAU9PCByzKyGHhTiGRE9bXauTjLyfEvRs3jKGz68Ie8AKd7igonZSHn
 GoyWKiyL+bw3FQPgJrS2/GvPZhIYQtTydr6g/zFeVNROOEf2cNb7hFJc5/PHnAKahoaa
 +t2ZYFfa5yIz3XLMUjxcbYaJKRHgXePNFNt+CQOFPT2cj42Q48+bsoTMqy1oJ7ANvVrF
 HqEGL+4ZlFrzjr0R8Acy/fNhhsWoh47csVCMEU+faNOJKpIsPb9EdgSOuYKYbbqAUYbd
 IS1UJyckMpfERqjSkjONnalgEtZ6cTzdTVsOiMnRF3+jgOQPAOyoFKwLWukXRrTap9E0
 HskQ==
X-Gm-Message-State: AFq9FYK+yDbYlBfODH6OXh4gmYA9uuo/Ss+X13MGppTuYs1aCybI68Oi
 RzigpxQjDF73iPu7m41kmu3RhOQf05L4ZL7dvxOvld/VEor8pz5AFo4wPXw6xw==
X-Gm-Gg: AYBFou14LT/Wrvx21Q+9DG9wgVi3CNCtDblpQYnDSvEZmAUGYDemmczRcBbGxfDODFP
 fE4k2DhZeFdyoFTAEQ0lOJeDHDtfexRdswYe6KWNqGpuC0V/3A9ABNPEKtnUro7zaLr4Q2hhO42
 F9UtyGZxUYXtL3mpA7wU7E+Wl94aWTyfWTHUjBDLKccBgqOYmMvkQJIdpaIbWkUTaNN4tfxiFza
 GTtWPSJpJMFb9twvXfwGBAJRlprInClTrQXTMKOPpghshq5vXk9aqtwT6BjjBpBdmw7JnCEZnHp
 xuLIuDL5yWv+KNQn9LhoZH5mq9kXs/qD7Le/oSM6PDMPjUotGmrnUxaYZfDrfljolFNe+epXb5R
 pAc0/FqHeilCHqc1kyVBzl8IeyjI9Jc56xdv9BB2RJ61OkZYxr7VM8Mxqci0sF8iTZA2f2lsHNE
 EAQvqEl1KYp/30PjSX1pqGkQtkaSkuryGCY5KoWBrXffo6CnSWxzQ/+R16+nRdzVK36fC2zlYIS
 SuIJq59BGdUuUI+
X-Received: by 2002:a17:90b:3c04:b0:3ab:39e5:6268 with SMTP id
 98e67ed59e1d1-3ab3a92f39fmr12598151a91.53.1791949241178; 
 Tue, 13 Oct 2026 20:40:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/52] target/riscv: Access MIP atomically
Date: Wed, 14 Oct 2026 13:38:41 +1000
Message-ID: <20261014033907.3332383-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Make riscv_cpu_get_mip() read env->mip with qatomic_read() and
riscv_cpu_update_mip() store it with qatomic_set(). This makes
MIP reads and writes safe for riscv_cpu_has_work(), which may
run without the BQL.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-7-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c            | 3 ++-
 target/riscv/tcg/cpu_helper.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3e1fde207e..2bf9c15d9a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -22,6 +22,7 @@
 #include "qemu/ctype.h"
 #include "qemu/log.h"
 #include "qemu/guest-random.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
 #include "target/riscv/tcg/csr.h"
@@ -957,7 +958,7 @@ int riscv_cpu_vsirq_pending(CPURISCVState *env)
 
 uint64_t riscv_cpu_get_mip(const CPURISCVState *env)
 {
-    return env->mip;
+    return qatomic_read(&env->mip);
 }
 
 bool riscv_cpu_has_work(CPUState *cs)
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 7ffee54777..2ea0095178 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/atomic.h"
 #include "cpu.h"
 #include "internals.h"
 #include "pmu.h"
@@ -584,7 +585,7 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     BQL_LOCK_GUARD();
 
     old = riscv_cpu_get_mip(env);
-    env->mip = (old & ~mask) | (value & mask);
+    qatomic_set(&env->mip, (old & ~mask) | (value & mask));
 
     riscv_cpu_interrupt(env);
 
-- 
2.55.0


