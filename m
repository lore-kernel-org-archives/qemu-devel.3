Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB00C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gE-0006qp-JR; Thu, 25 Jan 2024 11:34:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gC-0006oX-E2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2g8-000287-Uz
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e76109cdeso77101775e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200451; x=1706805251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXb190+lhYx3lCV3waqp1Pgx9RLFbwQo2doe5u6vJo0=;
 b=jQacrLeElBhY2VsPUmiiTHp7LMo43BnnTLv8I/3I9vB9xIzQC9BYIm3oMJDQ2KzQ5z
 uuzQMIdctBqFy17glRDaxwFieQwwomoiQzQ2ONqGl49tCUoF5Q8dvaHHXetlY4+ST17P
 Fffl8iC/E5qOwOxtdV6wnhH5rpcKIWqPR/17p6cDJRMd6uVrkeBVZ1ZqB6GEN31UQ0TQ
 3Oq8lAMbVRzm0sneGP2Tjlvi7nXE9cia0Q8zow6cru8kP1zw1ZumcwA7BTlkxUjIUJk2
 lZIHy+zxxOONCxg05XDIIzjm4S3FbPUlb8G36blFTAr1s9hrcV87klwix2PmsjoP4pxe
 YguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200451; x=1706805251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nXb190+lhYx3lCV3waqp1Pgx9RLFbwQo2doe5u6vJo0=;
 b=VUR1mB2CQb+7YvnyAQjHFvqMlVvjhJ+7V4qnVNp9a3BGEw7J+ruB66J2yLS2njvbnM
 KwclgWWqbh9/7Wx9ALaKOCRkN1jaZ+bqbt4LRY6rCwjwSgoGaZwa9VS5VLqgijhmndPa
 ZGiQqKbHDSToR5ap2+u29mXiXO/+XR7N9vvqoppKFO0ZDWCSCzc+YC21uCJBKyd6tkru
 n0EazAVNcLPtofdrcQsRicL9tDbCwDdSte81QQMYT89ImuBOHgTgnQq/q27gploBx9z8
 Hnm1PjnR54TQcsMMjnPJGSdmLSa7IZxP3FQsKP70M7LtMD3V5bRSK6KFRC0tp2I48C41
 8/8w==
X-Gm-Message-State: AOJu0Yz873QtDpI7gaZj4WSosqUSESBiNOl9GhBfE8u5ahId0CwbjffQ
 JpboVHKnCUIvg4X0WnLEIMYLWFboqqEAAXweXVHBb0V2JZFfIIPywCE+dXsJX77+u/9G3UH0JiQ
 2
X-Google-Smtp-Source: AGHT+IE0HVnIpPRsMYXIc3iE3qK38WGkTQQ5apxgP2dO9pN94oPR2pBbMSyOI/zQvndLN2N8XGhK+Q==
X-Received: by 2002:a05:600c:a01:b0:40d:7d87:6730 with SMTP id
 z1-20020a05600c0a0100b0040d7d876730mr716948wmp.101.1706200451391; 
 Thu, 25 Jan 2024 08:34:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 04/10] aspeed: Clean up includes
Date: Thu, 25 Jan 2024 16:34:02 +0000
Message-Id: <20240125163408.1595135-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

This commit was created with scripts/clean-includes.

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed_eeprom.h     | 1 -
 tests/qtest/qtest_aspeed.h | 2 --
 hw/arm/aspeed_eeprom.c     | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
index bbf9e54365b..f08c16ef506 100644
--- a/hw/arm/aspeed_eeprom.h
+++ b/hw/arm/aspeed_eeprom.h
@@ -7,7 +7,6 @@
 #ifndef ASPEED_EEPROM_H
 #define ASPEED_EEPROM_H
 
-#include "qemu/osdep.h"
 
 extern const uint8_t tiogapass_bmc_fruid[];
 extern const size_t tiogapass_bmc_fruid_len;
diff --git a/tests/qtest/qtest_aspeed.h b/tests/qtest/qtest_aspeed.h
index 235dfaa186a..d35b0c7cba5 100644
--- a/tests/qtest/qtest_aspeed.h
+++ b/tests/qtest/qtest_aspeed.h
@@ -12,8 +12,6 @@
 #ifndef QTEST_ASPEED_H
 #define QTEST_ASPEED_H
 
-#include <stdint.h>
-
 #include "libqtest.h"
 
 #define AST2600_ASPEED_I2C_BASE_ADDR 0x1e78a000
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
index ace5266cec9..daa3d329d10 100644
--- a/hw/arm/aspeed_eeprom.c
+++ b/hw/arm/aspeed_eeprom.c
@@ -4,6 +4,7 @@
  * SPDX-License-Identifier: GPL-2.0-only
  */
 
+#include "qemu/osdep.h"
 #include "aspeed_eeprom.h"
 
 /* Tiogapass BMC FRU */
-- 
2.34.1


