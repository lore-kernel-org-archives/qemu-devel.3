Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F0910706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oD5-00036b-UO; Wed, 18 Mar 2026 06:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCw-0002Vu-DC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oCu-0002WE-0e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:32:58 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso4745694f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829974; x=1774434774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GeF7zrqVpIAN2M1XENsNrdt0KqgGLN7xQ23+VAFB6Aw=;
 b=CBww7RuUOBTsnVP0WWQNqaG7zwMzBsqm82EMilNCYQUUZNuRcUfQke9LpZEThee7gk
 m23Fkw7yOMHyjx0EO2xbSL2E6xSs4dPyNb6rme7kta3h14haaf12aRjWDfDrui/7vzFD
 YWJvsXmdxxXguLK1uHLPzi8+sSyS21PjjJUVCodeze6uwJoTbNMmXdRWZSiPmvmdb0QU
 z1LyXylZd9vQvxWfmdSt94bt/4cOb1Cxq3pjzGDHBkv7/mumF6oIKF634V6xhxgjnEz3
 Hqk7O4Aquj8ryp6xmT62mnRqJT76nhCUPI/bBYAcOVatj9HPA6d+i/hhuwMl4/G8+tV1
 YS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829974; x=1774434774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GeF7zrqVpIAN2M1XENsNrdt0KqgGLN7xQ23+VAFB6Aw=;
 b=W5XZDzHnHmOgsk7Xv8XCUVGjWypvfDUUe16Uo+ILAG38KNOxmwD1FQ4rae+x0K2I/a
 kHprk35cWh5sKujg6vjMRLbYjiXFM50xIJ08tagvWSYJVNV9bMt0LImSRuxmXblidHxU
 qgHuiuHtnowtjodQwgv2BoMZZ1wv+sWigQ/pdfbQHbPv7MYA4yxiAvqcTRA66EPNCfUe
 3ud8188rzXFj326PfeTbOqQOV3jhlhxeQGMCDteB2eN/ZY9aiHHBduyZ5YUGlw2Oj8x2
 jqe3VGzX5Lki/CorEhomzqhypThWz/s6yP63oYH5Qf/cBo2gfyrekJZk1fun0v2PYOQ+
 4KHw==
X-Gm-Message-State: AOJu0YwNZAD+rOAu2FPoHJhs8ESJcwwsE4C+OAoAVsIFa49EyV8ioNlr
 hGcLLr9Z/+Amvko8s1NRqPn/OPPnAT9/tf+nsSvu4cBmoOjzne46BG9A9L8GtF/BGTveq06+v8p
 WYk9abmw=
X-Gm-Gg: ATEYQzw/HcEdlWKeNTLMoQ7oU9eFKw1MOjUUq75znYSvxXcc4usQ25QkQ2Pm7cKjJH2
 UIxW69hTzGMeqotKFpkfr5i9i6/iHwYnfO7J0e8yqM6vUbcPIKA22cJ/VbIee8p0mbypyYUVl1t
 s+ayuyhJF2bNZEFnkxY8uSpWWHp6jq2/iqc74ke557M8ee3G68aiNfam+Aw26goU+pnIfsqq+z8
 wbjLpJNkUQ+EGPzi/035D2/nhXFNLvpl1iJ0t8aVP+hCAD9A0MBKz2jmlmeRf+mCB6pCBfJZ3nT
 YQZ9XlzFxCSOPVJvztwT2Ckx5F71WUvYkEkHhV6GpKaOQj4OjqZqZyepSgaaO7r5RCfSvhDcsuu
 wLhz8VsvioeIUiHrFoWy02ztClR5o8l57E2nDYdQctmCEzC6yQtT5dWA4VTv8WLIOvFh2ZO12VO
 0CdGC9rI5SlbCqsdiNsEqGlir5JvyY7yrCpg86sJ+kHmu34Sk8AaxrMp/CBVOPNS9dpW5EY15l
X-Received: by 2002:a05:600c:3b07:b0:485:3026:2b8b with SMTP id
 5b1f17b1804b1-486f446fab2mr47314795e9.29.1773829972642; 
 Wed, 18 Mar 2026 03:32:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f5e1ab83sm12169645e9.36.2026.03.18.03.32.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:32:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 12/16] target/riscv: Replace MO_TE by mo_endian
 (Zilsd extension)
Date: Wed, 18 Mar 2026 11:31:17 +0100
Message-ID: <20260318103122.97244-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Replace compile-time MO_TE evaluation by runtime mo_endian()
one, which expand target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_zilsd.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
index 445406cf015..f50c52f22c9 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr = get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
 
     if (a->rd == 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_TE | MO_SQ);
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
 
     return true;
 }
-- 
2.53.0


