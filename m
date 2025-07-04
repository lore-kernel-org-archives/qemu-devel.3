Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD574C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeOH-0007ex-1o; Fri, 04 Jul 2025 07:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN7-0004w7-I5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeN5-0004O2-Mi
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:14:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-234f17910d8so7527465ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627662; x=1752232462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONjmGA/ciZhqBcIWB+pcuvZnH4RBOoReODO2aO4hpOQ=;
 b=D20cpfIcBExfpHU4SEeKFm0LNOe0PcPacNqutXH3FRcLCyGuLSLJZdbaFp/WdE7IGP
 I2qSmxn8xLyX/evLzKmOcHeiMqfvXOrhr73QuN9koZ3sphx1Cje86XkLjyTkfmW3r6dZ
 fxvQlSKxW2uP0Utir7pI/VWYQRLRdmvmLxLrSjCbNgIPiOjv0PJZYyfvd+1e/PoYTDOd
 JdWsY64gdZT/Q2p8mwfGE6+aD3Wpv2Bb20drmdgT1lWLH7VzxfYzMHaQ/y7WxDAV7K3/
 Z1T3ZMyStMuyylMj++ktV4MyTHOT1ay5IhcnUqlZkq1H1S3lPWUGL1HNnOyvLZWmg40s
 WhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627662; x=1752232462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONjmGA/ciZhqBcIWB+pcuvZnH4RBOoReODO2aO4hpOQ=;
 b=GqY35zKp0UTiVV1IJ7SZ6fJs4PGShtrD2k/ZgQvyOZoq5+o8S82pZoOQmbWNrXYXlm
 hkqq2spGcJ445fLfeaGAiyfZT2olFdWLoA+rC/7BZW0ZqQN2woqQOdDkXIZU/CjDhy8y
 OPszhfZaInXZmkS2LCbXdd1N0isS11XqgJxgGcx8in7bLCL5G6m9XXV9eo7IGx65qVTL
 vR7uXg1/2IhgS/QdGEBqsfAcMGIZTEJ5tm+cne4b7X792CvbcOIzJ3wK8ISMxwtXV65a
 lR1E7gwOZkPe3kElUm7+dgXnIL2e1tp8zh4SUD7na46Et+33BdLOeBlDmfh93qJ5i385
 /lLA==
X-Gm-Message-State: AOJu0YzNXskN/6bKaYa5lkPzhsaB0LU+Q6UlQ/BCM2OCuGGi+gbJOzzC
 7dmY0m4DQNz5VT6L5fwE4j/sW0EPaZSQEUTCB5TkPjVYwUOrL9WoR9DXbRJEyQ==
X-Gm-Gg: ASbGncsJZtlEqdyrawVjE+UHjTGbO4iJv39AaJwzBcrL5k7Vj1UFk6/ZoHGUR/uKTqk
 qmYim+YCEMYqiz1jPi/jtv9BboqRsfsbsOK2WKGsO63E8//lgt6Cjzp3vZDA54wTQS3hrV+YQSQ
 S6miFd646ryVoCQo7B4enbcAEUoTtud0OsPZ42baIBSkmfi2FkFlTRDEneFRlhpPujOIzjZHNdB
 rsimKLA52xZ6JCYyXjqKgkedxUGTlQQVv9Rf4c/vAC8dljsWPnlqpUv2ZRF9ORbsujMRZ6FvpdE
 A56aI7Fr/duzb0pKPgcnbEdjkaFOGPIWXzen1Jfro0kTVnBqHO37NsQyWiijtC1nXQ/VYOftTUy
 nWoYJoZWsu0LSIf4OtSuCiG0pspRTMBbzCKIjoOc4vrl6iyY1FMbStiZTesCgA6/qoVY=
X-Google-Smtp-Source: AGHT+IGJ43Dtnc88RzA7Q+cI8EGrxx2rdkV506T0e7Cb4gnxSyairFv6cTrghVTaZU2TI1jn5unaSQ==
X-Received: by 2002:a17:903:13ce:b0:234:f6ba:e681 with SMTP id
 d9443c01a7336-23c8606b87emr37720535ad.5.1751627661984; 
 Fri, 04 Jul 2025 04:14:21 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:14:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Charalampos Mitrodimas <charmitro@posteo.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 37/40] target/riscv: Fix MEPC/SEPC bit masking for IALIGN
Date: Fri,  4 Jul 2025 21:12:04 +1000
Message-ID: <20250704111207.591994-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Charalampos Mitrodimas <charmitro@posteo.net>

According to the RISC-V Privileged Architecture specification, the low
bit of MEPC/SEPC must always be zero. When IALIGN=32, the two low bits
must be zero.

This commit fixes the behavior of MEPC/SEPC CSR reads and writes, and
the implicit reads by MRET/SRET instructions to properly mask the
lowest bit(s) based on whether the C extension is enabled:
- When C extension is enabled (IALIGN=16): mask bit 0
- When C extension is disabled (IALIGN=32): mask bits [1:0]

Previously, when vectored mode bits from STVEC (which sets bit 0 for
vectored mode) were written to MEPC, the bits would not be cleared
correctly, causing incorrect behavior on MRET.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2855
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20250703182157.281320-2-charmitro@posteo.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 11 +++++++++++
 target/riscv/csr.c       |  8 ++++----
 target/riscv/op_helper.c |  4 ++--
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9686bb6208..172296f12e 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -158,6 +158,17 @@ static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
     }
 }
 
+static inline target_ulong get_xepc_mask(CPURISCVState *env)
+{
+    /* When IALIGN=32, both low bits must be zero.
+     * When IALIGN=16 (has C extension), only bit 0 must be zero. */
+    if (riscv_has_ext(env, RVC)) {
+        return ~(target_ulong)1;
+    } else {
+        return ~(target_ulong)3;
+    }
+}
+
 #ifndef CONFIG_USER_ONLY
 /* Our implementation of SysemuCPUOps::has_work */
 bool riscv_cpu_has_work(CPUState *cs);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6296ecd1e1..8631be97c5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3129,14 +3129,14 @@ static RISCVException write_mscratch(CPURISCVState *env, int csrno,
 static RISCVException read_mepc(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    *val = env->mepc;
+    *val = env->mepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mepc(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
-    env->mepc = val;
+    env->mepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
@@ -4169,14 +4169,14 @@ static RISCVException write_sscratch(CPURISCVState *env, int csrno,
 static RISCVException read_sepc(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
-    *val = env->sepc;
+    *val = env->sepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_sepc(CPURISCVState *env, int csrno,
                                  target_ulong val, uintptr_t ra)
 {
-    env->sepc = val;
+    env->sepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 557807ba4b..15460bf84b 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -280,7 +280,7 @@ target_ulong helper_sret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong retpc = env->sepc;
+    target_ulong retpc = env->sepc & get_xepc_mask(env);
     if (!riscv_cpu_allow_16bit_insn(&env_archcpu(env)->cfg,
                                     env->priv_ver,
                                     env->misa_ext) && (retpc & 0x3)) {
@@ -391,7 +391,7 @@ static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
 
 target_ulong helper_mret(CPURISCVState *env)
 {
-    target_ulong retpc = env->mepc;
+    target_ulong retpc = env->mepc & get_xepc_mask(env);
     uint64_t mstatus = env->mstatus;
     target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
 
-- 
2.50.0


