Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D169C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyp-0005Uf-BV; Fri, 03 May 2024 11:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uye-0004dP-Vk
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:38 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyc-0002oZ-I4
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:36 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a597c192246so167224466b.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750652; x=1715355452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpo/S5Ob+DXg1pnPA7+b6elSHA1T4ch7nUT4NXQUXUE=;
 b=rAQ6Bt+iD2RvsbVqeBUYkPMU38vW4EThxoXylUVDedaxWbIBzh8/Chhyl4s1MrLN9s
 /76jimm6PjNqnCe+UIqltlAeU7C/F0mcXz44euT6crs7hEuZKmQV2yVjT3xlZ4g0ThQc
 Mtiyt1JodJoxjxzBLpjzMCDs0WyUFGaqHhy0nhbM8ZSm9amHPPGELY3f2+3Lt2KRd7dW
 z1ypMhGyL+HXRrD3KutA2gWmp4w/WixdwIgc+aOhQnfXsmW5t60+usGUP4Fy+X4Ip1pA
 SG3Fi/7cK4Evsv3EP9LNdwVQPLso29NQMexqx+GAjcs99TEpXYyO53UO0soOg+G8FhvP
 xMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750652; x=1715355452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kpo/S5Ob+DXg1pnPA7+b6elSHA1T4ch7nUT4NXQUXUE=;
 b=kpmCtrLAzWjdXFQxhjZ+ps4EWH+i8aVJiIseqAG2fl5IjBpULwltg55bOoyZQh2EKi
 h9sTVlTA01Uz8VulMKeO5djdJJCQ44RZNLV2wqel5EbHxTfteo5ClnWT7bT4F05ux17R
 f/gESKfiFzZhPpPVYA3jMLno2miCCTbI+SmYNHg4QcKRaLFo07dWYN+yS82GfZRFYqqA
 q1oOtDEHISb+MZz+xwfLGnZHJEBvygHV1bIOgaSC5+vVxqxz+A0WYybebx4sTJscNU92
 MaOEhs2TAzPcP9XFqG600eRGaivZItE3Otej8EZmvDXG+9FqhUO9uOAhe+VuEXpBgInL
 B/ZA==
X-Gm-Message-State: AOJu0YyHwhfbvnopeQh/cEI3GhOecUL2ggU+T6kD2Zb5Tp7gCpVY+U9F
 HSCkZnSrpzvX+dM+4qMgKEvHhCEvHpMGQ0TT9pRF3zCZ69XlIOgdmFT0P1xZsfOXHT44U5dMXcu
 G
X-Google-Smtp-Source: AGHT+IEdOrQfPYrGmnpPhox0c2f/cfc4oVvMA+UytGeKLHbj/BYto03kl6zHbh+tVXBuk0hTV5eFHQ==
X-Received: by 2002:a50:f613:0:b0:572:689f:6380 with SMTP id
 c19-20020a50f613000000b00572689f6380mr2418621edn.3.1714750652674; 
 Fri, 03 May 2024 08:37:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a056402320b00b0057203242f31sm1806814eda.11.2024.05.03.08.37.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/14] ui/cocoa.m: Drop old macOS-10.12-and-earlier compat
 ifdefs
Date: Fri,  3 May 2024 17:36:13 +0200
Message-ID: <20240503153613.38709-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We only support the most recent two versions of macOS (currently
macOS 13 Ventura and macOS 14 Sonoma), and our ui/cocoa.m code
already assumes at least macOS 12 Monterey or better, because it uses
NSScreen safeAreaInsets, which is 12.0-or-newer.

Remove the ifdefs that were providing backwards compatibility for
building on 10.12 and earlier versions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240502142904.62644-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 25e0db9dd0..981615a8b9 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -50,23 +50,10 @@
 #include <Carbon/Carbon.h>
 #include "hw/core/cpu.h"
 
-#ifndef MAC_OS_X_VERSION_10_13
-#define MAC_OS_X_VERSION_10_13 101300
-#endif
-
 #ifndef MAC_OS_VERSION_14_0
 #define MAC_OS_VERSION_14_0 140000
 #endif
 
-/* 10.14 deprecates NSOnState and NSOffState in favor of
- * NSControlStateValueOn/Off, which were introduced in 10.13.
- * Define for older versions
- */
-#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_13
-#define NSControlStateValueOn NSOnState
-#define NSControlStateValueOff NSOffState
-#endif
-
 //#define DEBUG
 
 #ifdef DEBUG
-- 
2.41.0


