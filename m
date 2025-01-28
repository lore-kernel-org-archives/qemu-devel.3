Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E22C02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnWM-0002Ik-3p; Tue, 28 Jan 2025 10:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWI-0002IP-7K
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:28:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tcnWG-0004o0-Lg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738078130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C47V9HHeNEh4cxgtz1r0HUYEXyUXSESMFqh3wpmrwcg=;
 b=I28BE8VhtIPT+7mIrJYq5Hbi/EOjuqYokGVculX21uDtPk7RyqvWREXkt80izICjOnsSrP
 p9Mk4ZKjP5nK+p9ITZhyM0BeDwY7Y8Za6ZMZZGQxKP03qgqKezMJxPLVUjEZqBASp16mbR
 HRwsgEns3y30K13eaiPvgzSNLkmo+6U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-iwkWwrO_P0GR7x4tupumJw-1; Tue,
 28 Jan 2025 10:28:47 -0500
X-MC-Unique: iwkWwrO_P0GR7x4tupumJw-1
X-Mimecast-MFC-AGG-ID: iwkWwrO_P0GR7x4tupumJw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A7E1801895; Tue, 28 Jan 2025 15:28:45 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29E0E18002A6; Tue, 28 Jan 2025 15:28:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/5] Convert the MIPS replay tests to the functional
 framework
Date: Tue, 28 Jan 2025 16:28:34 +0100
Message-ID: <20250128152839.184599-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

tests/avocado/replay_kernel.py is a rather big file with a lot of
Avocado-based tests in it. But in the long run, we rather want to
get away from Avocado, so we eventually have to convert these tests
to the functional framework. For this, we have to separate the tests
by target architecture, since the functional framework cannot detect
this on the fly like Avocado (which e.g. looks at the tag annotations 
in the comments). Let's start the convertion by handling the
MIPS-related tests first (the other replay_kernel tests will follow
later).

v2:
- Put the tests in new files
- Rename the environment variable for enabling slow tests

Thomas Huth (5):
  tests/functional: Add a decorator for skipping long running tests
  tests/functional: Add the ReplayKernelBase class
  tests/functional/test_mipsel_malta: Convert the mipsel replay tests
  tests/functional/test_mips64el_malta: Convert the mips64el replay
    tests
  tests/functional/test_mips_malta: Convert the mips big endian replay
    tests

 MAINTAINERS                                   |   1 +
 docs/devel/testing/functional.rst             |   8 +
 tests/avocado/replay_kernel.py                | 165 ------------------
 tests/functional/meson.build                  |   4 +
 tests/functional/qemu_test/__init__.py        |   2 +-
 tests/functional/qemu_test/decorators.py      |  14 ++
 tests/functional/replay_kernel.py             |  84 +++++++++
 .../functional/test_aarch64_sbsaref_alpine.py |   5 +-
 .../test_aarch64_sbsaref_freebsd.py           |   9 +-
 tests/functional/test_arm_quanta_gsj.py       |   6 +-
 tests/functional/test_mips64el_replay.py      |  60 +++++++
 tests/functional/test_mips_replay.py          |  55 ++++++
 tests/functional/test_mipsel_replay.py        |  54 ++++++
 13 files changed, 289 insertions(+), 178 deletions(-)
 create mode 100644 tests/functional/replay_kernel.py
 create mode 100755 tests/functional/test_mips64el_replay.py
 create mode 100755 tests/functional/test_mips_replay.py
 create mode 100644 tests/functional/test_mipsel_replay.py

-- 
2.48.1


