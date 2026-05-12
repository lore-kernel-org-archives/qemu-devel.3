Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A04ACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuVl-0002T2-T5; Tue, 12 May 2026 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVT-0001xi-1E; Tue, 12 May 2026 17:19:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuVL-0007w9-Df; Tue, 12 May 2026 17:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619497; bh=0Ltl0SagAImtq57f08x0TRCYzKEAteLzaVQ/6BXHgWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LxDc5mfijk1+tiQHHLq4lcYz8G80+D7SYvjHNdPUCS/WFlQCqoMAc6IQFpSIdp+B3
 SNpr8CRnPIIomJjY/g7ffB+Xy4ANF7pZqPg9LVe6Iqf524DJgUosVfMQhrkNt7nupb
 wFPI4hdLQcCN+PNMndBhRyw+ahjK0WVidPi4Mc8+nA9ZjvF3COLLsCx+tlH3Yz22Ij
 9EkvuscH2zp5UTpWvvFQ3IW73NtWhi2wCQncfXD7dVLlifuL7/CC6d53rPXomPwEoQ
 q6vFBAiWETgb0FDzx2uDEiTmXXrj1PJx5snXCIRJLgADeoPFesu6NJbsmSLAQDGzjL
 wSp/KQVrKQhLQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B04131AA3D7;
 Tue, 12 May 2026 23:58:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB67B3ABD2F;
 Tue, 12 May 2026 23:58:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 12/58] hw/display: don't accidentally autofree
 existing virgl resources
Date: Tue, 12 May 2026 23:57:33 +0300
Message-ID: <20260512205820.361821-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260512235518@cover.tls.msk.ru>
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

From: Alex Bennée <alex.bennee@linaro.org>

While sanity checking a create blob operation the use of the auto
freed res variable could lead to inadvertently freeing an existing
blob.

Avoid this by in-lining the virtio_gpu_virgl_find_resource() check as
the value is not needed anyway.

While at it add a comment to the end and use g_steal_pointer to make
it clearer the object lifetime exceeds the function bounds if we pass
all the checks.

Fixes: CVE-2026-6502
Fixes: 7c092f17cce (virtio-gpu: Handle resource blob commands)
Message-ID: 20260417094443.785462-1-alex.bennee@linaro.org
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
Message-ID: <20260417122703.845442-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
(cherry picked from commit 30fad722ce68316d22b926ba0e6017f0440465df)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b7a2d160dd..add85bd4e6 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -830,8 +830,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
-    if (res) {
+    if (virtio_gpu_virgl_find_resource(g, cblob.resource_id)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
                       __func__, cblob.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
@@ -884,8 +883,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
 
     res->base.dmabuf_fd = info.fd;
 
+    /* Now live, cleaned up in virtio_gpu_virgl_resource_unref */
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
-    res = NULL;
+    g_steal_pointer(&res);
 }
 
 static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
-- 
2.47.3


