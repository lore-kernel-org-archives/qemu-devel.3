Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699CEC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkGwd-0007au-Eo; Thu, 16 Jul 2026 03:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkGwa-0007Ug-B0
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkGwX-0003yo-Na
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784188540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HGA/S3rRc7S5CSXQLWGAi3tEFZeLtR8B6kZNbrWEQz8=;
 b=N0tayDmEhyW8i03Oc/pVNIQEWyyUt5StW82lmvAVZFwtioFYeBdF37OOxDIvMa9MTwrWcn
 xF4Nts1Pu5YisNtyXTXNA2KpQiWXyIGU65FOur4zzjNEKcicdSbnppmw2R5bPa1T8HoP+9
 Po/6+4Czti4NxmRXy2ufrdWNlFUUWfE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-AzynUMvtOa-2SNTAXnSv2w-1; Thu,
 16 Jul 2026 03:55:36 -0400
X-MC-Unique: AzynUMvtOa-2SNTAXnSv2w-1
X-Mimecast-MFC-AGG-ID: AzynUMvtOa-2SNTAXnSv2w_1784188535
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B211800623; Thu, 16 Jul 2026 07:55:34 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5133C1800283; Thu, 16 Jul 2026 07:55:32 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] hw/display/virtio-gpu: cap submit_3d command buffer allocation
Date: Thu, 16 Jul 2026 11:55:29 +0400
Message-ID: <20260716075529.3009491-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Both virgl_cmd_submit_3d() and rutabaga_cmd_submit_3d() pass the
guest-controlled cs.size directly to malloc() without bounds checking. A
malicious guest can set cs.size to an arbitrarily large value, causing
an OOM abort that crashes the QEMU process.

Checking cs.size against the descriptor payload length (iov_size) is not
sufficient: indirect descriptor tables can repeat entries aliasing the
same guest-physical range, inflating iov_size() to nearly 4 GiB while
referring to only a small amount of unique memory.

Instead, cap cs.size at 4 MiB. With 4 KiB pages and QEMU's
VIRTQUEUE_MAX_SIZE (1024) mapped-iov limit, the Linux virtio driver
cannot carry more than ~4 MiB of inline command data, so legitimate
submissions are unaffected.

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h   | 8 ++++++++
 hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
 hw/display/virtio-gpu-virgl.c    | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc194627..c10bfbd596f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -299,6 +299,14 @@ struct VirtIOGPURutabaga {
     struct rutabaga *rutabaga;
 };
 
+/*
+ * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
+ * limit, the largest inline command is ~4 MiB.  Cap submit_3d
+ * allocations to this value to prevent a malicious guest from
+ * triggering an OOM abort via an inflated cs.size field.
+ */
+#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * 1024 * 1024)
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t virtiogpufillcmd_s_ =                                    \
             iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 6ff12639012..4d7d7b24592 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -351,6 +351,14 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(cs);
     trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command buffer too large (%u)\n",
+                      __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_new0(uint8_t, cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 60c78af06a4..d9e5b011049 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -607,6 +607,14 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
     VIRTIO_GPU_FILL_CMD(cs);
     trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: command buffer too large (%u)\n",
+                      __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_malloc(cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
-- 
2.55.0


