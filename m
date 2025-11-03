Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43259CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsGm-0003kD-Rx; Mon, 03 Nov 2025 05:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGl-0003jO-1N
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGg-0003yo-UJ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sc596xiC0ZujHZJu/ipEMf+cSb+EUWo0siASODLSpAA=;
 b=HRjCQl9LptS9WOTpVfkG+DzrH+Z8OIvI/j1lAYRWPHT9Yi/OUIEQKg3POW9HVbcgrPEifw
 jBmDesPak9uUVXTr+1t4u6R4Stf4cLelL9z45RaVqJWV284NQtWJHzDMkJii2wFDyn1w0v
 +WSHAT/r8DFc9wE1s9rOMno7pIQcmR4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-b56lJ1WwMd2UlI0cEsEyEw-1; Mon,
 03 Nov 2025 05:58:28 -0500
X-MC-Unique: b56lJ1WwMd2UlI0cEsEyEw-1
X-Mimecast-MFC-AGG-ID: b56lJ1WwMd2UlI0cEsEyEw_1762167507
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CFC619560BE; Mon,  3 Nov 2025 10:58:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08D8230001A1; Mon,  3 Nov 2025 10:58:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/22] Functional tests and s390x patches for the softfreeze
Date: Mon,  3 Nov 2025 11:57:57 +0100
Message-ID: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:

  Merge tag 'pull-target-arm-20251031' of https://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-11-03

for you to fetch changes up to 0408c61e27aca56c2d40aeb6ca0e5c5f8b8c3845:

  tests/tcg/s390x: Test SET CLOCK COMPARATOR (2025-11-03 08:27:59 +0100)

----------------------------------------------------------------
* Fix spurious EOFError messages from the device-crash-test script
* Fix various issues in the functional tests that pylint complained about
* Improve logging information in the functional tests
* Fix issue in the s390x clock-comparator code
* Use address generation for register branch targets on s390x

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests/functional: include logger name and function in messages
      tests/functional: include the lower level QMP log messages

Ilya Leoshkevich (4):
      target/s390x: Fix missing interrupts for small CKC values
      target/s390x: Fix missing clock-comparator interrupts after reset
      target/s390x: Use address generation for register branch targets
      tests/tcg/s390x: Test SET CLOCK COMPARATOR

John Snow (1):
      scripts/device-crash-test: fix spurious EOFError messages

Philippe Mathieu-Daudé (1):
      hw/s390x: Use memory_region_size()

Thomas Huth (12):
      tests/functional: Fix problems in asset.py reported by pylint
      tests/functional: Fix problems in decorators.py reported by pylint
      tests/functional: Fix problems in linuxkernel.py reported by pylint
      tests/functional: Fix problems in uncompress.py reported by pylint
      tests/functional: Fix problems in utils.py reported by pylint
      tests/functional/arm/test_aspeed_ast1030: Remove unused import
      tests/functional/migration: Fix bad indentation
      tests/functional/ppc64/test_mac99: Fix style issues reported by pylint
      tests/functional/rx/test_gdbsim: Remove unused variables
      tests/functional/x86_64/test_acpi_bits: Silence warnings reported by pylint
      tests/functional/x86_64/test_virtio_balloon: Fix cosmetic issues from pylint
      tests/functional/ppc64: Fix class names to silence pylint warnings

Vladimir Sementsov-Ogievskiy (2):
      tests/functional/.../testcase.py: better socketdir cleanup
      MAINTAINERS: fix functional tests section

 MAINTAINERS                                    |   1 +
 hw/s390x/s390-pci-inst.c                       |   2 +-
 target/s390x/tcg/mem_helper.c                  |  11 +-
 target/s390x/tcg/misc_helper.c                 |  12 +-
 target/s390x/tcg/translate.c                   |  11 +-
 scripts/device-crash-test                      |   2 +-
 tests/functional/arm/test_aspeed_ast1030.py    |   3 +-
 tests/functional/migration.py                  |   4 +-
 tests/functional/ppc/test_74xx.py              |   2 +-
 tests/functional/ppc/test_sam460ex.py          |   5 +-
 tests/functional/ppc64/test_mac99.py           |   8 +-
 tests/functional/ppc64/test_powernv.py         |   2 +-
 tests/functional/ppc64/test_pseries.py         |   2 +-
 tests/functional/ppc64/test_reverse_debug.py   |   2 +-
 tests/functional/qemu_test/asset.py            |  24 ++--
 tests/functional/qemu_test/decorators.py       | 176 ++++++++++++-------------
 tests/functional/qemu_test/linuxkernel.py      |   6 +-
 tests/functional/qemu_test/testcase.py         |   8 +-
 tests/functional/qemu_test/uncompress.py       |  40 +++---
 tests/functional/qemu_test/utils.py            |  22 ++--
 tests/functional/rx/test_gdbsim.py             |   6 +-
 tests/functional/x86_64/test_acpi_bits.py      |   8 +-
 tests/functional/x86_64/test_virtio_balloon.py |   8 +-
 tests/tcg/s390x/Makefile.softmmu-target        |   1 +
 tests/tcg/s390x/sckc.S                         |  63 +++++++++
 25 files changed, 256 insertions(+), 173 deletions(-)
 create mode 100644 tests/tcg/s390x/sckc.S


