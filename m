Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E29BD42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKb-0006HR-VZ; Tue, 12 Nov 2024 12:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIa-0003Vd-6S
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIV-0001Yt-V2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731430996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W2lFTbP2bem4vtB4O18XLYQH/DWUqw1c48IaJI5uXA8=;
 b=gLcfr13/ZxTcSNqLMpEXmUybvTbIkA8XOTI2/wy5/SHvtpzx6BNNI8pDFjqJwSvrGwNXG4
 jKS/hWG5Q0nH3LVpGmMzt1F9G3twtjZS+Ha+/gX9XUtl0KfFpjNnMS8PqOUp+D48Mn5BMg
 ys72tiHuggQsevOFL66gPPqnEf4fdzM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-iHI5z0RHOPSB52ekFpbS3w-1; Tue,
 12 Nov 2024 12:03:10 -0500
X-MC-Unique: iHI5z0RHOPSB52ekFpbS3w-1
X-Mimecast-MFC-AGG-ID: iHI5z0RHOPSB52ekFpbS3w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D06D81953951; Tue, 12 Nov 2024 17:03:05 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9D901944CC9; Tue, 12 Nov 2024 17:03:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [PATCH 0/7 for-9.2] Fix broken cpu hotplug after migration
Date: Tue, 12 Nov 2024 18:02:51 +0100
Message-ID: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

1st 4 patches are fixing regression and getting rid of not needed changes
that were merged out of context (ARM CPU hotplug) without proper review,
by simply reverting offendining patches to keep history clean as patches
not 9.2 material to begin with.

The rest [5-7/7] are not tested RFC (not for merging to 9.2) for how problem
could be dealt with and could be adopted/changed for the future ARM CPU hotplug
series. 

Igor Mammedov (6):
  Revert "hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug
    states"
  Revert "hw/acpi: Make CPUs ACPI `presence` conditional during vCPU
    hot-unplug"
  tests/acpi: update expected blobs
  acpi: cpuhp: add option to AML genrator to opt-in to always present
    vCPUs
  acpi: cpuhp: use 'realized' status of vCPU to check if CPU is enabled
  acpi: cpuhp: preserve always present vCPUs on unplug

Salil Mehta (1):
  qtest: allow ACPI DSDT Table changes

 include/hw/acpi/cpu.h                         |   5 +-
 include/hw/core/cpu.h                         |   2 -
 hw/acpi/acpi-cpu-hotplug-stub.c               |   3 +-
 hw/acpi/cpu.c                                 |  72 +++++-------------
 hw/acpi/cpu_hotplug.c                         |   2 +-
 hw/acpi/generic_event_device.c                |   2 +-
 tests/data/acpi/x86/pc/DSDT                   | Bin 8560 -> 8526 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8471 -> 8437 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9885 -> 9851 bytes
 tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15431 -> 15397 bytes
 tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9024 -> 8990 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10214 -> 10180 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8511 -> 8477 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5067 -> 5033 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8632 -> 8598 bytes
 tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9919 -> 9885 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8418 -> 8384 bytes
 tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8566 -> 8532 bytes
 tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12353 -> 12319 bytes
 tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8355 bytes
 tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9680 bytes
 .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8634 bytes
 tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8401 bytes
 tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 11968 bytes
 tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8819 bytes
 tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13180 -> 13146 bytes
 tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10009 bytes
 tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8430 bytes
 tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8443 bytes
 tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8372 bytes
 tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9714 bytes
 tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9485 bytes
 tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13208 bytes
 tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8235 bytes
 tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8213 bytes
 tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8361 bytes
 tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8456 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12913 bytes
 tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33770 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8961 bytes
 tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 8987 bytes
 tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18589 bytes
 tests/data/acpi/x86/q35/DSDT.viot             | Bin 14646 -> 14612 bytes
 tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35718 bytes
 47 files changed, 29 insertions(+), 57 deletions(-)

-- 
2.43.0


