Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D1C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAH1-0001Lc-Ro; Wed, 14 May 2025 07:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAH0-0001G4-0a
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFAGy-00024b-6m
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747222058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mYK+mXwJBAHO1k4WL/hngMdjsvnt59WtirK2ZXGZOtQ=;
 b=IfJaTJ7drSM5/p5k8oImGZedBXGK6DTg88IyAavoPgZit7fMd4mZEnN2xq5KUbdgg7iJsj
 pxc0Svdqqq4VYUa2YfWuGIpUN/NycH9cIi6Bf4B/pSwd3uzOMERlvE5X2tICgvr58nkfJo
 shjcLfSnZgMIdFbqc1YBRyx4aNnU62Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-XUo_slzDM9GqHOMxoVMEqQ-1; Wed,
 14 May 2025 07:27:36 -0400
X-MC-Unique: XUo_slzDM9GqHOMxoVMEqQ-1
X-Mimecast-MFC-AGG-ID: XUo_slzDM9GqHOMxoVMEqQ_1747222055
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B049E1956068
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 11:27:35 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C82419560A3; Wed, 14 May 2025 11:27:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/13] s390x obsolete machine removal & misc fixes
Date: Wed, 14 May 2025 13:27:20 +0200
Message-ID: <20250514112733.456644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi!

The following changes since commit 69ee0189d7977cfbb1b2c7a27393d8b9fb661b20:

  Merge tag 'qtest-20250509-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-05-12 11:11:37 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-05-14

for you to fetch changes up to c23d3339ce8fc936d8c60a023ea2b052d847dc78:

  tests/functional: Skip the screendump tests if the command is not available (2025-05-14 11:50:42 +0200)

----------------------------------------------------------------
* Removal of obsolete s390x machines
* Fix a memleak in s390x code
* Skip some functional tests if the corresponding feature is not available

----------------------------------------------------------------
Fabiano Rosas (1):
      s390x: Fix leak in machine_set_loadparm

Thomas Huth (12):
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.10 machine type
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.11 machine type
      hw/s390x/event-facility: Remove the obsolete "allow_all_mask_sizes" code
      target/s390x: Rename the qemu_V2_11 feature set to qemu_MIN
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.12 machine type
      hw/s390x/s390-virtio-ccw: Remove the deprecated 3.0 machine type
      hw/s390x: Remove the obsolete hpage_1m_allowed switch
      hw/s390x/s390-virtio-ccw: Remove the deprecated 3.1 machine type
      hw/s390x/s390-virtio-ccw: Remove the deprecated 4.0 machine type
      include/hw/dma/xlnx_dpdma: Remove dependency on console.h
      tests/functional/test_s390x_tuxrun: Check whether the machine is available
      tests/functional: Skip the screendump tests if the command is not available

 include/hw/dma/xlnx_dpdma.h               |   1 -
 include/hw/s390x/s390-virtio-ccw.h        |   4 -
 hw/s390x/event-facility.c                 |  37 +--------
 hw/s390x/s390-virtio-ccw.c                | 132 +-----------------------------
 target/s390x/gen-features.c               |  13 +--
 target/s390x/kvm/kvm.c                    |   6 --
 tests/functional/test_arm_integratorcp.py |   6 +-
 tests/functional/test_m68k_nextcube.py    |   6 +-
 tests/functional/test_mips64el_malta.py   |   6 +-
 tests/functional/test_s390x_tuxrun.py     |   1 +
 10 files changed, 18 insertions(+), 194 deletions(-)


