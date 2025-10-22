Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B3CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWkT-00088N-BD; Wed, 22 Oct 2025 07:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBWkQ-00086K-El
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:11:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vBWkN-0007dS-8E
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:11:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6329b6e3b0so686577a12.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761131473; x=1761736273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mbyA/LiI1lhWjIzquLDGeFGiPJ0qcFYc5ZQP/Jy2ZhU=;
 b=Um39HYyMBtRsflQw3WHbMpP+qCptOJY32FjH9PFXZiRUZ3+05fCEPPoZ5wp+KtWJQB
 bOOFj/gVbBho8DHaii2ERd50xAIsV0S7JhFpeWOGmlL7muKgIqkv6OTPPx7JHN0nPs5m
 r7TOkt7gNuSW/hd5cjke36u+mcEJgcyjl7ovV3TsH5tqq7B2FGd2FnhtWVIIREIhLb29
 tJTdBRjNsAO51fXTw7SNVc5vvtXHpWDGJwX8q4JNGsyD6n6qAZb9AorPP02X4+TCXoRY
 0a6+FPvgjnkRORrMwT4wHUSus0ZxJiQmsU8f/n7xEFjcekv55E+ZL4WzX5DzzkSPWR5r
 S4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131473; x=1761736273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mbyA/LiI1lhWjIzquLDGeFGiPJ0qcFYc5ZQP/Jy2ZhU=;
 b=uixoTULvUzTfCqo6iSkj5tOIZuZQm83IV1jjU1xtRoB1y7tdIuJ3pgx/jVtTNY/Ol3
 99KYc5Vyo/gAnOtcPjGDqc7fhhD2A2RE86MfLz7iOVL+9UCWm7yNbynOAILYuOzJ199F
 SAJcJmQtHf6S/+oQeyMF1ck7f36O4UZTz2I50D+dTU05dVxwoHodQXGvA14FbLod4k7r
 uWLkLSwKjhqxNA0hi/f8OmDiyJepjhdAE88KZ0fj4IOlmww5h3mbMdQGoCl0zndkuUiE
 djKTdf+bYOI6WspPmtBSjdv2eDKxxTY9DB414BLrxuWmdj/KnRpUU+/ug6sU8XwN7EdN
 8krQ==
X-Gm-Message-State: AOJu0YxBIK718PfCLf3Yb7hYEYo1Nzwv13YsaUoAwousHCGbp3K6bElO
 iHewBBAz4IjwNErPvbEguZ6KEP9Od43UGqYUZb2kGOCTCc6EF/uMOhU7gPFjCoFt0pr0wjgnT61
 hyjL00pY=
X-Gm-Gg: ASbGnctaW3ZG030osRNElq9Vk3V5BKxHY9VmjUp8oxRkdopkjc43Y0P74t+Ii3JQXA1
 0EQRbLK0yEasiHM9WL0fF823R+A/HootnBsKr+Dq1upVuR5n/zXRlTLxfpj6xla8e8S46P0raz0
 xzovXiX24nyd2XmRuQC1euQXmfn+wTomEVplc6pa5kDMNdwFID2mnjrEti60iSMDeQgzuvq88Nv
 KwRzL5zgxO/naR5qnmLXPTxvCATaua92j4iDaS6zXxDNESUf/upRqg6f7mWkAmI0Hbultk302vJ
 +SGZVxpce9jbU25rCDaXAJOyFcr77bBSKc7x5IQJCnmwaBWIJrJHdYQmYP4UVsz0oasEZi/5No+
 5z/dtM78YKqX6bM8iSyR8jHSUxW/qRb7lDKK6t/L1vI24V8otw0hnDlsPK41H6Qs2i0bck0dcoF
 2YlmubZX4xwHsgoyJf4RU552OaEe+A
X-Google-Smtp-Source: AGHT+IGpnQ1WUR2JlEHnERhpXDlvfDqcMy6x6gUIqfA7lpXUxIQC/jCHDqNObfEk1+rw0RO0UhC4Xw==
X-Received: by 2002:a17:903:186:b0:274:506d:7fcc with SMTP id
 d9443c01a7336-2935dff65a7mr15558835ad.6.1761131473104; 
 Wed, 22 Oct 2025 04:11:13 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc1:92d3:4170:1cad:ed8e:78ba])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcf88sm137457155ad.2.2025.10.22.04.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:11:12 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-stable@nongnu.org
Subject: [PATCH] target/riscv/kvm: fix env->priv setting in reset_regs_csr()
Date: Wed, 22 Oct 2025 08:11:05 -0300
Message-ID: <20251022111105.483992-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x529.google.com
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

This patch was originally made by Gitlab user Bo Gan (@ganboing) 4
months ago in the context of issue [1]. I asked the author to send a
patch to the mailing list ~3 months ago and got no reply. I'm sending
the patch myself because we already missed 10.1 without this fix.

I'll also just post verbatim Bo Gan comment in the commit msg:

"In RISCV Linux with KVM enabled, gdbstub is broken. The
get_physical_address isn't able to page-walk correctly and resolve the
physical page. This is due to that the vcpu is being treated as starting
in M mode even if KVM enabled. However, with KVM, the vcpu is actually
started in S mode. The mmu_idx will give 3 (M), instead of 1 (S),
resulting in Guest PA == VA (wrong)!"

Set env->priv to PRV_S in kvm_riscv_reset_regs_csr() since the VCPU is
always started in S-mode for KVM.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2991

Cc: qemu-stable@nongnu.org
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2991
Originally-by: Bo Gan (@ganboing in Gitlab)
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0dd0d59d41..000e44b2b7 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -705,6 +705,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->satp = 0;
     env->scounteren = 0;
     env->senvcfg = 0;
+    env->priv = PRV_S;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.51.0


