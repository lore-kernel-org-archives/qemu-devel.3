Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22969C88E7F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Fnc-00038Z-Qu; Mon, 14 Sep 2026 19:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnT-000369-RU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:12 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnS-0007Ep-9g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:11 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so1775169a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427349; x=1790032149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=We+ZmxCJgRSKoW0yRBOtG3XbfvyHqf+G2YK3lJ2kZqQ=;
 b=FqQNbSVJDUG5EUjPrKVDjcQks4PUZEF2Jxhc2ATbWYhDHA794wZRW3vzn5GA/vcjYh
 QPNKYQL0QRSjmSNAec+LvSl1gzVgO9IMhR3bkF2j+Bn7gNaH9dmc1X43IiLvPdHG4WFz
 KwSRBKszvS0+VAp7VcIdBVv3oylD6qeNvFpqAqw6Sxy7i4AQns+9YWzgkC3jWPXICLFc
 4gVyjVSreLj2W0ldDmt3zJBJ+YC+O/wvoFcQZpcjpPujdjxceNyM/UNiG3d4onqfhyM0
 eSuKqUNExHUtb64M/J+DClRCIiC2P4MzFACekA0bVMcj7FecI9CuBP8CnSUVzEDodAx2
 n+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427349; x=1790032149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=We+ZmxCJgRSKoW0yRBOtG3XbfvyHqf+G2YK3lJ2kZqQ=;
 b=DIRhjaFlVvHV7caHqRRcWjgIVyku8UxcLl0nbIzHhDVzZDuYoX+bjLZF6VlyKbOkfw
 hKAF+KahHDkMsJAJOcu5gXUX87ikQ1gvpMQtO1tQouwui3nXqLw+6gC1ltI2rhZaHKwW
 04NlAP+OvJ+An0ndxbYPxQTl+FaGQM1CrUzr8GHSfss0bVzHbF47e+AWl+RphegDk7ia
 f8m5T4/w377mY5ksIiMX39wGD4zLITu1iRTkU5hROQuHkqhWze3TCMW/yR4vjDn52me3
 yPTUtksH07U2/hxmpKcJDWtcHDSweSuQ5Guw0gCsQw8sMSvUM39P//XYVcWvbksr4Klr
 5XnQ==
X-Gm-Message-State: AFuF++n9/7yYwxX8sJzGJepvKx/MFDm/dZxdPDDEtNePbsCwGR1psnk0
 XP7bwWGMdSLmnjFANoZWqZDeji3W/aTybgefmC9+Cdc+Rj6iYtY31udRndaP517CjTtUfTKzSo5
 frAE8ikI=
X-Gm-Gg: AYBFou1/lKmFSJpl+zySSAi/iJJr7Z0tQGoPb70WzyBR5y7KEduT6MfsEnopXc9KLlg
 PU84/BwH0tsqusA0a9CWHvA2wb2DNxL4VH215F0Q/Ks3faEBufecwxLBo9wCKL3u5sxxlVELeBW
 twb52g6IDZuhWf4bn+iD1TrOpl76oiQ4TX4Nu3erqLLJl9Qm1f68qI9wp8TYPHnTRzAGlEh4ewP
 ZhyReozdIHG5mCSIUrLuBUzeNbUF86yMRDph7NxFuFZn60nxp/1dJZLvN9GqvaWAYOJLsRWfj2k
 gQX2LjswZ8jlaXDDdkvVybnUBSSBLxqsaP8RSpZkkFbuqTGX0j/SNSjmzFhsEVFVf7Zy9Z4dh+q
 +8Fdjf94QXaOTBeiXHqg3hwbxWSVPpf4Ijv1W/luV9DoFHhI6JvtkiZ272blQs4xXkwhoGEehQ4
 7w1A2n7xv9COMT3BCPmuntenlRzkrU13RaHJX7Ge0jbtV5SGIV6WmYKq3Rel+xqM4NcMkkDnRsH
 y98lhA=
X-Received: by 2002:a17:90b:582f:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39dec05fc8emr9830314a91.16.1789427348697; 
 Mon, 14 Sep 2026 16:09:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 5/6] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32SLT
Date: Mon, 14 Sep 2026 13:08:57 -1000
Message-ID: <20260914230901.1781309-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 4b2c264f031..293eeb46c23 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2313,34 +2313,15 @@ static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
  *    Update XRa with the signed "set less than" comparison of XRb and XRc.
  *    a.k.a. XRa = XRb < XRc ? 1 : 0;
  */
+
+static void gen_setcond_lt_i32(TCGv_i32 d, TCGv_i32 s1, TCGv_i32 s2)
+{
+    tcg_gen_setcond_i32(TCG_COND_LT, d, s1, s2);
+}
+
 static void gen_mxu_S32SLT(DisasContext *ctx)
 {
-    uint32_t pad, XRc, XRb, XRa;
-
-    pad = extract32(ctx->opcode, 21, 5);
-    XRc = extract32(ctx->opcode, 14, 4);
-    XRb = extract32(ctx->opcode, 10, 4);
-    XRa = extract32(ctx->opcode,  6, 4);
-
-    if (unlikely(pad != 0)) {
-        /* opcode padding incorrect -> do nothing */
-    } else if (unlikely(XRa == 0)) {
-        /* destination is zero register -> do nothing */
-    } else if (unlikely((XRb == 0) && (XRc == 0))) {
-        /* both operands zero registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else if (unlikely(XRb == XRc)) {
-        /* both operands same registers -> just set destination to zero */
-        tcg_gen_movi_i32(mxu_gpr[XRa - 1], 0);
-    } else {
-        /* the most general case */
-        TCGv_i32 t0 = tcg_temp_new_i32();
-        TCGv_i32 t1 = tcg_temp_new_i32();
-
-        gen_load_mxu_gpr(t0, XRb);
-        gen_load_mxu_gpr(t1, XRc);
-        tcg_gen_setcond_i32(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
-    }
+    gen_mxu_logic(ctx, gen_setcond_lt_i32);
 }
 
 /*
-- 
2.53.0


