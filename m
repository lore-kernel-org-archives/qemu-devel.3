Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA22C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nS-0001VA-1t; Thu, 17 Sep 2026 00:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nC-0001BP-Na
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:15 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nA-0007CS-UM
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:14 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eb79f6so2881725ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619531; x=1790224331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G0nqiK59TEqDZWj5X3IUro3ZcSa/k6Zs4DhFIDgSsoA=;
 b=TimEr75l9zPCDHRYqU39GVki7g9rS6ztJrWmClYxjZgJv/H1ahAFg+EISCaqmosaf4
 E4k9+/p0S+UYD5PvYCoTK3UbmZ/jz6sRKF2R7SHgBVxBIt52FJ/yP2CyXfCsY47gMImG
 OIpB4gy6NCku+rtBBu51RUcxeyElo32EHv31kirZUcIypTdQi/39l1JFZU8yU8+grjql
 vadKGxOS+oZ4Tt0CJJyM2n2j+SgxKYkXcvP7UoxlEnxX4UV6q42YlVHgI5XJWvmU3+6/
 5VRgKWlfBEMbzkJQnJEq06S5CC3SSfDKUPJnE5h/567tUfQxTTyY3QdCyJKbNPF+gymz
 sqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619531; x=1790224331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G0nqiK59TEqDZWj5X3IUro3ZcSa/k6Zs4DhFIDgSsoA=;
 b=aMri0ZjBTCF632DXKr4UqUJ8kAggBw5NFJQ/be1JN82zcPSF0XCk6CoMizU7e9MZXl
 c4Nqnr4vn+odaKyRbTu+S8N+4/4Nx4OU3ifZx8S8WqnydxjAA8ttcXUssn26hotWCRGm
 ql1QgiB3Bf6Iq7JAsVT/WLUM83g2mk2Oi8NjENFpHTXCfCPhZd+MEElxNeIZp+Ux8IWY
 K5s6vfpmhXVfdOkLrapKrCAoHXT7BXtKb94EyRmzZbj16XcyC55QoNFkzgidmw9vLia8
 iLJSVeT7BYzQjHWgwqrseMTUVXZrUWmD1t/G+DF/2x1I9+Yo4317aof2UcnQnxV1oBLS
 Lw6w==
X-Gm-Message-State: AFuF++l5AxzkK+BpNNNqC+dNEjGfopC5HtEdynrDwykfi9otKjrlHGPO
 7D4E3d4OjSzu0z9mGggCufscy8WhMdS3mM+rUJ132Xlr8VmJuR2LsI+Igl0EBdP5fVfeKh0joyS
 EoVHUjB8=
X-Gm-Gg: AYBFou2X74RlSfbzl0m/hoJyP9DAYAHGrgsdSCAfDwp4JuXp9b/Ew9Y+soFOgbOVb7w
 PJuiQqKOqM7NCY3h6gAxABC37mpaN6/fS4mG57I7WeDsQldFk2r+KDS10s/3zOZ1pBBtBvw2GlV
 CwYjd2AkY1z7a92ag4JmcagFxBVEBBLM2ahHe5JrPq7a0asndz+2xYuiVjLf4G35gk7/pY31ySS
 57ItA4yBvULhc167Ihb0sVbQcwiqE2iBVnF1yZMO88tzB7HnKdx5DggFU4MYQr4QOIsVYTQrsHY
 7y+X58siDHLEIPV4cICPRXKNfCfrxig38bM8yyAWA6PjiauK3lk4ntNRuwXCqLiX4DNUea93Vt6
 Wc2iSwzogY3iPoZKkEiv23wBmx2LvZahflFjvubRaar6uqsuB6oALQHdZM6KVaRydbR6TgCO0U1
 Jkd0+sSDRkttoGnQWm8g0Af57h1NgCEw8QPKE5h7bC1mzysYXXwGMrX5anvHSKoMAbh+l/SBadD
 3cOWN8=
X-Received: by 2002:a17:90b:4ece:b0:39d:ba21:fd90 with SMTP id
 98e67ed59e1d1-39e1e491176mr17267452a91.16.1789619531386; 
 Wed, 16 Sep 2026 21:32:11 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 042/101] tcg: Generic expansion of tcg_gen_orc_*
Date: Wed, 16 Sep 2026 18:27:24 -1000
Message-ID: <20260917042823.542588-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fb10ffd804..a5b9e0da647 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 62dc85ff6a6..e17caafd890 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9c911816eb0..8b98a0b1c12 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -575,6 +575,18 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        gen_not(type, tmp, src2);
+        gen_or(type, dst, src1, tmp);
+    }
+}
+
 static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -755,18 +767,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1772,18 +1772,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


