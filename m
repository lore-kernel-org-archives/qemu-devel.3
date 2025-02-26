Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D67C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEAm-0003Ke-Fe; Wed, 26 Feb 2025 04:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAj-0003Jp-Q0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAf-00083z-Hz
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+KQMaokrZg6n3ht6jZRx4Z9vziSpWj/IYljSW34WfpQ=;
 b=AY1mt+/4jXV+qGQkO3wRTyzE69US+x8PfOd+DiP1PI9H1XxXBP3tXG69V+jBpV40uw1u66
 EfcpIRqN7cQnQB7F4q6bdT2n1IiIktC6kRU4g1usCoGL6daawhkjBPlTZ4AiDB91+RiT/d
 jmRxVTguht78RVqW1HKzhcncOoYJ3Ys=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-XlFyMMdcO_61Y-MErL2sqg-1; Wed,
 26 Feb 2025 04:57:37 -0500
X-MC-Unique: XlFyMMdcO_61Y-MErL2sqg-1
X-Mimecast-MFC-AGG-ID: XlFyMMdcO_61Y-MErL2sqg_1740563856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CAAE190FF83
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:57:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35723180035E; Wed, 26 Feb 2025 09:57:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/18] Functional and other test improvements
Date: Wed, 26 Feb 2025 10:57:13 +0100
Message-ID: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-02-26

for you to fetch changes up to 72cdd672e18c486db7c54a7b33c8b4fe7a0026e6:

  tests/functional: Replace the ppc64 e500 advent calendar test (2025-02-26 08:05:09 +0100)

----------------------------------------------------------------
* Convert more avocado tests to the functional framework
* Fix a problem with the check-patch/check-dco CI jobs
* Replace the ppc64 e500 functional test with a better one
* Test retrieval of machine class properties

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional: Replace the ppc64 e500 advent calendar test

Daniel P. Berrangé (1):
      gitlab: use --refetch in check-patch/check-dco jobs

Peter Maydell (1):
      tests/functional: Bump some arm test timeouts

Philippe Mathieu-Daudé (1):
      tests/functional: Have microblaze tests inherit common parent class

Thomas Huth (14):
      tests/qtest/qom-test: Test retrieval of machine class properties
      tests/functional: Provide a proper name for the VMs in the replay tests
      tests/functional: Convert the xtensa replay test to the functional framework
      tests/functional: Convert the sparc replay avocado test
      tests/functional: Convert the 32-bit ppc replay avocado tests
      tests/functional: Convert the or1k replay avocado tests
      tests/functional: Convert the ppc64 replay avocado tests
      tests/functional: Convert the microblaze replay avocado tests
      tests/functional: Convert the m68k replay avocado tests
      tests/functional: Convert the arm replay avocado tests
      tests/functional: Convert the alpha replay avocado tests
      tests/functional: Convert the s390x replay avocado tests
      tests/functional: Convert the aarch64 replay avocado tests
      tests/functional: Convert the x86_64 replay avocado tests

 tests/qtest/qom-test.c                           |  11 +
 .gitlab-ci.d/check-dco.py                        |   2 +-
 .gitlab-ci.d/check-patch.py                      |   2 +-
 tests/avocado/replay_kernel.py                   | 302 -----------------------
 tests/functional/meson.build                     |  22 +-
 tests/functional/replay_kernel.py                |   2 +-
 tests/functional/test_aarch64_replay.py          |  30 +++
 tests/functional/test_alpha_replay.py            |  29 +++
 tests/functional/test_arm_replay.py              |  69 ++++++
 tests/functional/test_arm_sx1.py                 |   6 +-
 tests/functional/test_m68k_replay.py             |  42 ++++
 tests/functional/test_microblaze_replay.py       |  28 +++
 tests/functional/test_microblaze_s3adsp1800.py   |  27 ++
 tests/functional/test_microblazeel_s3adsp1800.py |  31 +--
 tests/functional/test_or1k_replay.py             |  27 ++
 tests/functional/test_ppc64_e500.py              |  33 ++-
 tests/functional/test_ppc64_replay.py            |  49 ++++
 tests/functional/test_ppc_replay.py              |  34 +++
 tests/functional/test_s390x_replay.py            |  28 +++
 tests/functional/test_sparc_replay.py            |  27 ++
 tests/functional/test_x86_64_replay.py           |  35 +++
 tests/functional/test_xtensa_replay.py           |  28 +++
 22 files changed, 519 insertions(+), 345 deletions(-)
 create mode 100755 tests/functional/test_aarch64_replay.py
 create mode 100755 tests/functional/test_alpha_replay.py
 create mode 100755 tests/functional/test_arm_replay.py
 create mode 100755 tests/functional/test_m68k_replay.py
 create mode 100755 tests/functional/test_microblaze_replay.py
 create mode 100755 tests/functional/test_or1k_replay.py
 create mode 100755 tests/functional/test_ppc64_replay.py
 create mode 100755 tests/functional/test_ppc_replay.py
 create mode 100755 tests/functional/test_s390x_replay.py
 create mode 100755 tests/functional/test_sparc_replay.py
 create mode 100755 tests/functional/test_x86_64_replay.py
 create mode 100755 tests/functional/test_xtensa_replay.py


