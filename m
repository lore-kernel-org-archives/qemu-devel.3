Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82644C3ABA8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKH-00026Y-MM; Tue, 29 Apr 2025 08:44:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKB-0001sC-U0
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kK9-0004LG-BY
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso69838715ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930671; x=1746535471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1/pH75J2ESZ3iYPkpvn3hHXRSZ0chs2dEX/b6rX2kE=;
 b=jitn915UQ4wKsB4pN9r+8xzXUSPD65cxD5rjIL7gJsB4HXcu5STNaqhMx8KANkRsGg
 Kwc2QNAJuvE1xPOdT44DgiuToVoUZYuUlYrAYyU0BsyFla0BTW84R2Wl3k0I8VJRNUxk
 g48mRye8fMI5qrl6WHlU4Vf+n48iI9yvsrgvZVwXn3ObR3urOJL/zhDmbbDrspirQVFv
 kRTb/984wGubMLHK35+hnD8Yps1jfYVmVdRGeLkcM8WpAe+mWyYsG1nO/vY+P+HmiKDt
 YcjcjYEr4f865zWAIEMbW+h0ZG5CEUbqLDxEjgfjOpseaeFxN+MOA4+XRSpyYhesRatc
 OUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930671; x=1746535471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1/pH75J2ESZ3iYPkpvn3hHXRSZ0chs2dEX/b6rX2kE=;
 b=W0doBaLRKHlHhg/4GIezFMR4GOtgqObfCAALDLJewdkQHJCaziuz9ADD+ERr/NMQaO
 0LnizKif/i3HayUVHQsfV8AFiFeZSymfpt4tsQZ84b572c+eV+8kseMs9UTj0SpSUwSu
 HawLDDxgTf7ajEk8x/uuZSkd0A4OMv7Fp6j4sNF359C7hY1zaSiMBNZClq/q0mwiq5/s
 dnknBhWYLWmlgjZVCyDFYnq77hF/dhFv/lGo+3ys9e9sCfKVQwwdQAZcMzpSCBOzO7X4
 XvKLxhAlv6SfJjlHgNY06CVL01ptLeGkNzz9e/3e7FQSuey0X1yFcIrNXSTalytTYlh9
 MY9Q==
X-Gm-Message-State: AOJu0YzFc5Z+jBNizKlGm1RUMKVqpkoQ9FTqM+SUIEKhmp+S6MSrSb3M
 VnT6DYEK0eZ1/Y6qgKRXSGdVvziz9iOUCErPqvnp0QKmvqYFN+I1nD7qULLVYhT0Z93qcS8a0Hu
 Z
X-Gm-Gg: ASbGncsJNUV9X2j15hiTVHMG6FYgrcs+g7FRDTLWF6gdycg7+WXr52271dLg79dkAno
 H83BgkuvlQf5La8SndMNv+Got9uwK7VXbydJLmzAnnfEUwhQS/iGqjPTBNGdpm1RPsJoHklYkDp
 v/SIACzOQZTgkBCd5agCdL1KcU+TDl94ilL9kPrEZ2CxFYOIA6IpVvb03CbPGa8rToqDwAirEp+
 7kTrpA6PVA0/JMyB/jcLGicj7gjfqk1C38YYhVUbOCBPPGmL/BEdD8N7GBBdT3QaIMTDdRjI9/s
 gZCQmLX+PyoWvtovj4ryXEXgpqSAXPR4W6O2Zs2mgUg=
X-Google-Smtp-Source: AGHT+IEJlBPnBJUYQxqdJXbCKNuXqmtaiHpuySn/Xd2ytwjGrf/8cVt/+Ho280Mw2UY5872zvB4jfw==
X-Received: by 2002:a17:90b:3a44:b0:305:2d27:7ba0 with SMTP id
 98e67ed59e1d1-30a21543ea5mr5020230a91.6.1745930671416; 
 Tue, 29 Apr 2025 05:44:31 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:30 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/9] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
Date: Tue, 29 Apr 2025 09:44:14 -0300
Message-ID: <20250429124421.223883-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x636.google.com
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

'reglist' is being g-malloc'ed but never freed.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index accad4c28e..6ba122f360 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1119,10 +1119,10 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
 
 static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 {
+    g_autofree struct kvm_reg_list *reglist = NULL;
     KVMCPUConfig *multi_ext_cfg;
     struct kvm_one_reg reg;
     struct kvm_reg_list rl_struct;
-    struct kvm_reg_list *reglist;
     uint64_t val, reg_id, *reg_search;
     int i, ret;
 
-- 
2.49.0


