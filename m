Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C58ED65C61
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvC-0008HY-RI; Thu, 14 Nov 2024 04:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvA-0008GV-CA
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVv8-0007fx-8t
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so292565f8f.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575625; x=1732180425;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuY5Yx+SDWSOTgPbmJ+N/i87adllxTARIGZlZIogOfA=;
 b=hZxqoGTypHP/ie0UMcE5++sECxT1ih3gugnbYYYCCY1834LlOEHYQ3KB9+cnfeIpTa
 dRp9brxzwHX9gcI40DxJJl9lf9Bdblq4lfOMOSznk7HG4SIMbEDzw6/14NN9x0i5Derh
 jMIWZfdE/6xCIe9ekqc32QzJE5LMFMIsOy085nfrbn3qyVcs4YoOX6PTR44WRq5QXRar
 ZLsb48CHobN9uST6iYWVvPXhLp1173b+0Zlq3mBWrTILNkS1zEr7tjE5I92Ffzd16T7J
 YunEWQ9Yasw9oZYfWCU3HPddro8V1bLbxWRq0iQTidnckb99fHk3WVexzvnrjwPrDMAU
 Lihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575625; x=1732180425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZuY5Yx+SDWSOTgPbmJ+N/i87adllxTARIGZlZIogOfA=;
 b=vGPc+LlYcpq8+queqLBghmTCtD1xdMngnc3mmv0dE52L+CLGdQtlrGU3++n6Pgsd0h
 DQwTqJF00EIcRZTU9T9jQB+OMAtuU1CQ5BDq4GltJw5N+Tu+MDtTezQdXFlZhzOBEICz
 5o2oNDK0GpoNLJg/skpBgbc0cuBhWePZLk6M15Xh8j9ifFd4lEOLQhjYb/kyAhnAUHPR
 i6ctBad2mk7w7FJvZsncXQ3ep3nT0f6vJSRgGroDNn4tWjDfKPdXJfbHrZ6d3XssZl82
 sxb8/w6IrCuDyvWXpRleNU5T+/omLFhT6NeIqH4xnGQp/Z9VlVaQbL+vT+PvFt6W6HnU
 h6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmRiy0Q3iGp3rnRDnqPXnglOhCf3VELIbuMdIOTdEzn7LSeQvCWWzkVD+tru2/afknpEuQNhkYg4L/@nongnu.org
X-Gm-Message-State: AOJu0YxvZcOLtHKuzoHP9Co4l1CnwWCX6d3CS4PlLxUpU4cw0sko7b+5
 Llm1uI1NrTqC5ebPYZnZMUAyFWHS1PfBQpuZZeWR60WZUvQ6wBITksKxoGdzgJs=
X-Google-Smtp-Source: AGHT+IGWlkG+i1Di5LFaY3zZaQx5bJaRfuTnvv9w58/kgpBKwXbj5UGdBnVKcFgGGtZfqUUpjURo7w==
X-Received: by 2002:a05:6000:178d:b0:37c:cfeb:e612 with SMTP id
 ffacd0b85a97d-3820df5bd38mr4840900f8f.1.1731575624714; 
 Thu, 14 Nov 2024 01:13:44 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:44 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/9] target/riscv: fix henvcfg potentially containing stale
 bits
Date: Thu, 14 Nov 2024 10:13:22 +0100
Message-ID: <20241114091332.108811-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

With the current implementation, if we had the current scenario:
- set bit x in menvcfg
- set bit x in henvcfg
- clear bit x in menvcfg
then, the internal variable env->henvcfg would still contain bit x due
to both a wrong menvcfg mask used in write_henvcfg() as well as a
missing update of henvcfg upon menvcfg update.
This can lead to some wrong interpretation of the context. In order to
update henvcfg upon menvcfg writing, call write_henvcfg() after writing
menvcfg and fix the mask computation used in write_henvcfg() that is
used to mesk env->menvcfg value (which could still lead to some stale
bits). The same mechanism is also applied for henvcfgh writing.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 target/riscv/csr.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b84b436151..73ac4d5449 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2345,6 +2345,8 @@ static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
@@ -2357,6 +2359,7 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
     }
     env->menvcfg = (env->menvcfg & ~mask) | (val & mask);
+    write_henvcfg(env, CSR_HENVCFG, env->henvcfg);
 
     return RISCV_EXCP_NONE;
 }
@@ -2368,6 +2371,8 @@ static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
+                                    target_ulong val);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
@@ -2378,6 +2383,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
+    write_henvcfgh(env, CSR_HENVCFGH, env->henvcfg >> 32);
 
     return RISCV_EXCP_NONE;
 }
@@ -2435,6 +2441,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
+    uint64_t henvcfg_mask = mask, menvcfg_mask;
     RISCVException ret;
 
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_HSENVCFG);
@@ -2443,10 +2450,24 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
     }
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
-        mask |= env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+        /*
+         * Since henvcfg depends on a menvcfg subset, we want to clear all the
+         * menvcfg supported feature (whatever their state is) before enabling
+         * some new one using the provided value. Not doing so would result in
+         * keeping stale menvcfg bits in henvcfg value if a bit was enabled in
+         * menvcfg and then disabled before updating henvcfg for instance.
+         */
+        menvcfg_mask = HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE;
+        mask |= env->menvcfg & menvcfg_mask;
+        henvcfg_mask |= menvcfg_mask;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (val & mask);
+    /*
+     * 'henvcfg_mask' contains all supported bits (both in henvcfg and menvcfg
+     * common bits) and 'mask' contains henvcfg exclusive bits as well as
+     * menvcfg enabled bits only.
+     */
+    env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (val & mask);
 
     return RISCV_EXCP_NONE;
 }
@@ -2469,8 +2490,13 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
                                      target_ulong val)
 {
-    uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
-                                    HENVCFG_ADUE);
+    /*
+     * Same comment than the one in write_henvcfg() applies here, we want to
+     * clear all previous menvcfg bits before enabling some new one to avoid
+     * stale menvcfg bits in henvcfg.
+     */
+    uint64_t henvcfg_mask = (HENVCFG_PBMTE | HENVCFG_STCE | HENVCFG_ADUE);
+    uint64_t mask = env->menvcfg & henvcfg_mask;
     uint64_t valh = (uint64_t)val << 32;
     RISCVException ret;
 
@@ -2479,7 +2505,11 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
         return ret;
     }
 
-    env->henvcfg = (env->henvcfg & ~mask) | (valh & mask);
+    /*
+     * 'henvcfg_mask' contains all menvcfg supported bits and 'mask' contains
+     * menvcfg enabled bits only.
+     */
+    env->henvcfg = (env->henvcfg & ~henvcfg_mask) | (valh & mask);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.45.2


