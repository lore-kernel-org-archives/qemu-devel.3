Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A13E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSq-0001eg-Qu; Wed, 11 Dec 2024 11:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSj-0001KO-Pi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSf-0007sy-R6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:20 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso5906855e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934076; x=1734538876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D00DSruytulbxjjJ4e78+Qdhi69cDsAe2XaYdtO6NTo=;
 b=a1xpGjNlSG5xouRdtwNQ5CKigMBpMpaOvgWTe1gWlcNe0dPfGJjYizSTFXL5/QKa52
 wQhJ2/yfWy9II3X8WXj6kPYI/8vkhE1/wk1J5Q42Y57M+9P4WT5EU4VSq7864lYQogSW
 xNoXCwf1hhWjEm9LVWGEfjaqDn5LJyAiqZk3XwxrKbkOVKanE4fQ7mf1Buemce+hdKep
 BO9YANPoMsjcWMZ12JrcYHqiCQycUF9TWDFD+d3dhHbpFFwHn+CmybZz9r86PNNVvJLr
 pAvsKi5XOLwihy5VdLjoSx05SGlInIfGSAjAOWSzNKYN/NBSlTNUG3M3WkhK1UckB2vw
 9Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934076; x=1734538876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D00DSruytulbxjjJ4e78+Qdhi69cDsAe2XaYdtO6NTo=;
 b=nXyizC3SOPEvaTbPOwBSYaITcyerRcCf+qavOZGWH+YnXx0odO2v88SvzLoNs2Zo3A
 InVBGYNy0eODTjFTNJ2x+6GjgMKm9iP0eNenU9rDD6/dRdTatOKSvVHqYZKme88EcSg1
 +Poa50EQPpx2C0uNGZWsbXx/WfpxjHQqnfNmW/vaMZ9ZNz1qO3CmGV4f5gFrBGNd6DqE
 9gSgEp4esF7kYktXecgNXJ07TH2zbF5HsvpkfYMJuPiKHQOiH3avk12E1ks9OccZ8UKq
 0ceJICaCc+w34AOAE6o18iwBDMP9tDhfT9GmfgvmOLZQkQyYfIIAF7UM0RcF0egBCfTW
 tA/w==
X-Gm-Message-State: AOJu0YzHdKoISzq8IFKdXh/Wc58Huc6awyci6KXKICKkFCD08jvSaeXZ
 hMTkt+IhxlHMHcmoOWvoxdb7EipjSk/IbuNe+t3+ZUJ8vH04gos0cXrhrH8ZY7xagvdv+6vvXX8
 E
X-Gm-Gg: ASbGncv1X4mOs/Zv/sbuV8UPWnjA57+XRtCwmQAPdzI9urwDbUqJFnKSBwoAz6gmyt1
 gE2ye712tssQM50jVht0qKKfLkIGqIkJ7z8fGSO31s9OT9l/0DMh0Y3ceBxcYW2m5Lk6sbgeQVK
 fzEjbU10MXCGJHqXBBfI1NdgUdTdTc5sKjKJ7wmA7ykeqUTa22c26bddCa4KNmgpXVOIcxPiu5C
 6tCK46QgUfDxpFBiOBJQv3FBJ0PLZoYHOMD5TqBWRO0eNNFXQIEl5pRIRDu
X-Google-Smtp-Source: AGHT+IEK5K4s41L+y15+QchqtoBbbgh+OSPX2oonZ29eXnyvngqJfQejFrzcuPoC8wAe5kvgHP5fPQ==
X-Received: by 2002:a05:600c:5108:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-4361c35d6b9mr28382815e9.12.1733934075760; 
 Wed, 11 Dec 2024 08:21:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/72] softfloat: Inline pickNaNMulAdd
