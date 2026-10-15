Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6830ACC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 01:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHANL-0004uS-7i; Wed, 14 Oct 2026 21:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHANK-0004u7-Au
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:35:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xHANI-0006iN-6r
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 21:35:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so45829815e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792028114; x=1792632914; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zejBekxOni4WocrkxdwEKQRh9tIW6r1ZHbwc0YpcKh0=;
 b=jJJSNknkbuJU35IYxBr0fFiW94hkYfsqrR+xfnXD7J5lrA6bMc2viFh9cuwsusq3LF
 vRlUiZ4WmrL0hgms0D/Mvs8tH5G5B2cfFMEnPA9Ia1I5TefamJgYGEWFk4g4l+fxg+1G
 peONVXWzkiHjOpyzE8dU4PHYESBGMapbWhNYM1Co2GO+9mYgux05DP8DAf21sMTQzzzk
 P20i9g7SNDMjh7nLX8nm2uetl5fWE4RpyM4naNU7iwSc0zNeJeRawdMzkMsJ74uWanDR
 nAlfHbgf51thLiuZgXPyc0dw24mmkpfVSMpfZrm/YQWtO3DSn01iRlb0+UEku4tsmZAn
 uYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792028114; x=1792632914;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zejBekxOni4WocrkxdwEKQRh9tIW6r1ZHbwc0YpcKh0=;
 b=Rkqz9Xxs1va1jT/QoLmZ4mFqRnGkLaulHVSItMEff2l6/FRf65ERgXL8mUCD6FAyFz
 ZTqDCqN+WTlWfLqoarA1P6Zs8+DxagvkiHaKqbjNYLS/nuryiiAE5osgblSMO1vvMXfN
 VPfxMqjPPfwqXjJf7sXSpuuxjd13Y8uYJd59SwVhitS3iWQzfCMWw4CPy3+PTCE6/6bB
 f7w9vgSNFrhzR47J24RThBx9ZkWQGAdFDD9MeZLQUxChylRHLaWLdA9pSksg1keBF2KP
 SnTmF6UnoFlxwn+Eyxjy4VGotOLGeZpXNK5dlF8aawpjOYBtpPp0s7CbpRSyN9Y0kdhN
 Kf8Q==
X-Gm-Message-State: AFq9FYKexFJQ0u8501FJBVfO+FMY/mbcaFwFmLShVJpio2DmTGxxPK/u
 AILxmMOyoMXxw+nyUzueeFWaELzdvLY0hVpO95Qdq3OKe0In9lbtzd6y
X-Gm-Gg: AYBFou0hamRFWc4RT0xGgpUOt7xIADuePD7yi/BxLyvmhpBfOV2O0AuME6Bs+nAWXSI
 jgvBCsIJPi0GgtBTQBdV5j9MmLmmnaVNlMO86tq3l+UMSIL4WzUGI2I3+88rJD/8hvOlX/0AvJV
 Ez9A07GnIBbyLVzQuaplYkLRW9SpBd4JGfaYGlUHzScjXheNliIgrlAcpfuDD3SRugr6eLOsXiK
 SBkAg+vUlQz8d8CuU4EjwSNR3026pRnyNisUhPNDfAM3sTchKT+CEPLNwfxAFkbtjjPhA2CFnjR
 aRYCx2zXlInlVj5sHSt3/v+VMOeWEph7+uY9qDKupc2Y2W8zEYDmTeZ248m0DX7t1oL5+N4s5tS
 E6Ywn4fxP6apYnZV0/rHF5AyGMYcCy28x+AuZBi7h+t+taEc/5aaN/aS8jRPwtVkYpgQsFBuGca
 GoARGfIyBnhIYisGpW39xijQj9XSOpBa1q9FD82LZ3CnUCrgIIsiAcebCbogObaVvRMDf8CluIw
 nID57RF0NQntbL4WoL2xTIHz5s=
X-Received: by 2002:a05:600c:820d:b0:4a1:65d2:7912 with SMTP id
 5b1f17b1804b1-4a18e47b302mr316469315e9.8.1792028114103; 
 Wed, 14 Oct 2026 18:35:14 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd67b125sm22982265e9.3.2026.10.14.18.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 18:35:13 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Thu, 15 Oct 2026 03:34:43 +0200
