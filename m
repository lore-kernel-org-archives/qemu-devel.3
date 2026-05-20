Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A3CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ8-0001T5-3j; Wed, 20 May 2026 13:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYw-0001K2-2z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:30 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYu-0001t6-4U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:29 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so5404842a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297506; x=1779902306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aizZ6KsxuScbuarSuGl62Wou0yp8xd59JdQCbRvge3Q=;
 b=c/zAX4lzRbGWc7nIPGb7/e2HFtKp+iOZL5o0Bu7k6CXaqtqPHGIhMrhfkb4hXOsyvC
 TvcVhhJZM5+maRc2Y1boawV7h+BjYZF4c8QpcLkIYx71vD1wUhQ/LUATeBbrITaOIFXt
 c1xbwf3W5rZmDIp/zYj3gIyQkrrxgcmFab20z2ofujbYKQpQ7ohUMf4smqOfuAaJ7np3
 zbNSw8jFEK7NhEq5PQWGW/DY4OkzOcE03cWmtTXX5RGzxdsVEWsPirgemGKez8HH084X
 TYVIP1Rjh35b8FYPq80UWwoWvMHUfrzfM8SkP2VmmSjkGYbBf1gTdzTwcmLmrVAbRN56
 TGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297506; x=1779902306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aizZ6KsxuScbuarSuGl62Wou0yp8xd59JdQCbRvge3Q=;
 b=orD3wdSeGcNZzJzLEtDt2W0dQKnMo1BzYpNE4Z/DgaxsnzXql9HH91AogBtoSvULYw
 ZMkvk6WQNv1Wm2ApCrd38HFrbAyb6fCwd3jFO6GS7AURuv3Nje+O6W+msyuOmqkqYmMs
 jS9Oa5RCiebk5B5PwLG8tyEzQ1QM0EHnLwZlH9PlcOFXuC2zSSYKWdczD4X4wvcAcfDE
 iUEF8msGUEm/o41jVR7phmOSbdOz4G9WYAwVrtEpihQ4JYr9riNhFE6p2Gagdtzzp8EZ
 zIqq4CPCXki1IMyj90tpfJGHbZ/EkvNl77r06nR+PUDkCdDpsuoHNPveT+wUEiJLyfdH
 m3KQ==
X-Gm-Message-State: AOJu0YzFhY+YzJNt6tyksxav7BTbHMkQ4OlQUKkA2uPgZRdTh5l+ObW1
 pCs7XPSH57N5ax1+PAUC/V0H431ynMn5NMedTjqwbTeWFl6gL839j5P8lPyd41S5fElwHpTet//
 x0Gh/NQA=
X-Gm-Gg: Acq92OFNfg98MfDuvGouhU3galnFZ4caNJXu3jB2F8i8fexMcQYFcKzPBB9homM8MFY
 MkgUviWbfON8TojuSVMvOjsrkVl2NdQY4XbVZP3nSJxhCmeP9YafdKoLGjrFKNXNvHalhDMAHBN
 hwv/7Nt4rYuvBU/H3FjoRaURFtBICVBIUWzamjeLjSvtYFFEAYZV1MsDxZ+ZtJEYMXHlZwxUYys
 VH5UcnKSNT8KuMPl3pZChoK+7J2y1xRXd/BsiWm7XOtqPylzHYaPAP6AQIJHwyD6WD7FJzX3Mag
 OCgkxIcoXzTFIRZ4awTNFwOS292IlPuxCp+FqHqlA4tJnxNKah9M0qtiMeeCFlR/RQWOJoPF9uX
 Rec6FNew0alUu5yO5BuUDEtqRwdSxMg7M+cbjD6515P9NCSOZsAxW8CzHLNBWdztaL9aCuNMkS6
 g8LgxFTLREiTWgLii3nV0MQ+2evuWb
X-Received: by 2002:a17:90b:3901:b0:35f:b5df:463 with SMTP id
 98e67ed59e1d1-36951b7835amr22394826a91.14.1779297505710; 
 Wed, 20 May 2026 10:18:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 05/30] fpu: Simplify 0 +/- N case in parts_addsub
Date: Wed, 20 May 2026 10:17:55 -0700
Message-ID: <20260520171820.848839-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Consolidate the tests for zero and anynorm.
Add comments for a few cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3246702289..45606f8402 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -556,6 +556,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 - 0 */
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
@@ -581,23 +582,20 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 + 0 */
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
+            /* N + Inf or Inf + N */
             a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b.cls == float_class_zero) {
-        g_assert(is_anynorm(a.cls));
-        return a;
-    }
-
-    g_assert(a.cls == float_class_zero);
-    g_assert(is_anynorm(b.cls));
-    return b;
+    /* 0 +/- N or N +/- 0 */
+    assert((ab_mask & float_cmask_zero) && (ab_mask & float_cmask_anynorm));
+    return b.cls == float_class_zero ? a : b;
 }
 
 /*
-- 
2.43.0


