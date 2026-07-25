Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10E4C531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnaMX-0007Zv-9O; Sat, 25 Jul 2026 07:16:13 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <210701c82e304622818989028e75192013cb81d8@kylie.crudebyte.com>)
 id 1wnaMK-0007X2-Tv; Sat, 25 Jul 2026 07:16:02 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <210701c82e304622818989028e75192013cb81d8@kylie.crudebyte.com>)
 id 1wnaMJ-0006S2-A6; Sat, 25 Jul 2026 07:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7e8LVU/rsCT7MMw3bX47FbjQLU6TBQu/kiitDZjF+u4=; b=AOTrW
 Y7E2Vbv1TA4fJi20yxXTsIhTCdSrsl8uARABsOFQzAkvKDdB/tohrYRPWECucmLbEj/l3NNwmLShj
 48w//xYAgcoIg2OtLfekxdf9fJf1NjGNrkVJLUFVVsj3vYNX1NwKlP2HMWCj+BU7hnz9T8O2ec41C
 A8JZBVjcSz9nm/2xkNvMP8AgJ5i7khohUSlyN5BxfEmK6RCYWGrWSUkvKCoJn6weIxJaq5mlZAwh8
 k6v6FEjqpsyC5feFdxRnNifzGWUVoW4wIdy3wLkV10i/ejYh3UtPlcbTyxSVN6cNeO2+AVNnsXgoS
 mH9UASwGKXp/cRlau7EASvAluOUFI6BenCFT003OajW8P7qUfdVOGJyEV9LMadUoa/3OxbtBeYiKE
 hMcvl9EN3NjJuV+6iSisISvAhkcZlpzEdklnVm9OnXNGpbHOWMg0yOl2w/IxARM1Xik5BWVL1sdCv
 EkVFwhHV+6iCBrUEM75PtWwXvAFuJjUdUS5d7Vg9qtk4tLCo+GkrVOhaxyKXdH1fjan0n5PHs9KGC
 8AjYoPJrgGQueyS9/Ep/LujIsEXUXYVinoKr9ZMgtJtDNllCQpWK3yNJkWZPC45c0EgFyJesKGS0w
 d3TzZpSjvN1f7XVYYj5Kq9GaJ2erCMULpsgkZ+d9G0IFrdx1P+dlHh5EpqS5uU=;
Message-ID: <210701c82e304622818989028e75192013cb81d8.1784977523.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784977523.git.qemu_oss@crudebyte.com>
References: <cover.1784977523.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 25 Jul 2026 13:05:24 +0200
Subject: [PULL 4/5] hw/9pfs/virtio: drain in-flight PDUs before virtio-9p
 unrealize
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>,
    Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=210701c82e304622818989028e75192013cb81d8@kylie.crudebyte.com;
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
Link: https://lore.kernel.org/qemu-devel/bc503aefffd20b1806941b3ef708afbd92f0aef2.1784809978.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 50dc93091d..576a794ea4 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev)
     V9fsVirtioState *v = VIRTIO_9P(dev);
     V9fsState *s = &v->state;
 
+    v9fs_reset(s); /* cancel all in-flight PDUs to prevent UAF */
     virtio_delete_queue(v->vq);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s);
-- 
2.47.3


