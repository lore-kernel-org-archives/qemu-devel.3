Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E521D69112
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfHB-0005RF-A1; Thu, 28 Nov 2024 09:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfH6-0005QL-6S
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:45 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tGfH2-00061e-Rq
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:13:42 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2120f9ec28eso7096965ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732803219; x=1733408019;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jQmZHVZGJH8bUITrZGLb9vyQJRHYXGRdZuUVz+4EJM=;
 b=RYxsWi19IojJJsvfNYjKxwVqJMHYhv58DgNg0JUbTUnlk/rG6307ZfULTK33YzhYWo
 PgXBK9Q9YZpByTdy2FK19fRzB/Il/6IC85Gqf1Evc27KVHq4nVAjNpDo9V94jAHizwvm
 xDPAw9Jmk7F0suze6F5j05X7hHLNvZYGHI/isXUHj50Yodz1TLdAFAkXD7d3+oyX3zcm
 5Y8ygjqBoEFxHkj9JILSuo4ew4NwexQPaMerX6PhmWv5ZdkxlvI1HkDREjlQJs9tZm4W
 d34Dgnh+pBI9qzOXQ8lxuS4AMayC3ujAhwJNwtbFp3CBHtksr7X0EVLOreGDdgMUkFX3
 eTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803219; x=1733408019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jQmZHVZGJH8bUITrZGLb9vyQJRHYXGRdZuUVz+4EJM=;
 b=XBza5SIoVOZebXvAKlMbhDqguAeGSXxH6IbW5+nhVsqGwxvGvqzEprFCWQf68yZAhd
 HnAoVj3wDR9w0gU4sGaNe4gAW+TS8fxGQyFjc08sYit047htLQ/U10efKD68NIvqIQhO
 aANsyVfNEQovgiwMTfO/ZEQbsGz1QqfVQXkBLIoeAMSLvn+TBKl6rrbfb1KanwB3Mflx
 jYD1WjDbyz8ngbKTyRFYG2143Tzhl5ww7DkssQ6G+mqY8zdIRp0F63ZriTMVbLMH84lq
 8URzjz4zAx7QMhYrdq7IlBGK7GsOTCiwig+mhM3LVN/iTkxs7ICN4rdbCOMny3uenOTc
 M6/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuzAxrX7qznZABXUOSisCFQBLuK77sQdXABS5By9V8wKZbZ89AGSWo01s1ka50OZMbJu3X1GQtjg98@nongnu.org
X-Gm-Message-State: AOJu0YxZKPHF2+5WZxrRWmCTPOGxrc/WoofC4U33g7qW+trGOMQ2VTbE
 jE6zMeflc4iR2L19kWymj4n1/dVIFr+RA3OiqfecZGJ0vTaOgU6fNLB5mvUH9yE=
X-Gm-Gg: ASbGncvDVpIjujkIUA1p6+lkGEgYiU2RT+RRefnK30f549GHcP8cZ3OIIBiK2KNqK8O
 AcVqcWuKHgEs1Cf80GyuMtTtcyNoyN82T+GyULPYgd0bcM8vX/ra4aE7y7iZr3EOiLEL8fwUsOV
 YFdbvhFGDrDj1DuSqwlfbWWYbK5a7/FT9PztT6LCSL5dC8gTW7n5JuZdJxAvlsCx8aJSB9yMttK
 kQJ8lVEJCxzN0oAZLErcwbAUtJsAtCafr8RRo6MwDs9WQnMAfg=
X-Google-Smtp-Source: AGHT+IEkX3KMCtHfmsbAFe2ylla4UOAbvh+ROmASYv+JpYewu+jeSYrOoe+VyrZLAWeFYzAIYNXNOg==
X-Received: by 2002:a17:902:e809:b0:20c:7196:a1e9 with SMTP id
 d9443c01a7336-2151d32eafbmr52108815ad.13.1732803219140; 
 Thu, 28 Nov 2024 06:13:39 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215218f452csm13829005ad.48.2024.11.28.06.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:13:38 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 6/9] target/riscv: Add Smdbltrp CSRs handling
Date: Thu, 28 Nov 2024 15:12:26 +0100
Message-ID: <20241128141230.284320-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128141230.284320-1-cleger@rivosinc.com>
References: <20241128141230.284320-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62e.google.com
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

Add `ext_smdbltrp`in RISCVCPUConfig and implement MSTATUS.MDT behavior.
Also set MDT to 1 at reset according to the specification.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  3 +++
 target/riscv/cpu_bits.h |  1 +
 target/riscv/cpu_cfg.h  |  1 +
 target/riscv/csr.c      | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f30630e947..be7c0475bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1027,6 +1027,9 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus_hs = set_field(env->mstatus_hs,
                                         MSTATUS64_UXL, env->misa_mxl);
         }
+        if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+            env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
+        }
     }
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index ed33610b83..ab9d0b19d8 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -566,6 +566,7 @@
 #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
 #define MSTATUS_GVA         0x4000000000ULL
 #define MSTATUS_MPV         0x8000000000ULL
+#define MSTATUS_MDT         0x40000000000ULL /* Smdbltrp extension */
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 1194dfd3bc..6699e134ee 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -80,6 +80,7 @@ struct RISCVCPUConfig {
     bool ext_sstc;
     bool ext_smcntrpmf;
     bool ext_ssdbltrp;
+    bool ext_smdbltrp;
     bool ext_svadu;
     bool ext_svinval;
     bool ext_svnapot;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 611f44e044..055b19d517 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1649,6 +1649,13 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         }
     }
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((val & MSTATUS_MDT) != 0) {
+            val &= ~MSTATUS_MIE;
+        }
+    }
+
     if (xl != MXL_RV32 || env->debugger) {
         if (riscv_has_ext(env, RVH)) {
             mask |= MSTATUS_MPV | MSTATUS_GVA;
@@ -1692,6 +1699,12 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
 
+    if (riscv_cpu_cfg(env)->ext_smdbltrp) {
+        mask |= MSTATUS_MDT;
+        if ((valh & MSTATUS_MDT) != 0) {
+            mask |= MSTATUS_MIE;
+        }
+    }
     env->mstatus = (env->mstatus & ~mask) | (valh & mask);
 
     return RISCV_EXCP_NONE;
-- 
2.45.2


