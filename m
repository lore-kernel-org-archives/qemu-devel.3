Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C52CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKqc-0006jw-F2; Wed, 24 Jun 2026 06:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKqa-0006jX-R5
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKqY-00077l-LY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782296920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=45YbT8iBm8vR11jNcpNDNAIm1ajkPoRSnoxsv+YxTkM=;
 b=XmsjfqT+wmbkhe4bU4dUDagjjkNebYVAxBIzc8tQaPndiAsvq4iYzxsfTB1JuQZ/BEYqG1
 Cnq/yEfKbl4DoABhmAxCA3Ejk2PtIQWkdAXqOgzbeHuiR4G16cROSVHIuvT98lqB5yQbCc
 iOEfUblKKWsV8xdD6tFI6VuKlK2bml4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-cAjspHu-MLGFvBWL23dGEQ-1; Wed,
 24 Jun 2026 06:28:37 -0400
X-MC-Unique: cAjspHu-MLGFvBWL23dGEQ-1
X-Mimecast-MFC-AGG-ID: cAjspHu-MLGFvBWL23dGEQ_1782296916
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7F031956063; Wed, 24 Jun 2026 10:28:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AA613000B54; Wed, 24 Jun 2026 10:28:33 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v3 00/17] Add watchdog support to arm/virt board
Date: Wed, 24 Jun 2026 12:28:13 +0200
Message-ID: <20260624102830.1355552-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds SBSA GWDT to the arm/virt machine with a WDAT table
tailored for it and necessary tweaks to make it usable with the
WDAT driver.

In addition to WDAT, it also adds a native variant with GWDT
described in FDT and GTDT (works on Linux, broken on Windows
without patches 16-17).

Patches 14-17 fix GWDT handling of direct WCV register writes
to match the SBSA spec. This fixes Windows 11 reboots when GWDT
is present without WDAT.
This is making GTDT watchdog sort of 'work' with Windows, modulo
that Windows sets timeout too far in the future, so in practice
watchdog would never trigger. (WDAT variant doesn't have this
issue).

One can test it launching VM with:
    -device sbsa-gwdt,wdat=on

to trace access to GWDT registers add:
    -trace "sbsa_gwdt*"

To verify the guest uses watchdog use following steps to trigger
watchdog reboot:
  * on Linux: enable watchdog service, check with wdctl, then:
      echo c > /proc/sysrq-trigger
  * on Windows: kill svchost in admin mode 'cmd' shell:
      taskkill /f /im svchost.exe

Tested with Fedora 43 & Windows 11 (aarch64, KVM on Jetson)

git tree: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v3

1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx

Changelog:
  v3:
    * drop x86 patches (already merged)
    * (Eric) rename device type from sbsa_gwdt to sbsa-gwdt (new patch 3)
    * arm: virt: create sbsa-gwdt watchdog (patch 4):
      - (Eric) assign MMIO/IRQ statically, drop dynamic sysbus machinery
      - (Peter) set watchdog freq to system counter clock explicitly
    * arm: sbsa-gwdt: add 'wdat' option (patch 5):
      - split out from v2's monolithic patch 11
    * acpi: introduce WDAT table for GWDT (patch 6):
      - (Eric) split out from v2's patch 11
      - add/improve comments
      - use 'freq' argument passed down by caller
      - simplify magic val on WRR write and add comment
      - group table records by used register
    * arm: virt: add support for WDAT based watchdog (patch 7):
      - (Eric) split out from v2's patch 11
      - skip FDT watchdog node creation in wdat mode
      - skip setting cntfrq clock-frequency in wdat mode
    * sbsa-gwdt: reschedule timer on direct WCV load (patch 16):
      - improved commit message with spec references and
        description of Windows GTDT-mode behavior
    * sbsa-gwdt: limit compare_value to INT64_MAX (patch 17):
      - rewritten commit message: document QEMU timer API
        limitation vs spec, Windows write sequence, and
        vCPU preemption fragility under virtualization

  v2:
    * ditch generic '-machine acpi-watchdog' option in favor of
      board specific: arm/virt: -device sbsa_gwdt,wdat={on|off}
    * arm/virt: add FDT and GTDT ACPI entries for GWDT
    * arm/virt: add test case for GTDT
    * optional GWDT cleanup/fixes for WCV register update

  previous revisions:
    v2: https://patchew.org/QEMU/20260303092532.2410177-1-imammedo@redhat.com/
    v1: https://patchew.org/QEMU/20260206131438.1857182-1-imammedo@redhat.com/

Igor Mammedov (17):
  arm: sbsa_gwdt: fixup default "clock-frequency"
  arm: add tracing events to sbsa_gwdt
  arm: sbsa_gwdt: rename device type to sbsa-gwdt
  arm: virt: create sbsa-gwdt watchdog
  arm: sbsa-gwdt: add 'wdat' option
  acpi: introduce WDAT table for  GWDT
  arm: virt: add support for WDAT based watchdog
  tests: acpi: arm/virt: whitelist new WDAT table
  tests: acpi: arm/virt: add WDAT table test case
  tests: acpi: arm/virt: update expected WDAT blob
  tests: acpi: arm/virt: whitelist GTDT table
  tests: acpi: arm/virt: add GTDT watchdog table test case
  tests: acpi: arm/virt: update expected GTDT blob
  sbsa-gwdt: reduce code ident
  sbsa-gwdt: move all foo_REFRESH logic under REFRESH condition
  sbsa-gwdt: reschedule timer on direct WCV load
  sbsa-gwdt: limit compare_value to INT64_MAX

 include/hw/acpi/wdat-gwdt.h            |  19 +++++
 include/hw/arm/virt.h                  |   3 +
 include/hw/watchdog/sbsa_gwdt.h        |   3 +-
 hw/acpi/meson.build                    |   2 +
 hw/acpi/wdat-gwdt-stub.c               |  16 ++++
 hw/acpi/wdat-gwdt.c                    |  99 +++++++++++++++++++++++++
 hw/arm/Kconfig                         |   1 +
 hw/arm/virt-acpi-build.c               |  51 ++++++++++++-
 hw/arm/virt.c                          |  39 ++++++++++
 hw/core/sysbus-fdt.c                   |   2 +
 hw/watchdog/sbsa_gwdt.c                |  66 +++++++++++------
 hw/watchdog/trace-events               |   9 +++
 tests/data/acpi/aarch64/virt/GTDT.gwdt | Bin 0 -> 132 bytes
 tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
 tests/qtest/bios-tables-test.c         |  41 ++++++++++
 15 files changed, 325 insertions(+), 26 deletions(-)
 create mode 100644 include/hw/acpi/wdat-gwdt.h
 create mode 100644 hw/acpi/wdat-gwdt-stub.c
 create mode 100644 hw/acpi/wdat-gwdt.c
 create mode 100644 tests/data/acpi/aarch64/virt/GTDT.gwdt
 create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat

-- 
2.47.3


