Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAD2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ4-0001OV-GF; Wed, 20 May 2026 13:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYv-0001Jz-QX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:30 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYs-0001sy-IY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:28 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso2646365a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297505; x=1779902305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=y3OT+wBDxDO3LQUQs2I77DI8jbA2HA5hOuMyu5uTFM2yvl5cu1f7AgnvfeCPDP+6GA
 oeXXSp5NjCBErwWYBADbpd/I0RMyCNmU22wkT7G16Zn3+AgIk2Rj4sKLln9OfU+0LuCu
 d6etZeQvbOaz0Mwtt5DuZuj3N6lp9HSKhtXVXLz3NmjB32sS/Un/XJkbv4C/XDihRGCi
 V4CikPWV+YzoPhBYfvCenyTtbiVYg7R/UcS6M4jwj7b9+rsFw1WCCmLKAll7sCgrjWZI
 Bp3yaMNW7pEA05aCbufpJpKWfcJskfz9tIpVEKO1UDB4YKivEDYJGFpyCEtol1//L5U7
 sNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297505; x=1779902305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXEFjIA2Rc2Ly2XJsgxo/zPmqwc6w9LU/oPQ8iHupDk=;
 b=kwxZZSestpn6FhAwrdVwctWNt88axCkjnDQU3qrBiHQ+zVQUGGKIQMX56IHXyOsf1s
 1q4NFSAghadck78TylKdfXep45RGk3X5jIv3HmuVNB2nM9Xt+j/YwtIRiajACylyW0fB
 8HglxEYOZ7c0Bv8cYMME5XBLkvmvyPMGQw0wWB0FGaFHMhS0rLOEvc4r+LJzTg13N59i
 zbVRydcg5gB6sloiHJz0QoM0PNHqWUAxjLC0fJRV0GgXDh5ggrVVnqcz/SywQOiFNYo1
 a1DefUdAXWqnsjAdlX//tToxb1dmLeLjWRhQuOorP7i9JyTN4eHCMZTfDn1gMdcM2/qt
 9Yxg==
X-Gm-Message-State: AOJu0YyiEAdAVHpAsZwz3HUYBC8JTdIEz/HYQCdOx6xVrb0xxd8TObXK
 fxcx5bHgFIzhepaRUWXR4zcyqvQFwd9pt68O7ABDSUYbZx5rSi4DJK6xNsCSjJP3hjOZWZFL5xd
 f9wpLtoI=
X-Gm-Gg: Acq92OHTAhxNQk7fX8te8r2vle37Eu+o1IKY0OfvSre/+5uCTarVaXHKXtv5eohdOlr
 XRmaGVeg+hYoyaQH8Z75B+YRDFkScNXp3+ve5AxUn0L1R2EcfotAKrxgcrK0Pqa3ov3Wwm+fca7
 HgrKkG+xDVe2HBiOQMI7K4uNHHR8QQkQpN2X/fPtJAXclhZAzbjHIycEw8XLCqXHUT/M9e9WM+u
 wziwFz519riaMQbjO8eIThojdtrmDTZJb0/vxb+cS0lOJ5zvShopPzBfyzGpOomjOp1VdOTrA+/
 jAPoqmDtb8Ma+TfriIUMEmJdR0eU5MD9K5ZDyTrgPD/+TlOB8zgqqiI0gMr1meh9P82ULjRpS/R
 84JqroKvH+W8CJe7ROjDHUnozQj9IXWgmuoZNrrhBwy7aKTA7eJreBsOEl+aepzEECb/JE73rVt
 XehOk2epynro0NLotionusJrJ0kPk3dEA6cq29O73CAptjHBuy9A==
X-Received: by 2002:a17:90b:3c10:b0:369:a359:b189 with SMTP id
 98e67ed59e1d1-369a35a15a7mr16712972a91.19.1779297505085; 
 Wed, 20 May 2026 10:18:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 04/30] fpu: Hoist nan check in partsN_addsub
Date: Wed, 20 May 2026 10:17:54 -0700
Message-ID: <20260520171820.848839-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

The nan test had been down below because it was unlikely.
But if we have to have one anyway because of denormals,
we might as well take care of them right away.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 437b333341..3246702289 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -530,13 +530,15 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
 {
     int ab_mask = float_cmask(a_orig->cls) | float_cmask(b_orig->cls);
 
+    if (unlikely(ab_mask & float_cmask_anynan)) {
+        return partsN(pick_nan)(a_orig, b_orig, s);
+    }
+
     /*
      * For addition and subtraction, we will consume an
      * input denormal unless the other input is a NaN.
      */
-    if (!(ab_mask & float_cmask_anynan)) {
-        record_denormals_used(ab_mask, s);
-    }
+    record_denormals_used(ab_mask, s);
 
     FloatPartsN a = *a_orig;
     FloatPartsN b = *b_orig;
@@ -558,10 +560,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             if (a.cls != float_class_inf) {
                 /* N - Inf */
@@ -586,10 +584,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
             return a;
         }
 
-        if (unlikely(ab_mask & float_cmask_anynan)) {
-            goto p_nan;
-        }
-
         if (ab_mask & float_cmask_inf) {
             a.cls = float_class_inf;
             return a;
@@ -604,9 +598,6 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
     g_assert(a.cls == float_class_zero);
     g_assert(is_anynorm(b.cls));
     return b;
-
- p_nan:
-    return partsN(pick_nan)(a_orig, b_orig, s);
 }
 
 /*
-- 
2.43.0


