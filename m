Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01678CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPKq-0001iI-F1; Sat, 16 May 2026 20:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKc-0001f6-9p
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:11 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPKa-0002gw-EL
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:26:10 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c802803ac17so394969a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977567; x=1779582367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AsQJRNP1GjT+LK7oBczLFbhTenBiS0j96dQXCFfIHLw=;
 b=g2wxqbULpeIgdIwlInPZKwXlxtz1wJJ56vV+ioGCAPQqIDzUUk+cCWl7kFUwch4aGG
 YMCrGSn238rT39QkWMDpLfTuSVRECX8kStnQSvdMOX/j7ujx0Q/X8lOzvVPmi9sXQ6U6
 bI2PfojZuAF9OelOk9MwuBzuTRUkPuXDWT1k0IpDRZ0wKi9svrHC7KPVqzDzDLrTnKIL
 uZCmlwbjsN6u7X9TYRYXbhCM168nvshgrNh25B8D6dUvd+ks1EFcs5izxUQ/laSi51pC
 SgjQY8vWpBc+b1jJE5sfKjMmnasJ5ITO+2IVgL/dGG26PloyqHNgCu6joqrFmI27KM5Y
 eHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977567; x=1779582367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AsQJRNP1GjT+LK7oBczLFbhTenBiS0j96dQXCFfIHLw=;
 b=FeC+9AjSLiRdCxYnAuUTL1B+6ZNi6qs4Ilyla6Hczb1H/iarSdUk7IOupUPymIQbbQ
 39kl4jMhRa8disdmk/OrKI8A5x+BHaK3JVWPcXXXgF6Ekt8T41uHN/DbSl5oE2IBzeSZ
 gotlMOVV6uZSDOUaZ2x8g6d6lNu8rS23sFAFKVfx30UwwckFSMRBwfxXVJw6VmnZ39B6
 pS0/dBbeqkr635AqSAsLGh8pI5CRN+r/oNiccPbWGMjikSKuEbg5DDIv/lJY6gugRgYi
 T5qKR9Sva4G+EihU3qBLtZVeoRek25RAnJknzR3gRfZW+EPTUOk1xc8I+ugsggio3aZH
 44qw==
X-Gm-Message-State: AOJu0YzCz8Kb4b7JGEKbqs5QmhMByUU2rTEXmdSnDepMKYcmcaF2KHW0
 CoMpCTATGg8ofawqOq3IVrzyt4fDvPgFxLO/KjArt+Tv/kJ6rh6O/QnPXhQtdZYDhancwYUWefM
 btnPv
X-Gm-Gg: Acq92OFc8hVA25r8vdCt7ydBiX8xdWhDANvf4YQQxXR1qTAmZecFmRnGJDfY3eA/JtU
 jLCPq71ahBngcNd+XseBSBFxWhJYTNg3zIBzL/dkWcMHEqLvCIJ+Nc97aDubkHDC/4rZmil9keH
 mAYIquXqR3d32I3Sp+q/Ryt3ul2wDRtsZq3z/hwDW178lj9pa69SwVsg1KBmFlpxT2PYVa50eq2
 fK+tjo8nMMXCo4A1qg2BoGWfdv2AL6zH7+dnPgbz1+Hc5AK1owFP44GQ+KTkZPxRmVmwV0+q5Y5
 +ejijX5Xt3TV7sqPr8AWG0rdz0ZvAIDQZoiTKIvwWVH3UT4zNRasNLhdyBNRfw/7VFYZnE7KGfG
 ZrXO9VxstmOT1c/VOQl0UdVv0FJFWn0fuGQAf9GshPsdh8Rf4JR95jeH4BbUVgS0Z0O1kDrc6iS
 a46RlT+7MRynVdA3EXd0upS9qYIHpK
X-Received: by 2002:a05:6a00:429b:b0:83e:b125:ff30 with SMTP id
 d2e1a72fcca58-83f33ab698bmr10169419b3a.7.1778977566951; 
 Sat, 16 May 2026 17:26:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5be71sm9670317b3a.39.2026.05.16.17.26.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/12] fpu: Introduce exp_scalbn
Date: Sat, 16 May 2026 17:25:49 -0700
Message-ID: <20260517002550.321291-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517002550.321291-1-richard.henderson@linaro.org>
References: <20260517002550.321291-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index a762f4b43a..722bf5ecda 100644
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
index 914e588ec8..0c617beef7 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1108,8 +1108,7 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     uint64_t frac_lsb, frac_lsbm1, rnd_even_mask, rnd_mask, inc;
     int shift_adj;
 
-    scale = MIN(MAX(scale, -0x10000), 0x10000);
-    a->exp += scale;
+    a->exp = exp_scalbn(a->exp, scale);
 
     if (a->exp < 0) {
         bool one;
@@ -1633,7 +1632,7 @@ FloatPartsN partsN(scalbn)(const FloatPartsN *a, int n, float_status *s)
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


