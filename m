Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D151C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY2uH-0005GC-Ve; Wed, 15 Jan 2025 07:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2uB-0004Tr-3J
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:53:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY2u8-0007BN-EN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736945630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QR2recj94CXxXW868WLXMz2gHMTs59hzapF3MWLD2w4=;
 b=K+S6QK/bdRM7xVk8cb7ix4D3jOZ3r1P+tWnzanQfzLok1fQR3gE2L64yZ89EPWXVE5Q87b
 8dcKIh4+QIB0myUHy4K227p83naRZ5mbu/1hvUouO333kw3YHv6nebq0K0ZG2Kte+JE4PN
 gF8d0Fa7TZ1XN49v3zxTfGo5Qg+/t1g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-_srh7JIrMcOf7H-knY7i5w-1; Wed,
 15 Jan 2025 07:53:49 -0500
X-MC-Unique: _srh7JIrMcOf7H-knY7i5w-1
X-Mimecast-MFC-AGG-ID: _srh7JIrMcOf7H-knY7i5w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A350A1955BDA
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 12:53:47 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4096F19560AD; Wed, 15 Jan 2025 12:53:45 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH 0/3] workaround Windows always reading _DSM(func=7)
Date: Wed, 15 Jan 2025 13:53:39 +0100
Message-ID: <20250115125342.3883374-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

subj causes PCI devices that do not have acpi-index assigned,
having bogus 'PCI Label Id = 0'.

The later triggers another Windows bug that leads to guest hang
in case of localized Windows versions [1].

Workaround is for QEMU to return invalid Package on _DSM(func=7) request
if acpi-index is not configured, which makes Windows ignore returned value
and not assign 'PCI Label Id'.

It should help [1] users to boot localized Windows variants as long as
no PCI devices have acpi-index explicitly assigned.

1) https://gitlab.com/qemu-project/qemu/-/issues/774 

Igor Mammedov (3):
  tests: acpi: whitelist expected blobs
  pci: acpi: Windows 'PCI Label Id' bug workaround
  tests: acpi: update expected blobs

 tests/qtest/bios-tables-test-allowed-diff.h   |  40 ++++++++++++++++++
 hw/i386/acpi-build.c                          |  33 ++++++++++-----
 tests/data/acpi/x86/pc/DSDT                   | Bin 8526 -> 8544 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8437 -> 8455 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9851 -> 9869 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15397 -> 15415 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 8990 -> 9008 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10180 -> 10198 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8477 -> 8495 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8598 -> 8616 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9885 -> 9903 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8384 -> 8402 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8532 -> 8550 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12319 -> 12337 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8355 -> 8373 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8372 -> 8390 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9680 -> 9698 bytes
 .../data/acpi/x86/q35/DSDT.acpihmat-generic-x | Bin 12565 -> 12583 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8634 -> 8652 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8401 -> 8419 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 11968 -> 11986 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12913 -> 12931 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33770 -> 33788 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8819 -> 8837 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13146 -> 13164 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10009 -> 10027 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8430 -> 8448 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8443 -> 8461 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8372 -> 8390 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9714 -> 9732 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9485 -> 9503 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13208 -> 13226 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8213 -> 8231 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8361 -> 8379 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8456 -> 8474 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12913 -> 12931 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33770 -> 33788 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8961 -> 8979 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 8987 -> 9005 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18589 -> 18607 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14612 -> 14630 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35718 -> 35736 bytes
 42 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.43.0


