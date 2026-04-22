Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283FFF9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUXq-0006sx-Eq; Wed, 22 Apr 2026 06:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXl-0006pP-7b
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXi-0000iu-Vc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso30006805e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852649; x=1777457449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
 b=nWQjJM1mTuQcRujdZTNx04U3WFqDDU7rwx+eyXVCIOZIZrqLFZW++o2MV0ZJNZRfU2
 50uPZzlddAWcq0FphHFFBuE3RlFla7E/LOSRzolnSnbEDbliB3Pjf7YLMm7bggq7vbyR
 mB3sk3bqGx7zBhq/oNsVnPmfuaqJicwNxk9WqeRYoGRnsdn+MYtUypnOw4JDKEFgK7wL
 KkluszeDsqaSBIiFJEIvu6pSmNNWlBMhM4oMRFlNF13UxIAP4gDe+uMwMf/2KomSqiuh
 8INrqs5UimOj9HpJe2486ZvvRdUu2yiDwoJR2M9w/rRwUHvaM/i+BchapwIhyyYrPB6g
 jc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852649; x=1777457449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/O57BXYHK8ET+Z6BA/YHEqhtOr337eupd637bkTh7l0=;
 b=KRQIscjGlrAsl4bQdFeDkcFzlvIzF4W8L7KbyJI3r3LUfTtoUyoFOnyiQ55AcjqsV+
 oLwGgpachBDZlMWHW2avGmxd4BqO8jKGTwqQWqbI9uiZVayTYswS3FyGPRpgIeWM64ff
 koldWSsQoRLHBluTSjx7XH6pqzU2aePttJ7PA0YNjdKy9KyXF38v38ebROjOaLgyXXhl
 OTMakoO6cku1lAbWeV8PTUg/fXeO6bDfYPBpFH3cZodN932TiLs0ml11TUw3R9g6i/Gh
 Bywsic1L3e/F+NNtFkjhzmK/0t5ET7CA27uZ8c3z4TfhLm28FfayAIayNc0M9Sa1KeL8
 8m5A==
X-Gm-Message-State: AOJu0Yw7wchkaqgi5Q5/XFqmmKQ5eOOhRBpjYMiTtLzhXDVaiJxCXc5m
 TrhruvqTBik4jyQD+HXRwFIf8UarKhM1dn3xN/jxaUEDlNoytKysRi+OpbSKiSJAXww=
X-Gm-Gg: AeBDiesBFhCcINP0mrY48xcCUN3f6hf2hTAZLwQiSGiujESM4lAx5KSj7RIreYiTz/D
 YHWsChVy6wBNa16BNjU/col0ELadDqGfM51zj1AyB44vYMbQvX3qzttX6OWXcjJZYf6bX5vs3tP
 snBLZ+IYMg4xyIfuTh5/bnWhThRdWRkasGYUdr65Q8ka2VvX1C0rTVLiQgSynSsNSc6eUDTUhu9
 ZUbY4GfEOHl3Iiyi9+0ECjNyutkfm5k0nFQz4RvfKfsW7iAZuaE4ygAxYqHtvoEwI6sSirNzSNn
 QrnnbC6XsYOn7y4YeX92RseWfdcyiT+ATh2mjb+Edm+bZKjaVDBOv/zO5mZyuTh4GS0MeR4axMs
 uGDhVpBwEE3Luj+x90e2haYZIayXeaCBxwelHgb7DBx/sszx9u1RluTqGEMTX3J8pwbD/8PVZ95
 U1m5auhpLb9vVurubB/LlBx3nYeLfFmF7p4Q==
X-Received: by 2002:a05:600c:6289:b0:488:f941:aab2 with SMTP id
 5b1f17b1804b1-488fb78a561mr299841095e9.30.1776852649323; 
 Wed, 22 Apr 2026 03:10:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm410399245e9.9.2026.04.22.03.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E2F5F60469;
 Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 06/31] target/arm: migrate PAC trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 11:10:17 +0100
Message-ID: <20260422101043.1234229-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

syn_pactrap is fairly simple as the ISS is all RES0.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 61053475984..fd8639d4f07 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -398,15 +398,32 @@ static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
     return res;
 }
 
+/*
+ * ISS encoding for a PAC Fail exceptions
+ */
+FIELD(PACFAIL_ISS, BnA, 0, 1) /* B key or A key */
+FIELD(PACFAIL_ISS, DnI, 1, 1) /* Data or Instruction */
+
 static inline uint32_t syn_pacfail(bool data, int keynumber)
 {
-    int error_code = (data << 1) | keynumber;
-    return (EC_PACFAIL << ARM_EL_EC_SHIFT) | ARM_EL_IL | error_code;
+    uint32_t res = syn_set_ec(0, EC_PACFAIL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, PACFAIL_ISS, DnI, data);
+    res = FIELD_DP32(res, PACFAIL_ISS, BnA, keynumber);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a trapped Pointer
+ * Authentication instruction is RES0
+ */
 static inline uint32_t syn_pactrap(void)
 {
-    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
+    uint32_t res = syn_set_ec(0, EC_PACTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    return res;
 }
 
 static inline uint32_t syn_btitrap(int btype)
-- 
2.47.3