Subject: [PATCH v3] treewide: use qemu_dup() instead of dup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-use-qemu-dup-v3-1-ca02b5927725@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw7CIBQFf6VhLaZcFNGV/2FcULi2GPsQCtE0/
 XehbhoTl5OcmTMRj86iJ6diIg6j9bbvEvBNQXSjuhqpNYkJlCBYyYAGj/SJbaAmDJRLAdJUSnN
 EkpTB4c2+ltzl+mUfqjvqMTfyorF+7N17+Yss7/6kI6OMltwcd3IPSmh5rltlH1vdtySnI6xl/
 iNDkhmgTjoIXh3W8jzPHwLzY8z3AAAA
X-Change-ID: 20261012-use-qemu-dup-38628dbac3ee
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792028113; l=7288;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=6Sitnwa4Mq8Mcy00yCaVFd17gEMtwrz93FTfKC8RUTA=;
 b=JeJDib0Y6fdA0hcGpxHbYNxlkq2q5RjASLk9GlMI2TlnHQhFIcxJcPxOdCLjLi81ha2MGgXaC
 RSAK7FFNGwbAQ62N46mmxJE4YzRROPSobCbDEW0pc9ndpeqSGyyHfuA
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use qemu_dup() to ensure the cloexec flag is set on dup'd fds.

The only direct users of dup() are now guest syscalls in the user
emulators and the implementation of qemu_dup() itself.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
For each call I replaced, I checked how the resulting fd is used
afterwards. In summary:

hw/virtio/virtio.c:
    the fd is passed to memory_region_init_ram_from_fd, used for mmaping

io/channel-file.c:
    the fd is passed to qio_channel_file_new_fd, used for reading/writing

migration/cpr-exec.c:
    the cloexec flag is cleared

qemu-nbd.c:
    the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO

system/vl.c:
    no change in behavior, the code was already setting the cloexec flag

ui/dmabuf.c:
    the function is called by qemu_spice_gl_update, which passes the fds
    to SPICE server

tests/qtest/bios-tables-test.c:
    temp dup of stdout, dup2'd back to STDOUT_FILENO

tests/unit/test-util-sockets.c:
    one fd is dup'd again and returned from mock monitor_get_fd; another
    is converted to string and given as address to socket_connect

tests/unit/test-vmstate.c:
    passed to qio_channel_file_new_fd to create a channel

Changes in v3:
- Also replace the use in migration/cpr-exec.c and the tests
- Link to v2: https://lore.kernel.org/qemu-devel/20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com

Changes in v2:
- Replace the use in qemu-nbd.c too
- Changed commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
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
index c9f9e5b511..70779fbd56 100644
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
index 5cef75a67c..3f707e80c9 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -48,7 +48,7 @@ qio_channel_file_new_fd(int fd)
 QIOChannelFile *
 qio_channel_file_new_dupfd(int fd, Error **errp)
 {
-    int newfd = dup(fd);
+    int newfd = qemu_dup(fd);
 
     if (newfd < 0) {
         error_setg_errno(errp, errno, "Could not dup FD %d", fd);
diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index daa50916d2..2f38db30bb 100644
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
index ed5895861b..db1a70b008 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -975,7 +975,7 @@ int main(int argc, char **argv)
 
             /* Remember parent's stderr if we will be restoring it. */
             if (opts.verbose /* fork_process is set */) {
-                opts.old_stderr = dup(STDERR_FILENO);
+                opts.old_stderr = qemu_dup(STDERR_FILENO);
                 if (opts.old_stderr < 0) {
                     error_report("Could not dup original stderr: %s",
                                  strerror(errno));
diff --git a/system/vl.c b/system/vl.c
index 468a9fc247..9381e3d7f7 100644
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
index f6dfa4131b..c4838322fb 100644
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
index 006f5e579c..c47ad6c82d 100644
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
index 23f3173070..57f1e3263f 100644
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
index 497f82cc61..6d5dffdf84 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -95,7 +95,7 @@ void qemu_dmabuf_dup_fds(QemuDmaBuf *dmabuf, int *fds, int nfds)
     assert(nfds >= dmabuf->num_planes);
 
     for (i = 0; i < dmabuf->num_planes; i++) {
-        fds[i] = dmabuf->fd[i] >= 0 ? dup(dmabuf->fd[i]) : -1;
+        fds[i] = dmabuf->fd[i] >= 0 ? qemu_dup(dmabuf->fd[i]) : -1;
     }
 }
 

---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-use-qemu-dup-38628dbac3ee

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


