Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6589C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs4W-0002Wq-Es; Mon, 19 May 2025 00:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrop-0008Ft-Bc
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:43 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGron-0004Mk-JY
 for qemu-devel@nongnu.org; Mon, 19 May 2025 00:09:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30ea559c18aso1978949a91.2
 for <qemu-devel@nongnu.org>; Sun, 18 May 2025 21:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627775; x=1748232575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDbQRI0gFUTlFlnqp0xUGVSKtTCiqP4maLsscJujipw=;
 b=UiqpxhZVygmsglzYEnKGkH6vAjgpjsB7lpFvZuFLrLt99KkpWIdlR1PrbpQuyOkYFW
 WNFJkiRzxp1lKjjYgKY7E9zbHpGBvnNLyk7OjVNt2fGiwrhv6sRCw4MjLmV4om4vhsGH
 n8u4rcdS7cMQ0MkQehzLURb6tCCTWGH4Jz9WeMblAxKfUQ7WjfzzBylYr7PU2eJl/7sD
 lTGHfXqXMHIopMoMHoxNBqkdMAWtULSgvYwY+GETl01LRgCchJy4at305Lwqiz4nhZyZ
 +dyfXgSbKApZf0s3MBdVI8dhDxxOy/7ZYOUvEPB/U6umTSno9SeyawpX+sBbJL8v9L0b
 HJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627775; x=1748232575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDbQRI0gFUTlFlnqp0xUGVSKtTCiqP4maLsscJujipw=;
 b=QKesc0EuGJ7mj01wm46wDIhCM6N3Vn0MyNXWBLlrbb9F8907QCRuTcVW3WIb0zfRwY
 vvvNmL0lzLpCRfuQSeZnSfkzLbU4olZ2EQUSHuVcOUoFTHW/JHjcYEaomcMDSGkdWfbq
 TLP6v+vJvq3StJnU6umKEjKK6OLL0iOk5sLg6xpMzCAdTdzyaoOB/H83oohTxkhkxdfK
 RcXndNpGXiLepdVMsUAhGKqk3GUoEjf12yWAJTdYgWO9xVooDrh+iE1BjOKjBEuDX39f
 JyfnpkJscinyUTAik/WO7C9PURRmdoD5ye4mClRODJKwYzYMHdkSm2kcZGKcp1OiWHjo
 ftlw==
X-Gm-Message-State: AOJu0YyB3SRhEJxtyNMqFFyFHQSeL9YHIhjxqW87mTJcsRhX60bqCh53
 Xy+3H6KodGMb3fW5Xu7kXfWMQSt4uQWg9WYrjnn9QSwof+FwVjqnkxcTm3+yfw==
X-Gm-Gg: ASbGncsuNDO7UY/xttLoc7VkUq/wmvnatCAhj24+lx7P0Z5GxQqwEd+5QXWT3EZ7KH7
 dQ6+VS0sSfIKhxazfmpYlcZjlgU7/Kmtpr5SyxRVRHSKDdsflEfEeRFjtYOeddN50L+/AjY86pc
 CM7XnlWQKZKRBLe/grqNIjG0esosrG0N6HHnT2Rj7eyAX9DAZ+T1OEuM5A1VDeS93xTKjAtGJkO
 K26ZztBDVthl1b2L3iCuXQE1DuesMyATK+VEmGopaE1K+HUgAdrzdNrsiG/Xr5Xu+Sjha7AB1th
 yCh6zDJnWPCJiAEl6nS2w7Z7ko0ZveebnpE4gAgFioZK6i9euwC9UNun7WGsskMpH2BaXoV4HYf
 WMLMzb9Ad+6AOj1q7Ui6s6C1cIwAIw/uTnXsMQG8iI8qBwwLwSIQAoOMl
X-Google-Smtp-Source: AGHT+IF1lRX+AmfZYLmPDKpddvqk7aj7gWFCjaGaBNU4Ufh56uC6A+Lhgpm+oBmzfr0DwHFBtrMgrw==
X-Received: by 2002:a17:903:4b4b:b0:220:c813:dfcc with SMTP id
 d9443c01a7336-231d452d0c7mr194936415ad.40.1747627775502; 
 Sun, 18 May 2025 21:09:35 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/56] target/riscv/kvm: read/write KVM regs via env size
Date: Mon, 19 May 2025 14:05:43 +1000
Message-ID: <20250519040555.3797167-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

We're going to add support for scounteren in the next patch. KVM defines
as a target_ulong CSR, while QEMU defines env->scounteren as a 32 bit
field. This will cause the current code to read/write a 64 bit CSR in a
32 bit field when running in a 64 bit CPU.

To prevent that, change the current logic to honor the size of the QEMU
storage instead of the KVM CSR reg.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250429124421.223883-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0e34382163..ca171d5457 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -135,6 +135,7 @@ typedef struct KVMCPUConfig {
     const char *description;
     target_ulong offset;
     uint64_t kvm_reg_id;
+    uint32_t prop_size;
     bool user_set;
     bool supported;
 } KVMCPUConfig;
@@ -237,6 +238,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
 #define KVM_CSR_CFG(_name, _env_prop, reg_id) \
     {.name = _name, .offset = ENV_CSR_OFFSET(_env_prop), \
+     .prop_size = sizeof(((CPURISCVState *)0)->_env_prop), \
      .kvm_reg_id = reg_id}
 
 static KVMCPUConfig kvm_csr_cfgs[] = {
@@ -646,9 +648,9 @@ static int kvm_riscv_get_regs_csr(CPUState *cs)
             return ret;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
-            kvm_cpu_csr_set_u32(cpu, csr_cfg, reg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
+            kvm_cpu_csr_set_u32(cpu, csr_cfg, (uint32_t)reg);
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             kvm_cpu_csr_set_u64(cpu, csr_cfg, reg);
         } else {
             g_assert_not_reached();
@@ -671,9 +673,9 @@ static int kvm_riscv_put_regs_csr(CPUState *cs)
             continue;
         }
 
-        if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint32_t)) {
+        if (csr_cfg->prop_size == sizeof(uint32_t)) {
             reg = kvm_cpu_csr_get_u32(cpu, csr_cfg);
-        } else if (KVM_REG_SIZE(csr_cfg->kvm_reg_id) == sizeof(uint64_t)) {
+        } else if (csr_cfg->prop_size == sizeof(uint64_t)) {
             reg = kvm_cpu_csr_get_u64(cpu, csr_cfg);
         } else {
             g_assert_not_reached();
-- 
2.49.0


