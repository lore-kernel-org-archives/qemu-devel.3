Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6099FC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8n8-00057u-9Y; Wed, 12 Aug 2026 09:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kC-0003G4-U4; Wed, 12 Aug 2026 09:11:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8kB-0006G5-3K; Wed, 12 Aug 2026 09:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=/AGXMWzIUO9Ado81QEBXfUF3gEbFN84+SWuo1bltgL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EpAd3pBgaJqJOnwf/11kAQZBh6SnujnTzpj10ZFRQl59cQkifnsj0p1m2QnBiS0nh
 Ckk0E3gvt2JG69FOitZ2YQygTpv4IusTfPfLpQCXt4zDt3xOw4NDRSFyI5b0n0URLE
 /KKxm7UR1zmkByGrxJ9AV+wWl5fM/32FV0uo29KL8AS73ms98q9baVbxAYIt1ib0/d
 Lx80ibQ7kEupQ5rrnQnC46XXnhocUZ5kC3iHCHjTFpH2l7e7QOoEAwTymS7yhFIRY+
 gV42HQ4uH8P4jceMQoAhKmNN3Hxumix/Kut/gFm7OLoyyy7A396SHW+9D4/tMjV3+w
 mX1Uum7cL/oGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4CFD1CA4D7;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DAC03409BBA;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B6A1A2F944; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?sundayjiang=28=E8=92=8B=E6=B5=A9=E5=A4=A9=29?=
 <sundayjiang@tencent.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 088/102] hw/display/virtio-gpu: validate blob iov size
Date: Wed, 12 Aug 2026 16:02:03 +0300
Message-ID: <20260812130233.621965-88-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

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
(cherry picked from commit 241095547a5d87ad6fa68cd674fe524e6596b958)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index c34a09e82b1..34b8bb053dc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -368,6 +368,17 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
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
@@ -989,6 +1000,15 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
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
@@ -1478,6 +1498,14 @@ static int virtio_gpu_blob_load(QEMUFile *f, void *opaque, size_t size,
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
2.47.3


