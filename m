Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0161E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPT0-0002J1-1L; Wed, 11 Dec 2024 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSo-0001RT-1l
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSl-0007uR-HH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361c705434so6524955e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934081; x=1734538881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E0giBM/EpXvNpQdM8VbewBXwD4I1LGLbeL66q1YYWe8=;
 b=y2h58+qP546ZgI1/ki+Ul0S+bK6Wch1eRTEkmj7ZdpuHCF0OXYPJ2uETy5fuPoUFl1
 DvTP5eXbeEY9cK07sq9as62GHeWSJ9WMdXsv2rFDvXr19qOreOt+snf93y4ieRrzgZIs
 KnyXkYl1phFCmqUDU4upKGmOaX/yzxKTnqiIOIezVuf8nFhDhJNiIg1+nQDHPY3aolX9
 61P5E+V+TdoLEIgjdecz+R9RKgGv6ImQwghGp4V82PEpiiqtP0R7gHsabk+bXS0fbG0B
 TIGmjnVRUb1TbrROaz+tjf4T4m6SuQukoD5mZsrpoB0E3mqclwDeFRY9YIOqzsb4FZFo
 WADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934081; x=1734538881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0giBM/EpXvNpQdM8VbewBXwD4I1LGLbeL66q1YYWe8=;
 b=ox8BZKTeh0E8DfkpaAlR+FWXK60PlYD/wXjFoqwzM+0Nu5pMl+NNVjBvHHxHt3MGDb
 Ml5KSw+G8UhlCcqcwAsEP/B1xS+Qg9QzB5SYt21u0n/y2/tWPGMbyljrIoD9xfAcBDGI
 JBpgeje1ezC7GlmPAk9VIwspPI/yD3A6X3ISs6GowZuMupj9gKb9rSB1zZ4DknZLC0RR
 5tUQDH2td7kHF+OKLz+Rl/Ns4zl6sPMw2oIlQBh2RhHN1YpRPCazk4f8R32GHQCOay32
 Npcz4qTA3eOE7hlYhI5CPpTVoJKybigfegFtf3y6umkqD+rw9EAKEeB+9aIjXe0zLman
 khRQ==
X-Gm-Message-State: AOJu0YwUZvO12P84BY2URRX6Q9tNfzB1NTvRuSBTwg/xV74eKKFmv/Xw
 ihm8KkdJ31u1Zm/lafeStNyj19RbJQHimEADnQXfcab6ozq8Axb2NATJpOdihLDhNmRuh6MtNmu
 l
X-Gm-Gg: ASbGnctoc2sswdOAmvGeHtst8Ai4K9HzRWZFbflvNH8IhDICQh6Wq5TYvF83DobUzwq
 ch6zaQuFBXScXOEj7fZPRpw3mSzbtXBlo2W2GRCJisSz0e2XyF5ATd48wqKyGM0XSFZ7ZERPnyy
 rinowlqm6D7006ulrYiWb5Pcj8VMIQp4bCHeBz6QDtQy3BUT8GVxOwGGvv5lqtB73htIP0uhj65
 UYljBrxgKOWW3PAcISUagr8JhT696HCSR29rqxgS+t3GmmSnt9g+OmhfHha
X-Google-Smtp-Source: AGHT+IGq4/1upfXFgIlB/bxNmYSvLA3vR6ZM6nCu+I9obc5PHJo0UuRNQb9M8kEtmNHPs6DIIgt/vw==
X-Received: by 2002:a05:600c:3b09:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-4361c346a89mr29631275e9.4.1733934081439; 
 Wed, 11 Dec 2024 08:21:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/72] softfloat: Inline pickNaN
Date: Wed, 11 Dec 2024 16:19:59 +0000
Message-Id: <20241211162004.2795499-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Inline pickNaN into its only caller.  This makes one assert
redundant with the immediately preceding IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 82 +++++++++++++++++++++++++----
 fpu/softfloat-specialize.c.inc | 96 ----------------------------------
 2 files changed, 73 insertions(+), 105 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 5fcdbc87fd7..a1b148e90b9 100644
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
index f7a320f6ff9..cbbbab52ba3 100644
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
2.34.1


