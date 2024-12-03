Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD08EE74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZgi-0001Pq-7E; Tue, 03 Dec 2024 15:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgc-0001LA-Et
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:58 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIZgZ-0003Am-Qo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:39:57 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-27d0e994ae3so3547645fac.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733258394; x=1733863194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D37F/cHBY8ajgMOC8jexCpS0iZn1VRkSiMEiE7b+toE=;
 b=MR1+ZZs+2k9oa+xItIcaW7I2AzopaIp4ICpGuUnmU/BpxjKTDq7rcfq0+WU5FZI1n/
 7CTwtDkPpJBxc759AaaRZb4n+tVWP0w8OcxhyF1N4ZzuXVQfyoZe2MQyRNqMOnpb2jfu
 kVD667SnxQVtP0CCQOUyDpXzbalidc4mUcNUYf7g+w0MxNxaPqlaUDhNkCWfOPlR+xt+
 saZTeJpG819RnMD+7O8cb1lBOxUQ8413u5v1eoxXXNB0qcbYrG7c2QMZf5Dqwrjo253m
 Y5NvSegyje0EBYNC3pt8v2vX2fzZ5xDek/AB8Rk2Bsydj3wv1A+Blbd9TseJcaHH+TwI
 GBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733258394; x=1733863194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D37F/cHBY8ajgMOC8jexCpS0iZn1VRkSiMEiE7b+toE=;
 b=YEdeyg22mETCgiMzIhMAqeKxIoo3YNYU6fHv2zGRTM9/18ebA/6Asp5A12C+b08Ppm
 0UPUaNtWDPYIEvo6EiJb1he/FH3HNthgVTwFMB9oUVmk3keJGr9fZwTXBLG8m4h64eAu
 guMrRxYAVqKtNWqqGgRknkgSh9WgW00C76drjRyy5f3U9tCLvOe65mHkt+OnEq2UNUZ1
 Iq2/lZckXndnch85CoRdnDQ2YbWmSe7akfb90UDrWifgg2579Hg17slzsQxwdFHpazL/
 sTHnm3IJz8nLTwiJwQcKyjggC0buDCXAM2piC9fDZt8BNHhvl0/O9dJAZe8tLTO9jnjb
 8Bgw==
X-Gm-Message-State: AOJu0YzBKBVwmk/SJCdHN7xrJhJGXG/H4ZCNTdPHY1abRcjbBD204RUZ
 NIg1c/yzedAa36vUNrO+4K0C8gjNNXPdg4pjMXWkbGFO8mod6orTXVLCeoBHjwoJyz5PjeA0NSQ
 yq3c=
X-Gm-Gg: ASbGnctxm9fUWN5+n6RM/5e0ynzaAmbdRWIHVhDEMZvpHboACP4i31WKmJZZe6bXmNP
 sww9uQEmvWKtj1D9VWLqwF8k2KVsRP44sLlbBhVdu7GEfRGqFrxONhXq/erHZDPZLcGhM46o75u
 uEzN6HpbRvm3TMsbeym7fMVFa4IQO9EKeQkINM6sDPA6Ylnql/b+AZrhhXU0fNpsFCrDgQ7Fnzw
 PSfcW+Vni/uQUL/VE0x9Sh4xDkEPJ5nzeB8sJOgGW2Pk6FpVq8amQ4aeSAdpWpQZvvo7sn6rH+a
 wICPEmFgiJ6iN6TnToj8Qq/J/q1Uq34FY7fe
X-Google-Smtp-Source: AGHT+IGTGXThYn+p/u7jBgLxC44+Lki2da9Xqg9trQwkkg74hq708E+JAI/Qw+MiaBI/XFztXB9ZwA==
X-Received: by 2002:a05:6870:e0c8:b0:29e:3345:74ff with SMTP id
 586e51a60fabf-29e886baf81mr5215810fac.23.1733258394221; 
 Tue, 03 Dec 2024 12:39:54 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29e3ae09f25sm2684018fac.49.2024.12.03.12.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 12:39:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 03/11] softfloat: Use goto for default nan case in
 pick_nan_muladd
Date: Tue,  3 Dec 2024 14:39:40 -0600
Message-ID: <20241203203949.483774-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203203949.483774-1-richard.henderson@linaro.org>
References: <20241203203949.483774-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Remove "3" as a special case for which and simply
branch to return the desired value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index f5c6b21fee..6423e12406 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -79,7 +79,7 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
     }
 
     if (s->default_nan_mode) {
-        which = 3;
+        goto default_nan;
     } else if (infzero) {
         /*
          * Inf * 0 + NaN -- some implementations return the
@@ -87,17 +87,18 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
          */
         switch (s->float_infzeronan_rule) {
         case float_infzeronan_dnan_never:
-            which = 2;
             break;
         case float_infzeronan_dnan_always:
-            which = 3;
-            break;
+            goto default_nan;
         case float_infzeronan_dnan_if_qnan:
-            which = is_qnan(c->cls) ? 3 : 2;
+            if (is_qnan(c->cls)) {
+                goto default_nan;
+            }
             break;
         default:
             g_assert_not_reached();
         }
+        which = 2;
     } else {
         FloatClass cls[3] = { a->cls, b->cls, c->cls };
         Float3NaNPropRule rule = s->float_3nan_prop_rule;
@@ -117,11 +118,6 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         }
     }
 
-    if (which == 3) {
-        parts_default_nan(a, s);
-        return a;
-    }
-
     switch (which) {
     case 0:
         break;
@@ -138,6 +134,10 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
         parts_silence_nan(a, s);
     }
     return a;
+
+ default_nan:
+    parts_default_nan(a, s);
+    return a;
 }
 
 /*
-- 
2.43.0


