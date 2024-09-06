Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87BACD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWz3-0007hL-DJ; Fri, 06 Sep 2024 07:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWz0-0007Pk-Fg; Fri, 06 Sep 2024 07:18:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWyy-0008Eb-FH; Fri, 06 Sep 2024 07:18:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0C1F8C4A6;
 Fri,  6 Sep 2024 14:12:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0733C13370F;
 Fri,  6 Sep 2024 14:13:28 +0300 (MSK)
Received: (nullmailer pid 353719 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 53/69] block/blkio: use FUA flag on write zeroes only
 if supported
Date: Fri,  6 Sep 2024 14:13:02 +0300
Message-Id: <20240906111324.353230-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefano Garzarella <sgarzare@redhat.com>

libblkio supports BLKIO_REQ_FUA with write zeros requests only since
version 1.4.0, so let's inform the block layer that the blkio driver
supports it only in this case. Otherwise we can have runtime errors
as reported in https://issues.redhat.com/browse/RHEL-32878

Fixes: fd66dbd424 ("blkio: add libblkio block driver")
Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-32878
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240808080545.40744-1-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 547c4e50929ec6c091d9c16a7b280e829b12b463)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/blkio.c b/block/blkio.c
index 882e1c297b..52ac94527f 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -899,8 +899,10 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     bs->supported_write_flags = BDRV_REQ_FUA | BDRV_REQ_REGISTERED_BUF;
-    bs->supported_zero_flags = BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP |
-                               BDRV_REQ_NO_FALLBACK;
+    bs->supported_zero_flags = BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK;
+#ifdef CONFIG_BLKIO_WRITE_ZEROS_FUA
+    bs->supported_zero_flags |= BDRV_REQ_FUA;
+#endif
 
     qemu_mutex_init(&s->blkio_lock);
     qemu_co_mutex_init(&s->bounce_lock);
diff --git a/meson.build b/meson.build
index 91a0aa64c6..7a56772136 100644
--- a/meson.build
+++ b/meson.build
@@ -2211,6 +2211,8 @@ config_host_data.set('CONFIG_BLKIO', blkio.found())
 if blkio.found()
   config_host_data.set('CONFIG_BLKIO_VHOST_VDPA_FD',
                        blkio.version().version_compare('>=1.3.0'))
+  config_host_data.set('CONFIG_BLKIO_WRITE_ZEROS_FUA',
+                       blkio.version().version_compare('>=1.4.0'))
 endif
 config_host_data.set('CONFIG_CURL', curl.found())
 config_host_data.set('CONFIG_CURSES', curses.found())
-- 
2.39.2


