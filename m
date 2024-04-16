Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBA6C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 23:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwrrG-00034S-8X; Tue, 16 Apr 2024 19:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrrE-00033g-57
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rwrrB-0007Py-FI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 19:04:55 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so4478492b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713308692; x=1713913492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7toiwGiMFJ8d0S7eID2dFSemOPb731HeAM6DXT2dsY=;
 b=Kdu0BPjvbxVgaqrO5RmSpqLrDlzweTnzxk6XQ9mEIofUx+oNBllCfzOBxje4ZU3g2e
 5j7rPg83lsy9laaryd7t89BvyxjpUkV4QEnGTkeKq2s++Ht9OzxZHsVDp8V27WNCSoFv
 iFbbp+/FmtFtq1KF+TWbBPTZYAwCb8OkFKQajsm0NxYQ+6gjf1pXlCX5bo3CXfuErdIn
 /IrZzqmHB1h7JPb7M/wahsCa6jUdevsKbRalB5bGe4kKW9/3W2UiKWwZ2KgjFwG2DXdJ
 yYc6pKezfPPjz2Csq5MioIQxg91edlZQq3fZPShx9Hk6vMm9xZHMX5RNSs7iCI4sb98F
 m5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713308692; x=1713913492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7toiwGiMFJ8d0S7eID2dFSemOPb731HeAM6DXT2dsY=;
 b=WEoSr46tM9kVexv2CRcKxeebgjbEHpNsbdGfzFO/3VieB8rb1RUytukCrpuZeXyuC7
 2lRBVg7kiSND5tu25FgEf1mtEIt9D88WyTQAief+qfhslb6AqQZ0X8DscphtveU23B6m
 W5J/akRo9xr7STpw69jMuIJbfCGRA2gWeAQw7+eCWeAmzT2tJVaTFIDAgPamqjMkLxFd
 vxHQ9OuHTFdu53gbWsdMkTYqcpY4DyVEVAZE/Yf4Sw8MsKKE+Xbfg5BTW2RB6UMAyJzF
 Li9J8xoJ6WR8xjusuixnw9Mwnnl/RnqpoN4xZF8BgJB5kEyLODAetC0/ftJhmKdUPWdf
 uPtQ==
X-Gm-Message-State: AOJu0YzEVfnUevWmU0Pps2GiX5+s5FCyzLt7Ju7weDqfY1PlQdrtCYvi
 Wun8mnDn5kiYeg9pvNjan4+Jou5RO//Xt9+eJM8McbRz+UR+eZksTqr4vnb7bPJFJkCpWhSl9Xu
 A
X-Google-Smtp-Source: AGHT+IHpam/HBLJmBOioxukgZ3F5MlNnSsMX7hH5WAG90QLBd3qr5H26reLoYwhJrK79vYYCnd0gfg==
X-Received: by 2002:a05:6a21:328d:b0:1a9:694b:e1f with SMTP id
 yt13-20020a056a21328d00b001a9694b0e1fmr19706081pzb.2.1713308691833; 
 Tue, 16 Apr 2024 16:04:51 -0700 (PDT)
Received: from grind.. ([177.45.186.202]) by smtp.gmail.com with ESMTPSA id
 g10-20020a63374a000000b005e4666261besm9399555pgn.50.2024.04.16.16.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 16:04:51 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.1 v3 2/2] trans_privileged.c.inc: set (m|s)tval on
 ebreak breakpoint
Date: Tue, 16 Apr 2024 20:04:37 -0300
Message-ID: <20240416230437.1869024-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
References: <20240416230437.1869024-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Privileged spec section 4.1.9 mentions:

"When a trap is taken into S-mode, stval is written with
exception-specific information to assist software in handling the trap.
(...)

If stval is written with a nonzero value when a breakpoint,
address-misaligned, access-fault, or page-fault exception occurs on an
instruction fetch, load, or store, then stval will contain the faulting
virtual address."

A similar text is found for mtval in section 3.1.16.

Setting mtval/stval in this scenario is optional, but some softwares read
these regs when handling ebreaks.

Write 'badaddr' in all ebreak breakpoints to write the appropriate
'tval' during riscv_do_cpu_interrrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_privileged.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 620ab54eb0..bc5263a4e0 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -62,6 +62,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     if (pre == 0x01f01013 && ebreak == 0x00100073 && post == 0x40705013) {
         generate_exception(ctx, RISCV_EXCP_SEMIHOST);
     } else {
+        tcg_gen_st_tl(tcg_constant_tl(ebreak_addr), tcg_env,
+                      offsetof(CPURISCVState, badaddr));
         generate_exception(ctx, RISCV_EXCP_BREAKPOINT);
     }
     return true;
-- 
2.44.0


