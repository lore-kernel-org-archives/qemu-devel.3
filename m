Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0AAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs40-0001cL-63; Mon, 19 May 2025 00:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGron-0008E5-8I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrol-0004MS-9E
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:36 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33677183so33405295ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627772; x=1748232572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCbKQMOwh8rHUyRi+b6GZXHbmiuSws8tyqWZVbKDIxg=;
 b=lFuQ9Rh+HFjaHvUIPNvpGzoDnqiVn7JfMJhgvgXu7cjj+XLFljoHAwnI3ypn8KtRcQ
 L2wz4ZR9YzELsQJnEyKcVzevMuXFo/W9UnQZtzFhY5RtT+x0QjOkVpeKeUe98k1MjmJt
 4GySTuWWewkoIcbYvwTHnWL4a24d7kwlnVfJdDB64el+BsU6djrfyBpATc/AJIKZgtyP
 J0DhG4fFcnDz+w8rWMPl73nzoskRaHTpgExIEiIzWyIXDSOezyfEcKrDSPwBkSh6SuBi
 /jCYUJag0PWMRa6IAS0w8GV77D+OIOZYYBNst5B8ajjpIQDeWV8qxkeSElJ/7/9agpjA
 NPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627772; x=1748232572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yCbKQMOwh8rHUyRi+b6GZXHbmiuSws8tyqWZVbKDIxg=;
 b=f3GZnQKPQTmfghR3bklsH2ewm2AYSH8nwfoI6cb6UK5YKWxqKReOKMiIg0vGuhOGk3
 k+FvvcQrx5IrjCEE23CVsKEKMl6CqkRfLGkflDW4wvmb/lsCp4bwyBsQGyWcEMgcpbv9
 okhl6Hvqmmi0/WR/kH/WltjZUo2Kmo6CtJqvashMWk9fEfUYCegRDBTLRNjL4wM8XR5i
 +aftrevWltbwi4d6z26gkphcu1U3F6SCw5+5a68gPra8EiZTmNAKgF5La8PJJJDyDf1t
 PCbvrtGNc/pkhoSp4EuxCOlZ9HAcMuE76uQeZAyh2KMFeM6hH1Swfrc4QcoNwjOWCaQW
 pNjA==
X-Gm-Message-State: AOJu0Yw3FKlU+Cc2BKIMiicwq+tGNz4TXH0tdQuYOmFyE5eIM7uTj0eN
 PDGv2K7w9gKzY1KRcDzboMdwjCMLISDtYJYa5D1MUCkEvQt+Pk1W4F7aYMYIyw==
X-Gm-Gg: ASbGnctdLnIakV0EjI7trxKSL5Z05a0uoOzQUQYrO8fGBusB/wGZn64srHX/g0R1uLF
 RyiA6p0TA/uJZTAiFaCrWYk07WH/DdBc/v6e+oOad7/+ECOiX5OaHQDZVS1RO/abE4K/42peQKN
 bhA8eshkDFxcWOahbnqMHr66/0geapjXUK45idLWpafpQVWW3ULf6H8wwl38KA0kABMUjSDqWeA
 jFwBCrYlWRbhJupCmoFAccMeLJeKSr6r99XrUaknr2iZourKru/V5bBwe2KV+LDT5ZjVSOO4uOn
 dVFZXxiaox2SUPobDIsLifsIS4xnP0a6f5x7O92yp4XhmxNEtXQRZM696dbbpzUxXUSeimjAgkD
 VqYFzJuNGRbUXL6AGA0ejJ2hIYuvU2sNP8FEjgI063XlHZqi8AWbMhwRg
X-Google-Smtp-Source: AGHT+IEv1LAjboojzQjhHuIhBLXMB5Y+FIMknUkvie/jWpXZVTRFBftWuU06TTvYxjw6CHxCQDw0dA==
X-Received: by 2002:a17:903:40d0:b0:224:194c:694c with SMTP id
 d9443c01a7336-231de3764d3mr181054375ad.28.1747627772371; 
 Sun, 18 May 2025 21:09:32 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/56] target/riscv/kvm: add senvcfg CSR
Date: Mon, 19 May 2025 14:05:42 +1000
Message-ID: <20250519040555.3797167-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

We're missing the senvcfg CSRs which is already present in the
KVM UAPI.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 344616c1cc..0e34382163 100644
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


