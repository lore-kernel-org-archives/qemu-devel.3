Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6193FC982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ri-0005v2-1j; Thu, 17 Sep 2026 00:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qu-0003eS-Bq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:04 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qs-0007wh-En
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:04 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8686f46e4adso338955b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619761; x=1790224561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WHup/94Sgl0bkQr1l1r+uzHpyYNDE26cjX/AH6Go9sg=;
 b=AH1xh1Oj6Qi49nvo0l/YK6csQVtoHoKp9U6W7dcBVhRM3jJllUD215/HAzpXUaK0Cd
 IT858q2bWpy3hWhhhz/IV/d5rBVRi/9PNXGi+yt37oReNrq1AY26mZ2Wg/XuGtsAVcQE
 zxCYqtwikxJpn/dzkqpPeGWrFgAlLGRh1fnZutGtXnTCtzXxg7nSUzKlQIGCFiY5LYvH
 HLYfvZln6gK3cX1c5Og/ZwWF/RVjkrlH3Z4kTLQFxoQTOUAZq+jxgnMBdDXBWdvEY6Y2
 3qEK99mLpIK+Hi/g0IuaonHlqGV0PU1pMtTWeSgA5NHMjkbcOyrRNiAH/ZVtstID7vea
 Tysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619761; x=1790224561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WHup/94Sgl0bkQr1l1r+uzHpyYNDE26cjX/AH6Go9sg=;
 b=AAXncZsMkkQ+caRLjLZtwlhpqaK2hfHSLU7AuSgCwsYyvnfinw2Y05ShaPVQxpPGQh
 WyAfyz/3rf1kGUIbYZEFKsBr+tmOHXTGxqAnusPQmjwPPcKeiqh9it+8xqqRe1XKJlN9
 ivgnIXdJmY58eBh82TU3ZSOPmcoYei7T+MCko4JnrC2jNbtQO95TDRl/Vse7nAiqQam6
 6NoI3m37DeFyVfsM/n5fOL9r9nFmLBySYyaBclHZ/zWwsQ9/iHqXhJaARZG6SK7yt35f
 +oXppztqmlww/iS5p4hPPVC2EeZOs+TAMGTu2zi0Y8DbP5YNhro4rFHcVG/mVRuvy1K0
 UJJQ==
X-Gm-Message-State: AFuF++mSjuRnww2W7ffOctB9ObhSRsTGDFHPS7wcqdksyLRdh0ynuC9L
 SWuPykMKdSTeb3L7OCkmCYI8wkXduMrvVKfufqDQr1r/pHiMEVag/D7EfQ1kVsf5vZZQMw1+J8u
 Oukv56Lo=
X-Gm-Gg: AYBFou2+OvQyFse9frKNLaQ1xBDx8mGaQ3e+Gcy8nTPcYxVNj5IJ2RNY1tyoEiWsNrf
 L4oWo6vrRmgtGCH+cPKvTd29yYczZQdqZS/XXGcbIbsZboC5IlYRVDF4t5VIQ8A1ig25QAsiQzZ
 OuBV7Iw5MzX+2m4gHbCie0wn1mIVhBukaVGJEzcw4UG586O5HCoGGj4wYykazsXTt+0TntCvt8Y
 lZvEX8gdfIQZHJNFVwE9PAn94QncXvZ5E9K+reaeRWMY5EzlzhtvHxJ6qhOTTrC9jQhQZrsBWt8
 LafxlMyR5pSa0JCc9Vu0E2agsMn6qw3+4hsoYwriZ5Hg95UzJbdPdhtVqhHRELa6ZVOthg4tbXn
 9CMNIV+aFscXo+Nob7Yec2POh0lRaIycFEH8f4S0xkNr5Cu0oPAeWAv18VtXESl6O6zi1wphMw4
 V1tmXfVcU33HIOm0CRtXlaRyO6LoCw4ZtVjTvW+41pkbJj+SLm+Rt0RtjjnyJVoc2i+zDPRWZdg
 IzO5jI=
X-Received: by 2002:a05:6a21:7d02:b0:3cc:faf3:331a with SMTP id
 adf61e73a8af0-3dd5f41b4d0mr12773228637.10.1789619760902; 
 Wed, 16 Sep 2026 21:36:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 090/101] tcg: Generic expansion of tcg_gen_revbit8_*
Date: Wed, 16 Sep 2026 18:28:12 -1000
Message-ID: <20260917042823.542588-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 51 +++++++++++++-----------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 56bc8ce4ace..c3d080222d9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -135,7 +135,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
@@ -161,7 +160,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 28cfa68db3e..13aa8e15e42 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -48,6 +48,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF2(revbit8, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a2ac9380802..33e82973d8d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -179,11 +179,6 @@ static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
     return tcg_gen_op1(opc, type, a1);
 }
 
-static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
@@ -1133,6 +1128,24 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_revbit8(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    static const TCGOpcode revw[2] = { INDEX_op_revbit32, INDEX_op_revbit64 };
+    static const TCGOpcode bswapw[2] = { INDEX_op_bswap32, INDEX_op_bswap64 };
+
+    if (tcg_op_supported(INDEX_op_revbit8, type, 0)) {
+        gen_op_tt(INDEX_op_revbit8, type, dst, src);
+    } else if (tcg_op_supported(revw[type], type, 0) &&
+               tcg_op_supported(bswapw[type], type, 0)) {
+        gen_op_tt(revw[type], type, dst, src);
+        gen_op_tti(bswapw[type], type, dst, dst, 0);
+    } else {
+        gen_bitswap(type, dst, src, 0x5555555555555555ull);
+        gen_bitswap(type, dst, dst, 0x3333333333333333ull);
+        gen_bitswap(type, dst, dst, 0x0f0f0f0f0f0f0f0full);
+    }
+}
+
 static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
@@ -1466,20 +1479,6 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
-void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_revbit32, ret, arg);
-        tcg_gen_bswap32_i32(ret, ret);
-    } else {
-        gen_bitswap_i32(ret, arg, 0x55555555u);
-        gen_bitswap_i32(ret, ret, 0x33333333u);
-        gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
-    }
-}
-
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit32, TCG_TYPE_I32, 0)) {
@@ -1700,20 +1699,6 @@ void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
     }
 }
 
-void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_revbit8, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit8, ret, arg);
-    } else if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_revbit64, ret, arg);
-        tcg_gen_bswap64_i64(ret, ret);
-    } else {
-        gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
-        gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
-        gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
-    }
-}
-
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_revbit64, TCG_TYPE_I64, 0)) {
-- 
2.53.0


