Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2EBC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwmo-0008Bv-4R; Wed, 02 Jul 2025 08:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjm-0004e5-Kk
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:58 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjb-0002C7-4w
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:53 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2f3dab2a2a9so919664fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459917; x=1752064717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vaj70g0V1dnaztOcjPq7TosV4lmjqP2yKjF2qWtmvpU=;
 b=S2I1jxpTwEJoNCaKHHUxIiKvBWte8AyWUGci7MxFhwZnsKkTFvIgk3Y4Ngj1UHv8FV
 zHGx0w37pGe9uKe60GuFJ/S8gog/GFWwieb9W378a+eUO3TX6S7uHX7S8bB5kS5T7Y1m
 F6hfOMRam0TonsGnOiqq+l3o4M/82iG0VKKtPIc/lt4M3dY2N+X2Hfco0zssHTChIQ2T
 Qqr1e8xfrKa+tcrSkEDumvWA0xhRu8DUv0/VjPog5h/n1eKMvAcK5bIzvUZbD2qNRYGk
 PWYqWn0TrWzzJik5ML5g+ioq4KgH491YkrpxsV3U/TrEvrk7s3RvUBQ/N3+gUkmzr/Al
 +Ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459917; x=1752064717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vaj70g0V1dnaztOcjPq7TosV4lmjqP2yKjF2qWtmvpU=;
 b=hqQMR5VpkQFMZm4jzssCUpQChggisjxCgqBAGV8DU1bWvjazemBkBEdbSW5iOzRUAi
 hQ+lA7ocYRCDjcLJq/m9q/dU6U2CL65L2hW5auThekRgoS2ApqARABVuFXZnu29ZVVX3
 O2UjjVOrdNXyZhc4V7rwvVlml5lxA1oGxqgX4p2XnAGQkpL7dBVOzBSuWsFwqgXaq0cq
 /6UuMZ1sIdV7lNi8oTmM7AEs+76uTnu89TUBpivoD5wMuHNjrsYF96OfbpOA80w37Tz9
 GK5sbKpd9jNmQpoQyMgbWqzY3rDAHGnBh4QHAjvm4oss/1ozfxGHPHFv8RoT8xywwPo/
 VfFA==
X-Gm-Message-State: AOJu0YwKCzUDiHtiiGJmqF5vEKV33zXpUyz3+F2COzAvzoGygb2cLtix
 fSya4RYK3u9qWVfX9jwwf8hzRGsTvL+LBdjFJBV571+LKzQUFvn/0XQmkz+QoDYl8f2/tdZLRgG
 6sxxOUfA=
X-Gm-Gg: ASbGncsv8I1AdgbiwyOtffi4FGCp9A1Tt3cF3zWuBo0/8N2/ZD8lwqufPn+Hlnt+rlF
 wQiI/EwnNyw218eOR6mBBz/BOKULioYpRTdsfTLLvOveAFr0vhsgWUo7b68QTG2/vK310sSCrMl
 m0A6p2hLjgz6Xz3QZ6pfwyLuaIOZZaRlbYJIpMzr4K3i2rLLSnigKm+JI6xyf9RQZ7EVSpVFUKI
 +ib0FqPTAXjdgCeeSSJOSw9d8j+diudl1CxhXuJBPa8n7mLI+J7ohNgGEv0YdnCbvhy/AXNWQJx
 zsKIQIZRWK1aWdGqxE7Y+FUepMZXgM7sVZGegzT4EskSKo8NjjX20v3RTVYtgXCxSXaFOg==
X-Google-Smtp-Source: AGHT+IEQ75OqS0DpLqj882LV/867N/LJfGrv8Why+zhKwSeEltkscEosa9aHYvjft+pVSN9r0pB4qQ==
X-Received: by 2002:a05:6870:5689:b0:29e:3921:b1ea with SMTP id
 586e51a60fabf-2f5a8b7d9f8mr2035536fac.30.1751459917450; 
 Wed, 02 Jul 2025 05:38:37 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 66/97] target/arm: Enable PSEL for SVE2p1
Date: Wed,  2 Jul 2025 06:33:39 -0600
Message-ID: <20250702123410.761208-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

This instruction is present in both SME(1) and SVE2.1 extensions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 62d3e2efd6..cb60b533e9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7273,7 +7273,7 @@ static bool trans_PSEL(DisasContext *s, arg_psel *a)
     TCGv_i64 tmp, didx, dbit;
     TCGv_ptr ptr;
 
-    if (!dc_isar_feature(aa64_sme, s)) {
+    if (!dc_isar_feature(aa64_sme_or_sve2p1, s)) {
         return false;
     }
     if (!sve_access_check(s)) {
-- 
2.43.0


