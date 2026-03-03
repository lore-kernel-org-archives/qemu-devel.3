Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25910EC0479
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxM0t-0003lr-T2; Tue, 03 Mar 2026 04:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0m-0003hv-Gr
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxM0g-0004O3-Eg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 04:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772529944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f0nviQmyfoxkGSC8TIhGI+gJFiQb12ZDuPZvnBgq6io=;
 b=QTsWQTIu/ddJpvjQ0ilM+JtzNeLDIyy3X47FfK5eJ1osdPwruMMSK44yEqozyiRgZYwhY8
 ZoLTxxkrCu+TBVmfdVpKeFr0gcXpL2mdhJjD9gBwq2KTo9Vdi/l1FZ/mYDxiZeN4TUro0+
 azDFHqEoMoRJhT1keFbLUss1seW6pmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-NKcZjf8uPXuXYW8sYkOm4Q-1; Tue,
 03 Mar 2026 04:25:40 -0500
X-MC-Unique: NKcZjf8uPXuXYW8sYkOm4Q-1
X-Mimecast-MFC-AGG-ID: NKcZjf8uPXuXYW8sYkOm4Q_1772529939
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFE46180049D; Tue,  3 Mar 2026 09:25:38 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CB3C30001B9; Tue,  3 Mar 2026 09:25:34 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v2 00/21] Introduce ACPI watchdog for Q35 and arm/virt boards
Date: Tue,  3 Mar 2026 10:25:11 +0100
Message-ID: <20260303092532.2410177-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Changelog:
  v2:
     * ditch generic '-machine acpi-watchdog' option in favor of
       board specific variants:
           x86/q35:  -machine wdat={on|off}
           arm/virt: -device sbsa_gwdt,wdat={on|off}
     * arm/virt: add FDT and GTDT ACPI entries for GWDT when it's present
       and hide GDTD one when WDAT is enabled.
     * arm/virt: add test case for GTDT 
     * [18-21] optional GWDT cleanup/fixes in handling WCV register update,
       make QEMU behave according to spec (at least the way I read it and
       it appears MS also read it that way). It fixes Windows 11 reboots when
       GWDT is present (without WDAT). With that fixed it's up to MS to fix
       their driver to set sane timeout as with the current one wdatchdog
       will never trigger.

Windows doesn't ship built-in TCO watchdog driver, and users are
forced to install vendor specific driver(s) if such exists.
However the OS provides a generic watchdog driver that uses
ACPI WDAT table [1] to abstract actual hardware behind it.
The same applies to ARM version of Windows.

This series adds
 *  WDAT table tailored for TCO watchdog that Q35 already
    has as part of ICH9 chipset and a knob to enable it.
 *  SBSA GWDT to arm/virt machine with WDAT table tailored
    for it and necessary tweaks to GWDT to make usable
    with WDAT driver.
    * in addition to WDAT, it also adds native variant
      with GWDT described in FDT and DTDT
      (broken on Windows/works on linux).

Guest OS WDAT support is present since Windows Vista and Linux since 2016[2].

One can test it launching VM with following options:
  * x86:
       -machine q35,wdat=on
  * arm/virt:
       -device sbsa_gwdt,wdat=on

to trace access to TCO registers one can add to CLI:
    -trace "tco_*"
to trace access to GWDT registers one can add to CLI:
    -trace "sbsa_gwdt*"

To verify that guest uses WDAT (both Windows and Linux would use it if present),
  * on linux make sure that watchdog service is configured/enabled
    (use wdctl to check what watchdog device is in use) and then
    trigger kernel panic with command:
      echo c > /proc/sysrq-trigger
  * on Windows kill svchost process, running cmd in admin mode:
      taskkill /f /im svchost.exe

Tested with WS2025 & RHEL9.6 & Fedora 43 (aarch64)

git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2

1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
2) https://lwn.net/Articles/700524/

PS:
 previous revision:
  https://patchew.org/QEMU/20260206131438.1857182-1-imammedo@redhat.com/

Igor Mammedov (21):
  acpi: add API to build WDAT instructions
  x86: q35: add 'wdat' property
  x86: q35: generate WDAT ACPI table
  tests: acpi: x86/q35: whitelist new WDAT table
  tests: acpi: x86/q35: add WDAT table test case
  tests: acpi: x86/q35: update expected WDAT blob
  arm: sbsa_gwdt: fixup default "clock-frequency"
  arm: add tracing events to sbsa_gwdt
  arm: virt: create sbsa_gwdt watchdog
  arm: sbsa_gwdt: add 'wdat' option
  arm: virt: add support for WDAT based watchdog
  tests: acpi: arm/virt: whitelist new WDAT table
  tests: acpi: arm/virt: add WDAT table test case
  tests: acpi: arm/virt: update expected WDAT blob
  tests: acpi: arm/virt: whitelist GTDT table
  tests: acpi: arm/virt: add GTDT watchdog table test case
  tests: acpi: arm/virt: update expected GTDT blob
  sbsa_gwdt: reduce code ident
  sbsa_gwdt: move all foo_REFRESH logic under REFRESH condition
  sbsa_gwdt: reschedule timer on direct WCV load
  sbsa_gwdt: limit compare_value to INT64_MAX

 include/hw/acpi/wdat-gwdt.h            |  19 ++++
 include/hw/acpi/wdat-ich9.h            |  15 ++++
 include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
 include/hw/i386/pc.h                   |   1 +
 include/hw/watchdog/sbsa_gwdt.h        |   1 +
 hw/acpi/aml-build.c                    |  14 +++
 hw/acpi/meson.build                    |   5 +-
 hw/acpi/wdat-gwdt-stub.c               |  16 ++++
 hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
 hw/acpi/wdat-ich9-stub.c               |  15 ++++
 hw/acpi/wdat-ich9.c                    |  90 +++++++++++++++++++
 hw/arm/Kconfig                         |   1 +
 hw/arm/virt-acpi-build.c               |  65 +++++++++++++-
 hw/arm/virt.c                          |   2 +
 hw/core/sysbus-fdt.c                   |  32 +++++++
 hw/i386/acpi-build.c                   |  12 +++
 hw/i386/pc_q35.c                       |  18 ++++
 hw/watchdog/sbsa_gwdt.c                |  65 +++++++++-----
 hw/watchdog/trace-events               |   9 ++
 tests/data/acpi/aarch64/virt/GTDT.gwdt | Bin 0 -> 132 bytes
 tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
 tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
 tests/qtest/bios-tables-test.c         |  54 +++++++++++
 23 files changed, 618 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 include/hw/acpi/wdat-ich9.h
 create mode 100644 include/hw/acpi/wdat.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c
 create mode 100644 hw/acpi/wdat-ich9-stub.c
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
 create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

-- 
2.47.3


