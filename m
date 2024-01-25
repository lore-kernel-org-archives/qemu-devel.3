Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BA7C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2gF-0006ru-F2; Thu, 25 Jan 2024 11:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gD-0006qC-Ul
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT2gA-000295-2P
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:34:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40eb033c192so6090155e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706200452; x=1706805252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VAtlyKekgyrpcRxglyNDTk+EfBtmZT3jre+RwjFb84=;
 b=YfPmM/ncBRWpFQQOQewrEalxrkMsI0TQYJuG4jH+kWNWimyywcnXMfOphxoWCtvgcr
 Gm/8OCJyTv2hUdwE5YiMnINMcS2S5UoFK6Dwsu5nUnecqMV7TiGB1OJc8om7cH9Ly25U
 ILwdy2UIG+Pjq2GLuhO/U1g/0vHsmPT4PP+0mTWBrRZBdYVoZgiUB5M6PBmYTFwctxhr
 S96ZUCgUzUJCVwxBcy76VqTDZVgALJqgKaHHIyYdqLH0NyAdpiTA3RX6hfVui5dIyBMz
 V5bkNnnUCMX02dJ7+yyKK+Bh9CwWdNYOcCeteg4ZtnZ5m02kjBZUWKs7RaYDa0wzikec
 08YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706200452; x=1706805252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VAtlyKekgyrpcRxglyNDTk+EfBtmZT3jre+RwjFb84=;
 b=uZOvIaZqM3uhYXKsSSVoE2WgZ5jsADfXBRfA9JAFSUCQESemFRMzh5ic2bonwoSKWN
 Z6FAeMfHA6QRtPnKGlNEGI5/2UsRjicFoCl0ZrL7urRPBH80N+BWeHSsvED/5GWMKaMC
 yt+knnspBH2epSmkULuhqXhy6ZBs/Ll8LQ/avTwYFgwht3/nCqh4gAoUcDkqtSDV3YAq
 uBatAEk5xe9eyVTHpS5T3Lq5qZ7M+yh2M3YX19kPs16gY1VfqN14DN1VtTHzPJudHG7J
 6TTLX6vByQJQCdUMJjFV34YtKy7+0Z8YGIz/DhRs0f272+qaW4la/hSsL0LQXxUilrHM
 nQbQ==
X-Gm-Message-State: AOJu0Yza+/0E78mW9g5DaxrHt9FLyFLL4tohgp/sFiPQLjkVlf5uhWa2
 kgWOkziyXe8IminPYZSbwrlbbwECA0wIYIlqtjZUV+k70i1CACrCkzRBMISdXkvjDnJnIJnev0x
 V
X-Google-Smtp-Source: AGHT+IGl23dbk6M9Zr1YlSPfewofwjrLnGbQ9yoY3iDw1oI4gHjKnf5tvL29+qfxZDhbQmLEXkqjmQ==
X-Received: by 2002:a05:600c:1d90:b0:40e:c635:331 with SMTP id
 p16-20020a05600c1d9000b0040ec6350331mr42474wms.53.1706200452627; 
 Thu, 25 Jan 2024 08:34:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05600c358d00b0040ea875a527sm3122208wmq.26.2024.01.25.08.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:34:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH 07/10] include: Clean up includes
Date: Thu, 25 Jan 2024 16:34:05 +0000
Message-Id: <20240125163408.1595135-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125163408.1595135-1-peter.maydell@linaro.org>
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git include include/*/*.h include/*/*/*.h

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I hand-checked that all these headers are included only by .c
files which already have osdep.h included.
---
 include/hw/arm/raspberrypi-fw-defs.h | 1 -
 include/hw/mem/memory-device.h       | 1 -
 include/hw/ppc/spapr_nested.h        | 1 -
 include/hw/xen/xen-hvm-common.h      | 1 -
 include/qemu/qtree.h                 | 1 -
 include/ui/rect.h                    | 2 --
 6 files changed, 7 deletions(-)

diff --git a/include/hw/arm/raspberrypi-fw-defs.h b/include/hw/arm/raspberrypi-fw-defs.h
index 4551fe7450d..579cf0d5546 100644
--- a/include/hw/arm/raspberrypi-fw-defs.h
+++ b/include/hw/arm/raspberrypi-fw-defs.h
@@ -10,7 +10,6 @@
 #ifndef INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
 #define INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_
 
-#include "qemu/osdep.h"
 
 enum rpi_firmware_property_tag {
     RPI_FWREQ_PROPERTY_END =                           0,
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index a1d62cc551a..e0571c8a319 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -14,7 +14,6 @@
 #define MEMORY_DEVICE_H
 
 #include "hw/qdev-core.h"
-#include "qemu/typedefs.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d3834864764..d312a5d61da 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -1,7 +1,6 @@
 #ifndef HW_SPAPR_NESTED_H
 #define HW_SPAPR_NESTED_H
 
-#include "qemu/osdep.h"
 #include "target/ppc/cpu.h"
 
 /*
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 4e9904f1a65..4b1d728f35c 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -1,7 +1,6 @@
 #ifndef HW_XEN_HVM_COMMON_H
 #define HW_XEN_HVM_COMMON_H
 
-#include "qemu/osdep.h"
 #include "qemu/units.h"
 
 #include "cpu.h"
diff --git a/include/qemu/qtree.h b/include/qemu/qtree.h
index 69fe74b50d0..dc2b14d2582 100644
--- a/include/qemu/qtree.h
+++ b/include/qemu/qtree.h
@@ -42,7 +42,6 @@
 #ifndef QEMU_QTREE_H
 #define QEMU_QTREE_H
 
-#include "qemu/osdep.h"
 
 #ifdef HAVE_GLIB_WITH_SLICE_ALLOCATOR
 
diff --git a/include/ui/rect.h b/include/ui/rect.h
index 68f05d78a8e..7ebf47ebcdc 100644
--- a/include/ui/rect.h
+++ b/include/ui/rect.h
@@ -4,8 +4,6 @@
 #ifndef QEMU_RECT_H
 #define QEMU_RECT_H
 
-#include <stdint.h>
-#include <stdbool.h>
 
 typedef struct QemuRect {
     int16_t x;
-- 
2.34.1


