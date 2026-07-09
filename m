Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61B2C44501
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpOT-0006kF-B8; Thu, 09 Jul 2026 10:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a25a3dbb8581c265d5eed2298738c6bfedf9cc38@kylie.crudebyte.com>)
 id 1whpOS-0006jz-NF; Thu, 09 Jul 2026 10:06:24 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a25a3dbb8581c265d5eed2298738c6bfedf9cc38@kylie.crudebyte.com>)
 id 1whpOP-0003Ei-Dn; Thu, 09 Jul 2026 10:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=5kVAY5lFZkNqOZV7lvL5dd8Ah9g7M/jRqmCC6LpOgYs=; b=dF48X
 QNKxTvcMfcsuMqCDyrEIYh8KQgK5ezHRhwC5s0t+g8xzmqZptdswz1dHnyqIZDmm9y1JUmbOXsV40
 zzddeGUZwRCYGDpZwWmKB2NUwh/Hcff9M6/j70ONY2qjFwyHuuzMumc01mE0RPPfIubZHJT+Fy88L
 6xpKUkUoUJgCZ/bb6EHjlohbOomUiM/UvcRUZhfnNn3kbCnjsTyTtKyWn7IaC8gsvSyfAoKrwwDDc
 RChxUZxvHu7EzPWZx1WvBY369l0l5MXiqf/6ZSxUelme2ewwj0sLLNurMBFJDxEDHE8fFApEuNb8Z
 8CsVh7CN5/LtGVEDo+vCX3rZGkCCDttodKqf0tCoPu01cRvD3TC31b/7GmbTp/hmJE4cCVDsiOnHn
 ARI4tnMu/Vf2CnJGgUP+ph+TNFg8txuMsEmRZIAifHuYfcGF653rz5ncwbqgW9PcCIyMa7X5MsPvk
 k2la925rej202Yb7V6A9bN5iNP4WLzrorB/CW2ZjgApElztTwto7nDyLmGXGajeFwmA6Q6M51MBTb
 fu0uqhmtkGAHp1Kd0DF2L4RPDSmxn21JX6TGZuMFi3J1gVq6v7Mt9NLhE/YG0Dv0UokuNJKLVrzGp
 w4zcacIG3Qmz+B0Tf4rlemdLg6W54nQecgWN8JdDdFUerTIbZdtNjORIlk6JDc=;
Message-ID: <a25a3dbb8581c265d5eed2298738c6bfedf9cc38.1783604079.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1783604079.git.qemu_oss@crudebyte.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jul 2026 15:50:36 +0200
Subject: [PATCH 1/3] hw/9pfs/virtio: drain in-flight PDUs before virtio-9p
 unrealize
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a25a3dbb8581c265d5eed2298738c6bfedf9cc38@kylie.crudebyte.com;
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

A guest can trigger a heap-use-after-free in the virtio transport
unrealize path by submitting a Treaddir request and immediately
ejecting the device via ACPI PCI hotplug. The unrealize path frees
struct LocalData while a worker thread still holds a reference
on it, causing a UAF in local_open_nofollow().

Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
before final server cleanup. This ensures all coroutines completed,
all FIDs are closed, and no worker thread still holds references
on 9p server state when it is freed.

Reported-by: Jia Jia <physicalmtea@gmail.com>
Suggested-by: Jia Jia <physicalmtea@gmail.com>
Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
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


