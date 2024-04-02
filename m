Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4DFCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrff3-0002sd-RE; Tue, 02 Apr 2024 11:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rrfev-0002qb-0T
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rrfes-0000aN-58
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712070161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+B6Nuxgao9DBjJlKFw1pkGUAakZVP/Ek+wPZZp1urW8=;
 b=aiQMpcMYPWQgwJrAOhKaKwTVETZf+RBDah+TPQfYXNqKxnV1QjjgwCOUV+kEtwVhB5JAlt
 NKgeRHkLnk2XmDmHtvho59tGaztpiG+ZNCATy/ALiOz4UHaMkbQF7GAq1ZppagqUVDMlme
 FeeBPmOzTQ4aAIajjuSullR1/tVNv6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-dUmvS242ODmpKQ9bOzeXKA-1; Tue, 02 Apr 2024 11:02:32 -0400
X-MC-Unique: dUmvS242ODmpKQ9bOzeXKA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC5DB811E81
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 15:02:31 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F338492BCD;
 Tue,  2 Apr 2024 15:02:29 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/1] virtio-pci: Fix the crash when the vector changes back
 from VIRTIO_NO_VECTOR
Date: Tue,  2 Apr 2024 23:00:09 +0800
Message-ID: <20240402150218.270587-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There is a crash in the Non-standard guest image. The root cause of
the issue is that an IRQFD was used After it release 

During the booting process of the Vyatta image, the behavior of the
called function in qemu is as follows:

1. vhost_net_stop() was called. This will call the function
virtio_pci_set_guest_notifiers() with assgin= false, and
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTOR

3.vhost_net_start() was called (at this time the configure vector is
still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
assgin= true, so the irqfd for vector 0 was not "init" during this process

4. The system continues to boot, and msix_fire_vector_notifier() was
called unmask the vector 0 and then met the crash
[msix_fire_vector_notifier] 112 called vector 0 is_masked 1
[msix_fire_vector_notifier] 112 called vector 0 is_masked 0

To fix this, we need to call the function "kvm_virtio_pci_vector_use_one()"
when the vector changes back from VIRTIO_NO_VECTOR

Signed-off-by: Cindy Lu <lulu@redhat.com>

Cindy Lu (1):
  virtio-pci: Fix the crash when the vector changes back from
    VIRTIO_NO_VECTOR

 hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.43.0


