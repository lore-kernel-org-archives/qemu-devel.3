Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36089E74AD3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZh9-0001cd-0h; Tue, 03 Dec 2024 15:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgh-0001Qo-L9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:04 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgd-0003Bu-V5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:01 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ea36b05654so3055760b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258399; x=1733863199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE9Xl02UsRFXlQRaYTkoaksxQH+Xcw8LkQwIo9WLMj4=;
 b=Aqdk3YRoihF5I5Sm2EzaMdqKOmvHTL3Oy9a7UT13m6rwgmuggvay56dC+6Bdp8wIcH
 Z6r3+TJFb3uGHNuWl/fV/36JPNGlq6nLnnwzzqVmEzbtJBBX3H/7a5gSFVJ3DLNwuhkF
 j5EgG3PeI2x9a1YTRZZOqwznNn6mkqcFa+H+Up1BLl31qOtf3Tmc/ftCPTchLd+fAnws
 XTenH01nhpBAMJDQkhGzr4Yo4QRwm/tiaRxn47LICuXaplTWZiTsvsGnvlqbCJlSDXeX
 n3kj471hpgG9ggtiR9yQu+16I18QveuDNpjVXYuTx6ilzX231GvZ72o3dHI4kCXfrfdm
 IiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258399; x=1733863199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vE9Xl02UsRFXlQRaYTkoaksxQH+Xcw8LkQwIo9WLMj4=;
 b=vv9gfK2S6hzRk4mPIC9up7ZkjFWPF9HKQZKCuL1Cg1NvlOqKIoa/pXM8reT/8F6e79
 X9f27QuJpwPJx4kW6ZXKTotUUZZEnfw790cdVMh3C6ZSeYSBWntRpiNnKlItt1Y6rVJy
 Sq6V31y8u2RzUsEmdxCjWDqVfN8gl6dLEb+6lQDM0HG5zaWcikRpiRo2KfMYIjRCsEU+
 OvPRZPvu3b+Io4Yh8n5/kdJFZVOIcknhlU3xLNbmyJ+2fA1HmtyuR7/Lkb6WJoICW6JO
 JsglCr6kBmzTWR6EB1M+e6scvz+T5A4pkgYi3QM0k9hd8cI2t6Pwr09a6V0w4aU128BD
 jKHw==
X-Gm-Message-State: AOJu0YxCjF9Y0dSZaivkLIiFrfa2iPO6Z7VTkf2QZWB7nyUXsDY2gatt
 MbcgI3NtPUE5u0s7jqK4bH8vVmb2PQ06jSO3Fc50kRHKjON0Ss9UO4p3X5xPnf8uQlNk2YQnpR3
 Gvio=
X-Gm-Gg: ASbGnctIy/8RA/q368xORJB3wWjOWbE9W4DK31aMcUw8bld1tvV9pZe7+63Py8YZk1U
 is3YRYs6DKHJAXRCeKZvHoSU0BDVXUL047y1FBr6yfTM+QKUnRY3lZHiO2Es/M7kRm9F+fhr5wa
 UOZZn90rcCjdw7E7meb96BOPYKd4/XOguEZW031BY+oQUr8yB2L4MKgAX7g1F/18+S+8LVp/uuH
 GIp/CxBBFgBQW+pfsnHcpqUnS21AY79wJbEH7brnFTVmsPSQdESfsp/VT9F1EYjphds0fPvh3CI
 jNBJ6K6usZnI5mnZQwNEYLniUa+LGkeIq87p
X-Google-Smtp-Source: AGHT+IFXZGbyOMWyI59BMLeYD/mvVz9Oy6d2DNzS+rV3qc3IyeYa6/Fy9EAD847+FALhm7GKtpvqwQ==
X-Received: by 2002:a05:6808:17a8:b0:3e7:5af6:af0f with SMTP id
 5614622812f47-3eaf04252cbmr910702b6e.39.1733258398717; 
 Tue, 03 Dec 2024 12:39:58 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 08/11] softfloat: Inline pickNaN
