Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA0CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQht-0001v3-0N; Tue, 16 Jun 2026 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhd-0001cX-Gb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:30 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhb-0003T7-QH
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:29 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so2907950a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604446; x=1782209246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kslYU5AYmj7thTXYRZ+gLiZ7/V0BzViJNUN2iFTUqIw=;
 b=cFZLAc+ti2VvszoexjzdENul26DhcUCXXCvd5boJjddxg6oF+r0LAGo/v3zZeBG0tQ
 QOPR5koYdY82OIPkTUUdGAtTTOhf3A0MaZkz4xnMuW9F0LNxyNas5qVMO2263fh3zXu3
 Tpq/r2I+2vFFrQPh9bOFZj9Jwk7mZfS/PDYkbRC59vgMbEtnYuUOm5duUWOIDSxrveGW
 r6S3jEW/w/2YxCrOKIsGe43nup2Quthc6R7n1uHHv9E8Sh/JInREgBrswKosfnffrR57
 gBdr1Pz7syMTpILXGu8gin88JDkxsQn4XMlDaGu+d6GbgV95usCM4m/tPNqVzKGFypN6
 fALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604446; x=1782209246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kslYU5AYmj7thTXYRZ+gLiZ7/V0BzViJNUN2iFTUqIw=;
 b=VLLGmPaZdGwsFKMiJwBmBPtkYQpXT1cdvIAoqgDOPvcAZNU3GL0KUnjvjKqwlhGGFN
 76rtd4f81vNhM16m+u2EkyebADp4C220P1ypCjdZMueP148hGOSTP3hUHiv2x/lW+Zt3
 JAN3Deq9nuxT2f5I5h8avKhZnIlyLEJymKsYYh8iHx/KADi6ISmxk328AiSwgUDa7Za8
 IznTfQNuPJZJqGAQ3bbad5CQKjhK3IQvhoMkS/ZakdelPgGGUfMGDI9u5s5CPyz9qYjg
 hyY32AqVqBRakpoTwKOcTgh3tQt+mRjXZVecl7jZp/z3248CUkbA7s/xH+Tm0ABXBtCx
 i7+A==
X-Gm-Message-State: AOJu0YzHIn3Lr7SZ7CdG0FayF5lDI+XmYE0eeiVJ6WZwIJ+hzGOp88OA
 3lqYo8r95ALw4Njs/wmNNPesI54u/HeDOGu95Ot4WwbAfZLldy8zz/Ys62gpVw7i
X-Gm-Gg: Acq92OF3XQ3rpkcEuKRujX6hiPEd+gQ62EDqs92zaME1VsU3Q23X7EbTy1TOySLIjkk
 2pcnTvTriW/GG62EF+xFVQszcYjIlOCLrtPBcVjSNKETXbIjLpEoPXxRFB7izeJ/RfqVWpOs6fM
 DgcJccCz/ovTxWiIrSNJn9XeiMp5aIWV+yEklrUQ9OcbUvtv80j/w1sbGA20eX8U+b+vnee+aak
 6icFWqsGJci1fx6Vwx2h6ZQltCKrcpJHk/v06fPS3b2nZBP47WkpCi4C5sZogxArnINqRCVdNKF
 l1ULNXwZe4xaNh0IS6+JXmV5eewk/uNo2AipNJ3Q94pThbs01Yw694SntvuWbCEcgmnY1JzUOec
 ZAcuZi8+Y7KhmpW9QyHOvjy/CjnMpTpkXtwXx1xDOzY9lrmqngfUqtgnAGfhbZHTetW3b2RoZUw
 bA0AtbVmHfLn453ORP5JyWR8J7fDHYYC+rmhC1uf1k
X-Received: by 2002:a17:90a:d60e:b0:36a:1ed8:6fe6 with SMTP id
 98e67ed59e1d1-37c2bd52996mr14481707a91.24.1781604446463; 
 Tue, 16 Jun 2026 03:07:26 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/83] target/riscv: Fix size of mseccfg
Date: Tue, 16 Jun 2026 20:04:35 +1000
Message-ID: <20260616100527.1939565-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

mseccfg is defined in version 20250508 of the privileged specification
to be 64 bits in size.  Update relevant function arguments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-22-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 2 +-
 target/riscv/pmp.h     | 4 ++--
 target/riscv/machine.c | 2 +-
 target/riscv/pmp.c     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 45dc0393f9..8726929bd3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -465,7 +465,7 @@ struct CPUArchState {
 
     /* physical memory protection */
     pmp_table_t pmp_state;
-    target_ulong mseccfg;
+    uint64_t mseccfg;
 
     /* trigger module */
     uint16_t mcontext;
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 17307ef88a..91130289d8 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -71,8 +71,8 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
                       target_ulong val);
 target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val);
-target_ulong mseccfg_csr_read(CPURISCVState *env);
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
+uint64_t mseccfg_csr_read(CPURISCVState *env);
 
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 78ca607b48..dad45f10c3 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -439,7 +439,7 @@ static const VMStateDescription vmstate_mseccfg = {
     .minimum_version_id = 1,
     .needed = mseccfg_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
+        VMSTATE_UINT64(env.mseccfg, RISCVCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 58a8923d0d..211f5b3862 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -667,7 +667,7 @@ target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 /*
  * Handle a write to a mseccfg CSR
  */
-void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
+void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
 {
     int i;
     uint64_t mask = MSECCFG_MMWP | MSECCFG_MML;
@@ -713,7 +713,7 @@ void mseccfg_csr_write(CPURISCVState *env, target_ulong val)
 /*
  * Handle a read from a mseccfg CSR
  */
-target_ulong mseccfg_csr_read(CPURISCVState *env)
+uint64_t mseccfg_csr_read(CPURISCVState *env)
 {
     trace_mseccfg_csr_read(env->mhartid, env->mseccfg);
     return env->mseccfg;
-- 
2.54.0


