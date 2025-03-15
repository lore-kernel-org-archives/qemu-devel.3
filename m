Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7453AC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKss-0005Fx-5P; Sat, 15 Mar 2025 02:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKru-0003os-Ex; Sat, 15 Mar 2025 02:19:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKrr-0003J8-Bf; Sat, 15 Mar 2025 02:19:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9F5F5FF9DB;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 76CCA1CAC44;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F00C558CD; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 myluo24@m.fudan.edu.cn, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 15/51] cryptodev/vhost: allocate CryptoDevBackendVhost
 using g_mem0()
Date: Sat, 15 Mar 2025 09:17:21 +0300
Message-Id: <20250315061801.622606-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function `vhost_dev_init()` expects the `struct vhost_dev`
(passed as a parameter) to be fully initialized. This is important
because some parts of the code check whether `vhost_dev->config_ops`
is NULL to determine if it has been set (e.g. later via
`vhost_dev_set_config_notifier`).

To ensure this initialization, it’s better to allocate the entire
`CryptoDevBackendVhost` structure (which includes `vhost_dev`) using
`g_mem0()`, following the same approach used for other vhost devices,
such as in `vhost_net_init()`.

Fixes: 042cea274c ("cryptodev: add vhost-user as a new cryptodev backend")
Cc: qemu-stable@nongnu.org
Reported-by: myluo24@m.fudan.edu.cn
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250211135523.101203-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 83cb18ac4500f3a14067b19408705068647cb0c5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 93523732f3..5901b3ec4c 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -53,7 +53,7 @@ cryptodev_vhost_init(
     CryptoDevBackendVhost *crypto;
     Error *local_err = NULL;
 
-    crypto = g_new(CryptoDevBackendVhost, 1);
+    crypto = g_new0(CryptoDevBackendVhost, 1);
     crypto->dev.max_queues = 1;
     crypto->dev.nvqs = 1;
     crypto->dev.vqs = crypto->vqs;
-- 
2.39.5


