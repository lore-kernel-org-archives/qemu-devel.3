Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D4C98324
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klx-0008VT-To; Thu, 24 Sep 2026 10:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klb-0008Kx-1f
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:46 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klY-0005Ek-3E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:42 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso1445428a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261378; x=1790866178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qDKqNNDlYfK6wn6XYvmytKMy0kJCAXt7Th72dC2Gd9E=;
 b=vQtHFOSBxlfqvgvikcSoV9CR6mjt8DYxzY69ULq2oYw/rYSS5arL836jJxaS+uT1oq
 bYESnVfKZkGMcFWJajKpqaL4K16nhy3WbtdycFb2sHP5pk1K7ceMelQEo1K0l3GAXuN4
 DHdtteKCnw9YYKjd6GJsp0tH7Q0+LKlUfIEX05RpEnKia+t+b88iK604GQhw+WfueBsT
 8iDLf6GM+VBdTUjVZhPknpHO5/P9/NPaHeZIyZkqQXgXpA42qm6y+aq7aAGS04l95dBQ
 snZX2NU9eK8tfyGW9EW3hHrgVjQCWvn9DFBpWBobpEuUHtQnGn3w1V9rZkwatqdrkWIb
 aKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261378; x=1790866178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qDKqNNDlYfK6wn6XYvmytKMy0kJCAXt7Th72dC2Gd9E=;
 b=N61LyUKETsuJykXL1C8dIWe9Ccn8Guy+qTk0vRcitx0dS02zY64vNMNGyYoifZuVHv
 Luqwm/m8bdx8Gd/7vsdYoG+EYkBlInTpiEmXP9yPtnATJQdMYm5GvnfUIszM4MV72OIG
 OpuuqmCQ1b9ZOMGA5hDIVf4nXNltvwXIgRMRPpZHkKwK9yiWCYVUk3sd3Z151VfYYKvZ
 CQVhf7qDoZMWu+kSzDZ9yo9XKoXZ7XD03W+NRRh20jZw4LeyzAnDYQTcbd3uD/Wb6X84
 Fz6EmqSfg6RONkRZgU8Tlne+Vfx/FDBR/sQSrTaMEhBgp+Nkmdjkb4vAxlevZaRKTWVN
 AB8Q==
X-Gm-Message-State: AFuF++m/98ydBOu8ik2e1ZuX9VyHTsCmYN1e9AAgwhFNxhA8xVaOSOUl
 MPMiiODIP1PshdLNMdAbGk9lYi0h6d5WBJeK76tsK9nRER6z1ALjRHqZQrQRXA7oIK8PK+U3rv3
 nIO4Y
X-Gm-Gg: AYBFou207oLQ43SakWlKJKNPjQTMOqersSXzQU8JO8bfdZiB2Pur4QaeU0p6SKwq1iH
 Kbehlv8KHwm0mGb75OG+C0TGm87X3pwmrKx8MqOYtlCcJWT+4veG+E9yJB8y1Ban+80EICHvCNR
 zVAEZJAw77s8m3+Rtg8jm+XjBwgcSBOIBlNBtmSO8dXpdiLzVnul7V/Mi4pGdG5IPPkrfiqteXf
 4G49PNZEicTnBlfpJKRikRMYv9nCaa0iQ9PEuFRxYinCSnWg+KTz9zmOQfMHsIawgXMbrEgqRjl
 oGFoJ9f1muhPDm+WVEvXLPMi22B5EJyLLe+rdrk7UtmWyHy0iL+IveEqjcP1c76m3FIzogFGOQq
 tbheJbdJ/99vLEuCps/XbXihuWqMG8F4i1c6sy3xHCHSgBBXgHzpzvVZN/mjQJdXIG61Lz8as+y
 atDWie1NpeHr7hn3jj+RFl+uQ0z354qrmjEYrEUH/QskQsMCqGCgVr+U2R6r0PVrdNrcNWGZH4f
 EtUjl65Ck/YEoFNPUq63hrSR21OXg==
X-Received: by 2002:a05:6a21:9198:b0:3dd:a007:cb2b with SMTP id
 adf61e73a8af0-3de0e9bd6c6mr2540121637.39.1790261377769; 
 Thu, 24 Sep 2026 07:49:37 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 6/8] target/mips/tcg: Use gen_mxu_logic for gen_mxu_S32SLT
Date: Thu, 24 Sep 2026 07:49:29 -0700
Message-ID: <20260924144931.161335-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


