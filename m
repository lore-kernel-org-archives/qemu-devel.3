Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8252C27C65
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgd2-0005dT-QE; Mon, 10 Jun 2024 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgd1-0005cs-3l
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:11 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgcz-0006Xp-E9
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:10 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f275c7286so683199f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718032087; x=1718636887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXqCJDK1XRCqnAP9Ne+ASEPrZvUZL26UbajQQQFWIgo=;
 b=SjPyOeaQk1v+35t0ezHh8qgQz5ZBZLrcAEuwGcoNRiRRqBVibElI85yx2tACyixRGh
 ynoMqT3INzsRjfthkao+7pY+4egihCvpyx21cmb21xfG51fpPHZK4nC7k5nurUlwr/Yy
 i07RQWFhar+8d/hDWSIu/B++e5Sv+8jGpbwNtKixC1UPHb6LtQb0EJOaDotkbPqqBH5n
 AvDMcYBb8wU5HLBjMxlyX4LnE+FsXJcfue0057ew6VIfWQeYwFIDKMXKXPgrI4Z7SIcx
 hJZPgpn0mjBi6uNNNQrtyVNoflHlmq/eduadxQb8rMPi8SGuuDsfOn0qjhxQ0E30/CzZ
 57uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032087; x=1718636887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXqCJDK1XRCqnAP9Ne+ASEPrZvUZL26UbajQQQFWIgo=;
 b=Yrv1/PlXKONgyEiJocXapDXqoPbto1MKm/QATcKxDgwTfgX10jTV/22pDI4VEOuKW7
 +UwFiP3uCU+MqdsmabgWFpP88+MCs502TldT0qCzBUY6DDFm2mjfK0mU+CnBEvOe5WJK
 0XEQ9V/IjCUus/rMLi+ax/Spo5G0k34/Y2Vy30c5Ccbfo7J7jnVSSyo94OPPqncbcdOR
 QQU9crEgdLDoPFuvLKDWyZbeerjmGVuiJJp26CeujJg7wpaF554FW5yPeoDaWMhgoyWP
 he2d3FXmgd3YM30WDJ1bkA4zyRPVmOkBaZFpiw2MPQaKnxQuXexGoHQE0lBObCg6UKBx
 3cUA==
X-Gm-Message-State: AOJu0Yy8ZRXTbh9DJqti1MoniFCyBybKLg+7HwpdeBtet8t+fZZegdta
 Q+IDNj4uBvwgVZAhvrQl5isrqFwumY1fp5vIlL1MYmNMzThXqsrtINGC5+sPLAuQ17KezkWiQEq
 L
X-Google-Smtp-Source: AGHT+IFBecK9ACy/aQIlA8FzSuqSdVTEted6hhPlRfDWKOih0CaZA2isALWmbuDgBFgt1dtkzkkRZw==
X-Received: by 2002:a5d:64c8:0:b0:35f:2092:39fd with SMTP id
 ffacd0b85a97d-35f20923acdmr3979515f8f.36.1718032087265; 
 Mon, 10 Jun 2024 08:08:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f08b280d0sm8525697f8f.86.2024.06.10.08.08.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 08:08:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] hw/misc/mos6522: Expose x-query-mos6522-devices QMP
 command
Date: Mon, 10 Jun 2024 17:07:57 +0200
Message-ID: <20240610150758.2827-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610150758.2827-1-philmd@linaro.org>
References: <20240610150758.2827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is a counterpart to the HMP "info via" command. It is being
added with an "x-" prefix because this QMP command is intended as an
adhoc debugging tool and will thus not be modelled in QAPI as fully
structured data, nor will it have long term guaranteed stability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS             |  2 +-
 qapi/machine.json       | 17 +++++++++++++++++
 hw/misc/mos6522-stubs.c | 18 ++++++++++++++++++
 hw/misc/mos6522.c       |  5 +++--
 hw/misc/meson.build     |  3 ++-
 5 files changed, 41 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/mos6522-stubs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 951556224a..e86638c68c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1453,7 +1453,7 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
-F: hw/misc/mos6522.c
+F: hw/misc/mos6522*.c
 F: hw/nvram/mac_nvram.c
 F: hw/ppc/fw_cfg.c
 F: hw/input/adb*
diff --git a/qapi/machine.json b/qapi/machine.json
index 1283d14493..a82b8dd39d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1865,6 +1865,23 @@
   'data': { 'filename': 'str' },
   'if': 'CONFIG_FDT' }
 
+##
+# @x-query-mos6522-devices:
+#
+# Query information on MOS6522 VIA devices
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: MOS6522 VIA devices information
+#
+# Since: 9.1
+##
+{ 'command': 'x-query-mos6522-devices',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ]}
+
 ##
 # @x-query-interrupt-controllers:
 #
diff --git a/hw/misc/mos6522-stubs.c b/hw/misc/mos6522-stubs.c
new file mode 100644
index 0000000000..c953f01a16
--- /dev/null
+++ b/hw/misc/mos6522-stubs.c
@@ -0,0 +1,18 @@
+/*
+ * QEMU MOS6522 VIA stubs
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+
+HumanReadableText *qmp_x_query_mos6522_devices(Error **errp)
+{
+    error_setg(errp, "Support for MOS6522 VIA devices not built-in");
+
+    return NULL;
+}
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 515f62e687..b1bb7f54f0 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -31,6 +31,7 @@
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
 #include "qemu/timer.h"
 #include "qemu/cutils.h"
@@ -576,7 +577,7 @@ static int qmp_x_query_via_foreach(Object *obj, void *opaque)
     return 0;
 }
 
-static HumanReadableText *qmp_x_query_via(Error **errp)
+HumanReadableText *qmp_x_query_mos6522_devices(Error **errp)
 {
     g_autoptr(GString) buf = g_string_new("");
 
@@ -589,7 +590,7 @@ static HumanReadableText *qmp_x_query_via(Error **errp)
 void hmp_info_via(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
-    g_autoptr(HumanReadableText) info = qmp_x_query_via(&err);
+    g_autoptr(HumanReadableText) info = qmp_x_query_mos6522_devices(&err);
 
     if (hmp_handle_error(mon, err)) {
         return;
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 86596a3888..9fa0e98794 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -18,7 +18,8 @@ system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
-system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'),
+                                      if_false: files('mos6522-stubs.c'))
 system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
-- 
2.41.0


