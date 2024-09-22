Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6269CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHl-0001yr-75; Sun, 22 Sep 2024 08:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x0-RY
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHL-0002On-GU
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:30 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a90188ae58eso423968866b.1
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006485; x=1727611285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4uFa1EewNZVM8eb9T0XGX/kCpjVJLtWV1XZpTNAvas=;
 b=Q+Iykkjnbab51oOZvahz3r/fIqJIi4CJGWXPJgvj+T+QJ1fFnUOs5wmfkhhgOXEeVQ
 QaW0wTfLqeJ4zXTCFNBiGHSAnjAD1dh7WycV30YlKqNzYhj4tk7MfW+bIFpKku715Xb2
 n6LZp+1xCFcXj24wy+Q+9Q5AILiwCI5QQ1x70IS+MKA2S39vbldoSxYYywy5YnZVKcEd
 bYARQpeao3KDBBkxPcq/3TT6S9ajRs/wWk67FGYwixb1a6viV+b8jb6kUF2IdeYiIirq
 bGi5OLnfiBecWtkRR8VWVGpLjbe9ekpscOFSjTFY+AbTv4JIfbKwK4ltMaOkXT6wlOkj
 NVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006485; x=1727611285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4uFa1EewNZVM8eb9T0XGX/kCpjVJLtWV1XZpTNAvas=;
 b=dnCu4lXDliw7ath7lwN0bUg16FzFPZlnNdCGfR23/AzRpt1I6BkmeSgykp4O4HN6BC
 ZhwIQ/gfDzfxlQLVebZmdW0cVnI4FhBPxfM3GdG/EeIvkqJEvxTDpv82fQH3Q21CNCDV
 etAplU5Jw2BEKkr9e0GUu2hDVNiM8SJcQURTHieHPPOYdqU5MHHk0AEP5IHayl8eTVB+
 9YO/7gtbOuuYumE8Xm/vK1ddOfuM/aMKUNpn59rwiFzKFFf4R6P5ox54qdXZ+Jxtd6+e
 Ebc50fG+zBQZxtsCH2scfCiL0Punf5tvJwwVcLW8qjplzI38bceCO2NO3yuSIeR4XmqT
 uenQ==
X-Gm-Message-State: AOJu0YynMjTCQpcDgXNgGZWNi4hqi5lbqizKSEeIjo02NBVe9GV3Ybw4
 mNMG3BGQ2cutdEIYpAcBZku/s+Egl0GmkngDobP93Og2pN9PTRqW9T5FeyA3O+54/RWlLLPnd+E
 qhwA=
X-Google-Smtp-Source: AGHT+IHO5hcJDUVcTwGdZ9K03yek5P4U6vPpcBlJjteAiCAHeKkqWH5X1+aM0JMUm/GpNxa2s27FKg==
X-Received: by 2002:a17:907:86a2:b0:a8d:4b70:b09a with SMTP id
 a640c23a62f3a-a90d56dcab6mr775042966b.20.1727006485106; 
 Sun, 22 Sep 2024 05:01:25 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 19/31] tcg/ppc: Optimize cmpsel with constant 0/-1 arguments
Date: Sun, 22 Sep 2024 14:01:00 +0200
Message-ID: <20240922120112.5067-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

These can be simplified to and/or/andc/orc,
avoiding the load of the constantinto a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  2 +-
 tcg/ppc/tcg-target.c.inc     | 43 +++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index e7ba00c248..453abde6c1 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -33,7 +33,7 @@ C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
-C_O1_I4(v, v, v, v, v)
+C_O1_I4(v, v, v, vZM, v)
 C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9d07b4d8e6..3f413ce3c1 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3725,6 +3725,11 @@ static void tcg_out_or_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
     tcg_out32(s, VOR | VRT(a0) | VRA(a1) | VRB(a2));
 }
 
+static void tcg_out_orc_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, VORC | VRT(a0) | VRA(a1) | VRB(a2));
+}
+
 static void tcg_out_and_vec(TCGContext *s, TCGReg a0, TCGReg a1, TCGReg a2)
 {
     tcg_out32(s, VAND | VRT(a0) | VRA(a1) | VRB(a2));
@@ -3827,15 +3832,30 @@ static void tcg_out_cmp_vec(TCGContext *s, unsigned vece, TCGReg a0,
 }
 
 static void tcg_out_cmpsel_vec(TCGContext *s, unsigned vece, TCGReg a0,
-                               TCGReg c1, TCGReg c2, TCGReg v3, TCGReg v4,
-                               TCGCond cond)
+                               TCGReg c1, TCGReg c2, TCGArg v3, int const_v3,
+                               TCGReg v4, TCGCond cond)
 {
-    if (tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond)) {
-        TCGReg swap = v3;
-        v3 = v4;
-        v4 = swap;
+    bool inv = tcg_out_cmp_vec_noinv(s, vece, TCG_VEC_TMP1, c1, c2, cond);
+
+    if (!const_v3) {
+        if (inv) {
+            tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v4, v3);
+        } else {
+            tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
+        }
+    } else if (v3) {
+        if (inv) {
+            tcg_out_orc_vec(s, a0, v4, TCG_VEC_TMP1);
+        } else {
+            tcg_out_or_vec(s, a0, v4, TCG_VEC_TMP1);
+        }
+    } else {
+        if (inv) {
+            tcg_out_and_vec(s, a0, v4, TCG_VEC_TMP1);
+        } else {
+            tcg_out_andc_vec(s, a0, v4, TCG_VEC_TMP1);
+        }
     }
-    tcg_out_bitsel_vec(s, a0, TCG_VEC_TMP1, v3, v4);
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3944,8 +3964,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_not_vec(s, a0, a1);
         return;
     case INDEX_op_orc_vec:
-        insn = VORC;
-        break;
+        tcg_out_orc_vec(s, a0, a1, a2);
+        return;
     case INDEX_op_nand_vec:
         insn = VNAND;
         break;
@@ -3960,7 +3980,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_cmp_vec(s, vece, a0, a1, a2, args[3]);
         return;
     case INDEX_op_cmpsel_vec:
-        tcg_out_cmpsel_vec(s, vece, a0, a1, a2, args[3], args[4], args[5]);
+        tcg_out_cmpsel_vec(s, vece, a0, a1, a2,
+                           args[3], const_args[3], args[4], args[5]);
         return;
     case INDEX_op_bitsel_vec:
         tcg_out_bitsel_vec(s, a0, a1, a2, args[3]);
@@ -4330,7 +4351,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_msum_vec:
         return C_O1_I3(v, v, v, v);
     case INDEX_op_cmpsel_vec:
-        return C_O1_I4(v, v, v, v, v);
+        return C_O1_I4(v, v, v, vZM, v);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


