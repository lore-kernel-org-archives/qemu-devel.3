Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF2EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLl4-0006yh-4m; Fri, 06 Feb 2026 08:20:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLkm-0006pU-3T
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLki-0005Of-V5
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770384001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=moCR76A0aSDUXjFrQ8JjGmzKKBV79+DaRdaItXA+qJ8=;
 b=WYbMoGaKvnxQg3plcFDsNCvV48E5c2KtjyMOLoDGCVCKH40Xha3t1G23PDLTMHb3dNnUay
 1feSsxEKbCnF/CzlM4AZilOWGksIw8Dd0ohZJPprWVbC3mzBX2qeMy2+L59hw4D8Y3nXvp
 JjhtZTmYZ94jri833I4cYFwCM4aiEqQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-bjLzCiQkOCuz9BkdTgJVjA-1; Fri,
 06 Feb 2026 08:14:48 -0500
X-MC-Unique: bjLzCiQkOCuz9BkdTgJVjA-1
X-Mimecast-MFC-AGG-ID: bjLzCiQkOCuz9BkdTgJVjA_1770383686
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96AFB1955DA0; Fri,  6 Feb 2026 13:14:43 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC6941800465; Fri,  6 Feb 2026 13:14:40 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
Date: Fri,  6 Feb 2026 14:14:27 +0100
Message-ID: <20260206131438.1857182-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Windows doesn't ship built-in TCO watchdog driver, and users are
forced to install vendor specific driver(s) if such exists.
However OS provides a generic watchdog driver that uses
ACPI WDAT table [1] to abstract actual hardware behind it.
The same applies to ARM version of Windows.

This series adds
 *  WDAT table tailored for TCO watchdog that Q35 already
    has as part of ICH9 chipset and a knob to enable it.
 *  SBSA GWDT to arm/vit machine with WDAT table tailored
    for it and necessary tweaks to GWDT to make usable
    with WDAT driver.

Guest OS support is present since Windows Vista and Linux since 2016[2].

One can test it launching VM with following options:
   -machine acpi-watchdog=on
to trace access to TCO registers one can add to CLI:
    -trace "tco_*"
to trace access to GWDT registers one can add to CLI:
    -trace "sbsa_gwdt*"

To verify that guest uses WDAT (both Windows and Linux would use it if present),
  * on linux make sure that watchdog service is configured/enabled
   (use wdctl to check what watchdog device to use and confirm that it's
    wadt based one) and then trigger kernel panic with command:
      echo c > /proc/sysrq-trigger
  * on Windows kill svchost process, running cmd in admin mode:
      taskkill /f /im svchost.exe

Tested with WS2025 & RHEL9.6 & Fedore 43 (aarch64)

git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2

1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
2) https://lwn.net/Articles/700524/

PS:
 previous revision (q35 only):
 https://patchwork.ozlabs.org/project/qemu-devel/cover/20251030123750.136175-1-imammedo@redhat.com/

Also CCing SBSA folks to see if they are interested in adding it to their
reference machine

Igor Mammedov (11):
  acpi: add API to build WDAT instructions
  machine: add "acpi-watchdog" property
  x86: q35: generate WDAT ACPI table
  tests: acpi: x86/q35: whitelist new WDAT table
  tests: acpi: x86/q35: add WDAT table test case
  tests: acpi: x86/q35: update expected WDAT blob
  arm: add tracing events to sbsa_gwdt
  arm: virt: create GWDT watchdog paired with WDAT ACPI table
  tests: acpi: arm/virt: whitelist new WDAT table
  tests: acpi: arm/virt: add WDAT table test case
  tests: acpi: arm/virt: update expected WDAT blob

 include/hw/acpi/wdat-gwdt.h            |  19 ++++
 include/hw/acpi/wdat-ich9.h            |  15 ++++
 include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
 include/hw/arm/virt.h                  |   3 +
 include/hw/core/boards.h               |   1 +
 hw/acpi/aml-build.c                    |  14 +++
 hw/acpi/meson.build                    |   5 +-
 hw/acpi/wdat-gwdt-stub.c               |  16 ++++
 hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
 hw/acpi/wdat-ich9-stub.c               |  15 ++++
 hw/acpi/wdat-ich9.c                    |  87 ++++++++++++++++++
 hw/arm/Kconfig                         |   1 +
 hw/arm/virt-acpi-build.c               |  16 ++++
 hw/arm/virt.c                          |  26 ++++++
 hw/core/machine.c                      |  20 +++++
 hw/i386/acpi-build.c                   |  12 +++
 hw/watchdog/sbsa_gwdt.c                |   8 ++
 hw/watchdog/trace-events               |   9 ++
 tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
 tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
 tests/qtest/bios-tables-test.c         |  34 +++++++
 21 files changed, 510 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 include/hw/acpi/wdat-ich9.h
 create mode 100644 include/hw/acpi/wdat.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c
 create mode 100644 hw/acpi/wdat-ich9-stub.c
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

-- 
2.47.3


