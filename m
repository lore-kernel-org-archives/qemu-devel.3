Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ADBCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 16:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPjg2-0005tI-W2; Wed, 20 May 2026 12:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfm-0005oB-HB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wPjfh-0008Tg-1q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 12:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779294082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IbnE/1zZVwiiEjbf5ulVsU2SRydppbmiNeDETKeZNXA=;
 b=asXD10Z0T6lbNVHqvT2rLd5NUf/+Tio3z3jMh0EgcGhRLtVsmwjCcGND535LFRQWb8Q8Ro
 FLG6pRsNt3GJuUSRbKJ7mkkEQZlxoEfoi34yfeDeUY9oVvLLboGBfHYp6G0jNftVp6EEB6
 JvaQZycnB1PcYS0DNamlt6Vu1PPJB3Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-1pprrhNDNH6t-8ythBUhZA-1; Wed,
 20 May 2026 12:21:20 -0400
X-MC-Unique: 1pprrhNDNH6t-8ythBUhZA-1
X-Mimecast-MFC-AGG-ID: 1pprrhNDNH6t-8ythBUhZA_1779294079
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 453BE1956055
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 16:21:19 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.34.136])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DD0319560A6; Wed, 20 May 2026 16:21:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/11] vfio queue
Date: Wed, 20 May 2026 18:21:04 +0200
Message-ID: <20260520162115.1613601-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a1b:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-05-19 15:23:10 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260520

for you to fetch changes up to b9638e2faa58dea98b0797cbb6c1c2ae04902028:

  scripts/update-linux-headers: Add typelimits.h (2026-05-20 15:05:20 +0200)

----------------------------------------------------------------
vfio queue:

* Fix IRQ notifier return value in vfio/ap and vfio/ccw
* Fix vfio-user: reject malformed migration capabilities and avoid
  leaking a duplicate device name
* Report overflow in migration size queries
* Fix s390x cpu_models build regression
* Update libvfio-user subproject to fix compilation on newer compilers
* Update update-linux-headers.sh to support typelimits.h and inject
  VIRTIO_RING_NO_LEGACY in virtio_ring.h to fix the Windows build
* Replace abort() with g_assert_not_reached() in the vfio/pci
  interrupt handling path
* Drop superfluous inclusion of hw-error.h from vfio device files

----------------------------------------------------------------
Avihai Horon (1):
      scripts/update-linux-headers: Add typelimits.h

Cédric Le Goater (3):
      vfio/pci: Replace abort() with g_assert_not_reached()
      update-linux-headers: Inject VIRTIO_RING_NO_LEGACY in virtio_ring.h
      vfio/migration: Detect and report overflow in migration size queries

Eric Farman (1):
      target/s390x: restore cpu_models for system builds

GuoHan Zhao (4):
      vfio-user: avoid leaking duplicate device name
      vfio-user: reject malformed migration capabilities
      vfio/ap: Return false when IRQ notifier setup fails
      vfio/ccw: Return false when IRQ notifier setup fails

John Levon (1):
      hw/remote: update libvfio-user subproject

Thomas Huth (1):
      hw/vfio: Drop superfluous inclusion of hw-error.h

 hw/remote/vfio-user-obj.c       |  3 ++-
 hw/vfio-user/pci.c              |  2 --
 hw/vfio-user/proxy.c            |  4 ++--
 hw/vfio/ap.c                    |  1 +
 hw/vfio/ccw.c                   |  1 +
 hw/vfio/device.c                |  1 -
 hw/vfio/helpers.c               |  1 -
 hw/vfio/igd.c                   |  1 -
 hw/vfio/kvm-helpers.c           |  1 -
 hw/vfio/migration.c             | 32 ++++++++++++++++++++++++++++----
 hw/vfio/pci.c                   |  7 ++++++-
 scripts/update-linux-headers.sh |  3 +++
 subprojects/libvfio-user.wrap   |  2 +-
 target/s390x/meson.build        |  6 +++++-
 14 files changed, 49 insertions(+), 16 deletions(-)


