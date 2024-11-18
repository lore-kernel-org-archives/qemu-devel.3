Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D36D591A9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 17:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD5gN-0008BS-ML; Mon, 18 Nov 2024 12:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gE-00086v-0k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:36:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD5gA-0004l2-Vd
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 12:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731951410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H1oAM7+G8hP522IIcHKt9nDTBIQsnQJ1LZDLK4aS8yc=;
 b=bGwd7+PacSvFyW6hJrcxxAbWGqYdjd5zkUHIK4c6aXRlCQDMPVpGPsEtOGGzEqX3Yt+gqT
 L83C7jSruYEE6/AlGEafdXGkLMFKU59ppj9mRs/VjUZFb199T/KT70drlM7hJFIsiJgvtz
 aFgJgUgUMJygfm52C16umzext6efvSM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-Xt7xdmAmOfC3SBptSoC3mQ-1; Mon,
 18 Nov 2024 12:36:40 -0500
X-MC-Unique: Xt7xdmAmOfC3SBptSoC3mQ-1
X-Mimecast-MFC-AGG-ID: Xt7xdmAmOfC3SBptSoC3mQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8DD419560A3; Mon, 18 Nov 2024 17:36:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76D4319560A3; Mon, 18 Nov 2024 17:36:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/12] s390x and misc patches for QEMU 9.2-rc1
Date: Mon, 18 Nov 2024 18:36:22 +0100
Message-ID: <20241118173634.473532-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

 Hi Peter!

The following changes since commit abb1565d3d863cf210f18f70c4a42b0f39b8ccdb:

  Merge tag 'pull-tcg-20241116' of https://gitlab.com/rth7680/qemu into staging (2024-11-16 18:16:46 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-18

for you to fetch changes up to 4483d98ab82671165276026b09287053328c94d4:

  .gitlab-ci.d: Raise timeout on cross-accel build jobs to 60m (2024-11-18 17:14:35 +0100)

----------------------------------------------------------------
* Fixes & doc updates for the new "boot order" s390x bios feature
* Provide a "loadparm" property for scsi-hd & scsi-cd devices on s390x
  (required for the "boot order" feature)
* Fix the floating-point multiply-and-add NaN rules on s390x
* Raise timeout on cross-accel build jobs to 60m

----------------------------------------------------------------
Ilya Leoshkevich (2):
      target/s390x: Fix the floating-point multiply-and-add NaN rules
      tests/tcg/s390x: Add the floating-point multiply-and-add test

Jared Rossi (3):
      docs/system/s390x/bootdevices: Update loadparm documentation
      pc-bios/s390x: Initialize cdrom type to false for each IPL device
      pc-bios/s390x: Initialize machine loadparm before probing IPL devices

Peter Maydell (1):
      .gitlab-ci.d: Raise timeout on cross-accel build jobs to 60m

Roque Arcudia Hernandez (1):
      hw/usb: Use __attribute__((packed)) vs __packed

Thomas Huth (5):
      docs/system/bootindex: Make it clear that s390x can also boot from virtio-net
      hw/s390x: Restrict "loadparm" property to devices that can be used for booting
      hw: Add "loadparm" property to scsi disk devices for booting on s390x
      pc-bios/s390-ccw: Re-initialize receive queue index before each boot attempt
      pc-bios: Update the s390 bios images with the recent fixes

 docs/system/bootindex.rst            |   2 +-
 docs/system/s390x/bootdevices.rst    |  24 +++-
 hw/s390x/ccw-device.h                |   5 +
 include/hw/qdev-properties-system.h  |   3 +
 include/hw/usb/dwc2-regs.h           |   2 +-
 tests/tcg/s390x/float.h              | 104 ++++++++++++++++
 hw/core/qdev-properties-system.c     |  26 ++++
 hw/s390x/ccw-device.c                |   4 +-
 hw/s390x/ipl.c                       |  19 +--
 hw/s390x/virtio-ccw-blk.c            |   1 +
 hw/s390x/virtio-ccw-net.c            |   1 +
 hw/scsi/scsi-disk.c                  |  43 +++++++
 hw/vfio/ccw.c                        |   1 +
 pc-bios/s390-ccw/main.c              |   4 +-
 pc-bios/s390-ccw/virtio-net.c        |   2 +
 target/s390x/tcg/fpu_helper.c        |   8 +-
 target/s390x/tcg/vec_fpu_helper.c    |  12 +-
 tests/tcg/s390x/fma.c                | 233 +++++++++++++++++++++++++++++++++++
 tests/tcg/s390x/vfminmax.c           | 223 ++++++++++++---------------------
 fpu/softfloat-specialize.c.inc       |  19 +++
 .gitlab-ci.d/crossbuild-template.yml |   2 +-
 pc-bios/s390-ccw.img                 | Bin 79608 -> 79608 bytes
 tests/tcg/s390x/Makefile.target      |   5 +-
 23 files changed, 567 insertions(+), 176 deletions(-)
 create mode 100644 tests/tcg/s390x/float.h
 create mode 100644 tests/tcg/s390x/fma.c


