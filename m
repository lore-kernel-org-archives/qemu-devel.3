Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF8C4453D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn72T-0007Zp-9l; Thu, 23 Jul 2026 23:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wn72R-0007Zc-Tv
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wn72P-0007In-7X
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 23:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784865447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=naIx8vuJNZwvieRfVQ5Og0LBIoNq1IaWbSfegzpuSmA=;
 b=GJB50hgMC69/z8OPy070FLbxCNFcVAVIckwQOkw6CyeGNpoFqm/Q/mNu3Ay1ZeWZco9BmR
 JSD8uGnwfXv3BnD/+WwxH3BeofucfxmUIyg6tjWMTvpgoV1YpD7ZNn0grChc79QhP78L3K
 b1Ugr5l/koeZ29yeai366Or/Z9syylM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-BPllQCQdNG-iWOUJ528AMA-1; Thu,
 23 Jul 2026 23:57:23 -0400
X-MC-Unique: BPllQCQdNG-iWOUJ528AMA-1
X-Mimecast-MFC-AGG-ID: BPllQCQdNG-iWOUJ528AMA_1784865442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25ACA182F568; Fri, 24 Jul 2026 03:57:22 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59C3130002CE; Fri, 24 Jul 2026 03:57:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH] hw/display/virtio-gpu: validate blob iov size in create_blob
Date: Fri, 24 Jul 2026 07:57:12 +0400
Message-ID: <20260724035712.856636-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
without checking it against the total size of the iov backing entries.
Since both values are independently guest-controlled, a malicious guest
can set blob_size much larger than the actual iov backing. Subsequent
SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
a pixman surface to be created over the undersized buffer. Any display
refresh then reads past the actual allocation, potentially crashing
QEMU or leaking host memory contents depending on the backing type.

Reject the resource early when the iov backing is smaller than the
declared blob_size.

Fixes: CVE-2026-66021
Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index eac039c3c366..cc6dbd116618 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -372,6 +372,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
+    if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: backing storage smaller than blob size\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        virtio_gpu_cleanup_mapping(g, res);
+        g_free(res);
+        return;
+    }
+
     virtio_gpu_init_udmabuf(res);
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
-- 
2.55.0


