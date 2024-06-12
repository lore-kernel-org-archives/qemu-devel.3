Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F40C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNug-0008O8-JR; Wed, 12 Jun 2024 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuZ-0008F4-4Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuS-0003r1-4P
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mHRCvrH9Xdn/6MhWUZNCs8EnGLFVyI0q6+F4eQOAU9Y=;
 b=STx/fm7kvbiKzxEFOdtGHC+EL1kmxEMR9oya8rB2uYhrko0SfLc3BvY2jT60KROpR08E/4
 isBVsjiCgSKpSQlB3WKd4ZioFqc9vYg5d69ZkOjucIA+ivw0bmEB4RMZKkbsKCiEn0XhZz
 bMlAjvksnGPzfO6FPMKgK+Um+W9tuWI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-ha69tsEvOcynmIThdS5Dww-1; Wed,
 12 Jun 2024 09:20:59 -0400
X-MC-Unique: ha69tsEvOcynmIThdS5Dww-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3A6B1954236; Wed, 12 Jun 2024 13:20:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D5521956087; Wed, 12 Jun 2024 13:20:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/15] CPU-related test updates
Date: Wed, 12 Jun 2024 15:20:40 +0200
Message-ID: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:

  Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-06-12

for you to fetch changes up to 26a09ead7351f117ae780781b347f014da03c20b:

  tests/tcg/s390x: Allow specifying extra QEMU options on the command line (2024-06-12 12:12:28 +0200)

----------------------------------------------------------------
* Fix loongarch64 avocado test
* Make qtests more flexible with regards to non-available CPU models
* Improvements for the test-smp-parse unit test

----------------------------------------------------------------
Ani Sinha (3):
      qtest/x86/numa-test: do not use the obsolete 'pentium' cpu
      tests/qtest/libqtest: add qtest_has_cpu_model() api
      tests/qtest/x86: check for availability of older cpu models before running tests

Ilya Leoshkevich (1):
      tests/tcg/s390x: Allow specifying extra QEMU options on the command line

Song Gao (1):
      tests/avocado: Update LoongArch bios file

Zhao Liu (8):
      tests/unit/test-smp-parse: Fix comments of drawers and books case
      tests/unit/test-smp-parse: Fix comment of parameters=1 case
      tests/unit/test-smp-parse: Fix an invalid topology case
      tests/unit/test-smp-parse: Use default parameters=0 when not set in -smp
      tests/unit/test-smp-parse: Make test cases aware of module level
      tests/unit/test-smp-parse: Test "modules" parameter in -smp
      tests/unit/test-smp-parse: Test "modules" and "dies" combination case
      tests/unit/test-smp-parse: Test the full 8-levels topology hierarchy

Zhenwei Pi (2):
      meson: Remove libibumad dependence
      test: Remove libibumad dependence

 meson.build                                        |   4 +-
 tests/qtest/libqtest.h                             |   8 +
 tests/qtest/libqtest.c                             |  83 +++++
 tests/qtest/numa-test.c                            |   3 +-
 tests/qtest/test-x86-cpuid-compat.c                | 170 ++++++----
 tests/unit/test-smp-parse.c                        | 373 +++++++++++++++++----
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 -
 tests/avocado/machine_loongarch.py                 |   8 +-
 tests/docker/dockerfiles/debian-amd64-cross.docker |   1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker |   1 -
 tests/docker/dockerfiles/debian-armel-cross.docker |   1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker |   1 -
 tests/docker/dockerfiles/debian-i686-cross.docker  |   1 -
 .../dockerfiles/debian-mips64el-cross.docker       |   1 -
 .../docker/dockerfiles/debian-mipsel-cross.docker  |   1 -
 .../docker/dockerfiles/debian-ppc64el-cross.docker |   1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker |   1 -
 tests/docker/dockerfiles/debian.docker             |   1 -
 tests/docker/dockerfiles/ubuntu2204.docker         |   1 -
 tests/lcitool/projects/qemu.yml                    |   1 -
 tests/tcg/s390x/Makefile.softmmu-target            |   2 +-
 22 files changed, 518 insertions(+), 147 deletions(-)


