Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D854EFDEE51
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG1bv-0007zy-EY; Thu, 23 Apr 2026 17:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bu-0007za-6w
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wG1bs-0004wI-Li
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:29:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d572f7437so4718948f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776979759; x=1777584559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sl+WvxuthkRNUPHmU0mekfW7QJT8g1ed3FLAGcfTyYU=;
 b=GwDe9WGzFl1gbtWdlo5+jCQ6BVdKMrfnpPgrs/34UNTaiIjHKAeYu5tW3dA+JCB7ZO
 0o+MGEt/hMeNsgGFTMCX06sVXn0i5ZFpaNerYzu6tlO+1UL1WEKMH8ev6N7SxawVfZGD
 9eZIFJC6+MdS+9m6zoWXIX1VRGJF6m2+kVBxeJF7zvmbuEBev32mirPvyUeM0K2xqIKZ
 iS6I/pU9Jb5S8L3kA5FjAbGWoZ84O38QYvApSRL2+5rf3U42wiB78IsRE+96WGY87Jm5
 MOY7vpwKnuwNiJ2CoToJXkqsndS1SJIC90avHprr/yCPkGmW7ZKyV4BDAxb2lrJMvbK+
 LUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776979759; x=1777584559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Sl+WvxuthkRNUPHmU0mekfW7QJT8g1ed3FLAGcfTyYU=;
 b=MMCi6O1mMi0DQsN7s4aOOUpw2cFsWR+Hc4uqEMU+mfRU15SZOWkmknnVl/JNnN/WMQ
 uGU1mcGVvDFg/SH4qzyifWdRMf28g91mlAjP+Z6RydkwheTn5D4L4GqLu95CqaLSAZcP
 FWD34WvIVXPOu+TJGmUKzoxi6wsc3dhLforczULbmzRufghwu9lrJsNzl7AJ9Z5YWvuD
 9hKg/m/iCoLoWom1/01dB1SKBTAlzlA24DihqAa9Ym35EeTva1lT8LMsx6Cp/EhcyGT/
 Tl8JX/vptb4FU+WEP+76PCu+iOsfPX3H3JtkfW5sHh3mkosmXARrmaLFc9qrjMo1YuJ7
 rUow==
X-Gm-Message-State: AOJu0YxRkCsJ/zrh9RjT98YWEgDI1Qk5GYRhxfPJQoc927XK6NNV2oF6
 I/MP/aeRCtLaoeUTMR+CiCRGs3tFnysIUunCQXmm2diC1/B+N8O9NTmKD1SAM5BQk3D7p3l+vze
 bcqifrnk=
X-Gm-Gg: AeBDies+ZDIu5bXy61OM0BQ5kw1bLSwLuphJH1OD/IAeBdSurmg+3V0sqea/RghSBre
 Nx5AJDoG+ab2Vd/UKG4ms5AwPDL5vSwMhqMzoPOPvyx+LC1oorSQW9MWWH0XSrb00lkQtmxsulJ
 ApOsniq2cHKGCnqGpw52ol8WbYVF5wToJ0U6fj/Q79R/aVJnHyjBCbAjUkK/EdKaqld05pHQLms
 iBR+4aH/TNnjlWWk9eAfCWwzVsh8Yme1dbVc6p/dzRSPAfYQWvw/TxFqzz5MUe9saCfgir9f1N+
 IBlixOw/5ZB7EhyB/WRbEfbkS7fWTFXMJaXmkm6z/Rhezsez4P95fA7c+f1pn6PCWkTE+foVVHl
 QGnfpQpYINoIAMfsP1RLG7kv6QNfHSUVepj9edJ+RK5x/53z9O9k5GO4Nh+0FyD7I+3Rz3Q5jZE
 6r9GKMQ70+5J3/Vu2hNAwZb2+FLaONz71Axpt9HAB5kOZ9T3yVg/PABu7t7HBMSoJy4ADVBjors
 Ln9li0iyBA=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-43fe3ddcc21mr45174934f8f.21.1776979758615; 
 Thu, 23 Apr 2026 14:29:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm63521044f8f.20.2026.04.23.14.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 14:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 51/52] MAINTAINERS: Maintain MIPS Boston
Date: Thu, 23 Apr 2026 23:28:56 +0200
Message-ID: <20260423212856.68734-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423212856.68734-1-philmd@linaro.org>
References: <20260423212856.68734-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Maintain the Boston board as just another MIPS board.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260422080406.62638-4-philmd@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index afc2f0002dd..30c7b4cd306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1486,6 +1486,7 @@ F: include/hw/intc/loongson_liointc.h
 F: tests/functional/mips64el/test_loongson3v.py
 
 Boston
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
-- 
2.53.0


