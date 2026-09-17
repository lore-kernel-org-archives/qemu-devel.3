Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C3AC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x78Uk-00048f-5y; Thu, 17 Sep 2026 05:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ug-00047R-VK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:27 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x78Ud-00018v-Ov
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 05:33:26 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc5121bcf1aso499639a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789637602; x=1790242402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q7FtXeSlpHd7K2MQSSg1jn7qqLWOBMuIhaVJ0YR20XA=;
 b=P7/FP0JdaBKkctIZQi9yaN3yeVcZkbCQKyT7peFPC49P9uSa6dVuHT1tfQ92S7+KvB
 VLnBhzc5bTQskag1rtIH+T7B+cExjiBGanDBsW6WH8OZdx5lnChYI6RKDYqFmO/w4VWj
 wvX6aol9nBWBY3j9QHdb1X1rHHqFkKv07ic9PhQkWKtSnIJC6FM2cAZ3MAtSwwhom8G8
 2kyK2BLHiyZIWX11/zwMaobIzt8VF/BOhWu6TqtIay3bFzNln2QdTeTFH/Bv3oK3yGUj
 SwSPWvVDuHcaNR7dVTuFZBuXtxa7SNw5gUaswgSURk6FrijhaRp5fWZ1ybkL8Oyp+E7b
 9Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789637602; x=1790242402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q7FtXeSlpHd7K2MQSSg1jn7qqLWOBMuIhaVJ0YR20XA=;
 b=eROrZHvQojPY4naGsFoQREE6nHuWe7TwR4+VotIzi4zTtggDKWYoMd6pKLry6fp3nJ
 QozcYBP0ozU4DgPiz5vh0mN2moPIqqbQK4trk38D3d7IKYGyVVW3bDFQ5lwQB+ItMlm9
 UPbBODBuHdPLlLwSrxtcieBbSl5RTLeFtwu17Y44VepJSWfPIlKGby6/jj/MjxXWJsBc
 q0vystkeeSquHFBOK7MAwCfFggQedOqKDzKQ/Xbtr+xl63WOPgiIkS0DXdFv/wKo2gbD
 K0j7gX+aZTN5NMONjLl13V4pHwSH0ue9RPHhtZKzlcxXH9JKegqojHwDhxn2DY1x+wAj
 P8tw==
X-Gm-Message-State: AFuF++n91X1e9XFPi3Y6dv7+RMTWQSTUnVUXi+xVkR+deR4biKrkcE7f
 htwmPCA/ouurkQG2LgdclDEj+lI/ePKWIAKsLXvtkVCSnkpdHxZDze9q4H6FbRmSb8E/p/qFkQq
 6mgBTKFM=
X-Gm-Gg: AYBFou2Xe55CftCUnfpck6LOk82Onw46EPWrsDNsFUx/ta3nkQDHZ75m4tfrTwH4Fve
 SvJCxDTCqpqJAlghhc+9wVayKTvemmZqVKKi7p+CG8U5ADza0qjMc0PVUiHByYRI9vrrxBdtLvJ
 dfgTUpWe+rnWMl0ijsV09P7lnzMF6t3Tup6nQsvQGA+TDX3YAZkQhwpKYcmdBg6b75oj7+aTy5Q
 uPc3OVj46g+UWNZnagJj87QejCBOTTv65KaS1/jRjiilUh4SPM9OqZHl6XGx4AXL/P/pb+mlgae
 FWeH5w4Rbz83dboCmqhIzSDq2NoLhhIcg0KliNgBWEw5T+zQyhtAnDeQU4zuvopy1PdcamsaPQO
 l8zcHoEWYHsYSdGVRpRcFSFMbngkkJBG+z6yg/m+dvwvaejpxbKNEtSYNPeWt0FN6lQdlkoLCKg
 r7QexrlRAIPgJ2C8BJf1LG48ih1jNEr18aKEcUdrx1g4ihjaNLFjggIwxyEfOFA5Jwgaw6GZje3
 E8mAdI=
X-Received: by 2002:a17:90b:4408:b0:39d:ec24:5ffe with SMTP id
 98e67ed59e1d1-39e1e284fd8mr12855099a91.9.1789637602269; 
 Thu, 17 Sep 2026 02:33:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm12494696c88.15.2026.09.17.02.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:33:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 11/13] tcg/x86_64: Implement INDEX_op_goto_jc
