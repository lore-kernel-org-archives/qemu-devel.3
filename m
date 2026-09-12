Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE68DC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5g-0003nI-0b; Sat, 12 Sep 2026 06:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5E-0001Xj-2K
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:44 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5B-0008UX-Th
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:43 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so284976a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209340; x=1789814140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/aaMe0Gg8UF8VRwBc25oZ69Ww0YRqFMd0yrNRchGJho=;
 b=jUgQcpL28YStjUHLF4OcmMSU7t2GTNT3euLAWJJ7Qck77D5oz70vccnGv/LxF34TS/
 1k6HJk3rnN1BTGbrM7y4ImbiLTe6mAklOraY4iGlq6AJ3efuG94GUVaj0eouDwARmbAV
 5xdlqJyKjUj1QYnv1vkpgWB8TL3OEbg8t38t7jLWLqRHG/l8aoLTQOQOMpERch5lwpIF
 DDxwVsKxJSIb6hSVU8wbFZVKtOe858ML23yWzGwFs5iO4+QWMIFVqCCyIO6c321wHgA9
 Kgq0rXo+CkAuOgx0F08ogMvz9XwGuXoNIQnRcjBdW0ePeQCRQ/+NBA/vurTc/RoZvlSm
 V8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209340; x=1789814140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/aaMe0Gg8UF8VRwBc25oZ69Ww0YRqFMd0yrNRchGJho=;
 b=sru2OMYa33/lgukfyRlwh8I7MdJIWFgicIIBbceoTunvAWcb7LDfo4EKceKVnFntp8
 XFIk1IwWaTO6eeyX95PsKsSCTuj1SFhwZZAaPNOhJZosenK+iH60wjjg2W4tqjq5/a3V
 aLAMOzupczhipowoUZhmYxnkX90e+JwmOdfyPp1sGwssZu4bkmJ+s3aLj0usQtpBH9RG
 n1iui2IE49eQskUb8xLFv/ncN+FafKvL7hX0/EKU1czadkt1w/YKFu/CbJpVC7uVckGF
 CtxytxDP02CwES3twNW/NjxFq7jB8vuZfmOfPCxhBbRwSr3KfzwUCzVfdGg1XSWyQdi5
 om6g==
X-Gm-Message-State: AFuF++lQJu1Vn36rzaHqU61fkRKiyZyoVkQJD5qy7+IpARuN6nxCkgGf
 SHSkh59EM3ZcdMHwk0x5zBLo+3iV31gGos4Zdml9beBZqCkwomFh09Ht7rN4N1VML+1I3/sgRtW
 3vHHcRBQ=
X-Gm-Gg: AYBFou3jgjXZs+qcPcfwVn1VHnL+2DFcxCwmBNnwOSkyrkQnUvdAdSrMfeGMa/WgF6I
 ND7DTqpxEdpmCJtFhqt6Er/wA6Of6qR7zVAeCcpsXdU08TG7ABvTWVRLwZlmTM6PuFfrRaixskd
 +GadFByBQpFyNH5hBuH40GGV6mpgDuT3+u+GCvFLu5LqFxNVzhK33i3q8VHYv0ajTOvRWiaiAsV
 lID9WpwagOXZ/Q4ugOQH9zVCyksQGLXROxnAmeURTyoPJjmRygoLSd/TwCFIAyTdZsLwox0176v
 OVldzIWVcxgQkMb3vKPAVND3I08Bb61WU4awScen2eA2knAqCsi6Z2V8PUMIfrCKvymOlm3JYpJ
 07uw7nIX8LZJUafdOcx3P0p242t2TNUGxsG/2qMWS0yvnSufxBST9OAJNRWl8Dt6tyHkzbhAv2L
 C8sBUhDoIp9GtyTc73dnyzuPUnmbLvsahi9oMvgqBWCSe4EreOMR7gWAXJprc0ICLT/BBNS1Awb
 t1stww=
X-Received: by 2002:a17:90b:1c90:b0:398:d6f4:c61a with SMTP id
 98e67ed59e1d1-39dbc6c4eb6mr4042122a91.17.1789209340427; 
 Sat, 12 Sep 2026 03:35:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/82] tcg: Generic expansion of tcg_gen_ussub_*
Date: Sat, 12 Sep 2026 00:31:18 -1000
Message-ID: <20260912103126.598030-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 944e26c7d28..903949e18b8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -166,7 +166,6 @@ void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -205,7 +204,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 745708c1bbb..19e1eb38dfb 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -58,6 +58,7 @@ DEF_RRR(smin)
 DEF_RRR(sub)
 DEF_RRR(umax)
 DEF_RRR(umin)
+DEF_RRR(ussub)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 566349e8a9a..6c76cecc501 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1144,6 +1144,16 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+    TCGTemp *zero = tcg_constant_internal(type, 0);
+
+    gen_sub(type, tmp, src1, src2);
+    gen_movcond(type, TCG_COND_LTU, dst, src1, src2, zero, tmp);
+    tcg_temp_free_internal(tmp);
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1539,16 +1549,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -2033,16 +2033,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


