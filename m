Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749AAFF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzpc-0008WQ-6G; Sun, 26 Apr 2026 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoY-00068g-4d
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzoW-0001dw-0G
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:46:25 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso60078005ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211182; x=1777815982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hheroKdVLCGDtCk2AAibf10Z6m4QN+uSO6ssI9+89yQ=;
 b=QxKqJB7NpSJ5FPD6leC6HXRu9vw7WuAhgZktVaBzHFU2TU7dte1CFBf42dtQFUWIVi
 KNp3b4a/721aZ2L+smanaJokDgeoBvV4pWLB2uDHD8wP9rP1n3mKtSu2NsMgua671P4U
 KUFIItZfSpJWu7LQEgkJfceR4iOCQPEb/MQHFBx4oDZEvivB28KUNCubF9p5yK+KKPYb
 yNR1rKh3CPQyL6IhWY3Pkf+y0dfXgrWFd9xoM749yIZF0ClkgEfSx13z+Ogzz9dDLP5E
 pixwQp6L4UhpQX36fhS6qH89Hj/NBWKhluQsqskGvAkErqB6FRrQfcOvWVyTiZwIr63t
 i5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211182; x=1777815982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hheroKdVLCGDtCk2AAibf10Z6m4QN+uSO6ssI9+89yQ=;
 b=HGrcpqJi+F5JTOMW2GaSRflkH+S8Rl6pirUVlXVxEVVt920JleDiqo9MMOurgZ7dX6
 fFEwGINRYoqHKLVZenjprsSHcfGkrSO6IEGq30EaO7EC140QywCnwUzFsIapNJiOq/58
 7PMhn9Pncn/cqWtbhCfSajs92rHIyXQnpokpirLBj7/jiIhCWcBmLy2/gICftib7dnQr
 WFRINDEje+jm04KeeSxYGDur2H8F6PFqFodgMevjk2Vzo6C4nGSMfBwN9N86AdKkVkLD
 TV0LMsEw/02GYcaGiB2AeF5s7UvZmzZiTti9lrHm+zQgRDyz0CukrceNxhKriq06sU3Y
 PstA==
X-Gm-Message-State: AOJu0Yzv3qQYVZmPIBXEWG4ONVF5noo55lNWcqPiAwCDf8tHLUksAn8+
 TSN+9lwwlsGefRKtRiCF8gNG0jmr/u6Csp9pFWhjtGM6l2nEoIszHFH5WhXezHahvQ3pdV3s8kc
 Rq0/9pMQ=
X-Gm-Gg: AeBDiesiy0TwrN0Ew84BlzT3YtLNVFK/6j6yHlQNN4xGM/OT9ZTnZLXb7XySVEvAhHq
 vSnlAT9V0zdNA+Kqh1KAbX3g3BfzAe/BszlUvTzJsL8avnM1Erbrjlra1rubwLdVK4DpSDTt8s3
 BE0KN+DqmoVHDrEs4AjiWY+dgUFlswQIKg8S0T1fkdDgWATsF7TGn3LxJnZ6BAjF0I4HMCwGj88
 ikNfGr4JKDJBZ7Al9Q6453kMRycX4JGCgYsT3n0go19PMf7fDL15Z0emUiU7Q0dhnalYYv0cDYr
 2wP0NmTWhBwHL6FPlJiLeVW86rqbSOeysdaBTVslK/ffxJCv7TzHugEB51v9HcG4MHFn/RiN/OA
 OQv0ny/ZfMsWacnWS0MQRPkHOJ0+7H9Ml2nXKj64DB/C0z/W29ySnb4DhkdB0NOSQJa8q0YeIQ5
 8ZwIa+pfFeECpa4hx54WSMffVVvnlzZtUnbr9NNc10
X-Received: by 2002:a17:902:b405:b0:2b0:b7c6:4ae7 with SMTP id
 d9443c01a7336-2b5f9dba8d3mr219433885ad.1.1777211182197; 
 Sun, 26 Apr 2026 06:46:22 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.46.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:46:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 71/84] fpu: Export parts{64,128}_round_to_int
Date: Sun, 26 Apr 2026 23:39:48 +1000
Message-ID: <20260426134002.865628-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 9 +++++++++
 fpu/softfloat-parts.c.inc     | 8 ++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index 5460f5c592..5b71809541 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -187,4 +187,13 @@ FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
 void parts64_round_canonical(FloatParts64 *p, float_status *s,
                              const FloatFmt *fmt);
 
+FloatParts64 parts64_round_to_int(const FloatParts64 *a,
+                                  FloatRoundMode rmode,
+                                  int scale, float_status *s,
+                                  const FloatFmt *fmt);
+FloatParts128 parts128_round_to_int(const FloatParts128 *a,
+                                    FloatRoundMode rmode,
+                                    int scale, float_status *s,
+                                    const FloatFmt *fmt);
+
 #endif
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index cc142ff5a5..87460306f4 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1255,10 +1255,10 @@ static bool partsN(round_to_int_normal)(FloatPartsN *a, FloatRoundMode rmode,
     return true;
 }
 
-static FloatPartsN partsN(round_to_int)(const FloatPartsN *a,
-                                        FloatRoundMode rmode,
-                                        int scale, float_status *s,
-                                        const FloatFmt *fmt)
+FloatPartsN partsN(round_to_int)(const FloatPartsN *a,
+                                 FloatRoundMode rmode,
+                                 int scale, float_status *s,
+                                 const FloatFmt *fmt)
 {
     switch (a->cls) {
     case float_class_qnan:
-- 
2.43.0


