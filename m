Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB7C5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbm-0006S6-1h; Mon, 24 Aug 2026 01:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaw-0004ie-8T
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:45 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNat-0002po-IF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:41 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3811f512167so4220660a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550698; x=1788155498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QT+NqtS29Jb8B76mVXI/GmUgsUgPIu04DUnpKcaegjs=;
 b=NDlozhiGiFuC9erk2egGsqI19NsGp8cStC8teG7/5wTUsA/KiRKvOgKAPBYXjY+/k5
 JRCrqTJcY6X7bSuOu3DiWk2aohjs+CC/trTYWypAO1epplAg+QGEOMhrc5nD7T4uV9LY
 Jlwc96MMlS7GJ4LTyZBBDYgSxoQTbbBgkcuwsiWx7Ib+B44FCAhQkiqBzX4ZOWiUZJpp
 xXC7st4FxXNhXxFZSDYtscwRppPiBUFk90PUTnyV5nvA4BGU2ee/t3snIWeDWRE/1Bix
 85d4iZLpBTTmZYZ1soXN4epq+X4Az8aE9SSbLy/+I36ioAug21qxhDMS2w95WQeKpi0E
 FXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550698; x=1788155498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QT+NqtS29Jb8B76mVXI/GmUgsUgPIu04DUnpKcaegjs=;
 b=E86bgH0quNcaaLcvUyBxpaf0+6GRxfZXJwGTIJfG6xHnQZEidvwYw5olqbUcWI/Ydd
 nyixFxOKKLRK4yXeXSkRXjd+qmJ9m8ZqHRVWq0uVIoGhSHLNdCZUP5jePFJaCSCkFVwX
 O7zSahWQot8hRFjHn8lIGigGaiE/YovMmnuxlKU+RMrymPnpB4otPKXfP4XRry3zA2An
 pcLDLnWupftFaSa3VFauvtn6H4sRH2I6t5tT43GT6FNbiQ19cmoU4lXYVqd1MhYFD55p
 NPq4jV/qZjqUs+BAgbMbVfcLG+233gRlrgp9G6FTGa5jKyjjIlC03OfUujnRrd5qsQCq
 lo8g==
X-Gm-Message-State: AFuF++mvzeBplKc3zxDo6iQFhy/aJPTSl36q2kg+NI7fdjybXk+KYdsO
 S9DygmzW3zHRITbsq2hw1w227GOl2YlrIF5ZW+47qaksMuB/tieX35TeziAFJg==
X-Gm-Gg: AR+sD13YF/mUZ2IQLxMheKVq6nYojTvrh6DezctVENmgNTJEos746COhtcMWPs5U+xT
 Pl1nbBEfKfbnWiKoCR+wRPRh1OaChp2p3ohGqZ3F+Gdq5BNZo0GQP8LmiMOAtAMCSxUiXijG5LS
 iZIlPs11Y+wUYR+ODLJIx4vyDiySizqKoHdoUgrq1srYu4jUceEFFrYFdOYlEj6aUoSAmuCHC0Q
 xkuyNyiDsOqfYjkHHe4fjdZLXkGi0aDVjDZAlL1GbXQVDMea9UJ1nzTaJot7z/oaVQUJCmdm8Q0
 uyPLG2dNwSZEYLbza5cVhDUOgX6A7kjvR8EJm/jTCPWEyPGAM3BnPwTjCd9ciFjvxswXQF6af4U
 xD5QJaiikG0dfAsOOVIE4oiFjYUmOBpwCUu91w1i94U2clBTCxZYqQNRqVsLPlVlmgjrGg77M1c
 rnN+UNaLKWlbKyDPOtFvlww9m2z7WtxOnPKeItRiFMT747tzYB4FE1H3RKL7ZzIGhzC15qNGfAx
 hOVgTDB47KXDq/V
X-Received: by 2002:a17:90b:530c:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-395c35e25e2mr39267267a91.11.1787550697976; 
 Sun, 23 Aug 2026 22:51:37 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:37 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 66/96] disas/riscv: Simplify some insn decompressions
Date: Mon, 24 Aug 2026 15:47:36 +1000
Message-ID: <20260824054806.2790041-67-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

Route "c.j" to "j" instead of "jal", etc.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-34-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index dedd925077..342e2db3cc 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1848,15 +1848,15 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
     { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
     { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
-    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
-    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
+    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
+    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
+    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
     { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
     { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
     { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
     { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
-    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
+    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
+    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
     { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
     { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
     { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
-- 
2.54.0


