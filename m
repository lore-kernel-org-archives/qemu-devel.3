Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3F0E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 18:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVaQx-0003YT-Kd; Wed, 08 Jan 2025 13:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVaQv-0003YE-P2
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:05:34 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVaQq-0002PD-PF
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 13:05:33 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso16723566b.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736359526; x=1736964326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SwMr4fSmOj3kJ9Ya24/AHdSd7ci6Sdj2KKgonz0WcPE=;
 b=sdBmRgtlReFKtOoBftuhgl+gXZuXFRzjr3X8IZtAgvAcFThWOfEJqeOmVfVeiFYkz/
 SLGoOj3RaVzIEef2SD1V7qSf4YtIyO/tBLtEH1+7t0xnOiEvAcxDc+wcl44gfZSL9Q6K
 IodIpDQdj+6wkp5wET27L8J5nw5NA5ozhZdlsfQEQOmgTo8ztYPafn0TMhV0L8UdF6t+
 +a1t8bXtVgwCpkUxMgFeTwr3LG+ndsHqo5oBUaz31HdIAIirtb0cnnRMtEkRm7uGTaOb
 NoM6q4k33TcsLjj3H7NhU2seyUml8A26mkyVbG4gPFFOQMjMewm1FmXz4G6zX+KcyKKT
 uaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736359526; x=1736964326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SwMr4fSmOj3kJ9Ya24/AHdSd7ci6Sdj2KKgonz0WcPE=;
 b=Bj3gJX6TvHT0nbfMz2zAW3HRvGeE0CyfV4pJHm5QjPDEQ5rzzC7kxVOAzSu/cd/2I1
 PAybs4FBKaX+hgcyly2h6HBpsHJQC/btWRm2+W8nX8ajpeRg7oQy1wbC97zQq+kilOul
 rPxTlHTRxuPP+u8JIVPDPLSSch8ABfxZnf5T3/NLbhFRX0bu7CISZJr+1Xoa6oIehdKQ
 YQtX4Ev1lKO/P2TPTK6j3Mw7GusoxosY3K27Vg+7kX14iwbw5etFZ0qymTIdwjL/YyQV
 cABVEO/8CGloKaEPCQjk9J3Hb+LLF17XBQPkEp7vLA3Jn0aGFItcACIcyiHBiyuOv4dE
 r28w==
X-Gm-Message-State: AOJu0Yx/Kb1uqbMmRDlspZWm7MRyNUSlUzmOqQt5+0TQwG7T1/Ow/X/P
 Rzsb7EphhBmIVoofCAnagVQvA8IVp3Wdm+EF/QsFs7prddNERpZGVOBzYa/rSLQ=
X-Gm-Gg: ASbGncs+gGTqIKhZkiScu1Giw7mU3qc/bhwEWugwe7cfba5FzYAObQa4qcLqwnXZED3
 T5M5EoyhWLQYfFJ7xe0iXu8r4U7/nExWP9YGeBC2M32S4HW8TWsobR+fMl3w9IWZJ8seukz9/ou
 yedLc2jgZoUuOlYYCaFFbjJbvX/LXVjoP0H5Q34rFQK5HZRdgSEnzjdPbUDmmQEInKWeIO4xSzG
 rAGf5husKFGStsKBbzAH79cW17cIRdqauiaKePtkPlZKFyhsDCPF+Y=
X-Google-Smtp-Source: AGHT+IHY2PYIft/i+ku/Vk81a1crGrasBN/XiJfOVvph0vly98faLrmZ/fWbsSuMJOcXPl5lABsqEg==
X-Received: by 2002:a17:907:2d1e:b0:aa6:93c4:c685 with SMTP id
 a640c23a62f3a-ab2ab6bfe87mr299017066b.23.1736359526156; 
 Wed, 08 Jan 2025 10:05:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0efe4184sm2492970266b.119.2025.01.08.10.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 10:05:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 801D95F8AC;
 Wed,  8 Jan 2025 18:05:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] gdbstub: propagate Error to gdbserver_start (and other
 device setups)
