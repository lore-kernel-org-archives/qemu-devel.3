Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4FCE74AD2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZgu-0001Yu-3z; Tue, 03 Dec 2024 15:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgd-0001LT-2E
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:40:00 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZga-0003As-UV
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:58 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29e5bf419ebso1564515fac.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258395; x=1733863195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxoUNyLc0dEDDQUspYmsgb0BaeY/3JixWBMZpMBDUos=;
 b=p/drL0ThAQJr0KFGIuGN9wo88HHdKek9SKBBvVsiAUvsgbDMiEPqANFG/Thu6Ls15+
 IRz3+vyQMTwNAeRjSVpjdM1Amm1JzyGuZuGVjavg2kvxmeIXG5bk6TAyUDf8uRNejLT9
 9pt/8JGfh97I5Lsn0sb7vorj1K7K6N6HKnPOt73YcZEKwLzPKt2pdq8vqcDyrBvcMESL
 zo5KDY3S4bMfLLY7Anxfm167NBJ2tzbsWG9joGELIJc0z/1hz1oaeer8KNKTA2vcavJ8
 5bT71ITohoF0HgM0ztoT9ScG6j3E5SRpz8yP+l+nqQ5bscKNlyASJxsK/WIyvIK8Fbok
 IrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258395; x=1733863195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxoUNyLc0dEDDQUspYmsgb0BaeY/3JixWBMZpMBDUos=;
 b=Ej3dl1yMs+MqzNNX4RyT651tWu1kmbSYrXYnRGQla2dCBlcV3ASa3QUq5ThfFljuoO
 syTUmvdbblRHwJwOAO8SYAWl4187Njw8KWRhBGpipUz6Hf+NWS9ZVCd8UAY8s57oOBRx
 69RZTNyHZwh/aegWOIthhs/5I8V2eNz7wbXkJMGOekfyKAdRc95DQarMerR5TBsTn8nG
 xxGPQlHJJR/fni0LTYHbiits3yXW6AGPF6RLElXAC8vpE7tUqy9pnYh7vQ0ub7R08FMw
 ec6lFk2MNx6C1DCpXBT0miHJOrOy1Ro0stwD/bX9hzpMOhqEOLAEqfVwc1l4eWIcbY7/
 E7qg==
X-Gm-Message-State: AOJu0YxjOvyRFu9338/DD98lrGM9r0guMJWiicpwzYL8N4QLjD8VE6CT
 3+VSkS41bLYMPejqQPUeGKfvHnyl9jaBBjLJBMYHg63GmV7pki9DMu7elgC+ibpXF7Vxz+5ZWC4
 Q4iI=
X-Gm-Gg: ASbGncuAFjJenIWjnbEhW96VktYNpgfaCQaph+f3Ps69C/p0Nl0JQVPmYUzQjqLxd0r
 ZjinwZnR0NmVG9HpN5n09he9BVRmTd+4Pfe1UvUDFb90x8QwRrjt91H7B2qxTibtf6Ect/AsCXB
 NLbnU28mqu2KhkVl/D9Jn6M9SQH71Vlqgz/uQwXd5y13v2syeQrihlks5nwG/AeES7btMrm5/a0
 VnhuS6m5axOKGNoCBkk9H5GE2SH4gLIow0mqoDvTIzHZTPPDTZJie8PDHg9fVrI8mXyycFX63IE
 Et/3bNy/CX19+1zx7qdDQc0o8IPxFQcTBKne
X-Google-Smtp-Source: AGHT+IHw0JjOX1V0fqvxXRzTILTt6i2QT+U9+bCt0KRJphsKKMLfnwWZKYrodyC/1xWO6gPPt1RT7Q==
X-Received: by 2002:a05:6871:10d:b0:29e:20c4:2217 with SMTP id
 586e51a60fabf-29e888949cfmr4315626fac.33.1733258394905; 
 Tue, 03 Dec 2024 12:39:54 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 04/11] softfloat: Remove which from parts_pick_nan_muladd
Date: Tue,  3 Dec 2024 14:39:41 -0600
Message-ID: <20241203203949.483774-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Assign the pointer return value to 'a' directly,
rather than going through an intermediary index.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6423e12406..77f16ac158 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -65,9 +65,9 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
                                             FloatPartsN *c, float_status *s,
                                             int ab_mask, int abc_mask)
 {
-    int which;
     bool infzero = (ab_mask == float_cmask_infzero);
     bool have_snan = (abc_mask & float_cmask_snan);
+    FloatPartsN *ret;
 
     if (unlikely(have_snan)) {
         float_raise(float_flag_invalid | float_flag_invalid_snan, s);
@@ -98,42 +98,30 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         default:
             g_assert_not_reached();
         }
-        which = 2;
+        ret = c;
     } else {
-        FloatClass cls[3] = { a->cls, b->cls, c->cls };
+        FloatPartsN *val[3] = { a, b, c };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
 
         assert(rule != float_3nan_prop_none);
         if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
             /* We have at least one SNaN input and should prefer it */
             do {
-                which = rule & R_3NAN_1ST_MASK;
+                ret = val[rule & R_3NAN_1ST_MASK];
                 rule >>= R_3NAN_1ST_LENGTH;
-            } while (!is_snan(cls[which]));
+            } while (!is_snan(ret->cls));
         } else {
             do {
-                which = rule & R_3NAN_1ST_MASK;
+                ret = val[rule & R_3NAN_1ST_MASK];
                 rule >>= R_3NAN_1ST_LENGTH;
-            } while (!is_nan(cls[which]));
+            } while (!is_nan(ret->cls));
         }
     }
 
-    switch (which) {
-    case 0:
-        break;
-    case 1:
-        a = b;
-        break;
-    case 2:
-        a = c;
-        break;
-    default:
-        g_assert_not_reached();
+    if (is_snan(ret->cls)) {
+        parts_silence_nan(ret, s);
     }
-    if (is_snan(a->cls)) {
-        parts_silence_nan(a, s);
-    }
-    return a;
+    return ret;
 
  default_nan:
     parts_default_nan(a, s);
-- 
2.43.0


