Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162A8CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 19:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGLwe-0002xS-Ja; Mon, 12 Oct 2026 15:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGLwb-0002x5-Vo
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 15:44:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGLwZ-0004y9-AK
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 15:44:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so15581955e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 12:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791834257; x=1792439057; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MKxlNH4cn62tbjHpbAVipSp6/2MkIgb/v80lcWlBQqs=;
 b=GywyD1XKIQXYoV78rdc5UPwPaIdv7DDDooTI5IdP30UGxI4Wr0f+PrJVoIMGsaKD4Z
 uju2d2p2ouRXmIjOckXc1p47R0rf1O/YEHBpHzQbGgAUaIZMzhe5g9HNrQBoKPO3VfT0
 gBpqZAVbId4NlSckQzmO4C+hOaizhfMM3afLjd3HEcY8ExhW4AvZD4kWwZv2ahvaRk07
 /8tyZ/+yftYv+1l7JbDTsi1YgRS5GH65u+sKEBlQY8Kh4wlUQMV6AtwsThFQAgW18Ksr
 MrtR2q86JQlsu0V4zpe4P6lI1ZiN0wm1NOYytsn8+/QCCC8PCYWm+9TSfB4LE6KR5wG/
 B9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791834257; x=1792439057;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MKxlNH4cn62tbjHpbAVipSp6/2MkIgb/v80lcWlBQqs=;
 b=Q9PppVQt6JnRBIBcW27SQFCEj1lK+A2hBWchLfxa9LBTSm4WdpDJfSHIwyrJk/M+yH
 SazuCrOv69RWJUw4jmPzHlyYyNM7ryk3Fg87YP02Nehg2fCC/vmuzmxUvMLHRFB/j/zX
 1sW/KzLXIar7Ugo4Yt12hWpm5+NUNryYSHKW1Fd46uy68I13N+ScnspHj7kdPRXh6yGy
 EnsgsBMl9z0O8EvmjKSNwHpVMqiserHWEdm4yfZWIvgmhIZQTl2llTKm9sI5n3k06vFM
 ndwY83G5Jn/PbZzRYBqMUmzgiR6gcH+0ujXTW2rPDvS5uzTqC2ZonI3JOSe/s1ijuurn
 uYXw==
X-Gm-Message-State: AFq9FYLLpHqws8tSwrQJFdLRtROoHCS7ypllZoHIhq4ne/4vIiFoNWKt
 fn3VjcYZsAqWrrYKZE6q9XQ9ov6IUN0dxFPWwa7Ll3EikB50+ODOn4WR
X-Gm-Gg: AYBFou3zjqZMvqVcXc66K4Hs7NqkaxRmdtTA6dkir2384mjnRhm4jBAcKCExC4Mxw97
 I0D6qoMrs2fYrOp2QMXI2YBsmgCHL50iCKLEsCj56aTZK3OZYBUAJ4I3zO6wmzw1i/za9k/+3mV
 n53REtR1i8B6+EL2IZPJ37RT91+npjNfh68J3kKNj/VOgkMKIPDzb672+qDD6OjIbdyZ9LgzXGt
 ZWMc3vsF13iOcTzeuZVOfgigDcHzrt6FCeHRriJz7/xpERbhASSV6hyGJDTS0Cbe/VIw4hMJpQq
 Hnq+hBliWXEdVAWpg6azj/Rn++suOw8slqbDvrGVYZm1MrK2R49PpJRFUb6WIWZ+PlrDHtQGOtf
 ROJdnwJUvWGde9V0fo5zjjlNvsMH0fEu1+ypIzV0rcC7Q6l6/uVeOHOCyJoPDzx9gzkpoyiuwuU
 x3IvLytbyKv1upCB2vUvu1Y32LdNznZ8X+fXkW5d4EeRqE8iIsDQfDXg2gtg7tiHGGvF6xIXHog
 suj1mglLDEvcbaEenXfszH667M=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a18e446db6mr179997655e9.1.1791834257372; 
 Mon, 12 Oct 2026 12:44:17 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beabbd0sm358895615e9.12.2026.10.12.12.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 12:44:16 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 21:44:06 +0200
Subject: [PATCH TRIVIAL] treewide: use qemu_dup() instead of dup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3dLiVN3C1NxS3ZTSAl1jCzMji5SkxGTj1FQloJaCotS0zAqwcdF
 KIUGeYZ6OPkqxEIni0qSs1OQSkGFKtbUAT5OspXkAAAA=
X-Change-ID: 20261012-use-qemu-dup-38628dbac3ee
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 qemu-trivial@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791834256; l=2370;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=G+K4qSCyk2jVmpDx/lFGJGU5YT4XwhwRPz1nn1hkr+A=;
 b=y2EQEFW37dLB6aCv9U/wm4eQmTN9ikflc+vgYQKJiAwSNPv2/YpBMyxxl2zTHITJeuYzVOZsu
 qHq1kkcTKPhBjhAE0D2bwnAAfiLjt78iRLtDayPeK8zOMnfVyoCBHnz
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
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

Make the use of qemu_dup() more consistent and eliminate the possibility
of accidentally creating non-cloexec fds.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/virtio/virtio.c | 2 +-
 io/channel-file.c  | 2 +-
 system/vl.c        | 9 +--------
 ui/dmabuf.c        | 2 +-
 4 files changed, 4 insertions(+), 11 deletions(-)

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


