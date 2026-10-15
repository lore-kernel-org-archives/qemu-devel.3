Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B865CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ4p-0002Wn-O8; Thu, 15 Oct 2026 06:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4n-0002UF-Ps
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHJ4m-0007rn-Cg
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:52:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so235080f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061563; x=1792666363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CQvSJUR6RlBCcGqLZcn5QWwr7QgdFrQ8iwqzgoq9Ltk=;
 b=IcGIdU0rw1bG3t3czq6wp7hfCGBi9ajxtIgdK9HFbxHWx9uNVKvU1uOl304anvxLAo
 qrWL5TyiWCntMQLAu9Iudns7NCYM3Ta2B6eTlxwt6d7nr2ZC2/bIQD03vfzLQf3SxHOC
 gtTbDmugnq45m6RxV19M33vxS8OPm+XSqr+3EMnjysRuM0+5lpcPMB9W3fgv0F+Ha0AG
 YjQp4kOw4RV3uMqtypgsHgzlq3tnLtA3fKoRtV/ro20IUh8yWHicJg+87TBrXyLkHo2g
 wr0BZM6VAF3ihWdZEUPt7lxVE4GLK8uO67XjrHz1odMC2rGpHM5uxoFSLRDzha9SgQmT
 h+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061563; x=1792666363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CQvSJUR6RlBCcGqLZcn5QWwr7QgdFrQ8iwqzgoq9Ltk=;
 b=y4Hp5oWHTYlGHK+XJVZD+l4jjw+J+FQLXzM2wZJpC240LZG7HUoUyq1unFw9QMX2di
 Bl/if2OxpubgDj1X5hVWOjnHxIKkDUax/50+EQQoJu7un9e/+vJFqLyVn84wOe40W5Y9
 wF5Yyd7ZAdlpeJgNaFdvVYwBcr91IoJW9VX0VOLaAbXRRdXw4vdfG7uPavBhbEog5pHc
 IJErJjWRZuMZyIwcN7DKQxvF3efImZFEzxJmr1tFKWZg03h6Senyxpke1ZmhBEeMbPWq
 fZEzjG8n3VQfYXje9I6pVn4yqc7GdpK4byNJrz8EG4LafyFZ8dA0/d5WYjzOsTxIyM9W
 jnlw==
X-Gm-Message-State: AFq9FYIB77Ca5rWIMR8nA+3ZTaTBtabpf2XmjpVqTb46cMFg8Swt/1+L
 XkOyW64O8l0yN7zR73QYZugFJGB078FieYd15mk2JEtFeNU0VQXvsNOcUXJJqVPa/F1ATFRArF9
 f3vuBaxw=
X-Gm-Gg: AYBFou3brjFpwSmzDLgy4RuZZVyVYEfNdLlrayuwsjqqftq/hXciOiLZ0eK13iUBrT0
 jj8b2i2dOYBLrNOevzNMUA51ZdDq0XBgQSyE9JXHDWhaE8Qvt0+VoTi3mIOCdb61hBNLrIDRjEX
 amkWQq37lacFz6c7Nrhbv12fLmiqLNEpCY+VcTlOF4kWFammaVQkwZ/Lj/5pRR8n0IOli1F1CLq
 9B4PvDmWkla7W/D6qv2dr2YRJOdqe96JEMX/kA2cXsOww21tWSdGKso8r7Av9HY35k/fwHQVOab
 rtl1o9CFKI1VHJSx83/uv7xolPKGvs4122w4RX/F/87KQmD2Y7NSZ0APCLfXhj0TsADktj4wBAq
 GkDedZWQSMTxi8Tt/tSZs35bzpuyvZeTUmOj+mzswzGf9kNba+Jx6MqKiv7V0qeEgnit2tv9F4M
 cldNQI7nOtjSZjXSivpV8SLRJrTZ3EWJQVFegLfX09EthPpWRBFp4gj1wYulLI2jW7e7LBx0coC
 2wAmmIr4Xe09SqHUMj5YsU+kCNNX3KwS3pj+jZkfOHkUrCDE9cMAn5lfWs14DsfeeFU44JsIUVp
 QNRcXQ==
X-Received: by 2002:a05:6000:1868:b0:48d:db43:9187 with SMTP id
 ffacd0b85a97d-48dece6d67amr10278986f8f.16.1792061562886; 
 Thu, 15 Oct 2026 03:52:42 -0700 (PDT)
Received: from stoup.fritz.box
 (p200300ca3f0f8b006e0ed1a687ab6860.dip0.t-ipconnect.de.
 [2003:ca:3f0f:8b00:6e0e:d1a6:87ab:6860])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48df5b88207sm3075949f8f.59.2026.10.15.03.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:52:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>
Subject: [PULL 14/16] tcg/riscv64: Fix off-by-one in branch range tests
Date: Thu, 15 Oct 2026 12:52:06 +0200
Message-ID: <20261015105212.356392-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015105212.356392-1-richard.henderson@linaro.org>
References: <20261015105212.356392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

We tested the size of the field encoding, not the
actual range of values.

Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index e4e1ce91eaf..d6c52323c3b 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -476,7 +476,8 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1,
 
 static bool encode_bimm12(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 12)) {
+    /* The 13-bit immediate is stored in 12 bits, with bit 0 zero. */
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 13)) {
         *insn |= ((imm & 0x1000) << 19
                   | (imm & 0x7e0) << 20
                   | (imm & 0x1e) << 7
@@ -512,7 +513,8 @@ static tcg_insn_unit encode_u(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 static bool encode_jimm20(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 20)) {
+    /* The 21-bit immediate is stored in 20 bits, with bit 0 zero. */
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 21)) {
         *insn |= ((imm & 0x0007fe) << (21 - 1)
                   | (imm & 0x000800) << (20 - 11)
                   | (imm & 0x0ff000) << (12 - 12)
-- 
2.53.0


