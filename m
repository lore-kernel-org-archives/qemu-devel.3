Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C071CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUzE-0001em-Jg; Fri, 05 Sep 2025 07:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUz1-0001bY-4Y
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUym-0003Z3-7Y
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45b83ae1734so12213075e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073096; x=1757677896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B99K9Dv9ZtO1Q8pfxV+jw9jadiWOHe4ZFjv0MH8KRzU=;
 b=jRgSsno4U4GNhK4I5m+383DJmwnVwBVmsCu0hGEgJc7d7HkRucNbkYYHNoM9XK8LLO
 AL7zlaqFOQvCdru2Ygodcfa05GteoiwFITHXmjyiJ+eLPNWF9lxrDM3mLRwfx3r3Yc4+
 aj4UWjxZ2g3ZuqxY0rYrnsPF1g3RJee6hLB5VLrn0T+D9fsd7SehaM+7LUpghZr35oGA
 Bv7o2ySwsf/HfiVbY5TJD8GJHb1wALPY9sq2PTNpJzoNw5urKhNyw8f9cq+Ck3Ex0Xft
 lEoU+EPVPiTJjcrtdgFXdxSzD9qbnql3o6e101SqW2tq894zyr6J7ifbssnibs2pbhdV
 q+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073096; x=1757677896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B99K9Dv9ZtO1Q8pfxV+jw9jadiWOHe4ZFjv0MH8KRzU=;
 b=wOo2+bOR01HxGMSOgdDlFRHgQNuCcl+JgHVV9x0LtqHhfUcDXqqBnDh2LqOhuKYbHz
 L9ZrSIMUyGMk5+nAs7U/D0yjOf5uNZP6SGsU07xjShsYidYmIucSGBiWY04g5rs/xF/X
 1HeIqaOotstMcZrvenLhPsIYt8++wOgzVG2ePSSwWTnuUM8iQLYgEMGpgL1cpqVvPpcV
 zxaQkQwoEvas1R80pfRBtlPFxI91lYe1JZ5mYJTe7XzoDWObloFVtMc8iIpK468xRDnX
 cj68VKPqqLYML1G8TLhD4fQ65WijmfBPt1kf4EI2Ik+BRnHmEXhpJd8Jx9PR+fHCaoIr
 q8iw==
X-Gm-Message-State: AOJu0YxTwLmP0lb19G1JiZt/wG5bBBGsfB/mOPan9Oe0STBK1UhJTks6
 TFNuDZv+aGo5/IVzn6e0zekuAK+HGbR9EYlua1kXng3tUVCUZH2mIRLaD2zjRAlEPEG5a9i28qS
 aB9UKrmU=
X-Gm-Gg: ASbGnctSwvNLusLRWzsEck/POA3uN7nvnF2DP4H+7mw5THxF13OqiOzWJb7aPV4Wakr
 zaUBO9dCE5jFoViQ8fltpkG7dfVEj4+4ubLNqFvaAhN2424Wio0BLFH64ItoZuxiPC4mc+vJaU1
 gGuxp/GJKOi6CCU6VTtQ2RPxd3782Pwch/txW/DOeqGeU69CFldaRhdBCdvZI4fW5Je2QKTYHrs
 /8nfCt0P9cSP3yfwDAmQ8/7kLcQW7y0wF7exqiZwtOCfhuovmRvrsk93Y6TiCmTayNgr4TaOWa6
 HcMQxUpZMZZgnh+OyRoFiKXVNJkxXEQXdwdON7hH5U2brUTMi2RlBr0WMZ72G/7xPcps4kIHXxh
 L+0UCEwbz7IHcQH8PQvWlcHSb5pr1dxrJwEDWrqkS5yhZ2VvTU3QOUkIJ
X-Google-Smtp-Source: AGHT+IG98cPYSN61pNWZAn9mgybnfPrmrqP/rL0L0ltI0bEapIFp9wTv/gnxd2M6Py+INCMUDip85Q==
X-Received: by 2002:a05:600c:1e89:b0:45d:d903:beea with SMTP id
 5b1f17b1804b1-45dd903c5admr21045525e9.30.1757073095918; 
 Fri, 05 Sep 2025 04:51:35 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 7/7] target/sparc: Relax decode of rs2_or_imm for v7
Date: Fri,  5 Sep 2025 13:51:28 +0200
Message-ID: <20250905115128.376295-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

For v7, bits [13:5] are ignored for !imm.
For v8, those same bits are reserved, but are not trapped.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 56 ++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cfdd9c1ce4..810e2491a6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2526,6 +2526,32 @@ static int extract_qfpreg(DisasContext *dc, int x)
 # define avail_VIS4(C)    false
 #endif
 
+/*
+ * We decoded bit 13 as imm, and bits [12:0] as rs2_or_imm.
+ * For v9, if !imm, then the unused bits [12:5] must be zero.
+ * For v7 and v8, the unused bits are ignored; clear them here.
+ */
+static bool check_rs2(DisasContext *dc, int *rs2)
+{
+    if (unlikely(*rs2 & ~0x1f)) {
+        if (avail_64(dc)) {
+            return false;
+        }
+        *rs2 &= 0x1f;
+    }
+    return true;
+}
+
+static bool check_r_r_ri(DisasContext *dc, arg_r_r_ri *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
+static bool check_r_r_ri_cc(DisasContext *dc, arg_r_r_ri_cc *a)
+{
+    return a->imm || check_rs2(dc, &a->rs2_or_imm);
+}
+
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
@@ -3249,8 +3275,7 @@ static bool do_wr_special(DisasContext *dc, arg_r_r_ri *a, bool priv,
 {
     TCGv src;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
     if (!priv) {
@@ -3693,8 +3718,7 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a,
 {
     TCGv dst, src1;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri_cc(dc, a)) {
         return false;
     }
 
@@ -3778,11 +3802,11 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     /* OR with %g0 is the canonical alias for MOV. */
     if (!a->cc && a->rs1 == 0) {
+        if (!check_r_r_ri_cc(dc, a)) {
+            return false;
+        }
         if (a->imm || a->rs2_or_imm == 0) {
             gen_store_gpr(dc, a->rd, tcg_constant_tl(a->rs2_or_imm));
-        } else if (a->rs2_or_imm & ~0x1f) {
-            /* For simplicity, we under-decoded the rs2 form. */
-            return false;
         } else {
             gen_store_gpr(dc, a->rd, cpu_regs[a->rs2_or_imm]);
         }
@@ -3799,8 +3823,7 @@ static bool trans_UDIV(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_DIV(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3851,8 +3874,7 @@ static bool trans_UDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -3889,8 +3911,7 @@ static bool trans_SDIVX(DisasContext *dc, arg_r_r_ri *a)
     if (!avail_64(dc)) {
         return false;
     }
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4186,8 +4207,7 @@ TRANS(SRA_i, ALL, do_shift_i, a, false, false)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
     if (imm || rs2_or_imm == 0) {
@@ -4250,8 +4270,7 @@ static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
 {
     TCGv src1, sum;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+    if (!check_r_r_ri(dc, a)) {
         return false;
     }
 
@@ -4369,8 +4388,7 @@ static TCGv gen_ldst_addr(DisasContext *dc, int rs1, bool imm, int rs2_or_imm)
 {
     TCGv addr, tmp = NULL;
 
-    /* For simplicity, we under-decoded the rs2 form. */
-    if (!imm && rs2_or_imm & ~0x1f) {
+    if (!imm && !check_rs2(dc, &rs2_or_imm)) {
         return NULL;
     }
 
-- 
2.43.0


