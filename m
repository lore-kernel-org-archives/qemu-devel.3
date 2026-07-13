Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480B6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGAw-0004lE-VK; Mon, 13 Jul 2026 08:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGAv-0004kh-0g
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wjGAt-0006AV-AA
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LSEdgwftzglGFzLwr5Qy8jMdq22XlZhEuXWxQ0FbgUo=;
 b=eUbYngzQWAUUV3EQA5Cl8zQ60onsI2liStso4bVJasHroNF7INUlGQpCOQ9rq8k3ioevhn
 RCylOPV5BoSPF3Rnly0rViiF2ezClSacAWC8iiv/Mkqw82aXESw8O56Y9zyah/dJVNFK0K
 +e3fW8VDHMWtYzzmTxbaoJGxLrAIHP8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-4OmrPq-pNXyL2WE0KCmCmw-1; Mon,
 13 Jul 2026 08:54:16 -0400
X-MC-Unique: 4OmrPq-pNXyL2WE0KCmCmw-1
X-Mimecast-MFC-AGG-ID: 4OmrPq-pNXyL2WE0KCmCmw_1783947255
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14F541955D95; Mon, 13 Jul 2026 12:54:15 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 922F536F29; Mon, 13 Jul 2026 12:54:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] hw/display/virtio-gpu: validate command buffer size in
 submit_3d
Date: Mon, 13 Jul 2026 16:54:10 +0400
Message-ID: <20260713125410.105653-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
g_malloc() without any bounds check. A malicious guest can set this
field to an arbitrarily large value (up to 4GB), causing an OOM abort
that crashes the QEMU process.

Validate cs.size against the actual descriptor payload size before
allocating, rejecting values that exceed what the virtqueue entry
can carry.

Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering support.")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
Reported-by: admin@fluentlogic.org
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu-virgl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 60c78af06a4..2a07dd2431f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -601,12 +601,23 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
                                 struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_cmd_submit cs;
+    size_t iov_len;
     void *buf;
     size_t s;
 
     VIRTIO_GPU_FILL_CMD(cs);
     trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
 
+    iov_len = iov_size(cmd->elem.out_sg, cmd->elem.out_num);
+    if (cs.size == 0 || iov_len < sizeof(cs) ||
+        cs.size > iov_len - sizeof(cs)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: size out of range (%u/%zu)",
+                      __func__, cs.size, iov_len);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
     buf = g_malloc(cs.size);
     s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
                    sizeof(cs), buf, cs.size);
-- 
2.55.0


