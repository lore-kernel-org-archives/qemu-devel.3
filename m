Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9BACA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGO6E-0004i8-9V; Mon, 12 Oct 2026 18:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGO68-0004hy-8v
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:02:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGO64-0007sd-Rv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:02:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so18550415e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791842534; x=1792447334; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vIUyRbrPQ1cP+wrJRdTdqNaiyHBOnWVC1oUtI7SpV/g=;
 b=V13Al5VqpnMTGgTkJ2PEqdDjlhbHNzGPvIT8mQivXP8XnfOn7Z0P49O6JoxkJ8RINL
 tCP+PNpT2IkrJD3ZMHSWc1f3eziyCGTdiGh0ZERasBdHqkrKpvJLMn+MrKssJ9LCdk02
 wrEeFVoU09dK+zC0AQYmnAM1Zlu4+/f9a38nyLksD/3TlpwY81rePpre2WoxGpI9jgKu
 2MT8jkPZNXoPJ62/7iM3FQj9pMEoeH9RGpKPQ+5MhaKFYOdF4knF5Q4m8ygp7GxHSURo
 qV9Y1FWfH0rTzyLAJ6N//Wg7WYuh74V2vjqNwHy771i+kjnfIP2vBenvHdzxocxnXmLs
 5Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791842534; x=1792447334;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vIUyRbrPQ1cP+wrJRdTdqNaiyHBOnWVC1oUtI7SpV/g=;
 b=axoro+OCLe4h8ainBqtCKRNhRtwfwsU1qs1zo9v95t0HJYgO9FwJYnpveik/4foawR
 bbaundbaIb2JcV4RTfLCltutQOjzFXNWNmc7ueyBDc8fETXcL6I6LkxA+eC07Gc83TE8
 BcT9Nmz3WdGPruMFiXW4LsHz2ak3KqH+ETw/o8+MBzU+xQjAiNFeaNcalOE3skDn6LeB
 0rIc9NMx3/oPcfVMqDlGHTEUMJVLXhkgrQiAkptxweRnfSXae7iy+loz7rKi4AwjKZOY
 EDSUD4K5W7yV+vDfddc650lGMJrGUf7ZGXBxoNwW9ID+uhrURz3V6TQNmc4ne2RhKPpT
 X2Nw==
X-Gm-Message-State: AFq9FYIWxlR9sSFgb6TiUdWzPQkHcS9Pbx33c+k6OQcOBL3tok5iKNiT
 3813dEf1rFzNHUuj8HbUQrNyh6w+fnlMPb/Xmu4nrFnd1hb5LTWa4yGH
X-Gm-Gg: AYBFou3AH3mQyqbbEeN6J2ppIfUhX6yRxwaYq8+deuhUdIiCdRqh871TVgfDrG8XL8d
 QezG0UVbXqI0eE8EhfQVnJ9eeFBFpmnAWnXaRY4RLb4RJydcFR/4dbbB2A4zdQGQltpFrYPYf3O
 EXeRB1iH3J0F+bEI31ce7qvP/cVz+zcnao1NxoDHnyJIkrWZaok/5shsIwfeNbVo4e1PbJYfcg7
 Q+RaKBfhWukZyHuB2bBSGRR4PKCef0ArPKfCJwvOLTaIJPb6YcAELO2mtnM1qtA8nXD4o001c29
 dgvrS8W0HY4D2mEOCBiJDG2BZrnaBnmABNrIyUC8Fmw5WTvRlp3IzosbSIGts12tOXUwLQwcffS
 THNqLT40cKKp/PPntf8JsCBtHtrNQey8mhR5IEqvM/xKIy+Ao24t+By3A2oJnkC+8I1/7L1UMvv
 e1DR3JZMWEiMSf/sW8uIGJsQhLDmE3739XO5BsHbRqi0iNWDsM2Fgw9XokmpN0OhB9vs/dyOa2o
 kFrBTlRRP4uvIYg6DZ0p1UdnvI=
X-Received: by 2002:a05:600c:3ba5:b0:4a1:70d4:c69 with SMTP id
 5b1f17b1804b1-4a18e4c03bbmr238815375e9.28.1791842534220; 
 Mon, 12 Oct 2026 15:02:14 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm309442575e9.6.2026.10.12.15.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 15:02:13 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 13 Oct 2026 00:01:58 +0200
Subject: [PATCH not-so-trivial v2] treewide: use qemu_dup() instead of
 dup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-use-qemu-dup-v2-1-12ecd94263b7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7RhalFRX3sOwKO0IY4BiSxsN4
 e4Cbl2+/Lz3ZwjkmQJcsxk8JQ7shhXkIQPT6qEhZLsyyFyWIhcSYyB8UR/RxhELVUpla20KIli
 V0dOD33vuDoObMDicPCfWHVS/PcT6SWbampvRcpic/+z/Seze/6skUGBe2MtJnaUujbo1vebua
 FwP1bIsXw8ZkV3KAAAA
X-Change-ID: 20261012-use-qemu-dup-38628dbac3ee
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 qemu-trivial@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 qemu-block@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791842533; l=4070;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Ns64wWTsa4Yr6mw355qJNtU+7UzwoMvKHW8I6AC9CJ8=;
 b=yzEgdDmiQozDWkHXvYc+4cXBR5eU2PrvErOXA34Oho4wKOOyUvo5hig0QyNN6hPuwb5ifiAwt
 Qb8FgOLLpMlB64p08KQNWXsu5g8shLWP7zd2ZC0zGwILslcjKc+laHl
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following dup() instances were left unchanged:

    FILE                     REASON
    util/osdep.c             implementation of qemu_dup
    migration/cpr-exec.c     fd is intentionally kept across exec
    {linux,bsd}-user/*       guest syscalls
    tests/*                  left for future work

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
For each call I replaced, I checked how the resulting fd is used
afterwards. In summary:

hw/virtio/virtio.c:
    the fd is passed to memory_region_init_ram_from_fd, used for mmaping

io/channel-file.c:
    the fd is passed to qio_channel_file_new_fd, used for reading/writing

qemu-nbd.c:
    the fd is stored into old_stderr, then dup2'd back to STDERR_FILENO

system/vl.c:
    no change in behavior, the code was already setting the cloexec flag

ui/dmabuf.c:
    the function is called by qemu_spice_gl_update, which passes the fds
    to SPICE server

These uses shouldn't require keeping the fd open across exec.

Changes in v2:
- Replace the use in qemu-nbd.c too
- Changed commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com
---
 hw/virtio/virtio.c | 2 +-
 io/channel-file.c  | 2 +-
 qemu-nbd.c         | 2 +-
 system/vl.c        | 9 +--------
 ui/dmabuf.c        | 2 +-
 5 files changed, 5 insertions(+), 12 deletions(-)

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


