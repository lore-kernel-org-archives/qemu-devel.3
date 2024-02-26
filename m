Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748C6C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOUv-0001KK-OZ; Sun, 25 Feb 2024 19:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTA-0006uj-PK; Sun, 25 Feb 2024 19:03:47 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOT8-0000ZJ-US; Sun, 25 Feb 2024 19:03:44 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60853ad17f9so18235667b3.0; 
 Sun, 25 Feb 2024 16:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905821; x=1709510621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xY4fZ6J1E5d6nZV14RhkO1nw2p+k/NowBgJrZNhXAdQ=;
 b=V68ljs9Wv/9ZmeCFnsO2vYpwFHAO1scxM1aOIr7S2+I6eKV3U5kZJGi6hIdh77hiGJ
 3fcKpk8DK0lT/YZKrDT09AhQD8N9nbkrONSZbNhxuwB4lhxbUuJxFtnDS6wgN2VjPuSL
 74XOe3faa2UXU8mh0nsMM2GmhCqnqPqaRNyAK/s/U5hYqVqolC04EseFA4lj+66mENA/
 22sttigvZ0jsqYm+lIwuk2jOHLkxxbsbp07Tk/T21MkwBUSYOXwsG/Z+zqZjJLXD/KNz
 byH1++EWqJPT3xz3c0fv/cIIBmg9945ul1GxL+Z/XRfLZTQfc2YVUARhPqqXWYABkE0F
 qY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905821; x=1709510621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY4fZ6J1E5d6nZV14RhkO1nw2p+k/NowBgJrZNhXAdQ=;
 b=Qc/VcQph4VVFgAO1ubdIbYtRih3C+m5RqOiWb8im25WGbGHtA0Tmz8vzBnAI/sVRIz
 8ZjNG8s10rmROLxmAOWHz7vjrO9A9PDkgxmpZuMITOQO3gEivzJ+pe2oG5kcZl9mRddI
 JGcBpoCYnkUlzsj3baBaABnCghRIgve7weRuXUGyRYf0ZkhHuM1Wwtab9tD1GqhuyFn0
 MvR8mGVmFA81ABmVYtBBLg7TUYQwofbqPXc69YPGy0HdHNZcDQSV4iUwJyhUlGLUPHDG
 rjO9nYtsVQSL+oNg6rkMgjiaC0AzjrMk3zRWheXcZfhWxe892s/h2iV9hUwAXTVH+T3A
 ux4Q==
X-Gm-Message-State: AOJu0Yw5FDEKNA1UD7krk1My7Gf1Sa6oaN9Bz5ln6+xYjVAa/dpfkluq
 1HFjx+OmYXJ+M24BlVquFBu9tZn1yxTWU9opKiwJA+TeQpF2sh1RWnXPcag/52GXoA==
X-Google-Smtp-Source: AGHT+IEjLJX9Id7JUSYMAHfdQEYQYJXse1Xpe8FkgHzLHsEN1r2Z2yty5a9IADVwaIonSaZB8I1maA==
X-Received: by 2002:a81:49cc:0:b0:608:f271:ca2d with SMTP id
 w195-20020a8149cc000000b00608f271ca2dmr809313ywa.37.1708905821120; 
 Sun, 25 Feb 2024 16:03:41 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:40 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 32/41] Add mailbox test constants
Date: Sun, 25 Feb 2024 18:02:50 -0600
Message-Id: <20240226000259.2752893-33-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.c |  1 +
 tests/qtest/bcm2838-mailbox.h | 88 +++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
index 0928a3dff8..1efd3c628a 100644
--- a/tests/qtest/bcm2838-mailbox.c
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -11,6 +11,7 @@
 #include "hw/registerfields.h"
 #include "libqtest-single.h"
 #include "bcm2838-mailbox.h"
+#include "hw/arm/raspberrypi-fw-defs.h"
 
 REG32(MBOX_EXCHNG_REG,          0)
 FIELD(MBOX_EXCHNG_REG, CHANNEL, 0, 4)
diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index e9e1f53bc9..9222b38bad 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -7,6 +7,94 @@
  * See the COPYING file in the top-level directory.
  */
 
+#define MBOX0_BASE 0xFE00B880
+#define MBOX1_BASE 0xFE00B8A0
+
+#define MBOX_REG_READ   0x00
+#define MBOX_REG_WRITE  0x00
+#define MBOX_REG_PEEK   0x10
+#define MBOX_REG_SENDER 0x14
+#define MBOX_REG_STATUS 0x18
+#define MBOX_REG_CONFIG 0x1C
+
+#define MBOX_READ_EMPTY 0x40000000
+
+#define MBOX_CHANNEL_ID_PROPERTY 8
+
+#define MBOX_PROCESS_REQUEST      0x00000000
+#define MBOX_SUCCESS              0x80000000
+#define MBOX_ERROR_PARSING_BUFFER 0x80000001
+
+#define BOARD_REVISION    0xB03115
+#define FIRMWARE_REVISION 0x548E1
+#define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
+
+#define ARM_MEMORY_BASE 0x00000000
+#define ARM_MEMORY_SIZE 0x3c000000
+#define VC_MEMORY_BASE  0x3c000000
+#define VC_MEMORY_SIZE  0x04000000
+#define VC_FB_BASE      0x3c100000
+#define VC_FB_SIZE      0x00096000
+
+#define CLOCK_ID_ROOT      0x00000000
+#define CLOCK_ID_EMMC      0x00000001
+#define CLOCK_ID_UART      0x00000002
+#define CLOCK_ID_ARM       0x00000003
+#define CLOCK_ID_CORE      0x00000004
+#define CLOCK_ID_UNDEFINED 0x12345678
+
+#define CLOCK_RATE_EMMC 50000000
+#define CLOCK_RATE_UART 3000000
+#define CLOCK_RATE_CORE 350000000
+#define CLOCK_RATE_ANY  700000000
+
+#define DEVICE_ID_SD_CARD   0x00000000
+#define DEVICE_ID_UART0     0x00000001
+#define DEVICE_ID_UART1     0x00000002
+#define DEVICE_ID_USB HCD   0x00000003
+#define DEVICE_ID_I2C0      0x00000004
+#define DEVICE_ID_I2C1      0x00000005
+#define DEVICE_ID_I2C2      0x00000006
+#define DEVICE_ID_SPI       0x00000007
+#define DEVICE_ID_CCP2TX    0x00000008
+#define DEVICE_ID_UNKNOWN_0 0x00000009
+#define DEVICE_ID_UNKNOWN_1 0x0000000a
+
+#define TEMPERATURE_ID_SOC 0x00000000
+
+#define TEMPERATURE_SOC     25000
+#define TEMPERATURE_SOC_MAX 99000
+
+#define ALIGN_4K 4096
+
+#define PIXEL_ORDER_BGR 0
+#define PIXEL_ORDER_RGB 1
+
+#define ALPHA_MODE_ENABLED  0
+#define ALPHA_MODE_REVERSED 1
+#define ALPHA_MODE_IGNORED  2
+
+#define GPIO_MASK 0x003c
+
+#define GPIO_0 0x00000080
+
+#define GPIO_DIRECTION_IN  0
+#define GPIO_DIRECTION_OUT 1
+
+#define GPIO_TERMINATION_DISABLED 0
+#define GPIO_TERMINATION_ENABLED  1
+
+#define GPIO_TERMINATION_PULLUP_DISABLED 0
+#define GPIO_TERMINATION_PULLUP_ENABLED  1
+
+#define GPIO_POLARITY_LOW  0
+#define GPIO_POLARITY_HIGH 1
+
+#define GPIO_STATE_DOWN 0
+
+/* Used to test stubs that don't perform actual work */
+#define DUMMY_VALUE 0x12345678
+
 typedef struct {
     uint32_t size;
     uint32_t req_resp_code;
-- 
2.34.1


