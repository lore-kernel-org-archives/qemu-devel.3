Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791F2C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Qc-0001e7-He; Fri, 28 Aug 2026 16:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Qb-0001VV-Eo
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QY-0000Iq-FO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eoW7o2w3JwJ3/PKM3kaLrXOjzHuADU29Xw8e0B2gWQc=;
 b=BTj7b+9xJNLeF0Eb1hpzw3bJNirBaH9S3rHcQEM4aVz5vZBXoVctpGPbMqoemyhtogu3XM
 v9dJcjDgoFz/UJUDVFe8RAbvkmTu/69piB3m/jjhRoTawzj3EovnwU+VwyBNDvWKFQ9Ozl
 22dLtKUu3+KEqAVpY9t6r0C0vftoDII=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-0Ob0tm8COMqsk2YHk8nb0w-1; Fri,
 28 Aug 2026 16:43:49 -0400
X-MC-Unique: 0Ob0tm8COMqsk2YHk8nb0w-1
X-Mimecast-MFC-AGG-ID: 0Ob0tm8COMqsk2YHk8nb0w_1787949827
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ADE51944CE7; Fri, 28 Aug 2026 20:43:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B91FF18001CF; Fri, 28 Aug 2026 20:43:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:09 +0400
Subject: [GIT PULL 30/50] monitor: isolate HMP declarations in hmp.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-30-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Amit Shah <amit@kernel.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowangio@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=15946;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZxP2zuDU77QuYSgeDP8Q6OgGS3abQd+ghG/LNZ1fqlc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKV+TiBXIR4jlgcsWZeWMBsAT4CApvmu2jsA
 ftWJcS3GnCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5Rk/D/455eZoCiTR9S9WIn0xamX12ONzpRLrbFXzA5SfJEe542d5yawTFv1VjjY/ehGgKjTgefl
 q2Tpr3RpgG1TLjcOMVxnk7rcX6ATgKk97EI5qhrnwSz+7mVoh4yyvo5f8ZMv+UWzvrwyllAdm3r
 jK8Lm5QXVtkInMNJLinALKrL+aNyxQR8kt41NWu3BKclNOMkWpYrZUt1BFY8rWYQkNT8XKjUJY7
 bLqQzTsEjHeZZOrwACSqHyM/Niw8kF0pRPvS0z1e2gdxJcnnNn3E5pzW1E5Scw9/+Ad9fAAU9ES
 KF/SNdkBmNzgQrirb8VMfT4N9enbLoiY+kmHI4rPOzT920czgfU8oZ/A7X0Vp9DrEPSDuQYcdBO
 KWkSz7APd8gAIg4PEQ1qGuzWDwtNRPuynUUk6XkJgpxiL8nnh3wYN7Qy/CE5W537rvH+qqrYW73
 RBbRDQMuGuLWtp6JglPTbuzrCigYHto5n5OK/nfDBgvR8lgugyQKTqAxZdkX7X/moL9rt3DOPBU
 4YOAK0EJe4OSw57zmZF9K4OtBo7gPYpZ7K6kwLhB9pZ/bEAVDTz1OnGMh+mYPh6NEMpGr0ZpBZ4
 bVnYj/6Q0v8NIsq7zWdXhjrXW9kIFtEHOU2jevBQ1IWD7v7fYwJ5EtmHW590/WEw+fnAwkOdNKd
 JiEeBQ7dbCPsp3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Also rename password & commands with hmp in the name, while at it.
