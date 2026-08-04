Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C0EC55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKmZ-00079w-2d; Tue, 04 Aug 2026 15:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmX-00079W-Fw
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmV-000578-Qa
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3AnR5+gsJzHOo4gwdjec5GVmM1fFGwyr/nH1Jm5SbeU=;
 b=fAQ8TxxQnsc9YylfKb0JYpKuU63DJfLspHdvCDtO8hgSlPw9HLRTGzLPJ/JSEDufIC11Cr
 EIaG8C4K97jY4Gb+nTCvSN8eARIppp4losGSJ+DqwTRK+rgCILxsU265W5G5ZEOahXKvXE
 4odDlLoNyUmeXqiGtvS1e7KFlYktgKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-R7yWLd5WNwqyc_wJKOIBYw-1; Tue,
 04 Aug 2026 15:26:24 -0400
X-MC-Unique: R7yWLd5WNwqyc_wJKOIBYw-1
X-Mimecast-MFC-AGG-ID: R7yWLd5WNwqyc_wJKOIBYw_1785871583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5A19180029F; Tue,  4 Aug 2026 19:26:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DDB9195608D; Tue,  4 Aug 2026 19:26:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 04 Aug 2026 23:21:48 +0400
Subject: [GIT PULL v2 1/9] hw/display/virtio-gpu: validate blob iov size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-fix-v2-1-70e8fe489c9e@redhat.com>
References: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
In-Reply-To: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6qeQBZsDpxxlBX+APuClWKzBBwDA/wesXR/QCuI+oMI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzTrJ24WrnX5cQcnTz1mOM2nAxg/RMisUelh
 zSaUijSwxKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI80wAKCRDa6OEJdZac
 5YqbEACKmtpoPc4P51KES+0o++gySiFqruH2h87kkwLylLtxsvat4ckRZnUGzOndqSzdvGnWZSm
 gFl+LxsX+tCHXklrs7SdosLiJsUPydvCSDbtwMlhiFI1mMQjzhFYpoC9JZgkWnOoq7IIkQgj3Xw
 ou9RRVyFX4j6dgJMYd5BGlspwk+9fPu+nHGrONdwk5NzY3jXoiS9LgCl6k1DGwco/ntibL5Amql
 MljZsGUKFbXhfRJm1LjzlFel4epalXoT4ae387sArZBif8uo/oF+X2ZhIYbh5soPbHzq/Ja275H
 wuWKmgyrHHd30CkLkLB0EgnViakXYW+v9214Zw77r3PwwFTjgcATEC51yCzvbHZ7Zhc9W3LfEk+
 AIRwyi0X7c1GrBu9cMIDHwovUGwY+7yYGIFEj5qiIej/20x7GhQNfFmVSf4QYNsEQwmft5LPRPG
 PTd8xN3y3GVBh1WP46tO4Oips5RIVS3B8Bm1dt1jZGSe37U0+O4irpwOroTkWO+fKXj4pmMEbbR
 aiev3ygv5I71E7MD8PdyuFIUk6kGcqYX3RHo/lC/S4yqK4QUpJ3tTiek42GviQzOc19JLucGJFP
 S7yx5OYPDYGMacngklqKKQ747fkZyLIt85MiNJtTBXz/swdtYEhu3uJ5tWCbFv9J3ZHQ1bFLNJH
 28Re5oQWT03rFig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


