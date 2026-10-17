Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CCDCCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIA1l-0002Ce-Cx; Sat, 17 Oct 2026 15:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0j-00024H-Br
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1xIA0h-0006lZ-ED
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 15:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792265041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=83wnJVHJF7XShJQ7py9NF7Do466sDbnnoHjkVtuFmlc=;
 b=UB5E6p+IvMOXHIOo1yWgCjJ8cDUg8RbMBQNrK7uLE41IMoIfOj2JSA14qCl8B1NDX7zm6E
 m0TczxYpt7e5qGaKLB4k07WeMlaQrWNwaPBnWfnbeafnDpTbxnnMPyKzukuYsmnHNMn4Wd
 Ceuuc9bpxmCmhLhI/xs3plsPcoKjdMk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-G2NKNUb-Meews3HbBgf4iQ-1; Sat,
 17 Oct 2026 19:22:40 +0000
X-MC-Unique: G2NKNUb-Meews3HbBgf4iQ-1
X-Mimecast-MFC-AGG-ID: G2NKNUb-Meews3HbBgf4iQ_1792264959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 988CD1800765; Sat, 17 Oct 2026 19:22:38 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D395D1800444; Sat, 17 Oct 2026 19:22:34 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 0/3] Subject: [PATCH 0/3] virtio-net: Add notification
 coalescing support
Date: Sun, 18 Oct 2026 00:52:29 +0530
Message-ID: <20261017192232.1545578-1-kdutta@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

This series implements VIRTIO_NET_F_NOTF_COAL (bit 53) for virtio-net,
enabling interrupt coalescing to reduce CPU overhead in high-throughput
workloads.

Patch 1 refactors TX path handling by introducing a unified dispatcher
that dynamically selects between timer-based and BH-based processing.
This is preparatory work with no functional changes.

Patch 2 implements the core notification coalescing feature, allowing
guests to configure RX/TX interrupt batching via ethtool -C using
time-based (microseconds) or count-based (packet) thresholds.

Patch 3 adds vDPA backend support, enabling coalescing state to be
restored during live migration when using Shadow VirtQueue.

Testing:
- Functional: ethtool -C configuration in guest with vDPA device
- Migration: VMState persistence across live migration
- Performance: 20% CPU overhead reduction, 30% fewer interrupts
- Compatibility: Feature disabled when tx=timer is configured

Changes in v11:
---------------
- Adds vDPA backend support for notification coalescing
- Resolved review comments

Koushik Dutta (3):
  Introduce virtio_net_handle_tx_dispatch() to unify TX path handling.
    This dispatcher dynamically selects between timer-based and BH-based
    TX processing based on configuration.
  virtio-net: Add VIRTIO_NET_F_NOTF_COAL support
  vhost-vdpa: Add VIRTIO_NET_F_NOTF_COAL support for vDPA

 hw/net/virtio-net.c            | 241 ++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |  11 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |  58 ++++++++
 6 files changed, 294 insertions(+), 19 deletions(-)

-- 
2.53.0


