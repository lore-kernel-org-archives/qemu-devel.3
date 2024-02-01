Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB227C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbVP-0006at-WA; Thu, 01 Feb 2024 13:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVL-0006a5-MI
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVI-00042f-Dr
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706810973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=X9AwAT/X3e91vBIu5yfOJLHyDQ53DDJSMLLJHQX3Z38=;
 b=jK/f74MIzehBM7ctUKp3lckR5IM3e02Z01E/1OdiyXOAAeW5lCWOBrssAFVO2Xsz3nD1gI
 p1F+DED0/usC07D3VVRvb7mVJ4OV5dEWAWlCUcjgArmidOcgn/Mj2JqIvbTJo+PeGM4lSV
 OtDersKhDBiQ+5E435ehzpS8f31ZPLY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-NfBBir4KMgKPZ0uF1_rB0A-1; Thu,
 01 Feb 2024 13:09:31 -0500
X-MC-Unique: NfBBir4KMgKPZ0uF1_rB0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56E491C54022;
 Thu,  1 Feb 2024 18:09:31 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 745182028CD2;
 Thu,  1 Feb 2024 18:09:29 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v2 0/7] Move memory listener register to vhost_vdpa_init
Date: Thu,  1 Feb 2024 19:09:17 +0100
Message-ID: <20240201180924.487579-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Current memory operations like pinning may take a lot of time at the
destination.  Currently they are done after the source of the migration is
stopped, and before the workload is resumed at the destination.  This is a
period where neigher traffic can flow, nor the VM workload can continue
(downtime).

We can do better as we know the memory layout of the guest RAM at the
destination from the moment that all devices are initializaed.  So
moving that operation allows QEMU to communicate the kernel the maps
while the workload is still running in the source, so Linux can start
mapping them.

As a small drawback, there is a time in the initialization where QEMU
cannot respond to QMP etc.  By some testing, this time is about
0.2seconds.  This may be further reduced (or increased) depending on the
vdpa driver and the platform hardware, and it is dominated by the cost
of memory pinning.

This matches the time that we move out of the called downtime window.
The downtime is measured as checking the trace timestamp from the moment
the source suspend the device to the moment the destination starts the
eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
secs to 2.0949.

Future directions on top of this series may include to move more things ahead
of the migration time, like set DRIVER_OK or perform actual iterative migration
of virtio-net devices.

Comments are welcome.

This series is a different approach of series [1]. As the title does not
reflect the changes anymore, please refer to the previous one to know the
series history.

This series is based on [2], it must be applied after it.

v2:
* Move the memory listener registration to vhost_vdpa_set_owner function.
* Move the iova_tree allocation to net_vhost_vdpa_init.

v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html .

[1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
[2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html

Eugenio Pérez (7):
  vdpa: check for iova tree initialized at net_client_start
  vdpa: reorder vhost_vdpa_set_backend_cap
  vdpa: set backend capabilities at vhost_vdpa_init
  vdpa: add listener_registered
  vdpa: reorder listener assignment
  vdpa: move iova_tree allocation to net_vhost_vdpa_init
  vdpa: move memory listener register to vhost_vdpa_init

 hw/virtio/vhost-vdpa.c         | 98 ++++++++++++++++++++++------------
 include/hw/virtio/vhost-vdpa.h | 22 +++++++-
 net/vhost-vdpa.c               | 34 ++----------
 3 files changed, 88 insertions(+), 66 deletions(-)

-- 
2.43.0


