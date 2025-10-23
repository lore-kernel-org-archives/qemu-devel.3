Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB69CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54W-0004Dr-Lg; Thu, 23 Oct 2025 19:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54U-0004AD-0S
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:18 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54Q-0007NJ-Ob
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:17 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so1231143a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263412; x=1761868212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qtmy91JEQYqJR/91H8B/Uh3Fg5s9NSfMz+Wbznv9/ps=;
 b=I7L7sBUSD+DEdYhPxAAGFk9Ry2IgJ1WOK5fwGdZByZytTYW3fzxnGB6tAduAh12K4E
 Te0bwPHRv2yOoT/QVu2C9qrr/G/cC9iWRQkD6m6ZDEcxvFnWTrZOE9mor7LH5AcglqWz
 yn+wXaSmYKd6GhaolNBNrKHTf2hNYc6HQKkFjAIXfON/FhTkqJ32CRnU3Er0d+etC9yb
 4gQguhRTjdf/yFmBCMXAFnsNoKFagHWA+2xasjdcJG6Dndg0U1XWwW2xQs9wqx1RvBwO
 Z7+PL9YrARW7NpAN7JmRnIOM4Cm5E9aURCnq9j4B4t1YAqKRJBuiTwv7dxfte8Y3tdIF
 uzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263412; x=1761868212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qtmy91JEQYqJR/91H8B/Uh3Fg5s9NSfMz+Wbznv9/ps=;
 b=v9zqxoILJocLKzEVl+Zpv3fn9Qzjxsm96SgbWX3dpwp2DFzxRd6T3EFVHGRHSG7m+v
 kgVuzovgCJL67cVLu4jyECySS32forya16GwDbhkhXDVP4OfCNSy/sKYgz3UUxTDkJ75
 3RYvUSEP0R0fUIcrRSuDh5RCX0jAA+L7os3744W8jnd6onTFVfMNBorRK7Q4M1ntHOIT
 ZhEAAeetMRnRbbEF0VezwV0juFBzzzV9rGhDxXdov+ex10S4dR2/rZng64iLTeqSkSNa
 0kbbTXb2OpDK47gw34iTUWvQ73Hn3Vs6n4kb6TlW1bY7rMvbiDlEPCmCjCcrVlqDiykb
 BW4g==
X-Gm-Message-State: AOJu0Yys2Vb8tRPshUxKmeStrJVepmi042clvSMFSDJ4zvo16GROyKoQ
 x0X1gDZNMOed0aG0cH/eT3PFq7jw1bxMowN/mF0tjs9UQgzBtLI5ZAvGJrQdrA==
X-Gm-Gg: ASbGncuavorJ9pWddu9i76v/mAOtrsAvc3+4FfsIb850GdVwJuuf5ONhlKcGnizYchN
 XSe9tXhs8UvelvNg20wUse3g3saIH1bCxEs0tpBq/pYHEhAvdJrpQ2MiDkW1weRccFBstszy44g
 rxlD6TbTnNcfZ19tM8Id4+cQ7ckvcg9llJRcmWIUmse3guJQVk8MHQ1SDly/BcLwQXlkY8bxKiS
 kV9zYVU9SaihRxW4zOXsJv97ovABNd97f34UQgVApArcsRg5Y7UbDvGsXguG7jTghNL2cGQyw6X
 xe5VUxKWx+AzFtAjXNdmJMhKGq3l5TYWPk3wjRTrBsf1+E5hHPcjvDNcxSfZ17V0HF/eD3DRIpG
 G66NdRuIlUV2tdon0gHB4l7Y1QPBgfA5RgKodUoCL8v8+xMs52BbaMW/5dJNitWBJ19eFmhP3hd
 4q3oS4hh4WUZMZLZO1eK3J26QTAj02v2hlzboYsX+10Y3d7upt7IX0mjasUoBhBdBqVWKiX/WmX
 hzyBUtJZQEwThTr6E4=
X-Google-Smtp-Source: AGHT+IHBJZZEjopUCDh+nzRGQMyRPayBPFdkas5hw2KXNFGcHfcktBOegSWiwLCDS5DaUDAKd6ZKXg==
X-Received: by 2002:a17:903:2449:b0:262:cd8c:bfa8 with SMTP id
 d9443c01a7336-2948ba3bb53mr2072115ad.34.1761263412015; 
 Thu, 23 Oct 2025 16:50:12 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:11 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 10/25] target/riscv: Conceal MO_TE|MO_ALIGN within gen_lr()
 / gen_sc()
Date: Fri, 24 Oct 2025 09:49:12 +1000
Message-ID: <20251023234927.1864284-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All callers of gen_lr() / gen_sc() set the MO_TE and MO_ALIGN flags.
Set them once in the callees.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-11-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index e0fbfafdde..8737e8d60d 100644
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


