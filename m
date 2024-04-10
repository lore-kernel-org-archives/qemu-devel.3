Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73896CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQWr-0000in-Qp; Wed, 10 Apr 2024 01:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruQWq-0000iX-8O
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruQWo-00070w-SG
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712726985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lUyt2lP+iaweP7GGIQcQN2/vMQc1UDRPtDmxt5CULrM=;
 b=DZMmjcA7pGd6TKsl9XbTptHgatV595yGfaq/bC3EPNQeXyJg8L4gEpCJmLI366Xrz9VJIn
 7/N4DBmcVejU7ZUXra5xsMVMdYk2xBqsA6cfNvzqkS+WXOhEV8b1I62bMkNPyOaUcjOTgf
 b6fCvppwkFAn7v/0P/ai4WsKJ94a2EU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ddmoYyiJMYWA5XAH6AcuYQ-1; Wed, 10 Apr 2024 01:29:41 -0400
X-MC-Unique: ddmoYyiJMYWA5XAH6AcuYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D716D802E4D
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 05:29:40 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11FD6C0157E;
 Wed, 10 Apr 2024 05:29:37 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/1] virtio-pci: Fix the crash that the vector was used
 after released
Date: Wed, 10 Apr 2024 13:27:55 +0800
Message-ID: <20240410052926.417674-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

During the booting process of the Vyatta image, the behavior of the
called function in qemu is as follows:

1. vhost_net_stop() was triggered by guest image . This will call the function
virtio_pci_set_guest_notifiers() with assgin= false, and
virtio_pci_set_guest_notifiers(） will release the irqfd for vector 0

2. virtio_reset() was called -->set configure vector to VIRTIO_NO_VECTOR

3.vhost_net_start() was called (at this time, the configure vector is
still VIRTIO_NO_VECTOR) and call virtio_pci_set_guest_notifiers() with
assgin= true, so the irqfd for vector 0 is still not "init" during this process

4. The system continues to boot,set the vector back to 0, and msix_fire_vector_notifier() was triggered
 unmask the vector 0 and then met the crash
[msix_fire_vector_notifier] 112 called vector 0 is_masked 1
[msix_fire_vector_notifier] 112 called vector 0 is_masked 0

To fix this, we need to call the function "kvm_virtio_pci_vector_use_one()"
when the vector changes back from VIRTIO_NO_VECTOR.

The reason that we don't need to call kvm_virtio_pci_vector_release_one while the vector changes to
VIRTIO_NO_VECTOR is this function will called in vhost_net_stop(),
So this step will not lost during this process.

Change from V1
1.add the check for if using irqfd
2.remove the check for bool recovery, irqfd's user is enough to check status

Cindy Lu (1):
  virtio-pci: Fix the crash that the vector was used after released.

 hw/virtio/virtio-pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.43.0


