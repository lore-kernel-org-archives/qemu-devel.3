Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E0C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:45:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMOG-0002UF-3M; Thu, 16 Jul 2026 09:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wkMOE-0002Tz-PM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wkMOC-0007Mv-OP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784209474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EgU6mLSPV8kXTf39CuLRvIJ6qnzgBh8Y0L5T6x1T0XQ=;
 b=Q9NhB0w0x7PJ0h7Sy4vmtp3Zzn7ldMleHa68OMV0MHkYRnNY8RsQqG7xJOJSdqAXCTErQ0
 zNBGUV9jzpxWJfmsu3M/LnbbiI6RQtvhBwE0sfV1sdhlod4oxZwll/lfKng4A8fXVEWDe6
 6rpnJNMS86WA00CstLoqQMZOseSRQ+g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-Sj8XHNPrMVqVClUnfThjUg-1; Thu,
 16 Jul 2026 09:44:30 -0400
X-MC-Unique: Sj8XHNPrMVqVClUnfThjUg-1
X-Mimecast-MFC-AGG-ID: Sj8XHNPrMVqVClUnfThjUg_1784209468
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B5F118002F2; Thu, 16 Jul 2026 13:44:28 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.80.216])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E67B42E; Thu, 16 Jul 2026 13:44:24 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v10 0/2] This patch series implements VirtIO network
 notification coalescing
Date: Thu, 16 Jul 2026 19:14:19 +0530
Message-ID: <20260716134421.3765533-1-kdutta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kdutta@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

reduce interrupt overhead by configuring coalescing parameters via
ethtool.

Changes in v10:
---------------
  - Organized coalescing fields into VirtIONetCoal structure
  - Renamed property to x-vq_notf_coal
  - Fixed TX notification coalescing to delay interrupts, not packet
    transmission
  - Added performance benchmark data

Feature Overview:
-----------------
The notification coalescing feature allows guests to configure interrupt
coalescing parameters using standard ethtool commands:

  ethtool -C <interface> rx-usecs <N> rx-frames <M>
  ethtool -C <interface> tx-usecs <N> tx-frames <M>

The device will delay interrupt notifications until either:
  - N microseconds have elapsed since the first packet, OR
  - M packets have been processed

This reduces interrupt overhead without delaying packet transmission.

Performance Results:
-------------------

Test                      Throughput           CPU Usage       IRQ/sec
---------------------------------------------------------------------------------
Without Coalescing        9.75 Gbits/sec       41.59%          451
LIGHT_COALESCING          9.43 Gbits/sec       39.92%          431
MODERATE_COALESCING       9.38 Gbits/sec       32.71%          280
AGGRESSIVE_COALESCING     9.64 Gbits/sec       31.26%          116
---------------------------------------------------------------------------------
LIGHT_COALESCING:  RX: 100µs, 5 frames, TX: 150µs, 5 frames
MODERATE_COALESCING: RX: 1000µs, 10 frames, TX: 2000µs, 20 frames
AGGRESSIVE_COALESCING: RX: 5000µs, 50 frames, TX: 5000µs, 50 frames

Moderate Coalescing vs without coalescing:
  CPU Usage Reduction:  20.0%
  Interrupt Reduction:  30.0%

Key findings:
  - Throughput remains virtually unchanged (packet transmission is immediate)
  - CPU usage reduced by 25% due to fewer interrupt context switches
  - Interrupt rate reduced by 74% (451 → 116 interrupts/sec)

Koushik Dutta (2):
  Introduce virtio_net_handle_tx_dispatch() to unify TX path handling.
    This dispatcher dynamically selects between timer-based and BH-based
    TX processing based on configuration.
  Implement VirtIO Network Notification Coalescing
    (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce interrupt
    overhead by configuring coalescing parameters via ethtool -C for
    both RX and TX paths.

Koushik Dutta (2):
  Introduce virtio_net_handle_tx_dispatch() to unify TX path handling.
    This dispatcher dynamically selects between timer-based and BH-based
    TX processing based on configuration.
  Implement VirtIO Network Notification Coalescing
    (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce interrupt
    overhead by configuring coalescing parameters via ethtool -C for
    both RX and TX paths.

 hw/net/virtio-net.c            | 244 ++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |  11 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 6 files changed, 241 insertions(+), 18 deletions(-)

-- 
2.53.0


