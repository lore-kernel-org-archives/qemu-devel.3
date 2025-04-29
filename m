Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DC6C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kKe-0002q1-1x; Tue, 29 Apr 2025 08:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKU-0002gC-IN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:54 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kKQ-0004Nn-R8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:44:52 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3031354f134so4890327a91.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930688; x=1746535488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5EPo2xWup2FzZs+fmoD03mr3dmy4Dnii+MBbbjY7Lvw=;
 b=NMFG6AOz0JBwd+VjcSTKjsOL4Yr0vNLVP7OAh6Pw6Fekazk4qisnoF8q6CEe/oVrx0
 KdHLQ6NfiqXqO2Oe88zyDxJAbP7vCbP3g3xz01qA4jlbL8RycU02zANSIxA9DdlpphtH
 0kwEzhyJfeP7ruzG5ApsSCWMTSZBYN31cliFEjoQjcOGye0YCu/5vWo3IhrV6Y1MUSiK
 oQOA84iEbbJZhisvC05sf5U6bSxFaAMJH65bKyhxPj6P9mJVfLtqpkQ8U7idtEurfvWc
 A0CB5MPIX775WPNm3jP5gnsBpHQIBkO41NLutja3YNzT2fmh0swYZMq6nqDEUcoQXw3U
 akfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930688; x=1746535488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EPo2xWup2FzZs+fmoD03mr3dmy4Dnii+MBbbjY7Lvw=;
 b=JJlUhaz3qUCT//1/yIFJvbj2XcZm6wRAMRE5kI/KwYRDyJiqDXNoQlZf6814ESaVsk
 Spy9430BPyy36UDw9VmnaSYeaJ1esTNkUj1ga1PC66gH629anGlWYL/DVvnQDI0R4nJX
 6PaihbY0T5AJLyU88BDwzK5s/CEUBEFzPY61X2jWEuJgxLoq1kn99f9VhfAXhvzeMh9Q
 vUoI4cbzTfOC9NDiXWPPOj5YpnkqsfnBEuHEAlT/qFkJ31qnzSctvQouPpZT4bGyfMhJ
 29rjWn9d0eHmfBEqYXcpv0OzVmqTe+/daMIio2qx4CCwFdWw/RvnOzSwq2jTZaXpcg3h
 Kh5g==
X-Gm-Message-State: AOJu0YytYg39zDoVAK5IX+ALqHA/PZCIH8ohyGkUW17ZZm+aCtHMeT+e
 +7ZDx9UR2sUWbNbnMXVzKNjXFt/CTdrcyxi5MiBAeUVEazqm5tKGspPem9K+m3p0pwrveJUOnz0
 I
X-Gm-Gg: ASbGncsV0rfsq7ydgGrDOz6RwEgbE/7PTQfsamhJk8eJcIBgClYvUJQu4Tj2nvRls73
 WYMDjFD8mG4LQSPwOfmG0tuNnM9Z1+X8k9iKZtkgVG2M0ZppnQfRVGuIMiu3apAPOI+cr4bAQCW
 mD7nOU4bmSy5VbB3bkJ18J/YxlDZ443djQyv4fYQd+AgbDuzC8isDswWZ8chqFrIpDctt/GsYZz
 hGIwPd2UScPCeRVq61OadwoE3j8GVwSCo9lJg/EYWvzX9SQY9tdI54Gne0uTW63pGJfcl7LSCle
 C84dWgk7T6KpT/zIvDskAZkHju6QvHpKSy8OhaW+C1U=
X-Google-Smtp-Source: AGHT+IGjB3tgKBQEypuOzwxN3gsi1/eNzNzjGBLjr0t2CyOFbn2GEVPpb6OVgcvtxqhfEojncsKb1Q==
X-Received: by 2002:a17:90b:3bce:b0:2ff:5a9d:9390 with SMTP id
 98e67ed59e1d1-30a2154eb1fmr5214288a91.8.1745930687764; 
 Tue, 29 Apr 2025 05:44:47 -0700 (PDT)
Received: from grind.. ([152.234.125.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef04ba89sm11001161a91.10.2025.04.29.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 05:44:47 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 9/9] target/riscv/kvm: add scounteren CSR
Date: Tue, 29 Apr 2025 09:44:21 -0300
Message-ID: <20250429124421.223883-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429124421.223883-1-dbarboza@ventanamicro.com>
References: <20250429124421.223883-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102f.google.com
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

Add support for the scounteren KVM CSR. Note that env->scounteren is a
32 bit and all KVM CSRs are target_ulong, so scounteren will be capped
to 32 bits read/writes.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d55361962d..ff22ad1fb6 100644
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


