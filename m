Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F3C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8fJ-0002MB-El; Wed, 12 Aug 2026 09:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fC-0002GD-VN; Wed, 12 Aug 2026 09:06:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8fB-000551-9Z; Wed, 12 Aug 2026 09:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=qUFN3BNC7X+PvuN5YFX16fykneYkYDjNc+2zRtoHuQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UG+98UmABC+VPoc6kiusi9MNuGyBtMy0pOykpGqO6Dbo/jOTkqwn9hqT4lmtZLrml
 ab+60JQ6iU2h5nkoniEVsA8d3X4+ybwLV7KdXg3+uY4U/R6RRAV2nNqfL1tIaH6oD7
 oK/vh1pI9bEsZRFeLuGZIUUfB4KYF9m1Dx054WvGZ/2x3Xg6Jhlc2dzHYu1mXI6wh2
 wRpn2eqN7PLKK0Kq1lE1Te7g9NPCiyOSAFtWmU26A1A5xnS63MxBXigEbnwT1vrvUV
 kXx0bH+IGN5UACowCN43+DwOJl9Bbob9u7/8uhP2cZf0KKg2vnu/uSOSasUwEqA5Zd
 CpseVjlEEW6ug==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C9C911CA4A7;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0BF04409B8A;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 336AA2F8E4; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 jasowangio@gmail.com, dong ling <dongling226655@outlook.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 040/102] hw/virtio: reject zero-length packed
 indirect descriptor table
Date: Wed, 12 Aug 2026 16:01:15 +0300
Message-ID: <20260812130233.621965-40-mjt@tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

The split-ring path already rejects a zero-length indirect descriptor
table since commit 7423192912af ("virtio: add checks for the size of
the indirect table"). The packed-ring path is missing the same check,
allowing a guest to trigger an assertion in address_space_cache_init()
with a packed indirect descriptor that has len=0.

Add the same !desc.len check to the packed-ring indirect validation
in both virtqueue_packed_get_avail_bytes() and virtqueue_packed_pop().

Fixes: 86044b24e865 ("virtio: basic packed virtqueue support")
Cc: jasowangio@gmail.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3984
Reported-by: dong ling <dongling226655@outlook.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260715115040.2186274-1-lvivier@redhat.com>
(cherry picked from commit 6dbdc271f56b42e921a662b65a862f503eb4448e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 215c95eccfd..7510eb34dc5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1426,7 +1426,7 @@ static void virtqueue_packed_get_avail_bytes(VirtQueue *vq,
         }
 
         if (desc.flags & VRING_DESC_F_INDIRECT) {
-            if (desc.len % sizeof(VRingPackedDesc)) {
+            if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
                 virtio_error(vdev, "Invalid size for indirect buffer table");
                 goto err;
             }
@@ -1876,7 +1876,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, size_t sz)
     vring_packed_desc_read(vdev, &desc, desc_cache, i, true);
     id = desc.id;
     if (desc.flags & VRING_DESC_F_INDIRECT) {
-        if (desc.len % sizeof(VRingPackedDesc)) {
+        if (!desc.len || (desc.len % sizeof(VRingPackedDesc))) {
             virtio_error(vdev, "Invalid size for indirect buffer table");
             goto done;
         }
-- 
2.47.3


