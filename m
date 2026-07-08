Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49058C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 14:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whTTT-000652-JX; Wed, 08 Jul 2026 10:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whTSl-0005LV-4v
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whTSi-0008T2-2H
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 10:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783521678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9+JHAz9fuOj7XQWf6UQrRtwG1Y4r659p6blOjuglpQM=;
 b=MtH57XnGyKBJ6+xN3l14JVNGRh6rZVjhCvYVQN/l8br8rbUMQazvL2iMDnmv8C0xFVG6OI
 ZRjP223lWoUhK6VTTTBW1UrBHwlRrpJLAA1WhD0QU0vPU0fdkX/N41AqgM94kXW319Qx1G
 JT3cMtNfeIZU2BpojfXOIWhbBsA+oy0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-y2Zo1YJiPAGkxAIaGyt-Lg-1; Wed,
 08 Jul 2026 10:41:17 -0400
X-MC-Unique: y2Zo1YJiPAGkxAIaGyt-Lg-1
X-Mimecast-MFC-AGG-ID: y2Zo1YJiPAGkxAIaGyt-Lg_1783521676
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D065D1955EB2; Wed,  8 Jul 2026 14:41:15 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90E4C1955F7B; Wed,  8 Jul 2026 14:41:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, qemu-stable@nongnu.org
Subject: [PATCH] hw/char/virtio-serial-bus: validate nr_active_ports from
 migration stream
Date: Wed,  8 Jul 2026 16:41:12 +0200
Message-ID: <20260708144112.1830881-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3801
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
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


