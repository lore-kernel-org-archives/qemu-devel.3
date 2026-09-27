Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70565C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklM-0003V2-QW; Sun, 27 Sep 2026 05:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkb-0002VP-7e
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkV-0007TI-7N
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:45 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so1312126a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499642; x=1791104442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ELjCGHpIoed9Ru6/xDR6p06a72Ns2vzOBBxGfK62PIo=;
 b=fE2QwPBDc819TlD75l/dEK0/frgKTXxam/C8xfg2sks6/tQ/LWVFr8FMdUnaoVkD5Y
 /p89egjID9SZ/EcKYe8xm/vbb7C8cnRpoRirXRIapEj7ivokdpWhqvqW46Bf7szfV9Ft
 KQuMBR3CERuOOquTTHM1SwYojwUHZurzCdEkjBx+m4MxnYggn6rU0pNkmhJBYH+Oric/
 jCBKe793elydE9DX1xdXAzJSObSl6yqk7g9NwAjivck8j2nfUXHlwKbnzDXhdE5wOnEL
 CFQx11lY+zU0VC3dnX3Z6HBd1mu7giY5wtjYwUn676ILLEF1kuX/3AGEZegeopRJ9xlL
 3iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499642; x=1791104442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ELjCGHpIoed9Ru6/xDR6p06a72Ns2vzOBBxGfK62PIo=;
 b=n6BodItJHrQZI8CZvQzG/HaTFBdoiA/w8YTZP9rQe7rS6DDLimHA4zkW/wnwbmR/w4
 tI8EBdeEEhskjN2WBOUIMedqUAIZc+ZqMRC0lYecWw0yKjLczhbihQW+LxWDekQPGyFG
 PvZ9CrQ7gIX8k7nVRPSDKLaAUTq+lfEtS/D7VhuXGj/FD6rzQ9E87L95bv5PezKEigZJ
 F4dsIP5yFHI2KBKv5SaHzsFBzoMkqM6FtD8K8iTpiivNURXe8nOrU+nEDwHbyF7EikeT
 odJQpOfLHcpO1AWMabm1QzDKHmQn/og4lh8TIhyKwZqDCKrT6eyeWzbjvoSaWgFM7t66
 754g==
X-Gm-Message-State: AFq9FYID5S5O32njTFi6P7Us/seYTiM2wEURVAwEqKnSLObsnufwnEUs
 WI7HYVxFkNjSGBmWywqfpd3ElLzIWoouzOT2BQGAxbrtrAA63FHsYlwqBI2/BEmEilPD7F+s9ot
 mgsyN
X-Gm-Gg: AYBFou1gxC2zHs9UW3SXZIJvQ8InMCUkXzMo+r+siBokszXKu51X0jojONCYJTwaz+d
 MrhuD67Z8tKaaPq8KsEbD2tO7MpCJdV3YUqW/9G9GCI2pWsmTkjdLMhzQP3IXZPemiNrhB++cBr
 E9JprFQiJV7UbzNdkKsaFLUshchau789qshaeWdh/tyt6hfnH1q36ijzRASEK3Q3Y+o080N3S27
 CM3yJ6OtRxyDwZgdb9qwNqBTE+SDVcPD79sjQcSFtQqWX/YE/rJBcooCJNvxhaeF21G15Lh1Bcy
 lT+P0YxmmrSJgrA/BMlOLrCiRu7mqr3F88w+GjqdnfWgX/IRgcCkHFYe1On8Rb06394juPbc3j3
 /2MJDTYm2iMQ/0RCxbAtL4yoxzaoQSwSTZc10TCP4icu7S7SK+aJyAyYJRZGO6nScf5S5Ys9IMF
 V2anBQHmLjtyOOPmmG2wCM+w9xk078pIaX9qF/nute1HLyTKcrPD6mrc7iLkwQeAL6OWCu1gcUh
 TlLks9fGYAZBc41TxzKq69Cwn935A==
X-Received: by 2002:a17:90b:1dcb:b0:3a0:e786:84bf with SMTP id
 98e67ed59e1d1-3a0e78686a5mr2667983a91.60.1790499641583; 
 Sun, 27 Sep 2026 02:00:41 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 029/101] tcg: Generic expansion of tcg_gen_ori_*
Date: Sun, 27 Sep 2026 01:58:59 -0700
Message-ID: <20260927090011.10724-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1af9f58df1e..b574a8f4f4f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f7e7f4d2a1c..f7a7dc69c9d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2baddbcfd38..90aae9ed4c9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,17 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -509,18 +520,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1487,18 +1486,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


