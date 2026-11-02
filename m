Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AAA606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZofvLoW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr7m-00087c-Kv; Mon, 02 Nov 2026 07:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7l-00087D-HC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7j-0001kV-Q7
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oQ5K+2MC48W5pl/92iAhFmEbrhJpMxjxZrqDt0kTVY=;
 b=LZofvLoWKNhjvftbyYC4oCLoY1TtTrp99vLl+5uDN6lqOhVzpQBoVEFeAJdLOMytuKAEYX
 VCMcsD2BMmKQuOD0V8uY5ae894LxB29/pAKkUAK5SIjkOQDZXkmX7LJfE7qyp+YsK2zXCX
 orUT4wBdvP23npKG60hE0Vcb2i3bJjs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-BOBhxM0nP1KLkIPu2a7QMQ-1; Mon,
 02 Nov 2026 07:26:49 -0500
X-MC-Unique: BOBhxM0nP1KLkIPu2a7QMQ-1
X-Mimecast-MFC-AGG-ID: BOBhxM0nP1KLkIPu2a7QMQ_1793622408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CBC2B1954219; Mon,  2 Nov 2026 12:26:48 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8742B1956087; Mon,  2 Nov 2026 12:26:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Filip Hejsek <filip.hejsek@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/13] treewide: use qemu_dup() instead of dup()
Date: Mon,  2 Nov 2026 12:26:33 +0000
Message-ID: <20261102122645.3353402-2-berrange@redhat.com>
In-Reply-To: <20261102122645.3353402-1-berrange@redhat.com>
References: <20261102122645.3353402-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Filip Hejsek <filip.hejsek@gmail.com>

Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.

The only direct users of dup() are now guest syscalls in the user
emulators and the implementation of qemu_dup() itself.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/virtio/virtio.c             | 2 +-
 io/channel-file.c              | 2 +-
 migration/cpr-exec.c           | 2 +-
 qemu-nbd.c                     | 2 +-
 system/vl.c                    | 9 +--------
 tests/qtest/bios-tables-test.c | 2 +-
 tests/unit/test-util-sockets.c | 6 +++---
 tests/unit/test-vmstate.c      | 2 +-
 ui/dmabuf.c                    | 2 +-
 9 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c9f9e5b5116..70779fbd564 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3204,7 +3204,7 @@ VirtioSharedMemoryMapping *virtio_shared_memory_mapping_new(uint8_t shmid,
         return NULL;
     }
 
-    fd = dup(fd);
+    fd = qemu_dup(fd);
     if (fd < 0) {
         error_report("Failed to duplicate fd: %s", strerror(errno));
         return NULL;
diff --git a/io/channel-file.c b/io/channel-file.c
index 4c9da6619b9..548a633be80 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -54,7 +54,7 @@ qio_channel_file_new_fd(int fd)
 QIOChannelFile *
 qio_channel_file_new_dupfd(int fd, Error **errp)
 {
-    int newfd = dup(fd);
+    int newfd = qemu_dup(fd);
 
     if (newfd < 0) {
         error_setg_errno(errp, errno, "Could not dup FD %d", fd);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index daa50916d23..2f38db30bb8 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -44,7 +44,7 @@ bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
     /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
-    int mfd = dup(fioc->fd);
+    int mfd = qemu_dup(fioc->fd);
     char val[16];
 
     /* Remember mfd in environment for post-exec load */
diff --git a/qemu-nbd.c b/qemu-nbd.c
index fcca88932a3..158906bcb20 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -976,7 +976,7 @@ int main(int argc, char **argv)
 
             /* Remember parent's stderr if we will be restoring it. */
             if (opts.verbose /* fork_process is set */) {
-                opts.old_stderr = dup(STDERR_FILENO);
+                opts.old_stderr = qemu_dup(STDERR_FILENO);
                 if (opts.old_stderr < 0) {
                     error_report("Could not dup original stderr: %s",
                                  strerror(errno));
diff --git a/system/vl.c b/system/vl.c
index fbe580746d3..8959b42442f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -614,14 +614,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
         return -1;
     }
 
-#ifdef F_DUPFD_CLOEXEC
-    dupfd = fcntl(fd, F_DUPFD_CLOEXEC, 0);
-#else
-    dupfd = dup(fd);
-    if (dupfd != -1) {
-        qemu_set_cloexec(dupfd);
-    }
-#endif
+    dupfd = qemu_dup(fd);
     if (dupfd == -1) {
         error_setg_errno(errp, errno, "error duplicating fd");
         return -1;
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f6dfa4131b8..c4838322fb1 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -529,7 +529,7 @@ static void test_acpi_asl(test_data *data)
                     const char *diff_cmd = diff_env ? diff_env : "diff -U 16";
                     char *diff = g_strdup_printf("%s %s %s", diff_cmd,
                                                  exp_sdt->asl_file, sdt->asl_file);
-                    int out = dup(STDOUT_FILENO);
+                    int out = qemu_dup(STDOUT_FILENO);
                     int ret G_GNUC_UNUSED;
                     int dupret;
 
diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sockets.c
index 006f5e579c6..c47ad6c82dc 100644
--- a/tests/unit/test-util-sockets.c
+++ b/tests/unit/test-util-sockets.c
@@ -62,7 +62,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
         error_setg(errp, "No fd named %s", fdname);
         return -1;
     }
-    return dup(mon_fd);
+    return qemu_dup(mon_fd);
 }
 
 /*
@@ -115,7 +115,7 @@ static void test_socket_fd_pass_name_bad(void)
 
     cur_mon = g_malloc(1); /* Fake a monitor */
     mon_fdname = "myfd";
-    mon_fd = dup(STDOUT_FILENO);
+    mon_fd = qemu_dup(STDOUT_FILENO);
     g_assert_cmpint(mon_fd, >, STDERR_FILENO);
 
     addr.type = SOCKET_ADDRESS_TYPE_FD;
@@ -189,7 +189,7 @@ static void test_socket_fd_pass_num_bad(void)
     int fd, sfd;
 
     g_assert(cur_mon == NULL);
-    sfd = dup(STDOUT_FILENO);
+    sfd = qemu_dup(STDOUT_FILENO);
 
     addr.type = SOCKET_ADDRESS_TYPE_FD;
     addr.u.fd.str = g_strdup_printf("%d", sfd);
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 23f31730703..57f1e3263fa 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -42,7 +42,7 @@ static QEMUFile *open_test_file(bool write)
     QIOChannel *ioc;
     QEMUFile *f;
 
-    fd = dup(temp_fd);
+    fd = qemu_dup(temp_fd);
     g_assert(fd >= 0);
     lseek(fd, 0, SEEK_SET);
     if (write) {
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index 497f82cc61f..6d5dffdf842 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
     assert(nfds >= dmabuf->num_planes);
 
     for (i = 0; i < dmabuf->num_planes; i++) {
-        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
+        fds[i] = dmabuf->fd[i] >= 0 ? qemu_dup(dmabuf->fd[i]) : -1;
     }
 }
 
-- 
2.56.0


