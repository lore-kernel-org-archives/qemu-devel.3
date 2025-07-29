Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C394C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 11:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiz7-0005Lt-0v; Tue, 29 Jul 2025 07:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyV-0004U2-KI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiyN-0006II-NI
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so56898195e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790300; x=1754395100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwDXkIv74V96n3Lc/dGOrgAXOY9PemtQuzZoNiGgaBI=;
 b=SkGyAivLZNX2XdYTjb/wGzPxwGZUpA4sf8l6VNirhm1JUOl3Cr5q5d4FBIIohQLcox
 b6euOQRSRVJiHVfiXZH2pBY4p5Y4lYYCuXvjf9OmHWZcFoCaQOidsbKhzkL386+iUH8l
 pDpx3vw3WTlnDVA1Gdqip7LIyxEZVG/mGgnCA1gNUAd6QCecQ7SlnNpyifSgaPPM3qF1
 gsRG56gucCa4wPK5+XgEWxrNqD9/ylRh8zbt38HqgWmp5o7SELvyfxeutix68F+sBh1f
 hDXkZY7Dah32q2jn8I/Q8hE2M5sEnZtPmzv+rzpAS5Q0ALFF1/auIsDyj0o9CEzYPkpn
 TVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790300; x=1754395100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vwDXkIv74V96n3Lc/dGOrgAXOY9PemtQuzZoNiGgaBI=;
 b=tGYW+IJOlMdxSp3CD5C9zfKH9oAiABPc2gduCjSa7A4s+ILjcmIqXa97M+Dvi0ehkM
 16b3CzaRJ+aX/1c/j63T/ZrTlTCOO/qRhUzKor+/naGrJ5RNNyrdbygbamUxPdICV0W7
 77MwuC4aJIobBIKha+QHCpvAufVeloZ58R0KxatoHR0eSCc/YeVoRVN5pby2Z2RZtv/t
 wP9l6NPfjaYnZZ5HBdlrYLayUa9BJexRIwjbN6wy1w4nHGAmxj31BGhG4d0lC9ai2ivb
 1ga3KhArke4qQrbLXuzAJxKyDpCgrnPxqlOH6DRzcPcNVSPaaxwy9YBLZG5GEeE/+L2+
 Ip/Q==
X-Gm-Message-State: AOJu0Yxm0PTYfmT5wI5cgSzpNFfFzAyE7yPAb2Dso6l34SOy/7yI708D
 dCMXKDPlls5AvzCyU0Me/1VOGQFBlVsS5YnNApz8XJ7CMtYIBzuyfuqAk7Ca+ftO9aF+8cSoW/i
 8E01Q
X-Gm-Gg: ASbGnctuRJXl4D2n64DnqpQlF1pq3rBhRl5hpSP8A2phWa0E6H5FAIlF3CT039Wp70o
 hisQaAxQpvk+EOoBKLeSUKYlv/pN12sgWvMa487SmOGYDz/0GZ0BMZkX/Z7aNTxMQ0p+4OaWS/F
 Qq78BWY8pKmfZnMcxoduqXYbf5f4aDAEhavDa3F3p8mopGXM7v/BsWVWOCUvf/+RSOcxLeqrNtK
 kk8r4IEn/eRXwWYmdYxVudEfqJL758Q7/oTlPIdNhxc8XMr1P2ZpporfLezF+MLfNtggOryzlAI
 FINYEDeWFwzUB15RGHmOOhcE/woSukb9HTmH4tx8hBFfsWnffaUXBuEual8GUG2Dd4Cq+fZzutF
 XGHlbo/lFZFOHWr8G9dpswAnBVmfua2zXRGh5iTkP1gszJ45YY4qah83dimwORp5wqUdTGCKt
X-Google-Smtp-Source: AGHT+IGniukk98M8qeG65Usji04kNtGx4KC85FQxDN8Cytq5sGnqUBZ0pXLyNs7vyuIGXeiJT0O19g==
X-Received: by 2002:a05:600c:1da8:b0:456:1bca:7faf with SMTP id
 5b1f17b1804b1-4587db2afc2mr110017375e9.16.1753790300337; 
 Tue, 29 Jul 2025 04:58:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f338sm189376535e9.13.2025.07.29.04.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org
Subject: [PULL 9/9] hw/display/sm501: fix missing error-report.h
Date: Tue, 29 Jul 2025 13:57:34 +0200
Message-ID: <20250729115735.33619-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Clément Chigot <chigot@adacore.com>

"qemu/error-report.h" was previously implicitly included. This is no
longer the case following 012842c075520dbe1bd96a2fdcf4e218874ba443.

However, the issue predates this change as `error-report.h` should have
been included when the `warn_report` call was introduced.

Fixes: fa140b9562 ("hw/sm501: allow compiling without PIXMAN")
Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250728090518.963573-1-chigot@adacore.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6d2f18684c3..bc091b3c9fb 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/usb/hcd-ohci.h"
-- 
2.49.0


