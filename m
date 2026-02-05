Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C6CEA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpe3-0008Q8-Pv; Wed, 04 Feb 2026 22:03:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpe0-0008Po-FR
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:01 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnpdy-0007Tq-SW
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:03:00 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso134499a12.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770260577; x=1770865377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0z/dh6/RDo5Q2XqTUloJH1njkINJixVqGcWa0XOrjA=;
 b=Rif6oeNlQHRXb164mHmJrkMiyE5BimOvNS/GkTnLjpqRWPk4LObs0RnCrn1cBx8Qr5
 eB7FCx5nf0i/ePN+qtVtXleATAa48pyPw8SeSNACw/kQFmtAxJ2Rry46Ubc7xxix8qpQ
 +1ihXaVUFus5W+q+iKbX1RBl2HyoNcOGLq4CVnTKHrKc8DcUFHhhQEcahQePqn+/dq5i
 qGtJBlHDT6dd2Qg08Orc/0D85CU1KrQvwJJ2/i8RbDxIqntluGUycVunYKfNPkJB3Oy4
 u5ndnC6Yw5Dq2he7glSWx8p3KzvcVCWNETHLZEycDBLclO+I14H3bgIAUuTd65m7nutw
 3c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770260577; x=1770865377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J0z/dh6/RDo5Q2XqTUloJH1njkINJixVqGcWa0XOrjA=;
 b=FL/+ziPVud4/5KLKCujep1VxIzNCTdNtF+vCXGG3jCHiKFbwJcYBzoEBzqXt3fv5Ov
 xrETKmUy0RR8gey0xKDlgWUpm6pXCmKuC9CrEqn/8ndGECqNeQ769q++arWp2DM2tQrC
 VLxAc9dqLkGfiQ5/fhIBTeTjknTjQc2YGJmJHRHn6iQoZyRXUPSXdhZk9sRlGc3BayJs
 eV6fG2mm2w1RzZ1aC7GA87RhvoGh6sR2pNByuIRBx85TkyLSJqlYGNYyRsIq3PBGHqrf
 LpybwIdSLvahPsKtWd8bFIMlurWShp8LmltU7iWvn0zTCVmAEJiInzERXv/K6SwMvI32
 FqPg==
X-Gm-Message-State: AOJu0YwJM0PZ/d6eM/cvVsiCq3pt2ufcUN8Ok8AjGxoNQxg+sZk2M3rc
 3LuiExY+vJCUdZT3B381A8mGKlpkEqnkrXpJxNAvPrFSWZqqRT1VzacE8TeSlkkKHdN2BgYt5fC
 Do43EplHi/Q==
X-Gm-Gg: AZuq6aItM5b+QhDOWlxwlD2lyy2Bp4z8Cx5K/WLvCkdRpr0eH2yYD+xUGGpajP0r9/r
 ZCY7jxRIJ8KO0QDh5d4nwAgOGsmkBZGgqupYNRnBi9nzozEKxcICbZ/eiYT9jEFp3IZiqpOdi5S
 Yt4Hc/Av1meGroOfsbDqaoFxNb21aqm6kHG0KJK1OGUtMANnUg7GSRN45wnmSRkcwbWuC9JLlFB
 GPhTeP73fCG3Ms/SA7nHMV/WBFdvn5m1657ateSQB7PSrbRWS2m8vGMAdtpVcmbpZDJrvxC+0ow
 WC4xLjcM10aSG+NtQkTileYOf5WbSC/Pkgdxfh0BPFLKzWfUXTH0zCYiiESnig1Y4aB8CbWWBJX
 JFSxD4Xk6E8IUocs5m0xw/a8eyDP4oEshRYH1gPixoV056LyyXT0wIDu9Oh+nhEAbM3imjdlIsC
 IyA1am3oiry27miRpZkCTaqi/0Ptmy+kc=
X-Received: by 2002:a05:6a21:15cf:b0:38d:f2a1:a44f with SMTP id
 adf61e73a8af0-393723c228dmr4597658637.48.1770260577208; 
 Wed, 04 Feb 2026 19:02:57 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8572b4e7sm3395480a12.33.2026.02.04.19.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 19:02:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	shorne@gmail.com
Subject: [PATCH 2/6] include/hw/or1k: Rename from openrisc
Date: Thu,  5 Feb 2026 13:02:40 +1000
Message-ID: <20260205030244.266447-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205030244.266447-1-richard.henderson@linaro.org>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/{openrisc => or1k}/boot.h | 6 +++---
 hw/openrisc/boot.c                   | 2 +-
 hw/openrisc/openrisc_sim.c           | 2 +-
 hw/openrisc/virt.c                   | 2 +-
 MAINTAINERS                          | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename include/hw/{openrisc => or1k}/boot.h (93%)

diff --git a/include/hw/openrisc/boot.h b/include/hw/or1k/boot.h
similarity index 93%
rename from include/hw/openrisc/boot.h
rename to include/hw/or1k/boot.h
index 3c481bdea6..2e6131580c 100644
--- a/include/hw/openrisc/boot.h
+++ b/include/hw/or1k/boot.h
@@ -16,8 +16,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef OPENRISC_BOOT_H
-#define OPENRISC_BOOT_H
+#ifndef OR1K_BOOT_H
+#define OR1K_BOOT_H
 
 #include "exec/cpu-defs.h"
 #include "hw/core/boards.h"
@@ -32,4 +32,4 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
 uint32_t openrisc_load_fdt(MachineState *ms, void *fdt, hwaddr load_start,
                            uint64_t mem_size);
 
-#endif /* OPENRISC_BOOT_H */
+#endif /* OR1K_BOOT_H */
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 6256babc42..c18f4a6a9f 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -12,7 +12,7 @@
 #include "exec/target_page.h"
 #include "elf.h"
 #include "hw/core/loader.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "system/device_tree.h"
 #include "system/qtest.h"
 #include "system/reset.h"
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 603d8ca0d9..f1b1f63274 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -26,7 +26,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "hw/core/qdev-properties.h"
 #include "system/address-spaces.h"
 #include "system/device_tree.h"
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 54ce96666e..39f54058ab 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -16,7 +16,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/core/split-irq.h"
-#include "hw/openrisc/boot.h"
+#include "hw/or1k/boot.h"
 #include "hw/misc/sifive_test.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index a0422936ad..508d37ab7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -305,7 +305,7 @@ S: Odd Fixes
 F: docs/system/openrisc/cpu-features.rst
 F: target/or1k/
 F: hw/openrisc/
-F: include/hw/openrisc/
+F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
 F: tests/tcg/openrisc/
 
-- 
2.43.0


