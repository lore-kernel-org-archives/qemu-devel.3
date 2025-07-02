Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83932C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwU0-0004uJ-9h; Wed, 02 Jul 2025 08:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTx-0004sx-Sd
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:33 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTl-0007CX-2L
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:33 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2da3c572a0bso4187546fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458938; x=1752063738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8Wr6t5HNQIpjoMJRAtfEnSzR8s3EtBh7dZofKf7j3o=;
 b=ubNc9Z5ys+tca9nEiM38paRyXf+c1P2wEwv9SG6+V+VUlt6wRzG1nEOdB2HyBfUuUi
 d10qu2uwE73neOQVL0OUsrwvRmLMOMjkCgSCnTZ4QKKL+4zfZp4s3NqWDBXgf9G1vh2Q
 jYf6aCu6MAsAIi57O8PB9lswYO6DSZ3i5aLjlrYu85QQi/yCqHR1+OF1OQ/99a2M6n0c
 bwB4RCM6V9vmoraCe71DgW9wn/ydbm2APTpBMkOGXsJUK9wXmwNLiCyRnbRLwTi7AQgq
 P6iicE5XhTD+3Hx0U+xqdu0pG9qVTLkdshZyzbV9kYqiJEv9K48QXK15U2FWhzaylgSA
 nClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458938; x=1752063738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8Wr6t5HNQIpjoMJRAtfEnSzR8s3EtBh7dZofKf7j3o=;
 b=OXoG4cbTs46Tt1L74KhjQXNUEPKCdI5HlC2HUtP3f06S2p5+DVGUh0Go4ENT8DscE/
 mmJ/0OjnGMma2i6HGyl/a+2Au4HqAdiZLIW+oS9by3MlotDG1y520tmy2yMQu9Ys4uOd
 W7gfW9GFyLHKRkT4ZbSBsvG+TKxtRyGixV8OZqGQPAJ5iRbMlLJMNHHvThjxUfetbpca
 TnYVdTm1Vvt2TRkG0KzFlQOxDOk67TKidjUiduI6/p5VLeQTDS4DM8Jj2sXQjG1lXBu8
 K1OpSMV6ogBHSfsb5Arc4ll4g2AMFjpJvwyYFLRQxGrELkaLlKWuqIXbyr3hTtJWHdIO
 aUnw==
X-Gm-Message-State: AOJu0YxNNIociINB6fEeAs7nSZ+xiQxWURNY/0i0Wkh2a/qNoV8c05Lt
 WocC56SH/ZpQrPgEpjRLPodAGV06ovRZCoVx4zLxN6qkbS7LMq020eKVzWxSiWWwQwkui17R7Ya
 vamCuCt0=
X-Gm-Gg: ASbGncu1QROwyqe6m9hnspmh0E8VWtWwlYp8tU32da0KykQ5muVyt+BZkNXO+np0tBX
 tbGtUg+Yfgb+0NjBkBB6L5CbOnd35G4Hi0zXJxM6rIe11yup4Hc0B5mVWwn6uTIv9C/U3eeMdc+
 k6o1pLvCISMC3I/6PKMjULziJZ6tbuwSvV/Dj/JxYQp1wLGJw8w1Ra8QAD+BI5L/zaVB65CRRWy
 snh1q9cta4gnNN2OgWMsoClfUpwtcd66bZ0UXjHExlb0UhQqiZcw92f1XZXZKv/Jd/1I5yXRFaR
 63ayWJhrn4yDS+JIPYr3Tc5jyV8v9ycIX9iJfmL4z+ARJUc+8we7NSkVB+N+flmCbvlPJw==
X-Google-Smtp-Source: AGHT+IFloorpYhTnVN/IQu0ho8eQorqWf3UJvMBHlEQaLq+98+iJRINi2SwDgJl9SjVjBqWjqmQjsA==
X-Received: by 2002:a05:6871:cd07:b0:2c1:e9a3:3ab3 with SMTP id
 586e51a60fabf-2f5a8b819b7mr2243723fac.33.1751458938273; 
 Wed, 02 Jul 2025 05:22:18 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 02/10] target/arm: Fix sve_access_check for SME
Date: Wed,  2 Jul 2025 06:22:05 -0600
Message-ID: <20250702122213.758588-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not assume SME implies SVE.  Ensure that the non-streaming
check is present along the SME path, since it is not implied
by sme_*_enabled_check.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bb49a2ce90..7f8671e2e8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1387,11 +1387,8 @@ static bool fp_access_check_only(DisasContext *s)
     return true;
 }
 
-static bool fp_access_check(DisasContext *s)
+static bool nonstreaming_check(DisasContext *s)
 {
-    if (!fp_access_check_only(s)) {
-        return false;
-    }
     if (s->sme_trap_nonstreaming && s->is_nonstreaming) {
         gen_exception_insn(s, 0, EXCP_UDEF,
                            syn_smetrap(SME_ET_Streaming, false));
@@ -1400,6 +1397,11 @@ static bool fp_access_check(DisasContext *s)
     return true;
 }
 
+static bool fp_access_check(DisasContext *s)
+{
+    return fp_access_check_only(s) && nonstreaming_check(s);
+}
+
 /*
  * Return <0 for non-supported element sizes, with MO_16 controlled by
  * FEAT_FP16; return 0 for fp disabled; otherwise return >0 for success.
@@ -1450,14 +1452,24 @@ static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
  */
 bool sve_access_check(DisasContext *s)
 {
-    if (s->pstate_sm || !dc_isar_feature(aa64_sve, s)) {
+    if (dc_isar_feature(aa64_sme, s)) {
         bool ret;
 
-        assert(dc_isar_feature(aa64_sme, s));
-        ret = sme_sm_enabled_check(s);
+        if (s->pstate_sm) {
+            ret = sme_enabled_check(s);
+        } else if (dc_isar_feature(aa64_sve, s)) {
+            goto continue_sve;
+        } else {
+            ret = sme_sm_enabled_check(s);
+        }
+        if (ret) {
+            ret = nonstreaming_check(s);
+        }
         s->sve_access_checked = (ret ? 1 : -1);
         return ret;
     }
+
+ continue_sve:
     if (s->sve_excp_el) {
         /* Assert that we only raise one exception per instruction. */
         assert(!s->sve_access_checked);
-- 
2.43.0


