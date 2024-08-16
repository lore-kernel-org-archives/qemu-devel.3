Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezaR-0008IY-4n; Fri, 16 Aug 2024 12:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaO-00089F-Rz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaM-0007df-PD
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37196229343so458629f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723824833; x=1724429633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz0afNFWYytxnrxwkdvFof0HvXopb2DbUZl03+TROWI=;
 b=grRigugJfg1IPLuCkhTX2/p/CjKdndFJDbR/dHFikfU9afmb5w+5xQIERGVNvv0yRE
 wbpRgho78lTlUC33jj2nLHnvv4HzkkuqdwUKVwK+0NT5jRyvJX8xRYKGNEYJWMs2u2nj
 +lRRz6tfwfdNjXuhkZ1y7heooKedGjcS3emoEIcaKtZbnbfttUHB7TueSRFQnqk8u2x7
 MXuNZld2zDAycPSPTKFCOAGDUoGHKrXynYDjVLFrFHk12j9t1ZdHHfJKASk0oAhTQgYN
 jWyKsx1fi8jSmi67ZNqT1MRd2aW9GyeYB9ythuu33BerlOzGAlyJn/QbfFruvVn71wtF
 yRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824833; x=1724429633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz0afNFWYytxnrxwkdvFof0HvXopb2DbUZl03+TROWI=;
 b=S+zHXS07hO3a0Fv9DRc7/+YCpNnLoVz0o/9nVCkmLSVIZU/189urnlL8VKza+GrV9k
 MHElkG0g1MPzNChu5izGuWkt6se+FzLeoVNl5cjw+fR0kzLRHOBvrTJgiMyPrrp2r+4h
 7W07xDyCRlNtnnTNl+yKx8njIOB6uAgGJW8LK/CQMekP9ZW7fuwGcIYgVJNQtuD11bGu
 FiLYxY+w03IbNL+DU7cC2QGm1urToDtefImnQAXlAnQT1b3dr6rCrz1UUeo9dtD9allO
 hqZkNtIE6+sD5+UzE1NSo7WugU89MbwTJAYAkLdZ/+5QwcdBfNsO6SJ5fdRTFKpSLtUB
 lvHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb+aN4MAqyec1dq2qtbrDKVeFVdCDWg6+b12Jpb6x64WslngQpfdblJIf5PqaCfjdCIZH0xu3KnFFHMXHNZ1zl1i3Up3E=
X-Gm-Message-State: AOJu0YydqnSIi5lYn5LTwbjqPhtmU6goIcL3rpcBGZvENzWcr+8OWQDM
 zY+TZb8/g9WiWOoviA8f7lgnlhvRUmgA0YZYQ9O+Vv/4rU8Z/6AdgyD1htuR4fumjggI3eWCECf
 1
X-Google-Smtp-Source: AGHT+IGybJM1qk35Xv0nrwh2jSoiuM+xmr+/dMBZ3H1Q8QVkcGdylLKJWt0KG58NlxhVa1HrVUrENg==
X-Received: by 2002:adf:f0c6:0:b0:368:5b0c:7d34 with SMTP id
 ffacd0b85a97d-37194641a3cmr2535447f8f.22.1723824832920; 
 Fri, 16 Aug 2024 09:13:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3912269f8f.115.2024.08.16.09.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 2/4] hw/arm/smmuv3: Update comment documenting "stage" property
Date: Fri, 16 Aug 2024 17:13:48 +0100
Message-Id: <20240816161350.3706332-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816161350.3706332-1-peter.maydell@linaro.org>
References: <20240816161350.3706332-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When we added support for nested (stage 1 + stage 2) translation
to the SMMU in commit 58377c363291d we forgot to update the
comment that documents the valid values of the "stage" property.
Add the new "nested" value to it.

Fixes: 58377c363291d ("hw/arm/smmuv3: Support and advertise nesting")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 39719763897..4c49b5a885f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1981,6 +1981,7 @@ static Property smmuv3_properties[] = {
      * Stages of translation advertised.
      * "1": Stage 1
      * "2": Stage 2
+     * "nested": Both stage 1 and stage 2
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
-- 
2.34.1


