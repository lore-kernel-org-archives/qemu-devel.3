Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B43C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOS6-0005Q7-AK; Thu, 20 Mar 2025 18:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOQ7-0002qC-9A
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:26 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPT-0007Dw-BF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2255003f4c6so25982855ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509840; x=1743114640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHEF58QYUX/sH/f2D4AiJ/KV1+OKbOaRN8ddf0N58IU=;
 b=kIEUYrdOI9Vq5sO/wdMC1tMLKYcPjMarGfRnqAP5uOPNGYsUt7yDr97+Qj6Ij8/Iat
 LePAfx6M0+PzEhqhRChzgpZUWgHj623pZr2mnY2KlxnKkSDMZsoqoMlJ9rUn+tE6cWe5
 AstoZY6m8JKyVx3kcesk8WliZkG7lvbEqbeorPNm26pKCBf5UsF7d+Rf0mUcAXeTLlpU
 GmW2b0IQQ1J05ACL2JQRq5V4oCvkTILf2evssWt532ASS9UGINedf3Jh6GM36ZX+zYpB
 OoQTaRCMe4NeA56zuO4jBkfoEBVqmaxJwpPaVdm/dJn77TLaPTjLNm8pNXP0PP24tS/+
 Xrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509840; x=1743114640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHEF58QYUX/sH/f2D4AiJ/KV1+OKbOaRN8ddf0N58IU=;
 b=OCr74nU88XWIV8Vjufp+ussSSbhhLuKNjJGeo7SZFQXYKJeotStKpAUvgSDQnqiRXs
 g26YTRFo5GcF9gWFOj369y025wEid8h2YtHL+RN6g9Tm8S3CtfoCZ4sMn8PJgE3o+7TW
 SwF0XZmyVwx6qXtNBpqM2ZU38tQxBrwIpcXQuk5zNKMpylou4SMzFK8T8l7DND2OnEAC
 fmSBWFkprDuziF0LdAbm+800n5EcR9DoxghTd2MibP9DJ6P/C29hDah4j1Znyzv5Eybt
 ixDIajcitBTg5wHqVY/WwDZEgrlal9c6ND2Mousn0w3mbOi2AQMR/JEq0WUlkbDI9cXG
 4XuA==
X-Gm-Message-State: AOJu0YyzfvEjVsL9kWzahK7Ddv/chgpPxUfDi7BihUgaG42AnghteU0r
 S+KTLi6S2CQF0IzGfVya3BDbj8NFbMWgxH5ZMPL5Dj1SbhNSLlYWCm0wN/is5zz8ROZdaA1nrvw
 c
X-Gm-Gg: ASbGncuiEntPDidxcVENyBGokxjGvngJVtASN0Vnk7y5uniO+vscM22EEL9ePp5DxrL
 ar54Mjg+8ztwlMKxnr72mEdj2Rv/JDmDdJxptMxvL6qU+QrWmbbt5WlG9WkCRqQkfwuMCI0RX7X
 QVGTKwFRDg2mlxP1TpeP6YerlPw747Ka163U9VOTowDEegniKJbXEAXcVdvQmaE0deXsC2n31gs
 obN3v2zhWNHZypu1b7FjMt274c3vwK/kZ6+zW5xjxFMshGugCF1agQbiZA8EXnx+AzgtdvLmmVr
 kUDTMjha091UT9b0Qt+E41l3gX/Tpb1v6AXSflmoyCg9
X-Google-Smtp-Source: AGHT+IGSwMvnVIjoOPD494sxH4RGx3NXLi4VEGe0c2kLzhohOrnkSN5SNch8m4i9VjXaZXHDGWWEXQ==
X-Received: by 2002:a17:902:cec4:b0:219:e4b0:4286 with SMTP id
 d9443c01a7336-22780db462fmr15563735ad.29.1742509839708; 
 Thu, 20 Mar 2025 15:30:39 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 29/30] hw/arm/xlnx-versal: prepare compilation unit to be
 common
Date: Thu, 20 Mar 2025 15:30:01 -0700
Message-Id: <20250320223002.2915728-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 278545a3f7b..f0b383b29ee 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -17,9 +17,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "hw/arm/boot.h"
-#include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
-- 
2.39.5


