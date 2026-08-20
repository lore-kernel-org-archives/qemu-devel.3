Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE16BC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlS-0006nz-6u; Wed, 19 Aug 2026 23:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlQ-0006kK-JC
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlP-0004Op-7E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so1519963a91.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197702; x=1787802502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZV9gDbx+A65MEMcmH9Ce0cuAUaddw6IKp5G5U1reZI=;
 b=aEzMW5rJylZtcGkz9i/vjl8jsiFO9MMoWhtiVKrX8i/drtpk9qtGh3aKxq1v/twHVr
 HCgsd403U0QON072VGqvFZ7FqqfNb7Nf2zHrc2vMdplSgEIVw/dN8xvaL9Rblso6Pw4n
 TrpOTtyJcsxVUhFdSe+LwNZL8/bTmGtsKUH/BdIRELBMarx18a9siVxSofTAL+Lkuvg4
 dD239440tNG+tvj0xG/H8gHhtME2JGPMEk4aY6xmYyWWhwMhJClqsOIK0ovooMU/hIiy
 Z8FGCED/CG+6iX4XlubaKW8yDU/TesrFC2FnBRx2QOmyf9NOw9EfYS3K0Ol3AVM19Ib9
 JAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197702; x=1787802502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZV9gDbx+A65MEMcmH9Ce0cuAUaddw6IKp5G5U1reZI=;
 b=Y2eCQhJetlHG1hNjr5N+aeGHzKK88//NKRlTzTeq37FeK58vFGfhyomuRk0rKay9r+
 GOjDSEvqYHQqnfTlPuN4qQIbXgDQJPXU7JTdn8dKVBNwGFQUIket7JYPYQDkBRkW6Klo
 S5tXVQDaxPii8GCzJS1aXb4C+ag1pT+r/IkDIMAAG4yKZswVlJ5+xb6IEqgGnEeqYUTv
 9pUjlmWmqrlire4W4Et4cyRCs2vtfuFAfi4s2NHeKsdXK1wIxquKKf9fQPaZKoHM5+9e
 IJ9qrf/mU1gZtUPIXlDq+69VQPnKR32ZehIj554wIqAjxKLqsXFMGNTtGm1L+cYiETz5
 VY8A==
X-Gm-Message-State: AFuF++lMJWz8KPwPeVKkj1ne9MYsx33yXFngh/9Gu1n+FFOttu21hUdM
 HwqiPGqoRqYgjdNvC9UEK7+c1j92pHUKOE78egZo0IiE3tkioTCzIxXXL4wLPw==
X-Gm-Gg: AR+sD10JOujtQwG/JOI8f+MKJE4FFwrkO2g6IcVBGctLsuWAwZ408Jat+8/dpNHKwAB
 wOi+FLEJXNmFsd9L1u7dYYT9sfbOducYmX8DuYXMEYsNfVJsLU57iz8t+aglyOiIY49CwF/DL2I
 1pqs2zM8iBfqKQfM2mrkXfw5O/GUekN2JJJbc6s55eeS60U1gQ9NrlmA8ay4sTdEuQsPqFcGSnO
 N+dLG5aeKWMD5AzrR3igh8YMmNG5HsJrnchqvJ8MAWYqQ+p7U9YwlRwGbZ70EUJcfuUq8iTH4qk
 mOKjrK/QNYbx/FpeSs3s0jd9INdwRgGeMhLf0gN0/IQJ7cIvp2vfIDoR10HQU6H253PjO+X95wf
 rDUW+ExZYovsJF/SUQLhWgBDhi1vyS4kYgLpsCN4Jd6BkjKjr4Tm2uhlv/43ReQeuE/lcTVcMZa
 Zp/mqeXV8Nhg+7NSROY6J8Ta2jU8JYMc/H3XsMJKTvLuJc6r9b6RE7EeQUCHQJLRbiFUJo7uBU3
 KjRTA==
X-Received: by 2002:a17:90b:3910:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-39581088755mr18035634a91.11.1787197701844; 
 Wed, 19 Aug 2026 20:48:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:21 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 76/93] disas/riscv: Fix typo in th.lbib format
Date: Thu, 20 Aug 2026 13:44:13 +1000
Message-ID: <20260820034430.1186695-77-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

th.lbib should format the same as th.lbia, and the other
increment insns, with the address register in parenthesis.

Cc: qemu-stable@nongnu.org
Fixes: 318df7238b9 ("disas/riscv: Add support for XThead* instructions")
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-41-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv-xthead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv-xthead.c b/disas/riscv-xthead.c
index 428a6380e9..fbc96631fd 100644
--- a/disas/riscv-xthead.c
+++ b/disas/riscv-xthead.c
@@ -189,7 +189,7 @@ static const rv_opcode_data xthead_opcode_data[] = {
     { "th.mulsh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
     /* XTheadMemIdx */
     { "th.lbia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml },
+    { "th.lbib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lbuib", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
     { "th.lhia", rv_codec_r2_imm2_imm5, rv_fmt_rd_rs1_immh_imml_addr },
-- 
2.54.0


