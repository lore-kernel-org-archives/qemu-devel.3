Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43131C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAKE-0006eO-Rt; Wed, 12 Aug 2026 10:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIy-000542-Aa; Wed, 12 Aug 2026 10:51:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIw-0006qU-OJ; Wed, 12 Aug 2026 10:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=gG0AQaaGMteVasmUCuN/B80YIH5Sk7JShmsHeVt8yXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wQP2N7N5d3ZU0tFdy2GNVi48/UWjDgSLZQizj2bnN8tP6n0TlxX9FgsS0QKzAEpfc
 jMYcw9zLdKdUBKqKKAvBqZSGSlMkAlnP40thj20beU3ZA7eGrNQZgX9+HgtQgaGe8J
 nKjCC8zXBo8k09KUMKw6M0YGIi0cgKCwjtDQQ3DtJAkmHXXDwoMmsdJUcBGR/zKE1Q
 9CLOXucB3IJWuw3OiQP05heQUby6c9M2HSwW8W2qyTb9balhmo9YxeC/z5PdeeyqCt
 uu03F45kXzT3eQEyNKXK7pOJFT6hyWNAu6E/BE3e1q2MnZqJ6VxjBdAZSyRleYhjoS
 MqoL/4SBCHZWQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 239E51CA615;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E374409D51;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DBCB92F985; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 017/120] vfio-user:
 vfio_user_device_io_get_region_info: fix capability check
Date: Wed, 12 Aug 2026 17:48:00 +0300
Message-ID: <20260812144955.649205-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Thanos Makatos <thanos.makatos@nutanix.com>

The existing check for PCI capabilities misses the case where
info->cap_offset == info->argsz, which results in accessing unallocated
memory. Fix the comparison.

Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3865
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-6-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 20b3a363fa8c9a83715d7241ec21e2d516359a1b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 580559d9b95..34af50aa83a 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -173,7 +173,8 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
 
     /* cap_offset in valid area */
     if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
-        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        (info->cap_offset < sizeof(*info)
+         || info->cap_offset + sizeof(struct vfio_info_cap_header) > info->argsz)) {
         return -EINVAL;
     }
 
-- 
2.47.3


