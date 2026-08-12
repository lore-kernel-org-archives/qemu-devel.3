Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E40C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAPO-0006R0-C9; Wed, 12 Aug 2026 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAOV-0004mK-E2; Wed, 12 Aug 2026 10:57:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAOT-0000nG-PW; Wed, 12 Aug 2026 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546232; bh=u37CJcTB3wht7ebDH5Vi4PXBdfIYif67r60XnjV85SY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B1EdSorYE6J1BQ5Waefps+LRB0OIZzVfhgRikUVNzbibm0yYPpo2HfkVX21ntl4HJ
 kxHvD+5XpfWLfnyq7lcIxdc0iwcw4xt7mPt5w3UB+C1GdZv3fij2rr5r4lqIZNP9Vg
 MKAztY8oTfPLAQzAcoM+97pp+z9AzsjodP92X+jqh+YW/He7nq2yxPAlFY8MQeV0V8
 uq2F4kVO26pmLBZdQT8m89r7BEt3n9ZxEVpwkdPBapAYb1/9UjPogWuILhh//OqSXv
 WefgDaT9jPBxzzLR1BcKcMdlGRa6QCmXl2cC1zYt6KvtQVQOrHM35caMjRbA1jrx3B
 P2T+RLk2F8m/w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E9BE1CA648;
 Wed, 12 Aug 2026 17:50:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05847409D8A;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 63A9E2F9EB; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 dong ling <dongling226655@outlook.com>, Thomas Huth <thuth@redhat.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 068/120] backends/rng: cap request size to avoid
 oversized allocation
Date: Wed, 12 Aug 2026 17:48:51 +0300
Message-ID: <20260812144955.649205-68-mjt@tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

rng_backend_request_entropy() uses the requested size to allocate
a buffer with g_malloc(). With virtio-rng, this size comes from
guest-supplied descriptor lengths. A malicious guest can set a very
large descriptor length, causing QEMU to attempt a multi-gigabyte
allocation and abort.

Cap the allocation to 64 KiB. The virtio-rng queue size is
hardcoded to 8 entries, the EGD backend protocol limits requests
to 255 bytes, the Linux kernel hwrng framework requests at most
SMP_CACHE_BYTES per call (64 bytes on x86_64), and the Windows
viorng driver uses a 4 KiB buffer. The worst legitimate case is
8 x 4 KiB = 32 KiB, so 64 KiB is well above any legitimate use.

Fixes: 14417039653d ("virtio-rng: use virtqueue_get_avail_bytes, fix migration")
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3983
Reported-by: dong ling <dongling226655@outlook.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260715141300.2295392-1-lvivier@redhat.com>
(cherry picked from commit 70074cc48f450e6c95881ac534e67013c8773cb2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/rng.c b/backends/rng.c
index 7bed62616a5..bc9c7a5ab3b 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -11,11 +11,14 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "system/rng.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 
+#define RNG_MAX_REQUEST_SIZE (64 * KiB)
+
 void rng_backend_request_entropy(RngBackend *s, size_t size,
                                  EntropyReceiveFunc *receive_entropy,
                                  void *opaque)
@@ -27,7 +30,7 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
         req = g_malloc(sizeof(*req));
 
         req->offset = 0;
-        req->size = size;
+        req->size = MIN(size, RNG_MAX_REQUEST_SIZE);
         req->receive_entropy = receive_entropy;
         req->opaque = opaque;
         req->data = g_malloc(req->size);
-- 
2.47.3


