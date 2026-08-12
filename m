Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B0BC5DF61
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8d1-0004kt-ED; Wed, 12 Aug 2026 09:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cr-00048j-Iv; Wed, 12 Aug 2026 09:04:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8cp-0004Qj-T1; Wed, 12 Aug 2026 09:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=Oh374S/rWmOdxx0wbCJekFgaGU3ELY5ujiV+puhHXcI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TlZqvMOebSgTXYByZIKFvY4rqEIw1hWqBOfqGrqn+6vVt6GF3l2gPI8/ydIgYs6K0
 QLZx56npJeNsotjMEVUdMF49cEYv9tvV8e5DzXhYhicByciYR/8lGR9MTJmnVo2mCG
 2BVtYvOo/ntepnjCohsthgVIc6Ue6JNz8fO/ev+H9w2cfymll4miux7/wwNlj7V2jF
 SGiWt9QSpWv7MEoSo5LdHo8WOFa7jI1jR+eIUuZjL+QopWCnCh++HEpMbbXMNbnqHe
 Zv6Umc5tzdsjLpsLn1T1iiRlROW/PGSqMK5N1LfpXwObW6ixcZq5zZU1upOTnhMqz3
 ro07RiHxFtZBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 542341CA490;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A9B2409B73;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id ECD0F2F8B6; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jia Jia <physicalmtea@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 017/102] hw/9pfs/virtio: drain in-flight PDUs before
 virtio-9p unrealize
Date: Wed, 12 Aug 2026 16:00:52 +0300
Message-ID: <20260812130233.621965-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
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
(cherry picked from commit 210701c82e304622818989028e75192013cb81d8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index f3fabf2abd3..cc9582c5f7b 100644
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


