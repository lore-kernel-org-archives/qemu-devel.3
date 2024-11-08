Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EFD5E158
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MSl-00049x-FJ; Fri, 08 Nov 2024 05:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSj-00049a-7a
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSh-00068s-DL
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Wn/SU29qjPGoDuvuKwnDYxy4am62rNvT1IhX7LQqR8=;
 b=fS+SCv91mWi75mdCacfzlllRFPay5oe7HA7whrmb+2P5eqRT4LdSI90F1hcTuoQnGh6XN/
 tXiMLqn5apxmkzYtCdjof6G/q7zoocyUpbsOPhywBHqNplPxtqvA8+nKbeuRsEFsSFe/nE
 pjU9UrA201pj0pGZRnlxQE28Evt3Kyo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-Zi2L6gMfPJWDBALj4lv2ZQ-1; Fri,
 08 Nov 2024 05:43:24 -0500
X-MC-Unique: Zi2L6gMfPJWDBALj4lv2ZQ-1
X-Mimecast-MFC-AGG-ID: Zi2L6gMfPJWDBALj4lv2ZQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE61F1956048; Fri,  8 Nov 2024 10:43:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A489D1953880; Fri,  8 Nov 2024 10:43:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/10] Functional test fixes & next-cube cleanup
Date: Fri,  8 Nov 2024 11:43:00 +0100
Message-ID: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

 Hi Peter!

The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:

  Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-08

for you to fetch changes up to e7e76150a2e9642adf6763bcd8ca9a2a5d3b74b3:

  ui/input-legacy.c: remove unused legacy qemu_add_kbd_event_handler() function (2024-11-08 11:06:42 +0100)

----------------------------------------------------------------
* Various fixes and improvements for the functional tests
* Refresh CI container files with the latest changes from libvirt-ci
* Clean up keyboard code of the next-cube machine to get rid of a legacy API
  (I know, the kbd patches are a little bit borderline for soft-freeze
  already, but since the next-cube machine is experimental anyway, I
  still opted for including them here)

----------------------------------------------------------------
Cédric Le Goater (1):
      test/functional: Fix Aspeed buildroot tests

Daniel P. Berrangé (1):
      tests: refresh package lists with latest libvirt-ci

Mark Cave-Ayland (2):
      next-kbd: convert to use qemu_input_handler_register()
      ui/input-legacy.c: remove unused legacy qemu_add_kbd_event_handler() function

Phil Dennis-Jordan (1):
      scripts/checkpatch.pl: Ignore ObjC #import lines for operator spacing

Thomas Huth (5):
      tests/functional: Convert the riscv_opensbi avocado test into a standalone test
      tests/functional: Fix the ppc64_hv and the ppc_40p test for read-only assets
      tests/functional: Provide the user with hints where to find more log files
      tests/functional: Bump timeouts of functional tests
      tests/functional: Split the test_aarch64_sbsaref test

 MAINTAINERS                                        |   3 +-
 include/ui/console.h                               |   2 -
 hw/m68k/next-kbd.c                                 | 158 +++++++++++++-------
 ui/input-legacy.c                                  |  37 -----
 .gitlab-ci.d/cirrus/freebsd-14.vars                |   2 +-
 scripts/checkpatch.pl                              |   2 +-
 tests/avocado/riscv_opensbi.py                     |  63 --------
 tests/docker/dockerfiles/debian-amd64-cross.docker |   8 +-
 tests/docker/dockerfiles/debian-arm64-cross.docker |   8 +-
 tests/docker/dockerfiles/debian-armhf-cross.docker |   8 +-
 tests/docker/dockerfiles/debian-i686-cross.docker  |   8 +-
 .../dockerfiles/debian-mips64el-cross.docker       |   7 +-
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   8 +-
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   8 +-
 tests/docker/dockerfiles/debian-s390x-cross.docker |   8 +-
 tests/docker/dockerfiles/fedora-win64-cross.docker |   4 +-
 tests/functional/meson.build                       |  41 ++++--
 tests/functional/qemu_test/testcase.py             |  18 ++-
 tests/functional/test_aarch64_sbsaref.py           | 159 +++++----------------
 tests/functional/test_aarch64_sbsaref_alpine.py    |  64 +++++++++
 tests/functional/test_aarch64_sbsaref_freebsd.py   |  66 +++++++++
 tests/functional/test_arm_aspeed.py                |   2 +-
 tests/functional/test_ppc64_hv.py                  |   3 +-
 tests/functional/test_ppc_40p.py                   |   3 +-
 tests/functional/test_riscv_opensbi.py             |  36 +++++
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/mappings.yml                         |   3 +
 tests/vm/generated/freebsd.json                    |   2 +-
 28 files changed, 392 insertions(+), 341 deletions(-)
 delete mode 100644 tests/avocado/riscv_opensbi.py
 create mode 100755 tests/functional/test_aarch64_sbsaref_alpine.py
 create mode 100755 tests/functional/test_aarch64_sbsaref_freebsd.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed.py
 create mode 100755 tests/functional/test_riscv_opensbi.py


