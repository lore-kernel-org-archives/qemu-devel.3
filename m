Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9C6C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk0MN-0003Sm-Up; Wed, 15 Jul 2026 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wk0ML-0003SP-Vx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wk0MJ-0003k9-On
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 10:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784124789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=48hShJSkZiaw0lssguiRUZ6Jejf21tqdC6f+AvIasxI=;
 b=OHZxIgg4zFgzReYdR65PIsipOQe/aIa6yv+riyWVVji64Bl4048QUMBBLzmfSA/d3tVQEg
 SE0Wbzjo3pYHHx/rqDFiYKKtBjLhOMjMU3qX2RAxVI8DANGQ3s1NgZZcl5DToNt2vqSLjg
 e3ZWXRsK2qDuxWPIR6VqVD1BIzw8KZA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-tlRCBj3hPLimXza_TV3iCw-1; Wed,
 15 Jul 2026 10:13:05 -0400
X-MC-Unique: tlRCBj3hPLimXza_TV3iCw-1
X-Mimecast-MFC-AGG-ID: tlRCBj3hPLimXza_TV3iCw_1784124784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7527A1956051; Wed, 15 Jul 2026 14:13:04 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E4D119541AA; Wed, 15 Jul 2026 14:13:01 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH] backends/rng: cap request size to avoid oversized allocation
Date: Wed, 15 Jul 2026 16:13:00 +0200
Message-ID: <20260715141300.2295392-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=lvivier@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 backends/rng.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/backends/rng.c b/backends/rng.c
index ab94dfea850a..d8904f89dc43 100644
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
2.54.0


