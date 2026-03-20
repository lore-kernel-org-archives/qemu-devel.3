Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2A41098784
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYX-0002vl-Mw; Fri, 20 Mar 2026 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYT-0002si-4O
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:21 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYQ-00061W-TM
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:20 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6687be9791cso2692661a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011976; x=1774616776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJwDFHhBf+8AgcOpTirKnOmj9rGpr2ot57177Z/8DEE=;
 b=U14H7Ew20jC35+sfVwoAVnGMQgXIdZzQFSitGKMVLRcJDinNR6T1GK1Y2siqgIqPpJ
 /pDn9JEfsKU5Ymf6J2u2a7SOqaIjizwfizjctA77B3s40SXqeL+7hE1MCgqfY9GU2bth
 AYUjJQNOPEuKk0dZBH/ppdv/kRt44bBy9MrvCm+70Dy0kS4BfpO2WgnWoKPDC3IfKOMg
 PwmWQyg3wzU7V5uEGqE5fL8hUWJm/aOhliNPbzOxtjc9+cVv0r162IrlHfxorBpMG/AA
 F8Ia9RvlVd/khrdhnG/poDdizWwHEMIk7ZP/G2eUJZKMjkfxlrNc9/oBnMpdu5yJH6at
 lpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011976; x=1774616776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJwDFHhBf+8AgcOpTirKnOmj9rGpr2ot57177Z/8DEE=;
 b=EhaLagVFOfujAbBAw+bGGrKbtmalsD15oEQwtfnyBUoTV37b5nT29oYeIRDSU/muxN
 TGh2irXRBoz3Mt5X/cErfpbk1i9faUbAjFNKx+6nWOyGfA2Pt8ZOe2CcqTUmhjYAKcDa
 9kN4VlnllH+fZKi/CC7OQvdgVJ/NwAdDuT9pyCprXBQLEmzLwRalNd5fb7VXAy6Fp26T
 sjzy7FUFP7rm/7s1ypbk2FZUf3DIS5mvSd9jWb8qKeJsLNNmJPG+VveYFIhL5bakGPS+
 TwceWTW0W3R+nZUPDnZzR//H1sowbpF1gh7bouHCLNPytgjcOHxVauPtg02utQzS8Nwf
 c6jw==
X-Gm-Message-State: AOJu0YyWKzfLPlhnTBxbeC2f7GqVvFHZLab2oljJaV3YAmVyssRF+f3C
 2FjT/dxH9mV3f3JVCQof/2we9SAnD27RDwEoBXLrrWodhJfKv0ZGGc6jWEUWRzoqgDY=
X-Gm-Gg: ATEYQzwneUeffQsZvp6BgUafSw+ZacGmN21KCCEE1KEPe1O+B+QqTQ5FemOmd4O2k/6
 XSQpUZHPjFdrHWqn26U9UxnmoAKiMHt2e7jHeXOOdro/HUKQcE54oWOYQaAft+j3AUuL14GmYyx
 eo4nYlwPZzjAMO1/7Ba37+IpbufX+odWFsUp7+VtJOmdmuIM8V6sYsuK9DcM2Oi5pRGHeZWGIyK
 +9meYafoYSjWATfqCZWWsN1GXxEvRUs1Gb2A+cx+X8o5lLYpRj96zBawy1BCwyY7eS0Qj+XC7k+
 rKNYM/76FNcD5k3qDBZhvEN8t6zKzOZ1gbKz6qxfiuFgG3OaNsq9Db7cCGvY6UuuMM0ZbB0uyNN
 pE6tR1r8Rtt+YziUM/DUVpxcAJLLHaZAH8NYovdZQZL5MG6OixxzhHv6mwDFqyQvOPwYqsVHHJT
 yoYHwQ1ufJ7kQnG3JQysfUEMc=
X-Received: by 2002:a17:906:2746:b0:b97:f9c9:af61 with SMTP id
 a640c23a62f3a-b982f4e922fmr164777866b.45.1774011976362; 
 Fri, 20 Mar 2026 06:06:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983365f607sm154752166b.50.2026.03.20.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 156AE5F943;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 07/35] target/arm: migrate BTI trap syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:38 +0000
Message-ID: <20260320130607.2071996-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 19c7659fb4f..0520e51a686 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -426,9 +426,18 @@ static inline uint32_t syn_pactrap(void)
     return res;
 }
 
+/*
+ * ISS encoding for an exception from a Branch Target Identification
+ * instruction.
+ */
+FIELD(BTI_ISS, BTYPE, 0, 2)
+
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
+    uint32_t res = syn_set_ec(0, EC_BTITRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+    res = FIELD_DP32(res, BTI_ISS, BTYPE, btype);
+    return res;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.47.3