Date: Wed, 16 Sep 2026 23:33:05 -1000
Message-ID: <20260917093307.1092084-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917093307.1092084-1-richard.henderson@linaro.org>
References: <20260917093307.1092084-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
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

Use comparisons vs memory, short branches, and
an indirect memory jump.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target-con-set.h |  1 +
 tcg/tcg.c                       |  1 +
 tcg/x86_64/tcg-target.c.inc     | 63 ++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 5af8c1cb2cd..f3359ae5bce 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -26,6 +26,7 @@ C_O0_I2(x, r)
 C_O0_I3(L, L, L)
 C_O0_I3(s, L, L)
 C_O0_I4(L, L, L, L)
+C_O0_I4(r, r, re, re)
 C_O0_I4(r, r, ri, ri)
 C_O1_I1(r, 0)
 C_O1_I1(r, L)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a08e83f3954..2650119dedb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -61,6 +61,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/guest-base.h"
 #endif
+#include "../accel/tcg/tb-hash.h"
 
 /* Forward declarations for functions declared in tcg-target.c.inc and
    used here. */
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 08dec0dace8..7f510545b48 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -1531,6 +1531,25 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
     return jz;
 }
 
+static void tgen_cmp_mem_reg(TCGContext *s, int rexw, TCGReg reg,
+                             TCGReg base, intptr_t ofs)
+{
+    tcg_out_modrm_offset(s, OPC_CMP_GvEv | rexw, reg, base, ofs);
+}
+
+static void tgen_cmp_mem_imm(TCGContext *s, int rexw, int64_t imm,
+                             TCGReg base, intptr_t ofs)
+{
+    if (imm == (int8_t)imm) {
+        tcg_out_modrm_offset(s, OPC_ARITH_EvIb | rexw, ARITH_CMP, base, ofs);
+        tcg_out8(s, imm);
+    } else {
+        tcg_debug_assert(imm == (int32_t)imm);
+        tcg_out_modrm_offset(s, OPC_ARITH_EvIz | rexw, ARITH_CMP, base, ofs);
+        tcg_out32(s, imm);
+    }
+}
+
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
@@ -3344,8 +3363,50 @@ static const TCGOutOpLea outop_lea = {
     .out = tgen_lea,
 };
 
+static void tgen_goto_jc(TCGContext *s, TCGReg ptr, TCGReg pc,
+                         TCGArg cs, bool const_cs, TCGArg fl, bool const_fl,
+                         TCGLabel *label)
+{
+    /* ptr is CPUJumpCache */
+
+    /* Validate pc match */
+    tgen_cmp_mem_reg(s, P_REXW, pc, ptr, offsetof(CPUJumpCache, array[0].pc));
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Load and validate tb non-null */
+    tcg_out_ld(s, TCG_TYPE_PTR, ptr, ptr, offsetof(CPUJumpCache, array[0].tb));
+    tcg_out_brcond(s, P_REXW, TCG_COND_EQ, ptr, 0, true, label, true);
+
+    /* ptr is now TranslationBlock */
+
+    /* Validate cs_base match */
+    if (const_cs) {
+        tgen_cmp_mem_imm(s, P_REXW, cs, ptr,
+                         offsetof(TranslationBlock, cs_base));
+    } else {
+        tgen_cmp_mem_reg(s, P_REXW, cs, ptr,
+                         offsetof(TranslationBlock, cs_base));
+    }
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Validate flags:cflags match */
+    if (const_fl) {
+        tgen_cmp_mem_imm(s, P_REXW, fl, ptr,
+                         offsetof(TranslationBlock, flags));
+    } else {
+        tgen_cmp_mem_reg(s, P_REXW, fl, ptr,
+                         offsetof(TranslationBlock, flags));
+    }
+    tcg_out_jxx(s, JCC_JNE, label, true);
+
+    /* Jump to tb */
+    tcg_out_modrm_offset(s, OPC_GRP5, EXT5_JMPN_Ev,
+                         ptr, offsetof(TranslationBlock, tc.ptr));
+}
+
 static const TCGOutOpGotoJC outop_goto_jc = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O0_I4(r, r, re, re),
+    .out = tgen_goto_jc,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0