Other functions need larger changes which we will take care of next.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-30-9227de146347@redhat.com>
---
 accel/accel-system.c           |  1 +
 accel/tcg/monitor.c            |  1 +
 chardev/char.c                 |  2 +-
 disas/disas-mon.c              |  1 +
 gdbstub/system.c               |  2 +-
 hw/char/virtio-serial-bus.c    |  1 +
 hw/core/machine-hmp-cmds.c     |  1 -
 hw/core/sysbus.c               |  1 +
 hw/hexagon/hexagon_tlb.c       |  1 +
 hw/misc/auxbus.c               |  1 +
 hw/usb/bus.c                   |  1 +
 hw/usb/host-libusb.c           |  1 +
 hw/xen/xen-bus.c               |  1 +
 include/monitor/hmp.h          | 21 +++++++++++++++++++++
 include/monitor/monitor.h      | 18 ------------------
 monitor/hmp.c                  |  8 ++++----
 monitor/monitor-internal.h     |  1 +
 net/slirp.c                    |  1 +
 stubs/monitor-core.c           |  1 +
 stubs/monitor-internal.c       |  2 +-
 target/rx/disas.c              |  1 +
 tests/unit/test-util-sockets.c |  1 +
 tools/qemu-vnc/stubs.c         |  1 +
 trace/trace-hmp-cmds.c         |  1 -
 ui/ui-hmp-cmds.c               |  4 ++--
 util/error-report.c            |  2 +-
 util/qemu-print.c              |  1 +
 27 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 9176665202d2..977804c4048a 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -28,6 +28,7 @@
 #include "qom/compat-properties.h"
 #include "qapi/qapi-commands-accelerator.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index be5c1950177c..74170ddef708 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -11,6 +11,7 @@
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "internal-common.h"
diff --git a/chardev/char.c b/chardev/char.c
index c6c8133f5c1d..9da0911e503c 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "monitor/qmp-helpers.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/disas/disas-mon.c b/disas/disas-mon.c
index 9c693618c277..bc9dec3a7761 100644
--- a/disas/disas-mon.c
+++ b/disas/disas-mon.c
@@ -10,6 +10,7 @@
 #include "system/memory.h"
 #include "hw/core/cpu.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 /*
  * Get LENGTH bytes from info's buffer, at target address memaddr.
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 070bc26f416c..8a1cdb11db36 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -29,7 +29,7 @@
 #include "hw/core/boards.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "trace.h"
 #include "internals.h"
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248fc..02604740f86a 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "migration/qemu-file-types.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 686304bafab5..1c700aad3587 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
-#include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-accelerator.h"
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 3e1160ee921d..13df7cbafe10 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "system/address-spaces.h"
 
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent);
diff --git a/hw/hexagon/hexagon_tlb.c b/hw/hexagon/hexagon_tlb.c
index b6d4aff389e5..2d878cee736d 100644
--- a/hw/hexagon/hexagon_tlb.c
+++ b/hw/hexagon/hexagon_tlb.c
@@ -12,6 +12,7 @@
 #include "hw/core/resettable.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 877f34560626..ac2525b90fec 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -33,6 +33,7 @@
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qapi/error.h"
 
 #ifndef DEBUG_AUX
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 3b6fbd46ac3f..9b9b2e7c2f8f 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -9,6 +9,7 @@
 #include "system/system.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "trace.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b9f3ad3f66dd..af67d5dfeb10 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -48,6 +48,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index dfad2bc5085f..a563f6066bb4 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -17,6 +17,7 @@
 #include "hw/xen/xen-bus.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "system/system.h"
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bffb..166cd4100c63 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -18,6 +18,9 @@
 #include "qapi/qapi-types-common.h"
 #include "monitor/monitor.h"
 
+#define TYPE_MONITOR_HMP "monitor-hmp"
+OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
+
 #define HMP_STUB(cmd) \
     void hmp_##cmd(Monitor *mon, const QDict *qdict) \
     { \
@@ -30,6 +33,24 @@ struct MonitorDef {
     int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
 
+void monitor_new_hmp(const char *id, const char *chardev_id,
+                     bool use_readline, Error **errp);
+
+int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
+    G_GNUC_PRINTF(2, 0);
+int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
+void monitor_printc(Monitor *mon, int ch);
+
+void monitor_hmp_read_command(MonitorHMP *hmp, int show_prompt);
+int monitor_hmp_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
+                              void *opaque);
+
+void monitor_register_hmp(const char *name, bool info,
+                          void (*cmd)(Monitor *mon, const QDict *qdict));
+void monitor_register_hmp_info_hrt(const char *name,
+                                   HumanReadableText *(*handler)(Error **errp));
+
+
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 9f048ba103b5..72a8f6ea5b4f 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -10,9 +10,6 @@
 #define TYPE_MONITOR "monitor"
 OBJECT_DECLARE_TYPE(Monitor, MonitorClass, MONITOR);
 
-#define TYPE_MONITOR_HMP "monitor-hmp"
-OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
-
 #define TYPE_MONITOR_QMP "monitor-qmp"
 OBJECT_DECLARE_TYPE(MonitorQMP, MonitorQMPClass, MONITOR_QMP);
 
@@ -30,8 +27,6 @@ void monitor_init_globals_core(void);
 char *monitor_compat_id(void);
 void monitor_new_qmp(const char *id, const char *chardev_id,
                      bool pretty, Error **errp);
-void monitor_new_hmp(const char *id, const char *chardev_id,
-                     bool use_readline, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
@@ -43,28 +38,15 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
 int monitor_puts(Monitor *mon, const char *str);
-int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
-    G_GNUC_PRINTF(2, 0);
-int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
-void monitor_printc(Monitor *mon, int ch);
 void monitor_flush(Monitor *mon);
 int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
 
-void monitor_read_command(MonitorHMP *hmp, int show_prompt);
-int monitor_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
-                          void *opaque);
-
 AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags, Error **errp);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 
