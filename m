Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3B0C531CA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmsq6-0008QE-J5; Thu, 23 Jul 2026 08:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bc503aefffd20b1806941b3ef708afbd92f0aef2@kylie.crudebyte.com>)
 id 1wmsq5-0008Pb-1Z; Thu, 23 Jul 2026 08:47:49 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bc503aefffd20b1806941b3ef708afbd92f0aef2@kylie.crudebyte.com>)
 id 1wmsq3-0001At-Hx; Thu, 23 Jul 2026 08:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=TnTyMGcps9pLzVD+xAJmeZIkZhLzfTw6EtxKWuY+Rlk=; b=em81i
 e1qWzqIhGv409/7mFWtZTK9XGcBCXAUFM9qrFS4WaVHA/Pt9s8gLiNSOVAcqfZW4Y4P6BIKPd7vB5
 ufPTFP5S/qiCnH6Vd7OSmp61FWcHguMHIQaLSrlz/DR30WceAKz9elIKRomfsvGv6isFC1Np1bt0e
 +LXE4JutFmuWBOCZtNcJe7Zx8hjwJYlLUWfFkhzCAAZT6ee05kbfHvEOgP5lHHQ9QtXdGheQMOR2S
 nDn0ULrFVvK0LKfHoIB9FnxO+rswDiztqhT+ErhYfnvBpvv/LaHujvOo3Koj4hkF1rB9QWr5BNYeQ
 /E40+JvbnFZBaKmT6P9DXY1b1EE9KQjnQWy9Pxdacp++YeVbh4XKe0ISQFwzS7ANiWos/y8jjFuwY
 lvgyJXDewjWhZidBo9ERUHCKD+HO0K/9tGPWY8qRb3Lc9vEIXU1SRulpwpJ1ob/AyfSMrmdBPSMzF
 5XC2kmC67QGdHjfH9KXgtJjoYrA3oHft7v1jIMaW80mAu0YFgGbJxykY67SMFV0kUAjOYowPqNpzI
 INDSHl5PULp1t8qC6ZvyxSJaRUw/lRyc20ECTP2b0oCugx7zSmuU3N2hGS8iy3w1y9itnN15m+sOf
 ESgiQgwigC/jk4C/xOdHNdTJT79uPoXNphpHdtW6vzXx+qkJJ9Zf6/fgasl9vA=;
Message-ID: <bc503aefffd20b1806941b3ef708afbd92f0aef2.1784809978.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784809978.git.qemu_oss@crudebyte.com>
References: <cover.1784809978.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 23 Jul 2026 14:43:24 +0200
Subject: [PATCH v3 1/2] hw/9pfs/virtio: drain in-flight PDUs before virtio-9p
 unrealize
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=bc503aefffd20b1806941b3ef708afbd92f0aef2@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Jia Jia <physicalmtea@gmail.com>

A guest can trigger a heap-use-after-free in the virtio transport
unrealize path by submitting a Treaddir request and immediately
ejecting the device via ACPI PCI hotplug. The unrealize path frees
struct LocalData while a worker thread still holds a reference
on it, causing a UAF in local_open_nofollow().

Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
before final server cleanup. This ensures all coroutines completed,
all FIDs are closed, and no worker thread still holds references
on 9p server state when it is freed.

Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
[ Christian Schoenebeck: add commit log message. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 50dc93091d..1ec48fc9e0 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev)
     V9fsVirtioState *v = VIRTIO_9P(dev);
     V9fsState *s = &v->state;
 
+    v9fs_reset(s);
     virtio_delete_queue(v->vq);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s);
-- 
2.47.3


