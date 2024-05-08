Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221BDC25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lOR-000587-0s; Wed, 08 May 2024 13:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lOE-0004zn-OS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:39 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lOC-0000sh-Mh
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:38 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51ef64d051bso4051676e87.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190453; x=1715795253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB9PBXZLhPirLB2HUXLQgsvt1kdrJAYX5azy5DWGsCI=;
 b=MeLbS01kJxZO3QcL5W0jG2Fioop4bHZEVXAeY77PDByAmpx7btIaqAu95Zhr7gFGZi
 42LjFFrvHJEXHt0Fq9MyUR+R5o8fszxlv7sWkc5icUGFfnzZYf76+qd1X1hXK9/5tb+o
 iypk976AV/jjziCvXQL93//M/YEt5Tj6PNgCLvLTlASjUF40Br6bZMBcql4PqU0Aw3Am
 n3YZkQELkwZrzEx/5tn5OWe8oIgvegr4ddKqO/k40r9pqJCU3wU6cjN99BhigZgNGOU0
 t1Lb9mFUA6KR3iUEMfmgsbMLY7l+K90XcvVDTEi/xY4ZhaFY6SRmd9ENaK3N7knEBrtX
 UPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190453; x=1715795253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB9PBXZLhPirLB2HUXLQgsvt1kdrJAYX5azy5DWGsCI=;
 b=eZsZ7S+uMCCnJ6u3DATlL8bz+NXHrgDZOojELYbS1TyP0xKCoaMkIyAiSKcXZWyOVM
 NSRqa1vKsQxm/PcDVMH4pRBWTsmXwsoXBwg6qDwSmAdrSOdXXBRBz5mgcTGnS9lZf9Zq
 NFap048ymTa+/9Ii2MWEADJg88E5+HPCU7vGvzXxQUxc5+wspQUmCYdx+orVaIslH1zB
 xw6NJ6+4jEViIXMs3yA0ZeXDAI94/WbzDiEq+lcJwTDuiwBPEIX57hEALow889pxYJ8P
 txTITXSriez79DhX0ySd/XURdOGPZT67Pdkm3TsYm4oaUr7fnpKMrQws6YKHx9XPwMkx
 kNyw==
X-Gm-Message-State: AOJu0YwW/GwHfewKhFPVaPhsO1a2Y1/hCrerWhWPva81DY6fg2T5xByC
 uJx6Li9QrnMn5aFoo6lH6h2Lk1X7xPSJta6AMBjgwtCf3FizTHYJ17xtJ2Z/d6nPA2ebF+f1Ix/
 Q
X-Google-Smtp-Source: AGHT+IErf8jaj9iHB0AJKsDouPlhfOlLoBUYZAHmGlSzmEqaKasw5QbS+Tl/P3jHJ+L4c4PX6ieHxQ==
X-Received: by 2002:ac2:5494:0:b0:51d:bbb:7a4e with SMTP id
 2adb3069b0e04-5217c3740bemr2007778e87.24.1715190453314; 
 Wed, 08 May 2024 10:47:33 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 el24-20020a170907285800b00a59b9263f59sm5007080ejc.102.2024.05.08.10.47.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/26] misc: Use QEMU header path relative to include/ directory
Date: Wed,  8 May 2024 19:45:10 +0200
Message-ID: <20240508174510.60470-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240507142737.95735-1-philmd@linaro.org>
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


