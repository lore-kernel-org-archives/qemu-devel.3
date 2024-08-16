Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 17:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf0TP-00079B-KI; Fri, 16 Aug 2024 13:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TN-0006sa-Em
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:45 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sf0TL-0007QG-Gq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 13:10:45 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d3d58d6e08so1249360a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723828242; x=1724433042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FVE9uwE5SGNsSu9ob6L64WLDml4rbiZ/hyx7tyV/IQ=;
 b=lO0yHw0Zx2HgnGb9bPj1j3uJPc5YuM2NOaUF8M+Y3JKualGVX0iuSyZPTxmqLIaFgz
 6vaXruoQNjWHxbrZ3BaU/H3JFQ19jMXcN900PTGUd/KF+a7ZBmeSXD8ie0GBke/ixA5t
 yiyoYDynNZaq40wHokf0Yp4lOwddiTZLui/Eupt8/YAAZUFnlYWxR4tsOUvVap+65m5q
 ESqjBBDqGmXxJ6B5/J9QjYXTEywp271dhJU96UJ5vTTRTY/1qd+0CuROs5WdzWhQzy06
 uJJjhw2akUFRZSNxvjUTGsWRIDqZ1pEzkXAfO5o/viy6X+M/ibH3SQA00ZSKDN4jo4OM
 nnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723828242; x=1724433042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FVE9uwE5SGNsSu9ob6L64WLDml4rbiZ/hyx7tyV/IQ=;
 b=HThDqOpd1ltYtHi6ud4pnMoB/dej3yMRsQ5BtFQ2fRs8y1r6xK3EwJQvsfl5UYQx8C
 xllupwvNgWnsGucE+jqANnbF5CeMHXgqEuhJRIUaMA7uRBgbU2NVASZi3/D/8M0kP2Pg
 q/5a3RIZOiMZr1RB4jozmn5566NKWRowtVcJ5RykDIcyHo0kahCj5M+iWxjtpf+OuGIh
 IwwnzHp0FfmKxBgNZKCHQ82I427XXR7xFJSuW7mM8eyGQ/8qtJsbxZy++koG3a85GFRt
 8nGI1wEgfpRXmN2SqS6Np7HoweGvIXU+DBcKi3gfyBJus+XB3FO8sDjWVsL/TsvAi0pg
 hSpw==
X-Gm-Message-State: AOJu0YzOG3zuwJW33E+IKqGhggnpXmdUL3QI4skCAQe99okdQZ85i/2t
 OaJ4RDHig71yMQyPjg3XrTDkb+q+8V49nAYPmO7KqxFJf4qk9WAuV9p8QL6VI7Q=
X-Google-Smtp-Source: AGHT+IHCdkp83Tf3RAfLPd3k05qhiYDKxUNBopRMx+YMIARDpcjcvtuerIeX6f2Q2SdA7K1xYVEnDg==
X-Received: by 2002:a17:90a:df04:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2d3dffe2e82mr3855566a91.20.1723828241546; 
 Fri, 16 Aug 2024 10:10:41 -0700 (PDT)
Received: from localhost.localdomain (121-45-122-195.tpgi.com.au.
 [121.45.122.195]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3ac7ca33dsm5988407a91.6.2024.08.16.10.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 10:10:41 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 16/17] bsd-user: Implement set_mcontext and
 get_ucontext_sigreturn for RISCV
Date: Sat, 17 Aug 2024 03:09:48 +1000
Message-Id: <20240816170949.238511-17-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816170949.238511-1-itachis@FreeBSD.org>
References: <20240816170949.238511-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=itachis6234@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Corbin <mark@dibsco.co.uk>

Added implementations for 'set_mcontext' and 'get_ucontext_sigreturn'
functions for RISC-V architecture,
Both functions ensure that the CPU state and user context are properly
managed.

