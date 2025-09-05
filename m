Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3763CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUz1-0001c1-80; Fri, 05 Sep 2025 07:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyr-0001XA-Bm
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyg-0003Yg-0d
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so13672705e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073093; x=1757677893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIej8KJ0qwZtdzS8NUwMCivvv646uavNq2u0pssJkXg=;
 b=nxeBQeOexKgxmcc8dIgfTRjImKfi2Pu4CYlAXqAuinU+xeSTpwlyRi1tApKq/iMGvO
 bleuEoCOiWEmX9tNZl+G9ukow+BnXiphiG8zGJlHju9EYyvkHZRu7PdjO4Ynkz8mbtCM
 vLZ/rwPKpqOQm/XATJhNup8CsI88Q4DEpclVo5VyibdOiBwB//uZfyB/C8tqWWqu8eR5
 0GQbjPrdYQQQ9Aja63TLtOB3LOdd9Mf8bCr1m0Fe4mGD24FICZXdhDu4A1+1Rh69kl71
 PxsYka1OaCAURjiTeKuvpSwZHMavKpknFjV/QUP9Lonu7+hjUOqme+hJOZREzD8iXK+W
 ruyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073093; x=1757677893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIej8KJ0qwZtdzS8NUwMCivvv646uavNq2u0pssJkXg=;
 b=kPlyZWFfUH+6bYuaZneJFQ/z1zFNP1Si2bskb6t7rwFxrjhpSm+5O/OUbSdd0Hr7mv
 OKhYkw3hgHzYUd5F3sXTiXfbzvDju/D7bVCPoxYpOCvYpVUKT1IgBlbEFOgErRZen2FS
 F/Z8uNqIQESm+Bbv3OIxsOR3Yb9kdcSuJmsXESS5FvuDdvVPOWGeZ7bmrjJz1hjmRMyF
 ucIc18LbO4yaxOTCWc7IycVHFxT9G0BvugqROe8NR60JugClsqSdQoHgCP1/flf/Tuzx
 hc0HE4L3YhxrajWjWPIJWHu76HontBjBupOOeAP4Ttdq7B454JyUaidd6LB1YS2e9pE3
 qQQg==
X-Gm-Message-State: AOJu0Yxwe2MHNiDfveWe5q68HpLcH7Orzm1sbe+mVrEMr/gvun+6PPh4
 1zK9TiZeu3tyk7TNnWIZpLXuv76viydF5VTX2hKTAS4Hb7sGHbPK1+mKD7y/rPKe+lPRYLR+ZuC
 K6PefuxM=
X-Gm-Gg: ASbGncsyzckWdUxnvJDLkEBagr25uN3SQbNXmkTJx9mZway4dPSGHq585+JhKkxvNdW
 3Qs2s1ToJox6XfCoO1/ltMsP4+6Z/IT54tbZJ35efKWYlev0maJcM5XWfz8TE1XxSnN9AET5DLj
 UJSg6/h+RMpMokEuXyBAFxhwFdjPbKzZh4yAtcNKJ1ULZKj9giDktoL/wEaPwR/PX16OAmgxJXq
 eG1lauj3AROVNeERUA6EkaLpuT/8Qds+0X3MGsEtn4dGRHst4ALb0qfK+Wan20sKTwrESd8Y1UJ
 cYAs+mdUPw0vCL5MMzxkz/LNokreMO4wEXpeUfA+Xa6ygYoGdLe/UH5zPCt9RqfFT7ed2Slp8Kd
 dK4C8rtGYMNPP8HYldtEV36nCSsuUFVsWV4aCaj8R5k1lpeaXzm66KoGf
X-Google-Smtp-Source: AGHT+IFslXC4H90qzOvyr2CEJPIRysjktd5kGzk7jTBOxYlRFWjPpmU1si5QVhLOftaoP2L/MlytPg==
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id
 5b1f17b1804b1-45b855983cfmr168873545e9.27.1757073093264; 
 Fri, 05 Sep 2025 04:51:33 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 4/7] target/sparc: Loosen decode of RDPSR for v7
Date: Fri,  5 Sep 2025 13:51:25 +0200
Message-ID: <20250905115128.376295-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: 668bb9b755e ("target/sparc: Move RDPSR, RDHPR to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 74848996ae..1c6403ad8a 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -158,14 +158,16 @@ CALL    01 i:s30
 }
 
 {
-  RDPSR             10 rd:5  101001 00000 0 0000000000000
-  RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
+  [
+    RDHPR_hpstate       10 rd:5  101001 00000 0 0000000000000
+    RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
+    RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
+    RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
+    RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
+    RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
+  ]
+  RDPSR                 10 rd:5  101001 ----- - -------------
 }
-RDHPR_htstate       10 rd:5  101001 00001 0 0000000000000
-RDHPR_hintp         10 rd:5  101001 00011 0 0000000000000
-RDHPR_htba          10 rd:5  101001 00101 0 0000000000000
-RDHPR_hver          10 rd:5  101001 00110 0 0000000000000
-RDHPR_hstick_cmpr   10 rd:5  101001 11111 0 0000000000000
 
 {
   WRPSR             10 00000 110001 ..... . .............  @n_r_ri
-- 
2.43.0


