Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B979C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 16:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSJT2-0003Zt-15; Tue, 23 Jan 2024 11:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSz-0003YS-Cj
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:37 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rSJSx-0007bu-Ad
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 11:17:37 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2906bcae4feso1306865a91.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706026653; x=1706631453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOOocRNMyUSXJ3ngIwpNGvdMcQOP/Ba340YkioYdkN0=;
 b=leK5oLGHtwHt1X9Aj/VTZkRynyafZeM24/F1uW4vkrBEkYkRQNmF5pB6pkgZXjHhUN
 tgY3/CzjNFmvgVqYLJlsWnd7pGAjlu+KuarRgHZPMB5nrh5TUQdyc1roATMBA374LrYv
 Hh5Gl+YJVaqx+0FZUWo0hQIWUoxGQjwebFBoDAT1CyBLUoKBdolQe8vJNOrALehKKPnB
 oGrOG7h7L8wHdnqdOU8HlAjsh5qmmbxEs2FHAGYxTErz7aa9h2BlP/W3PcmVpWEjUQ5X
 DnEtTpAs/MIVq0a2KepxNso9RcB69hHzc+/fIBBYHno931+NmUBuBvrP7+mCpg3Es3Y9
 /xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706026653; x=1706631453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOOocRNMyUSXJ3ngIwpNGvdMcQOP/Ba340YkioYdkN0=;
 b=evYGE1URgSfWwK0QyfNW4oy/M33mOC8bRL+28ej/lEos0ZtT+O6a0oK30TWl4IWjDI
 f/NIA4dLWXsbJGoThg4nJlj8MFI48GreRwYEnh7l5MOFxXxJ5fCg03oIXnrzXaA3jvY5
 Ad94SGwXe68l9+ueZzBWnslXS4MwCECXWVuD7g4pfKbEU/7QDLu/cUhXc1YWsvQbduqp
 Pw+fxszkBu1NtRdEx0zXzpjEC9XqBTh6cSQJUZNdTlYBXbM0MCGv3m1YaleW7VLGrWYa
 ltHwWLM/rXIHB4cofQMFPBfGK1viV6jTQ8SP0+IMIa/wM06Xr3j2/cELNKlRPHnsiTGT
 BBvA==
X-Gm-Message-State: AOJu0YwgADei1gHkWrehUQl8dZoc9gc28cWjAcf+YN+QXOl1KkgU1fD8
 Xz2JsDUfvWx3WCYban/3Uk90zz80QZviAlz7bjWKcSKNDdQLXA6/eGEx6bqoKcCXZuHw5zynRuf
 C
X-Google-Smtp-Source: AGHT+IEzZrqMn1mtj4kwpVwex65oCTLZLCf49XvLu8TMCOyghpGPLGPjgTEQg8AngWq+m2TuA/8uUQ==
X-Received: by 2002:a17:90a:ce83:b0:28d:42d3:5cde with SMTP id
 g3-20020a17090ace8300b0028d42d35cdemr2740665pju.68.1706026652975; 
 Tue, 23 Jan 2024 08:17:32 -0800 (PST)
Received: from grind.. ([152.234.127.94]) by smtp.gmail.com with ESMTPSA id
 u14-20020a17090ac88e00b0028bcc2a47e9sm11755686pjt.38.2024.01.23.08.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 08:17:32 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 3/3] target/riscv/kvm: get/set vector vregs[]
Date: Tue, 23 Jan 2024 13:17:14 -0300
Message-ID: <20240123161714.160149-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123161714.160149-1-dbarboza@ventanamicro.com>
References: <20240123161714.160149-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vregs[] have variable size that depends on the current vlenb set by the
host, meaning we can't use our regular kvm_riscv_reg_id() to retrieve
it.

Create a generic kvm_encode_reg_size_id() helper to encode any given
size in bytes into a given kvm reg id. kvm_riscv_vector_reg_id() will
use it to encode vlenb into a given vreg ID.

kvm_riscv_(get|set)_vector() can then get/set all 32 vregs.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 3812481971..a7881de7f9 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -86,6 +86,27 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
     return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
 }
 
+static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
+{
+    uint64_t size_ctz = __builtin_ctz(size_b);
+
+    return id | (size_ctz << KVM_REG_SIZE_SHIFT);
+}
+
+static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
+                                        uint64_t idx)
+{
+    uint64_t id;
+    size_t size_b;
+
+    g_assert(idx < 32);
+
+    id = KVM_REG_RISCV | KVM_REG_RISCV_VECTOR | KVM_REG_RISCV_VECTOR_REG(idx);
+    size_b = cpu->cfg.vlenb;
+
+    return kvm_encode_reg_size_id(id, size_b);
+}
+
 #define RISCV_CORE_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
                            KVM_REG_RISCV_CORE_REG(name))
@@ -694,7 +715,8 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong reg;
-    int ret = 0;
+    uint64_t vreg_id;
+    int vreg_idx, ret = 0;
 
     if (!riscv_has_ext(env, RVV)) {
         return 0;
@@ -724,6 +746,21 @@ static int kvm_riscv_get_regs_vector(CPUState *cs)
             return ret;
         }
         cpu->cfg.vlenb = reg;
+
+        for (int i = 0; i < 32; i++) {
+            /*
+             * vreg[] is statically allocated using RV_VLEN_MAX.
+             * Use it instead of vlenb to calculate vreg_idx for
+             * simplicity.
+             */
+            vreg_idx = i * RV_VLEN_MAX / 64;
+            vreg_id = kvm_riscv_vector_reg_id(cpu, i);
+
+            ret = kvm_get_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
+            if (ret) {
+                return ret;
+            }
+        }
     }
 
     return 0;
@@ -734,7 +771,8 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     target_ulong reg;
-    int ret = 0;
+    uint64_t vreg_id;
+    int vreg_idx, ret = 0;
 
     if (!riscv_has_ext(env, RVV)) {
         return 0;
@@ -761,6 +799,21 @@ static int kvm_riscv_put_regs_vector(CPUState *cs)
     if (kvm_v_vlenb.supported) {
         reg = cpu->cfg.vlenb;
         ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vlenb), &reg);
+
+        for (int i = 0; i < 32; i++) {
+            /*
+             * vreg[] is statically allocated using RV_VLEN_MAX.
+             * Use it instead of vlenb to calculate vreg_idx for
+             * simplicity.
+             */
+            vreg_idx = i * RV_VLEN_MAX / 64;
+            vreg_id = kvm_riscv_vector_reg_id(cpu, i);
+
+            ret = kvm_set_one_reg(cs, vreg_id, &env->vreg[vreg_idx]);
+            if (ret) {
+                return ret;
+            }
+        }
     }
 
     return ret;
-- 
2.43.0