-void monitor_register_hmp(const char *name, bool info,
-                          void (*cmd)(Monitor *mon, const QDict *qdict));
-void monitor_register_hmp_info_hrt(const char *name,
-                                   HumanReadableText *(*handler)(Error **errp));
-
 #endif /* MONITOR_H */
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 8134dfaad4bb..b4d05d47c4bf 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -136,7 +136,7 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
     monitor_resume(&hmp->parent_obj);
 }
 
-void monitor_read_command(MonitorHMP *hmp, int show_prompt)
+void monitor_hmp_read_command(MonitorHMP *hmp, int show_prompt)
 {
     if (!hmp->rs) {
         return;
@@ -148,8 +148,8 @@ void monitor_read_command(MonitorHMP *hmp, int show_prompt)
     }
 }
 
-int monitor_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
-                          void *opaque)
+int monitor_hmp_read_password(MonitorHMP *hmp, ReadLineFunc *readline_func,
+                              void *opaque)
 {
     if (hmp->rs) {
         readline_start(hmp->rs, "Password: ", 1, readline_func, opaque);
@@ -1647,7 +1647,7 @@ static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
                                     monitor_readline_flush,
                                     hmp,
                                     monitor_find_completion);
-            monitor_read_command(hmp, 0);
+            monitor_hmp_read_command(hmp, 0);
         }
 
         qemu_chr_fe_set_handlers(&hmp->parent_obj.chr,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index fdeeeb853636..ee9ba0c8231e 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,6 +27,7 @@
 
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-types-control.h"
 #include "qapi/qapi-types-qom.h"
diff --git a/net/slirp.c b/net/slirp.c
index 517dd23be14b..9bf09a2c8bc9 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -36,6 +36,7 @@
 #include "clients.h"
 #include "hub.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
 #include <libslirp.h>
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index a7c32297c90a..b0c7002bd406 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qapi/qapi-emit-events.h"
 
 Monitor *monitor_cur(void)
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 731fad221ecc..6f69f1f14ae4 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
diff --git a/target/rx/disas.c b/target/rx/disas.c
index 67b932882914..0eb2ee6f4507 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
 #include "qemu/bitops.h"
+#include "monitor/hmp.h"
 #include "cpu.h"
 
 typedef struct DisasContext {
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index ab3f39c3efb5..b2a884529598 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "socket-helpers.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 static void test_fd_is_socket_bad(void)
 {
diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
index 1c82d8cff430..26597fefaa99 100644
--- a/tools/qemu-vnc/stubs.c
+++ b/tools/qemu-vnc/stubs.c
@@ -9,6 +9,7 @@
 #include "system/runstate.h"
 #include "hw/core/qdev.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "migration/vmstate.h"
 
 bool runstate_is_running(void)
diff --git a/trace/trace-hmp-cmds.c b/trace/trace-hmp-cmds.c
index 390173095cff..c8f0133abecf 100644
--- a/trace/trace-hmp-cmds.c
+++ b/trace/trace-hmp-cmds.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-#include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-trace.h"
 #include "qobject/qdict.h"
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 806a7bece7cb..4ef459490ba2 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -327,7 +327,7 @@ static void hmp_change_read_arg(void *opaque, const char *password,
                                 void *readline_opaque)
 {
     qmp_change_vnc_password(password, NULL);
-    monitor_read_command(opaque, 1);
+    monitor_hmp_read_command(opaque, 1);
 }
 
 void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
@@ -344,7 +344,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
     }
     if (!arg) {
         MonitorHMP *hmp = MONITOR_HMP(mon);
-        monitor_read_password(hmp, hmp_change_read_arg, NULL);
+        monitor_hmp_read_password(hmp, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
     }
diff --git a/util/error-report.c b/util/error-report.c
index f333af9249b9..aaa15bc79827 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qemu/error-report.h"
 
 /*
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 7b9591035e57..a2d1f0244168 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
+#include "monitor/hmp.h"
 #include "qemu/qemu-print.h"
 
 /*

-- 
2.55.0.543.g5ebe2ebe4ea8


