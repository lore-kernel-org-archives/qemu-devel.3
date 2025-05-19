Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39327C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3h-000104-6f; Mon, 19 May 2025 00:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrot-0008Iy-Lx
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGror-0004NF-CB
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso5047105b3a.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627778; x=1748232578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TV5kwGq87oDOWhwHlyeIfJNLvub05pNZhCjxw0wPvYc=;
 b=iefVEnehK6vpOoB8QfGR7/ok3aMQDJsDIAZXG+sxbpjhoaumifXAZojbHllqJgn99D
 UXZ8sn98aD+/DMkSTHMhvktCPrNKSRc+eL3RAzKX6QNfsjIhCyFslXwAH6ntBbNDuedu
 aWtXtbBIcKGjJYjGv7vsc6lSXi4yenuQSOcYYZhBzw6JWawhug7ASnONK21EBDw9tDBs
 fSBLMYCEcd2eyJQMw/4dS/qUE5XdcxhoBQaHF6s/c4oY7K7W2+lxc89sVwyjEwdbv6Fr
 BwBEYgI+SKPnLaUEOtA8MPr+RgqpvepKu11j7zJTGcBtT3Dot/djxhXQviPpxxzj3n9S
 95hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627778; x=1748232578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TV5kwGq87oDOWhwHlyeIfJNLvub05pNZhCjxw0wPvYc=;
 b=rmIUSuILkgkeqhUeCrKRMBDg96cw0HzRKBoBjRq4hey9wYIPZZ8QerTdvha9MytGei
 e5YkMU+82+g5VxuyZamnDzrHCqF/0FssNfo15yQ7v5KHaIQ8U2MvtCdHQ5b7MOOA19m+
 Cyk2lH6nxQsytaoQHcEdTTUv5g3ZrWHm0qj9pcPh1l8w/uWh/QQPcywJ4hdE1OZOBW6H
 53DEQYHwXbpr9lXnyxzb2KrKrkdypcWO9Udu8VSEeyIdsK5My5RyxmyCR+QASCyhmC4R
 GfJ/lsGPUu4iCCM8SIyflZsc9CdBKVLBRC6qyeiNDNkab0DAtAmjk+IUFb18GdJNKhQj
 /nNA==
X-Gm-Message-State: AOJu0Yyq+6bXlQ31TmRJuymxAr4Gc2Sll6PVJr9OkUT5SbyqBEqh4OJp
 WBcqIcvYzXZl9994bGcD9L7+fml+WXvthxkGVcmmN0jMnB2MNj1YT7kPrngM9w==
X-Gm-Gg: ASbGncuWOPxLd31RezylCzdja9QiKKAEm2JLN8L0N5mJtJzlcdWCYh3XytJrtHGmBbz
 d628gFWyUaotG7uTaCGiRxtOiG3tGinbkve6ZMSivXY9FQsOIfYDBFK8K4yKWJOVySDDFUZUB2P
 wuOWAAfpS527qgZQfgkKrnvnYi0j26YeO8TFM45IPNUhNCRBuL7ss/OCKlSEDSt4SFdmwqOzZY0
 0g5+umhSIM5NVWHDkIPoUHlRoYBYhckfSl9OO62b/0lOftV7sMXmJAT8V0rhduS9K2jSZQ7FZre
 4MAPm6e54BI9+WpGyytgCPWIKJoMjnp43Zib2H2NV8NDjyQTKjDDRh9AH+MEfjlZZmFacgC0TyJ
 DVxlgBEQ4tNIjpl8+MUFWNjzOX29z865xqqUp4eFk76zcIHak2wp6C1eL
X-Google-Smtp-Source: AGHT+IFDMEtBv0iPQHRZXwda4E0QWiP1lBHczanPmX0SZ41ynFLSkUH9ZmuNNdZ8aibuDhxR4jnVBg==
X-Received: by 2002:a05:6a21:3984:b0:215:cf53:c35 with SMTP id
 adf61e73a8af0-2170cde51f9mr18007105637.31.1747627778457; 
 Sun, 18 May 2025 21:09:38 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/56] target/riscv/kvm: add scounteren CSR
Date: Mon, 19 May 2025 14:05:44 +1000
Message-ID: <20250519040555.3797167-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add support for the scounteren KVM CSR. Note that env->scounteren is a
32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
to 32 bits read/writes.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index ca171d5457..82f9728636 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -251,6 +251,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("scounteren", scounteren, RISCV_CSR_REG(scounteren)),
     KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
 };
 
@@ -701,6 +702,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
     env->senvcfg = 0;
 }
 
-- 
2.49.0