Date: Wed,  8 Jan 2025 18:05:15 +0000
Message-Id: <20250108180515.1471177-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

This started as a clean-up to properly pass a Error handler to the
gdbserver_start so we could do the right thing for command line and
HMP invocations. To that end everything that used
foreach_device_config() and failed was also an immediate exit case so
I mechanically tweaked all the helper functions and simplified some.

Currently an RFC, I suspect we want to rename the foreach function to
something more pithy like foreach_device_config_or_exit().

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/exec/gdbstub.h |  8 +++-
 gdbstub/system.c       | 22 +++++-----
 gdbstub/user.c         | 20 +++++----
 linux-user/main.c      |  6 +--
 monitor/hmp-cmds.c     |  2 +-
 system/vl.c            | 98 ++++++++++++++++--------------------------
 6 files changed, 70 insertions(+), 86 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index d73f424f56..0675b0b646 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -49,12 +49,18 @@ void gdb_unregister_coprocessor_all(CPUState *cpu);
 /**
  * gdbserver_start: start the gdb server
  * @port_or_device: connection spec for gdb
+ * @errp: error handle
  *
  * For CONFIG_USER this is either a tcp port or a path to a fifo. For
  * system emulation you can use a full chardev spec for your gdbserver
  * port.
+ *
+ * The error handle should be either &error_fatal (for start-up) or
+ * &error_warn (for QMP/HMP initiated sessions).
+ *
+ * Returns true when server successfully started.
  */
-int gdbserver_start(const char *port_or_device);
+bool gdbserver_start(const char *port_or_device, Error **errp);
 
 /**
  * gdb_feature_builder_init() - Initialize GDBFeatureBuilder.
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2d9fdff2fe..8ce79fa88c 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -330,26 +330,27 @@ static void create_processes(GDBState *s)
     gdb_create_default_process(s);
 }
 
-int gdbserver_start(const char *device)
+bool gdbserver_start(const char *device, Error **errp)
 {
     Chardev *chr = NULL;
     Chardev *mon_chr;
     g_autoptr(GString) cs = g_string_new(device);
 
     if (!first_cpu) {
-        error_report("gdbstub: meaningless to attach gdb to a "
-                     "machine without any CPU.");
-        return -1;
+        error_setg(errp, "gdbstub: meaningless to attach gdb to a "
+                   "machine without any CPU.");
+        return false;
     }
 
     if (!gdb_supports_guest_debug()) {
-        error_report("gdbstub: current accelerator doesn't "
-                     "support guest debugging");
-        return -1;
+        error_setg(errp, "gdbstub: current accelerator doesn't "
+                   "support guest debugging");
+        return false;
     }
 
     if (cs->len == 0) {
-        return -1;
+        error_setg(errp, "gdbstub: missing connection string");
+        return false;
     }
 
     trace_gdbstub_op_start(cs->str);
@@ -374,7 +375,8 @@ int gdbserver_start(const char *device)
          */
         chr = qemu_chr_new_noreplay("gdb", cs->str, true, NULL);
         if (!chr) {
-            return -1;
+            error_setg(errp, "gdbstub: couldn't create chardev");
+            return false;
         }
     }
 
@@ -406,7 +408,7 @@ int gdbserver_start(const char *device)
     gdbserver_system_state.mon_chr = mon_chr;
     gdb_syscall_reset();
 
-    return 0;
+    return true;
 }
 
 static void register_types(void)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c48..fb8f6867ea 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -13,6 +13,7 @@
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/sockets.h"
+#include "qapi/error.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
@@ -372,15 +373,15 @@ static bool gdb_accept_tcp(int gdb_fd)
     return true;
 }
 
-static int gdbserver_open_port(int port)
+static int gdbserver_open_port(int port, Error **errp)
 {
     struct sockaddr_in sockaddr;
     int fd, ret;
 
     fd = socket(PF_INET, SOCK_STREAM, 0);
     if (fd < 0) {
-        perror("socket");
-        return -1;
+        error_setg(errp, "Failed to bind socket: %s", strerror(errno));
+        return false;
     }
     qemu_set_cloexec(fd);
 
@@ -405,31 +406,32 @@ static int gdbserver_open_port(int port)
     return fd;
 }
 
