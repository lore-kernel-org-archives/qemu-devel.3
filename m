Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC61D10BE5
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 08:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4bjy-0003tH-6n; Sat, 26 Oct 2024 04:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjs-0003sd-5d
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t4bjq-0000hw-B3
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 04:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729929691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=f4PyAyBJaHugbx1x7u2ocpgp5PBMgkaN7C66cN9lymg=;
 b=ZI76C42L9+gUEgXuUUBAWzortITWJ83+bf9fn/mBPid5bK6rJdf5rd8PSB6wrDryy1qphI
 XA0HHRhMQLtOatbLTTvTu8q0MFEBc5gLiYKr3jupvEUg8xGVNwHeWI/clZ90JXlPa4H1fG
 xFK+RH/D1tpYGs58gz32l/gmxBMuMxs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-TJ2_egVwN82Kz8o3g4mcQQ-1; Sat,
 26 Oct 2024 04:01:28 -0400
X-MC-Unique: TJ2_egVwN82Kz8o3g4mcQQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C982195608F
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2024 08:01:27 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B70319560A3; Sat, 26 Oct 2024 08:01:24 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] virtio_net: Add the check for vdpa's mac address
Date: Sat, 26 Oct 2024 15:59:58 +0800
Message-ID: <20241026080121.461781-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When using a VDPA device, it is important to ensure that the MAC
address is correctly set.Here we add Add a new parameter to 
enable this check.
There are only three acceptable situations for MAC setup; any other
configuration will fail to boot.

The usage is:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,macstrickcheck=true\
-device virtio-net-pci,netdev=vhost-vdpa0\
....

tested by ConnectX-6 Dx device

change in v3
1. add a new parameter to enable the check and keep the old behavior
2. adjust the comment and make it more clear

Cindy Lu (4):
  vhost_vdpa : Add a new parameter to enable check mac address
  virtio_net: Add the check for vdpa's mac address
  virtio_net: Add the 2rd acceptable situation for Mac setup.
  virtio_net: Add the 3rd acceptable situation for Mac setup.

 hw/net/virtio-net.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 include/net/net.h   |  1 +
 net/vhost-vdpa.c    |  4 +++
 qapi/net.json       |  5 ++++
 4 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.45.0


