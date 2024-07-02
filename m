Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A22C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapE-00044Y-Gb; Tue, 02 Jul 2024 06:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOap9-000447-MP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOap6-0006z7-Fx
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yUUZI1Aj43tbdKL3h2T54aa7CSeX97Wiv+h2Ew2TMQ8=;
 b=hM6q/hC6Klk3qAfQzGxBmx5wE/SgFY4CQFGYqISR/fGEAjs9AgUfALbRxg5thT2sg2iPmM
 vrrYVXpWobpyIUz9LLINGISbiJBsBBrerAJLj1mBHsphsNC5a7ydsXc8jOMt202YsxiUik
 hSLw2prYmgPrJql7p+jBr+w52soVLws=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-09skQtHqOtqeWrH3h9Godw-1; Tue,
 02 Jul 2024 06:33:15 -0400
X-MC-Unique: 09skQtHqOtqeWrH3h9Godw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B534119560B0; Tue,  2 Jul 2024 10:33:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94C6719560AA; Tue,  2 Jul 2024 10:33:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/12] qtest, s390x, avocado and doc patches
Date: Tue,  2 Jul 2024 12:32:58 +0200
Message-ID: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Richard!

The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:

  Merge tag 'pull-target-arm-20240701' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-01 10:41:45 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-07-02

for you to fetch changes up to e3e2708fee10e6df413c36a71b100c59710e727e:

  pc-bios/s390-ccw: Remove duplicated LDFLAGS (2024-07-02 09:52:38 +0200)

----------------------------------------------------------------
* Fix interrupt controller migration on s390x with TCG and enable qtest
* Fix memory leaks in qtests
* Use a proper qom-tree parent for s390x virtio-net devices
* Add hotplug avocado test for virtio-blk
* Fix Travis jobs (need python3-tomli now)

----------------------------------------------------------------
Akihiko Odaki (5):
      tests/qtest: Use qtest_add_data_func_full()
      tests/qtest: Free unused QMP response
      tests/qtest: Free old machine variable name
      tests/qtest: Free paths
      tests/qtest: Free GThread

Alexandre Iooss (1):
      docs: add precision about capstone for execlog plugin

Nicholas Piggin (1):
      tests/qtest/migration-test: enable on s390x with TCG

Thomas Huth (4):
      hw/intc/s390_flic: Fix interrupt controller migration on s390x with TCG
      hw/s390x: Attach default virtio-net devices to the /machine/virtual-css-bridge
      .travis.yml: Install python3-tomli in all build jobs
      pc-bios/s390-ccw: Remove duplicated LDFLAGS

Vladimir Sementsov-Ogievskiy (1):
      tests/avocado: add hotplug_blk test

 docs/devel/tcg-plugins.rst           |  4 +-
 include/hw/s390x/s390_flic.h         |  1 +
 hw/intc/s390_flic.c                  | 75 ++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-virtio-ccw.c           |  8 ++++
 tests/qtest/device-introspect-test.c |  7 ++--
 tests/qtest/libqtest.c               |  3 ++
 tests/qtest/migration-test.c         | 12 ------
 tests/qtest/qos-test.c               | 16 ++++++--
 tests/qtest/vhost-user-test.c        |  6 +--
 .travis.yml                          |  6 +++
 pc-bios/s390-ccw/Makefile            |  4 +-
 tests/avocado/hotplug_blk.py         | 69 +++++++++++++++++++++++++++++++++
 12 files changed, 181 insertions(+), 30 deletions(-)
 create mode 100644 tests/avocado/hotplug_blk.py


