Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC047C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 17:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiz2y-0000vO-L7; Mon, 04 Aug 2025 13:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uiwzC-0005jC-QI
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uiwz9-0001SD-Vi
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 11:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754320821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qy/fVFp4dzr8c5G2doGStbvCjggcqM6sA9gPxQgirtQ=;
 b=W8PI+pLYTu7cIuMyhettURrr3FV4PfTsjqXCN299gzT6yGQ9Mcnr708wParSjhdivA8AtN
 Jubtrr+fyAkq5hkFdwlXAgYut3ACPXIKUOmS1DZ6KIKsrYKmaGWwev6mlQKtTI2J0bOZ/+
 CKBZrxUkNZy1MPeQY3Ie0nDHxaqPTaY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PrAh634IPYW76UCcm1UURg-1; Mon,
 04 Aug 2025 11:20:18 -0400
X-MC-Unique: PrAh634IPYW76UCcm1UURg-1
X-Mimecast-MFC-AGG-ID: PrAh634IPYW76UCcm1UURg_1754320817
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 578261955BF7; Mon,  4 Aug 2025 15:20:17 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E8E51956094; Mon,  4 Aug 2025 15:20:12 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 kraxel@redhat.com, mjt@tls.msk.ru
Subject: [PATCH for 10.1] microvm: Explicitly select ACPI_PCI
Date: Mon,  4 Aug 2025 17:20:07 +0200
Message-ID: <20250804152008.247673-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

With a microvm-only build based on a custom device config,
we get a link failure due to undefined reference to
build_pci_host_bridge_osc_method() which is defined in hw/acpi/pci.c and
whose compilation depends on CONFIG_ACPI_PCI. Although CONFIG_ACPI
and CONFIG_PCI are set with such configuration, implied CONFIG_ACPI_PCI
in config PCI_EXPRESS_GENERIC_BRIDGE is not selected as expected.

It Looks like CONFIG_ACPI_PCI must be enforced and this patch selects
CONFIG_ACPI_PCI in MICROVM config directly as done for PC config.

Reproducer:

../configure \
 --without-default-features \
 --target-list=x86_64-softmmu \
 --enable-kvm --disable-tcg \
 --enable-pixman \
 --enable-vnc \
 --audio-drv-list="" \
 --without-default-devices \
 --with-devices-x86_64=microvm \
 --enable-vhost-user

with configs/devices/x86_64-softmmu/microvm.mak:
CONFIG_PCI_DEVICES=n

CONFIG_MICROVM=y

CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_SERIAL=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_INPUT_HOST=y
CONFIG_VHOST_USER_INPUT=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_SCSI=y
CONFIG_VIRTIO_RNG=y
CONFIG_VIRTIO_CRYPTO=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_GPU=y
CONFIG_VHOST_USER_GPU=y

FAILED: qemu-system-x86_64
cc -m64 @qemu-system-x86_64.rsp
/usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_host_bridge_methods':
hw/pci-host/gpex-acpi.c:83:(.text+0x274): undefined reference to `build_pci_host_bridge_osc_method'
collect2: error: ld returned 1 exit status

Fixes: af151d50eac24 "hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method"
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 5139d23087..3a0e2b8ebb 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -131,6 +131,7 @@ config MICROVM
     select I8259
     select MC146818RTC
     select VIRTIO_MMIO
+    select ACPI_PCI
     select ACPI_HW_REDUCED
     select PCI_EXPRESS_GENERIC_BRIDGE
     select USB_XHCI_SYSBUS
-- 
2.49.0


