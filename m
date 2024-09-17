Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB2BC3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVYy-0002O3-4g; Tue, 17 Sep 2024 06:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYu-00025S-Th
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYt-0007I7-2H
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jj0SDkpYgqk3wjEMsFsdQSR9sk8BMbxhfmcx0YnWGeQ=;
 b=L0QmUaMtdCL4wdkE+v1IWOiikBgpbu6E07bdizYy9KES8fTKuFstD/i2ljCiSqtH4O1PF+
 DZoIxTQ4TG5PjtMRIi1BVuk390UITclrZTelrhV0VpCuF6XB5h/xUlrKtqeSWXeEJmN52F
 S7SPMlywGnALsvprcRvZfrdnft8vOHk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-T5NuGsPrMRimFT5G3drhEg-1; Tue,
 17 Sep 2024 06:35:54 -0400
X-MC-Unique: T5NuGsPrMRimFT5G3drhEg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EB351956083; Tue, 17 Sep 2024 10:35:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3AE0319560A3; Tue, 17 Sep 2024 10:35:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/17] tests/qtest/meson.build: Add more CONFIG switches checks
 for the x86 tests
Date: Tue, 17 Sep 2024 12:35:27 +0200
Message-ID: <20240917103540.149144-5-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When configuring QEMU with "--without-default-devices", currently a lot
of the x86 qtests are failing since they silently assume that a certain
device or the i440fx pc machine is available. Add more checks for CONFIG
switches here to not run those tests in case the corresponding device is
not available.

Message-ID: <20240905191434.694440-6-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fc852f3d8b..ce0dba18cb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -50,7 +50,15 @@ qtests_filter = \
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
   qtests_filter + \
-  (have_tools ? ['ahci-test'] : []) +                                                       \
+  (config_all_devices.has_key('CONFIG_ACPI_VMGENID') ? ['vmgenid-test'] : []) +             \
+  (config_all_devices.has_key('CONFIG_AHCI_ICH9') and have_tools ? ['ahci-test'] : []) +    \
+  (config_all_devices.has_key('CONFIG_AHCI_ICH9') ? ['tco-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_FDC_ISA') ? ['fdc-test'] : []) +                      \
+  (config_all_devices.has_key('CONFIG_I440FX') ? ['fw_cfg-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_I440FX') ? ['i440fx-test'] : []) +                    \
+  (config_all_devices.has_key('CONFIG_I440FX') ? ['ide-test'] : []) +                       \
+  (config_all_devices.has_key('CONFIG_I440FX') ? ['numa-test'] : []) +                      \
+  (config_all_devices.has_key('CONFIG_I440FX') ? ['test-x86-cpuid-compat'] : []) +          \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
@@ -64,6 +72,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_I82801B11') ? ['i82801b11-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_IOH3420') ? ['ioh3420-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_LPC_ICH9') ? ['lpc-ich9-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_MC146818RTC') ? ['rtc-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_USB_UHCI') and                                        \
    config_all_devices.has_key('CONFIG_USB_EHCI') ? ['usb-hcd-ehci-test'] : []) +            \
@@ -77,6 +86,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_MEGASAS_SCSI_PCI') ? ['fuzz-megasas-test'] : []) +    \
   (config_all_devices.has_key('CONFIG_LSI_SCSI_PCI') ? ['fuzz-lsi53c895a-test'] : []) +     \
   (config_all_devices.has_key('CONFIG_VIRTIO_SCSI') ? ['fuzz-virtio-scsi-test'] : []) +     \
+  (config_all_devices.has_key('CONFIG_Q35') ? ['q35-test'] : []) +                          \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
@@ -92,25 +102,16 @@ qtests_i386 = \
    config_all_devices.has_key('CONFIG_PARALLEL') ? ['bios-tables-test'] : []) +             \
   qtests_pci +                                                                              \
   qtests_cxl +                                                                              \
-  ['fdc-test',
-   'ide-test',
+  [
    'hd-geo-test',
    'boot-order-test',
-   'rtc-test',
-   'i440fx-test',
-   'fw_cfg-test',
    'device-plug-test',
    'drive_del-test',
-   'tco-test',
    'cpu-plug-test',
-   'q35-test',
-   'vmgenid-test',
    'migration-test',
-   'test-x86-cpuid-compat',
-   'numa-test'
   ]
 
-if dbus_display
+if dbus_display and config_all_devices.has_key('CONFIG_VGA')
   qtests_i386 += ['dbus-display-test']
 endif
 
-- 
2.46.0


