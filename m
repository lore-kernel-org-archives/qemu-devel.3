Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC330CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2X-0000Zh-CU; Sat, 17 Oct 2026 16:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1C-0006Oa-J3; Sat, 17 Oct 2026 16:28:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1A-0003zh-W3; Sat, 17 Oct 2026 16:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268844; bh=RGAd5ibHiodI5YwFcPorHpWGBclDFCGrJpuETcQaFg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xGreYEyUGhAxV0dq1Kezo3GYsLVftb5I90UcSR3iFLsaSdet0Q5gdjyZ0rjlv5bNL
 0Qih3+Cu9dLT6Tx9GvHDzVGLgSo4kqpd9qgcxf8X9diAK08c3rI4eR6xNWcrOED3fm
 ZWD+G35sO2sRaxMSarR8gxYSAwvrwKIAgizzzcNAiplRcUUDVN3TLFLoDkPy+NeNko
 OAKuMIS17NZ7Bi9gClFlDChq/lmuU3aDFtF8y+IpV0ZuACcdAxTfD7oR0sahN8xcJD
 tL1DDUdk2FweQzXj7y/h4LHORqcVTbDCyQBUk6Dl++RHbqa/I3Mmw/MNGJN7aUJc1V
 dyipF7abXZWRg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3C42C1DE750;
 Sat, 17 Oct 2026 23:27:24 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50EA7443426;
 Sat, 17 Oct 2026 23:27:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 20/73] virtio-gpu: disable blob scanouts on mapping
 cleanup
Date: Sat, 17 Oct 2026 23:25:38 +0300
Message-ID: <20261017202638.728621-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

When a blob resource backing is cleaned up (for ex via detach_backing),
any scanouts referencing it must be disabled first to prevent the
dmabuf from outliving its backing memory.

Fixes: CVE-2026-66020
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 3ece85b53c124142c7d5cbb1165d4da125b7c369)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index f991baf856..d479595ddb 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -999,6 +999,16 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
 void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
                                 struct virtio_gpu_simple_resource *res)
 {
+    if (res->blob) {
+        int i, max_outputs = g->parent_obj.conf.max_outputs;
+
+        for (i = 0; i < max_outputs; i++) {
+            if (g->parent_obj.scanout[i].resource_id == res->resource_id) {
+                virtio_gpu_disable_scanout(g, i);
+            }
+        }
+    }
+
     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
     res->iov = NULL;
     res->iov_cnt = 0;
-- 
2.47.3


