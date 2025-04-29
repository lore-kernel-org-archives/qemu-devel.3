Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F89C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKP-0002Ue-Ku; Tue, 29 Apr 2025 08:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKO-0002TH-Ts
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:48 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKL-0004N7-Iy
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so5471197a91.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930683; x=1746535483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=ZDok/Q5Cj78hcj7v68oV8h7G6ySTe+IUjExHRQR22BtwGFQE6iHl1tuQDUijJflFGv
 8cPj9stRuir4JcDzGPSTvsjFi5sVCcJtIdaYPLC7EBm6mz6abDgy7RFhGgzWPJcPuQw/
 ELZoG8vChgVYCGKn/moHkDh4r/QigA06KtAlNa3lkXB6vRlRFkHaSdqmqXtIhb9ZhUHa
 5HOuYl6i+w34DDeOzH7wl5pIGb50Oz/dnHKmPimHMx8vEQHDu+21Miq+hFMx1KUOZHvE
 Pa1Q20wHErs3EOjQr0rRLiSTiGP1VeHigGIzjOskijtmbk/hsPRsPNHHG8Q0hZCLWfnp
 k1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930683; x=1746535483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=NDI/w06IPsxlI35nI35uXWUyia/v+ysN4J0MtV0rgW295UY7fdOARQUnru/kechdkK
 wseJ0Uf4Byp0fnVmJzmob/Xv6nRj1R9UbPmCxnXP7ESc5U/spxwfv16FJXK5hHFXbpOE
 bgS/C8xbYJhiy3ds+NSKQGQhG5RooTJOEvwOlZPbW1n2uZtc3uEACcfB0aUJ0GxVF3QQ
 V6DhjHyEJ0+0in8TlBinMwHpNC4HQGeks3lpxH2dFmMA6jormEzNKuH4Ls5MnwL6o0BA
 cyKTr4oqyDZTiaj+SvyTtiQEdtuMyiygf/1XWyivVBGRxhbPMa6g3z0oZOr/RNfk7IQi
 VaRQ==
X-Gm-Message-State: AOJu0Yy1M+wyLKeVFTiUvzP5Cq+NunWk/Hq8IIqNaTpNClRFok1vuKoE
 bSyaMKKgOMQRa/Ukx9m0Z0LihAKTRrG6f6J8jI5LKaOS8pMKqriPe0HqL1GCB4AvxcBNXWpiZkS
 J
X-Gm-Gg: ASbGncvnIjx0o9LKDtD9HWnooPsFA7u4b7AwZb0g+umZ8wTVLHEW0j1cbYoxxKyhfE8
 h0DY+h10sRNLt/SaOPUPQS+Ew1HCn7kNHp16MKebtEy01wjDwBhjswSOLHUvvDi5CLzvlniipLi
 jHmtutCrFiNc1I3KEJi+qi7p7AuzczpylfS9BMw+5TZawjRJtCtboF1J3qnnXeyv+wOZGfgPaPj
 Uzu8yWRxxfW0TOyn7v7l7M9lNp693z2LWuw1VReFwA3LLk4N4cxlU4srjXjxaeYpDGlglmgACSR
 +1a4Vbl9+cm01NQhcQ/VOkagVnsbewj9UDPA6hmwCOU=
X-Google-Smtp-Source: AGHT+IGRP37o9WXqP6qNkb4kWf2nc8/v/hyMZYH+atvtdw7PrOYEpLRly9pK/EhuHjgpSxrIIMrf9A==
X-Received: by 2002:a17:90b:394d:b0:2ff:5357:1c7f with SMTP id
 98e67ed59e1d1-30a215ac108mr4945816a91.30.1745930683201; 
 Tue, 29 Apr 2025 05:44:43 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:42 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 7/9] target/riscv/kvm: add senvcfg CSR
Date: Tue, 29 Apr 2025 09:44:19 -0300
Message-ID: <20250429124421.223883-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1031.google.com
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

We're missing the senvcfg CSRs which is already present in the
KVM UAPI.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1ce747d047..5efee8adb2 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -249,6 +249,7 @@ static KVMCPUConfig kvm_csr_cfgs[] = {
     KVM_CSR_CFG("stval",      stval,      RISCV_CSR_REG(stval)),
     KVM_CSR_CFG("sip",        mip,        RISCV_CSR_REG(sip)),
     KVM_CSR_CFG("satp",       satp,       RISCV_CSR_REG(satp)),
+    KVM_CSR_CFG("senvcfg",    senvcfg,    RISCV_CSR_REG(senvcfg)),
 };
 
 static void *kvmconfig_get_env_addr(RISCVCPU *cpu, KVMCPUConfig *csr_cfg)
@@ -698,6 +699,7 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_fp(CPUState *cs)
-- 
2.49.0