Date: Tue,  3 Dec 2024 14:39:45 -0600
Message-ID: <20241203203949.483774-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Inline pickNaN into its only caller.  This makes one assert
redundant with the immediately preceding IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 82 +++++++++++++++++++++++++----
 fpu/softfloat-specialize.c.inc | 96 ----------------------------------
 2 files changed, 73 insertions(+), 105 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 06cfc6abb5..de51097dcf 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -39,24 +39,88 @@ static void partsN(return_nan)(FloatPartsN *a, float_status *s)
 static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
                                      float_status *s)
 {
+    int cmp, which;
+
     if (is_snan(a->cls) || is_snan(b->cls)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
     }
 
     if (s->default_nan_mode) {
         parts_default_nan(a, s);
-    } else {
-        int cmp = frac_cmp(a, b);
-        if (cmp == 0) {
-            cmp = a->sign < b->sign;
-        }
+        return a;
+    }
 
-        if (pickNaN(a->cls, b->cls, cmp > 0, s)) {
-            a = b;
-        }
+    cmp = frac_cmp(a, b);
+    if (cmp == 0) {
+        cmp = a->sign < b->sign;
+    }
+
+    switch (s->float_2nan_prop_rule) {
+    case float_2nan_prop_s_ab:
         if (is_snan(a->cls)) {
-            parts_silence_nan(a, s);
+            which = 0;
+        } else if (is_snan(b->cls)) {
+            which = 1;
+        } else if (is_qnan(a->cls)) {
+            which = 0;
+        } else {
+            which = 1;
         }
+        break;
+    case float_2nan_prop_s_ba:
+        if (is_snan(b->cls)) {
+            which = 1;
+        } else if (is_snan(a->cls)) {
+            which = 0;
+        } else if (is_qnan(b->cls)) {
+            which = 1;
+        } else {
+            which = 0;
+        }
+        break;
+    case float_2nan_prop_ab:
+        which = is_nan(a->cls) ? 0 : 1;
+        break;
+    case float_2nan_prop_ba:
+        which = is_nan(b->cls) ? 1 : 0;
+        break;
+    case float_2nan_prop_x87:
+        /*
+         * This implements x87 NaN propagation rules:
+         * SNaN + QNaN => return the QNaN
+         * two SNaNs => return the one with the larger significand, silenced
+         * two QNaNs => return the one with the larger significand
+         * SNaN and a non-NaN => return the SNaN, silenced
+         * QNaN and a non-NaN => return the QNaN
+         *
+         * If we get down to comparing significands and they are the same,
+         * return the NaN with the positive sign bit (if any).
+         */
+        if (is_snan(a->cls)) {
+            if (is_snan(b->cls)) {
+                which = cmp > 0 ? 0 : 1;
+            } else {
+                which = is_qnan(b->cls) ? 1 : 0;
+            }
+        } else if (is_qnan(a->cls)) {
+            if (is_snan(b->cls) || !is_qnan(b->cls)) {
+                which = 0;
+            } else {
+                which = cmp > 0 ? 0 : 1;
+            }
+        } else {
+            which = 1;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (which) {
+        a = b;
+    }
+    if (is_snan(a->cls)) {
+        parts_silence_nan(a, s);
     }
     return a;
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index f7a320f6ff..cbbbab52ba 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -352,102 +352,6 @@ bool float32_is_signaling_nan(float32 a_, float_status *status)
     }
 }
 
-/*----------------------------------------------------------------------------
-| Select which NaN to propagate for a two-input operation.
-| IEEE754 doesn't specify all the details of this, so the
-| algorithm is target-specific.
-| The routine is passed various bits of information about the
-| two NaNs and should return 0 to select NaN a and 1 for NaN b.
-| Note that signalling NaNs are always squashed to quiet NaNs
-| by the caller, by calling floatXX_silence_nan() before
-| returning them.
-|
-| aIsLargerSignificand is only valid if both a and b are NaNs
-| of some kind, and is true if a has the larger significand,
-| or if both a and b have the same significand but a is
-| positive but b is negative. It is only needed for the x87
-| tie-break rule.
-*----------------------------------------------------------------------------*/
-
-static int pickNaN(FloatClass a_cls, FloatClass b_cls,
-                   bool aIsLargerSignificand, float_status *status)
-{
-    /*
-     * We guarantee not to require the target to tell us how to
-     * pick a NaN if we're always returning the default NaN.
-     * But if we're not in default-NaN mode then the target must
-     * specify via set_float_2nan_prop_rule().
-     */
-    assert(!status->default_nan_mode);
-
-    switch (status->float_2nan_prop_rule) {
-    case float_2nan_prop_s_ab:
-        if (is_snan(a_cls)) {
-            return 0;
-        } else if (is_snan(b_cls)) {
-            return 1;
-        } else if (is_qnan(a_cls)) {
-            return 0;
-        } else {
-            return 1;
-        }
-        break;
-    case float_2nan_prop_s_ba:
-        if (is_snan(b_cls)) {
-            return 1;
-        } else if (is_snan(a_cls)) {
-            return 0;
-        } else if (is_qnan(b_cls)) {
-            return 1;
-        } else {
-            return 0;
-        }
-        break;
-    case float_2nan_prop_ab:
-        if (is_nan(a_cls)) {
-            return 0;
-        } else {
-            return 1;
-        }
-        break;
-    case float_2nan_prop_ba:
-        if (is_nan(b_cls)) {
-            return 1;
-        } else {
-            return 0;
-        }
-        break;
-    case float_2nan_prop_x87:
-        /*
-         * This implements x87 NaN propagation rules:
-         * SNaN + QNaN => return the QNaN
-         * two SNaNs => return the one with the larger significand, silenced
-         * two QNaNs => return the one with the larger significand
-         * SNaN and a non-NaN => return the SNaN, silenced
-         * QNaN and a non-NaN => return the QNaN
-         *
-         * If we get down to comparing significands and they are the same,
-         * return the NaN with the positive sign bit (if any).
-         */
-        if (is_snan(a_cls)) {
-            if (is_snan(b_cls)) {
-                return aIsLargerSignificand ? 0 : 1;
-            }
-            return is_qnan(b_cls) ? 1 : 0;
-        } else if (is_qnan(a_cls)) {
-            if (is_snan(b_cls) || !is_qnan(b_cls)) {
-                return 0;
-            } else {
-                return aIsLargerSignificand ? 0 : 1;
-            }
-        } else {
-            return 1;
-        }
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the double-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.43.0


