Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBF6CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpr7-0006X4-3r; Tue, 13 Oct 2026 23:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpr1-0006Pz-Gn
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqz-0001ed-Vh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:35 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so1798921a91.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949232; x=1792554032; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/sIldZ0dU711EsMF8z6ztMUtXll6EZ6iwh6/7xBf8+M=;
 b=aiR+Ezq0wz0UOy7xGmQgzE9La27GCx2noysAKhagFXPHkn1Z00uVRhlHyo0LqDH3Vw
 RWe5Aa9IWz154zuLr9ZewdMD2UMVMvXj8RKxph4qWUDLLfGcwlwgnFWOFyZF7fGfqWpI
 TaNwlw1i94vmlNjq93XXPpJkdCu90YBbIhALe9iNZt+H4FGhBqf82pTR0nWT+RlwOcLd
 FMydytlrq7qXZ+HYOrq8jab9HpGok/S5/mhfG4arvGtI4nSXKTxW4Wu++rO9Mx0WcXyw
 vDy5PXRNXkRMg/OZgn09MftcwMpVxp1DjEfC47oBTvoUCh3v1+/ZXwK+VbdsAYOfcdAo
 aQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949232; x=1792554032;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/sIldZ0dU711EsMF8z6ztMUtXll6EZ6iwh6/7xBf8+M=;
 b=Eez7hxmqYgHwtcWvtUU1uJwrkNE+ZYEKTXTH0WEZ32yVqPgFhaonYIFjR+3B9A7Uar
 nL2EyG8pyAuH3BYWrtG3igDXrWbUCokLF99DSRzcfAOxX5L246VNmUUIlWJ6d26uFKpj
 zTYGt16YO7na71pMVHurM4/UMAhcGigHJh9b505jT2WZrGoNGJQYgwsZu0obdBZNLmd4
 ue7sywTyvLSeFRciKyjDnV8bc7jtbILboqgUBLNAYoPn+5hc6kUYYA49DCFX2LboTuTi
 J5HVXWXScnYiG3OUhVhpuYv9LWrRD4/YD+HVX+XcRKi0IuWjOx2VeOpmF9Gp+RmjMpyU
 zYYA==
X-Gm-Message-State: AFq9FYJWPHe7JeryQJF8aEFq9X7EQX0LAHYKqOaYYmziti5I6YSCi3Pk
 p2DC5oONZYVN7sT/xWn9gyt+kqWFL+RiPumIYoCHg0EY640p05tbI+UJPM+0tw==
X-Gm-Gg: AYBFou1i6X6uNkRiPi5BVZRrRSehHuksyvxpbSBLulkG9zHEIVc04VAm+L8CqPLVFDB
 pKjqrjw4oX0PtBckgNoVabNQ8T4gLjYPcSteZY+6DygyO/xMCQUVj1TsxrWnfW6daLlaSgIE7x0
 JaXnZ5tKDO/g51pKa/m/e6BYar6EUTux4eqDzl7JKe8dQARTvwzSgqE4lwa4aGKDSYZPxIT0Vg4
 Tbl1Fz1CkUSXCtawj6XCaXVOhsKppRJ97hzGy1rrSV5PfwQmpTGA9/OhNY86nZRKXahKiXXATTx
 TGIG6vGbfhEAvQqpvyrf2cd48rbHA42mv1bOQVIZA2Jn18qaNYbz53dHuwiwgqQLXYsnwHBWnne
 Gn8jgayYQx8zu4SKhIWCvAsejL1EMI5jweA1S3Fl1pattdowB9q7kb2EMnJGU5Hwr2u2uGfAUNn
 1DfuaI4V1k3LyeMsi3mZM5+VTVYvkfv7hmGWWSWtqMzZdZtw8v2uItj87UvU29YJpIvSm+r2MZd
 1fiZQpD0IH5W6YdJa89MAUG56k=
X-Received: by 2002:a17:90b:2ccb:b0:3ab:17b6:9a93 with SMTP id
 98e67ed59e1d1-3ab3afcdc6emr12600720a91.52.1791949231919; 
 Tue, 13 Oct 2026 20:40:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/52] target/riscv: Clarify riscv_accel_set_irq() arguments
Date: Wed, 14 Oct 2026 13:38:38 +1000
Message-ID: <20261014033907.3332383-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

Use per-accelerator locals to make the differing conventions
explicit: TCG takes a MIP bitmask and value, KVM takes an IRQ
number and a level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-4-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/time_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
index ede1a4c2a3..29bbebb96f 100644
--- a/target/riscv/time_helper.c
+++ b/target/riscv/time_helper.c
@@ -25,18 +25,24 @@
 #include "system/kvm.h"
 #include "system/tcg.h"
 
-static void riscv_accel_set_irq(RISCVCPU *cpu, int irq, int level)
+static void riscv_accel_set_irq(RISCVCPU *cpu,
+                                int irq_or_mask, int level_or_value)
 {
     if (kvm_enabled()) {
+        int irq = irq_or_mask;
+        int level = level_or_value;
+
         kvm_riscv_set_irq(cpu, irq, level);
     }
 
     if (tcg_enabled()) {
-        riscv_cpu_update_mip(&cpu->env, irq, level);
+        uint64_t mask = irq_or_mask;
+        uint64_t value = level_or_value;
+
+        riscv_cpu_update_mip(&cpu->env, mask, value);
     }
 }
 
-
 static void riscv_vstimer_cb(void *opaque)
 {
     RISCVCPU *cpu = opaque;
-- 
2.55.0


