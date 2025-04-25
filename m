Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD4C369D3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 16:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8MGn-0006Ty-Qi; Fri, 25 Apr 2025 12:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8MGV-0006Md-D0
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:51:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8MGR-0006xe-GQ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 12:51:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2243803b776so43324145ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745599858; x=1746204658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/lEkwr44G1EnW5u3PsDr2ks/Ob649k5jZV75azPxp0=;
 b=nNifGbvM0CbXiGz7M8BqjbtNMY7Hj3s7D2syeyVii3S9qy5+wsPUpyqG0NT8i71Ttk
 1k3h3mQSTTJhrktcpDBn9AeDvW1DpstHjwID6LJ3fKVNIZ8zKTAe2NUYUSlMqQGNqNad
 +4K972r4iSYDGQBqZpe41gZBLvE0dLpFOifvE1pNycFPVgqy0Av6pWUtCCCbSe04CwPS
 +wh9iVVYEvYzL702V7Ql3HW76RGMbegAjyPzBoLaTf555Ma4GMp0/79DJs8rqsh1Zkyd
 twGnwpZPyohkf/3Hx7ZTV+3BaXYELf0zq9oC6cJJrpP2H8ELg//CfooRZLoJevhtU10N
 LcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745599858; x=1746204658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/lEkwr44G1EnW5u3PsDr2ks/Ob649k5jZV75azPxp0=;
 b=qppTyKBPfT0fEufPGGUVAyouwvR7s6LT2nC/eXfuV7lAY8owsftOiWXVlcPgHK5ISG
 VScykoeiCDzxPGiT77tSBsl5RMjGWVwP0liGSeEj8skOmYmX4DPhQuU5UebB7v8/tIxK
 oNdWKffdDUNlo9w6JchC37zoqxshRakipMS5JGjatFEcLobiEgT3QAQUqTKMzpGJGDb+
 fuBNtvLs6qEiLAhMN5ipvtUmRUKKNhX3KoQWZ2F8JqsZfJQ2c7jNYrbSNbI6mFoTe9wN
 3jMCg/iVAdpHg4pYYm126Itr0hML0EdkL2MDxpy/ScYV/Bv18febIBmNulnHCLNTe04U
 6wJg==
X-Gm-Message-State: AOJu0Yy4DN0WzQ/xVDGy0tLL6mD6joxwhmSGV3irx2W/zm/lOQDfpMWv
 9dKJkMQpVsG/RaADtYRs8OOXoj++W43e6sYL09cwwABh8XunCA1rFIVAFZE1+rCfNPGoNCVq+ul
 0
X-Gm-Gg: ASbGncs1q/l6v0jlyKHN0BQZ2wp2it35R6YDt/FV6JiYvNYj1LjxdnIc6LgEX+ypx0Q
 3RnpwhKpftbjtM3e5vtKV8v63Mj6NQTv6zpMe3zFkR7XOQZGtyYZlWjbt8T+pH+4tonDbMZdjis
 1tZ9DXOrmWn0ccpa5d1aA2L9JvSRQKWe+KOdIFTdATG8JdA96AzaW6RhiKoqcQDH6hsLTUbxZye
 v093ZLDunVVVKSFV1oxuulXexmwjtw6o4YNDAWnA2s+Lu2L4fz/28bxil/cF8m2imV2jmorrOp0
 j16P34fEH5X4yssyJCqKAYsRjRr5IlEGyBBvKRHvfW5F1nQdF2kIanvi+GIDYvYgfGwjAg4gD74
 =
X-Google-Smtp-Source: AGHT+IH/MUqMOw6hjIzcPsTXrFFUJh6nH+QddbUxLmIQhwCnWsYbf/rJuPgAkx85rnsoVY1nxNCH+A==
X-Received: by 2002:a17:902:ccc4:b0:224:c76:5e57 with SMTP id
 d9443c01a7336-22dbf62255bmr48418815ad.39.1745599857705; 
 Fri, 25 Apr 2025 09:50:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50fff4dsm34637305ad.159.2025.04.25.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 09:50:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
Subject: [PATCH alternate 1/2] target/riscv: Update pc before csrw, csrrw
Date: Fri, 25 Apr 2025 09:50:54 -0700
Message-ID: <20250425165055.807801-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425165055.807801-1-richard.henderson@linaro.org>
References: <20250425165055.807801-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b9c7160468..a367fecf7e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -992,6 +992,7 @@ static bool do_csrw(DisasContext *ctx, int rc, TCGv src)
     TCGv_i32 csr = tcg_constant_i32(rc);
 
     translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
     gen_helper_csrw(tcg_env, csr, src);
     return do_csr_post(ctx);
 }
@@ -1002,6 +1003,7 @@ static bool do_csrrw(DisasContext *ctx, int rd, int rc, TCGv src, TCGv mask)
     TCGv_i32 csr = tcg_constant_i32(rc);
 
     translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
     gen_helper_csrrw(dest, tcg_env, csr, src, mask);
     gen_set_gpr(ctx, rd, dest);
     return do_csr_post(ctx);
@@ -1025,6 +1027,7 @@ static bool do_csrw_i128(DisasContext *ctx, int rc, TCGv srcl, TCGv srch)
     TCGv_i32 csr = tcg_constant_i32(rc);
 
     translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
     gen_helper_csrw_i128(tcg_env, csr, srcl, srch);
     return do_csr_post(ctx);
 }
@@ -1037,6 +1040,7 @@ static bool do_csrrw_i128(DisasContext *ctx, int rd, int rc,
     TCGv_i32 csr = tcg_constant_i32(rc);
 
     translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
     gen_helper_csrrw_i128(destl, tcg_env, csr, srcl, srch, maskl, maskh);
     tcg_gen_ld_tl(desth, tcg_env, offsetof(CPURISCVState, retxh));
     gen_set_gpr128(ctx, rd, destl, desth);
-- 
2.43.0


