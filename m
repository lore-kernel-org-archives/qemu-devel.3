Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9320C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNX-0006vi-KK; Wed, 16 Sep 2026 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN8-0006jP-18
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:27 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN3-0001OW-UC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:21 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae736c64so723075eaf.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564095; x=1790168895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l89D56q/18iSUPe1X0uf1ATQFmUbmr7VQsQm5oIDOzo=;
 b=x4DebskfWPEEt3QE5u+x+uGkLzpl0ddSDKb9O8Yp6DInHdDY7zDQU9bKsNC7rpvgB/
 UIxMAzhobfqmEzGqgOFJZ/mnDdTBSwIMaUy9LMY6LlI/1rc6ZS7caMCl0ksMvna8n7cB
 GbMX7nuT9PauVKHqcd8lMxqI3nAuvjnSA4zfjUFkzkrA60PjKXV24kTpXt+6/E5ZWvcR
 izH4iZzeoPQqg5gm500OXY5FmOYG5A21wfrvXYSV7XDcqjQdBynGcm47y+nUZSEDrZCE
 OKDXCISN/E5QYyVNE08gBKwPLlvWvBOrT2X0hAHkg6090QdJ8IE1dOwFZNeiX0iObqW/
 VuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564095; x=1790168895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l89D56q/18iSUPe1X0uf1ATQFmUbmr7VQsQm5oIDOzo=;
 b=TQg1paO5s0mlAwvEhImQlNLBk4eZHvk2dTpDRm1AtVja9M7Oo8CX1VUM4szGP3tIDZ
 rKvsVJ1/c9Sf3q4O0xOZRxgJXNMEmhDNbDx4U/MZLFB/IDrALRNWBNvgulAYU/w/E+nP
 /v9QAkmQbZ9K3TkUk1WPvM3N+7XXb5nX5vOF4ytj3vAYR7fb2ZJzIeueaJ1rw8nfyfOs
 lvIx617Kw+JD0gCWDd0fkzxFfQPsgWyHYA6EsmQpGDJB9tqktYh2VweZQeuw5kGAGRtC
 F26fLKceDqn7vmHo5J0/2sLjpazsToeDKdf07f1CUYglF35UtTXAHVJqwpVVTglflbJZ
 JL0w==
X-Gm-Message-State: AFuF++mEZYGPbvb+mLu44tnKSu3Gwbx+fIUtvjaW2Haut3LrYUYfTxx1
 IX14QBg0ufPoA5KY9X5hXYVp+mh8n6rbWEPRH6JTKqb6CTKmBBwy4XZC6xF5xbAS/xSpTcbnU3S
 KB3Wq51I=
X-Gm-Gg: AYBFou0IvJL7atWpYbTo0CraL2gZ2kG8OwnwmGBfdWP/E7YfItFA6CfK9eooCcluBB0
 t7sSqFCi81mC9nGjXsxvMtLCn9v/zgG8i7GhSTJx8KUA+2tOYk4ZvMKIr2PFX/sJLx+SgzBdiDj
 orAzIi/tnqvn9RDzY4WcOsAmGxRGaGNe9fQC6lE7LTFR+aC7uXBMZc70cdS8d8zBK+H6abHkaSJ
 Ts8xY/gaIZQyO1TQC5AJjc3p9NeFYBnya4axgZOpqmFaxL9LN/J1eIeZ7/3+PqaX9SytFyUqysP
 MbkOKhD+56YSFHgMHEtxZuD3LFqkPLoxcuC0UKhpEJxiAyqK5TE7fldVsXOIl60I6F3uO2A+okx
 OlwC5a/cg2xz+N8T58sar0JjHde8JCSyDTGL6Xx752ZmP/MWO1XJYWC9r6+8JtlComTQabCcpvg
 Y9/pY7cTBeO5Vd4aJhcegC7GIKpHgVZqmcQPCBA6v7mwYjk+C8tuDHGj2dXcX6c2n7mCUYuixPM
 z/qais=
X-Received: by 2002:a05:6820:1501:b0:6c3:bfee:dea3 with SMTP id
 006d021491bc7-6c7d0edd677mr2771083eaf.18.1789564095050; 
 Wed, 16 Sep 2026 06:08:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 41/92] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Wed, 16 Sep 2026 03:03:16 -1000
Message-ID: <20260916130409.3382710-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++--------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 31d35780739..006f668aa5f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d2bbf9ba017..63e87c8313b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e42ee3f08a1..17251a8be93 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -477,6 +477,12 @@ static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                        int64_t src2, TCGLabel *l)
+{
+    gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -741,15 +747,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1540,11 +1537,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.53.0


