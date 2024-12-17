Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B13BE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOV-0006BB-PJ; Tue, 17 Dec 2024 03:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOS-00068B-HN; Tue, 17 Dec 2024 03:57:28 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTON-00006c-Bm; Tue, 17 Dec 2024 03:57:28 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53e3a5fa6aaso6363276e87.0; 
 Tue, 17 Dec 2024 00:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425841; x=1735030641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqqiYI1N5oBwLuCt7KegYLbkIlLmIwIkklCNAXBzFm8=;
 b=fyJYVz62MkMBYSrHjL8szPjbGZC+yug5eAgAL0Cg3cUX23s3CN9PCAg4WZj+Ilgg+M
 pGhLq6NGMo9WgzZSfCVPypDQVs5E9SAuE9Yig1XLz5r3DSyaKgxjBgQX2tQ3iMVGYec9
 /chac+xt7FAbmT2bT8Nppx0YBlryQD+RVvuaXllPq4at1o6fXZ1uZxM9bkYbYZXANlrX
 7LXF/DSMT1C+N7X0pzJdddFFM2AIj3nzQfsPShuubFfP3VaxvS89uWpZYQpQ8OB4D5Lz
 yC133V8V8DDvQnx6lVNDYqLUYvNkMZf2MEKkcB0EnIgYh45pMnNgkKu+6NC1Oo4QNdER
 Cf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425841; x=1735030641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqqiYI1N5oBwLuCt7KegYLbkIlLmIwIkklCNAXBzFm8=;
 b=EsX+pghP6WuIB3ByjBoe/M5lGOfNtuLKURBkIj86oZtN62TI+3rGRj33NUdM3eJ5mb
 J4D9HZ2IfX/H7ag54Uo9ATmpmd6h94c6ug00IDNzqB80cm4b0FtjpPweniDR9L1t3Bs8
 ia4iRXJQRHlAzS0+wLGBO7Ai1MnS0yT9fKGQ576r1oWi0MVWKT9YMTtn1M5QX9/BN6hq
 RbTLEAei9081x1BPAFGuiDeCCLXqkZ64NHborCOtJFgK63FY/RNNUydJZln+IxeMi/v5
 rfMWK7D5JtvU/A41qDAjXAMnhNrRr2G6NrNp/v0lio6FiL9K8maunGHcoAXPEd4gJ5as
 e2vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVXd4Ci9STkkLuONkttGU7d4CLj3X8B8QZKmskvY70V+A6oBrmKrv9XFCNwAAm+3tEAXxSRc9gtFyNvg==@nongnu.org,
 AJvYcCWhBRtS4LS+pnMAIp6y1yNPOB0UdosySaboZZWMT2iEa/eB4+cigl+3/gvc+cd/zNyxxi47cDV7Iv7z@nongnu.org
X-Gm-Message-State: AOJu0Yy+SYyGIAVH5lEbFzXuI1YmDb+8A1CkR6yvjz30ui8I5i6/JUjW
 pxmXspSG0+v05hrFdOzaf9RhoeoYnTX6EbEVjC6gOOhosVK2rVrE
X-Gm-Gg: ASbGnctMVt2a6j8I+Or7pmJW5f/tmKUJbFCSBLmZhJ66yiKqr/v+/4Or+RMc0ulY1Ea
 +6Eb1nghPRkFiVqj3Ev6M2LqR+W7kOBPb3KP67S0knofgNuRBTU0xBiD3VIjCwDjJNbBxA9B4Wc
 x6yEIszLLG+hnsw6qBACy8H9chUL33wN7AmQ7yk7iilhp920ewKR8g0b6WcNQWR+6Eombx7tp0p
 1cj1rajRqKI7t83IDfqxZQ5R5eE4pJDxEaoOD3+k7sKsgpma8iwyuRb2aKL
X-Google-Smtp-Source: AGHT+IHUo53k8pR7zxcbJoOKplBMk5P0YqTTUkqvnsBT/eRFu4TgSg8DbJtJ3NbWfyTHhkLpE7WTfQ==
X-Received: by 2002:a05:6512:4013:b0:53e:3852:999c with SMTP id
 2adb3069b0e04-54131571282mr668479e87.12.1734425840554; 
 Tue, 17 Dec 2024 00:57:20 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:19 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 4/7] target/riscv: Add pointer masking tb flags
Date: Tue, 17 Dec 2024 11:57:06 +0300
Message-Id: <20241217085709.679823-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e7f346ff6b..38231fe21e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -631,6 +631,9 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 26, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 27, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 29, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7d149dfb33..30fa475c0f 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -126,6 +126,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
@@ -210,6 +211,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 018be5504f..bb92f36ba1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -102,6 +102,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_xl;
+    bool addr_signed;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -1230,6 +1233,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
+    ctx->addr_xl = 0;
+    ctx->addr_signed = false;
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
-- 
2.39.5