Date: Wed, 11 Dec 2024 16:19:53 +0000
Message-Id: <20241211162004.2795499-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Inline pickNaNMulAdd into its only caller.  This makes
one assert redundant with the immediately preceding IF.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-3-richard.henderson@linaro.org
[PMM: keep comment from old code in new location]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc      | 41 +++++++++++++++++++++++++-
 fpu/softfloat-specialize.c.inc | 54 ----------------------------------
 2 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 655b7d9da51..c1a97c35b20 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -79,9 +79,48 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
+        /*
+         * We guarantee not to require the target to tell us how to
+         * pick a NaN if we're always returning the default NaN.
+         * But if we're not in default-NaN mode then the target must
+         * specify.
+         */
         which = 3;
+    } else if (infzero) {
+        /*
+         * Inf * 0 + NaN -- some implementations return the
+         * default NaN here, and some return the input NaN.
+         */
+        switch (s->float_infzeronan_rule) {
+        case float_infzeronan_dnan_never:
+            which = 2;
+            break;
+        case float_infzeronan_dnan_always:
+            which = 3;
+            break;
+        case float_infzeronan_dnan_if_qnan:
+            which = is_qnan(c->cls) ? 3 : 2;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        which = pickNaNMulAdd(a->cls, b->cls, c->cls, infzero, have_snan, s);
+        FloatClass cls[3] = { a->cls, b->cls, c->cls };
+        Float3NaNPropRule rule = s->float_3nan_prop_rule;
+
+        assert(rule != float_3nan_prop_none);
+        if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
+            /* We have at least one SNaN input and should prefer it */
+            do {
+                which = rule & R_3NAN_1ST_MASK;
+                rule >>= R_3NAN_1ST_LENGTH;
+            } while (!is_snan(cls[which]));
+        } else {
+            do {
+                which = rule & R_3NAN_1ST_MASK;
+                rule >>= R_3NAN_1ST_LENGTH;
+            } while (!is_nan(cls[which]));
+        }
     }
 
     if (which == 3) {
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index e075c47889a..f26458eaa31 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -448,60 +448,6 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     }
 }
 
-/*----------------------------------------------------------------------------
-| Select which NaN to propagate for a three-input operation.
-| For the moment we assume that no CPU needs the 'larger significand'
-| information.
-| Return values : 0 : a; 1 : b; 2 : c; 3 : default-NaN
-*----------------------------------------------------------------------------*/
-static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
-                         bool infzero, bool have_snan, float_status *status)
-{
-    FloatClass cls[3] = { a_cls, b_cls, c_cls };
-    Float3NaNPropRule rule = status->float_3nan_prop_rule;
-    int which;
-
-    /*
-     * We guarantee not to require the target to tell us how to
-     * pick a NaN if we're always returning the default NaN.
-     * But if we're not in default-NaN mode then the target must
-     * specify.
-     */
-    assert(!status->default_nan_mode);
-
-    if (infzero) {
-        /*
-         * Inf * 0 + NaN -- some implementations return the default NaN here,
-         * and some return the input NaN.
-         */
-        switch (status->float_infzeronan_rule) {
-        case float_infzeronan_dnan_never:
-            return 2;
-        case float_infzeronan_dnan_always:
-            return 3;
-        case float_infzeronan_dnan_if_qnan:
-            return is_qnan(c_cls) ? 3 : 2;
-        default:
-            g_assert_not_reached();
-        }
-    }
-
-    assert(rule != float_3nan_prop_none);
-    if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
-        /* We have at least one SNaN input and should prefer it */
-        do {
-            which = rule & R_3NAN_1ST_MASK;
-            rule >>= R_3NAN_1ST_LENGTH;
-        } while (!is_snan(cls[which]));
-    } else {
-        do {
-            which = rule & R_3NAN_1ST_MASK;
-            rule >>= R_3NAN_1ST_LENGTH;
-        } while (!is_nan(cls[which]));
-    }
-    return which;
-}
-
 /*----------------------------------------------------------------------------
 | Returns 1 if the double-precision floating-point value `a' is a quiet
 | NaN; otherwise returns 0.
-- 
2.34.1


