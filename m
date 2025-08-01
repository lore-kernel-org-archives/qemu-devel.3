Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512E7C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 23:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhzAE-0000Qg-Qg; Fri, 01 Aug 2025 19:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8t-0007RC-RU
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhz8q-0005w4-85
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 19:26:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31eb75f4ce1so2338438a91.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754090783; x=1754695583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hBawASsHdbL6GWaVoVOq2WpP17YA49FN5IqJZ8zqPk=;
 b=ALNwvHgXgVyMarFOyz5LcPX4g35VGBSb017xebRer0Fm5oQi4WqmxGGMFilAaawzcj
 mYd0vj76LZv1SPIMRN28L1p5cxiIdiuvn5fAza/s2XD399UicZZ7hI22Tv7FXIGHweHa
 gJaGI+AAu9PA6kH7Mm3s02RBG76L5DMlsp/4YNVuWtgrzR5yn1gJU1ikBIxeLpl6xKb7
 n33av4mbIl25vyo+TLArFAklIHrpzA5N78tHwP9ruSYaQveWLXd2HU29OLIWPG5Bzf3N
 NmZJIOnhqbJ4idM4Tl/sOXrIdILAOefTIbxzu9g/dmJC+EQdxen+7uGYyytWTNIsxexu
 NkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754090783; x=1754695583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hBawASsHdbL6GWaVoVOq2WpP17YA49FN5IqJZ8zqPk=;
 b=XfP75PQ9bgM2Di3mbz/nfi9VFxbsMPXWC8CBCvczAJvx+0HiWZrET/w9HdRu75sn2K
 aO/eSvM83m/yPJe/rZ5UEbdHuTESDYRAG2f0gWhve3L6Jalxywu9mKJ3hxxx1qrSG6Gg
 uNfIJujEIoJLCIjX5K8S9mW47bn6oYBwJ4aUE0jmvZUsbtcfsPxOv61C4GYroxFQj7Qr
 X5jFhl+bprJ2sB2a/S83sMY4+jV4tDUjU6pYM7ZrFrXSRzSikj1S3BYHBmjTdtv1OONi
 b6LPYJEy+e5rqldY8rYBQOn7YUej4j63DHT1ifa1QS/Kq+s1cYKXQZ+T7Io6QBlVZci1
 hxaA==
X-Gm-Message-State: AOJu0YzrK1IAtdoYGhWxTYZWWe/7jbP8IYRzkjuhxHI04ook8UnRtKav
 ETClsDo98nDr6M0lgWx/n2O0gGCcI+dI0jUT+QA+5qnovCvIh+2T3eJWwdjj4XBEPxOrqzCe8P8
 037g4R+o=
X-Gm-Gg: ASbGnctpNVAnlp4AR/YrUTg2RkEdCs18ww2K78fffdPRiy7FfmrgV+xaqvJV5hoKN8D
 I0IxUGrU9jWGw5VGNZHTcmfJ3u3nh/v6Ec05Wd67gvBxvgCTlq1oGKdH2nNk5Fh1KV3QdRFUenF
 I11NCPZSsw6oMfysvt0u+Z/zckiNo/0ySwbr113cX2E6i9hUHDorJAy0ncUKbruwSTbDy+mYz0I
 aTtFlAAbM6tsIU3HeJBcf1p4lLctpI4o1tqzrudWCCh6nxuEgwi/u7Rhg0m5luLYWcckhDlyirH
 4Sb6E9hbAlJF/z681XDRVSMXZjIPf2eBtErI9X2XvUtzyl37Gkr15r94NAt1TUNTSKobOxfUUwv
 yvfYM6uiMcCaWhfquTA8Mhw==
X-Google-Smtp-Source: AGHT+IErVAIYG+ZivK0tp9L4ZO2CAyYDXyBRtGWk5IQIXLDMyxQxQ99iYzY3K+k1a49xo9eHNhCr6A==
X-Received: by 2002:a17:90b:2d08:b0:31f:28ae:8709 with SMTP id
 98e67ed59e1d1-321161ff633mr2008864a91.8.1754090782807; 
 Fri, 01 Aug 2025 16:26:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6d3asm5628217a91.23.2025.08.01.16.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 16:26:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 07/11] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
Date: Fri,  1 Aug 2025 16:26:05 -0700
Message-ID: <20250801232609.2744557-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
References: <20250801232609.2744557-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

No semantic change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index e44e910696b..b56d882aa52 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -787,7 +787,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (sizeof(target_ulong) == 8) {
+        if (is_64bit_semihosting(env)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
-- 
2.47.2


