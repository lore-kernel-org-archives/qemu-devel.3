Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3AFCD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgl-0001ca-HZ; Fri, 29 May 2026 07:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgk-0001cA-4W
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgi-0008DH-Gt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:41 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef372c58aso278723f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055259; x=1780660059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFPyMg6CG4UqvbKuUhXJfwaLJHXNaajBdeaaZX6YoCE=;
 b=ngdcIAVVI04Dv9aTMkun3jeqWF84fo8QOg+Gw+ZP9fcE4Y8AAdzyt0yswFAtbCTKTw
 Z9M8hmDc0vCOEhB0l0RVuoxa+7kWq038WeSr1P7U5lcQgPmpb67CH9WeDj60ZWPpR0+r
 gL7FVHx3Nv05tEL07LJgq0Jboxvl3Rjd4SbYn1H+jhK1NtyGK5zU4PaKWSAyHTk3Fp0c
 mLSBcyj9boj3uXJW/Pljc7+f6Y8WRetk9cSZVH2aJXoKytrRw7voeyoEj/DTA1BHHR9Y
 kYjJXmK3AqOA1TP0b9rMl/WJp35jsejKpsbaQmxNtJo47+6VCjteS9WjralNU5Hm1dBs
 kncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055259; x=1780660059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oFPyMg6CG4UqvbKuUhXJfwaLJHXNaajBdeaaZX6YoCE=;
 b=ljOX0iu3XT+9fz+ftBbI9z7N+65epu/g8qD3IgYtIj1WW700UvSJTthmYQvmjw2J9d
 jSCyyIaCQyKi4C+2GoZ/SBbNPGaNAZ3yW4hgA5SOphFfzsTdKfQHFS7yvs7M+x4VHjBL
 2CqBzTr7zDM4AzFoIgLfH1I9z47i51SFmyUUQXDBE1i29WvPlFsFHALP1Yv11QS/d53J
 v/AT/lctGFd22+nmK/6p2MVRwQxlTDg6vfa2Pi1aKL1x3UeW8vZ07+sAZ2geu/hTQbv2
 PBJQ/a7Qxa89EikWz5UqQex+9C6YQOiyiwliqh0RW03TitZi6+EhFVTySeRgXKMMzv5a
 69Gw==
X-Gm-Message-State: AOJu0YxqpMIg4KKKslas8oII9nSrCoREn0suGetGw2FDllx8Wz/nTmSZ
 N9pxBlec3Dyes6SlNf79c2D0ZLCQruQGZ1wJm0hd+jOxMnyssYTd3D3MgwoFXz2mgKrYT391rnl
 Vxnaj
X-Gm-Gg: Acq92OEbY5tb5MkDHveyuHFYehhdOWGRo7ctx8Qxqibee3/UBG0jOIC3KxJs3AgXGsM
 EoJMsrzQKD1MYzZmpeqIf790/ZjkMms+J/4iLtXqNEZjFBi901xfkarZxhjePWHh+XHWzuNkiUx
 E2OfSw/eVvuvNWVKNx/fyyAN+IiJSsPMk/XMx68DJlvEDKd8ALtilPSTq32oNzTYGpV6f9BCzhY
 4FpVqg9Qvip6D8Gvjb9duqTfEX2NcuM7QD9WjSHc42Tq9sSEsn5vHLnC4ivQKPBcxm2dBj2sG6j
 19Xy2he+133pSkcVt1gAf6AiaAuy4UVJR3p22LakVEXbHif+/yg/JB7uZCFtIVi9PglAcouYcIb
 7e5Sqy/WR2PFIevT87EUEsFIIKMiDCBOqdOg+qe9D4MoRDOZUH2/DMDnZJUSHaQ0sGOqlEREdDP
 iRc7fIcfSEVue/NQG4JliA2bolezgKpaEVHG1UaiOTyGaB6Dcz8DMm+zYKpFTpUYezfeZS2iJJC
 60NfE3klh3M1STXaCuhLw0I0lkE3Hq6CGNYWTv4TA==
X-Received: by 2002:a05:6000:461b:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-45ef143ef08mr4758696f8f.21.1780055259158; 
 Fri, 29 May 2026 04:47:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] target/arm: Implement CB (immediate)
Date: Fri, 29 May 2026 12:47:14 +0100
Message-ID: <20260529114723.42040-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260518174750.660258-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: var decl at top of function; add comment]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a5a2a45a2f..d8a3269573 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -217,6 +217,8 @@ CB_cond         1 1110100 ... ..... 00 ......... .....      @cb esz=3
 CB_cond         0 1110100 ... ..... 10 ......... .....      @cb esz=0  # CBB
 CB_cond         0 1110100 ... ..... 11 ......... .....      @cb esz=1  # CBH
 
+CB_cond_imm     sf:1 1110101 cc:3 imm6:6 0 ......... rt:5   %imm9
+
 BR              1101011 0000 11111 000000 rn:5 00000 &r
 BLR             1101011 0001 11111 000000 rn:5 00000 &r
 RET             1101011 0010 11111 000000 rn:5 00000 &r
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 94dad693eb..765bc3f0b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1817,6 +1817,49 @@ static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
     return true;
 }
 
+static bool trans_CB_cond_imm(DisasContext *s, arg_CB_cond_imm *a)
+{
+    /* Note that CB imm and CB encode the condition differently */
+    static const TCGCond cb_cond[8] = {
+        [0] = TCG_COND_GT,
+        [1] = TCG_COND_LT,
+        [2] = TCG_COND_GTU,
+        [3] = TCG_COND_LTU,
+        [4] = TCG_COND_NEVER,  /* reserved */
+        [5] = TCG_COND_NEVER,  /* reserved */
+        [6] = TCG_COND_EQ,
+        [7] = TCG_COND_NE,
+    };
+    TCGCond cond = cb_cond[a->cc];
+    TCGv_i64 t;
+    DisasLabel match;
+
+    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
+        return false;
+    }
+
+    t = cpu_reg(s, a->rt);
+    if (!a->sf) {
+        TCGv_i64 tt = tcg_temp_new_i64();
+
+        if (is_signed_cond(cond)) {
+            tcg_gen_ext32s_i64(tt, t);
+        } else {
+            tcg_gen_ext32u_i64(tt, t);
+        }
+        t = tt;
+    }
+
+    reset_btype(s);
+    match = gen_disas_label(s);
+
+    tcg_gen_brcondi_i64(cond, t, a->imm6, match.label);
+    gen_goto_tb(s, 0, 4);
+    set_disas_label(s, match);
+    gen_goto_tb(s, 1, a->imm9);
+    return true;
+}
+
 static void set_btype_for_br(DisasContext *s, int rn)
 {
     if (dc_isar_feature(aa64_bti, s)) {
-- 
2.43.0


