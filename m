Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5648EC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMfb-0004ao-4P; Fri, 24 Jan 2025 11:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ2-0005jG-3v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ0-0005jL-Eq
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:47 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385e3621518so1220039f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736184; x=1738340984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LRgE5sYkagidW3WnsnXPvw6PPdsduRp7Jmx+Kr/CH8=;
 b=pzNUrEb8G4iopC1dIF1xZMzR0h6Wr6mzU/bj3S1pELLDfgVztjNUw/PfovIk0RQD7b
 fYXCdZ1V5ss5NTRlE7ozlTykoxSn+ooYQlsPG0shYAm7SosjBJ0kBEfkhSwVWcLvX/n+
 bYyb862npRaEjmqHKZQ1A8hKdxh856dznb8ItQCe4iHOjz1eAUcHP8AeA8A2w3d65XZz
 IjVLMmmkT7/+822B+prShWPzFYFLZdDmU/C9DtqDKaldiYgkIXFzg4UuyMFzaRttx4Gt
 wQ3GYKAm7+RkI2eromdjIZtVdju0vzs2g6gDdarLZe5o/O8Y9bmJyVA04u1JtWl010GM
 7xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736184; x=1738340984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LRgE5sYkagidW3WnsnXPvw6PPdsduRp7Jmx+Kr/CH8=;
 b=AXYjKIEIhKzDHBZPYNVM/3uSZhKoDBrxGfz6XRN9VgcgKdQ3Sh60S6Zwh8HOZ+lEdl
 YtI8oWFMNEAET8aKfhVbadXAM+of4gIOzJbJZVs7qIclubVUAKKf3a7qIQZV/EI+wtr7
 k9cWVvOaIjrea+6bzLmcvTfuBaQP65Ipi4PRRhG6hswJtZBLKMh38TJGSyHNS/+Sfya1
 OFLFyicO6XuSXfsP8CpjPIXGOIgq16LdcCBHtMQ+Bgdic70pk7sQWHqvIbKlMjz5//0Z
 x2XULRkIsqJ7MRHcbC6K+x3LMln3Nx1iWNc8oOjk2x6g2eFECZuQpTGQi+nswM7KbpN9
 ztuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabo73b/NWaSbnrnWufUqq9VEAGIgRJ5nqjoZ9aiyfbUvJEPPdBsviF2xguIsHrcz/cA/jxsUO+APh@nongnu.org
X-Gm-Message-State: AOJu0YxjLvHOt7GxgBkz/LUEtcrWOvENo+t1Tsbd4VxZxUgiXv30TZuP
 oMDD8On0vrl5r44c3JkrvAlS1xR0WF2g8u67u7kD+GmtqvyNJGRrWm9ibqTSH+YQH2VZVkW/AUM
 X
X-Gm-Gg: ASbGnctMIr0eSERm8k53vfvnuU3OXK5jbG36SgvxII5CXn6QqNSdXZV6XYU4FVqCCFs
 yo1iXJg9GyXkBAHyGCjiaW5qvo9n1ebspUjtbRJ8I4VJ5E3A1JG48QS/BRCzmMfwXRTigmWQtoP
 SW3ekQb08hsYhXyFjmF7xNJwI/qGMEXOhMkWUTSZePZJUyexQj1kJdA2raSS3IilJgvMWB6mnjd
 1vkrZ3qurwWs89rAleLjvrME14POLox5cWrEf0rycQ4cI4shdgiRA5dikE9fEdkDHgNfYEOWL5j
 0qnUXz1sQE0=
X-Google-Smtp-Source: AGHT+IGvQnTVhv0XzvVqRX5G/YbqPYE6d+XfPX3H2lXMs1bI+/MJ1wjvEGwc0X6NxuuuGr1KUH+Jsg==
X-Received: by 2002:a05:6000:1a87:b0:385:fc32:1ec6 with SMTP id
 ffacd0b85a97d-38bf57bb947mr24409151f8f.50.1737736184650; 
 Fri, 24 Jan 2025 08:29:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 53/76] target/arm: Implement FPCR.AH handling for scalar FABS
 and FABD
Date: Fri, 24 Jan 2025 16:28:13 +0000
Message-Id: <20250124162836.2332150-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

FPCR.AH == 1 mandates that taking the absolute value of a NaN should
not change its sign bit.  This means we can no longer use
gen_vfp_abs*() everywhere but must instead generate slightly more
complex code when FPCR.AH is set.

Implement these semantics for scalar FABS and FABD.  This change also
affects all other instructions whose psuedocode calls FPAbs(); we
will extend the change to those instructions in following commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 69 +++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 085b29ee536..542e774790b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -880,6 +880,43 @@ static void gen_vfp_ah_negd(TCGv_i64 d, TCGv_i64 s)
                         s, chs_s);
 }
 
+/*
+ * These functions implement
+ *  d = floatN_is_any_nan(s) ? s : floatN_abs(s)
+ * which for float32 is
+ *  d = (s & ~(1 << 31)) > 0x7f800000UL) ? s : (s & ~(1 << 31))
+ * and similarly for the other float sizes.
+ */
+static void gen_vfp_ah_absh(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_absh(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7c00),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_abss(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32();
+
+    gen_vfp_abss(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7f800000UL),
+                        s, abs_s);
+}
+
+static void gen_vfp_ah_absd(TCGv_i64 d, TCGv_i64 s)
+{
+    TCGv_i64 abs_s = tcg_temp_new_i64();
+
+    gen_vfp_absd(abs_s, s);
+    tcg_gen_movcond_i64(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i64(0x7ff0000000000000ULL),
+                        s, abs_s);
+}
+
 static void gen_vfp_maybe_ah_negh(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
 {
     if (dc->fpcr_ah) {
@@ -5403,12 +5440,35 @@ static void gen_fabd_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
     gen_vfp_absd(d, d);
 }
 
+static void gen_fabd_ah_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subh(d, n, m, s);
+    gen_vfp_ah_absh(d, d);
+}
+
+static void gen_fabd_ah_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subs(d, n, m, s);
+    gen_vfp_ah_abss(d, d);
+}
+
+static void gen_fabd_ah_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_subd(d, n, m, s);
+    gen_vfp_ah_absd(d, d);
+}
+
 static const FPScalar f_scalar_fabd = {
     gen_fabd_h,
     gen_fabd_s,
     gen_fabd_d,
 };
-TRANS(FABD_s, do_fp3_scalar, a, &f_scalar_fabd, a->rn)
+static const FPScalar f_scalar_ah_fabd = {
+    gen_fabd_ah_h,
+    gen_fabd_ah_s,
+    gen_fabd_ah_d,
+};
+TRANS(FABD_s, do_fp3_scalar_2fn, a, &f_scalar_fabd, &f_scalar_ah_fabd, a->rn)
 
 static const FPScalar f_scalar_frecps = {
     gen_helper_recpsf_f16,
@@ -8654,7 +8714,12 @@ static const FPScalar1Int f_scalar_fabs = {
     gen_vfp_abss,
     gen_vfp_absd,
 };
-TRANS(FABS_s, do_fp1_scalar_int, a, &f_scalar_fabs, true)
+static const FPScalar1Int f_scalar_ah_fabs = {
+    gen_vfp_ah_absh,
+    gen_vfp_ah_abss,
+    gen_vfp_ah_absd,
+};
+TRANS(FABS_s, do_fp1_scalar_int_2fn, a, &f_scalar_fabs, &f_scalar_ah_fabs)
 
 static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negh,
-- 
2.34.1


