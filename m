Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8927EC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9JM-0007Bf-BZ; Thu, 20 Feb 2025 11:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JK-000784-CL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:02 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JI-0008Ff-NN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:02 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4398c8c8b2cso11630775e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068519; x=1740673319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=en6YocqtrS/0yWND16m0Wy3DxaXuYWGQFBD5//8sF1E=;
 b=ROC+IosCo5Fs48id/5SFEGYdSANElVs4XCi0Ptob1lfrRJrK23Gvg194c58kE8T3iJ
 dnMf6ZRkeaXJmqM8GyPM4zZ8RJksxwS26Q+CytWOcXN2/Y6syr4ds34zXR14KuzBmbkV
 WWUtwzMFWV9zzStmR7D31fzGJSZ8MEwyxq3HasNcvfQchIr9EejW1yJv/CWzXBdjjI9a
 i+0vJlQDb0UWBvXzwMQ0FizKbsx/q+FoBh/VO92K4X1NKZ2het1ZLorV8i68YnBEOTZX
 tdZ6msckCJ/15WO1XD+46EVE9hl9IW2OkqYhQ9leLKUBYoQfFsVuiUpit8V9uCSrDNs7
 sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068519; x=1740673319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=en6YocqtrS/0yWND16m0Wy3DxaXuYWGQFBD5//8sF1E=;
 b=Z7/Kfo1+tX4RYp22NkYqzY0zCOQBpXhsfkcmghFlP0tXtP/vGsZbX5WDMpuPGmROpO
 jkk3dIO1tgWDwzflIIXnv6VbHYGlZgtNRzX10tLslla2V3GFExNSVwO0JgRThPfKtK5w
 2t6yZyMcVG7kAbQ662RET5WCa9s2LwpKp2k54/CH5G9DE7TJ0WG+BZebMbWicehbSk4E
 GhxHJgQ08gXZrMoQh5FOrYpFKIy+piYMBDiLp8UB5JwGIV0I9782ZCvafY6COxVOsyqI
 1rn0mxYxjhJwMy2OqkaWO2kB2FMY6Ds68N+XVXVV8nAbbuTGHH571LxH69uYuPbVoLEy
 0jkA==
X-Gm-Message-State: AOJu0YxGTMAmXiprrNuufFgrXBHRIreGgutWkmyfYKgfHvnqd/tqYVQW
 HZufUxyeoKw9FSuqzxsVH9tDrMWfQAtiN3md7iqUue+t+UdNurqItl/y1MpYYUMRe/X3AAr0ChO
 p
X-Gm-Gg: ASbGnctjDY3bKj8F314sCr981cqdRiNiFxfFR+phZC6c1Nd1yz036v0urPY36SJn3tf
 qwN7dCYrrGP1oUfP5EYY0OJURQ6z9yYSmXSEopkrBsXKp/sUMya8NzilNDTh/rtLfLCRo3IQG30
 6sXMPVgo0D0LsH++NDrweSkGUGsEPROqG4eC49UktkeNt25Z8AOfU5QoVr+caJZBhHvtPqeW7Hl
 aUmz97rH3n75KP2B4D+P3+1luijSM6bbpRYjHbyTkbQl96G6sq3YXaj+ap5pJwTLvRLFFdpl8VN
 tOZDF0X+CmT7zfL6Bkiq7w==
X-Google-Smtp-Source: AGHT+IHZpq98AqE5SNm7tYlKu0RpO8n8EyL5zAsgdYQHwVep6XtX/n/oIG51S4XrFT2QCRsPJ2XN9A==
X-Received: by 2002:a05:600c:154c:b0:439:89d1:30dc with SMTP id
 5b1f17b1804b1-43989d1328bmr176267825e9.10.1740068519221; 
 Thu, 20 Feb 2025 08:21:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/41] hw/misc: Rename npcm7xx_gcr to npcm_gcr
Date: Thu, 20 Feb 2025 16:21:09 +0000
Message-ID: <20250220162123.626941-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Hao Wu <wuhaotsh@google.com>

NPCM7XX and NPCM8XX have a different set of GCRs and the GCR module
needs to fit both. This commit changes the name of the GCR module.
Future commits will add the support for NPCM8XX GCRs.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-5-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h                      | 2 +-
 include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} | 6 +++---
 hw/misc/{npcm7xx_gcr.c => npcm_gcr.c}         | 2 +-
 hw/misc/meson.build                           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (96%)
 rename hw/misc/{npcm7xx_gcr.c => npcm_gcr.c} (99%)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 4e0d2101885..510170471e0 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -24,7 +24,7 @@
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
 #include "hw/misc/npcm7xx_clk.h"
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/misc/npcm7xx_rng.h"
diff --git a/include/hw/misc/npcm7xx_gcr.h b/include/hw/misc/npcm_gcr.h
similarity index 96%
rename from include/hw/misc/npcm7xx_gcr.h
rename to include/hw/misc/npcm_gcr.h
index c0bbdda77e5..9b4998950cc 100644
--- a/include/hw/misc/npcm7xx_gcr.h
+++ b/include/hw/misc/npcm_gcr.h
@@ -13,8 +13,8 @@
  * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
  * for more details.
  */
-#ifndef NPCM7XX_GCR_H
-#define NPCM7XX_GCR_H
+#ifndef NPCM_GCR_H
+#define NPCM_GCR_H
 
 #include "exec/memory.h"
 #include "hw/sysbus.h"
@@ -70,4 +70,4 @@ struct NPCM7xxGCRState {
 #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
 OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxGCRState, NPCM7XX_GCR)
 
-#endif /* NPCM7XX_GCR_H */
+#endif /* NPCM_GCR_H */
diff --git a/hw/misc/npcm7xx_gcr.c b/hw/misc/npcm_gcr.c
similarity index 99%
rename from hw/misc/npcm7xx_gcr.c
rename to hw/misc/npcm_gcr.c
index 07464a4dc93..826fd41123b 100644
--- a/hw/misc/npcm7xx_gcr.c
+++ b/hw/misc/npcm_gcr.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 
-#include "hw/misc/npcm7xx_gcr.h"
+#include "hw/misc/npcm_gcr.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521be..554eb8df5bc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,7 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm7xx_clk.c',
-  'npcm7xx_gcr.c',
+  'npcm_gcr.c',
   'npcm7xx_mft.c',
   'npcm7xx_pwm.c',
   'npcm7xx_rng.c',
-- 
2.43.0


