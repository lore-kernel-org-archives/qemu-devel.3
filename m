Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176F5C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7J-0008Nv-Mb; Sat, 12 Sep 2026 22:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7B-0008NP-5g
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:46 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a79-0000wX-KY
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:44 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so735031a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267122; x=1789871922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BFdwlpBUb/ld5iaXCqigYzlB5i82jNLi2haiV8Iolgw=;
 b=eU1RafTOSiVZqkF08AsIh6F1oJRaiHWSE/lIIPuy6tgh9G6UKo0o7Y/YMf17wxae+m
 UQgutZ4SM9vYsqiqGa5Ep+dKgMuyb/xMjkJuHkvy+EW+yJgqf3CUz0WgEldNiL2mQhCw
 p+DDKLwoznH9lGR02l0htKWhJFEO8cDZ2BpCHsxkhjaIgKx6FItH6R2rqg+IrcEiqQoC
 H1kXRncNuxY7GNodON8/jP+x7ppJwaOAMxv4EI45bDaPjFJ7bt/1g7JZRkqR3fryTnlz
 qoMHBTsIhnzOCzgMLq8+v7BvzsDD6DhPxBuqRTcwjFy/HYvqXS72K3njrqFOz8YLQPtB
 b8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267122; x=1789871922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BFdwlpBUb/ld5iaXCqigYzlB5i82jNLi2haiV8Iolgw=;
 b=tSWkmJzxeNU6eIuNAxXfL9m3g1ia4P4JpH+K3Q5A+76/tQ0T27eTGms9X/+vQ7FPz4
 50zfFe9I6NOmaEDr9LXNh7ZVSuOcbzdap25CMWgrVh9QYBWcLIudrNU/jkganH7w5Trv
 z9rQHA8xDDE5PZUKTJyFKlMkEvujFTg7+3xiaKbgfObmvsKquvqJPrciEuvBmgJpFAN9
 ZFy1Ergb0rl/6n8diJPup2TN3zDNvz3aM+0Q24AUYU4V0q7obk+3qFr9odKm3F5GqBk8
 emXu/MQIBhjmD9Iolwrvn6wepCvXWaPBRIH5csg+96S69+Kysl1BypqGn4PX7Kv3r1BI
 jf5A==
X-Gm-Message-State: AFuF++nRd21F/yrIppGzrvMTWeLUTttGsO9CKRLLg+BtjRUa0Yb3ebzY
 5eM0ZQ5B6s7h2vb3w2clHDkgXO3LXnzNLt4F59mfaRQDgNHQ3v0HbKYOdlfhWt/RhuUD3IwSvmB
 N6lmZUi8=
X-Gm-Gg: AYBFou0Zn65xAVlUK9nv6qTfKfT3gNLjpQjmPNuJsTPoBhUhisLykL9wumkWkwkApzy
 LQrrRavicn5+I3z0coa2F0V8eJbWIiGB5BDbC5SxBLDQ00Ay9wIX0Q4h6FzRMvudC7aDTYugiv9
 Ne5pG3DB9YqC5lDbPIThYCyKXb+42xlSIMG0/+i9AnUNIV8EwWbP1ip5e6ezGhSTuw8o4Piid9g
 iWlEZgNHBWN3knEsMCtEetJBpSzWEQPwu0wWAMVWbOiu2AoSEVsuAIXxjwQxutVesZphp++zse3
 3nSVjyEJ8imXIEvY9WkkUVi+J4nx5wji52LQXkVyFfpI1IRAiGn/oZP3uxQiv5UdRGdF6S5KEv7
 R98ZYCHl2yaiJ90OJenFZx25pSF9vuZRRH+R+G/LElR0xNJoHqexts7vNSeCspLbQcrboRBbqeV
 43XFMxlhVM7Dy0Zrs8RIFQr3SKSVGR22JBo+Ja1iuZ5Rs11700AYkJ2eD0MKEkrtgURLepeN6wM
 5nO1Fo=
X-Received: by 2002:a17:90a:10d6:b0:39d:cbb1:c96f with SMTP id
 98e67ed59e1d1-39dcbb1cadbmr3391253a91.18.1789267121930; 
 Sat, 12 Sep 2026 19:38:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/86] include/qemu: Define QEMU_ALIAS
Date: Sat, 12 Sep 2026 16:37:12 -1000
Message-ID: <20260913023837.741866-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 4c49f52eb07..614a0bfd295 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -222,6 +222,13 @@
 # define QEMU_UNINITIALIZED
 #endif
 
+/*
+ * Alias the current function definition to another.
+ */
+
+#define QEMU_ALIAS(N) \
+    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.53.0


