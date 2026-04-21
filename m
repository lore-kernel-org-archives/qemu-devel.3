Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59126F55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3S0-0008Kd-NX; Tue, 21 Apr 2026 01:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RB-0007xV-0U
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3R4-0006MA-7N
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso23519805ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748449; x=1777353249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfNScWpB7q780oJkpTFR+sWvykva2u51oGRZh7kaCOI=;
 b=FgmYs3HEW5cP3ayJXgJx5SzQOk4qYhWFagEab2sLGBrtOSqlLunL75WnjVRYbGB9Xh
 tWYYP/6USXaEjKCh9W5gy3QvgP5BCJNRwoNZDzPDima1giXfzQl7b4pn9RCNZ2orVZeP
 Ye8IEpC7wrGAKeGYDA0GNLqotVGMNzxUrQGXrrlLhF+gJebZUZsAKdEqcHEml7+Eloup
 97tolVXmFxDVlKGqXQdNEbHKLKPasb+IAv0QZd5ogUuhTqKJdvd6WIl3hBTLODh9/CJA
 uu4OkEit+Sba66wHHu3Xxk06gKOeogcTw5JqUDIYkHscyPIBeQHYwNSBZqv1U+Qeijpl
 hBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748449; x=1777353249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfNScWpB7q780oJkpTFR+sWvykva2u51oGRZh7kaCOI=;
 b=Zn1xl+zfGdWKvPNtVmbqr/V5hlhQEvZaXTjniOPIkPp+iBcHkDBnsVrtXGHO6Utvf7
 hjFmW4gFfpYfxNNGimyQM7fNM7VxOJJEytsxekPy8A5f+FLPgpFtRXkxZHcVuL8WFXXj
 zTO7xUm47Yk/hNlAj9LfkVPCjravqg632IYIzY7i8bhm4zbG/1BdKFxQhJvG1Lb3nZXN
 jYP/KzzfywC6OQVuX6OJn+idSjxw7Wg64CRfmxe3EVW5FNgdC5QT7AkzAOWyFUJ2tLa5
 j5l43MGctoG3ng8noab6dTxGse8eNrNYNyHlN9wvbvCy7PyqVW+H5ZZx/JTg3dgJMoqy
 5FfQ==
X-Gm-Message-State: AOJu0YzjE+G298Dwe3GBNOK+ubNWSmrE6Yufjwg1m8ev/GF2D1YZt3HC
 VG7aJwTVyW8gMaZCzSqMjD6VcpSpYsgmvpDJK46NvEbOUJJ0xKqAKrLBB/CzWNxbDPDXekMnRJM
 ef8GcRt4=
X-Gm-Gg: AeBDieuwLBNoVAfMJw4T9kJQOGbrGu7EL4xUwC0LEdTUqvreEzookXF1Dfrl3UyF9RD
 Tv7oRhyWF0MPknOIVrv4+N5IEg7852OwLqaWjhV4PfBXdudr664JfC9t6F7p/b4JeASfAe7rrIK
 y7BpfOqYdh8jmDd96WgBB+UwqfxMCeaeQcGvo3XpcJVczMEKOw3gFL6UMTYN3LYQbXZqdzuG/PZ
 Q/xQozi3SpC3vTSRjpCky/OzkqiaY0OAIN1dcFypdV2KzqN2INX/HyugE0XNPyITHn2qvcIyfmV
 JflkyRzTO1HUFBZko1VulUHnHZgPOloVqsKJUeUjua7c2ajvJzTVYZEG5VKeVFf0ufz55bicMml
 BdFatie0Xt+Zh+3yJkQ+0VxsirCrOo5HnMh2fpU4PCBrNj4iUT63fIpJgmmc7BE80DUJX+/CO3l
 0hSMhJuI7uGTXgXGcDMrKYb/LMBL3j11S998HuNTZ5
X-Received: by 2002:a17:903:b8f:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b5f9fb9d4cmr164504445ad.30.1776748448752; 
 Mon, 20 Apr 2026 22:14:08 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 07/37] target/arm: Update HCRX bits for Arm ARM M.a.a
Date: Tue, 21 Apr 2026 15:13:16 +1000
Message-ID: <20260421051346.41106-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 85980f0e69..b0f6bfa62c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -252,7 +252,9 @@ FIELD(VSTCR, SA, 30, 1)
 #define HCRX_TCR2EN   (1ULL << 14)
 #define HCRX_SCTLR2EN (1ULL << 15)
 #define HCRX_GCSEN    (1ULL << 22)
-
+#define HCRX_ENFPM    (1ULL << 23)
+#define HCRX_PACMEN   (1ULL << 24)
+#define HCRX_SRMASKEN (1ULL << 26)
 #define HPFAR_NS      (1ULL << 63)
 
 #define HSTR_TTEE (1 << 16)
-- 
2.43.0


