Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D12CC6B3C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJWZ-0002Kb-Ld; Thu, 15 Oct 2026 07:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWY-0002J3-JQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJWV-00045J-LA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WmbF2rav6olts7r91nikWE5VNRBJjs1nM9Ql/qEIAzk=;
 b=H3nKjkHsHMcj7CJKbgvf3CXtkMASQOEclQZLbqkBgbrhqPaJk2RyFnFdRIPlKk4Du1FiyD
 0xC/YnRoz53wc4+vxfPcx+tWSlQg+LRVIcUyVHlTC/zua6TU7nmDQyW2Fu3TXQbxd5uIC8
 L+B0u+w3KBGJdtxDQnPgafsJBRYuopI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-TvMfxSBrN2e5UdyjGzfKAQ-1; Thu,
 15 Oct 2026 11:21:19 +0000
X-MC-Unique: TvMfxSBrN2e5UdyjGzfKAQ-1
X-Mimecast-MFC-AGG-ID: TvMfxSBrN2e5UdyjGzfKAQ_1792063278
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1824818011D5; Thu, 15 Oct 2026 11:21:18 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABDB41800677; Thu, 15 Oct 2026 11:21:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 07/21] util: introduce 'tldr',
 a system data recorder for crash handling
Date: Thu, 15 Oct 2026 12:20:30 +0100
Message-ID: <20261015112044.1999748-8-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Introduce a new subsystem "tldr" aka "thrifty live data recorder"
that will be able to continuously collect certain information at
runtime and dump that in a crash report when QEMU exits abnormally.
As a second use case, it will support manual triggering on interesting
events such as guest OS panic.

Initially the framework does nothing except print the signal
information. Later commits will introduce broader data collection.
This relies on the dummy siginfo_t struct for portability to Windows.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS                 |   8 +
 include/qemu/tldr.h         |  24 ++
 qapi/qom.json               |  15 ++
 qemu-options.hx             |  14 ++
 tests/unit/meson.build      |   1 +
 tests/unit/test-util-tldr.c | 105 +++++++++
 util/meson.build            |   1 +
 util/tldr-internal.h        |  21 ++
 util/tldr.c                 | 438 ++++++++++++++++++++++++++++++++++++
 9 files changed, 627 insertions(+)
 create mode 100644 include/qemu/tldr.h
 create mode 100644 tests/unit/test-util-tldr.c
 create mode 100644 util/tldr-internal.h
 create mode 100644 util/tldr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b5aafe43b1..4fa68810c1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4772,3 +4772,11 @@ Machine development tool
 M: Maksim Davydov <davydov-max@yandex-team.ru>
 S: Supported
 F: scripts/compare-machine-types.py
+
+Data Recorder
+M: Daniel P. Berrangé <berrange@redhat.com>
+S: Maintained
+F: util/tldr.c
+F: util/tldr-internal.h
+F: include/qemu/tldr.h
+F: tests/unit/test-util-tldr.c
diff --git a/include/qemu/tldr.h b/include/qemu/tldr.h
new file mode 100644
index 00000000000..67152b136b3
--- /dev/null
+++ b/include/qemu/tldr.h
@@ -0,0 +1,24 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * TL;DR: Thrifty Live Data Recorder
+ *
+ * Copyright (C) 2026 Red Hat Inc.
+ */
+
+#ifndef QEMU_TLDR_H__
+#define QEMU_TLDR_H__
+
+/**
+ * qtldr_crash_dump_signal:
+ * @si: signal information
+ *
+ * Print a crash dump in response to a signal.
+ *
+ * The crash will be printed to the configured crash
+ * file, if set. If opening the crash file fails, or
+ * no path is configured, STDERR will be used.
+ */
+void qtldr_crash_dump_signal(siginfo_t *si);
+
+#endif /* QEMU_TLDR_H__ */
diff --git a/qapi/qom.json b/qapi/qom.json
index 49f222796ab..1c9031fba9a 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1233,6 +1233,19 @@
   'data': { '*pretty': 'bool',
             '*close-action': 'MonitorQMPCloseAction' } }
 
