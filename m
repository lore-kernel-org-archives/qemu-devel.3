Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBA1C982D5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nr-0002fS-Vm; Thu, 17 Sep 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nl-00021A-NG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:49 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nj-0007KP-3I
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:49 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db22383fe8so2500005ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619566; x=1790224366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctDp8YwXxzCXaDR2a8lYDv0WsLUKLCro93lKhEtLaW0=;
 b=fhxavsqhlgqRey5MbwfufLeZtLkc6eOmlLxjWLgpcZsejoC3BUkmXQhqfojci8ECSi
 fjH4Uykc/KhtJ5oJ5/ePESi4IQq93rfvVzVnrakfR+tAfLYyuxMzgj/JHKdPFI9F9J3P
 x1KQIv6f4rx5xJIkoPQyF6Dm/R7xViLmf8bkgrdcWMhR900VszVKhnPj2fAYICZrKlUI
 hE2+7QOKLFoSR/kxEiLrE4jcmGmUFX8QHXrRmZf/NiIn5bIfXiNXGaXf0JePl1Axqbf7
 w73XwOvidrnJqVdqicEuKnNqwVkweUZ2KgWNjEtktuJqWngw06yig8SY7LNzWMrT+lzh
 lUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619566; x=1790224366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ctDp8YwXxzCXaDR2a8lYDv0WsLUKLCro93lKhEtLaW0=;
 b=T8d9GOxvONNaUim3TFM7YFC3SVquAPSHsUVsUOWOhAMd5WIoj/moW9biU9STjJvjTt
 ShKOL7Ufud7YaojrQXwB3vaYPsrdpoJlNXfZGSWoZbZa1myt4BjOhq38jajbw20BdXdb
 VK6Wf02La5nykBYxglxrf0XJPLlVdNeg/Id3iU47w1wyTpfnlZChccNtgnReBBkynMhR
 N1MUJACJ+huDZk0LkxssAAAfRLpylUJ/MprgxY/PJuOMS2IAYaIFcC/U+bOcX+lExflf
 N7UYYIJRumi4Elp19hLFyjKF4T0NVgB6ovkwaC5pLEqT4P6z3ktzuP3mmym1UH38uLEs
 +yeA==
X-Gm-Message-State: AFuF++lOJUaQ0mN0Dj4r2xa9HgXC42JDhYeuKIDqVUb5suYW6zAlr/BG
 U8VnvuxK7Ss0XzUd6cFubXYrBr3ixCwtIX8ZYsaecejRlaKymT7cNMNhe4OAaYAVU3jQjQNTdzP
 iwJT6U0Y=
X-Gm-Gg: AYBFou3E5u60NFge1352fxWpDF1gneFk6AYiEf5VkAfJPrBXj+aV6a4nhkY5rrrIlrP
 Pc4002BndpkU9GIgdyFluqtC81kohvo6Cs8NHQBDIt72VxsW7iYIQ7mEk2nG+AyVu5ITEpu4au0
 ibuUgNfdlbFHcxi/vR9JQUKUSzHiHy938WxCWJJIorjkgOAkh0h1yiY2okQKHBkf74rd1ODPdwa
 1Y0wO8+hPmhmvyNGjX31SUCXTcm9QT6ZRyRb1fCsCnBZQRADRGg7q64CWFucUIZMM0Kqr6NHaOi
 G7V+3/DWcddIKAHasM+KrTjwyeXXfqff40dJukU3aT8g/wwtI+NmYVmfIAwqrxIQlaTQFr3t+tO
 QNNQmDziMrCeyJ25jFH6NTwlVmsbL8PJSRPap2hgeaAJ2EgV09eHsT7mhuZ2kkvCGSt2tOQtAyZ
 4BSWDtCM7gIFHwCeczj1AfMuLeLqSZS+p6tbpk1FYSROms2v6btR8zRT7GDe/MS8aaUNIU/GCDY
 bxHiF4=
X-Received: by 2002:a17:90b:56cc:b0:39d:eac2:7bb1 with SMTP id
 98e67ed59e1d1-39e1e26378amr16078024a91.4.1789619565676; 
 Wed, 16 Sep 2026 21:32:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 076/101] tcg: Generic expansion of tcg_gen_umin_*
Date: Wed, 16 Sep 2026 18:27:58 -1000
Message-ID: <20260917042823.542588-77-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 997f04ba3a4..e9f7703b687 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
@@ -187,7 +186,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a5330ab6a1d..70f1fc48a26 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -59,5 +59,6 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ac513ec93d3..cd735bc429e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1155,6 +1155,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umin, type, 0)) {
+        gen_op_ttt(INDEX_op_umin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1452,15 +1461,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1974,15 +1974,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


