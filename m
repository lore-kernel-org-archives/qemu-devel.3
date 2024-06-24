Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C0C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfj7-0007vf-7J; Mon, 24 Jun 2024 05:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfj4-0007uq-VR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfit-0003rS-Vj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tQPa4Uxxo/Zku59gbZtIItJ4TBbOXLza2Ousu/zIp00=;
 b=CKnuiVQUxpadBMtjtkeYyG15s2NDXbjR7dphw+14m1Ow5OH5NurpeDsw2Zj+ZmYdRfuLZn
 XmpC1P6qsbJS2C9J2TTK1XA18hXWuFkAPZfCjAAYDhH5gCYgndSs5DFlfQ2tdyqapMq1/s
 yx+XXF3wIPKOp4TghYHY3hs84GYvCr0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-XLVCvJ4ZM5-ruSLFuUYm-Q-1; Mon,
 24 Jun 2024 05:10:47 -0400
X-MC-Unique: XLVCvJ4ZM5-ruSLFuUYm-Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7B9195608C; Mon, 24 Jun 2024 09:10:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 216F5300021C; Mon, 24 Jun 2024 09:10:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/11] s390x and qtest patches 2024-06-24
Date: Mon, 24 Jun 2024 11:10:32 +0200
Message-ID: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:

  Merge tag 'pull-target-arm-20240622' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-06-22 09:56:49 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-06-24

for you to fetch changes up to d6a7c3f44cf3f60c066dbf087ef79d4b12acc642:

  target/s390x: Add a CONFIG switch to disable legacy CPUs (2024-06-24 08:22:30 +0200)

----------------------------------------------------------------
* s390x error reporting clean ups
* fix memleak in qos_fuzz.c
* use correct byte order for pid field in s390x dumps
* Add a CONFIG switch to disable legacy s390x CPUs

----------------------------------------------------------------
Cédric Le Goater (6):
      hw/s390x/ccw: Make s390_ccw_get_dev_info() return a bool
      s390x/css: Make CCWDeviceClass::realize return bool
      hw/s390x/ccw: Remove local Error variable from s390_ccw_realize()
      s390x/css: Make S390CCWDeviceClass::realize return bool
      vfio/ccw: Use the 'Error **errp' argument of vfio_ccw_realize()
      vfio/{ap, ccw}: Use warn_report_err() for IRQ notifier registration errors

Dmitry Frolov (1):
      tests/qtest/fuzz: fix memleak in qos_fuzz.c

Omar Sandoval (1):
      target/s390x/arch_dump: use correct byte order for pid

Thomas Huth (2):
      MAINTAINERS: Cover all tests/qtest/migration-* files
      target/s390x: Add a CONFIG switch to disable legacy CPUs

Zhenzhong Duan (1):
      vfio/ccw: Fix the missed unrealize() call in error path

 MAINTAINERS                 |  3 ++-
 hw/s390x/ccw-device.h       |  2 +-
 include/hw/s390x/s390-ccw.h |  2 +-
 hw/s390x/ccw-device.c       |  3 ++-
 hw/s390x/s390-ccw.c         | 29 +++++++++++++----------------
 hw/s390x/s390-virtio-ccw.c  |  5 +++++
 hw/vfio/ap.c                |  2 +-
 hw/vfio/ccw.c               | 18 ++++++++----------
 target/s390x/arch_dump.c    |  2 +-
 target/s390x/cpu_models.c   |  9 +++++++++
 tests/qtest/fuzz/qos_fuzz.c |  1 +
 target/s390x/Kconfig        |  5 +++++
 12 files changed, 49 insertions(+), 32 deletions(-)