+##
+# @QTLDRConfigProperties:
+#     Configuration for data recorder
+#
+# @crash-target: fully qualified path to perserve data recorder
+#                contents on QEMU crash
+#
+# Since: 11.2.0
+##
+{ 'struct': 'QTLDRConfigProperties',
+  'data': { '*crash-target': 'str' }
+}
+
 ##
 # @ObjectType:
 #
@@ -1302,6 +1315,7 @@
     's390-pv-guest',
     'tdx-guest',
     'throttle-group',
+    'tldr-config',
     'tls-creds-anon',
     'tls-creds-psk',
     'tls-creds-x509',
@@ -1379,6 +1393,7 @@
       'tdx-guest':                  'TdxGuestProperties',
       'thread-context':             'ThreadContextProperties',
       'throttle-group':             'ThrottleGroupProperties',
+      'tldr-config':                'QTLDRConfigProperties',
       'tls-creds-anon':             'TlsCredsAnonProperties',
       'tls-creds-psk':              'TlsCredsPskProperties',
       'tls-creds-x509':             'TlsCredsX509Properties',
diff --git a/qemu-options.hx b/qemu-options.hx
index 2f6863180b0..2f63d86b635 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6682,6 +6682,20 @@ SRST
         ::
 
             (qemu) qom-set /objects/iothread1 poll-max-ns 100000
+
+
+    ``-object tldr-config,id=id,crash-target=path``
+        Creating the ``tldr-config`` object enables the thrifty live data
+        recorder, which continuously captures important information about
+        the operation of the QEMU process. When a SIGSEGV, SIGBUS,
+        SIGILL, SIGFPE or SIGABRT are seen the contents of the data
+        recorder will be dumped to the stderr stream. If the
+        ``crash-target`` parameter was given, that specifies a fully
+        qualified file path to write the dump to instead of stderr.
+
+        The ``tldr-config`` object can be added at initial startup
+        or via QMP at runtime. Once created, however, it is not
+        permitted to disable it.
 ERST
 
 
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c1877..aa02895e767 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -136,6 +136,7 @@ if have_system
     'test-qmp-cmds': [testqapi],
     'test-xbzrle': [migration],
     'test-util-sockets': ['socket-helpers.c'],
