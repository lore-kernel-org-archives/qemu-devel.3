Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC3C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAJj-0005zs-OQ; Wed, 12 Aug 2026 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIu-00050F-Fb; Wed, 12 Aug 2026 10:51:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIr-0006mJ-MN; Wed, 12 Aug 2026 10:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=n80XF94ENzWb/HbD1OTsDgHDgXT7L4g/jQqEfJ7m3P8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rugn6XGnVNgv25cf/CmM8n1HT/QL4BvBhYb/1Y5Rp4IoR9pgr64PSJW9M33kPmfNq
 +MZgkbFGAVefAPu9RSLkrKCnscGCZRo2tKBiOpIb4gMxxU6Pq0UYu2kyGirkHVuYqI
 nLv7b63LLX7+SGQhsg7uOMfRrb61j5Y/cbEbhypAq0Ru3clGs6cbnTTskU4IJhXqSF
 dAMXRbdMqb2M1GZMjUF962NhMxoL+j+JgjGCqCJoZSgoMtwuwrbS+f01jvBbyznVNd
 Wo8moCudqvMk19WrUAJkW9PbfrlnqHSePN3w0LbwS+MdeVE8gnXvlvALoKLV4/QjBv
 cAIC+FLtx+PUg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C25F1CA612;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 66EE5409D4E;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C44132F97F; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 014/120] vfio-user: vfio_user_get_region_info: respect
 max_xfer_size
Date: Wed, 12 Aug 2026 17:47:57 +0300
Message-ID: <20260812144955.649205-14-mjt@tls.msk.ru>
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

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-3-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 152f7dd3b04f1ad8e99248610c74f876e0da2107)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 9055f648cf0..8feedf82238 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -96,6 +96,10 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
         error_printf("vfio_user_get_region_info argsz too large\n");
         return -E2BIG;
     }
+    if (size > proxy->max_xfer_size) {
+        error_printf("vfio_user_get_region_info argsz too large\n");
+        return -E2BIG;
+    }
 
     if (fds != NULL && fds->send_fds != 0) {
         error_printf("vfio_user_get_region_info can't send FDs\n");
-- 
2.47.3


