Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD848E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSv-0001ud-3r; Wed, 11 Dec 2024 11:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSj-0001KQ-R7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSh-0007tM-7w
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:20 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso5071952f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934077; x=1734538877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WxD1Jy1Rj/MBN3Hz79N9s4ZRpfmRU1nfzEotTIZVleI=;
 b=AhFQRpGqNnV7KIPPWT7WPsjPrqv9aaX9HuPZgTWKNR7f7/Vmjgoh2VztIu29Aq+umT
 YNjEJBGczDBNu5P+my/6g0jSLkyDPy9gQzWM789QJbgvH1GJZlMBHHdGNG8zaZf6VKmY
 hrktZ4gxmQl8axeSYmxVj/0keXu8dDdCYsYYjxvhlk8knbsLus9yfVtTchmZRrRpHgkA
 MDUq/mssszXezpUWAnji3jPidXQ/1oCLl/YJsyMA1AEWl/d4AshKWj05mpp9ImnnszFf
 WZs9evoiOU8Os4oAWOgqd41DQfHuW5bNMVvEWmHUn55byVHg6LAUeAjgJjt13/sin4zd
 mHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934077; x=1734538877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxD1Jy1Rj/MBN3Hz79N9s4ZRpfmRU1nfzEotTIZVleI=;
 b=jKq0ImaO/r6IKQbi+4FiQdTLi2nFilzgWMdLlS55rUW+ZTdDZDh7py8g112B2AgwSH
 qrLtcyv9CHQBwsaeAKz9bhfqDSY4BSQcGQlsDPNWvK3HGpy99LuXx5FT4rgmWhUqH5NL
 Hg/kJtpQbhbwovO70PQDnnDOCLR09eQKaIzrZWJFxAgozIbBmnhhH5F0kad2FgFEH+Zp
 HFhs0VEiX1l88zc6myLiCeCsKTEgumNcI3Mi6+L6br4gpEEv2m7j0biOLBG+Rp+rQcQe
 UxMSCE4VOYedenSgNYcjzXNk+rKclFl6hEjkmkj+5lXkFhtGu9XnN20Uk/dGYHcU1eer
 LtSQ==
X-Gm-Message-State: AOJu0YyHG82to6xGuMibcOi9F1L/iUqv+/07iuZo5KEprdPtIT/TsW3s
 uXm/AhUaEoOIYsqLeDD1gzy7gO+vrngg59cvvz0eQRaXoMj6PE7LayEsCetwXb5pQ3TiLtvrbcN
 X
X-Gm-Gg: ASbGncvjLzSvimtoh2zN3MUoJcL2eBLHlCQkQkf6h8174C/JQHIYnrejI7OxLz32MVa
 TEv5GX1Wxt+X4H+IzLMZIiHWAqL3Z+30PLOyFPRcvyBbEG6YZrd2j8hE287guLlNsBsNN5AI0os
 h29at347T7KMnhwSTbs57727EqzlJ8LBoOQwXRhDhGeFD9Xe/C98VPq0OISGJv/ulZsGFfBZ7Ph
 3AM9ANhqhrHWrcVmW2VNrgXkkTU42UaXJ+mN6CdgKCPHd4EIQbXMlwbYcHD
X-Google-Smtp-Source: AGHT+IFRVEvVm30fL3SZv4nPO+1EtSnuPt2UB/IKrWSxjSBSTTiCPzmfPiWoN3DUm7kK+15GtsTg1A==
X-Received: by 2002:adf:e181:0:b0:385:edd1:2249 with SMTP id
 ffacd0b85a97d-387876c4969mr189948f8f.50.1733934077631; 
 Wed, 11 Dec 2024 08:21:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 63/72] softfloat: Remove which from parts_pick_nan_muladd
Date: Wed, 11 Dec 2024 16:19:55 +0000
Message-Id: <20241211162004.2795499-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Assign the pointer return value to 'a' directly,
rather than going through an intermediary index.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241203203949.483774-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat-parts.c.inc | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index be7e93127d4..525db617411 100644
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
@@ -104,42 +104,30 @@ static FloatPartsN *partsN(pick_nan_muladd)(FloatPartsN *a, FloatPartsN *b,
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
2.34.1


