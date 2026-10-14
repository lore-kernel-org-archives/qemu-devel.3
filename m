Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97E5CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpr8-0006e7-La; Tue, 13 Oct 2026 23:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqy-0006Gs-Tz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqw-0001eN-OE
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:32 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc502d509c0so206355a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949229; x=1792554029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yy6Zl78c3NO2zuE+UCOh3WBHxwZVYNNzsACHtZLfSrc=;
 b=NIqeiuzdmFBCnadR7Z9sN1jwbuqejnCDzCVJ/Wj+ZyEQ4fXHlFQysLncdPrSQFhJUI
 psInUJUX3eX815x+jSbjTuT2gxAjaBTZe0SO63uha5SkJ0lZEmKf22odEi8uNuioh3y4
 EagbrX4aeW7Md21cfxVBZP5fO4pqarkKsA6DBEx/Le4AFwcgfZKqslFaOWwa2ghNSLW6
 2uYdIzZ9yI8GghpWSKzGBwcsc6a1fRfYkkH7+F+qv0OQr4dIkZHmMvNny5bRez9l370g
 DcRim48LJ7qEdfb5cPohu0ROwHU6JA+uyegpma12NxqTx1c6QJMUyB6gyhcRR46PHMLh
 opIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949229; x=1792554029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yy6Zl78c3NO2zuE+UCOh3WBHxwZVYNNzsACHtZLfSrc=;
 b=KfLxPRsuljIRcvcK32WHQq2eM+2QGifmiq+I7fqQmXGjQG46NqreheJrvhkhXPGjPD
 2bppK5c7VzF2sWsc5QBWCNmJWxASzgiF6w+dqFntQUHoXYxWlrQAiv9Ul8kXekCc6poA
 pRFPBVXJLvOV5IQUIb5aN1aRIbYL6snekEovFpLK3iWf+AYJARUBa0nRJEZNf5mvMtFx
 r8zpokfMKIhiOpwk8W7XDEgmDBYq8Yj9V/QQICSed6z59Rah4NwrL7KTi/YghNCzhwU/
 ji3UCenSUzVHTkuADea3qII/1JpCUAbOPJKvNzprwIkJtlbYibBxER4HOZtzYLS/E68+
 Zksg==
X-Gm-Message-State: AFq9FYI2OtKPhAcW7ryDBbD61Zha2Njzw4535TD1SKXKmru5G56sn5j+
 a78QrfZ9Q680z5eR7moW+to45yI7y1CAk30I7Cdazzk77Xxm+WyaIC87rrn/SQ==
X-Gm-Gg: AYBFou1qPJ/q97pB4PRDJHyWZbis4AY8Oz15g4dw46Cg4lLf2zaQ11Ck3Q6x4o2asYD
 w/6g1lNSDSk27oEIK0y6gGYvFYoR1Yxuc+CJyWD9Z2TWZ56aMpEZnOflxH7lMjy5+tYKXfLByZd
 cVHCzDQUr738/gL+KjDiNfLx5WEf8CITGm4a2xc0TtdZZJXHzdUGQAOVH0sZsRW5wvXOUB299Xl
 NwJKyDQIiLs49H60YyRucTdx7ITqu9EzfLTS0SKgJgOQyv2OVIRnFjpltsp+fU1+I7cD9iRgUhp
 zEq/jxOUQ5CU8g2DKV9ZQsCPSzFy04DPlY49vBHhCGr8R2ut+zxtGq/t15HCfO7f39ujtM7U+mu
 /miI6Kkug5pmKrDiDmaeRCfkLjDqD9drjqFeda/AnufTECkDNYzyeoHkgtzclIUOz1f1yr+X0rD
 SUWEoUKjgfkqpZo74+mcNs9hRTWka3m/kqAg0XFtxF92pccoakycxNj4xoVMOXaXGRMvsYLyIxi
 h83csQaWLqNanJJdg==
X-Received: by 2002:a17:90b:4a45:b0:3a8:bb9e:f8d2 with SMTP id
 98e67ed59e1d1-3ab3a9aa915mr11911515a91.64.1791949229282; 
 Tue, 13 Oct 2026 20:40:29 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:28 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/52] target/riscv: Document kvm_riscv_set_irq()
Date: Wed, 14 Oct 2026 13:38:37 +1000
Message-ID: <20261014033907.3332383-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
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

Describe the supported interrupt and the effect of @level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-3-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm_riscv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 0e27ce8bf3..aef681f0a2 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -22,6 +22,12 @@
 #include "target/riscv/cpu-qom.h"
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
+/**
+ * kvm_riscv_set_irq:
+ * @cpu: RISC-V CPU
+ * @irq: Interrupt to set or clear (only %IRQ_S_EXT is supported).
+ * @level: %0 to clear the interrupt, non-zero to set it.
+ */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
-- 
2.55.0


