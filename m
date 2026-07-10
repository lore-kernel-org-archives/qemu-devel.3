Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B84EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8Ty-0006Jh-4M; Fri, 10 Jul 2026 06:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tv-0006Hy-VH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wi8Tu-0003yz-E8
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783679352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itSmT4dNttaxIulYwVEw4nRScMcnSaXcZ40WtiNAk/o=;
 b=HjvSotGmkS9IydfxgSxyvt8w0aBtPJpI7mLBo1OZZBf0NLPK4cXfagl9ha7Kl70D1PBfLR
 xEMRXEVzgJQgxWV9YFPvzzDj4SDiNTx794dFY0/z6ijRwMcW/znJmdy6MSPpkX6fsMO5ko
 MVjWdZskkEd4kEFGMnpJ1x0REcmEYS8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-jT_GNggRPXyat_l0cM7BjQ-1; Fri,
 10 Jul 2026 06:29:09 -0400
X-MC-Unique: jT_GNggRPXyat_l0cM7BjQ-1
X-Mimecast-MFC-AGG-ID: jT_GNggRPXyat_l0cM7BjQ_1783679348
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0F4E1956094; Fri, 10 Jul 2026 10:29:07 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4361D1800348; Fri, 10 Jul 2026 10:29:04 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/3] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
Date: Fri, 10 Jul 2026 12:28:57 +0200
Message-ID: <20260710102859.1967551-2-lvivier@redhat.com>
In-Reply-To: <20260710102859.1967551-1-lvivier@redhat.com>
References: <20260710102859.1967551-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The migration restore path reads nr_active_ports from the incoming
stream and passes it directly to fetch_active_ports_list(), which
uses it to size a heap allocation. A crafted migration stream can set
this field to a very large value, causing QEMU to attempt a
multi-gigabyte allocation and abort.

Fix this by checking nr_active_ports against the configured
max_virtserial_ports before calling fetch_active_ports_list().

Cc: qemu-stable@nongnu.org
Fixes: 6663a1956eb6 ("virtio-serial-bus: Maintain guest and host port open/close state")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/char/virtio-serial-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248fc..80f1b308aa53 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -804,6 +804,10 @@ static int virtio_serial_load_device(VirtIODevice *vdev, QEMUFile *f,
 
     qemu_get_be32s(f, &nr_active_ports);
 
+    if (nr_active_ports > max_nr_ports) {
+        return -EINVAL;
+    }
+
     if (nr_active_ports) {
         ret = fetch_active_ports_list(f, s, nr_active_ports);
         if (ret) {
-- 
2.54.0


