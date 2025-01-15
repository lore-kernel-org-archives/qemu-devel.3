Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86570C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3nU-0006gz-Ht; Wed, 15 Jan 2025 08:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tY3nL-0006Zd-6f
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tY3nH-0007uS-J4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736949050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9Clod6haqnIULY3kksdBDCjT+tMhDl2X+JfbfiCfEAw=;
 b=W4DdIxVcYyZybTdDBqs2GpkAILKee0pKDkPe35v52saY+qALINncRlRd1+7vTXQrGKaATh
 ttLJqdwVQXcuwIIW9OunHSEm4F4gnPphqBXk/24bNc6AYICUFhGvzA2XP4k8Bgn5xUYqkg
 PfRVE8qfAFKidwm7/WWwRpDyPZcNK9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-RgZ4DYBbOhWNXNXrsG2HVg-1; Wed,
 15 Jan 2025 08:50:48 -0500
X-MC-Unique: RgZ4DYBbOhWNXNXrsG2HVg-1
X-Mimecast-MFC-AGG-ID: RgZ4DYBbOhWNXNXrsG2HVg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9AA91956080
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 13:50:47 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.39.192.232])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F7F619560A3; Wed, 15 Jan 2025 13:50:45 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 0/2] virtio-net: vhost-user: Implement internal migration
Date: Wed, 15 Jan 2025 14:50:42 +0100
Message-ID: <20250115135044.799698-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support of VHOST_USER_PROTOCOL_F_DEVICE_STATE in virtio-net=0D
with vhost-user backend.=0D
=0D
v2:=0D
  - Add stubs for the migration state transfer interface=0D
=0D
Laurent Vivier (2):=0D
  vhost: Add stubs for the migration state transfer interface=0D
  virtio-net: vhost-user: Implement internal migration=0D
=0D
 include/hw/virtio/vhost.h |  23 +++++++=0D
 hw/net/virtio-net.c       | 135 +++++++++++++++++++++++++++++++-------=0D
 2 files changed, 135 insertions(+), 23 deletions(-)=0D
=0D
-- =0D
2.47.1=0D
=0D


