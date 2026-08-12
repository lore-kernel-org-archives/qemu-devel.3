Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518A5C5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAM7-0001Xo-8M; Wed, 12 Aug 2026 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIx-00053L-M1; Wed, 12 Aug 2026 10:51:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIw-0006qG-3J; Wed, 12 Aug 2026 10:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=KOEFUmlJ8sUsLa6+WoVu6B0boMIALbm69/xYypWjhC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=t4GFXQFksalakHfieKXcgj8gu7G40eIT3Mgwz83VI3DkH8tzXJNW1nqusuZskQd+G
 zXByh86LywY5b2ZE93YzcE+N+gc4kmi228vVGW8qxb66iy8uLTsK9Ha3wug2GzWuDz
 pCXOUVuuQM8bY2SIsiFaZMBLVI59ajPsFqpd6rOtR+iztLFJ3ETAIqD4Xr+nYWwDAl
 xoCp82sQieDlaXVT/WPynhULob2WkaWC9gJB78FZ/ZEmr5HdJET4ark3EKVoV49XPZ
 s5wEcDx2H+kVqdihmY5oEIDz42xL/XftaqBciUQXWekFGIAuOevognCFd4k0nAfz/z
 m7qVdUkF72a8A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B7591CA614;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 760D6409D50;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D2FBC2F983; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 016/120] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Date: Wed, 12 Aug 2026 17:47:59 +0300
Message-ID: <20260812144955.649205-16-mjt@tls.msk.ru>
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

If the vfio-user server responds with a value larger than max_xfer_size
vfio_device_get_region_info() blindly uses it in the next loop in
g_realloc. An value larger than max_xfer_size is anyway rejected by the
check at the beginning of vfio_user_get_region_info(), however that only
happens _after_ the g_realloc, and if that value is excessively large it
can cause g_realloc to fail, so check it here.

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-5-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 6a51aab908e0f043387b91ad6a198b0eae5f2b58)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index df86dabe1e6..580559d9b95 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -129,6 +129,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
         return -EINVAL;
     }
 
+    /*
+     * The server can respond with a larger argsz in the reply to request a
+     * larger buffer on the next iteration via vfio_device_get_region_info().
+     * Reject values that would trigger an oversized realloc.
+     */
+    if (msgp->argsz > proxy->max_xfer_size) {
+        error_printf("vfio_user_get_region_info reply argsz too large\n");
+        return -E2BIG;
+    }
+
     memcpy(info, &msgp->argsz, info->argsz);
 
     /*
-- 
2.47.3


