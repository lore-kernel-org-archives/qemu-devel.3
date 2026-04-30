Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A44FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEyp-0007n2-Q4; Wed, 29 Apr 2026 20:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEyk-0007Cf-Oh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:10:07 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEyi-00038v-Qq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:10:06 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso180182b3a.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507803; x=1778112603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tno4FRdkKISmgYOrfh62o7rJBcHuyC+6/bmV3xDjQJQ=;
 b=ztFFbXerc4HuGW0krNWKbnR5FkasZB15K5h6UPzXvBi668tYlAizx5/CbxcqbhQUam
 Ni1YRGSOvZVLLyfVnvnvgdbjbz8dCPyxzMfEE80+GxAy7aU4M2x/h125OKKYCISQbIYO
 QRwHmYCvgGz7uEIQFNAWXTtN4POBW08Pzs6/IHRVoiY8KCj02vv6JmvzV6CzGrA11OtJ
 slFVlcsw/MdsY3PjcW38JROP/QazvQUyCNS/LvpOfWu3TveTeHu6jutKxoRrShb15eoJ
 4CnTasvYmie3WEuEWSn+l9sBayqfqXEjqnAjiVnyHGveHJMkeXmEa6WNJfuiGFAwuOYt
 VtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507803; x=1778112603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tno4FRdkKISmgYOrfh62o7rJBcHuyC+6/bmV3xDjQJQ=;
 b=Mt/ZXgTOoNRB+GjhVGuMdNX2B/rV7fUB7p/VPFOW7cOsuPFnFppD8Nt4iOZHLM0Mpu
 va2r89NqGCUSaBZBPBDw338qmVErJbKNZQddv6T1h0NiI3qmd3xz38bkLjvlFmX1geQm
 AfbqCb0Kka+rBIZWPGt6kEzlVnGmV7M4YWRBdbycXcbaKPpENjeWecJ6NvbeaGd9ZGxe
 cCwQAdNdVUgA4xYU9JsHRxVznLfG2OF6Qyob7HHXEweEy67xkGTvZU5AzsPERMBRtWJa
 8r8nQFF1lbTjj4o1V+j1hmKp4yCx3gjM6PvwSe/6qQWtPGzXX2ATFfg+Fq0xdaeLs8Jk
 r3pQ==
X-Gm-Message-State: AOJu0YywDEGpVVpVirafSz++VNhbV3UyPhS5q90YopiXyAG7T/mvMR4Z
 hOGrq83zxuMVRotJQcLZhd5240wolZrOfl0qiyRkXifB5Uq3/IehR16STY4H4jQPSgLVLJAUa1z
 Q0QI6LP4=
X-Gm-Gg: AeBDietLqcE1tIjKNZMCvrJSIaDvxci5UeANDLPxvP0xritfaqbFCB0M+6sNJ6XM2GK
 lAbaPZZZ8wmnOfuI8e8urel0XLR5hiJdqg2oPCCeLtCxXmrTVX08eANzEZb7U/J3Y3vbeCLyhCM
 BjGLeWUF1r5Szj/I6BpxW4aCZIebi5PePlPLvDLMdOB+NqlUkElYYGzOEcLhx0zpgA+/b/B23rw
 /xoa5S2S4fMqLehHH4ESuFfJVL9ElkCVKWDsQ9EUK09qzsvCvxWVZvdYNUhg1gsd45Irq3RPtuM
 cz+hTwloCRYoYOaG2Zl70sz2423cTNZB+nNBH0yuhGK3w10Fp5OfavQeXKJYXrREFgBCP6aRmll
 moDgsjJeIZXMPHHqtA4sDB0udi3ZdTKAeblOhC0wxMfaGw3eAhVmYyu+Dmnk4nI3fmtbxPKwEMp
 pQ7f/pKBJgzyxJCJgztOTevWgylw3A+eDnAfD5YxpaZ1Yt/TQ8kR8=
X-Received: by 2002:a05:6a00:4c8d:b0:82f:48e:241c with SMTP id
 d2e1a72fcca58-834fdbe464amr754190b3a.23.1777507803242; 
 Wed, 29 Apr 2026 17:10:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed80df96sm3052272b3a.54.2026.04.29.17.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:10:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 40/40] fpu: Introduce exp_scalbn
Date: Thu, 30 Apr 2026 10:05:23 +1000
Message-ID: <20260430000524.56046-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Avoid exponent overflow as well as checking that we don't
lose information with opposing scaling.  Use it in partsN(scalbn)
and partsN(round_to_int_normal).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c           | 17 +++++++++++++++++
 fpu/softfloat-parts.c.inc |  5 ++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6a14c5d639..a6ab3ee0f8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -601,6 +601,23 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
+static int32_t exp_scalbn(int32_t exp, int32_t scale)
+{
+    /*
+     * Catch chains of scaling which lose information.
+     * In particular, if the exponent has been saturated,
+     * do not allow it to become unsaturated.
+     */
+    if (unlikely(exp == INT32_MAX)) {
+        assert(scale >= 0);
+    } else if (unlikely(exp == INT32_MIN)) {
+        assert(scale <= 0);
+    } else {
+        exp = sadd32_saturate(exp, scale);
+    }
+    return exp;
+}
+
 /*
  * Helper functions for softfloat-parts.c.inc, per-size operations.
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index c5a828eb90..789a41d24e 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1107,8 +1107,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     uint64_t frac_lsb, frac_lsbm1, rnd_even_mask, rnd_mask, inc;
     int shift_adj;
 
-    scale = MIN(MAX(scale, -0x10000), 0x10000);
-    a->exp += scale;
+    a->exp = exp_scalbn(a->exp, scale);
 
     if (a->exp < 0) {
         bool one;
@@ -1632,7 +1631,7 @@ FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
     case float_class_normal:
         {
             FloatPartsN r = *a;
-            r.exp += MIN(MAX(n, -0x10000), 0x10000);
+            r.exp = exp_scalbn(r.exp, n);
             return r;
         }
     default:
-- 
2.43.0


