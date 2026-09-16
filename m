Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63D9C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMf-0002x0-L0; Wed, 16 Sep 2026 03:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMd-0002r7-57; Wed, 16 Sep 2026 03:47:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kMb-0005Q4-7T; Wed, 16 Sep 2026 03:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544619; bh=W8vuVPPk7YFnn93xLGvKlsRQLztsdjQUBnJj3kpGymg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X8fk+TNyI8xVplbqXRT2mLvAmiuLwZJF6GIcTM1Ht83oskz30lYnAQIxszDOqW+s+
 IzbR9pFJ/yEYf7nGEV83Nb9jK7LATPlYQk0L+bEKmCroTHWjdYehJbSNjVcNBK/+UL
 XHVjvsOCpu0/29dHlbjvcSgJIbUkPDc+QXIR9pmr3KVnBkI9MaxBJ3y8iROOVgyRAp
 vfZzzSWvwJsx6+CZSGyBleVqSgSyCe/1WuuwzPXs0nAd6waZHUMZRxqppweetZHfhP
 QqzYp3y88lOuN2kNkHhAvWr56ertvXdLND+m66IMlUu4rnw3Q6M6K9paN9XpD3rs03
 lucIPcY8b111g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 403C21D55BD;
 Wed, 16 Sep 2026 10:43:39 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C3CB6429B76;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5EF205A71F; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 admin@fluentlogic.org, Michael S. Tsirkin <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 47/49] vhost-user-gpu: validate command buffer size
 in submit_3d
Date: Wed, 16 Sep 2026 10:43:05 +0300
Message-ID: <20260916074346.671467-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
g_malloc() without any bounds check. A malicious guest can set this
field to an arbitrarily large value (up to 4GB), causing an OOM abort
that crashes the vhost-user-gpu daemon.

Validate cs.size against the actual descriptor payload size before
allocating, rejecting values that exceed what the virtqueue entry
can carry.

Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260713125431.107278-1-marcandre.lureau@redhat.com>
Message-ID: <67f10fb88d3c75da3ba7fa5a37f7d6bcfcf3ce9e.1789071042.git.mst@redhat.com>
(cherry picked from commit 01df81b24c50fe70e816cce70956acd6ac632fc9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 20bae57d0fe..c95c4afc5c5 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -197,20 +197,24 @@ virgl_cmd_submit_3d(VuGpu *g,
                     struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_cmd_submit cs;
+    size_t iov_len;
     void *buf;
     size_t s;
 
     VUGPU_FILL_CMD(cs);
 
-    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
-        g_critical("%s: command buffer too large (%u)",
-                   __func__, cs.size);
+    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
+    if (cs.size == 0 || iov_len < sizeof(cs) ||
+        cs.size > iov_len - sizeof(cs) ||
+        cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        g_critical("%s: size out of range (%u/%zu)",
+                   __func__, cs.size, iov_len);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
     }
 
     buf = g_try_malloc(cs.size);
-    if (!buf && cs.size) {
+    if (!buf) {
         cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
         return;
     }
-- 
2.47.3


