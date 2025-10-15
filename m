Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F8ACCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95pD-0003tf-1H; Wed, 15 Oct 2025 14:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95ov-0003oS-Uc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oo-0006H6-Qe
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so70259855e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551302; x=1761156102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnmxi6Yf1MiEzeJwE97RY8q8VnjAUodXcAwkoIgszys=;
 b=kf3JikzebyhXefCRtUhTSfahVJI5YJJxyBJYrsXTBdQL2n/vdClIbhNxnhEHYCKLke
 LJT5O3+ln25MfMVypy9uPwjToTr89RC7dq8s9ltseYTvWggGizQBw8LlO4Zikw7OBDHJ
 aBTnb8FrY3MTGIwGZudUS6X6ZavpD6eoDvQgG5hyL9E32ChpIMGUTf7aMwO15t/O6nXT
 Cnjyu0bU3ZJmfBH5ppUqHHStjH1mLZFO3fRsdRCzynFXgTZsv6MvGD5MjWFEV2DS3e4g
 GsuNlMq9gY69N0mYckoUVIsNQw9p0l7ClDAb7gG8kwx0MiAyFuYymJyBjXJHM7bAzA3M
 Laig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551302; x=1761156102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tnmxi6Yf1MiEzeJwE97RY8q8VnjAUodXcAwkoIgszys=;
 b=D0rufAuFe2VOzJjNXwiryLxweLOx1f1MM3FniaJsFObSNgnI3a9dp3dtqtyWDte4Ck
 XnN1PHhin8XT/Qdx8x0BHGcFsEZq8srP+/3SRGTfrr3i+OhZBAwv8XtdzuMIB0z/iPZF
 lCut0JwHBLTvtriiaYtzFiZ3lSReWhCXfut5LkVAhxRxB6pXYSElsEmzHgZHbHY/CsSH
 yY3mLd2SOd91Y5P4bi/P6eh7OSOuKRTkso+G8ZprGDtweLym553hNem2T1En4cZEILCG
 zNSRimW+qGh0hm61UQ//v/2ZYFGoN4JHWrKni3n44uZ0m80BnrBqjyJk+VMek8Sn1363
 kgcg==
X-Gm-Message-State: AOJu0YxkvTEYuqFK1RvdegNRaptMEbctPrP8y0v/bOu01pWbxcpeoATX
 31HMyyGLHkTrkWPYpqzW3E4WgsVjOLJfGL0YtsQuoazuNIaehj2DPk6VPK1safFpcf1aDC7Ecrb
 wZMcHdqJx0w==
X-Gm-Gg: ASbGncve48deCXzEAG3+dSWVERmQQZ1pKbpLV6xiEWVcUOY00nQFfuUGx+3Xj+Gifih
 lenqOwTcPyMJMElGbrn18hCQJ1LSzvAJQjUfsDrZmVwm+XyEZyCYwjrQJTyKjJETtkYMppuCbyJ
 A0sRQk4CdTq/3Vh6/2LHWsK4wESAKZIwcBSzHp4q5bGFTXVOQaOE9rklCTZ8Y6R+RWFMOUSqFUv
 bw+MGfI+5P5HXuTffMYuaRqqPfC862UBO6b8b/Tw4j2OTVKTc2gpK9rg/LZW5aSp8yKAGBQzz3+
 Inb2nOSBh1G8uTYmHq7OakqF7i79PxH3f+0DGl0Luq9bMr6MRN9y7pg+2CmsRI1IPDUgU1zuTQN
 EqLb+nk2ZtSYiI3H+7StVY1z3nO6l3biE52D2mzSiajXSIPvnxcubrPE+CMe9VLkAl2XTk82tm+
 4wAVLaxH8NUC6G29+R7043zKs/DqGw9Q==
X-Google-Smtp-Source: AGHT+IHxETPHhXfkvEHUPr6lIoDY0cpRUgl/peY+oC1AjcHDIEfgpYeuxeQprGMcN7VTmoLz+bDtPQ==
X-Received: by 2002:a05:600c:4e47:b0:46e:652e:16a1 with SMTP id
 5b1f17b1804b1-46fa9a8b482mr216328015e9.7.1760551301921; 
 Wed, 15 Oct 2025 11:01:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb483bcf9sm316996965e9.6.2025.10.15.11.01.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/7] target/microblaze: Have compute_ldst_addr_type[ab]
 return TCG_i32
Date: Wed, 15 Oct 2025 20:01:13 +0200
Message-ID: <20251015180115.97493-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Both compute_ldst_addr_typea() and compute_ldst_addr_typeb()
bodies use a TCG_i32, so return the same type.

Suggested-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 994e1d5cef0..1554b9e67b0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -604,7 +604,7 @@ static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 DO_TYPEA(xor, false, tcg_gen_xor_i32)
 DO_TYPEBI(xori, false, tcg_gen_xori_i32)
 
-static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
+static TCGv_i32 compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
 {
     TCGv_i32 ret;
 
@@ -626,7 +626,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
     return ret;
 }
 
-static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
+static TCGv_i32 compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 {
     TCGv_i32 ret;
 
@@ -750,13 +750,13 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_lbu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lbur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -776,19 +776,19 @@ static bool trans_lbuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lbui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_lhu(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lhur(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -810,19 +810,19 @@ static bool trans_lhuea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lhui(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_lw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -844,16 +844,16 @@ static bool trans_lwea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_lwi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_load(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_lwx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
 
     /* lwx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index,
                         mo_endian(dc) | MO_UL);
@@ -910,13 +910,13 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
 static bool trans_sb(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sbr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, true);
 }
 
@@ -936,19 +936,19 @@ static bool trans_sbea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_sbi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UB, dc->mem_index, false);
 }
 
 static bool trans_sh(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_shr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, true);
 }
 
@@ -970,19 +970,19 @@ static bool trans_shea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_shi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UW, dc->mem_index, false);
 }
 
 static bool trans_sw(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swr(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, true);
 }
 
@@ -1004,19 +1004,19 @@ static bool trans_swea(DisasContext *dc, arg_typea *arg)
 
 static bool trans_swi(DisasContext *dc, arg_typeb *arg)
 {
-    TCGv addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
+    TCGv_i32 addr = compute_ldst_addr_typeb(dc, arg->ra, arg->imm);
     return do_store(dc, arg->rd, addr, MO_UL, dc->mem_index, false);
 }
 
 static bool trans_swx(DisasContext *dc, arg_typea *arg)
 {
-    TCGv addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
+    TCGv_i32 addr = compute_ldst_addr_typea(dc, arg->ra, arg->rb);
     TCGLabel *swx_done = gen_new_label();
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
     /* swx does not throw unaligned access errors, so force alignment */
-    tcg_gen_andi_tl(addr, addr, ~3);
+    tcg_gen_andi_i32(addr, addr, ~3);
 
     /*
      * Compare the address vs the one we used during lwx.
-- 
2.51.0


