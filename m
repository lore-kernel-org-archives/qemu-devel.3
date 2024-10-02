Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B425CF31B4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyqU-0006cU-2u; Wed, 02 Oct 2024 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqM-0006bD-8X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svyqJ-0003Zt-D4
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727873552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HThwxNwZNRfgKJDbCFqjVZF+wGzGqXhm4mwO6948BdU=;
 b=XpDnoooaodTsa1T43vjIEnaz5uXg4bEBUXW4MjsPqJ/zm3RZ7avuJVx8Mzw4Tw5aAGkrss
 M3b0DayGvZVcZ/dI17sbeNgIzUkCmDl6YXgJE2XtTwU2UQ2/lWQkFwOHct3BpkFt7knejD
 CHO/apxAZu9X9YL6PV6rBKumUk7UBDg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-DQzsjjdyOXuOnzkUYq8yBg-1; Wed,
 02 Oct 2024 08:52:30 -0400
X-MC-Unique: DQzsjjdyOXuOnzkUYq8yBg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF0B91955D59; Wed,  2 Oct 2024 12:52:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CDAA1956056; Wed,  2 Oct 2024 12:52:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] Fix mips64el CI job + some other misc patches
Date: Wed,  2 Oct 2024 14:52:21 +0200
Message-ID: <20241002125226.282193-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:

  Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-02

for you to fetch changes up to e5a007001824f9cde0db58cc960d4efcf1b93f27:

  tests/tcg/s390x: Test modifying an EXECUTE target (2024-10-02 13:01:26 +0200)

----------------------------------------------------------------
* Fix mips64el in the CI
* Remove unused sh4eb target
* Add an additional EXECUTE TCG test for s390x

----------------------------------------------------------------
Alex Bennée (1):
      testing: bump mips64el cross to bookworm and fix package list

Dr. David Alan Gilbert (1):
      qemu-timer: Remove unused timer functions

Ilya Leoshkevich (1):
      tests/tcg/s390x: Test modifying an EXECUTE target

Thomas Huth (2):
      configs: Fix typo in the sh4-softmmu devices config file
      Remove the unused sh4eb target

 configs/devices/sh4-softmmu/default.mak            |  2 +-
 configs/devices/sh4eb-softmmu/default.mak          |  3 --
 configs/targets/sh4eb-softmmu.mak                  |  2 -
 qapi/machine.json                                  |  2 +-
 include/qemu/timer.h                               | 21 --------
 tests/qtest/endianness-test.c                      |  1 -
 tests/qtest/machine-none-test.c                    |  1 -
 tests/tcg/s390x/ex-smc.c                           | 57 ++++++++++++++++++++++
 util/qemu-timer.c                                  | 10 ----
 .gitlab-ci.d/buildtest.yml                         |  2 +-
 .gitlab-ci.d/cirrus.yml                            |  2 +-
 .gitlab-ci.d/crossbuilds.yml                       |  2 +-
 .travis.yml                                        |  2 +-
 .../dockerfiles/debian-mips64el-cross.docker       | 18 ++-----
 tests/lcitool/mappings.yml                         | 26 ++++++++++
 tests/lcitool/refresh                              |  2 +-
 tests/qemu-iotests/testenv.py                      |  1 -
 tests/qtest/meson.build                            |  1 -
 tests/tcg/s390x/Makefile.target                    |  1 +
 19 files changed, 95 insertions(+), 61 deletions(-)
 delete mode 100644 configs/devices/sh4eb-softmmu/default.mak
 delete mode 100644 configs/targets/sh4eb-softmmu.mak
 create mode 100644 tests/tcg/s390x/ex-smc.c