-int gdbserver_start(const char *port_or_path)
+bool gdbserver_start(const char *port_or_path, Error **errp)
 {
     int port = g_ascii_strtoull(port_or_path, NULL, 10);
     int gdb_fd;
 
     if (port > 0) {
-        gdb_fd = gdbserver_open_port(port);
+        gdb_fd = gdbserver_open_port(port, errp);
     } else {
         gdb_fd = gdbserver_open_socket(port_or_path);
     }
 
     if (gdb_fd < 0) {
-        return -1;
+        return false;
     }
 
     if (port > 0 && gdb_accept_tcp(gdb_fd)) {
-        return 0;
+        return true;
     } else if (gdb_accept_socket(gdb_fd)) {
         gdbserver_user_state.socket_path = g_strdup(port_or_path);
-        return 0;
+        return true;
     }
 
     /* gone wrong */
     close(gdb_fd);
-    return -1;
+    error_setg(errp, "gdbstub: failed to accept connection");
+    return false;
 }
 
 void gdbserver_fork_start(void)
diff --git a/linux-user/main.c b/linux-user/main.c
index b97634a32d..7198fa0986 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -1023,11 +1023,7 @@ int main(int argc, char **argv, char **envp)
     target_cpu_copy_regs(env, regs);
 
     if (gdbstub) {
-        if (gdbserver_start(gdbstub) < 0) {
-            fprintf(stderr, "qemu: could not open gdbserver on %s\n",
-                    gdbstub);
-            exit(EXIT_FAILURE);
-        }
+        gdbserver_start(gdbstub, &error_fatal);
         gdb_handlesig(cpu, 0, NULL, NULL, 0);
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 80b2e5ff9f..0aa22e1ae2 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -285,7 +285,7 @@ void hmp_gdbserver(Monitor *mon, const QDict *qdict)
         device = "tcp::" DEFAULT_GDBSTUB_PORT;
     }
 
-    if (gdbserver_start(device) < 0) {
+    if (!gdbserver_start(device, &error_warn)) {
         monitor_printf(mon, "Could not open gdbserver on device '%s'\n",
                        device);
     } else if (strcmp(device, "none") == 0) {
diff --git a/system/vl.c b/system/vl.c
index 0843b7ab49..1d2ca77b7f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -811,29 +811,13 @@ static void configure_msg(QemuOpts *opts)
 /***********************************************************/
 /* USB devices */
 
-static int usb_device_add(const char *devname)
+static bool usb_parse(const char *devname, Error **errp)
 {
-    USBDevice *dev = NULL;
-
-    if (!machine_usb(current_machine)) {
-        return -1;
-    }
-
-    dev = usbdevice_create(devname);
-    if (!dev)
-        return -1;
-
-    return 0;
-}
-
-static int usb_parse(const char *cmdline)
-{
-    int r;
-    r = usb_device_add(cmdline);
-    if (r < 0) {
-        error_report("could not add USB device '%s'", cmdline);
+    if (!usbdevice_create(devname)) {
+        error_setg(errp, "could not add USB device '%s'", devname);
+        return false;
     }
-    return r;
+    return true;
 }
 
 /***********************************************************/
@@ -1307,22 +1291,20 @@ static void add_device_config(int type, const char *cmdline)
     QTAILQ_INSERT_TAIL(&device_configs, conf, next);
 }
 
-static int foreach_device_config(int type, int (*func)(const char *cmdline))
+/*
+ * Run through the special device configs, any error will exit via error_fatal.
+ */
+static void foreach_device_config(int type, bool (*func)(const char *cmdline, Error **errp))
 {
     struct device_config *conf;
-    int rc;
 
     QTAILQ_FOREACH(conf, &device_configs, next) {
         if (conf->type != type)
             continue;
         loc_push_restore(&conf->loc);
-        rc = func(conf->cmdline);
+        func(conf->cmdline, &error_fatal);
         loc_pop(&conf->loc);
-        if (rc) {
-            return rc;
-        }
     }
-    return 0;
 }
 
 static void qemu_disable_default_devices(void)
@@ -1452,7 +1434,7 @@ static void qemu_create_default_devices(void)
     }
 }
 
