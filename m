Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9C8CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 16:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI8bH-0001OO-Tg; Sun, 09 Nov 2025 11:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bF-0001NR-FN
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:09 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vI8bD-00007O-RL
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 11:49:09 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1762706932; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nx9yybIJsr6ff/tn4nph7CAtngVgIYvlaKUJDKwDeTf7K9YwEvBfdZV9pVr2QlnsGjhLay/JJKlQgMjg/Lw42EIekk7eR6tMVe051C8WVA/LJECQtc8/dh3Dm/NWUYFPElqNjw6fSP5cbbBvqVVx5DVuycwkdno9TPoPh5c1gvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1762706932;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nLTs0bFvzZaFOZD0jvOJ51eBtDkTOFprK6NA/CAmf/o=; 
 b=EHBI6HJjKEUQMNkRIAqMa0IkzZafElMSVJSqSz1w57ICU+M3oibXWDMNLcsy16ahds0bRQoOUwVpzFrDup+jPeMvY+lVG5oe4NSqdMSkB/BjFNXFgqTnU1RnUbxOBa2PgNA7v/OKyJD9xQqajZEfv8NxaL/JdVA1dziqNRnFBvY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762706932; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nLTs0bFvzZaFOZD0jvOJ51eBtDkTOFprK6NA/CAmf/o=;
 b=b7ek3vSHbXMsYWf2cTBTu1R4yMRPs4xHYioiOP/qRNJ7CvqlTNFh4s+Qhf3bdLNO
 bE1NafAmxq9FWCcmJB4OyoM6SlTd0P6xsmjm1t0um9me7CMWqXHWzQ4Gra5PXcXoEvC
 Q7AJV2lk+NjslW/2w+TsU1C6y20HO1ETRjAwXSOE=
Received: by mx.zohomail.com with SMTPS id 1762706931380800.6854112370477;
 Sun, 9 Nov 2025 08:48:51 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v15 03/10] virtio-gpu: Handle virgl fence creation errors
Date: Sun,  9 Nov 2025 19:47:04 +0300
Message-ID: <20251109164711.686873-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
References: <20251109164711.686873-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Print out error messages when virgl fence creation fails to aid debugging
of the fence-related bugs.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 07f6355ad62e..d9704e3574a0 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -876,6 +876,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -976,14 +977,30 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 #if VIRGL_VERSION_MAJOR >= 1
     if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
-        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
-                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
-                                            cmd->cmd_hdr.ring_idx,
-                                            cmd->cmd_hdr.fence_id);
+        const uint32_t flags = VIRGL_RENDERER_FENCE_FLAG_MERGEABLE;
+
+        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
+                                                  cmd->cmd_hdr.ring_idx,
+                                                  cmd->cmd_hdr.fence_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_context_create_fence error: %s",
+                          __func__, strerror(-ret));
+        }
         return;
     }
 #endif
-    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+
+    /*
+     * Unlike other virglrenderer functions, this one returns a positive
+     * error code.
+     */
+    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: virgl_renderer_create_fence error: %s",
+                      __func__, strerror(ret));
+    }
 }
 
 static void virgl_write_fence(void *opaque, uint32_t fence)
-- 
2.51.1


