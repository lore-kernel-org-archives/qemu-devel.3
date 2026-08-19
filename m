Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE5C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgmb-00018D-AX; Wed, 19 Aug 2026 09:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <0xjnml@gmail.com>) id 1wwgHR-0001B6-Sd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:24:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <0xjnml@gmail.com>) id 1wwgHQ-0006dz-99
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:24:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-495590dde14so12539255e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787145870; x=1787750670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r0yqxzYzQ0zmWd95bT86DD4zanMt2XBYkGq36xeoR8M=;
 b=sO2BdwCbhDvroG7SGgcYMCYPg5o2jEx9kX5guTbUV0f+LYDtRwTcm0UdSHhrGjV97+
 YY5CtBxtOA0QLfwfog2n+VsC9WQVnM6xggnb9Ui5G/riNZ974vlzWTtUBVBMvSCUWAcd
 OzOXVjDm6kGCahCZcIsmyfi7N8yZ7762ZiAmIMLDH+1mq1oG8mRUbzdf+ekQtj9M60XQ
 c9UWAsh9hsFaPQaTAHxzvU1Gd8V9TIBU/wugUMn7C0Rm2LWdX8mfk+vfAfgz+bsUC88j
 4KzeF5SWmvgzHf51zfF2VnzCk2FdHw8upMzKK2Atombpkq4HPYLAxUmZnE8tz3RVMm6S
 98hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145870; x=1787750670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r0yqxzYzQ0zmWd95bT86DD4zanMt2XBYkGq36xeoR8M=;
 b=pPNfTCm7O1KEJVashh9q6zmUfgLEWdAhLxRyt4BffvaAco5yKXgCIfBXfFAWwL10s5
 CyweRQFHHMs8fGWYXpTybB0X6lNCcQuZSmGevrG4zxG6aRCZStrzJ9aDJa/fWJUyrA+6
 NcaX07ig32Q0MBu1LjhuCzwoFP9M8F2rkFE3fopGGAW1qfa1q0RUwOgQ4x6UvRjNpv0w
 r+h18Xor9q1hLNZcKtDHAhbGXHz9VDvtohk+hDoBUY9/WBCqvakqpCVisKcyPdTg4LIm
 EPwbqh/C0udOz6ky/XH7S4f8VlH3PiOFMIlZvlNWzfAI8oMsYOdgoywWr64UgXgEtlMX
 /Yfg==
X-Gm-Message-State: AOJu0Yzmx8LmPO4WFbaW48F1I2HxaRdgRAiHsOI8tcZ/bhilPcopaSjx
 LYDtUTwA96AcR4TH6f+2j0+57srXz53VBoWRuZJR5djuWKLxF8B9RCAR75EJNw==
X-Gm-Gg: AR+sD11oO8tT5faJNfmjoGV6K43IFeN3t9xaXKfR0wFphT4NNHJwrR3ny3oJw/Crn/a
 rKHTkQ6qivDM+/f99LAjy3iXKv6h9qsvKOPdvcfdouovRwGxj9aOa4uZgyBbKsbwT+K2gS2urL1
 xvE2f7Ow63fDudbnIICUo+yPW3tSFSf63KnpTixYQPeBBuy6a+t3ONANrsz2qtcWlrn8xSxsICg
 oetXKL/T/849vJkpcVMjONrBoFcgawfs/cdzSu8xtGI2FKgm+AGgITufeFhl0a2LpMr9XxzleYP
 e1rSpMQ+vdDQW/uJQkbY6KwaxKkhUjsWLCZsJYusWzUCqztWBt7D77etHedl0EsuJxL4zGkbKr+
 FKrliiR06SncxVdxWXfPbfDDqC5coGCa+S8UQpfVh3R9kHZo+suI60xsmzESnd5E2Gjhb1H/WN3
 2m4tiFbWDQx3m+JI5a/2tAMHoplRYmdmaw1i6mPKRk/xXuA42KDIhOsXnIx0zLtsNLPCQd24yG5
 AUM2eHyuetKLhTJRcR8pzwGdeFvQLU+xK5tRHHTpGpnlmXF8fdObGL9rl4R5nrt9U/5dq9fcl6L
 74P6mDluzYDhN8Wjz4Vw2w1Q/vRyj5Nf/Gim5o40wpE/XJLPiM0BkVexRYuC+Y5hmrYmQ5UjOTn
 qO9RZ8H077Uoo7fM2Gd0=
X-Received: by 2002:a05:600c:3487:b0:499:53c4:1daa with SMTP id
 5b1f17b1804b1-499aa1c2764mr95666135e9.15.1787145869419; 
 Wed, 19 Aug 2026 06:24:29 -0700 (PDT)
Received: from 3900x.local (dslb-188-102-122-219.188.102.pools.vodafone-ip.de.
 [188.102.122.219]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d055dsm5669642f8f.34.2026.08.19.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:24:28 -0700 (PDT)
From: Jan Mercl <0xjnml@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Jan Mercl <0xjnml@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] target/loongarch: check FPE before reading fcc in bceqz/bcnez
Date: Wed, 19 Aug 2026 15:24:22 +0200
Message-ID: <20260819132422.5164-1-0xjnml@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=0xjnml@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.711, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 09:56:43 -0400
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

gen_cz_bc() loads env->cf[cj] without CHECK_FPE, unlike every other
translator that touches an fcc register (trans_fcmp.c.inc and
trans_fmov.c.inc, for movcf2gr/movgr2cf/movcf2fr/movfr2cf/fsel).

A guest that manages the FPU lazily -- Linux clears CSR.EUEN.FPE in
lose_fpu() on every context switch -- relies on the next fcc access
raising a Floating-Point-Disabled exception so the kernel can restore
that task's fcc.  Because bceqz and bcnez never raise it, they branch on
the condition flag left behind by whichever task last owned the FPU.

Real Loongson hardware does raise the exception, so this is TCG-only.
It surfaces as Go binaries dying at startup in runtime.check() with
"fatal error: float64nan1" -- roughly one process start in a thousand
once the guest has more runnable tasks than vCPUs -- and in general as a
conditional branch silently taking the wrong path.

With four tasks each executing 5M bcnez on a 2-vCPU guest, master
mispredicts 89 of 20000000.  With this patch, 0 of 100000000 over five
runs; a Loongson-3C5000 is likewise 0 of 600000000.

CHECK_FPE is defined in trans_farith.c.inc, which translate.c includes
before trans_branch.c.inc, so it is already in scope.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4209
Cc: qemu-stable@nongnu.org
Signed-off-by: Jan Mercl <0xjnml@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_branch.c.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
index f94c1f3..da07778 100644
--- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
@@ -66,6 +66,8 @@ static bool gen_cz_bc(DisasContext *ctx, arg_c_offs *a, TCGCond cond)
     TCGv src1 = tcg_temp_new();
     TCGv src2 = tcg_constant_tl(0);
 
+    CHECK_FPE;
+
     tcg_gen_ld8u_tl(src1, tcg_env,
                     offsetof(CPULoongArchState, cf[a->cj]));
     gen_bc(ctx, src1, src2, a->offs, cond);
-- 
2.47.3


