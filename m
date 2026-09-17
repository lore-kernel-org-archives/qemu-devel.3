Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA78C982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x77Jb-0002jx-7z; Thu, 17 Sep 2026 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JM-0002gr-GZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:40 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x77JH-0001vl-5Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 04:17:37 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so396511a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789633053; x=1790237853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nAo2jxIfFVtT+B9Lgx/jvKb4qu0tXrL4w9HZJ5IEEtw=;
 b=tE/m+8viq5VoYj0B5pNzxfbCL1/VhEijnFql2iyaZfTX1kMUqDkvYiumK3EYuztMlN
 SQzJjCm55Yw3/3gwX0Cgi85DOjJi1FQbvlb/d4s0HXsyaZ2AVNYeS3hj1k2rW6B5lMHw
 Gl/Qt6KscFCC/kt8J6ZODA5EscGJdR92vGkwA6cQ8I/eqY4baDcaxrwfGged8Guj19vv
 ftrr57xek1gqCsgI7XjNObr9IuXuKl1L2a49Q5Oavsi11RFFk+xqetLbkzFJ3JzOIscq
 05iA76UaD0Q9kWHJVyO5WLrKGRMg0iwNk1jXljvudgA9NNRezw+L2Gsn+JvN+bgwPIDw
 54lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789633053; x=1790237853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nAo2jxIfFVtT+B9Lgx/jvKb4qu0tXrL4w9HZJ5IEEtw=;
 b=iSJrIXdXMf6PPmgsc6TttU0acb4HmPjtHgW7rxMVJhX0I1HogmfOFgpbrXoympLXsx
 4/rvcypleUqKy0naQu7zLsvylyn7BP0mNPVH1dFboU3bU7FLYAot0+JNjMu9MG4UdFk6
 inHBFL7luVdN/9EF17iUTcLfhOebNs5kLvE4TsC7OlACpj+0Q6Rkcf3ZeUqDC5/XebhJ
 28hN+68slUCdH4499ZXwcmJyANYa3kwsQ2rKW458qr3iDpp5PjWIuhUYFGfj/aQByKq1
 7tVCwEuvnjSshOrwWyGlLb2p4PdZFGeer1p2RElb0lgiyYdZhbHZfODedc534bnGpM0j
 vYBg==
X-Gm-Message-State: AFuF++nnbjDEbxko2F+p4u+mwrbHAgTRLaJ+K9oF6vmCv9Hs6YMpuLtn
 NOjTq4FKdqKkN3GGexeqaFYfSC8Vu3lZia6TH3NLsFk8ZynMvfdH+jsr8gpBpWlOEKyx9FXXlkM
 t1H6m5FM=
X-Gm-Gg: AYBFou1g3c+xlFSLin5QdB2jhhKaNuwD9RLFeThPbd03vHwjbbBCuZAlw1pMiHGZ5v6
 H8TMSqfx6oTiwmHqMqP/ZgiBIj/Zu+7Kuo1enKj04U7iuUlb2TP7RKBfme8em6XXrdU4ItzBoP5
 LrzjY1A1MaYI1x3+UXtYKUiwHpd4Yo5rwvYh1MWsKJmYgaxoeN9YLol1CsYHIexNt4syBIw19sW
 FJjY6YACLPonD267PgrvRE8sl0C9hkh0nVRRboMEBkFUKpdct+oE2EJqhrFsLTxx/dFtU/MMxya
 ktVrc6jbNm2pMw+7pFiF5XGMzPa2BS3y4Q+X74yFsDi5MP8F6WU736NxakBGqprL7L9g6XIMFpj
 q+ZI1McHG0FOxwX0aLNnAMALZhoCMHCvoCXiEMOUvsGbztKGi0tCfkJ/aaYjMvc1t2ipuzwdFIu
 XBA8o/QWNcYxPluIz6dGY6xWEkC/d2MnN0R5RMB/3HGW82D5jjEdTkn+hTMgv4ovrPtL3uZiP9z
 3lpTHmr
X-Received: by 2002:a17:90a:c09:b0:39e:2036:8243 with SMTP id
 98e67ed59e1d1-39e20368cf3mr8081439a91.25.1789633053431; 
 Thu, 17 Sep 2026 01:17:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c1943f4bcsm127638eec.21.2026.09.17.01.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:17:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PATCH v2 13/16] tcg/loongarch64: Implement INDEX_op_lea
Date: Wed, 16 Sep 2026 22:17:13 -1000
Message-ID: <20260917081716.946668-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917081716.946668-1-richard.henderson@linaro.org>
References: <20260917081716.946668-1-richard.henderson@linaro.org>
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-has.h |  4 ++--
 tcg/loongarch64/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 31e6ea9632d..53b7ca40571 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -54,7 +54,7 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) >= 1 && (sh) <= 4)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == 0)
 
 #endif
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 17784d8bbe2..377cd9ec08d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2098,8 +2098,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sladd_w(s, a0, a2, a1, sh - 1);
+    } else {
+        tcg_out_opc_sladd_d(s, a0, a2, a1, sh - 1);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


