Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49416CE9D48
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJh-0003uH-Sl; Wed, 07 Jan 2026 07:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJX-0003ry-BR
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJP-00027k-4U
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zQRZiqjXcBFWqyw3b1/BFnsZJznbwLCPmyD6ECZ8mCI=;
 b=iP+1ismfudI/dUMOC2/O8POA8s8m9K9CCjlJBUwNsSINuUBPOQyAnzNDbNHbeRzVVUuaGn
 7g4kAz0CQR4GWdOBqTA3Cv3EjTOqZoBcKIuRfaqu0il5KrMK+sn4gtWbBe3Nt8xo9UIe8A
 JCe63DsX7lSc+X0nb/wySSjJgh5r0sk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-VgU7_k1uN6SqJtgGo10sPA-1; Wed,
 07 Jan 2026 07:06:41 -0500
X-MC-Unique: VgU7_k1uN6SqJtgGo10sPA-1
X-Mimecast-MFC-AGG-ID: VgU7_k1uN6SqJtgGo10sPA_1767787601
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9DD11956094; Wed,  7 Jan 2026 12:06:40 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 098FB1956048; Wed,  7 Jan 2026 12:06:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/14] First set of s390x and functional test patches in 2026
Date: Wed,  7 Jan 2026 13:06:24 +0100
Message-ID: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

 Happy new year!

The following changes since commit 0fc482b73d8e085d1375b4e17b0647fd2e6fe8f0:

  Merge tag 'pull-aspeed-20260105' of https://github.com/legoater/qemu into staging (2026-01-06 06:52:47 +1100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-07

for you to fetch changes up to 80802278817770783a07eebc06adc157df89d827:

  tests/functional/qemu_test/testcase: Fix mismatched quotations (2026-01-07 10:41:40 +0100)

----------------------------------------------------------------
* Compat machines for 11.0
* Add some more files to the MAINTAINERS file
* Use explicit big-endian API calls in the s390x code
* Add the possibility to run sub-tests manually in the functional test suite

----------------------------------------------------------------
Cornelia Huck (1):
      hw: add compat machines for 11.0

Fabiano Rosas (1):
      tests/functional: Allow tests to be run individually

Philippe Mathieu-Daudé (8):
      hw/s390x/ccw: Remove deprecated s390-ccw-virtio-5.0 machine
      hw/s390x: Use explicit big-endian LD/ST API
      target/s390x: Use explicit big-endian LD/ST API
      target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
      target/s390x: Replace MO_TE -> MO_BE
      target/s390x: Inline cpu_ld{uw, l}_code() calls in EX opcode helper
      target/s390x: Use big-endian variant of cpu_ld/st_data*()
      target/s390x: Inline translator_lduw() and translator_ldl()

Thomas Huth (3):
      hw/s390x: Un-inline the s390_do_cpu_*() functions
      MAINTAINERS: Add util/s390x_pci_mmio.c to the S390 PCI section
      MAINTAINERS: Add configs/targets/s390x-softmmu.mak to the S390 general section

Yodel Eldar (1):
      tests/functional/qemu_test/testcase: Fix mismatched quotations

 MAINTAINERS                            |   2 +
 docs/devel/testing/functional.rst      |  15 ++++
 include/hw/core/boards.h               |   3 +
 include/hw/i386/pc.h                   |   3 +
 target/s390x/cpu.h                     |  24 +-----
 target/s390x/tcg/insn-data.h.inc       |  54 ++++++-------
 hw/arm/virt.c                          |   9 ++-
 hw/core/machine.c                      |   3 +
 hw/i386/pc.c                           |   3 +
 hw/i386/pc_piix.c                      |  13 ++-
 hw/i386/pc_q35.c                       |  13 ++-
 hw/m68k/virt.c                         |   9 ++-
 hw/ppc/spapr.c                         |  15 +++-
 hw/s390x/css.c                         |  24 +++---
 hw/s390x/s390-pci-bus.c                |   4 +-
 hw/s390x/s390-virtio-ccw.c             |  45 +++++++----
 hw/s390x/virtio-ccw.c                  |  24 +++---
 target/s390x/cpu-system.c              |   2 +-
 target/s390x/cpu.c                     |   5 ++
 target/s390x/gdbstub.c                 |  26 +++---
 target/s390x/kvm/kvm.c                 |   8 +-
 target/s390x/mmu_helper.c              |   3 +-
 target/s390x/tcg/excp_helper.c         |  16 ++--
 target/s390x/tcg/mem_helper.c          |  71 ++++++++--------
 target/s390x/tcg/translate.c           | 144 ++++++++++++++++-----------------
 target/s390x/tcg/vec_helper.c          |   8 +-
 target/s390x/tcg/translate_vx.c.inc    |  38 ++++-----
 tests/functional/qemu_test/testcase.py |   9 +--
 28 files changed, 334 insertions(+), 259 deletions(-)


