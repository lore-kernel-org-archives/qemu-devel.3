Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7145DC3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 19:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9U5A-0003iG-AV; Mon, 28 Apr 2025 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U57-0003h3-M1
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:57 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9U56-0007OK-3C
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 15:23:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2240b4de12bso78562505ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745868234; x=1746473034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=dtepnuWpV6gMvnvXqVOBvEN+kFGWaZQLpTcjtDCpBmvT62Gc20MLr1wpQhttaMiVs6
 pQfUUPrfkLvg7PFICtU0aSjpdQnDgkOx2OTO60flKYW/a4lwsaOaUzhtoiJpX7WMA9lr
 kNCi9wAYtARr+yBYDB1+ivmLnnXYwUIoXtQmxKfdqjCHrRw1u0ebenqu7lQukW3eioS8
 YXLuYrdSToSBR3mnbBpLwlrUVNQjXCjTTeS2PM5kxhNaVtJZBP0uD9NhTHffiJy4BV8R
 1EFHgqJOncA6OEIUouZ3dAkKjVGi3y7H2L+/QjXCp4MQvLJcmxrYLeeoTbiRTExT61hP
 drYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745868234; x=1746473034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqkSXWmlAzXCmkQApAbF+YpwERfG9A2hRBSgef/JTFs=;
 b=epYEmt0s8kvc9Ng5Q+jgtJ8BFuc2m0tT6GPuKIGeyN4hNWtRtQ6fiFnRC4D6FmDXF0
 j86SXfxOLNngRGpwCmVoo3nHTqM1Kur2VoO1JSFi4A168v5gstPnJ7gesYY5RixNGRLn
 VlL2WMszl15I/ehp51QmJto4CMjI0kWM8bQsKj1DdK5SGsciqPBBsynV0QRJ346nUq4r
 WkjH1OsZlkXDmqg4Y5ka0y8U5EY7AuQtiqPFqt6AJ11y5c/B56sc8xavIQoSqN/g+ysA
 Y0Z/7S1qt5UiE/oDKuHSQekUxuCcr/SjF/yoz6UnvunByIAMH/EUGjBHND41yaXFNTwU
 2jpw==
X-Gm-Message-State: AOJu0YwlzAF7FX3bV4ImDh0QEkauCm02XF2Gf1/v+/xxDAc+kDA1dJ/C
 wTxskFiq6g5CxfeIin+cs6cNthVZanPaHfwe1C+KK5xYrpIWi6Oz85uLOl5hahXpIlH8KhNFcBM
 cBuc=
X-Gm-Gg: ASbGncsGqBhVXQjAdWNoU1aCzqT0I6/Hh96HMFHuwUmIBX7if+BhWUhQMU2XjbkUeh7
 EtE4hNON6mPtHQvil63hidpFt2WqGP6j3s8/+mZDlZMVHiOKeQQivPOyJWrwlz5P8zfqUkvBHV+
 XkYPhzE0GFNToRJolfN5HRVF7h7LM/6ROBsCuZalW7SPVQItVahIR+lQ2qdHldrC42UYIpdDGjw
 JFFrjVjB1IqeXAxd3cGgtmI3aiSaLBYiQ4TgxrbJBq+7LB1LBX7O6eMpvd6bl2iUNuMB8BBMKeY
 /7busPEySC+/S5aPOsZ23cEAryLflHOak3CcyJnt3aIT
X-Google-Smtp-Source: AGHT+IFSnTEGWjV9S2VC9mg//Sux2kfRF9Ce+hrDfGO7zzsfU18TI7NJTQpa9HQ4G4osonWqWRVzLw==
X-Received: by 2002:a17:903:1209:b0:21f:7e12:5642 with SMTP id
 d9443c01a7336-22dc6a04770mr129720115ad.18.1745868234419; 
 Mon, 28 Apr 2025 12:23:54 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:906e:57d5:dca2:1ab3:20de])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4db99d3sm87300565ad.53.2025.04.28.12.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:23:54 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 7/9] target/riscv/kvm: add senvcfg CSR
Date: Mon, 28 Apr 2025 16:23:21 -0300
Message-ID: <20250428192323.84992-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428192323.84992-1-dbarboza@ventanamicro.com>
References: <20250428192323.84992-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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


