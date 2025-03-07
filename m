Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6201C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWGk-0002Ix-HF; Fri, 07 Mar 2025 06:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGb-0002IU-LH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGZ-0000HO-8z
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VnqWjIdmY4KDP7yaTuiXAVKTRGY3mmKlTPdotnCwYrM=;
 b=WUdeRbn4MKH/wwqjfVwrKvino9uxjVoqKTO0ubwADMmub4AR3npoAr/Vm1TG1Xpf1cw7vU
 SyBufqkNdbAI9RhRklQQUZL73zjamhra1g3QmI2rH7Z6MaQ5wCWgUNnbCAx0YS98NK1NCW
 9LAwwNJbtu4G3rFfRFpMffOFAs5xVSM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624--HKB2TO9Meuxl5a7KxSiCg-1; Fri,
 07 Mar 2025 06:53:20 -0500
X-MC-Unique: -HKB2TO9Meuxl5a7KxSiCg-1
X-Mimecast-MFC-AGG-ID: -HKB2TO9Meuxl5a7KxSiCg_1741348399
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E3E81800875
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:53:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA6481944F2E; Fri,  7 Mar 2025 11:53:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/15] Functional and s390x patches before 10.0 soft-freeze
Date: Fri,  7 Mar 2025 12:52:59 +0100
Message-ID: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit e8a01102936286e012ed0f00bd7f3b7474d415c9:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2025-03-05 21:58:23 +0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-03-07

for you to fetch changes up to d9b5dfc7122559e5b5959ecf534788b90c3dd102:

  s390x/pci: indicate QEMU supports relaxed translation for passthrough (2025-03-07 09:24:00 +0100)

----------------------------------------------------------------
* Bug fixes and some small improvements for functional tests
* Improve performance of s390x PCI passthrough devices with relaxed translation

----------------------------------------------------------------
Aditya Gupta (1):
      doc: add missing 'Asset' type in function test doc

Daniel P. Berrangé (7):
      tests/functional: remove unused 'bin_prefix' variable
      tests/functional: set 'qemu_bin' as an object level field
      tests/functional: reduce tuxrun maxmem to work on 32-bit hosts
      tests/functional: skip memaddr tests on 32-bit builds
      tests/functional: drop unused 'get_tag' method
      tests/functional: stop output from zstd command when uncompressing
      tests/functional: fix race in virtio balloon test

Matthew Rosato (2):
      s390x/pci: add support for guests that request direct mapping
      s390x/pci: indicate QEMU supports relaxed translation for passthrough

Thomas Huth (5):
      tests/functional: Move the code for testing HTTP downloads to a common function
      tests/functional/test_mips_malta: Add a network test via the pcnet NIC
      tests/functional: Increase the timeout of the mips64el_replay test
      tests/functional/test_virtio_balloon: Only use KVM for running this test
      MAINTAINERS: Add docs/devel/testing/functional.rst to the functional section

 MAINTAINERS                               |  1 +
 docs/devel/testing/functional.rst         |  8 ++++---
 include/hw/s390x/s390-pci-bus.h           |  3 +++
 include/hw/s390x/s390-pci-clp.h           |  1 +
 hw/s390x/s390-pci-bus.c                   | 39 +++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c                  | 13 +++++++++--
 hw/s390x/s390-pci-vfio.c                  | 28 ++++++++++++++++++----
 hw/s390x/s390-virtio-ccw.c                |  5 ++++
 tests/functional/meson.build              |  1 +
 tests/functional/qemu_test/linuxkernel.py | 26 ++++++++++++++++++++-
 tests/functional/qemu_test/testcase.py    |  8 +++----
 tests/functional/qemu_test/tuxruntest.py  | 11 ---------
 tests/functional/qemu_test/uncompress.py  |  6 ++---
 tests/functional/test_intel_iommu.py      | 22 +----------------
 tests/functional/test_mem_addr_space.py   | 34 +++++++++++++++++++++++++++
 tests/functional/test_mips_malta.py       | 20 +++++++++++++++-
 tests/functional/test_ppc64_tuxrun.py     |  2 +-
 tests/functional/test_virtio_balloon.py   | 29 ++++++++++++++++++-----
 18 files changed, 197 insertions(+), 60 deletions(-)