+    'test-util-tldr': [],
     'test-base64': [],
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
diff --git a/tests/unit/test-util-tldr.c b/tests/unit/test-util-tldr.c
new file mode 100644
index 00000000000..4384e10cc18
--- /dev/null
+++ b/tests/unit/test-util-tldr.c
@@ -0,0 +1,105 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Tests for util/tldr.c
+ *
+ * Copyright 2026 Red Hat, Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "util/tldr-internal.h"
+
+typedef struct {
+    bool siginfo;
+    const char *data;
+} QTLDRTestData;
+
+#define TEST_SIGINFO_NULL \
+    QTLDR_DUMP_TRIGGER_PREFIX "manual\n"
+
+#define TEST_SIGINFO_SEGV \
+    QTLDR_DUMP_TRIGGER_PREFIX "\n" \
+    "  - Signal: SIGSEGV (11)\n" \
+    "  - Code: Address not mapped (1)\n" \
+    "  - Address: 0x87539319\n"
+
+
+static void
+test_tldr_one(QTLDRTestData *data)
+{
+    g_autofree char *tmpname = NULL;
+    int tmpfd;
+    char buf[1024];
+    ssize_t dumplen;
+
+    tmpfd = g_file_open_tmp("test-util-tldr-XXXXXX",
+                            &tmpname, NULL);
+    unlink(tmpname);
+
+    if (data->siginfo) {
+        siginfo_t si = {};
+        si.si_signo = 11; /*
+                           * SIGSEGV on Linux, but don't use constant
+                           * since expected output string hardcodes 11
+                           */
+        si.si_code = 1;
+        si.si_addr = (void *)0x87539319;
+        qtldr_crash_dump_internal(tmpfd, &si);
+    } else {
+        qtldr_crash_dump_internal(tmpfd, NULL);
+    }
+
+    lseek(tmpfd, 0, SEEK_SET);
+
+    dumplen = read(tmpfd, buf, sizeof(buf));
+
+    assert(dumplen > 0);
+    buf[dumplen] = '\0';
+
+    close(tmpfd);
+
+    g_assert_cmpstr(buf, ==, data->data);
+}
+
+
+static void
+test_tldr_minimal_default(void)
+{
+    QTLDRTestData data = {
+        .siginfo = false,
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+static void
+test_tldr_minimal_siginfo(void)
+{
+    QTLDRTestData data = {
+        .siginfo = true,
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_SEGV
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/util/tldr/minimal/default",
+                    test_tldr_minimal_default);
+    g_test_add_func("/util/tldr/minimal/siginfo",
+                    test_tldr_minimal_siginfo);
+
+    return g_test_run();
+}
diff --git a/util/meson.build b/util/meson.build
index fa174c07a57..00c2350c87e 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -66,6 +66,7 @@ util_ss.add(files('int128.c'))
 util_ss.add(files('memalign.c'))
 util_ss.add(files('interval-tree.c'))
 util_ss.add(files('lockcnt.c'))
+util_ss.add(files('tldr.c'))
 
 if have_system
   util_ss.add(files('crc-ccitt.c'))
diff --git a/util/tldr-internal.h b/util/tldr-internal.h
new file mode 100644
index 00000000000..193d8425eee
--- /dev/null
+++ b/util/tldr-internal.h
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * TL;DR: Thrifty Live Data Recorder
+ *
+ * Copyright (C) 2026 Red Hat Inc.
+ */
+
+#ifndef QEMU_TLDR_INTERNAL_H__
+#define QEMU_TLDR_INTERNAL_H__
+
+#include "qemu/tldr.h"
+
+#define QTLDR_DUMP_LEADER "\n🚨🚨🚨 QEMU Data Recorder Start 🚨🚨🚨\n"
+#define QTLDR_DUMP_TRAILER "\n🚨🚨🚨 QEMU Data Recorder End 🚨🚨🚨\n\n"
+#define QTLDR_DUMP_TRIGGER_PREFIX "\n🔍 Trigger:"
+#define QTLDR_DUMP_OPEN_ERROR "🔥 Unable to dump to '"
+
+void qtldr_crash_dump_internal(int fd, siginfo_t *si);
+
+#endif /* QEMU_TLDR_INTERNAL_H__ */
diff --git a/util/tldr.c b/util/tldr.c
new file mode 100644
index 00000000000..13e9881bc9b
--- /dev/null
+++ b/util/tldr.c
@@ -0,0 +1,438 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * TL;DR: Thrifty Live Data Recorder
+ *
+ * Copyright (C) 2026 Red Hat Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "util/tldr-internal.h"
+#include "qom/object.h"
+#include "qom/object_interfaces.h"
+#include "qapi/error.h"
+
+struct QTLDRConfig {
+    Object parent;
+
+    char *crash_target;
+};
+
+static int qtldr_active;
+static char *qtldr_crash_target;
+
+#define TYPE_QTLDR_CONFIG "tldr-config"
+
+OBJECT_DECLARE_SIMPLE_TYPE(QTLDRConfig, QTLDR_CONFIG);
+
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(QTLDRConfig,
+                                          qtldr_config,
+                                          QTLDR_CONFIG,
+                                          OBJECT,
+                                          { TYPE_USER_CREATABLE },
+                                          { NULL });
+
+
+static void
+qtldr_config_finalize(Object *obj)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(obj);
+
+    g_free(cfg->crash_target);
+}
+
+
+static char *
+qtldr_config_get_crash_target(Object *obj, Error **errp)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(obj);
+    return g_strdup(cfg->crash_target);
+}
+
+
+static void
+qtldr_config_set_crash_target(Object *obj, const char *path, Error **errp)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(obj);
+    g_free(cfg->crash_target);
+    cfg->crash_target = g_strdup(path);
+}
+
+
+static void
+qtldr_config_complete(UserCreatable *uc, Error **errp)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(uc);
+
+    /*
+     * Forbid changes, since once configured, we can't safely
+     * change it due to signal handlers running without ability
+     * to hold mutex locks
+     */
+    if (qtldr_crash_target) {
+        error_setg(errp, "TLDR configuration cannot be changed");
+        return;
+    }
+
+    qatomic_store_release(&qtldr_crash_target, g_strdup(cfg->crash_target));
+    qatomic_inc(&qtldr_active);
+}
+
+
+static bool
+qtldr_config_prepare_delete(UserCreatable *uc, Error **errp)
+{
+    /*
+     * Forbid deletion, since once configured, we can't safely
+     * change it due to signal handlers running without ability
+     * to hold mutex locks
+     */
+    error_setg(errp, "Deleting the 'tldr-config' object is not supported");
+    return false;
+}
+
+
+static void
+qtldr_config_class_init(ObjectClass *klass, const void *opaque)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(klass);
+    object_class_property_add_str(klass, "crash-target",
+                                  qtldr_config_get_crash_target,
+                                  qtldr_config_set_crash_target);
+
+    ucc->complete = qtldr_config_complete;
+    ucc->prepare_delete = qtldr_config_prepare_delete;
+}
+
+
+static void
+qtldr_config_init(Object *obj)
+{
+}
+
+
+/*
+ * WARNING: Code below this marker is used when dumping
+ * WARNING: the data recorder buffers. It is subject to
+ * WARNING: execution directly in signal handler context
+ * WARNING: on a limited stack (SIGSTKSZ).
+ *
+ * WARNING: Thus from here onwards must only use async
+ * WARNING: signal safe POSIX functions.
+ */
+
+
+static void
+qtldr_write_int_buf(int fd, uint64_t v,
+                    const char *digits, size_t digitslen,
+                    char *target, size_t targetlen)
+{
+    size_t offset = targetlen;
+    do {
+        uint64_t r = (v % digitslen);
+        target[--offset] = digits[r];
+        v /= digitslen;
+    } while (v && offset);
+    ignore_value(write(fd, target + offset, targetlen - offset));
+}
+
+
+static void
+qtldr_write_int_dec(int fd, uint64_t v)
+{
+    static char digits[] = "0123456789";
+    char target[20];
+    qtldr_write_int_buf(fd, v, digits, strlen(digits),
+                        target, G_N_ELEMENTS(target));
+}
+
+
+static void
+qtldr_write_int_hex(int fd, uint64_t v)
+{
+    static const char digits[] = "0123456789abcdef";
+    char target[16];
+    qtldr_write_int_buf(fd, v, digits, strlen(digits),
+                        target, G_N_ELEMENTS(target));
+}
+
+
+static const char *
+qtldr_crash_dump_signal_str(int signo)
+{
+    switch (signo) {
+    case SIGSEGV:
+        return "SIGSEGV";
+#ifndef WIN32
+    case SIGBUS:
+        return "SIGBUS";
+#endif
+    case SIGABRT:
+        return "SIGABRT";
+    case SIGILL:
+        return "SIGILL";
+    case SIGFPE:
+        return "SIGFPE";
+    }
+    return NULL;
+}
+
+
+static const char *
+qtldr_crash_dump_code_str(int signo, int code)
+{
+    switch (code) {
+#ifdef SI_USER
+    case SI_USER:
+        return "User process kill";
+#endif
+#ifdef SI_KERNEL
+    case SI_KERNEL:
+        return "Kernel process kill";
+#endif
+#ifdef SI_QUEUE
+    case SI_QUEUE:
+        return "Signal queue";
+#endif
+#ifdef SI_TIMER
+    case SI_TIMER:
+        return "Timer expired";
+#endif
+#ifdef SI_MESGQ
+    case SI_MESGQ:
+        return "Message queue state changed";
+#endif
+#ifdef SI_ASYNCIO
+    case SI_ASYNCIO:
+        return "AIO completed";
+#endif
+#ifdef SI_TKILL
+    case SI_TKILL:
+        return "User thread kill";
+#endif
+    }
+    switch (signo) {
+    case SIGSEGV:
+        switch (code) {
+#ifdef SEGV_MAPERR
+        case SEGV_MAPERR:
+            return "Address not mapped";
+#endif
+#ifdef SEGV_ACCERR
+        case SEGV_ACCERR:
+            return "Access permissions";
+#endif
+#ifdef SEGV_BNDERR
+        case SEGV_BNDERR:
+            return "Address out of bounds";
+#endif
+#ifdef SEGV_PKUERR
+        case SEGV_PKUERR:
+            return "Memory protection keys";
+#endif
+        }
+        break;
+
+#ifndef WIN32
+    case SIGBUS:
+        switch (code) {
+#ifdef BUS_ADRALN
+        case BUS_ADRALN:
+            return "Address alignment";
+#endif
+#ifdef BUS_ADDRER
+        case BUS_ADRERR:
+            return "Physical address error";
+#endif
+#ifdef BUS_OBJERR
+        case BUS_OBJERR:
+            return "Object hardware error";
+#endif
+#ifdef BUS_MCEERR_AR
+        case BUS_MCEERR_AR:
+            return "Memory error, machine check";
+#endif
+#ifdef BUS_MCEERR_AO
+        case BUS_MCEERR_AO:
+            return "Memory error, not consumed";
+#endif
+        }
+        break;
+#endif
+
+    case SIGILL:
+        switch (code) {
+#ifdef ILL_ILLOPC
+        case ILL_ILLOPC:
+            return "Illegal opcode";
+#endif
+#ifdef ILL_ILLOPN
+        case ILL_ILLOPN:
+            return "Illegal operand";
+#endif
+#ifdef ILL_ILLADR
+        case ILL_ILLADR:
+            return "Illegal addressing mode";
+#endif
+#ifdef ILL_ILLTRP
+        case ILL_ILLTRP:
+            return "Illegal trap";
+#endif
+#ifdef ILL_PRVOPC
+        case ILL_PRVOPC:
+            return "Privileged opcode";
+#endif
+#ifdef ILL_PRVREG
+        case ILL_PRVREG:
+            return "Privileged register";
+#endif
+#ifdef ILL_COPROC
+        case ILL_COPROC:
+            return "Coprocessor error";
+#endif
+#ifdef ILL_BADSTK
+        case ILL_BADSTK:
+            return "Internal stack error";
+#endif
+        }
+        break;
+
+    case SIGFPE:
+        switch (code) {
+#ifdef FPE_INTDIV
+        case FPE_INTDIV:
+            return "Integer divide by zero";
+#endif
+#ifdef FPE_INTOVF
+        case FPE_INTOVF:
+            return "Integer overflow";
+#endif
+#ifdef FPE_FLTDIV
+        case FPE_FLTDIV:
+            return "Floating-point divide by zero";
+#endif
+#ifdef FPE_FLTOVF
+        case FPE_FLTOVF:
+            return "Floating-point overflow";
+#endif
+#ifdef FPE_FLTUND
+        case FPE_FLTUND:
+            return "Floating-point underflow";
+#endif
+#ifdef FPE_FLTRES
+        case FPE_FLTRES:
+            return "Floating-point inexact result";
+#endif
+#ifdef FPE_FLTINV
+        case FPE_FLTINV:
+            return "Floating-point invalid operation";
+#endif
+#ifdef FPE_FLTSUB
+        case FPE_FLTSUB:
+            return "Subscript out of range";
+#endif
+        }
+        break;
+    }
+    return NULL;
+}
+
+
+static void
+qtldr_crash_dump_print_field(int fd, const char *label,
+                             const char *valstr, int val)
+{
+    ignore_value(write(fd, label, strlen(label)));
+    if (valstr) {
+        ignore_value(write(fd, valstr, strlen(valstr)));
+        ignore_value(write(fd, " (", 2));
+    }
+    qtldr_write_int_dec(fd, val);
+    if (valstr) {
+        ignore_value(write(fd, ")", 1));
+    }
+    ignore_value(write(fd, "\n", 1));
+}
+
+
+static void
+qtldr_crash_dump_print_siginfo(int fd, siginfo_t *si)
+{
+    const char *signostr = qtldr_crash_dump_signal_str(si->si_signo);
+    const char *codestr = qtldr_crash_dump_code_str(si->si_signo, si->si_code);
+    ignore_value(write(fd, QTLDR_DUMP_TRIGGER_PREFIX,
+                       strlen(QTLDR_DUMP_TRIGGER_PREFIX)));
+    ignore_value(write(fd, "\n", 1));
+
+    qtldr_crash_dump_print_field(fd, "  - Signal: ", signostr, si->si_signo);
+    qtldr_crash_dump_print_field(fd, "  - Code: ", codestr, si->si_code);
+
+    ignore_value(write(fd, "  - Address: 0x", 15));
+    qtldr_write_int_hex(fd, (uint64_t)si->si_addr);
+    ignore_value(write(fd, "\n", 1));
+}
+
+
+void
+qtldr_crash_dump_internal(int fd, siginfo_t *si)
+{
+    if (fd == -1) {
+        fd = STDERR_FILENO;
+    }
+
+    ignore_value(write(fd, QTLDR_DUMP_LEADER, strlen(QTLDR_DUMP_LEADER)));
+    if (si) {
+        qtldr_crash_dump_print_siginfo(fd, si);
+    } else {
+        ignore_value(write(fd, QTLDR_DUMP_TRIGGER_PREFIX,
+                           strlen(QTLDR_DUMP_TRIGGER_PREFIX)));
+        ignore_value(write(fd, "manual\n", 7));
+    }
+
+    ignore_value(write(fd, QTLDR_DUMP_TRAILER, strlen(QTLDR_DUMP_TRAILER)));
+}
+
+
+void
+qtldr_crash_dump_signal(siginfo_t *si)
+{
+    int fd = STDERR_FILENO;
+    const char *tgt;
+
+    if (!qatomic_read(&qtldr_active)) {
+        return;
+    }
+
+    tgt = qatomic_load_acquire(&qtldr_crash_target);
+    if (tgt) {
+        /*
+         * Must NOT use qemu_create, as it is not safe from
+         * signal handler context due to using monitor APIs
+         */
+        fd = open(tgt, O_WRONLY | O_CREAT | O_TRUNC, 0600);
+        if (fd < 0) {
+            /*
+             * Couldn't open our designated crash report
+             * file location, so fallback to STDERR as
+             * the least worst next best option, and
+             * warn the user of the failure
+             */
+            fd = STDERR_FILENO;
+            int saved_errno = errno;
+            ignore_value(write(fd, QTLDR_DUMP_OPEN_ERROR,
+                               strlen(QTLDR_DUMP_OPEN_ERROR)));
+            ignore_value(write(fd, tgt, strlen(tgt)));
+            ignore_value(write(fd, "': ", 3));
+            qtldr_write_int_dec(fd, saved_errno);
+            ignore_value(write(fd, "\n", 1));
+        }
+    }
+
+    qtldr_crash_dump_internal(fd, si);
+
+    if (fd != STDERR_FILENO) {
+        qemu_fdatasync(fd);
+        close(fd);
+    }
+}
-- 
2.56.0


