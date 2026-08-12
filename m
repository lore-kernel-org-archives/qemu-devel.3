Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571DEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuALI-0007eV-BG; Wed, 12 Aug 2026 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIv-00051i-5V; Wed, 12 Aug 2026 10:51:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAIt-0006mg-FA; Wed, 12 Aug 2026 10:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546231; bh=ebWdaFqJnEcTicyE2bqL1Mj0OsK7DUakSnUMP5QurSc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d1D6pX6RWKBiOvMElI8T7VQoOfWXq4qLtoISqnXOZErBg/b3wqzYjcEeFkp0q0G9e
 Uz+ucVTWCSEczPmNKGdE5TRancvW8U0soddxCEOidB5lR6m20VfX2LAAPD1DO+WfrW
 89K4bcYImw6Tq73gHsFba5jjHth6h3FjsSPFJC166xHjAn0RWta7eATLpG7UJqYfQM
 tolJII3ISyoPIWNH/skshOdu7t3CnNCSmLZt7o5QXmNcZXyuVh/Xe8BqT5AUsYKMPV
 KSdSMP3B3pMz11v4YuaOXqVhmqxMHdPkTEj8auZNkCzVCUpQy7WUScui/sfYUyWmRx
 nXDKA7nOTpUnQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 119021CA613;
 Wed, 12 Aug 2026 17:50:31 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B81B409D4F;
 Wed, 12 Aug 2026 17:50:42 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CB9A52F981; Wed, 12 Aug 2026 17:50:17 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 015/120] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Date: Wed, 12 Aug 2026 17:47:58 +0300
Message-ID: <20260812144955.649205-15-mjt@tls.msk.ru>
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

While this isn't technically a bug, it's highly unlikely that the
server wouldn't be writing an entire struct.

Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
Fixes: 667866d66620 ("vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260721122643.30985-4-thanos.makatos@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 3966a4258b597c7e1a86a65d6a0d15f28a09dca8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 8feedf82238..df86dabe1e6 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -124,6 +124,11 @@ static int vfio_user_get_region_info(VFIOUserProxy *proxy,
     }
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
 
+    if (msgp->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info reply argsz too small\n");
+        return -EINVAL;
+    }
+
     memcpy(info, &msgp->argsz, info->argsz);
 
     /*
-- 
2.47.3


