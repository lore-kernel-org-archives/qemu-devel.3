Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F5CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERuz-0000a4-Hx; Thu, 30 Oct 2025 08:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERuw-0000Za-Lo
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vERup-000757-Mp
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761827877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Jorkqq79qeNVBCrrW4IZIAjILo6qNbjs8trWCng1os=;
 b=dY89zuAlJwXCkpRXG5DpdP2K6ULgs30PY3Wwu3hM6Bx7jhZ/tNRQmzRb9pz+iuU8AeQUBM
 Fi2b86s+39zBdV+cWPrJ0anX7CTpfuocoQzX94j6+c3363z594YrnzpxBvL2/Pa0GeKAGj
 r8ct9vAXL4w6G42PAYsq+9jGchVpG8I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-Kgxm0nlGPt6a8O72ervH4g-1; Thu,
 30 Oct 2025 08:37:55 -0400
X-MC-Unique: Kgxm0nlGPt6a8O72ervH4g-1
X-Mimecast-MFC-AGG-ID: Kgxm0nlGPt6a8O72ervH4g_1761827874
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C4A195607A
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 12:37:54 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA4E1180035A; Thu, 30 Oct 2025 12:37:52 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, berrange@redhat.com, rjones@redhat.com
Subject: [PATCH 0/5] x86: q35: add support for WDAT watchdog
Date: Thu, 30 Oct 2025 13:37:45 +0100
Message-ID: <20251030123750.136175-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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


Windows doesn't ship built-in TCO watchdog driver, and users are
forced to install vendor specific driver(s) if such exists.
However OS provides a generic watchdog driver that uses
ACPI WDAT table [1] to abstract actual hardware behind it.

This series adds an optional WDAT table tailored for TCO watchdog
that Q35 already has as part of ICH9 chipset and a knob to enable
it. Guest OS support is present since Windows Vista and Linux
since 2016[2].

One can test it launching VM with following options:
   -watchdog-action reset -global ICH9-LPC.wdat=on
to trace access to TCO registers one can also add to CLI:
    -trace "tco_*"

To verify that guest uses WDAT (both Windows and Linux would use it if present),
  * on linux make sure that watchdog service is configured/running and then
    trigger kernel panic with command:
      echo c > /proc/sysrq-trigger
  * on Windows kill svchost process, running shell in admin mode:
      taskkill /f /im svchost.exe

Tested with WS2025 & RHEL9.6

git tree at: https://gitlab.com/imammedo/qemu/-/commits/wadt_q35_v1

1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
2) https://lwn.net/Articles/700524/

PS:
ARM version of this is still work in progress, and probably should
be ready by the next merge window. So I'm sending only x86 part of
WDAT enablement.

Igor Mammedov (5):
  x86: q35: ich9: add 'wdat' property
  acpi: add API to build WDAT instructions
  x86: q35: generate WDAT ACPI table
  tests: x86: q35: acpi: add WDAT table test case
  tests: acpi: update expected WDAT blob

 include/hw/acpi/ich9.h            |   1 +
 include/hw/acpi/wdat.h            | 121 ++++++++++++++++++++++++++++++
 hw/acpi/aml-build.c               |  14 ++++
 hw/acpi/ich9.c                    |   5 ++
 hw/acpi/meson.build               |   3 +-
 hw/acpi/wdat-ich9.c               |  85 +++++++++++++++++++++
 hw/acpi/wdat-stub.c               |  16 ++++
 hw/i386/acpi-build.c              |  13 ++++
 hw/isa/lpc_ich9.c                 |   1 +
 tests/data/acpi/x86/q35/WDAT.wdat | Bin 0 -> 308 bytes
 tests/qtest/bios-tables-test.c    |  13 ++++
 11 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/acpi/wdat.h
 create mode 100644 hw/acpi/wdat-ich9.c
 create mode 100644 hw/acpi/wdat-stub.c
 create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat

-- 
2.47.3


