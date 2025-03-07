Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD33C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIV-00012L-2x; Fri, 07 Mar 2025 10:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIS-00010i-OF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:32 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIQ-0008Jj-SB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:32 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso12153845e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360049; x=1741964849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pPEjy4gO+6lS+Bi1oqacrZc1QhZKm+yak03NfzfqAsw=;
 b=t2EMNZ++qJx5fv9sixt/Jw0M8R7n4nyS+rzPINwk5BhuqWmNnCs1Gqq7cakZ/2EYq4
 Sn4qU6yVG2stVwRRLDm+o7D9rGUc/IO4oGaWDCnSnhSTN2C7/gCqgKmUWWdAU2Mwtdxo
 I4YR6vOt9CjojMsKXSSExa4bLC/FsK4Yk2e4U4DrvMYu2BKSh+0L67jYQyf1HRCA8sCt
 m5Sk3d0OgZ2CKtwx6aObL8khVc3QxSvOIDNZa5VbyMMrqXcpSRoaDilUXDlX3SY33Rbt
 9oITBGqqAld0+CUPppZWSIvT0Zu9UTe9cH1PXXM5211kkBD5UjXXJOhbdY63OqpZKQ1i
 u+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360049; x=1741964849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPEjy4gO+6lS+Bi1oqacrZc1QhZKm+yak03NfzfqAsw=;
 b=KBg97R18f1pdbGMELpt4yXgf7b0Rt29hLzn0yMVnkMt1sYaPwe7T/U5aUuZvzfBgpj
 vbSG+ps+mfaCH84/GegnOXKXhZiQi160auF/LbLYVE0pjRlBxkwbVnZ/pntozh1gUil/
 Od3DNu+Rla6meyQ4FnDiGG2pzj7CpFBjuc3d2JkgunkANf2e1+7Y3/0Yp4d18IszjBUu
 tvG3A+fuqgBfs16w1B9eNhZkcs1KZ/pSdSQX0/ILjO58aGaJUrsiUe+btAyWEOo6ysLM
 toT8VHQuyeBOIC/SpOVc4vccbf2vb2wXnxDq8jl9gnYiK+s048Q0cTsuaN1UbUNytIcg
 bPkQ==
X-Gm-Message-State: AOJu0YzXrUr+W0WzLbCyhRGtz2qGBwSx1vtJj90y5G2DLcskDfUlsMsq
 pVbJckhOczaq9omrMwmiISoqC2ZQ5/MDXueFHvV1wzIvsobk50NzQ8CfGs+/PZupF3CSR/E4TRg
 r
X-Gm-Gg: ASbGncu+1UzVwfxojgYTMe7M3MUf18G8HIBJ22FM4LN+l5ai/Go53Baf9gqIo+7uyB/
 6FNqnjdZcEFSv4n6q2d1JYVTngsmCOh3khB0epLfRv8Qu9kZmrLIOxz8/tYtGUo9/HBv3V1PEt+
 kbtbas60+kUmaDA0ZgULdyG9SA4tIG5N4etEm3sXVlmJBMoOLM/GvLOF87NPcB1ef/R5MFNtma2
 kak0Z5/xJtD3Vrn+Ga3W6uhnkKd0UnQ1PQFriNkdqnEpnjmlwNHQA/GuQGc0sCFHzsDc3Ek0bWC
 PRO7sooIs2IZP5s8U/nsCbV+3LzLpuU3MNpJ0+xNnuqtrsqEX1g=
X-Google-Smtp-Source: AGHT+IGtyuJfAD9aeJVzXV0pEFUm2Ao+aqvWyESaqgen7GqYPctv2Mw9AA0ElZNq+Sup427lp00rTg==
X-Received: by 2002:a5d:6daa:0:b0:391:2d61:453f with SMTP id
 ffacd0b85a97d-39132d71099mr1908488f8f.24.1741360048714; 
 Fri, 07 Mar 2025 07:07:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/21] target/arm: Drop unused address_offset from op_addr_{rr,
 ri}_post()
Date: Fri,  7 Mar 2025 15:07:02 +0000
Message-ID: <20250307150708.3222813-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

All the callers of op_addr_rr_post() and op_addr_ri_post() now pass in
zero for the address_offset, so we can remove that argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250227142746.1698904-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 404a254678a..d2800181388 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4941,7 +4941,7 @@ static TCGv_i32 op_addr_rr_pre(DisasContext *s, arg_ldst_rr *a)
 }
 
 static void op_addr_rr_post(DisasContext *s, arg_ldst_rr *a,
-                            TCGv_i32 addr, int address_offset)
+                            TCGv_i32 addr)
 {
     if (!a->p) {
         TCGv_i32 ofs = load_reg(s, a->rm);
@@ -4954,7 +4954,6 @@ static void op_addr_rr_post(DisasContext *s, arg_ldst_rr *a,
     } else if (!a->w) {
         return;
     }
-    tcg_gen_addi_i32(addr, addr, address_offset);
     store_reg(s, a->rn, addr);
 }
 
@@ -4974,7 +4973,7 @@ static bool op_load_rr(DisasContext *s, arg_ldst_rr *a,
      * Perform base writeback before the loaded value to
      * ensure correct behavior with overlapping index registers.
      */
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     store_reg_from_load(s, a->rt, tmp);
     return true;
 }
@@ -4999,7 +4998,7 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
     gen_aa32_st_i32(s, tmp, addr, mem_idx, mop);
     disas_set_da_iss(s, mop, issinfo);
 
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5059,7 +5058,7 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     do_ldrd_load(s, addr, a->rt, a->rt + 1);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5111,7 +5110,7 @@ static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
 
     do_strd_store(s, addr, a->rt, a->rt + 1);
 
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5147,13 +5146,14 @@ static TCGv_i32 op_addr_ri_pre(DisasContext *s, arg_ldst_ri *a)
 }
 
 static void op_addr_ri_post(DisasContext *s, arg_ldst_ri *a,
-                            TCGv_i32 addr, int address_offset)
+                            TCGv_i32 addr)
 {
+    int address_offset = 0;
     if (!a->p) {
         if (a->u) {
-            address_offset += a->imm;
+            address_offset = a->imm;
         } else {
-            address_offset -= a->imm;
+            address_offset = -a->imm;
         }
     } else if (!a->w) {
         return;
@@ -5178,7 +5178,7 @@ static bool op_load_ri(DisasContext *s, arg_ldst_ri *a,
      * Perform base writeback before the loaded value to
      * ensure correct behavior with overlapping index registers.
      */
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     store_reg_from_load(s, a->rt, tmp);
     return true;
 }
@@ -5203,7 +5203,7 @@ static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
     gen_aa32_st_i32(s, tmp, addr, mem_idx, mop);
     disas_set_da_iss(s, mop, issinfo);
 
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
@@ -5216,7 +5216,7 @@ static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
     do_ldrd_load(s, addr, a->rt, rt2);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
@@ -5245,7 +5245,7 @@ static bool op_strd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 
     do_strd_store(s, addr, a->rt, rt2);
 
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
-- 
2.43.0