-static int serial_parse(const char *devname)
+static bool serial_parse(const char *devname, Error **errp)
 {
     int index = num_serial_hds;
 
@@ -1467,13 +1449,13 @@ static int serial_parse(const char *devname)
 
         serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
         if (!serial_hds[index]) {
-            error_report("could not connect serial device"
-                         " to character backend '%s'", devname);
-            return -1;
+            error_setg(errp, "could not connect serial device"
+                       " to character backend '%s'", devname);
+            return false;
         }
     }
     num_serial_hds++;
-    return 0;
+    return true;
 }
 
 Chardev *serial_hd(int i)
@@ -1485,44 +1467,44 @@ Chardev *serial_hd(int i)
     return NULL;
 }
 
-static int parallel_parse(const char *devname)
+static bool parallel_parse(const char *devname, Error **errp)
 {
     static int index = 0;
     char label[32];
 
     if (strcmp(devname, "none") == 0)
-        return 0;
+        return true;
     if (index == MAX_PARALLEL_PORTS) {
-        error_report("too many parallel ports");
-        exit(1);
+        error_setg(errp, "too many parallel ports");
+        return false;
     }
     snprintf(label, sizeof(label), "parallel%d", index);
     parallel_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
     if (!parallel_hds[index]) {
-        error_report("could not connect parallel device"
-                     " to character backend '%s'", devname);
-        return -1;
+        error_setg(errp, "could not connect parallel device"
+                   " to character backend '%s'", devname);
+        return false;
     }
     index++;
-    return 0;
+    return true;
 }
 
-static int debugcon_parse(const char *devname)
+static bool debugcon_parse(const char *devname, Error **errp)
 {
     QemuOpts *opts;
 
     if (!qemu_chr_new_mux_mon("debugcon", devname, NULL)) {
-        error_report("invalid character backend '%s'", devname);
-        exit(1);
+        error_setg(errp, "invalid character backend '%s'", devname);
+        return false;
     }
     opts = qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, NULL);
     if (!opts) {
-        error_report("already have a debugcon device");
-        exit(1);
+        error_setg(errp, "already have a debugcon device");
+        return false;
     }
     qemu_opt_set(opts, "driver", "isa-debugcon", &error_abort);
     qemu_opt_set(opts, "chardev", "debugcon", &error_abort);
-    return 0;
+    return true;
 }
 
 static gint machine_class_cmp(gconstpointer a, gconstpointer b)
@@ -2044,12 +2026,10 @@ static void qemu_create_late_backends(void)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
-    if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
-        exit(1);
-    if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
-        exit(1);
+    /* failures here will exit via error_fatal */
+    foreach_device_config(DEV_SERIAL, serial_parse);
+    foreach_device_config(DEV_PARALLEL, parallel_parse);
+    foreach_device_config(DEV_DEBUGCON, debugcon_parse);
 
     /* now chardevs have been created we may have semihosting to connect */
     qemu_semihosting_chardev_init();
@@ -2668,10 +2648,9 @@ static void qemu_create_cli_devices(void)
     qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                       parse_fw_cfg, fw_cfg_find(), &error_fatal);
 
-    /* init USB devices */
+    /* init USB devices, failure will exit */
     if (machine_usb(current_machine)) {
-        if (foreach_device_config(DEV_USB, usb_parse) < 0)
-            exit(1);
+        foreach_device_config(DEV_USB, usb_parse);
     }
 
     /* init generic devices */
@@ -2718,10 +2697,9 @@ static bool qemu_machine_creation_done(Error **errp)
         exit(1);
     }
 
-    if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-        error_setg(errp, "could not start gdbserver");
-        return false;
-    }
+    /* failure will exit via error_fatal */
+    foreach_device_config(DEV_GDB, gdbserver_start);
+
     if (!vga_interface_created && !default_vga &&
         vga_interface_type != VGA_NONE) {
         warn_report("A -vga option was passed but this machine "
-- 
2.39.5


