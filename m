Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A8109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cP8-0000Bx-37; Fri, 20 Mar 2026 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOg-0008W9-Ot
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOe-0008Sz-5n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:26 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so2822015f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022902; x=1774627702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1etCwO8aK08qpLcIJ497JKqocrRfF8wFd5a8chIrRs=;
 b=pSTGD1CFKAJhkrEF0BTY5LUH/CRwqhoyB1Qjqep9PHahp+hELi/yNGufOUKaEeS6bP
 t42onDqZjLUZkTSC1TrK1UXCfDxipG8IXaN1ncP388DmU1odP2enO4ZpO6wzB5uQNho+
 diZtFRSMYuNmvj/HtzkWBkemkfALuuN0HLrQkuXdCKCzFGKkPnZn+XWrVhEfWRHJTWRB
 OMgCU8+vzoKm7J1ZMuWX/8IxsIpL9T3Rd/QK8W8h8waeNYsLZv4IQ2RFsQkn37WrMPx6
 SbORc4FZ0sv6BR2zJcBBt/vyfFUWNiLOGvv1IhxYwXEY9+JFgX5aTKaSgH6aqQNBwCkX
 bknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022902; x=1774627702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1etCwO8aK08qpLcIJ497JKqocrRfF8wFd5a8chIrRs=;
 b=fZI7NcoCBDQ4s8faoWzXc0SKVsMV6x8HNhrBw/74HEqE4+MTBMezXd7zYjIKDaGb5f
 S0u1HPZm8o9vn+jPxPHYavflQtrpQb4fEYilYkGxDdIYFJyHfgHpVBph0GPDXfh9zd/r
 FS/1i8zTcEdBZVdqICEagp+Utcc6smq3I9BnQGaxfk/+ycAkNt0CNYeI3nKcsLzd64Kc
 WbKFcYNo/yo/cm5Kj4y7hWFQvvROIqFsnOGVT6a0q4039riPoxQ+I4JU9IaliOjUs5jz
 gaRJn1E3bUyTOB/g4swiaEKuwi/oZNRqeKgGXKv66kbKzGYlmCa/4hcUBQcGHwtAw/0A
 g5yA==
X-Gm-Message-State: AOJu0YzUVZAw5s0873U/d2zj84LABwXmvhR6EY4n88fYM9GxLzrYsSnB
 Y4ICpHgB9OWcVXp/oG6AC8cXcMt2iWy4frKnbY9ws88yI4iMnXOlNum/4cp1HUOR4jU6B54Ey12
 4HKBhT9Q=
X-Gm-Gg: ATEYQzzC6+1eOVbHcH2UJpqzbbGHQgFOeTBoJjtqLegcwMaSiITiJbf+G22TV1HmWRt
 Ql/7CzAJGKeHe2CZFD/4AGs/29cMsXFq/1qUNtdVk96pPa2Nh6ubGsDpsy5SSb64z8QcFnU0PiH
 TAprR+5iN29jTPFKT5nUwZ3ePgWS6JDH3yYqqeO/1VyLhyfv1MBp/4jqxadV53Ik3FNhVoNoNSj
 wLKCerl28aaAegJ5gl0bwjzzRJoU/9y18hqZXX9F4WGSSct626IES1P2u+35bYPSNoh93ISDTbm
 Ieda5f2YzHKz8ed63wXu/iyrw8cuaXr7Hf9tDr2OACmKXUyd1uDPAnLivCW04cIcLn6h7qeKRPM
 4QWM8WixVVY8rf4ggOq+UrUa9fNYgQ/lBX76fqOmDlfLkc3M0GEs3nDy0F6dZEQx1trHTfeaDkH
 SVOB3TSqevXwGqjcF6WwjLd+VoISVpnsLGCTvB/XTQ0tJWNGVuDjQMqrY62ycCdZX/7YTEgZEk
X-Received: by 2002:a05:6000:2408:b0:43b:5003:e301 with SMTP id
 ffacd0b85a97d-43b642796afmr6789339f8f.42.1774022901665; 
 Fri, 20 Mar 2026 09:08:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644addfbsm7803368f8f.3.2026.03.20.09.08.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH-for-11.1 01/10] monitor: Extract completion declarations to
 'monitor/hmp-completion.h'