Signed-off-by: Mark Corbin <mark@dibsco.co.uk>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Co-authored-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/riscv/signal.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/bsd-user/riscv/signal.c b/bsd-user/riscv/signal.c
index 072ad821d2..10c940cd49 100644
--- a/bsd-user/riscv/signal.c
+++ b/bsd-user/riscv/signal.c
@@ -114,3 +114,57 @@ abi_long get_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
 
     return 0;
 }
+
+/* Compare with set_mcontext() in riscv/riscv/exec_machdep.c */
+abi_long set_mcontext(CPURISCVState *regs, target_mcontext_t *mcp,
+        int srflag)
+{
+
+    regs->gpr[5] = tswap64(mcp->mc_gpregs.gp_t[0]);
+    regs->gpr[6] = tswap64(mcp->mc_gpregs.gp_t[1]);
+    regs->gpr[7] = tswap64(mcp->mc_gpregs.gp_t[2]);
+    regs->gpr[28] = tswap64(mcp->mc_gpregs.gp_t[3]);
+    regs->gpr[29] = tswap64(mcp->mc_gpregs.gp_t[4]);
+    regs->gpr[30] = tswap64(mcp->mc_gpregs.gp_t[5]);
+    regs->gpr[31] = tswap64(mcp->mc_gpregs.gp_t[6]);
+
+    regs->gpr[8] = tswap64(mcp->mc_gpregs.gp_s[0]);
+    regs->gpr[9] = tswap64(mcp->mc_gpregs.gp_s[1]);
+    regs->gpr[18] = tswap64(mcp->mc_gpregs.gp_s[2]);
+    regs->gpr[19] = tswap64(mcp->mc_gpregs.gp_s[3]);
+    regs->gpr[20] = tswap64(mcp->mc_gpregs.gp_s[4]);
+    regs->gpr[21] = tswap64(mcp->mc_gpregs.gp_s[5]);
+    regs->gpr[22] = tswap64(mcp->mc_gpregs.gp_s[6]);
+    regs->gpr[23] = tswap64(mcp->mc_gpregs.gp_s[7]);
+    regs->gpr[24] = tswap64(mcp->mc_gpregs.gp_s[8]);
+    regs->gpr[25] = tswap64(mcp->mc_gpregs.gp_s[9]);
+    regs->gpr[26] = tswap64(mcp->mc_gpregs.gp_s[10]);
+    regs->gpr[27] = tswap64(mcp->mc_gpregs.gp_s[11]);
+
+    regs->gpr[10] = tswap64(mcp->mc_gpregs.gp_a[0]);
+    regs->gpr[11] = tswap64(mcp->mc_gpregs.gp_a[1]);
+    regs->gpr[12] = tswap64(mcp->mc_gpregs.gp_a[2]);
+    regs->gpr[13] = tswap64(mcp->mc_gpregs.gp_a[3]);
+    regs->gpr[14] = tswap64(mcp->mc_gpregs.gp_a[4]);
+    regs->gpr[15] = tswap64(mcp->mc_gpregs.gp_a[5]);
+    regs->gpr[16] = tswap64(mcp->mc_gpregs.gp_a[6]);
+    regs->gpr[17] = tswap64(mcp->mc_gpregs.gp_a[7]);
+
+
+    regs->gpr[1] = tswap64(mcp->mc_gpregs.gp_ra);
+    regs->gpr[2] = tswap64(mcp->mc_gpregs.gp_sp);
+    regs->gpr[3] = tswap64(mcp->mc_gpregs.gp_gp);
+    regs->gpr[4] = tswap64(mcp->mc_gpregs.gp_tp);
+    regs->pc = tswap64(mcp->mc_gpregs.gp_sepc);
+
+    return 0;
+}
+
+/* Compare with sys_sigreturn() in riscv/riscv/machdep.c */
+abi_long get_ucontext_sigreturn(CPURISCVState *regs,
+                        abi_ulong target_sf, abi_ulong *target_uc)
+{
+
+    *target_uc = target_sf;
+    return 0;
+}
-- 
2.34.1


