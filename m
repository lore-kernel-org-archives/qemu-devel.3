Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5790C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN7w-0003UO-JT; Fri, 20 Feb 2026 04:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vtN7j-0003O0-Re
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:48:40 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vtN7f-0000C9-LH
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:48:35 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6D7CEC01BB;
 Fri, 20 Feb 2026 12:48:24 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:46e::1:36])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EmYb7x4A1uQ0-hAWgnqCq; Fri, 20 Feb 2026 12:48:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771580903;
 bh=3kS5TpEBQcF3prgZ5xCUU5tGP2vdJgBjEJP2pCQkTP0=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=LIV4j6X+FgM9b5Dk9syTX1IgGAhtd19CZCY8zTWJwDgnV5EoUkZGxnJmcugKlnPDR
 K7RSwN5EFogEPwIZ+Xs8CDY68eAXvcoR4Ivt9IIgxVtd3/jyDsoqzFO6HNJuAyhrRj
 7LvTNWLLuovNOaYX/vdICAuQdzDHMWm+RZP1YbHI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v2] vhost: fix vhost_inflight_buffer_pre_load
Date: Fri, 20 Feb 2026 14:48:01 +0500
Message-Id: <20260220094800.276489-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

While I was rebasing my series about inflight migration, I missed a
small issue in vhost_inflight_buffer_preload:

* fix wrong return type in function
* fix error check

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 52801c1796..f83bdcaf8b 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1926,8 +1926,8 @@ static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
     void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
                                   F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
                                   &fd, errp);
-    if (*errp) {
-        return -ENOMEM;
+    if (!addr) {
+        return false;
     }
 
     inflight->offset = 0;
-- 
2.34.1


