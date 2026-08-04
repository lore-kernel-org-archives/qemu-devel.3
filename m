Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E79C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9RL-0000sq-U4; Tue, 04 Aug 2026 03:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9RJ-0000qV-Oa
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9RI-0001G2-46
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785827990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3AnR5+gsJzHOo4gwdjec5GVmM1fFGwyr/nH1Jm5SbeU=;
 b=FIQ7FU/oVAsuD4ZnTur24TGkGvgY6CDyz2r4drplN+3JoT9tJ1t4JYA41RynnHAf0fDjaF
 ZDxMDmN6ZnJa7QZKWTdQE3eDlg/WNGXLxHXMF/wacA2lN7LQgm4Kmul5ntlY5IWQC32hea
 K8bf19OiTnzfsbh4dHWkthH+wTA65BE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-Ll1zFr1SMcqGk_uPHUv2eQ-1; Tue,
 04 Aug 2026 03:19:46 -0400
X-MC-Unique: Ll1zFr1SMcqGk_uPHUv2eQ-1
X-Mimecast-MFC-AGG-ID: Ll1zFr1SMcqGk_uPHUv2eQ_1785827985
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98F6319560AA; Tue,  4 Aug 2026 07:19:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 040DE414; Tue,  4 Aug 2026 07:19:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 11:18:50 +0400
Subject: [GIT PULL 1/9] hw/display/virtio-gpu: validate blob iov size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v1-1-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6qeQBZsDpxxlBX+APuClWKzBBwDA/wesXR/QCuI+oMI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJcr4E3CvzxIOj/+6K9KLTkFdn+vGML0ULhT
 AND/7u1TOSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXAAKCRDa6OEJdZac
 5SjKD/4ib11IR0bPyri0ox7hu39KM9FzXnU4Ac2uQOlV+AvTtDs71VFOF3DrinHU1synkwb7CYF
 X7CexXSAqKy6d8QWWe6EMu4j3rkMkQ4n8MBPVBuOOPxRw9fTgTEpOiH7iES2JkWaftknW7dE4PF
 HLgLx4G2CcRUHz8IRw/pQj6EbGt+vYALl0C/748DR7YBFR2KbCofdeIUQC0X+IEci2KL7P3bNp3
 nHajmky31u7rwdQcOi5ioNZOrz3dE19SDUaA3RN8amV36CmboAQEP0ZWY2RQNPzW7yeA+vDjA77
 MUOHGqadD8+kuST5iHBdsKUr6pHGrwgkFgyfagh8e+1J1sxSJUSjCZFzSPlbuXWF51AxSn0kc8y
 6Q8YSERrkoWVHwiVunMEPN5lj4TOFIEKeMyMCY64dLI80Z9IMYekvy3HeqtSROGZQE9aPU/+lq7
 Df4nhijQ6wPhDtsZuNiL9YcQRcdvVg4WxdDZWUi/CSPl4SEQvK2RSLxYsT/Qlnko7j0xNeSJ1On
 SLy5DPlERB0bmWW6aKxwMhnh0zYrgJNadcoS/nb85eR4UFHM6oI+TK//Dt3E6FGwLwwDo/ywpi/
 4duakQVeXG0VCC21mHWlxriHslcu9dh9gaIRrF5/dPlgUttj2CTOFhmZGuF93N3nws3q+12C0jd
 KbmDi2H47kyPn+Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
without checking it against the total size of the iov backing entries.
Since both values are independently guest-controlled, a malicious guest
can set blob_size much larger than the actual iov backing. Subsequent
SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
a pixman surface to be created over the undersized buffer. Any display
refresh then reads past the actual allocation, potentially crashing
QEMU or leaking host memory contents depending on the backing type.

Validate that the iov backing is at least as large as the declared
blob_size in create_blob (when nr_entries > 0, since the spec permits
deferred backing), attach_backing (when attaching to a blob resource),
and the blob migration load path.

Fixes: CVE-2026-66021
Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260729161431.1180691-1-marcandre.lureau@redhat.com>
---
 hw/display/virtio-gpu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 4d46a4eb10fa..0206910cc377 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -372,6 +372,17 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
+    if (res->iov_cnt > 0 &&
+        iov_size(res->iov, res->iov_cnt) < res->blob_size) {
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
@@ -993,6 +1004,15 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         return;
     }
 
+    if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: backing storage smaller than blob size\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        virtio_gpu_cleanup_mapping(g, res);
+        return;
+    }
+
     if (!res->image) {
         virtio_gpu_init_udmabuf(res);
     }
@@ -1493,6 +1513,14 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
             res->iov[i].iov_len = qemu_get_be32(f);
         }
 
+        if (res->iov_cnt > 0 &&
+            iov_size(res->iov, res->iov_cnt) < res->blob_size) {
+            g_free(res->addrs);
+            g_free(res->iov);
+            g_free(res);
+            return -EINVAL;
+        }
+
         if (!virtio_gpu_load_restore_mapping(g, res)) {
             g_free(res);
             return -EINVAL;

-- 
2.55.0


