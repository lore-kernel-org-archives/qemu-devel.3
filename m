Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9326C4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 08:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWAz4-0003ar-R9; Sat, 03 Feb 2024 03:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz1-0003Zc-RS
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWAz0-00081A-40
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 03:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706947356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oC7K5HlKFwFUXM44ZBaLeMD9Kdajze8Vum+N13l6px8=;
 b=SnkVClDl5obvy2FL3tkOW1vj5DE8lXsu2ENOovay/dQhdjMR6b30mRcWA00Fbfd9i/qjX/
 e9i1NtnXUWl7FaD88yiFtpryIPPx1RNS/NCPxW6gE1428Ny0h+WRuAqywi8L5RMYFfkbVU
 pt4sQbIDx/0ayYoE38LiZbTxt1s/AJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-JPPspWEDMGSQo0Urq_316g-1; Sat, 03 Feb 2024 03:02:34 -0500
X-MC-Unique: JPPspWEDMGSQo0Urq_316g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1187F83106D;
 Sat,  3 Feb 2024 08:02:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC417492BE2;
 Sat,  3 Feb 2024 08:02:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1D4321E66CD; Sat,  3 Feb 2024 09:02:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com
Subject: [PATCH 1/4] chardev/parallel: Don't close stdin on inappropriate
 device
Date: Sat,  3 Feb 2024 09:02:25 +0100
Message-ID: <20240203080228.2766159-2-armbru@redhat.com>
In-Reply-To: <20240203080228.2766159-1-armbru@redhat.com>
References: <20240203080228.2766159-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The __linux__ version of qemu_chr_open_pp_fd() tries to claim the
parport device with a PPCLAIM ioctl().  On success, it stores the file
descriptor in the chardev object, and returns success.  On failure, it
closes the file descriptor, and returns failure.

chardev_new() then passes the Chardev to object_unref().  This duly
calls char_parallel_finalize(), which closes the file descriptor
stored in the chardev object.  Since qemu_chr_open_pp_fd() didn't
store it, it's still zero, so this closes standard input.  Ooopsie.

To demonstate, add a unit test.  With the bug above unfixed, running
this test closes standard input.  char_hotswap_test() happens to run
next.  It opens a socket, duly gets file descriptor 0, and since it
tests for success with > 0 instead of >= 0, it fails.

The test needs to be conditional exactly like the chardev it tests.
Since the condition is rather complicated, steal the solution from the
serial chardev: define HAVE_CHARDEV_PARALLEL in qemu/osdep.h.  This
also permits simplifying chardev/meson.build a bit.

The bug fix is easy enough: store the file descriptor, and leave
closing it to char_parallel_finalize().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/osdep.h    |  9 ++++++++-
 chardev/char-parallel.c |  7 +++++--
 tests/unit/test-char.c  | 21 +++++++++++++++++++++
 chardev/meson.build     |  4 +---
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index c9692cc314..3b0f3389d3 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -508,11 +508,18 @@ void qemu_anon_ram_free(void *ptr, size_t size);
 
 #ifdef _WIN32
 #define HAVE_CHARDEV_SERIAL 1
-#elif defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)    \
+#define HAVE_CHARDEV_PARALLEL 1
+#else
+#if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__)   \
     || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__) \
     || defined(__GLIBC__) || defined(__APPLE__)
 #define HAVE_CHARDEV_SERIAL 1
 #endif
+#if defined(__linux__) || defined(__FreeBSD__) \
+    || defined(__FreeBSD_kernel__) || defined(__DragonFly__)
+#define HAVE_CHARDEV_PARALLEL 1
+#endif
+#endif
 
 #if defined(__HAIKU__)
 #define SIGIO SIGPOLL
diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
index a5164f975a..78697d7522 100644
--- a/chardev/char-parallel.c
+++ b/chardev/char-parallel.c
@@ -164,13 +164,13 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
 {
     ParallelChardev *drv = PARALLEL_CHARDEV(chr);
 
+    drv->fd = fd;
+
     if (ioctl(fd, PPCLAIM) < 0) {
         error_setg_errno(errp, errno, "not a parallel port");
-        close(fd);
         return;
     }
 
-    drv->fd = fd;
     drv->mode = IEEE1284_MODE_COMPAT;
 }
 #endif /* __linux__ */
@@ -238,6 +238,7 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
 }
 #endif
 
+#ifdef HAVE_CHARDEV_PARALLEL
 static void qmp_chardev_open_parallel(Chardev *chr,
                                       ChardevBackend *backend,
                                       bool *be_opened,
@@ -306,3 +307,5 @@ static void register_types(void)
 }
 
 type_init(register_types);
+
+#endif  /* HAVE_CHARDEV_PARALLEL */
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 649fdf64e1..76946e6f90 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1203,6 +1203,24 @@ static void char_serial_test(void)
 }
 #endif
 
+#if defined(HAVE_CHARDEV_PARALLEL) && !defined(WIN32)
+static void char_parallel_test(void)
+{
+    QemuOpts *opts;
+    Chardev *chr;
+
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "parallel-id",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "parallel", &error_abort);
+    qemu_opt_set(opts, "path", "/dev/null", &error_abort);
+
+    chr = qemu_chr_new_from_opts(opts, NULL, NULL);
+    g_assert_null(chr);
+
+    qemu_opts_del(opts);
+}
+#endif
+
 #ifndef _WIN32
 static void char_file_fifo_test(void)
 {
@@ -1544,6 +1562,9 @@ int main(int argc, char **argv)
     g_test_add_func("/char/udp", char_udp_test);
 #if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
     g_test_add_func("/char/serial", char_serial_test);
+#endif
+#if defined(HAVE_CHARDEV_PARALLEL) && !defined(WIN32)
+    g_test_add_func("/char/parallel", char_parallel_test);
 #endif
     g_test_add_func("/char/hotswap", char_hotswap_test);
     g_test_add_func("/char/websocket", char_websock_test);
diff --git a/chardev/meson.build b/chardev/meson.build
index c80337d15f..b39028b7b0 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -21,11 +21,9 @@ if host_os == 'windows'
 else
   chardev_ss.add(files(
       'char-fd.c',
+        'char-parallel.c',
       'char-pty.c',
     ), util)
-  if host_os in ['linux', 'gnu/kfreebsd', 'freebsd', 'dragonfly']
-    chardev_ss.add(files('char-parallel.c'))
-  endif
 endif
 
 chardev_ss = chardev_ss.apply({})
-- 
2.43.0