Date: Fri, 20 Mar 2026 17:08:01 +0100
Message-ID: <20260320160811.28611-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Many files include "monitor/hmp.h", but few of them really need
the completion declarations: move them to a distinct header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                      |  1 +
 include/monitor/hmp-completion.h | 40 ++++++++++++++++++++++++++++++++
 include/monitor/hmp.h            | 21 -----------------
 chardev/char-hmp-cmds.c          |  1 +
 migration/migration-hmp-cmds.c   |  1 +
 monitor/hmp-target.c             |  1 +
 net/net-hmp-cmds.c               |  1 +
 qom/qom-hmp-cmds.c               |  1 +
 system/qdev-monitor.c            |  1 +
 system/runstate-hmp-cmds.c       |  1 +
 trace/trace-hmp-cmds.c           |  1 +
 ui/ui-hmp-cmds.c                 |  1 +
 12 files changed, 50 insertions(+), 21 deletions(-)
 create mode 100644 include/monitor/hmp-completion.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 48976138be7..969c3601beb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3409,6 +3409,7 @@ F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp.h
+F: include/monitor/hmp-completion.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
diff --git a/include/monitor/hmp-completion.h b/include/monitor/hmp-completion.h
new file mode 100644
index 00000000000..dab21867dc9
--- /dev/null
+++ b/include/monitor/hmp-completion.h
@@ -0,0 +1,40 @@
+/*
+ * Human Monitor Completion handlers
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HMP_COMPLETION_H
+#define HMP_COMPLETION_H
+
+#include "qemu/readline.h"
+
+void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void device_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void sendkey_completion(ReadLineState *rs, int nb_args, const char *str);
+void chardev_remove_completion(ReadLineState *rs, int nb_args, const char *str);
+void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void set_link_completion(ReadLineState *rs, int nb_args, const char *str);
+void netdev_add_completion(ReadLineState *rs, int nb_args, const char *str);
+void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str);
+void ringbuf_write_completion(ReadLineState *rs, int nb_args, const char *str);
+void info_trace_events_completion(ReadLineState *rs, int nb_args,
+                                  const char *str);
+void trace_event_completion(ReadLineState *rs, int nb_args, const char *str);
+void watchdog_action_completion(ReadLineState *rs, int nb_args,
+                                const char *str);
+void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
+                                       const char *str);
+void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
+                                      const char *str);
+void delvm_completion(ReadLineState *rs, int nb_args, const char *str);
+void loadvm_completion(ReadLineState *rs, int nb_args, const char *str);
+
+#endif
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 26571d35e84..f17a50a3fed 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -126,27 +126,6 @@ void hmp_vhost_queue_status(Monitor *mon, const QDict *qdict);
 void hmp_virtio_queue_element(Monitor *mon, const QDict *qdict);
 void hmp_xen_event_inject(Monitor *mon, const QDict *qdict);
 void hmp_xen_event_list(Monitor *mon, const QDict *qdict);
-void object_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void object_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void device_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void device_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void sendkey_completion(ReadLineState *rs, int nb_args, const char *str);
-void chardev_remove_completion(ReadLineState *rs, int nb_args, const char *str);
-void chardev_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void set_link_completion(ReadLineState *rs, int nb_args, const char *str);
-void netdev_add_completion(ReadLineState *rs, int nb_args, const char *str);
-void netdev_del_completion(ReadLineState *rs, int nb_args, const char *str);
-void ringbuf_write_completion(ReadLineState *rs, int nb_args, const char *str);
-void info_trace_events_completion(ReadLineState *rs, int nb_args, const char *str);
-void trace_event_completion(ReadLineState *rs, int nb_args, const char *str);
-void watchdog_action_completion(ReadLineState *rs, int nb_args,
-                                const char *str);
-void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
-                                       const char *str);
-void migrate_set_parameter_completion(ReadLineState *rs, int nb_args,
-                                      const char *str);
-void delvm_completion(ReadLineState *rs, int nb_args, const char *str);
-void loadvm_completion(ReadLineState *rs, int nb_args, const char *str);
 void hmp_rocker(Monitor *mon, const QDict *qdict);
 void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
diff --git a/chardev/char-hmp-cmds.c b/chardev/char-hmp-cmds.c
index 8e9e1c1c021..f377e00b699 100644
--- a/chardev/char-hmp-cmds.c
+++ b/chardev/char-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "chardev/char.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-char.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 0a193b8f54a..d5712d11b8c 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -17,6 +17,7 @@
 #include "block/qapi.h"
 #include "migration/snapshot.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 2574c5d8b4b..d07e545ef7e 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -28,6 +28,7 @@
 #include "net/slirp.h"
 #include "system/device_tree.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index e7c55d27876..2b24c9e6049 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "migration/misc.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "net/hub.h"
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 32e40630c96..47110ca58c0 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/qdev.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qom.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1ac6d9a8575..2ed95e83602 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/sysbus.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
 #include "system/arch_init.h"
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index be1d6769926..02d1d42bf39 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "exec/cpu-common.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 45f4335ff5d..390173095cf 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 6c93d452c9c..1e9bc77bd80 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -18,6 +18,7 @@
 #include <spice/enums.h>
 #endif
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
-- 
2.53.0


