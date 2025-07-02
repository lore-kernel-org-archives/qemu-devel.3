Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA44FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwmJ-0007qq-Q1; Wed, 02 Jul 2025 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjF-0004HD-8f
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:28 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwj7-00023P-7l
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:20 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3839685fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459892; x=1752064692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUMOQ8Bv1dniLD18oQYen4kIEUad0i0u4S8cG6PKGo0=;
 b=jGBgyTq3nNS0xKMrlNViR0CKfTiX+zXLY5z+HPzO2OeybozWENceO5KOCpTRxkyeW6
 kL8R+myIJvm2LQIfQaIFqu/RkYKqz0sr4dZAlmxRbz/fVPDK5fnOSXSLEydmd4pTL9Tt
 CsvAGLuZk5Q12y3A5DKLxco7UDSeVlMwsuBBiSStcGOWcT1hcb9yWZOGMvkIE1jhGEyS
 jLIWveS5yRsAzto1i17859UDrKPm3QiAgn+DMM64amwfGpV7Pn/xfSnR1keMTlSlWdIa
 6uWOa4+tkgShlrJWXDiQarfS+H1QOctuoROzd2t8vh1l8oxb+1YBM5m7WGOL0vHF8+kF
 VIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459892; x=1752064692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUMOQ8Bv1dniLD18oQYen4kIEUad0i0u4S8cG6PKGo0=;
 b=F8vUeRscDqtfDLZ94R7c6CDu7ZFcd0ImzGk4q9CilTczTbF6lwJNwmr5oqsE9llWgU
 azfc0gkw8RWJ/gG71RbYNuNnUF+EluE9IEzaHrVyYLqNnsTpi7DrTz2pYYR7MGWOglvn
 vfRSvauPJAnPPiP6xOO9u1AP4ePlZK1hE4ewhbjGqHYUic8DvoseZo2XldwiepoZPn+9
 SovjUoo5WfpnoDZeHwVBIY2AAi5OTc+vtx5eNhnUTov6Po551O89QA3rQaIWtV5OIXQK
 /m/f6iDYYg4sm0Neip+wLP2QUcMR7tZhq2PT9UDiGpXq93s2bAY8S7umVqigndpLLVkG
 j2+Q==
X-Gm-Message-State: AOJu0Yx0rJqB7ZRHoyloTjbwHgJ1EkXnPc5ZMY1iqw31itS58MH046Be
 saxWWwfWXPo/f5lR1jPw0xlG8bOFUajWMFMtRLKiDuP3pwmQW3SBA8ebScJhoOmNSh4AUA/okO8
 NkkVnBv4=
X-Gm-Gg: ASbGncvVKQUo/WOVGP6aJRJA/V3+QyiumjXW/TtY3Sw9bBl7wDjyGby6/hx0deE+5tl
 DTf+IBxK4n2xFiVZzWryXOh4o+WQxhNNFKDN/H/VyBe80VYbIfk2C+rMD8JXWr1XyyteWcEBnkb
 FaFwMvpOvBpmwdaOYmPPkcbkkddNvUKFwJIz5qNZUyXgN8LuaBJimZpFwn/g9V1Fky4HygisPMU
 gHsvI6sO/cNUAB91xzU/c0jjnfu0b8N6amOYP1VNuMYelvMBQZ/hAmu7Ohd/g+0EyOgk7EhTLRM
 aS+51WacI3OuIwXhnDaxd9fbYn5lFwlwGhOgmE6rrrPjr2xxeDYi10ma55cUi9iGYxksdPT07yI
 Vl4ub
X-Google-Smtp-Source: AGHT+IEEdB28attT6mW4XX3rd88R188JJBBeAs1FxYg9791bGjXLbBxCtVAceSeZjbCz/JBB2Ua5pA==
X-Received: by 2002:a05:6871:688:b0:2d5:25b6:ec14 with SMTP id
 586e51a60fabf-2f5a8cb5316mr1850263fac.15.1751459891707; 
 Wed, 02 Jul 2025 05:38:11 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 47/97] target/arm: Introduce do_[us]sat_[bhs] macros
Date: Wed,  2 Jul 2025 06:33:20 -0600
Message-ID: <20250702123410.761208-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Inputs are a wider type of indeterminate sign.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index bbf76f63b1..a1c10c60a1 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -223,6 +223,13 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
+#define do_ssat_b(val)  MIN(MAX(val, INT8_MIN), INT8_MAX)
+#define do_ssat_h(val)  MIN(MAX(val, INT16_MIN), INT16_MAX)
+#define do_ssat_s(val)  MIN(MAX(val, INT32_MIN), INT32_MAX)
+#define do_usat_b(val)  MIN(MAX(val, 0), UINT8_MAX)
+#define do_usat_h(val)  MIN(MAX(val, 0), UINT16_MAX)
+#define do_usat_s(val)  MIN(MAX(val, 0), UINT32_MAX)
+
 /**
  * bfdotadd:
  * @sum: addend
-- 
2.43.0


