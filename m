Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549BEC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBG-0005ux-Kf; Sun, 09 Aug 2026 18:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBE-0005se-GC
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:44 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBB-00082r-AG
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:44 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-381b831d535so1581363a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315180; x=1786919980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Cjtp0kSC2EC9ntVOyIYKDIN43KY5qOuxwt7Sk7NLWA=;
 b=ZKQxw7zzsg+IwVH/0o/7oc2vdIIWDlMVWtw1TpfjcMZipfiqn2MFvvehWcGdOknK1F
 eGj/1KLj1rK3PDGbQ5H+ut/SXNL2/eZ/wNrrtKeQ+Jlu6EqdYEuDmUT0O/HaqvC1jZZg
 SDLHJBGcks4Gqldj5PEjac04yoO3AhePJgifF+9wOO/XjqTT0ZeAU7qXbbeDzgeuxclv
 bto/4zlyPIDH0aQXGhSJOFrbrfIezllZDolLxrRKh4OohjoXtv2NIboPLyXOcxxD0t6B
 jCKblmmp+rSlyf0SRPD7rtRb3OS0Hg9Zuq1v1jLf1RWgWm03iHQuc8nbM7cLmIJiKUER
 DZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315180; x=1786919980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Cjtp0kSC2EC9ntVOyIYKDIN43KY5qOuxwt7Sk7NLWA=;
 b=WP3fi7tURb/7WPp88jutfZlKxswRaob1hPLt1Kxj1aUx375zFc4hkO2vsB554RZhCM
 gzQHgfMaSB8LACbnrQ9/7yElMlpBgV7eKOn/Oh9Ih0jPIE2vrzMRht3v/ePJKkmKkV3j
 StgkUhdi9xIdHbXAMEvlqbHT8uGE2SjtI+m2oELay2UsdN/C1//Dj1GQ63nBd7h9Ivzs
 JOgBP4qtM1ribNy4x8hkSiwsaeQJ+Zm3yb+dvtjd7+CRBaf7EcT3M/vllxm17suZxJ46
 yBnamRviaes6dwjTy1uVuu/NZ0pfWi0apVnQEVmZjPc+rsqNAPXSK1K6Nu6R4FB0y5xH
 kdtA==
X-Gm-Message-State: AOJu0YzkXWN6c03rWfOicc23TkGvOcaYPjbrzU+sZGbSws+BiMLwocbc
 YEsOAEokLuGnTbiw6KoI7UGqdi6eHZtxFYYxk7ig3H+rD/yemBzW3FuKs9LJSYKEOH+cfcheVcO
 CbmUU
X-Gm-Gg: AR+sD13amTeZmQCmzF6EFF2rjwYfzdd2dxUgrfcUTQYXdrewDDL9vs1ldXl+3RJWfJy
 mVCIkm1H6Qap0BxBVD0Nd2b5gl1NX6EvWgK69nSoDj0JSalKCy3mG6r03WLZ+SATzYLzGs/gSxM
 K+3D7q70WXMEZbn9OrakN+NLTClBaJ6KR2qEdaVcTgybUnywu9+Zzs8nkkRoGZjxwotbLOAcGCF
 OiEPHEBeL1UOu4XfNrfwaDmevtwtfHtJWiZ8zTHGKSw87dv/BEOBX5MLRTEElAr6DZzqZPqN4KB
 UJcnneF1Wd3SmYcU1Dlz9Uy4It2GML7pLdyZz7lFo558a5RZPuQUkyQ4OK6hfZGy7yDRrBjerGW
 ymaG25mmKEsscivOijfI5v5xpWYEpE5jKc12MH8EJQ1tkKp/7sGhm3LjtCPsJTRkWyn5PFPsAM8
 tI/5h+3oWdrmbrDjkVVz76MWUEd0/DShq9Q52/Stf/zy/pHYhC8YuZ5ut8YxDuy7Qb1lPyzNGIo
 MowGmmmZYi/A1Jx5c7a
X-Received: by 2002:a17:90b:590d:b0:38f:5801:cd76 with SMTP id
 98e67ed59e1d1-39261f71c4cmr21641790a91.3.1786315179908; 
 Sun, 09 Aug 2026 15:39:39 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH 44/56] disas/riscv: Fix typo in th.lbib format
Date: Sun,  9 Aug 2026 15:35:33 -0700
Message-ID: <20260809223545.730664-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

th.lbib should format the same as th.lbia, and the other
increment insns, with the address register in parenthesis.

Cc: qemu-stable@nongnu.org
Fixes: 318df7238b9 ("disas/riscv: Add support for XThead* instructions")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


