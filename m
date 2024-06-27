Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C4EC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 10:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMlwK-0004x9-JI; Thu, 27 Jun 2024 06:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwJ-0004x0-BI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMlwH-0001ZX-I3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 06:01:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70670188420so4012391b3a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719482472; x=1720087272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHVdgQ5R0OU4he+m9ZDS4YAng1a0QCz6gz1s5XZ7cf0=;
 b=lTy/a9VmlcBlFNvzWq4EmE4OzcYzzEbtpivONxSuaQJHk4SatoZ22m30uj0GR0nu+H
 yWrtcn9GGsD8QkIwhob8QOy1ZH0zjwDN4GAWNQdDQzMyq2+rOR6lpquRGMuzGKG1bIgA
 YDe5JQ2LNDA3F9ThzA/HarZnElm3FSCId57TPhGZySnn8YaKVnAzaipuU8mYL5q2D0c/
 PTfdI/ceHcUNT9PK0R4+cB5y9wyyIikgknOgZB9WKIEoFifBcS6XhhHpplzK3PiZ0Qap
 gf34+L3k4BsQzEs6h86EnuIX9HbaIbjst0p0FfD+HWQeYx3Av7mpvSOW5DovDi/JgHkL
 dacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719482472; x=1720087272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHVdgQ5R0OU4he+m9ZDS4YAng1a0QCz6gz1s5XZ7cf0=;
 b=HiD0vNRjFd+g2MYq4JWe6q0lF8ToswYbWLIBSmKIcP7PiFngoN2RiQloIbSbFGk+a0
 T+ErfAYIgD9k/Savbr2lP9ejaMD2c/kUswaWtAtRtgjPitlkL+bbW44dvrHzbcDB0IAh
 P+HvTV6E0sI8pRbE+nm26pKVQoboAapgfqI/SivPqbD7r+gz0Gfwc/jLgsoEMor53LTr
 soV8WZdVcLJkKip/EFPDT2lpcj4PPZZ+FiNTX72NKj8HypgjyeJWbh15/+gpXIA9hw55
 OSh8ceBuRK9xutrlw6RAlIGPAq85Cyv1pRBuTQgDMYkIqSfrHJcORd5ObBMnjtdQAlyO
 U+3g==
X-Gm-Message-State: AOJu0YwubU/cBKO17QpZN+D7bibstaJxJikWx2rQKhaM9J9Oi37FtBgv
 OkmSXYZlJR5tGvLZl4PHspHb3SqDS0SphOBmeNX568WFGitAPCOrk419PF7N
X-Google-Smtp-Source: AGHT+IEIjTxOTZ+8LPGC1VoXdY16gbAcuKdNKVBV//ifj0meDne7H76OnSlgkcV4ntsvAMZi4s3mXA==
X-Received: by 2002:a05:6a00:9290:b0:706:636a:21e1 with SMTP id
 d2e1a72fcca58-7066e4e6832mr19253105b3a.6.1719482471690; 
 Thu, 27 Jun 2024 03:01:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706b4a07326sm932431b3a.111.2024.06.27.03.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 03:01:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 02/32] target/riscv: Move Guest irqs out of the core local irqs
 range.
Date: Thu, 27 Jun 2024 20:00:23 +1000
Message-ID: <20240627100053.150937-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627100053.150937-1-alistair.francis@wdc.com>
References: <20240627100053.150937-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Qemu maps IRQs 0:15 for core interrupts and 16 onward for
guest interrupts which are later translated to hgiep in
`riscv_cpu_set_irq()` function.

With virtual IRQ support added, software now can fully
use the whole local interrupt range without any actual
hardware attached.

This change moves the guest interrupt range after the
core local interrupt range to avoid clash.

Fixes: 1697837ed9 ("target/riscv: Add M-mode virtual interrupt and IRQ filtering support.")
Fixes: 40336d5b1d ("target/riscv: Add HS-mode virtual interrupt and IRQ filtering support.")

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240520125157.311503-3-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 3 ++-
 target/riscv/csr.c      | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 74318a925c..a470fda9be 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -695,7 +695,8 @@ typedef enum RISCVException {
 #define IRQ_M_EXT                          11
 #define IRQ_S_GEXT                         12
 #define IRQ_PMU_OVF                        13
-#define IRQ_LOCAL_MAX                      16
+#define IRQ_LOCAL_MAX                      64
+/* -1 is due to bit zero of hgeip and hgeie being ROZ. */
 #define IRQ_LOCAL_GUEST_MAX                (TARGET_LONG_BITS - 1)
 
 /* mip masks */
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dd89edb06a..ee33019b03 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1145,7 +1145,14 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 
 #define VSTOPI_NUM_SRCS 5
 
-#define LOCAL_INTERRUPTS (~0x1FFF)
+/*
+ * All core local interrupts except the fixed ones 0:12. This macro is for
+ * virtual interrupts logic so please don't change this to avoid messing up
+ * the whole support, For reference see AIA spec: `5.3 Interrupt filtering and
+ * virtual interrupts for supervisor level` and `6.3.2 Virtual interrupts for
+ * VS level`.
+ */
+#define LOCAL_INTERRUPTS   (~0x1FFFULL)
 
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
-- 
2.45.2


