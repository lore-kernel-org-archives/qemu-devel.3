Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD372D5C0FC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f1r-0007XY-Lb; Sat, 09 Nov 2024 01:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1q-0007XH-3h
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1t9f1o-0001TL-Gw
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 01:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731133977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BeZ5UV53hkOaaPKWmI02uGB/Br3HHHmTODgHUpPktUU=;
 b=T7yi1BICz71GwnscYTVGgIVEEiYcO/OB8/Ye9Lyd8ur9BAxGeajO11iYywDKGP4iqqfuyc
 eEWxBq0M74Z+Kx0srHcvXZtl+hZnpdq0sFJa58RXMyc42LhQRcZCyqhDRjmtSEzT1HR2Z2
 U4cVCdwiQ3gyYP9HQ1ab0rp9z4UWcxg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-VCgUdUzTMEONssfgNeFrZg-1; Sat,
 09 Nov 2024 01:32:51 -0500
X-MC-Unique: VCgUdUzTMEONssfgNeFrZg-1
X-Mimecast-MFC-AGG-ID: VCgUdUzTMEONssfgNeFrZg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDD451956057
 for <qemu-devel@nongnu.org>; Sat,  9 Nov 2024 06:32:50 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2EF1195E480; Sat,  9 Nov 2024 06:32:47 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 0/4] virtio_net: Add the check for vdpa's mac address
Date: Sat,  9 Nov 2024 14:31:22 +0800
Message-ID: <20241109063241.1039433-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When using a VDPA device, it is important to ensure that the MAC address
is correctly set. In this patch series, we add a new parameter to
enable this check.
Only three MAC setup configurations are acceptable; any other will
fail to boot.

The usage is:
....
-netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-0,id=vhost-vdpa0,check-mac=true\
-device virtio-net-pci,netdev=vhost-vdpa0\
....

tested by ConnectX-6 Dx device

change in v3
1. add a new parameter to enable the check and keep the old behavior
2. adjust the comment and make it more clear

change in v4
1. change the new parameter's name to check-mac
2. change the comment and make it more clear


Cindy Lu (4):
  vhost_vdpa : Add a new parameter to enable check mac address
  virtio_net: Add the check for vdpa's mac address
  virtio_net: Add second acceptable configuration for MAC setup
  virtio_net: Add third acceptable configuration for MAC setup.

 hw/net/virtio-net.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 include/net/net.h   |  1 +
 net/vhost-vdpa.c    |  4 +++
 qapi/net.json       |  5 ++++
 4 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.45.0


