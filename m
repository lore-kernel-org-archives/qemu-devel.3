Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C0BC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8LVa-0006Ao-2v; Fri, 25 Apr 2025 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVM-0005sJ-Pl
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:22 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u8LVL-0008Ln-1t
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:02:20 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af6a315b491so2376393a12.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745596937; x=1746201737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mysvDSm/Jc56rhNUm6asG4M9/OvRcpOng4mCRfmCeZk=;
 b=oHx4zR/b7GJclGSbtTByGFOK1679ePdkOmWEUlW08eMJob1HKroH7pfMZTcH2uqett
 BkQKJSzhFs4ri8LarAvO8EJ4jS8G9sRBqRo/swoRYJofhLJXv1Hyo/H/qZlXICN80l6D
 TDSQUaztcX6f+UNIUjNEwA7j35LKLj6Bb0dVUl/cMvr2C6sGkv69x7cmpG2oZDqXDfnL
 idr85PnVNAQr2Jax3IqDr3ZHj2ar7nLn6HxO8rbhTIabT8TxMJn1xPF+H4vkOpuqI3ib
 n4wlcmNhqqTgU4hxG68lGaHIOtYjds8rVBoA9b0KSvw86Rdi3heWJMli9YWjlJsybR0V
 dI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745596937; x=1746201737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mysvDSm/Jc56rhNUm6asG4M9/OvRcpOng4mCRfmCeZk=;
 b=I3yKZWY7rkXW7namAF6R0zc8l3pYhyRg0jy3Ad6EAjyZijl8/+VIhrdD7QZx+rewKT
 J/UmNBzfKpi/uuIEio1poxMavBF1UsMcYubmvg+KRavaLoR8t0pOtTIxYwdZOwAUdiyM
 rSmWSF9dKzeSdY2pMSCcPRhDba6SXdDZIxVUT8uu+gVE1Hc4zKx7xmor2UAP7oGqlpWP
 Mwi2Az1w2p2FkYtCzkiN6rxB7+8At9bqFZm8S6SNyDjEk8akhsLmgd42/nAj/mhzlu6J
 7WISbqNTNl0hFbsUxzv4GT0QHGvQbdjTdelIcwHc3FFgnx5BcgiWvvl4Bq1iu5NXh5bW
 vzog==
X-Gm-Message-State: AOJu0YxqAlnlFTHhjDfYB5y12Nfqvqxx8lYOd+CZTbPKZSxbBMk4sF7P
 BQC3zQs0c6L4CqZ5ShHAIBQ3Ft5GHiflY5g9zNwylkDXdfEv0ahZy5xXUThq2/wBDdBvbA+AivY
 Q
X-Gm-Gg: ASbGnctnCqN02sMNaWMXT09bOVgzqutCR5XcQXMRV6L9ZZSq3zuK8bg83L1xwNtqLIC
 f5CgR8gL7Ku07m2VTwr5cMy539iORQPuV1Ue/EngGYsFTH+z+yNfysBlTsHRV0Bt2h+0vcIJa0M
 JwxhR53nq3QJr5V4wPS+PDCfaONPU/6OCaOPNu/BijV0JesK7M15CgQD6Z2zZ/+eoQP9vliaJS5
 Pcgvwey9XU2pnmZi/1+S5piLUbVGa9na+F2fwGnDI2F7Ni084bFuAJuJdJQA7iUFhyVtZse+4qG
 uPWGSHNUqo//MWymzO+qUfcuBT/hbbRNr2T6G8qxdQL1nXbbfmi3Ss8dQNNXrETX7Iul
X-Google-Smtp-Source: AGHT+IHB4mUcuFm+GKhG7QrzRS48FcS5IkaNzF9uvLcHu3c9ZyoKZkjpaOJ4eHd0Fcb5YKKy8wnp0A==
X-Received: by 2002:a17:90b:48:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-30a01300dddmr205836a91.2.1745596937323; 
 Fri, 25 Apr 2025 09:02:17 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f774e534sm1820005a91.17.2025.04.25.09.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:02:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/9] target/riscv/kvm: turn u32/u64 reg functions into
 macros
Date: Fri, 25 Apr 2025 13:01:57 -0300
Message-ID: <20250425160203.2774835-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52a.google.com
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

This change is motivated by a future change w.r.t CSRs management. We
want to handle them the same way as KVM extensions, i.e. a static array
with KVMCPUConfig objs that will be read/write during init and so on.
But to do that properly we must be able to declare a static array that
hold KVM regs.

C does not allow to init static arrays and use functions as
initializers, e.g. we can't do:

.kvm_reg_id = kvm_riscv_reg_id_ulong(...)

When instantiating the array. We can do that with macros though, so our
goal is turn kvm_riscv_reg_ulong() in a macro. It is cleaner to turn
every other reg_id_*() function in macros, and ulong will end up using
the macros for u32 and u64, so we'll start with them.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6ba122f360..c91ecdfe59 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,12 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 
 static bool cap_has_mp_state;
 
+#define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
+                                         type | idx)
+
+#define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
+                                         type | idx)
+
 static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -76,16 +82,6 @@ static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
     return id;
 }
 
-static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
-}
-
-static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
-}
-
 static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
 {
     uint64_t size_ctz = __builtin_ctz(size_b);
@@ -119,12 +115,12 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
                            KVM_REG_RISCV_CONFIG_REG(name))
 
-#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
+#define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
-#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
+#define RISCV_FP_F_REG(idx)  KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, idx)
 
-#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
+#define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
 #define RISCV_VECTOR_CSR_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
-- 
2.49.0


