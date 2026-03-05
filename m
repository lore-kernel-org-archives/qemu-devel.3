Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D8BF47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCx0-00070G-Eh; Thu, 05 Mar 2026 12:57:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwy-0006zH-UX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCww-0003Un-T6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdCS0DnnHcsS2ciqFMCbCvsAQSy83WJGNbS8OnpJm9k=;
 b=Sjja0Q95eKDALUXTxhilDzKka3kQNLvWZwU9rFjUU6ZVt15NIGpamgw9m3BXkzkwf/cGMa
 iKMEzqb3r+381p7uZ/nIuLP1gPK6CqCMXA4OXN4reDKZW05b5GSaI4SaVxAUrYz0RcWhcg
 vmfLWBHwdeog9uO080Bt2EWz4bE3qJA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-mRBH-6_oMPudVbZqwTVd0w-1; Thu,
 05 Mar 2026 12:57:22 -0500
X-MC-Unique: mRBH-6_oMPudVbZqwTVd0w-1
X-Mimecast-MFC-AGG-ID: mRBH-6_oMPudVbZqwTVd0w_1772733440
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43ABC1955F29; Thu,  5 Mar 2026 17:57:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76BCF3003E9E; Thu,  5 Mar 2026 17:57:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>, Titus Rwantare <titusr@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Subject: [PULL 02/38] hw/misc/aspeed_i3c: Move to i3c directory
Date: Thu,  5 Mar 2026 18:56:35 +0100
Message-ID: <20260305175711.1119025-3-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Moves the Aspeed I3C model and traces into hw/i3c and creates I3C build
files.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Reviewed-by: Titus Rwantare <titusr@google.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 meson.build                           | 1 +
 hw/i3c/trace.h                        | 2 ++
 include/hw/arm/aspeed_soc.h           | 2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h | 0
 hw/{misc => i3c}/aspeed_i3c.c         | 2 +-
 hw/Kconfig                            | 1 +
 hw/arm/Kconfig                        | 1 +
 hw/i3c/Kconfig                        | 2 ++
 hw/i3c/meson.build                    | 3 +++
 hw/i3c/trace-events                   | 7 +++++++
 hw/meson.build                        | 1 +
 hw/misc/meson.build                   | 1 -
 hw/misc/trace-events                  | 6 ------
 13 files changed, 20 insertions(+), 9 deletions(-)
 create mode 100644 hw/i3c/trace.h
 rename include/hw/{misc => i3c}/aspeed_i3c.h (100%)
 rename hw/{misc => i3c}/aspeed_i3c.c (99%)
 create mode 100644 hw/i3c/Kconfig
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/trace-events

diff --git a/meson.build b/meson.build
index df841e12e24e..77590cdf534f 100644
--- a/meson.build
+++ b/meson.build
@@ -3614,6 +3614,7 @@ if have_system
     'hw/fsi',
     'hw/hyperv',
     'hw/i2c',
+    'hw/i3c',
     'hw/i386',
     'hw/i386/xen',
     'hw/i386/kvm',
diff --git a/hw/i3c/trace.h b/hw/i3c/trace.h
new file mode 100644
index 000000000000..1e0c4eadf0ed
--- /dev/null
+++ b/hw/i3c/trace.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include "trace/trace-hw_i3c.h"
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index b185b0418678..d7b3647ca16c 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -23,7 +23,7 @@
 #include "hw/timer/aspeed_timer.h"
 #include "hw/rtc/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/misc/aspeed_hace.h"
 #include "hw/misc/aspeed_sbc.h"
diff --git a/include/hw/misc/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h
similarity index 100%
rename from include/hw/misc/aspeed_i3c.h
rename to include/hw/i3c/aspeed_i3c.h
diff --git a/hw/misc/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
similarity index 99%
rename from hw/misc/aspeed_i3c.c
rename to hw/i3c/aspeed_i3c.c
index ac6db214ee26..fff259ff665f 100644
--- a/hw/misc/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "hw/misc/aspeed_i3c.h"
+#include "hw/i3c/aspeed_i3c.h"
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/Kconfig b/hw/Kconfig
index b3ce1520a6b4..b3ed092f7a84 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -13,6 +13,7 @@ source fsi/Kconfig
 source gpio/Kconfig
 source hyperv/Kconfig
 source i2c/Kconfig
+source i3c/Kconfig
 source ide/Kconfig
 source input/Kconfig
 source intc/Kconfig
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737ee..8344b9769f7d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -545,6 +545,7 @@ config ASPEED_SOC
     select DS1338
     select FTGMAC100
     select I2C
+    select I3C
     select DPS310
     select PCA9552
     select PCA9554
diff --git a/hw/i3c/Kconfig b/hw/i3c/Kconfig
new file mode 100644
index 000000000000..e07fe445c655
--- /dev/null
+++ b/hw/i3c/Kconfig
@@ -0,0 +1,2 @@
+config I3C
+    bool
diff --git a/hw/i3c/meson.build b/hw/i3c/meson.build
new file mode 100644
index 000000000000..ebf20325cbac
--- /dev/null
+++ b/hw/i3c/meson.build
@@ -0,0 +1,3 @@
+i3c_ss = ss.source_set()
+i3c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i3c.c'))
+system_ss.add_all(when: 'CONFIG_I3C', if_true: i3c_ss)
diff --git a/hw/i3c/trace-events b/hw/i3c/trace-events
new file mode 100644
index 000000000000..3ead84eb456d
--- /dev/null
+++ b/hw/i3c/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# aspeed_i3c.c
+aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
+aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/hw/meson.build b/hw/meson.build
index 36da5322f7e4..ef65ba51950d 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -35,6 +35,7 @@ subdir('dma')
 subdir('gpio')
 subdir('hyperv')
 subdir('i2c')
+subdir('i3c')
 subdir('ide')
 subdir('input')
 subdir('intc')
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d304a984984a..96b6705b7d07 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -135,7 +135,6 @@ system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
-  'aspeed_i3c.c',
   'aspeed_lpc.c',
   'aspeed_ltpi.c',
   'aspeed_pwm.c',
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index d6af2fcf8527..b88accc437c9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -293,12 +293,6 @@ armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU wri
 # aspeed_xdma.c
 aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
-# aspeed_i3c.c
-aspeed_i3c_read(uint64_t offset, uint64_t data) "I3C read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_write(uint64_t offset, uint64_t data) "I3C write: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
-aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
-
 # aspeed_pwm.c
 aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRIx64 " data 0x%" PRIx64
 aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" PRIx64 " data 0x%" PRIx64
-- 
2.53.0


