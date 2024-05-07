Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE1C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LnP-000873-LE; Tue, 07 May 2024 10:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4LnK-000801-Iu
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:27:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4LnC-0000KN-JK
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:27:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ba1ba55ebso23963285e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092061; x=1715696861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAfJ0NZ6UlMeTeYaEEe6FTjmLyP9Oz5XaYcm2QoIF8I=;
 b=tBfDljRNqSwIy5xVGIrjf9p2Lww3MUeAJDnqerVOlNzk779ES2bKUwmDW25IZt5nPZ
 fITtgRb+PmaeacyqEvVfkIi2Ftn+TIUwULtXm2BFUcdqgzQ5AnnqKF0gwhsP0mMUXes1
 h9GMTvs5/lNex+rowSuHhlCJPYDDxR4wvXn6q03NZBjcnv4LKxj/x59B0xpabcrl/69q
 391cW8ZJNmB/ZyTWq2hc57Rny6uOxGNABQM51oZ3Q9OIyUsCQKOhfliWH20v182u3wGe
 7sQIBZiuL+X7Vb/MoiwkgZzjO4Vb3QSpreSCdaZJSn2oxUHKPVDxoL5FlNtML7oNEd6X
 EhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092061; x=1715696861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAfJ0NZ6UlMeTeYaEEe6FTjmLyP9Oz5XaYcm2QoIF8I=;
 b=irFoo75kaHEp/c5n4ff2vdbpcOujyGvSHHGmsDZ8v6mQoeOnY/PmMrUAtkzJeCbMK1
 lyPGPWaA1MoETA58pUKzHIqPK1YX58X3HAQgQmZuCabPqkvozReUwaUBW+yGWANRaAj5
 GWNMb0hec9Ga/vlrSCuoVtxQ293EU/zgD7bexnJPk5tBJV8cDw+NoqVbntKM13C67NIF
 8xBCTP2TCB3RMeXfzywADE09OAugweqRAagWqGeFmKNzzKaWhg3RReg5u1Si518WIQTW
 t869k4BKGC1AoUm3DZEJ/p6+stBkkq1qI3gZK3+U5e96Dx9gFWd73JAqEeITV6QwR8y/
 6pww==
X-Gm-Message-State: AOJu0YzZXpbZg3xbyhaF3KSE6DCmagSiFYryZshtD4cw/ujRC7eR20B1
 b1RicA7lv8aOB8AmD7QJ7iLaJJOOXYFLluJHP8nCS/ZeskqPl1vwrfg1bYlhjsJo30ZyG+FTO/q
 p
X-Google-Smtp-Source: AGHT+IGC47DCq2erqdvmbO/w8yi5g7U48HVcB556ZaJ118OCS0+rrG9JKNHTbNj6U0d0XDMqEFsvFA==
X-Received: by 2002:a05:600c:1c84:b0:41a:b310:8959 with SMTP id
 k4-20020a05600c1c8400b0041ab3108959mr10499427wms.32.1715092060747; 
 Tue, 07 May 2024 07:27:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a05600c474600b004182b87aaacsm19841880wmo.14.2024.05.07.07.27.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 May 2024 07:27:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] misc: Use QEMU header path relative to include/ directory
Date: Tue,  7 May 2024 16:27:37 +0200
Message-ID: <20240507142737.95735-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

QEMU headers are relative to the include/ directory,
not to the project root directory. Remove "include/".

See also:
https://www.qemu.org/docs/master/devel/style.html#include-directives

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/audio/virtio-snd.c   | 2 +-
 hw/rtc/ls7a_rtc.c       | 2 +-
 target/i386/gdbstub.c   | 2 +-
 tests/qtest/nvme-test.c | 2 +-
 tests/qtest/ufs-test.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6a2ee085c0..7d09800d1f 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -19,7 +19,7 @@
 #include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "include/qemu/lockable.h"
+#include "qemu/lockable.h"
 #include "exec/tswap.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index ac28c1165b..052201c2cd 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
-#include "include/hw/register.h"
+#include "hw/register.h"
 #include "qemu/timer.h"
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index ebb000df6a..4acf485879 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -19,7 +19,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "include/gdbstub/helpers.h"
+#include "gdbstub/helpers.h"
 
 #ifdef TARGET_X86_64
 static const int gpr_map[16] = {
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index 008d189b0f..5ad6821f7a 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -13,7 +13,7 @@
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
-#include "include/block/nvme.h"
+#include "block/nvme.h"
 
 typedef struct QNvme QNvme;
 
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 95e82f9472..82ec3f0671 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -13,7 +13,7 @@
 #include "libqos/qgraph.h"
 #include "libqos/pci.h"
 #include "scsi/constants.h"
-#include "include/block/ufs.h"
+#include "block/ufs.h"
 
 /* Test images sizes in Bytes */
 #define TEST_IMAGE_SIZE (64 * 1024 * 1024)
-- 
2.41.0


