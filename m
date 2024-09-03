Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F8ACD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW4p-0005rp-Tb; Tue, 03 Sep 2024 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4o-0005jX-Gf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW4l-0002kP-6Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42c7856ed66so28206665e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379693; x=1725984493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VPp1eQBabOpNy75PWXgECBrWizh2x9vXF9PCGd8LS30=;
 b=gdZLRsNhgsF9F7lNMU3UhCScTfpbTyNUDk0UNEIYIKB2hS9+b6IyB7V5VkHOamANqk
 nR00mf+vLpfIUirZp54H1zPw0bTuj2DSoQo45xy+W/JWyb5s4eRzrm8F9e3vbgK2pkMS
 4Zfcx3Ak+IONzzNe2O5sGv2KZyGu5c6bcuv9Qs1OrGCLUprSN7kS0ARXLTWVMQikrYaM
 Z93shIfksv1YysXWlY1gNme4S6uR8jY/mGjcb5V6H09qTDWPicTveVKDbkvOA9irwDHH
 nI6RFpoo0ipmcVZOCfbNNrxHCHA22AdvqH6Z+3Uxb6JROD3CfJta5/pUkrAIk7nMZlCO
 nRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379693; x=1725984493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPp1eQBabOpNy75PWXgECBrWizh2x9vXF9PCGd8LS30=;
 b=VmoVHTjbPfQjc1jIQkcoMDHS9bNNMu93ErNPJJHWHHiWd9i72gcVYK86tNeVwGUNNe
 usbCGIFfjB/CD2HSkArqH4ybEhxfA5vzuSNsvKO0BGTpEN5fbY65buqAuXdx/zfU3CI+
 igIb+LKPfcTj/mTc/2QqQbWAcb49iXjmcT4ez60NZ4AHymw6TAU1LPxWKbttT4ZkM3bQ
 n8rZGb8LVW+XlGMXGvShvXyFpPdhrcz5hMoEHChur6cNP7YEtL7ucXG/H67Tu5zEhoeP
 PtxeEqOCNnIbwJsOqv3r1MP1AwZIzuMIyx9jfKAFCu7qHExyRkotssaJx/XZOsX0jfjV
 0Gcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqh0lkIDdCat2oVHq6G2GDVcVEFxNcVJzzKVSK70uZiZVfcP5t6HmovCG7cUx6CoHaPkHLBJCfRHZ+@nongnu.org
X-Gm-Message-State: AOJu0Yzxfp6WXhvmulrNWP/8myOLXcxS7REBVO6SqrIs4Knw7du3t2QJ
 VS1VpDSURhnw/a0Y201o1PT1bPN7yn9UnxYYW835uQsM+K3m45JEPoVJ9DcJKCk=
X-Google-Smtp-Source: AGHT+IGARFYFMOg/PyobecON2cdhYOfvegYrpBKLtjcW5OURIURugxOnvpZiJ6DJqQzA3AU3hX7zrQ==
X-Received: by 2002:a05:600c:3596:b0:426:614b:1a72 with SMTP id
 5b1f17b1804b1-42bb0306805mr137341695e9.17.1725379693428; 
 Tue, 03 Sep 2024 09:08:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 14/53] hw/timer/pxa2xx_timer: Remove use of pxa.h
 header
Date: Tue,  3 Sep 2024 17:07:12 +0100
Message-Id: <20240903160751.4100218-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pxa2xx_timer includes pxa.h, but it doesn't actually make
use of any of the #defines, function prototypes or structs
defined there. Remove the unnecessary include (we will
shortly be removing the whole header file).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/pxa2xx_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6479ab1a8b3..d1a3ecac2b5 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -12,7 +12,6 @@
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 #include "sysemu/runstate.h"
-#include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
-- 
2.34.1


