Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A81C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVric-0005kO-1P; Mon, 22 Jul 2024 08:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVria-0005co-3l
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sVriW-0006U7-Ax
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mu/btMAjY/GJpqUgcBcXz6M94Ku4WTPYpPI3uU0xl5M=;
 b=W3cCWKdEVUfSoHRVPqf9fylLPt0AnH7B2vncM+jln9qQGq2UgcEU74OyRYqnXtF5eG/Sed
 vXremEUvSRF9c82dALeGVvO22lqJvKxZnzgAOEKDLgPh7qQhmHus1Sr+9cplU8Cv1bwvRs
 sSisTJyB/wgeY/Y6rja6HgiAPKuMcYc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-yPsTBAoFN-yQzuRfI37M2g-1; Mon,
 22 Jul 2024 08:00:33 -0400
X-MC-Unique: yPsTBAoFN-yQzuRfI37M2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 060F419054D1; Mon, 22 Jul 2024 12:00:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.179])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD5791955E7F; Mon, 22 Jul 2024 12:00:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PULL 00/12] QTests, Avocado and s390x fixes for 9.1 softfreeze
Date: Mon, 22 Jul 2024 14:00:14 +0200
Message-ID: <20240722120026.675449-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-07-22

for you to fetch changes up to eed0e8ffa38f0695c0519508f6e4f5a3297cbd67:

  target/s390x: filter deprecated properties based on model expansion type (2024-07-22 13:56:11 +0200)

----------------------------------------------------------------
* Minor clean-ups and fixes for the qtests and Avocado tests
* Fix crash that happens when introspecting scsi-block on older machine types
* s390x: filter deprecated properties based on model expansion type

----------------------------------------------------------------
Cleber Rosa (3):
      tests/avocado/boot_xen.py: merge base classes
      tests/avocado/boot_xen.py: unify tags
      tests/avocado/boot_xen.py: use class attribute

Collin L. Walling (1):
      target/s390x: filter deprecated properties based on model expansion type

Cédric Le Goater (1):
      tests/avocado/machine_aspeed.py: Increase timeout for TPM test

Igor Mammedov (1):
      tests: increase timeout per instance of bios-tables-test

Philippe Mathieu-Daudé (1):
      tests/avocado: Allow overwriting AVOCADO_SHOW env variable

Thomas Huth (4):
      tests/avocado: Move LinuxTest related code into a separate file
      tests/avocado/mem-addr-space-check: Remove unused "import signal"
      tests/avocado: Remove the remainders of the virtiofs_submounts test
      hw: Fix crash that happens when introspecting scsi-block on older machine types

Yao Xingtao (1):
      qtest/fuzz: make range overlap check more readable

 qapi/machine-target.json                           |   5 +-
 hw/core/machine.c                                  |   3 +-
 target/s390x/cpu_models_sysemu.c                   |  16 +-
 tests/qtest/fuzz/generic_fuzz.c                    |   3 +-
 tests/Makefile.include                             |   2 +-
 tests/avocado/avocado_qemu/__init__.py             | 239 +------------------
 tests/avocado/avocado_qemu/linuxtest.py            | 253 +++++++++++++++++++++
 tests/avocado/boot_linux.py                        |   3 +-
 tests/avocado/boot_xen.py                          |  34 +--
 tests/avocado/hotplug_blk.py                       |   2 +-
 tests/avocado/hotplug_cpu.py                       |   2 +-
 tests/avocado/intel_iommu.py                       |   2 +-
 tests/avocado/machine_aspeed.py                    |   2 +-
 tests/avocado/mem-addr-space-check.py              |   1 -
 tests/avocado/replay_linux.py                      |   2 +-
 tests/avocado/smmu.py                              |   3 +-
 .../avocado/virtiofs_submounts.py.data/cleanup.sh  |  46 ----
 .../virtiofs_submounts.py.data/guest-cleanup.sh    |  30 ---
 tests/avocado/virtiofs_submounts.py.data/guest.sh  | 138 -----------
 tests/avocado/virtiofs_submounts.py.data/host.sh   | 127 -----------
 tests/qtest/meson.build                            |   2 +-
 21 files changed, 288 insertions(+), 627 deletions(-)
 create mode 100644 tests/avocado/avocado_qemu/linuxtest.py
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/cleanup.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/guest-cleanup.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/guest.sh
 delete mode 100644 tests/avocado/virtiofs_submounts.py.data/host.sh


