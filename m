Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77640C9EC8E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHrt-0000xh-DM; Mon, 12 Jan 2026 08:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHpY-0004gE-Fb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfHpV-00030h-FU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768223971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eu1PKUpiqCV2ZLTN2SR72xLno6JoUPLie6pQPBXVzHg=;
 b=BWaHNyp3Cz8yep90HI9aqCsnapsJsttM54iufyLUDO0vXzSBb3NsUGHaDnLpsHXZrYfvGT
 ZwM+rQECK9T8tLy2qo7CNpY8500SQ1iybybWTJuLrq674cPEqZxLpctKf17UMP093YU48Z
 9Yb2FpHcCGhlDQ0uD3SJYnqg1nse41o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-uxMwJuX1MSC2wHWfa7wAwQ-1; Mon,
 12 Jan 2026 08:15:02 -0500
X-MC-Unique: uxMwJuX1MSC2wHWfa7wAwQ-1
X-Mimecast-MFC-AGG-ID: uxMwJuX1MSC2wHWfa7wAwQ_1768223701
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 453261954B06; Mon, 12 Jan 2026 13:15:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.179])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAEBC30001A2; Mon, 12 Jan 2026 13:14:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/15] s390x patches and pylint support for functional tests
Date: Mon, 12 Jan 2026 14:14:42 +0100
Message-ID: <20260112131457.67128-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:

  Merge tag 'pull-riscv-to-apply-20260109' of https://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-12

for you to fetch changes up to f397b7652dac77bf24a491dfee8def59a5d2591f:

  tests/functional/s390x: Add reverse debugging test for s390x (2026-01-12 13:56:28 +0100)

----------------------------------------------------------------
* Check functional tests with pylint
* update copyright year to 2026
* Some more universal-binary work for the s390x code done by Philippe
* Fix reverse debugging for s390x and add a functional test for it

----------------------------------------------------------------
Ani Sinha (1):
      docs: update copyright year to 2026

Ilya Leoshkevich (1):
      target/s390x: Fix infinite loop during replay

Philippe Mathieu-Daudé (6):
      target/s390x: Restrict WatchPoint API to TCG
      target/s390x: Use vaddr for $pc in get_next_pc()
      target/s390x: Replace target_ulong -> uint64_t in gdb_write_register()
      target/s390x: Remove unused 'gdbstub/helpers.h' header in helper.c
      target/s390x: Simplify S390_ADAPTER_SUPPRESSIBLE definition
      target/s390x: Un-inline s390_is_pv()

Thomas Huth (7):
      tests/functional: Add a pylintrc file
      tests/functional/mips/test_malta: Silence warnings reported by pylint
      tests/functional/ppc64/test_hv: Silence warnings reported by pylint
      tests/functional/aarch64/test_virt_gpu: Fix style issues
      tests/functional/aarch64/test_smmu: Silence warning from pylint
      tests/functional: Add a generic test that checks the files with pylint
      tests/functional/s390x: Add reverse debugging test for s390x

 MAINTAINERS                                  |  2 +
 docs/conf.py                                 |  2 +-
 include/hw/s390x/css.h                       |  2 +
 include/qemu/help-texts.h                    |  2 +-
 target/s390x/cpu.h                           |  6 --
 target/s390x/kvm/pv.h                        | 24 +-------
 target/s390x/s390x-internal.h                |  2 -
 target/s390x/tcg/tcg_s390x.h                 |  5 ++
 hw/s390x/tod.c                               |  5 ++
 stubs/async-run-on-cpu.c                     | 11 ++++
 stubs/cpus-queue.c                           |  8 +++
 target/s390x/cpu.c                           | 30 +++++-----
 target/s390x/gdbstub.c                       |  2 +-
 target/s390x/helper.c                        | 39 -------------
 target/s390x/kvm/kvm.c                       |  2 +
 target/s390x/kvm/pv.c                        | 18 ++++++
 target/s390x/machine.c                       |  4 ++
 target/s390x/tcg/debug.c                     | 85 ++++++++++++++++++++++++++++
 target/s390x/tcg/excp_helper.c               | 32 -----------
 target/s390x/tcg/translate.c                 |  5 +-
 util/qemu-timer.c                            | 30 ++++++++++
 stubs/meson.build                            |  2 +
 target/s390x/tcg/meson.build                 |  3 +
 tests/functional/aarch64/test_smmu.py        |  1 +
 tests/functional/aarch64/test_virt_gpu.py    | 20 +++----
 tests/functional/generic/meson.build         |  1 +
 tests/functional/generic/test_linters.py     | 41 ++++++++++++++
 tests/functional/mips/test_malta.py          |  8 +--
 tests/functional/ppc64/test_hv.py            | 10 ++--
 tests/functional/pylintrc                    | 84 +++++++++++++++++++++++++++
 tests/functional/reverse_debugging.py        |  4 +-
 tests/functional/s390x/meson.build           |  1 +
 tests/functional/s390x/test_reverse_debug.py | 21 +++++++
 33 files changed, 368 insertions(+), 144 deletions(-)
 create mode 100644 stubs/async-run-on-cpu.c
 create mode 100644 stubs/cpus-queue.c
 create mode 100644 target/s390x/tcg/debug.c
 create mode 100755 tests/functional/generic/test_linters.py
 create mode 100644 tests/functional/pylintrc
 create mode 100755 tests/functional/s390x/test_reverse_debug.py


