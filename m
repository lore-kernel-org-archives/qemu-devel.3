Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F52CC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 16:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVgD-0001oE-6I; Fri, 21 Feb 2025 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlVgB-0001mt-O3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:15:07 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tlVg9-0007EQ-NE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 11:15:07 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so278360166b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740154502; x=1740759302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AGFiFHnJkakYmzYx4CwkPAU1wVf8B/kVib84R8bcTN0=;
 b=K7DiuYKKvlPrWEb5JUvy2GWyTHM2q7g6qAa3XYsh8XtcMZQxXRcfS/hgSWC8m1IUar
 tFIzv1k8Lv3fETRmTWxvj56fnsHz/QbH4pfi7njvcmhwebzM9N12iN1GZvzIy78KO5Ru
 +emmq6Qzlte6UUFD214e71nPskNd435nvZpZ8NbeWRffjLfUIzc2RhaweT2wa3osXAvc
 EUzdF4Wic1g5mDUoF8b7sE/9JxikiUGwzs+81VvCPc0JFwe9a7wwAi7PCOdDvktiJmbM
 Upxpafb1eqRibhisXRoXBwzB4beeisqOGMJbDUJE+iOdFwx31LGiL21Gy/20PhRQutnK
 vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740154502; x=1740759302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AGFiFHnJkakYmzYx4CwkPAU1wVf8B/kVib84R8bcTN0=;
 b=FPTvU0ZeOSxhg9hnnpq7wE01j5gqiDqwBdmvAlW7uuXIZI7IwZLuqjtpd7JZRTcdoE
 ILWfw0n9T+7CilOSKIrPmbZXqOf22a4UGXU79hNGhOf9XZ0t12WS3ibCWhJGW8VoXAsh
 wtqc2x861qdfpLN7e3kE6WXb2YNbewgHyuBCCYTMK7yfq22aPWFpPYKHUtRdCm1u15b/
 Vz7TUbhusBTueTqoJdC6KS1g1rTs9vualRpLvDjR+cNEtBJzQfUh4xMgEk8V5lhlmK9o
 MHQsxb2rLTtI9q9PWoqBde2zL/GA0LKD84MSmmwQgmlBQzQ4rQe38KjHk/F6AIlCIZDd
 0bRg==
X-Gm-Message-State: AOJu0YwWz+Z1XqrPRZPFU2vgQdX1/rjfll419c/NYt23Iqdbt1rJSrmy
 hMgQjadTorAh7zEMhj0Ycv4DDQrjHBicLIQu1/pbg5SY4KTde5HVxXxgLw2ThbY68cvU21TI3xL
 kQKE=
X-Gm-Gg: ASbGnct/x/jYjDnI0HX72M7ZWBoP7PQx4kL5nEHjrUCmlIz/ZKJ+YernEdqSlMu0bKn
 dZxjPaxVIF79CcaomYvPcg/YFig6bo+5yq2mr9otQqPfp9NyV0tjwu1Ja7PKRpPyWu55JlXstnX
 odcSyYJ3tVt8Ow3rX8p0BG5gFP0hJ30Gg7A1rQVbwjJyTyKAJV0zgkPkSQbIjMar8SzgQKuPs3i
 cs2FbrpajSmkaUJQ+lPbJMtqC4FwmXhj0O6wWjtVGjOvDkktygCMF0UwBAaGaahHsxrKmPKB+70
 QVsvQmKoS2YQ8mDdWtkNZ1JwJJ5I
X-Google-Smtp-Source: AGHT+IEckjDTzXRn3jz6Kak4qUZrDdzOtPUZ+E4Ewi1aQOMiXkvH7fbt+Cg64gsRhKBiUIfC4g4BJw==
X-Received: by 2002:a05:6402:268f:b0:5dc:6e27:e6e8 with SMTP id
 4fb4d7f45d1cf-5e0b7252c81mr7818051a12.24.1740154502355; 
 Fri, 21 Feb 2025 08:15:02 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1c4483sm13967393a12.25.2025.02.21.08.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 08:15:01 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 20E0C5F8C8;
 Fri, 21 Feb 2025 16:15:00 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] MAINTAINERS: remove widely sanctioned entities
Date: Fri, 21 Feb 2025 16:14:43 +0000
Message-Id: <20250221161443.2321327-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following organisations appear on the US sanctions list:

  Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
  ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890

As a result maintainers interacting with such entities would face
legal risk in a number of jurisdictions. To reduce the risk of
inadvertent non-compliance remove entries from these organisations
from the MAINTAINERS file.

Mark the pcf8574 system as orphaned until someone volunteers to step
up as a maintainer. Add myself as a second reviewer to record/replay
so I can help with what odd fixes I can.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3848d37a38..55b2ef219e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2523,8 +2523,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
-S: Maintained
+S: Orphaned
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -3621,10 +3620,10 @@ F: net/filter-mirror.c
 F: tests/qtest/test-filter*
 
 Record/replay
-M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
+R: Alex Bennée <alex.bennee@linaro.org>
 W: https://wiki.qemu.org/Features/record-replay
-S: Supported
+S: Odd Fixes
 F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
-- 
2.39.5


