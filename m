Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0776DC982D3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kI-0003Hk-O1; Thu, 17 Sep 2026 00:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0003EW-F1
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:09 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k8-0006qh-Gb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:06 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so4759915ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619343; x=1790224143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gCagFY9mrpszpvLeVnyj7Wim+i1wybGsO4ncoXWiXzQ=;
 b=OMPZIZ9gBmkSKBIQbE/s8vGLAT92yAwZGWtKlzQ43nTVHz6jZtwUEQQB2HZkvVKZPW
 xlzWtH4Xtq8SNgv8LUF24YX9tBzQmehSm3QBN/HdGzbjEje9SvRZnGM7ieuZhlCeb/95
 ZVj9QuQC8Tas4ll4w75gmQU2n1bZEp/East2AbsUUMYXZjz5ZwGsic557gz4I3fUis3X
 ISWpE0ICA7qrrOlB0i0MZ9HUuQKxsoQ7NKA9/i+yBLtwAuS3odUZo7HGo9ZVuC3NE+IQ
 KqVZ3+qcQwORK6P3KLxLUo9EwjlIaHmE5CHHMHATJfnfYkpzS9n18GnsGhP7mUWWhzch
 CuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619343; x=1790224143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gCagFY9mrpszpvLeVnyj7Wim+i1wybGsO4ncoXWiXzQ=;
 b=SKIWU1IvZ81eAnnmPdNlYih6PLVEflRadWqLm8N0vcb99NhV+NuaaZWjFbaKsjsttV
 6p7GotYZAfWgAhKme+cBm8mWeWqaalsLebwI4oaY2TeLyRWqz8pfU3fEVC+POlZHQgHF
 sFO4ELYIhQ1ys7FqhxXtx1u7D2s7DoR3ZvZhw6H6pM52Kz4dg4dwxrHbz3OnOkHHc0al
 JWy4yWKqgJSDWIyM1FvZutzVs7CRa7OVdRl5vBIL+IJSqNEgePxcwCUZWWiflfoAL2M7
 BfoX6sEx8lk/ADpxVv7UsK3Ndr8Xg0Q4pHZym7m8YiEDdUAHChKlidGFsW5HCdCfZYFI
 bmtg==
X-Gm-Message-State: AFuF++m501PISrg/xv37OjPbBGDYMWRSzFy04ELEnXle3lMHgiROvXMz
 bdZiTK8uiNq2UP5gp9kUhqB6cKJxYUDXZ4kDrtU55pmUM27mUpTW+vyO2x6aCDE+lWBJvJE3HeV
 d9rbDVgE=
X-Gm-Gg: AYBFou1OdaNnyA1OeM2bD/t11kEhxw8GOYgJEUR39Kz1ho+Vg2H6dUxIG3beuV01GVg
 oiZtU7A0H3JV4eGKrRz6QYKkgPMc4q1YICXuuiqmFpFz7CL2jScsiAEMyfXOuvCTP40HvqGxvfu
 l7oV92Tf1gbfVWH0KzfV3s51IEkm1GW9cs9KXPcJrfQkQTmNxc3TZIx5lJWp28Oypy5YWwNQH0D
 +RiuHLQw+BugB/vU7pdTwUIzE/aleaWtDPgf3NLlLhpemM8+cwLIV9o8MEZCCU4bz60kSrFKl72
 vLyhl16/nM3Jt9CkjeY/ZnTMSCX3rsTEoCode3LzpucuIvIej4LE87bm5GWq/wNhkXab+EWtXZ9
 18WLgFMs57TiG3B6rzAmlJdrqF50ij+09Ns+SED/WoPXrshSM3fL3TSIQIONoltOrV6GdvsROg1
 ZLGB7jdSqgwosyFgOKovE//lTrnY3mbbgJvqymBmc4+N5lF+1fY/u0tZGfYTjbsKvVs3RRdu7+9
 1xUf9M=
X-Received: by 2002:a17:90b:3842:b0:39d:f6a6:60d8 with SMTP id
 98e67ed59e1d1-39e1e23e8bcmr11197278a91.3.1789619343135; 
 Wed, 16 Sep 2026 21:29:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 035/101] tcg: Generic expansion of tcg_gen_rem_*
Date: Wed, 16 Sep 2026 18:27:17 -1000
Message-ID: <20260917042823.542588-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 tcg/tcg-op.c                 | 61 +++++++++++++-----------------------
 3 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2f8a9f48eda..6223d46b199 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 473d472823c..67261d12741 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ebacffead4a..8ec4e38fae2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -533,6 +533,27 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            int width = tcg_type_size(type) * 8;
+            gen_sari(type, tmp, src1, width - 1);
+            gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -672,26 +693,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1586,26 +1587,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


