Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92884C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8x-0005Tf-Fd; Fri, 17 Jul 2026 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8u-0005Eb-Q4
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8s-0003Sy-VB
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2DjTqkkGv9hx92D0WNYid3pXflD4YCT9E+5cXBSj1I=;
 b=imq+znKrdECkWocU3NHNDkLZ4SNWk1cDzJ5qj5xCGfOkB067VdU4AN7MqAydyd4JTiyVRp
 Paj1vEyPPvcftTxWNKq8bKD041blpaqoudIgxUAm04HzpyCTqRLFUWJzQEYX018P0jHWRc
 1dle+OyGDO5K/3MHB8t9C5uVi/EW4vc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-Hr_KGsFdP0-PGDQ2N7KmQA-1; Fri,
 17 Jul 2026 07:54:08 -0400
X-MC-Unique: Hr_KGsFdP0-PGDQ2N7KmQA-1
X-Mimecast-MFC-AGG-ID: Hr_KGsFdP0-PGDQ2N7KmQA_1784289247
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A13BF180076C
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA9A3180034C
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:54:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:51 +0400
Subject: [GIT PULL 12/15] hw/display/virtio-gpu: cap submit_3d command
 buffer allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-12-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5772;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VQljr2kxfrhnVUh+A6NaCNU6GmJHaoU7bUMaNpXzZwI=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheag3kcE1OyfX3Ug/VwkWaZ8RY8P/GmR8nS6
 QJWnE9Pv8qJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmgAKCRDa6OEJdZac
 5YwTD/jIPrT/3ik94/GS8TFZE5O9uj0w/YdQ6wsvKlnKcpfP6jUnZBf1f3iIrWSzLMyvRGQU04I
 CybmjbMj1b8t1grVhFBU/G5LiH4ndBp53dZsvjODNWjkII2aAYGj+GSyYVECt4RATNUtj0MlQk3
 HhVU0jVNMgdFR2hQgAVDpLe1GRk40WFjYRe/cKZUK/pw/n1A0NZu/ga4KqBqrXJ3+2kyYOO8w3c
 P5f59KOc1zwqXd2fgKG8c+sQkzvGq6FRVLpmklruX3Nw6pGXI+dpjyccPZzuPJerMcE6blwWbBN
 tN4XaPTnu+/GnRaiLyxcWbEwcql8jNXRD7cuF0a4yYiuwrZ2UVbCPWXsUqB+eaHCD9fGPgt+/EZ
 KSzG45m2UWsrN/VLUGWO1RCUikggdfu9itLV30zyMFCqQeOlKMgzMpUa/xKW2jdaeGv6tg7JWVR
 quxRlB4LL0WMfwuGmmHIGfaGQE9aTAmNTCMyMjxg5q5nOOmPCgMLNrGt+r6jD5L5zjEPS4WWRFw
 mBpT0VaOI0ct0B9c3euceKn0yD/i0wkLxzUzBZiVMRcRYLhl42Jucn7I/GJ5b6rEYPCwnFI+5bg
 mbI4YAg2RoRE6g9vB9jaRnPaWlrSgwuJmpbLatOj5hqVa85qgM+xK3M6sr1WGXzPzXlCiOrJtCA
 P4AjAROv6mIA4
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
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
Fixes: d52c454aadc ("contrib: add vhost-user-gpu")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vugpu.h   | 9 +++++++++
 include/hw/virtio/virtio-gpu.h   | 9 +++++++++
 contrib/vhost-user-gpu/virgl.c   | 7 +++++++
 hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
 hw/display/virtio-gpu-virgl.c    | 8 ++++++++
 5 files changed, 41 insertions(+)

diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index 654c392fbbf..2374eb90cb9 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -22,6 +22,7 @@
 #include "qemu/queue.h"
 #include "qemu/iov.h"
 #include "qemu/bswap.h"
+#include "qemu/units.h"
 #include "vugbm.h"
 
 typedef enum VhostUserGpuRequest {
@@ -163,6 +164,14 @@ struct virtio_gpu_ctrl_command {
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
 
+/*
+ * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
+ * limit, the largest inline command is ~4 MiB.  Cap submit_3d
+ * allocations to this value to prevent a malicious guest from
+ * triggering an OOM abort via an inflated cs.size field.
+ */
+#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * MiB)
+
 #define VUGPU_FILL_CMD(out) do {                                \
         size_t vugpufillcmd_s_ =                                \
             iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,  \
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index f69fc194627..b9bad27c97a 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -15,6 +15,7 @@
 #define HW_VIRTIO_GPU_H
 
 #include "qemu/queue.h"
+#include "qemu/units.h"
 #include "ui/qemu-pixman.h"
 #include "ui/console.h"
 #include "hw/virtio/virtio.h"
@@ -299,6 +300,14 @@ struct VirtIOGPURutabaga {
     struct rutabaga *rutabaga;
 };
 
+/*
+ * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
+ * limit, the largest inline command is ~4 MiB.  Cap submit_3d
+ * allocations to this value to prevent a malicious guest from
+ * triggering an OOM abort via an inflated cs.size field.
+ */
+#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * MiB)
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t virtiogpufillcmd_s_ =                                    \
             iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 51da0e3667f..550fd03bf5c 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -202,6 +202,13 @@ virgl_cmd_submit_3d(VuGpu *g,
 
     VUGPU_FILL_CMD(cs);
 
+    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
+        g_critical("%s: command buffer too large (%u)",
+                   __func__, cs.size);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_malloc(cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
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


