Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC20CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGA-0001UL-5y; Tue, 12 May 2026 17:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDu-0006vg-Nx; Tue, 12 May 2026 17:01:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuDs-0006M4-OR; Tue, 12 May 2026 17:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619277; bh=v3SUpINWlqo+e3uyV/6RfKqswv5vmvgIs7RRwaHysZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OXzLhxrnOCnG+AZtUKo0FAO7sQeBInByWyKPA37+7ei5d/0rB1V7imB5PMpnhRCq4
 uH15rIAZg2aKyuzEJq3v2Ckqo3rDO0Ujpwqn4a3ITMv2RhztmXp1xm0mw2micC9Msi
 YFWhucq0syr9cw6E+sLvx/myFwHNqkWleCeTosHHPoFj+7Sqt22/OVmsg314NKyFyy
 skYVvsyRWpdWEnLAZ5HC3rM4KaScJ9atML37CP3ZrO4lm6wbIc48zd8ESu2QJLjg1Z
 +RxQ6k84OQc85564ZxId1EMmnqmRUXmYIDJM5k09NnR5ETH6sERfeMvI3zAF7P/it2
 oOZW7QDKZlQNQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AD4951AA30D;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B831C3ABC7E;
 Tue, 12 May 2026 23:54:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 065/107] hw/display: don't accidentally autofree
 existing virgl resources
Date: Tue, 12 May 2026 23:53:52 +0300
Message-ID: <20260512205437.360850-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index a65fca9c62..030b329d5a 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -708,8 +708,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
-    if (res) {
+    if (virtio_gpu_virgl_find_resource(g, cblob.resource_id)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
                       __func__, cblob.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
@@ -762,8 +761,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
 
     res->base.dmabuf_fd = info.fd;
 
+    /* Now live, cleaned up in virtio_gpu_virgl_resource_unref */
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
-    res = NULL;
+    g_steal_pointer(&res);
 }
 
 static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
-- 
2.47.3


