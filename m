Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E40C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTli-0000EF-Cs; Mon, 24 Feb 2025 03:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlZ-000062-Gi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:44 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1tmTlW-0001AF-3Y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:24:39 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c665ef4cso67900755ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1740385476; x=1740990276; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/bWOD2oND7Vlosu6daJhAwxVOQyujRyeWSVMNgf17/o=;
 b=jrZR5GrXF+l/NJzNeacCA10YcrCE83kUCxclmEW0haMDE2m+coIB0I3f7D2HC3Ujer
 THeAGMAI4EJ0mhptUPhGM5ZYNOGNf3o/XeS/M85xJuXsADUYpwAQ+yhx60mhigI+zMI9
 yF5Om8iqARVPueGatAo4qEUyrDDlbAEwNHEANXf4vuqOgLfLe5v+lUsCa5pTnt3HB64E
 fbVjy/C7ZQZZSi1JwY6PqX+tHMNYY5jpbgmbIV4sT8kQWZfybQRsDffdjIIopSFTZoqc
 9v2dLTpLbbNkUjrPYHRXjbj6l97ki3X4IKyaDajcv2VN/MzQrk2RA/oPI19RJq3HGbzb
 9dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385476; x=1740990276;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/bWOD2oND7Vlosu6daJhAwxVOQyujRyeWSVMNgf17/o=;
 b=oHZA4F1dnKxRdFS5HUaLoTIvsIbroQKarkPjZ4S8c1SBBnO1QiB8tQGVzDRGpRsswb
 jWi/OSB0AB7TJdCN0EipRzOk8MiMxYSjqb3yfNkSNBFCVyBsvrNkb6z7Dw/3NBauZ4NV
 FNb8lwpKJ6sSh/zo/4EkmCHRsuxIMLLM/u4hjUnLBKvfah8+XLuGoe6hAWoGIUVU9FUt
 qaLivn3hKoM3bFRuC11F/xHUx/S3lENs2fafZg4S0x4+N1m+Hjm+QmQ0ReYBFgYIN7m0
 7gt8l7qjtPQgqNTy8uFtLYTdxcpWigOuT8zuIjgMiYivGib4xE0dEGQO3TVEkwgPG9jD
 nM0w==
X-Gm-Message-State: AOJu0YxboKnFGsD4lla/2wkkzdKqMlYmSvpNpfUUh+nfATzgsM46QICo
 HAR/rC3+JJYrWs3vOdbuvmiyHdUEZlI7XjSrqxZThCeTp5zttpfoZYk4hMyVeN+A6DIv1jfCkge
 5j1Gkg2hBIJfs7EMR9P+hNLT92YfDbUhBEV/JZVIMdzLy3H9qEB3vwVT9blKVEmQLwyaujV8X7D
 jWl/yD2bbw8zdQ7WlFdUA5qQQfCn8Gi5MJfCTALlMdYA==
X-Gm-Gg: ASbGncuYuO20y9pM9dS/NrRKVuRLlA2kzhd2aCd3w+oAOxEua6LrOQDmaXjfFnGn/1n
 6nyIxs4Ye0d82DfxIXVUMEn3UNwhZgw8d/HmgW2C/Br2H1uyjGiXmLSxEcWCj+GYsbbD8pxTw9U
 esbN82wd7M3LfalMnF5aC+iqF88P+xUDQFwCEudM/IVvnMUTsCz4+Z1ry2GVTm/hdsvx9g60Ehh
 gfnW/2MCDr82VH9eMGlRpXK6hjIaeRWxkX5e+9s98q8WZkkN4wLb3GYIttNxgPpPTstBeWpoJAn
 Udwb2b6SSfr6GwIfDYkT/SGxK4bsq4QxryfpJxAImOtucXfJT33kuWAV
X-Google-Smtp-Source: AGHT+IEOnxIkYT3cpPEoJ0iYbY7e59Nd8dloYrQNQ1LRjgyeH0A6NED9nKlU6VgDOa09rr3uMZ07oA==
X-Received: by 2002:a05:6a21:7882:b0:1ee:cd18:d400 with SMTP id
 adf61e73a8af0-1eef3c883ecmr23178823637.11.1740385475705; 
 Mon, 24 Feb 2025 00:24:35 -0800 (PST)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7325c88d74esm17714914b3a.149.2025.02.24.00.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 00:24:35 -0800 (PST)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] target/riscv/kvm: add KVM_REG_RISCV_CSR_AIA
Date: Mon, 24 Feb 2025 16:24:09 +0800
Message-Id: <20250224082417.31382-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250224082417.31382-1-yongxuan.wang@sifive.com>
References: <20250224082417.31382-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x631.google.com
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

Add KVM_REG_RISCV_CSR_AIA support to get/set the context of AIA
extension in VS mode.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 target/riscv/kvm/kvm-cpu.c | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index ff1211d2fe39..c7318f64cf12 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -132,6 +132,9 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
 #define RISCV_GENERAL_CSR_REG(name) \
     (KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(name))
 
+#define RISCV_AIA_CSR_REG(name) \
+    (KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(name))
+
 #define KVM_RISCV_GET_CSR(cs, env, idx, reg) \
     do { \
         int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, idx), &reg); \
@@ -644,9 +647,50 @@ static int kvm_riscv_put_regs_general_csr(CPUState *cs)
     return 0;
 }
 
+static int kvm_riscv_get_regs_aia_csr(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    uint64_t mask = MAKE_64BIT_MASK(32, 32);
+    uint64_t val;
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
+    env->sie = set_field(env->sie, mask, val);
+    KVM_RISCV_GET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
+    riscv_cpu_update_mip(env, mask, val);
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_aia_csr(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    uint64_t mask = MAKE_64BIT_MASK(32, 32);
+    uint64_t val;
+
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siselect), env->siselect);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1), env->siprio[0]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio1h), env->siprio[8]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2), env->siprio[16]);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(iprio2h), env->siprio[24]);
+
+    val = get_field(env->sie, mask);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(sieh), val);
+    val = get_field(env->mip, mask);
+    KVM_RISCV_SET_CSR(cs, env, RISCV_AIA_CSR_REG(siph), val);
+
+    return 0;
+}
+
 static int kvm_riscv_get_regs_csr(CPUState *cs)
 {
     kvm_riscv_get_regs_general_csr(cs);
+    kvm_riscv_get_regs_aia_csr(cs);
 
     return 0;
 }
@@ -654,6 +698,7 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
 static int kvm_riscv_put_regs_csr(CPUState *cs)
 {
     kvm_riscv_put_regs_general_csr(cs);
+    kvm_riscv_put_regs_aia_csr(cs);
 
     return 0;
 }
-- 
2.17.1


