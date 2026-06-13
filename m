Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C283ACD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYWwo-0003dd-Rm; Sat, 13 Jun 2026 18:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wYWwm-0003dV-T8
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 18:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kdutta@redhat.com>) id 1wYWwl-0001CD-HE
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 18:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781390121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h4UmoEXprqod5wRJ81LtxfPrkXtS+tFLeg6uQRRz318=;
 b=GnWCinfuGP4kCnEdv5S/HC0vtqxHVpBv9LdwANIQJjJiRTg2U6vYpFXgwXKv557skg1BVg
 9g6hhR6RF/FK/8zWsc9iPX6Dd0u9c4CJ1LrIerVNVwlTszzwyRix5tJAnIr6peLCzSkA84
 bfR/lStXyyOylmg8DcIJTN9829M/B58=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-KH6-S1lnPhmAK4ZURfOePA-1; Sat,
 13 Jun 2026 18:35:19 -0400
X-MC-Unique: KH6-S1lnPhmAK4ZURfOePA-1
X-Mimecast-MFC-AGG-ID: KH6-S1lnPhmAK4ZURfOePA_1781390119
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADBEE1800345
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2026 22:35:18 +0000 (UTC)
Received: from kdutta-thinkpadp1gen7.bengluru.csb (unknown [10.74.64.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB8D3765; Sat, 13 Jun 2026 22:35:15 +0000 (UTC)
From: Koushik Dutta <kdutta@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v8 0/2] *** virtio-net: Add notification coalescing support
Date: Sun, 14 Jun 2026 04:05:11 +0530
Message-ID: <20260613223513.865744-1-kdutta@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kdutta@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds support for virtio network notification
coalescing (VIRTIO_NET_F_NOFT_COAL) in virtio-net.

Patch 1: Introduces a Tx dispatch helper to unify tx path
handling.

Patch 2: Implements notification coalescing support and feature
negotiation for virtio-net.

Koushik Dutta (2):
  Introduce virtio_net_handle_tx_dispatch() to unify TX path handling.
    This dispatcher dynamically selects between timer-based and BH-based
    TX processing based on configuration.
  Implement VirtIO Network Notification Coalescing
    (VIRTIO_NET_F_NOTF_COAL). This allows guests to reduce interrupt
    overhead by configuring coalescing parameters via ethtool -C for
    both RX and TX paths.

 hw/net/virtio-net.c            | 188 ++++++++++++++++++++++++++++++---
 include/hw/virtio/virtio-net.h |   8 ++
 net/passt.c                    |   1 +
 net/tap.c                      |   1 +
 net/vhost-user.c               |   1 +
 net/vhost-vdpa.c               |   1 +
 6 files changed, 184 insertions(+), 16 deletions(-)

-- 
2.53.0


