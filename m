Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AF4CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcGb3-0002Cd-O5; Wed, 24 Jun 2026 01:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGb0-0001ry-HB
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:22 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wcGav-0007IP-EM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 01:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782280560; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=IK9vwdDkouL8wrN92t1Xa5aGiE/m6O0md75byRhvJJ8=;
 b=dtByWnLdTclmqkMt2RLZ/ASmbT/uhh8mHUHHSWDNZQTnGnJao6dwqxSGe6kPSn47mbDk/RuekGiDbAZrSvmvGBSsD5lYaXVNJ/FJt462G+pKnbKBIy6bUFvsgV5cK8/ji2fx73nbeeRhvBOuXapGkAKGJma//QPF5tw7iprHMqQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032089153;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0X5X450F_1782280559; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X5X450F_1782280559 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 24 Jun 2026 13:55:59 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: alex.bennee@linaro.org
Cc: mst@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 dmitry.osipenko@collabora.com, qemu-devel@nongnu.org
Subject: [PATCH 1/3] virtio-gpu-virgl: validate resource existence on ctx
 attach/detach
Date: Wed, 24 Jun 2026 13:55:55 +0800
Message-ID: <32f6f23fb4880a4f1ec3056fde306332d54e442f.1782270919.git.guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1782270919.git.guobin@linux.alibaba.com>
References: <cover.1782270919.git.guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=guobin@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The CTX_ATTACH_RESOURCE and CTX_DETACH_RESOURCE command handlers
forwarded the guest-supplied resource_id directly to virglrenderer
without verifying that the resource actually exists.  A malicious or
buggy guest could reference an invalid resource_id, potentially causing
undefined behavior inside virglrenderer.

Resolve the long-standing "TODO add security" comments by checking the
resource against QEMU's own resource table (virtio_gpu_find_resource)
before forwarding the request.  This is consistent with how other
command handlers in virtio-gpu.c validate resource references.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/display/virtio-gpu-virgl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 60c78af06a..b992ffc44e 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -743,6 +743,14 @@ static void virgl_cmd_ctx_attach_resource(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_res_attach(att_res.hdr.ctx_id,
                                         att_res.resource_id);
 
+    if (!virtio_gpu_find_resource(g, att_res.resource_id)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid resource %d for ctx %d\n",
+                      __func__, att_res.resource_id, att_res.hdr.ctx_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     virgl_renderer_ctx_attach_resource(att_res.hdr.ctx_id, att_res.resource_id);
 }
 
@@ -755,6 +763,14 @@ static void virgl_cmd_ctx_detach_resource(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_res_detach(det_res.hdr.ctx_id,
                                         det_res.resource_id);
 
+    if (!virtio_gpu_find_resource(g, det_res.resource_id)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid resource %d for ctx %d\n",
+                      __func__, det_res.resource_id, det_res.hdr.ctx_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     virgl_renderer_ctx_detach_resource(det_res.hdr.ctx_id, det_res.resource_id);
 }
 
@@ -1073,11 +1089,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
         break;
     case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
-        /* TODO add security */
         virgl_cmd_ctx_attach_resource(g, cmd);
         break;
     case VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE:
-        /* TODO add security */
         virgl_cmd_ctx_detach_resource(g, cmd);
         break;
     case VIRTIO_GPU_CMD_GET_CAPSET_INFO:
-- 
2.50.1 (Apple Git-155)


