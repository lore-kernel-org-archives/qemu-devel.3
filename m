Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73076C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBO-0004Wb-Nk; Sat, 12 Sep 2026 22:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBL-000489-BX
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:03 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBJ-00020H-Kk
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:03 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8686f46e4adso1128484b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267380; x=1789872180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bfp39Fy6N+4jTfaiZ81VDF4ngWDjyDLWox1YTqbMnRs=;
 b=lln0mbGOsGwZuMJhFzbwY/EIYOhqJHlMT1h46mXGPuJu9Hmilc8+cMjsQgFgbKTLc6
 PCOYivuOZc5yC6YcygXDK2CAurV+TCsh2EAE8oMpqSJ20viQaSn+zD3+PlrcCwQHMg5W
 vdJF95i7GL1J9a8xsylnoZme2dPjf0F9v5kNRirzzsepYtNANemVBZEsKzlo3HHrs/8h
 fKvGEwPuyT1xj89GS1KYnsQzZuj5kc0Pa72DipbUO9Fn8n+pwhGQhaI6HYChL173zyXo
 e5pifVFSCsX7Ao0/AtqIdYqNpXxehzoOXdNmFz8aQ3ZYSLqGEQvInmik40taQsWALbeo
 AipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267380; x=1789872180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Bfp39Fy6N+4jTfaiZ81VDF4ngWDjyDLWox1YTqbMnRs=;
 b=aZ+DLvreIqfB4oLxxSVYk7e3iUBy+i6TsAQiyjHLOY7KIvnlBYfFWPOqlYrE3c0+9u
 ZcVyD555KKY/2UHfNN9s44pqb3E+RiD2BpYDouqL4oX6xrQL7aq727AmzIkbSzeVSvNT
 RkuVEGpJy7L8gYEnZNfFiIivu4ToPtQPEe36fowk4Mm1/7Wq6GtRwbFOGWUgw+VxMBhr
 OCY3WNHzahoFnSu+YjWRM56ldmNg04e0/83MX7s5638Muk8qx/7a9OFnNXH/ckoRKgcB
 DdEqRyPleZ/M3DEIQ06eEyjJyoW2fOU9JFwSTDF5hLFsYGhXpBsL6vtgHxsMMFOvRRZ2
 DGNg==
X-Gm-Message-State: AFuF++lP1tv3Q8JrhQF/peltEgf/I6zKOCdK/mlihxH80+cV2O/bVvYW
 +7icQ0cEU0ayJMQD2lcn+gbeB4J7Ux+RjEa5fqaPnpQLYaFiG4uQKYwi0VPF7PIHTK2+V++D3Em
 hJtBvqFw=
X-Gm-Gg: AYBFou0gXaXSbD8wZ+R+BhHC2O/hGSYdqyaeIPXrKc4UFcB7ylLaSaExOAoIGoK7ZST
 TjHYe/9IiBb3hjOf4xLV80Dtp7UmsqakdAaTyFk685vwI+VrfhcdIs5EixG4afmvCe9aKzqqd9+
 7yJBEIKm/jsLraKxm8FQu54LAsRGbXcyo+oEQackDLP9BazWwjXoQd8wVNMdvhASTjhikArrBEW
 Qnyf7pvYwgCdgxlaUkWVdiqLOoyoP6euOyB6vK5LWvSyKybM+lrbcGU5iuo8+oyH0WyKH/usuxi
 98g0lRF0Sr8gD80qrUrExP5Gg3yHXh0ehjNiTyWQxgjSHTTOsBl7n9QvS/jb0kWE57uNon1NUFy
 ewQ7hfxfr+GkgQspwFkuQ5AS+HOLBsYatDhNDhOfJd7+8ZDrWaPbSq99lU+Crjk6rfZ7S5UAYnE
 IaIFNtgG3uIoOLLrfZjxcVAGSCjxR7Ebr4XJDnWDlLz2vRWqFtwE+RATqhO+dOH7u/qSZLgYRRj
 PVU4mc=
X-Received: by 2002:a05:6a21:4cc1:b0:3d3:b00b:50fc with SMTP id
 adf61e73a8af0-3daed434594mr19263750637.28.1789267380235; 
 Sat, 12 Sep 2026 19:43:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 74/86] tcg: Generic expansion of tcg_gen_ussub_*
Date: Sat, 12 Sep 2026 16:38:25 -1000
Message-ID: <20260913023837.741866-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 60f3ac4dac4..f38851a5bf7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 69df7967c76..48f5acd5dc1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,5 +62,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c15256fa1d..decc15f3d20 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1204,6 +1204,16 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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
@@ -1501,16 +1511,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
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
@@ -1995,16 +1995,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
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


