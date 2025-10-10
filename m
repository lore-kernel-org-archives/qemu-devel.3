Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95252CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7FPN-0004EJ-7X; Fri, 10 Oct 2025 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPL-0004DQ-Fr
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v7FPE-0002d6-BS
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:51:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so18674225e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760111497; x=1760716297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+LjuonxLSezOOPsBu7D5T1RerWloURfdVhjBPrGFuk=;
 b=WrekRuatZl2G9Dh2xDpXtZXTjUU+M91xXAPTf9J+fMPMYQuKPL8zhFwQqVkm+U7U7V
 RbUabaR3ps54rw6T5FMd5uymjE48ug3J2W2zy23qZcdCIb8jlVRe+uZmiatYsGIppOE+
 O52JL2NFsC20rA2J9HR2p7/Cg/vs54e5A8BU0iWGoHqxbAvIACq5BUmFqlKPgu95pLeK
 cbAQgRD5U9h121CpguZsdSEnxG6nMzFcI26JncIzuH3Jo+M2/HTpngiqfkXtCr8UM3lu
 pUVeK/cEcqWYl6JtA7lIKrd5IHroaWu+9+lv3UT8n+Cp7H1mH+jTAKS3qga6vZJHARZa
 uf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760111497; x=1760716297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+LjuonxLSezOOPsBu7D5T1RerWloURfdVhjBPrGFuk=;
 b=FZjK+uBTNU4QXgkuEX6VKt/xeaW0oUe2vk8+fHb4WwZA4u/+u+vs/USJZ0wCefiQAm
 iPorsPu08L6gOn89DHhk6gzjmvX6qyY+PfQm3fz9ACV0P3UadQVhDvSlywasRFjWZVG1
 MroXJwrmlcVWrQEOhwrfsLNyJucM3NBY47S7FTPjc+QhqexNDsi5AOVqGWnhMgU4z3KA
 veglPtbn7VSJxLl7WZudB/vHbQHezd1sYuA6DgNbBXzi1raA5b52BzWE8m6l8VUEEF5j
 3QWAgGv5XfB77/nzky2miIN0Ho+PYVlcYpzYz3qn8NtRDXRm5Q7x0OVKPpew6K70msRp
 w+8Q==
X-Gm-Message-State: AOJu0YxemxdgYPy/hbxNQP6U/UdaUHj4Pl5iTE6gz3tAlzBhR15IWd/n
 f9OlMKqWrB07mpdC7P17s5Y3op0gIDovAlzn71lyUJpd7HpFfegx1VP7ede38C+8cgLe5BatywU
 tnV2dsbskUg==
X-Gm-Gg: ASbGnctDgqlS4R/AtYhlBI9jmZap3b04PiQFW1TIumHAZPsedTs81hAiAh9OO6VBU5T
 mOruT/Td8aHpyn1QFc5+op5zwqmTX4dvMbgGP7hNvl6/PQwe3wT2koEr61MgwT+9BoaKyPcnTII
 BPTsIRAMp/ITjVBs5ML3WpzpeznBdubt0h64UO4ubeVpsCDZUHcicsDg5CF+HjAz2MU410oZJfJ
 TOMY5awN7xBUkQbXDdjCkhKP6aK/LSIGpUl6/E3TmTL6cNOqvoizFZ3nk8vfGnKozMpPqy5DfO8
 K6JzqhJRwUBxNAutEssPC0v+KMrtTx7XW+AJlg9UTppF/5jrf46q66goVNo8LtywujhBrJ7eC2O
 8uFqJzAKlIHrXiR2GOCCw8pcKI4wKbWJYI1UbpO5O7bhY/oSC4T60A/EsHpFyzyY6vWIWlXR+dR
 t/VabtWG83I8reGNW1VyA=
X-Google-Smtp-Source: AGHT+IGAXKnmbDWYJ4lSDPR4gGHrMkjucpbFpZnBTc5qFM13srq+3OoKLZe/YMsIZktvo3fvmNxKrw==
X-Received: by 2002:a05:600c:3f0c:b0:45b:9912:9f30 with SMTP id
 5b1f17b1804b1-46fa9a86314mr85706785e9.6.1760111497248; 
 Fri, 10 Oct 2025 08:51:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab524f92sm61068925e9.7.2025.10.10.08.51.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Oct 2025 08:51:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/13] target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr() /
 gen_sc()
Date: Fri, 10 Oct 2025 17:50:41 +0200
Message-ID: <20251010155045.78220-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010155045.78220-1-philmd@linaro.org>
References: <20251010155045.78220-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

All callers of gen_lr() / gen_sc() set the MO_TE and MO_ALIGN flags.
Set them once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/insn_trans/trans_rva.c.inc | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index e0fbfafdde4..8737e8d60d1 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -34,6 +34,9 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
     TCGv src1;
 
+    mop |= MO_ALIGN;
+    mop |= MO_TE;
+
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     if (a->rl) {
@@ -61,6 +64,9 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l1 = gen_new_label();
     TCGLabel *l2 = gen_new_label();
 
+    mop |= MO_ALIGN;
+    mop |= MO_TE;
+
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
@@ -99,13 +105,13 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_lr(ctx, a, MO_SL);
 }
 
 static bool trans_sc_w(DisasContext *ctx, arg_sc_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_SL));
+    return gen_sc(ctx, a, MO_SL);
 }
 
 static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
@@ -166,14 +172,14 @@ static bool trans_lr_d(DisasContext *ctx, arg_lr_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_lr(ctx, a, MO_ALIGN | MO_TE | MO_UQ);
+    return gen_lr(ctx, a, MO_UQ);
 }
 
 static bool trans_sc_d(DisasContext *ctx, arg_sc_d *a)
 {
     REQUIRE_64BIT(ctx);
     REQUIRE_A_OR_ZALRSC(ctx);
-    return gen_sc(ctx, a, (MO_ALIGN | MO_TE | MO_UQ));
+    return gen_sc(ctx, a, MO_UQ);
 }
 
 static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
-- 
2.51.0


