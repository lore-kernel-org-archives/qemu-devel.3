Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA421C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAN7-0003ip-F6; Wed, 12 Aug 2026 10:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAMP-0002AN-F0; Wed, 12 Aug 2026 10:55:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAMI-0007vg-Mh; Wed, 12 Aug 2026 10:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=RU7PGg/8CgB1rXrLOry6ym2cJR/WFl9hoFv43FpgAfM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KRsbt/M/wlInnY4KDcCEKMbUP0krt0i8OqvdhrcAFG1J3SXx1o8ZV80mALoPRZ07Z
 FSOpFlLQM/Uw5m01IsAD5yBVx9YnFQYSLhARLUvJUSI5SSQXldACd5DziuoO3htFyw
 rkfBKCvNMPlBdQmihzZ8Hbhz2vDWrxoKuM5+eXesjxdeH5G5naP2FeEZGQEYJkkTJE
 nWvDKfsHfdwLPumX2Gt7LpVj0QBfWQgNC5+t/3FIa/m7r/c+GuWHbv3lXwQ/RxwkMY
 TIDUV/FJTSwziVYR7yP6AxSLSfd8ZlFtRboBQGRlP4rSLbpjzgQl5NPpZMqXRW5Vfx
 0M5tldUrYocmQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 259CC1CA637;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8086C409D79;
 Wed, 12 Aug 2026 17:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DE9502F9C9; Wed, 12 Aug 2026 17:50:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael S. Tsirkin <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Feifan Qian <bea1e@proton.me>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 051/120] vhost: do not crash on ring map failure
Date: Wed, 12 Aug 2026 17:48:34 +0300
Message-ID: <20260812144955.649205-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: "Michael S. Tsirkin" <mst@redhat.com>

When vhost_commit() rebuilds the memory region table after a flatview
change, it revalidates cached host virtual addresses for active vring
parts. If a mapping is stale, QEMU abort().

This is not a security problem - only the priviledged guest
can control make it invalid - but not nice e.g. for driver debugging.

Let's call virtio_error() instead, marking the device as broken.

Fixes: 0ca1fd2d68 ("vhost: Simplify ring verification checks")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3783
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <71961a7dc157f552303aeea8c99a75c5e1ce904e.1784898432.git.mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
(cherry picked from commit 27806d2ddba2da97fb4137cba7d4172356c42914)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b9dc4ed13ba..623a17d650d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -687,8 +687,9 @@ static void vhost_commit(MemoryListener *listener)
                        (void *)(uintptr_t)dev->mem->regions[i].userspace_addr,
                        dev->mem->regions[i].guest_phys_addr,
                        dev->mem->regions[i].memory_size)) {
-            error_report("Verify ring failure on region %d", i);
-            abort();
+            virtio_error(dev->vdev,
+                         "Verify ring failure on region %d", i);
+            goto out;
         }
     }
 
-- 
2.47.3


