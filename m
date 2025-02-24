Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2788FC021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 12:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmXco-0004yd-PX; Mon, 24 Feb 2025 07:31:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXca-0004bO-P1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmXcZ-0007eV-7n
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 07:31:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220f4dd756eso85833925ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740400296; x=1741005096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7ZOq6CGiOpDDrwdS6L6rqcG8JIc9h6/YnxChOerYnU=;
 b=a8dD/8auXsdA18kjx+f/zTpGNNqLovvtNP1orNRwlSedY5BDg8Va663AsBzpLEoBjs
 mVn+oUzmu/1kmKVGoO5vmR16vxtI0C592Be2QJamzGEopIEOzCL6Jufpf/Wyj2rvoeia
 /mr6NzXYhWKuMGn2oXmlkU1oJR5U/ULn58xi0rsQX/d4H/vMrlbuOvqkncpEhhj8y9Vs
 iLjFtgPLWF4sx34ZS5YpI/6Xz7WgR3KhKfkUIXRsLU6qWNrD4f4PRQFJg0/Dr7rE4wWk
 LjB77kv+IoH0omiKsqQ6lFDZMZcDiDoXwP7qrPAlmZ356pHTKGaNupVTVId2Y5RZXO0U
 PMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740400296; x=1741005096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7ZOq6CGiOpDDrwdS6L6rqcG8JIc9h6/YnxChOerYnU=;
 b=GuswDQqElU68iR3FkgD1OBdehbAFZRPiKI0mn0KdwAruE1bZ3uVG1qdV6fOCxRbkPu
 iW2INVh925bUM5SoccKEMP3H4KIeSjTXk3ei/P6rMR4a8RXFPkA7Cd4VFTziOawX/KjY
 uxxwyb+PodyS4t91TPauflMC2B4POtebrkjYJtTrkGBvH2mQzmJgf8DD01swZFBY4dsA
 /Zj56n4tJ8f0MQhZwbVwJ2W9MV2pHnPv5Y+qyxTTSZCRyJVMawQuf6oO2eRKJ0qHJCru
 CSDEFm03khyftMEdJ6OJ3xP2VioHDTOmtAgxbvPGMz8bdJ3DfgnfEoZqxbO5AXKv4B64
 C1hA==
X-Gm-Message-State: AOJu0Yzrx4OUJhGAEb4spJpk+brjh6MF0BtP6Dncps9Xu4KzNooQLVVd
 MlKkNeXzfcUMZS9RDPWNoiX1q/AwerSly4QbiX3nZoieiK+lfTGXhDldPZrTRYiMkqWeT13kEt/
 S
X-Gm-Gg: ASbGncvNKdg7UA7+EwTTMzdfUltaHQWgyp3nQssTGkvfiaTKjroOzeEWC+/cgjA/chk
 eAjTAuZHQbUkCZBB4GMknbNvPcOe0imZZNGWE4/6uNA4CauJrjzM33A4qaVvnYdYP0m6ceKDbHe
 0n2BOi3FaoLC4E1aTw8ds/ZS9cL2r6reI35Jo6dHFbD2x+39aWsuGGbgbu7lHmf2Y/O9UXLZvDv
 HMZXTA5bahIRmYPfqimaWT4o4q9YaJKu2Dpje9npudwZ9XU9BLj+cAQiUcpO/Q6TszL3PbTPJ5z
 QeKap3EpJ3kf7flnIRWTe58cUb1Mhg==
X-Google-Smtp-Source: AGHT+IGfZh/PBCq7Rk8S0SdaiWpX+hoJGxIVgJ87PMio/G08O/wf/0IbkCTn8D3kypCW9NA1hkFyng==
X-Received: by 2002:a05:6a00:b52:b0:730:91fc:f9ba with SMTP id
 d2e1a72fcca58-73426d77a2emr22208725b3a.19.1740400296562; 
 Mon, 24 Feb 2025 04:31:36 -0800 (PST)
Received: from grind.. ([177.170.227.219]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568af8sm20554470b3a.48.2025.02.24.04.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:31:36 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/3] target/riscv/kvm: add missing KVM CSRs
Date: Mon, 24 Feb 2025 09:31:20 -0300
Message-ID: <20250224123120.1644186-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

We're missing scounteren and senvcfg CSRs, both already present in the
KVM UAPI.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index cabc34b6a2..e8c31a32d4 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -619,6 +619,8 @@ static void kvm_riscv_reset_regs_csr(CPURISCVState *env)
     env->stval = 0;
     env->mip = 0;
     env->satp = 0;
+    env->scounteren = 0;
+    env->senvcfg = 0;
 }
 
 static int kvm_riscv_get_regs_csr(CPUState *cs)
@@ -634,6 +636,8 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
     KVM_RISCV_GET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_GET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_GET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_GET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_GET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
@@ -651,6 +655,8 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
     KVM_RISCV_SET_CSR(cs, env, stval, env->stval);
     KVM_RISCV_SET_CSR(cs, env, sip, env->mip);
     KVM_RISCV_SET_CSR(cs, env, satp, env->satp);
+    KVM_RISCV_SET_CSR(cs, env, scounteren, env->scounteren);
+    KVM_RISCV_SET_CSR(cs, env, senvcfg, env->senvcfg);
 
     return 0;
 }
-- 
2.48.1


