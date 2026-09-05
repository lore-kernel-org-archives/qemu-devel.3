Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366AC624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 17:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uaL-0005H2-KT; Sat, 05 Sep 2026 13:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaH-0005EC-AE; Sat, 05 Sep 2026 13:53:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2uaF-0008I5-0a; Sat, 05 Sep 2026 13:53:45 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECF6844507;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531D1F00ACA;
 Sat,  5 Sep 2026 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788630812;
 bh=1Ap2AaEX7QZiIBIMnM0SlLinjnztzgM3LmFtkWcHmJQ=;
 h=From:To:Cc:Subject:Date;
 b=AZQ8y1kfimIF9IrBWDEkBZhtOB7J6rZHW2X0Ih8sr9vhhukIZdeHuQwJFkgkuEB9X
 3nU1YqTO1/L1dFewb19akLFc66Qu/IHtPPAp+CnAgQXanzokQKimvYRN2AXxsBMUgA
 vCorgSVjQFgiNzv1uhUouUtCX0nb9qh3k6/l0Yy073XGzTXfSJiIWO9iMqesDjqFhg
 xhTOeSpnOKWIFNyWHn7HTLWHQFmHnA4kJ33mHpTAv9iW6Sh89pv+kxeWyKQrRTAHTj
 Dd9B0L1erQ65zWFZ+H3cEwCyPADbeeo3zStZ5hvZa0XZhQV05R+rL8eq+8cWPM7M3J
 3pGaV1pN3aKXw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.5)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1x2ua2-0000000Bkre-2jlL; Sat, 05 Sep 2026 19:53:30 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 0/8] Add SCI support for APEI on x86
Date: Sat,  5 Sep 2026 19:53:20 +0200
Message-ID: <cover.1788630333.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Igor,

After a long time, I finally found some time to finish x86 support
for APEI. Right now, it supports only QMP error inject.

I did local tests here with q35 and it works fine. I also added
tests for both piix4 and q35 at tests/qtest/bios-tables-test.

My end goal is to do functional tests with:
- upstream Kernel + QEMU + rasdaemon.

I'm already working on a temporary tree to implement it.

NOTE: this series is based on v11.1.1. I tried to base it on
the top of master, but there's currently a problem with a
docker.py script that it is causing compilation issues here:

$ ./tests/docker/docker.py
Traceback (most recent call last):
  File "/new_devel/edac/qemu/./tests/docker/docker.py", line 657, in <module>
    sys.exit(main())
             ~~~~^^
  File "/new_devel/edac/qemu/./tests/docker/docker.py", line 653, in main
    return args.cmdobj.run(args, argv)
           ^^^^^^^^^^^
AttributeError: 'Namespace' object has no attribute 'cmdobj'

As this is a separate problem, I'm opting for now to keep it
based on v11.1.1, to make easier for you to review.

There will be a couple of trivial conflicts to be solved when
porting to upstream.

Mauro Carvalho Chehab (8):
  acpi_dev_interface: a ghes support state at AcpiDeviceIfClass
  tests/acpi: virt: reserve expected tables for PC GHES SCI support
  hw/i186: add support for HEST table with SCI
  hw/i386: add GHES support at ICH9 and PIIX4 PM
  tests/acpi: virt: add x86 DSDT and HEST tables
  docs: acpi_hest_ghes: document notification mechanisms
  tests: test GHES notifications on arm64 virt machine
  tests: add GHES tests for x86 piix4 and q35

 docs/specs/acpi_hest_ghes.rst        |  44 +++++++--
 hw/acpi/acpi_interface.c             |   7 ++
 hw/acpi/generic_event_device.c       |   6 ++
 hw/acpi/ghes.c                       |  30 ++++---
 hw/acpi/ich9.c                       |  19 ++++
 hw/acpi/piix4.c                      |  25 ++++++
 hw/i386/Kconfig                      |   1 +
 hw/i386/acpi-build.c                 |  99 ++++++++++++++++++++
 hw/i386/pc.c                         |  41 +++++++++
 hw/isa/lpc_ich9.c                    |   6 ++
 include/hw/acpi/acpi_dev_interface.h |   6 ++
 include/hw/acpi/ich9.h               |   2 +
 include/hw/acpi/piix4.h              |   2 +
 include/hw/i386/pc.h                 |   5 ++
 tests/data/acpi/x86/pc/DSDT.ras      | Bin 0 -> 8818 bytes
 tests/data/acpi/x86/pc/HEST.ras      | Bin 0 -> 132 bytes
 tests/data/acpi/x86/q35/DSDT.ras     | Bin 0 -> 8647 bytes
 tests/data/acpi/x86/q35/HEST.ras     | Bin 0 -> 132 bytes
 tests/qtest/bios-tables-test.c       | 130 +++++++++++++++++++++++++++
 19 files changed, 402 insertions(+), 21 deletions(-)
 create mode 100644 tests/data/acpi/x86/pc/DSDT.ras
 create mode 100644 tests/data/acpi/x86/pc/HEST.ras
 create mode 100644 tests/data/acpi/x86/q35/DSDT.ras
 create mode 100644 tests/data/acpi/x86/q35/HEST.ras

-- 
2.55.0


