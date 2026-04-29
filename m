Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C983CD13D3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDM2-0000y9-7v; Wed, 29 Apr 2026 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDM0-0000xf-LW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:00 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIDLz-0005Cg-3i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:26:00 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so143010a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777501558; x=1778106358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWRiQ8+0/5b0+mW+9xPCMkFbkAIHbfNeO2YSW11WGWA=;
 b=Uqp0O5HgzdDHUaGwJTw/KXSnR7P77RN4yuvVJvvidnNsMKUQujYolHfxIABqoZl6Wh
 zEtOgSrFDg+modz6cwyoOc5p9JeHP9/FLKIMWZbyW7QXHW+vjoGXSS1Sy59gOQS+A7kZ
 4IgARtUS7BSkGRa9eLE6v9D9VFJNc8NmqEL2F7yVvpHBTBKFq9mySjx6yE34K3+JF/r/
 lu5OdHJIkIrt4KboBDdDADAc6zqtceLX5qicoDJvn6pRP2aOUR67l8UiqaX6+bm+AXYl
 Qz3dyc1wb4RJs6rj93ea2nprH76V4SY9XMBzHgPuoOZfo/MkR1MGEvKnCJT+cM5znMYx
 JCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777501558; x=1778106358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vWRiQ8+0/5b0+mW+9xPCMkFbkAIHbfNeO2YSW11WGWA=;
 b=qClCGxCyiVzb3BAmb07/GoY2wi1uSfv6nMQAoAUC3qXzaD6sU+7r31ipDJZwsCuItH
 s6EZGuU8SDJXzbEGV9M2omx9HEqLgiRpahrA71PgQP9KYiCSyQ8Tes3Rt7juRSglA/ad
 egNomuWo+V3OVSYYltOpYZ09AqPkiIaGcjNkaMHtzRofgC1k8fFoCVHExCaFkMrwifPC
 Yhv6wjqtLWJPgHgYH2900dw+bBFac05co4frm+n+uLFknXdYEIydjsGAyGQHjMLlg7D8
 YejnC18VtOz9Jq52El3K9tnAt2VCWI9MJh06minNOS8cqw0Ev+G2iAMxuLfIUjCsT4YH
 Gjew==
X-Gm-Message-State: AOJu0Yw+a/QqgInFmxKGd4GynQWwhWurP7RQdv8pZVUG48InWyiG/m6m
 GU6DnK7TyPf2d/tzHxwO9QVpubsxuoayfP1PktqYvsCccpKaPzxftaKQWi4YjGD2Fg1h7posz2P
 ZeNwJSLw=
X-Gm-Gg: AeBDiesivsTf6m3ECuJVOnDbV9XG63eIOk2aBp/nXt2RNN9gH3G1JyMZ5oClNM9fZFg
 ZRNlAL/CaMKHWuQMN8BFIcOTQtwRI6kPBZXPhijzXYijqtpliksekor6TJ8xDQsw6FqsaJZiygu
 JQIRoJY0tOsuj/yNJP9kwLbnEUa07K3AyQaAe2c2MsbsMCsH4YHmH/kmG46Rm/HyEylDcvqjqjC
 1MKkCFhfM+GSHZjwC39/XN0FL5mFxS771XUJGsarR37FUt0Mim+al7nlCB1YQXrmnPwlG1R4zxM
 XqeWrbAr4GJH4qkp/RxuH3wS3QvyQVnqbd8zM0D7jByA816/xl1kB75Hl976aRphUrUitDD0Amf
 L62rbK3k9UvSU6QQdxPOhMhwq+Gkvz4V3XcFA/PJGFF0ruw7R2oZJSKKYnrIAYLk5jIa8EL+AVd
 9eu/fW77bTRPa8pfqfPK7CwhxHrCgLVP25pIWUEedy
X-Received: by 2002:a17:90b:3d0b:b0:361:423d:2026 with SMTP id
 98e67ed59e1d1-364c2fce7cdmr202760a91.12.1777501557615; 
 Wed, 29 Apr 2026 15:25:57 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364a2732502sm1888471a91.3.2026.04.29.15.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 15:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/48] fpu: Drop parts_scalbn
Date: Thu, 30 Apr 2026 08:24:23 +1000
Message-ID: <20260429222445.26301-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429222445.26301-1-richard.henderson@linaro.org>
References: <20260429222445.26301-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Use parts{64,128}_scalbn at each call site.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3aebe4a058..3e6f2a152a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -779,12 +779,6 @@ static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
                   FloatParts128 *: parts128_##NAME, \
                   FloatParts256 *: parts256_##NAME)
 
-static void parts64_scalbn(FloatParts64 *a, int n, float_status *s);
-static void parts128_scalbn(FloatParts128 *a, int n, float_status *s);
-
-#define parts_scalbn(A, N, S) \
-    PARTS_GENERIC_64_128(scalbn, A)(A, N, S)
-
 static void parts64_log2(FloatParts64 *a, float_status *s, const FloatFmt *f);
 static void parts128_log2(FloatParts128 *a, float_status *s, const FloatFmt *f);
 
@@ -4678,7 +4672,7 @@ float16 float16_scalbn(float16 a, int n, float_status *status)
     FloatParts64 p;
 
     float16_unpack_canonical(&p, a, status);
-    parts_scalbn(&p, n, status);
+    parts64_scalbn(&p, n, status);
     return float16_round_pack_canonical(&p, status);
 }
 
@@ -4687,7 +4681,7 @@ float32 float32_scalbn(float32 a, int n, float_status *status)
     FloatParts64 p;
 
     float32_unpack_canonical(&p, a, status);
-    parts_scalbn(&p, n, status);
+    parts64_scalbn(&p, n, status);
     return float32_round_pack_canonical(&p, status);
 }
 
@@ -4696,7 +4690,7 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
     FloatParts64 p;
 
     float64_unpack_canonical(&p, a, status);
-    parts_scalbn(&p, n, status);
+    parts64_scalbn(&p, n, status);
     return float64_round_pack_canonical(&p, status);
 }
 
@@ -4705,7 +4699,7 @@ bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
     FloatParts64 p;
 
     bfloat16_unpack_canonical(&p, a, status);
-    parts_scalbn(&p, n, status);
+    parts64_scalbn(&p, n, status);
     return bfloat16_round_pack_canonical(&p, status);
 }
 
@@ -4714,7 +4708,7 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
     FloatParts128 p;
 
     float128_unpack_canonical(&p, a, status);
-    parts_scalbn(&p, n, status);
+    parts128_scalbn(&p, n, status);
     return float128_round_pack_canonical(&p, status);
 }
 
@@ -4725,7 +4719,7 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
     if (!floatx80_unpack_canonical(&p, a, status)) {
         return floatx80_default_nan(status);
     }
-    parts_scalbn(&p, n, status);
+    parts128_scalbn(&p, n, status);
     return floatx80_round_pack_canonical(&p, status);
 }
 
-- 
2.43.0


