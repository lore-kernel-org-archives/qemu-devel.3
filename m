Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7114AD116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 08:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOu78-0006pC-2B; Fri, 28 Nov 2025 03:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOu6i-0006d4-Is
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:45:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vOu6e-0000Ph-T2
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 03:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764319530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JUcPh+IoBQgF90tXIXqi8jdfjgAy/P7gIvjlhWvXh20=;
 b=JvAnCawFjuW/tfHQyeIpvRDROtS//dlEqVqEwOmXoBzeuvrZLHgcAKF6usUKd7ZO4gY5er
 j4Nhd+EY8vj2zTLUjTzHnii3ZaZJ6H1mtjziepVGbf+iWb/wmLrNDfdzc+bFUs+6RV06ew
 ToL9GlXDsEXiAgHrduX2v7CmOOpgibc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-vLfUt5KlMqqswNgZPb5C1g-1; Fri,
 28 Nov 2025 03:45:28 -0500
X-MC-Unique: vLfUt5KlMqqswNgZPb5C1g-1
X-Mimecast-MFC-AGG-ID: vLfUt5KlMqqswNgZPb5C1g_1764319527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A240D195605F; Fri, 28 Nov 2025 08:45:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.236])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6A64195608E; Fri, 28 Nov 2025 08:45:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2E4211800639; Fri, 28 Nov 2025 09:45:24 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 0/9] edk2: update to edk2-stable202511
Date: Fri, 28 Nov 2025 09:45:07 +0100
Message-ID: <20251128084524.363989-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

Update edk2 firmware images to latest upstream release.

Noteworthy edk2 upstream change is that 32-bit architectures (ia32 and
arm) are not supported any more, so the qemu builds of these are removed
too.

v2:
 - add asl diff to test data update.
 - rename rischv builds.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Gerd Hoffmann (9):
  tests/acpi: enable updates
  edk2: update build script
  edk2: update submodule to edk2-stable202511
  edk2: drop 32-bit build config (ia32 and arm), update aarch64 vars
  edk2: drop 32-bit binaries (ia32 and arm)
  edk2: update binaries to edk2-stable202511
  edk2: rename risc-v firmware builds
  tests/acpi: update expected data files
  tests/acpi: disable updates

 roms/edk2-build.py                            |  21 +++++--
 tests/qtest/bios-tables-test.c                |  40 +++++++-------
 pc-bios/descriptors/50-edk2-i386-secure.json  |  34 ------------
 pc-bios/descriptors/60-edk2-aarch64.json      |   2 +-
 pc-bios/descriptors/60-edk2-arm.json          |  31 -----------
 pc-bios/descriptors/60-edk2-i386.json         |  33 -----------
 pc-bios/descriptors/60-edk2-riscv64.json      |   4 +-
 pc-bios/descriptors/meson.build               |   3 -
 pc-bios/edk2-aarch64-code.fd.bz2              | Bin 1565763 -> 1662423 bytes
 ...m-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} | Bin
 pc-bios/edk2-arm-code.fd.bz2                  | Bin 1570311 -> 0 bytes
 pc-bios/edk2-i386-code.fd.bz2                 | Bin 1780004 -> 0 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2          | Bin 1858666 -> 0 bytes
 pc-bios/edk2-i386-vars.fd.bz2                 | Bin 190 -> 0 bytes
 pc-bios/edk2-loongarch64-code.fd.bz2          | Bin 1148383 -> 1178146 bytes
 pc-bios/edk2-riscv-code.fd.bz2                | Bin 1296526 -> 0 bytes
 pc-bios/edk2-riscv64-code.fd.bz2              | Bin 0 -> 1252448 bytes
 ...v-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} | Bin
 pc-bios/edk2-x86_64-code.fd.bz2               | Bin 1907255 -> 2138026 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2            | Bin 1787244 -> 1996414 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2        | Bin 1962992 -> 2293816 bytes
 pc-bios/meson.build                           |  10 +---
 roms/edk2                                     |   2 +-
 roms/edk2-build.config                        |  52 +++---------------
 roms/edk2-version                             |   4 +-
 tests/data/acpi/aarch64/virt/HEST             | Bin 224 -> 224 bytes
 tests/data/acpi/aarch64/virt/SSDT.memhp       | Bin 1817 -> 1817 bytes
 27 files changed, 53 insertions(+), 183 deletions(-)
 delete mode 100644 pc-bios/descriptors/50-edk2-i386-secure.json
 delete mode 100644 pc-bios/descriptors/60-edk2-arm.json
 delete mode 100644 pc-bios/descriptors/60-edk2-i386.json
 rename pc-bios/{edk2-arm-vars.fd.bz2 => edk2-aarch64-vars.fd.bz2} (100%)
 delete mode 100644 pc-bios/edk2-arm-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-secure-code.fd.bz2
 delete mode 100644 pc-bios/edk2-i386-vars.fd.bz2
 delete mode 100644 pc-bios/edk2-riscv-code.fd.bz2
 create mode 100644 pc-bios/edk2-riscv64-code.fd.bz2
 rename pc-bios/{edk2-riscv-vars.fd.bz2 => edk2-riscv64-vars.fd.bz2} (100%)

-- 
2.52.0


