Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3E606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZGOxstY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIyay-0005n3-SY; Mon, 19 Oct 2026 21:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xIyau-0005mO-4N
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xIyar-0000lx-Uy
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 21:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792459482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8E6BiXubxPhko6PASmlDopYecG4w8oi/rHvsZtMi9H0=;
 b=FZGOxstYwc6Vc4VpABbyXrb0P9LBS4VQqcTjJaxx2cmKxco3zOnRGKceSbvaNQUB+ofwhu
 AT1E8zFsvxwTKRpExbcWx6QjXCb02ghYmK97aev8X/tmbs9y8IQSPX+CDdwaDMqGK9NyzM
 9YQQAqXUd0VbimzzPzkumeR23YGfVGs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-9CL_1uNQO9WEAMoJhqneUA-1; Mon,
 19 Oct 2026 21:24:38 -0400
X-MC-Unique: 9CL_1uNQO9WEAMoJhqneUA-1
X-Mimecast-MFC-AGG-ID: 9CL_1uNQO9WEAMoJhqneUA_1792459476
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 768701955E7E; Tue, 20 Oct 2026 01:24:36 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4D741956087; Tue, 20 Oct 2026 01:24:33 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, david@kernel.org, mst@redhat.com,
 shan.gavin@gmail.com
Subject: [PATCH] hw/virtio/virtio-mem: Fix error message on invalid NUMA node
Date: Tue, 20 Oct 2026 11:24:04 +1000
Message-ID: <20261020012404.191329-1-gshan@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add space as the separator between "exceeds" and "the number of numa
nodes:". Otherwise, we will see error message with twisted format like
below.

  qemu-system-aarch64: -device virtio-mem-pci,id=vmem1,bus=pcie.3, \
  memdev=virtio-mem1-mem,requested-size=0,node=1: 'node' property  \
  has value '1', which exceedsthe number of numa nodes: 1

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 hw/virtio/virtio-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d..ee6a0c206a 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -846,7 +846,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
     if ((nb_numa_nodes && vmem->node >= nb_numa_nodes) ||
         (!nb_numa_nodes && vmem->node)) {
         error_setg(errp, "'%s' property has value '%" PRIu32 "', which exceeds"
-                   "the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
+                   " the number of numa nodes: %d", VIRTIO_MEM_NODE_PROP,
                    vmem->node, nb_numa_nodes ? nb_numa_nodes : 1);
         return;
     }
-- 
2.56.0


