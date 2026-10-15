Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750ACCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKSM-0002oI-W2; Thu, 15 Oct 2026 08:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSL-0002ne-3R
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKSJ-0005IN-KC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GbgDmWBP2ex35aB6M+KcyNwA82V26Myp+820/irNa8E=;
 b=CVuG/+aBdke4d0SDzWG5T2XCIv78nMWDbGoLOhyjj7k3dRvugxvXR09z+1ffOlK5GIqCoR
 iLjwt8hVMWRLZV/HShTmQDyUCT6JxvdkdmANazyfKt52f8+94qPVwyVDNdlBs62pPvX0O5
 RJtw8dWNzRKruG2rCLVoP3xbjmvuoUA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-L3yH4fPkMUSWOqZF2w9oaw-1; Thu,
 15 Oct 2026 12:20:59 +0000
X-MC-Unique: L3yH4fPkMUSWOqZF2w9oaw-1
X-Mimecast-MFC-AGG-ID: L3yH4fPkMUSWOqZF2w9oaw_1792066858
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABFC91800657
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:20:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 994D118004D2; Thu, 15 Oct 2026 12:20:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/8] vfio queue
Date: Thu, 15 Oct 2026 14:20:47 +0200
Message-ID: <20261015122055.888209-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit d5b5083cb783c447001e862c2b525e59f48ad78c:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2026-10-15 11:53:41 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20261015

for you to fetch changes up to 2240c14c16dfc6c3b9840677f0d153165af7d4ee:

  vfio/migration: Don't reset a device on a declined stop transition (2026-10-15 13:15:24 +0200)

----------------------------------------------------------------
vfio queue:

* Fix UBSAN shift error in MTRR mask computation on AMD EPYC with 52
  physical address bits
* Add Fixes: tag validation to checkpatch
* Reject virtio-net failover during vfio-user init
* Sanitize DBUF_CTL POWER_STATE for iGPU passthrough, fixing display
  corruption on first boot
* Thread vf-token through iommufd bind
* Make MTL/ARL guests fall back to BAR-based framebuffer access in
  passthrough
* Update igd-assign.txt for Intel MTL and newer platforms
* Don't reset a VFIO device on a declined stop transition

----------------------------------------------------------------
Cédric Le Goater (2):
      target/i386/kvm: Fix UBSAN shift error in MTRR mask computation
      scripts/checkpatch: validate Fixes: tag format and commit ancestry

Hugo Komatsu (1):
      vfio-user: reject failover during init

Mikhail Malyshev (1):
      vfio/igd: sanitize DBUF_CTL POWER_STATE for iGPU passthrough

Pankaj Kumar (1):
      vfio/migration: Don't reset a device on a declined stop transition

Tushar Dave (1):
      hw/vfio: thread vf-token through iommufd bind

Yuan Wang (2):
      vfio/igd: Make MTL/ARL guests fall back to BAR-based framebuffer access
      vfio/igd: Update igd-assign.txt for Intel MTL and newer platforms

 docs/igd-assign.txt   |   2 +-
 hw/vfio-user/pci.c    |   5 ++
 hw/vfio/igd.c         | 168 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c     |  10 +++
 hw/vfio/migration.c   |  38 ++++++++++--
 target/i386/kvm/kvm.c |   3 +-
 scripts/checkpatch.pl |  66 ++++++++++++++++++++
 7 files changed, 281 insertions(+), 11 deletions(-)


