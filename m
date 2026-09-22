Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC44FC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96ya-00062n-ED; Tue, 22 Sep 2026 16:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xu-0004OS-Kf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96xr-00084a-Ft
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahtL8d/f5ccJKChY/SNUDX21P/8Lv41CXrtUhi0Z4yE=;
 b=jQCnBqyHbRLjjqo3KFHJ8Zo/CfetHJWxPsjeGSRD2GIgWoxbEuyejQI8Mr9S5IWphfnrK/
 RxO7pLh3abIPd2vypR7FT0p7J31IEqxCC3HHmzBvxdQc9s7UBecQEtU5aqH5F1xCL5wgng
 zQL2viLjeSFxu4aPQgnB6BKi/lyn5tQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117--d94FC3qOs6ee_vsLRwiHg-1; Tue,
 22 Sep 2026 16:19:39 -0400
X-MC-Unique: -d94FC3qOs6ee_vsLRwiHg-1
X-Mimecast-MFC-AGG-ID: -d94FC3qOs6ee_vsLRwiHg_1790108378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 837EA1955DC8; Tue, 22 Sep 2026 20:19:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87D561956095; Tue, 22 Sep 2026 20:19:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:15 +0400
Subject: [PATCH 08/88] block/monitor: capture x-qemu-io output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-8-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=15707;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E85hmf8j4i6epgOYHttBoGqQ6Fh4ArEKDkO29LWFxlA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKuq37pRNq9fF2dq+8Z7vVF+pl2Mt1EuAYtH
 bBFpvjZXIeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5ZgqEACdGPVW820WDse2U0lbIsGYPmH4P8+4uwoDr6J1DA1mg64NbAWFUDbWEisW8iH+eM9lyS/
 ESnX1U3C6R665cTjRUG/DnUOJoz0HaUOyQg4YYq1ed6xNuXFM03Hx+G4hi+6Wd9YCH0/V5DIBm0
 9U9DxZa52YVyTgYyzKXx2CumJ8pr6XRRhL0wVEwCXAUsNddBz7l1ruiXUUqbzqXf8Jqs3+ZVWio
 BQ7OBuhWPBSv5m7jiLIrQ9PvpOaJRDpymfIQdAtpbmw8DVxWahvvYKYFhBJV02KguGWqlUO0SdA
 yNn2jk0leOtIDGSolRt8/j9mVxPjRv9OLsRtaToG51Lik60KvAWftQ/q18vN0wn5u247CmWrsPF
 nMpfQG/lyye+B30p+wHeHK4ajvhWms/eDJMkGowl5LBlOpa3+sV/B7/3/jrrdtWE2PRsq2DBaEs
 Sn2HTRJAPS3WpnJvJH3ul2EznzLxj3+RG0nWcAcoPPWu1TwjbXI/hrxhikvHO5FzKWuTDs4uMQL
 Y2jhS2BxureH4u0uqVhz9+1jKO9Vvx9zWrnNPPIqOBqHWeU09rdL2a1wYlkRF76YWyqrwAzG1Fs
 FVf9XH9u543pZ0d2r4n3/PMPHqZcdWk+TIMsGiQYqOdGitcP2BA+kycum5B1nVU5KlRHGyWVeGc
 d17A1jeY6f5DAEw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Use a bare monitor to capture qemuio_command() printf output. Return it
as HumanReadableText.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 14 +++++---
 block/monitor/qmp-cmds.c       | 49 +++++++++++++++++++++++-----
 qapi/block.json                |  3 ++
 qemu-io-cmds.c                 | 74 ++++++++++++++++++++++--------------------
 system/qtest.c                 |  4 ++-
 tests/qemu-iotests/iotests.py  |  2 +-
 6 files changed, 95 insertions(+), 51 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7bae4d425c6d..ed071c0f4144 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -543,12 +543,18 @@ void hmp_qemu_io(MonitorHMP *hmp, const QDict *qdict)
     bool qdev = qdict_get_try_bool(qdict, "qdev", false);
     const char *device = qdict_get_str(qdict, "device");
     const char *command = qdict_get_str(qdict, "command");
+    g_autoptr(HumanReadableText) out = NULL;
     Error *err = NULL;
 
