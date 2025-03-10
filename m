Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E046C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 12:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbur-00027K-ES; Mon, 10 Mar 2025 08:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trbuk-00025o-CD
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:07:24 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1trbuf-0002HK-5S
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 08:07:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1741608422; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=H/AY+exWAbJzeN2aeCFQsFrsFvQACbFxNFlbyiDnNpfUgZ+KJ8O+kQQhCVOtGWW+zmScXG8itNtptCz3uvLNtCbD+bBjUWC/C1WI81/nHjC1CF6MdPQ90qR8sV68QsbVJRgshWlD7Vx9MA2fgFfiTu8cGOOheIULfqtS/Iz0ePE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1741608422;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MhKxg8KhlFdU/0zGr+2oG+QDo2bkuViXKalTtQT6/Ck=; 
 b=nA0L6r5fPrTVwPXn/46n2U5vo7d+zIFTuQiwxHRe82dpDNYVk5rcd+BgfgxkJA5V9pnvCMBHic7Wcd0/50RpKdMeXKh+TbqNGCY1ev8W8lWWsLWPFY/+h1GINVD7ysdCUL8vYH3QAAxeuOc0ddXo4/Fp/prDPmudHSYCIrYmkXg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741608421; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MhKxg8KhlFdU/0zGr+2oG+QDo2bkuViXKalTtQT6/Ck=;
 b=MZGa0qUY1G6Ydsmby/6CUGs70lW7fk2tOxPdfjyGnO7OM9Q+SUgSTc7Z6aAWJQtx
 VB6761bcKyuQnRiiaTPLyopM5Q+q6ugOUluz6WKi7EnITtg7EHAwBamIa+G+8DMud6u
 uEqIVCpUPyaqwNpHAmPFB7xuxA2sAoXElsOEecIQ=
Received: by mx.zohomail.com with SMTPS id 1741608419495708.2912761825511;
 Mon, 10 Mar 2025 05:06:59 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
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
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v11 03/10] virtio-gpu: Handle virgl fence creation errors
Date: Mon, 10 Mar 2025 15:05:48 +0300
Message-ID: <20250310120555.150077-4-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120555.150077-1-dmitry.osipenko@collabora.com>
References: <20250310120555.150077-1-dmitry.osipenko@collabora.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b387956..2eb6aaab4e84 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -872,6 +872,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -970,7 +971,17 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     }
 
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
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
2.48.1


