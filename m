Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A9ACC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqJ-0004wN-B0; Tue, 13 Oct 2026 23:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq6-0004qV-1X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpq2-0001Ku-Vv
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:39:37 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc4b1f7e8f4so2192715a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949172; x=1792553972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFyH+5DZTbPdi9UXaqYYCr1jsYDxpuhVYIku+Zw9p8c=;
 b=XkGYrF0agm5OWP4zzHBvQ4XtdREMmQgb2+H2zEA3UnqOQeVwuKvyo5wbMRG0y+29SL
 ZengnqullzXIn8COucFBZlmfip//d4ZUo43cQWh9XXTFl/wfX3I9c6dnw9d8P6FuroTZ
 90lqbToAtWN2E+E7q4EFmStRxeiWvAlfBC4qotteTNMgbPVKTNXlC71XDqg0YxwfvZdd
 +9TXL/gCGAK4+4KQILySgmkcNB948pxbgqE3xjdk65CmM3Q7VPw/yzzYa19pBrPMUJTi
 kRAXRRKkSRi3bl4FuAwjd7wZgBcSDcFTQDwN/PnvzLWo2Rgoi7bPEeeYvXds7gqtwKUK
 SH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949172; x=1792553972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFyH+5DZTbPdi9UXaqYYCr1jsYDxpuhVYIku+Zw9p8c=;
 b=INR3ZuM66IZsw2p4PkhKuGAZnhyPyTIRkLwM+e5luPtjphBa7adBe6ChitbT7RV29D
 h6xQ79T/zSkkdX1/H5bnWSclo4GCsVJ7zAenJJmJQ/gMRXoShcEQc3tyB4i8Om38I4df
 FaRNjtgdT09vLWq5cs+hI4zarXFo0oiMPkWN2J6mJqRSxlD69E/KEi4ASlHnvVGF6oSl
 MY2YjXpjHQsuGgnhgsOEPXiKuHZuhOccGWyvcxQy1VWW+MHV1liehBnaO7mUi5Tf9rg+
 UPdmULvekA4egc59rCtatSirl4t4AZViuNK9MSTvvAq34LbBMPOKwamU/BZkn7mk46pa
 BrOw==
X-Gm-Message-State: AFq9FYLjMLyocWNW1bfpEY8lmEgO3n5LGadNhVIcfsYxBXa1W4QAITFT
 dFfsZ+O9nxXjvopU/LlBJeeYpnOgmRgcO351gL3frc9ebLraatAMVfV8HjERGQ==
X-Gm-Gg: AYBFou01pyjRoowN3Pcn63PxByMQMk2tr/b4rvC8L4FyYoyz860Ip11qPuoVj3PUMZU
 yWp4N3FBSF0q6K53QOUXFpJd1s13XXmcdI/OpyR/2pq+gym2It+kkqBpZCXvD8LKp8meBY6tpSt
 5jC64khe19vgVaxKTljIhP0lDIQ2ICxcB1AIUiTr0pFIrCK7yQuM/o2f1kah6lzAwaIu83I4U1X
 q4J2KvKYQUVpEdISyCa/HBHOvGGPbOJE+5XkEpWeZ496r70umyyPzTfIZN4RJXhy+JHEJIXupbK
 nqdD7t3YFR+ikcYQseRVCKA6oU0VyDyJOyU/nt3GsJiR5JYXwD7+e0vsiUC8VrGDY96GnPCWrbx
 LiIBvtYeUnRDGM910I+0lOaPcuum2JXxqpGMUU6xq7Y0mf7ZWtd1jwi8nEDSa3ueE1qUNbFgF/d
 NlqOV8xiSYWrbVQ1XcWYX1pWHkV7gdyYLZpbPaMGF35EYyvS7MGvFpgV3PrXUeFZj8tNXkaf1tq
 5xMeAEHLj8pwRwItqLsJpnCX7Q=
X-Received: by 2002:a17:90b:1dd1:b0:3a7:e0f4:2857 with SMTP id
 98e67ed59e1d1-3ab3a359dd3mr10491509a91.1.1791949172036; 
 Tue, 13 Oct 2026 20:39:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:39:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/52] disas/riscv: Fix csrrs decode
Date: Wed, 14 Oct 2026 13:38:18 +1000
Message-ID: <20261014033907.3332383-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

Resolves: Coverity CID 1685513
Fixes: 4fec981f18fd ("disas/riscv: Split rvi_opcode_data")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260914015316.792751-1-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index e85dbac035..ef8b7ff20f 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2560,7 +2560,6 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 2:
-                return &op_csrrs;
                 if (operand_rs1(inst) == 0) {
                     switch (operand_csr12(inst)) {
                     case 0x001: return &op_frflags;
@@ -2574,7 +2573,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 0xc82: return &op_rdinstreth;
                     }
                 }
-                break;
+                return &op_csrrs;
             case 3: return &op_csrrc;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
-- 
2.55.0