-    qmp_x_qemu_io(qdev ? NULL : device,
-                  qdev ? device : NULL,
-                  command, &err);
-    hmp_handle_error(hmp, err);
+    out = qmp_x_qemu_io(qdev ? NULL : device,
+                        qdev ? device : NULL,
+                        command, &err);
+    if (hmp_handle_error(hmp, err)) {
+        return;
+    }
+
+    /* use stdout and not monitor_puts() for compatiblity reasons */
+    printf("%s", out->human_readable_text);
 }
 
 static void print_block_info(MonitorHMP *hmp, BlockInfo *info,
diff --git a/block/monitor/qmp-cmds.c b/block/monitor/qmp-cmds.c
index e5759d824f13..4ea4d5985833 100644
--- a/block/monitor/qmp-cmds.c
+++ b/block/monitor/qmp-cmds.c
@@ -5,44 +5,51 @@
 #include "block/block_int.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/error.h"
+#include "qapi/type-helpers.h"
+#include "monitor/monitor.h"
 #include "qemu-io.h"
 
-void qmp_x_qemu_io(const char *device, const char *qdev,
-                   const char *command, Error **errp)
+HumanReadableText *qmp_x_qemu_io(const char *device, const char *qdev,
+                                 const char *command, Error **errp)
 {
+    ERRP_GUARD();
     BlockBackend *blk = NULL;
     BlockBackend *local_blk = NULL;
     BlockDriverState *bs = NULL;
-    int ret;
+    g_autoptr(Monitor) capture_mon = NULL;
+    g_autoptr(GString) str = NULL;
+    Monitor *old_mon = NULL;
+    HumanReadableText *ret = NULL;
+    int r;
 
     if (!device && !qdev) {
         error_setg(errp, "Must specify either device or qdev");
-        return;
+        return NULL;
     }
     if (qdev && device) {
         error_setg(errp, "Cannot specify both qdev and device");
-        return;
+        return NULL;
     }
 
     if (qdev) {
         blk = blk_by_qdev_id(qdev, errp);
         if (!blk) {
-            return;
+            return NULL;
         }
     } else {
         blk = blk_by_name(device);
         if (!blk) {
             bs = bdrv_lookup_bs(NULL, device, errp);
             if (!bs) {
-                return;
+                return NULL;
             }
         }
     }
 
     if (bs) {
         blk = local_blk = blk_new(bdrv_get_aio_context(bs), 0, BLK_PERM_ALL);
-        ret = blk_insert_bs(blk, bs, errp);
-        if (ret < 0) {
+        r = blk_insert_bs(blk, bs, errp);
+        if (r < 0) {
             goto fail;
         }
     }
@@ -72,8 +79,32 @@ void qmp_x_qemu_io(const char *device, const char *qdev,
      * extended, possibly resulting in a read-only guest device keeping write
      * permissions. Ugly, but it appears to be the lesser evil.
      */
+
+    /*
+     * qemuio_command() doesn't return structured output, so we need
+     * to capture the monitor output, use a bare monitor for that.
+     */
+    capture_mon = MONITOR(object_new(TYPE_MONITOR));
+    old_mon = monitor_set_cur(qemu_coroutine_self(), capture_mon);
+
     qemuio_command(blk, command, errp);
 
+    monitor_set_cur(qemu_coroutine_self(), old_mon);
+
+    if (*errp) {
+        goto fail;
+    }
+
+    str = monitor_steal_output(capture_mon);
+
+    /*
+     * monitor_puts_locked() adds \r before \n for terminal display;
+     * strip those from captured output
+     */
+    g_string_replace(str, "\r", "", 0);
+    ret = human_readable_text_from_str(str);
+
 fail:
     blk_unref(local_blk);
+    return ret;
 }
diff --git a/qapi/block.json b/qapi/block.json
index 012a9d73333b..da135f419386 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -618,6 +618,8 @@
 #
 # @command: the qemu-io command string to execute.
 #
+# Returns: qemu-io output as a string
+#
 # Features:
 #
 # @unstable: This command is for testing only.
@@ -635,5 +637,6 @@
   'data': { '*device': 'str',
             '*qdev': 'str',
             'command': 'str' },
+  'returns': 'HumanReadableText',
   'features': [ 'unstable' ],
   'allow-preconfig': true }
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index aa795fd87a14..28b810c25e58 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -17,6 +17,7 @@
 #include "block/block_int.h" /* for info_f() */
 #include "block/qapi.h"
 #include "qemu/error-report.h"
+#include "qemu/qemu-print.h"
 #include "qemu/main-loop.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
@@ -52,7 +53,7 @@ void qemuio_add_command(const cmdinfo_t *ci)
 
 void qemuio_command_usage(const cmdinfo_t *ci)
 {
-    printf("%s %s -- %s\n", ci->name, ci->args, ci->oneline);
+    qemu_printf("%s %s -- %s\n", ci->name, ci->args, ci->oneline);
 }
 
 static int init_check_command(BlockBackend *blk, const cmdinfo_t *ct,
@@ -453,19 +454,19 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
     for (i = 0, p = buffer; i < len; i += 16) {
         const uint8_t *s = p;
 
-        printf("%08" PRIx64 ":  ", offset + i);
+        qemu_printf("%08" PRIx64 ":  ", offset + i);
         for (j = 0; j < 16 && i + j < len; j++, p++) {
-            printf("%02x ", *p);
+            qemu_printf("%02x ", *p);
         }
-        printf(" ");
+        qemu_printf(" ");
         for (j = 0; j < 16 && i + j < len; j++, s++) {
             if (isalnum(*s)) {
-                printf("%c", *s);
+                qemu_printf("%c", *s);
             } else {
-                printf(".");
+                qemu_printf(".");
             }
         }
-        printf("\n");
+        qemu_printf("\n");
     }
 }
 
@@ -478,12 +479,12 @@ static void print_report(const char *op, struct timespec *t, int64_t offset,
     if (!Cflag) {
         cvtstr((double)total, s1, sizeof(s1));
         cvtstr(tdiv((double)total, *t), s2, sizeof(s2));
-        printf("%s %"PRId64"/%"PRId64" bytes at offset %" PRId64 "\n",
+        qemu_printf("%s %"PRId64"/%"PRId64" bytes at offset %" PRId64 "\n",
                op, total, count, offset);
-        printf("%s, %d ops; %s (%s/sec and %.4f ops/sec)\n",
+        qemu_printf("%s, %d ops; %s (%s/sec and %.4f ops/sec)\n",
                s1, cnt, ts, s2, tdiv((double)cnt, *t));
     } else {/* bytes,ops,time,bytes/sec,ops/sec */
-        printf("%"PRId64",%d,%s,%.3f,%.3f\n",
+        qemu_printf("%"PRId64",%d,%s,%.3f,%.3f\n",
             total, cnt, ts,
             tdiv((double)total, *t),
             tdiv((double)cnt, *t));
@@ -674,7 +675,7 @@ static int do_aio_writev(BlockBackend *blk, QEMUIOVector *qiov,
 
 static void read_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " reads a range of bytes from the given offset\n"
 "\n"
@@ -877,7 +878,7 @@ out:
 
 static void readv_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " reads a range of bytes from the given offset into multiple buffers\n"
 "\n"
@@ -1012,7 +1013,7 @@ out:
 
 static void write_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " writes a range of bytes from the given offset\n"
 "\n"
@@ -1239,7 +1240,7 @@ out:
 static void
 writev_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " writes a range of bytes from the given offset source from multiple buffers\n"
 "\n"
@@ -1449,7 +1450,7 @@ out:
 
 static void aio_read_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " asynchronously reads a range of bytes from the given offset\n"
 "\n"
@@ -1504,7 +1505,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
             }
             break;
         case 'i':
-            printf("injecting invalid read request\n");
+            qemu_printf("injecting invalid read request\n");
             block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_READ);
             g_free(ctx);
             return 0;
@@ -1558,7 +1559,7 @@ static int aio_read_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 
 static void aio_write_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " asynchronously writes a range of bytes from the given offset source\n"
 " from multiple buffers\n"
@@ -1629,7 +1630,7 @@ static int aio_write_f(BlockBackend *blk, int argc, char **argv, Error **errp)
             }
             break;
         case 'i':
-            printf("injecting invalid write request\n");
+            qemu_printf("injecting invalid write request\n");
             block_acct_invalid(blk_get_stats(blk), BLOCK_ACCT_WRITE);
             g_free(ctx);
             return 0;
@@ -1780,7 +1781,7 @@ static int zone_report_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         error_setg(errp, "zone report failed: %s", strerror(-ret));
     } else {
         for (int i = 0; i < nr_zones; ++i) {
-            printf("start: 0x%" PRIx64 ", len 0x%" PRIx64 ", "
+            qemu_printf("start: 0x%" PRIx64 ", len 0x%" PRIx64 ", "
                    "cap"" 0x%" PRIx64 ", wptr 0x%" PRIx64 ", "
                    "zcond:%u, [type: %u]\n",
                     tosector(zones[i].start), tosector(zones[i].length),
@@ -1986,7 +1987,7 @@ static int zone_append_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     }
 
     if (pflag) {
-        printf("After zap done, the append sector is 0x%" PRIx64 "\n",
+        qemu_printf("After zap done, the append sector is 0x%" PRIx64 "\n",
                tosector(offset));
     }
 
@@ -2072,7 +2073,7 @@ static int length_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     }
 
     cvtstr(size, s1, sizeof(s1));
-    printf("%s\n", s1);
+    qemu_printf("%s\n", s1);
     return 0;
 }
 
@@ -2098,10 +2099,10 @@ static int info_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bs->drv && bs->drv->format_name) {
-        printf("format name: %s\n", bs->drv->format_name);
+        qemu_printf("format name: %s\n", bs->drv->format_name);
     }
     if (bs->drv && bs->drv->protocol_name) {
-        printf("format name: %s\n", bs->drv->protocol_name);
+        qemu_printf("format name: %s\n", bs->drv->protocol_name);
     }
 
     ret = bdrv_get_info(bs, &bdi);
@@ -2112,8 +2113,8 @@ static int info_f(BlockBackend *blk, int argc, char **argv, Error **errp)
     cvtstr(bdi.cluster_size, s1, sizeof(s1));
     cvtstr(bdi.vm_state_offset, s2, sizeof(s2));
 
-    printf("cluster size: %s\n", s1);
-    printf("vm state offset: %s\n", s2);
+    qemu_printf("cluster size: %s\n", s1);
+    qemu_printf("vm state offset: %s\n", s2);
 
     spec_info = bdrv_get_specific_info(bs, errp);
     if (*errp) {
@@ -2140,7 +2141,7 @@ static const cmdinfo_t info_cmd = {
 
 static void discard_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " discards a range of bytes from the given offset\n"
 "\n"
@@ -2230,7 +2231,7 @@ static int discard_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 
 static void aio_discard_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " asynchronously discards a range of bytes from the given offset\n"
 "\n"
@@ -2388,7 +2389,7 @@ static int alloc_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 
     cvtstr(start, s1, sizeof(s1));
 
-    printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
+    qemu_printf("%"PRId64"/%"PRId64" bytes allocated at offset %s\n",
            sum_alloc, count, s1);
     return 0;
 }
@@ -2462,8 +2463,9 @@ static int map_f(BlockBackend *blk, int argc, char **argv, Error **errp)
         retstr = ret ? "    allocated" : "not allocated";
         cvtstr(num, s1, sizeof(s1));
         cvtstr(offset, s2, sizeof(s2));
-        printf("%s (0x%" PRIx64 ") bytes %s at offset %s (0x%" PRIx64 ")\n",
-               s1, num, retstr, s2, offset);
+        qemu_printf("%s (0x%" PRIx64 ") bytes %s"
+                    " at offset %s (0x%" PRIx64 ")\n",
+                    s1, num, retstr, s2, offset);
 
         offset += num;
         bytes -= num;
@@ -2483,7 +2485,7 @@ static const cmdinfo_t map_cmd = {
 
 static void reopen_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " Changes the open options of an already opened image\n"
 "\n"
@@ -2729,7 +2731,7 @@ static const cmdinfo_t abort_cmd = {
 
 static void sigraise_help(void)
 {
-    printf(
+    qemu_printf(
 "\n"
 " raises the given signal\n"
 "\n"
@@ -2819,12 +2821,12 @@ static const cmdinfo_t sleep_cmd = {
 
 static void help_oneline(const char *cmd, const cmdinfo_t *ct)
 {
-    printf("%s ", cmd);
+    qemu_printf("%s ", cmd);
 
     if (ct->args) {
-        printf("%s ", ct->args);
+        qemu_printf("%s ", ct->args);
     }
-    printf("-- %s\n", ct->oneline);
+    qemu_printf("-- %s\n", ct->oneline);
 }
 
 static void help_onecmd(const char *cmd, const cmdinfo_t *ct)
@@ -2842,7 +2844,7 @@ static void help_all(void)
     for (ct = cmdtab; ct < &cmdtab[ncmds]; ct++) {
         help_oneline(ct->name, ct);
     }
-    printf("\nUse 'help commandname' for extended help.\n");
+    qemu_printf("\nUse 'help commandname' for extended help.\n");
 }
 
 static int help_f(BlockBackend *blk, int argc, char **argv, Error **errp)
diff --git a/system/qtest.c b/system/qtest.c
index 47c954838dd0..e07c7acf34fc 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -801,13 +801,15 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
     } else if (strcmp(words[0], "qemu-io") == 0) {
         const char *io_dev;
         g_autofree char *io_cmd = NULL;
+        /* ignore multi-line output for now */
+        g_autoptr(HumanReadableText) out = NULL;
         Error *err = NULL;
 
         g_assert(words[1] && words[2]);
         io_dev = words[1];
         io_cmd = g_strjoinv(" ", &words[2]);
 
-        qmp_x_qemu_io(io_dev, NULL, io_cmd, &err);
+        out = qmp_x_qemu_io(io_dev, NULL, io_cmd, &err);
         qtest_sendf(chr, err ? "FAIL %s\n" : "OK\n",
                     err ? error_get_pretty(err) : NULL);
         error_free(err);
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7d5a77a85e58..445a22a8659a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -965,7 +965,7 @@ def qmp_qemu_io(self, drive: str, cmd: str,
             res = self.qmp_log('x-qemu-io', **kwargs)
         else:
             res = self.qmp('x-qemu-io', **kwargs)
-        return res.get('error', {}).get('desc', '')
+        return res.get('return', {}).get('human-readable-text', '')
 
     def flatten_qmp_object(self, obj, output=None, basestr=''):
         if output is None:

-- 
2.56.0.rc0.29.g47ce80527c56


