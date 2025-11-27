Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C985DCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObso-0004zG-F1; Thu, 27 Nov 2025 08:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0002jt-Jk
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqs-0001I4-HV
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1c/CqcdEjL/bbWaeAxqSK1h7PX2itfCl8C7yrGM9yhg=;
 b=F179FdyD68a9X7Jdug2hOA0LodvsetS5/JoybuFxBW6FQLBThSI2wY5jVVmSNtRKHHORcI
 PvsN25wv9RgQBT1aEuGa+Xi7GWIHJVeQ2PWdiUojFGcT1DQ4ojoQeLd8ZSZ3Kq2TV756Aa
 Bl7keDW6QzfTbKLOkdLKj3ZfenVUNlI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-WObiYR2-OzC0x2YAYhvmbw-1; Thu, 27 Nov 2025 08:15:56 -0500
X-MC-Unique: WObiYR2-OzC0x2YAYhvmbw-1
X-Mimecast-MFC-AGG-ID: WObiYR2-OzC0x2YAYhvmbw_1764249355
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b70b974b818so77247466b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249355; x=1764854155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1c/CqcdEjL/bbWaeAxqSK1h7PX2itfCl8C7yrGM9yhg=;
 b=Vlv+LsXXU90hX+SVgRKPl4zk/gGJCxCDgZnB/Kc7AVbXne7HXkniX7NpZgV5odR4dx
 ljcxzVNmmqKYN14u6BO7QjrzT/C8nkUEI/a6TwWOfL/B58XN4qwDuqZ/GMj2rYQhD6tu
 3megNXtx5bB+PaTjI8Qs+y1Z3/Nsirt/BPzmjTIPuOSLFC1uQgH1FLh1KpZm4clVjlc6
 pigu+L7lqgspYc7X5+56JoD3DmXIypQjc5Z89Fc58OaPVZh9YO4DIuCLjzrf84H7uLRt
 5ZcIwolzW2Q2pMuqLSX8otK1IKHOBmCaslVyYhlW+/MzUIiRifI9O6rB1K4IF6J21OJM
 qFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249355; x=1764854155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1c/CqcdEjL/bbWaeAxqSK1h7PX2itfCl8C7yrGM9yhg=;
 b=NU5lxmJewFN2L/SsYrw4PeayzDkGi6PzwUzpSjropUGctDzovNpUjUyZLTlRTQhaH4
 Eh18hdBt7whk0Fk7et5hXfvVymoGjWen0oOvuwAZtdjDvwIh7Juqcj2UPnv9Ujho1NJ/
 Hbz76qzkfjI2aM2grRjP8O2L9iIIzKZJepFOhHhhP0xSu30Gz7Cq+IpXc4GXp4VTZCxI
 UnfJ4+XSCjXl5EEMo9nY0H8kOBzuAi0qiNU9xmmhe0d0Adqe1cuYcswcu2pEkAnX3ted
 ykCs2jOirKg2uzyrEXfEIl7ca1HgVImN/l/37IjlUbqn7QovBsA83UwsSRvK3kBEiAOe
 6tPA==
X-Gm-Message-State: AOJu0YxKpn/ztSf6okzTr4vJxZp/eaFv6PQkJAN5wJ0VXePhx9O+mw8S
 dNYg6gUxdceR/ewbpdGwUTBWmITBdgrYdBrw8IhLYxN5QraBQUxoauoUDNgfKpmJ5+732K/VW2T
 T/QZogOfRBq/KawIaCA8ztbHyDwlFrf9xYnZkt5/WFvzLgqGu/dj3QYpH49Eb3oikPiC1JLtFbF
 6JqThu3jd0FSk8GyvLUqaqzAVp0R2PrYKmGMmmtgcK
X-Gm-Gg: ASbGnctLKLB5dkMROenXAfgwt20cnC9+5rk7LkKDWIpBPYogmPYz/YI5t95LmRdV9oE
 Jom/iBSDCkTyvATHMC74AWXs3rU30yhtiXFB4HJNWlHcKgQwISdxU6p3A+JtgoSZzIKFshN/PKS
 j/LNOEykjvMlCr2r8HGrPdG6zzzCRck17uzkNOMt87o2IucDFLdruCAPcAd8DCvd+6ilu28WjYu
 ZAgCgckAiSgWKbdPeOB1PQ84TbThPSBl6ISKDviR0k0kcRqBGoLidiMnMJ7KNUkMxES5gxGvIcI
 ddIgmUvze6uwAGqEBXFjMrRylJi0gVZlRycuOcAshabh2rUv9JZInXZYCV10JVSSU1seSeb/F13
 T3f5iElN2yNoU53A7uMnQvETgcxQ8T0I3ZaXF9qN+Iu3xlstkpazI6+9BpYY1LQdDcc6ZnAV5Dx
 gpOJykP3NOhTAYJJ8=
X-Received: by 2002:a17:906:a191:b0:b76:7f64:77a5 with SMTP id
 a640c23a62f3a-b767f64a792mr1848031066b.20.1764249353637; 
 Thu, 27 Nov 2025 05:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLkyVDC3/19oH2lfZjaCRxqzU4Sx2od5v1yicSTM+ZoORiP1AR4uBGuuBy2BHOKqFGudannw==
X-Received: by 2002:a17:906:a191:b0:b76:7f64:77a5 with SMTP id
 a640c23a62f3a-b767f64a792mr1848018366b.20.1764249352138; 
 Thu, 27 Nov 2025 05:15:52 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f516a6c1sm165513366b.13.2025.11.27.05.15.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/28] include: move hw/qdev-properties-system.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:07 +0100
Message-ID: <20251127131516.80807-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/block/block.h                       | 2 +-
 include/hw/{ => core}/qdev-properties-system.h | 0
 include/net/net.h                              | 2 +-
 include/qemu/audio.h                           | 2 +-
 migration/options.h                            | 2 +-
 rust/hw/core/wrapper.h                         | 2 +-
 backends/spdm-socket.c                         | 2 +-
 hw/acpi/vmclock.c                              | 2 +-
 hw/acpi/vmgenid.c                              | 2 +-
 hw/arm/strongarm.c                             | 2 +-
 hw/block/fdc-isa.c                             | 2 +-
 hw/block/fdc.c                                 | 2 +-
 hw/block/m25p80.c                              | 2 +-
 hw/block/pflash_cfi01.c                        | 2 +-
 hw/block/pflash_cfi02.c                        | 2 +-
 hw/block/vhost-user-blk.c                      | 2 +-
 hw/char/avr_usart.c                            | 2 +-
 hw/char/bcm2835_aux.c                          | 2 +-
 hw/char/cadence_uart.c                         | 2 +-
 hw/char/cmsdk-apb-uart.c                       | 2 +-
 hw/char/debugcon.c                             | 2 +-
 hw/char/digic-uart.c                           | 2 +-
 hw/char/diva-gsp.c                             | 2 +-
 hw/char/escc.c                                 | 2 +-
 hw/char/exynos4210_uart.c                      | 2 +-
 hw/char/goldfish_tty.c                         | 2 +-
 hw/char/grlib_apbuart.c                        | 2 +-
 hw/char/ibex_uart.c                            | 2 +-
 hw/char/imx_serial.c                           | 2 +-
 hw/char/ipoctal232.c                           | 2 +-
 hw/char/max78000_uart.c                        | 2 +-
 hw/char/mcf_uart.c                             | 2 +-
 hw/char/nrf51_uart.c                           | 2 +-
 hw/char/parallel.c                             | 2 +-
 hw/char/pl011.c                                | 2 +-
 hw/char/renesas_sci.c                          | 2 +-
 hw/char/sclpconsole-lm.c                       | 2 +-
 hw/char/sclpconsole.c                          | 2 +-
 hw/char/serial-pci-multi.c                     | 2 +-
 hw/char/serial.c                               | 2 +-
 hw/char/sh_serial.c                            | 2 +-
 hw/char/shakti_uart.c                          | 2 +-
 hw/char/sifive_uart.c                          | 2 +-
 hw/char/spapr_vty.c                            | 2 +-
 hw/char/stm32f2xx_usart.c                      | 2 +-
 hw/char/stm32l4x5_usart.c                      | 2 +-
 hw/char/terminal3270.c                         | 2 +-
 hw/char/virtio-console.c                       | 2 +-
 hw/char/xen_console.c                          | 2 +-
 hw/char/xilinx_uartlite.c                      | 2 +-
 hw/core/qdev-properties-system.c               | 2 +-
 hw/hyperv/vmbus.c                              | 2 +-
 hw/i386/kvm/i8254.c                            | 2 +-
 hw/intc/xilinx_intc.c                          | 2 +-
 hw/ipmi/ipmi_bmc_extern.c                      | 2 +-
 hw/ipmi/ipmi_bmc_sim.c                         | 2 +-
 hw/mem/cxl_type3.c                             | 2 +-
 hw/misc/allwinner-sid.c                        | 2 +-
 hw/misc/allwinner-sramc.c                      | 2 +-
 hw/misc/ivshmem-flat.c                         | 2 +-
 hw/misc/ivshmem-pci.c                          | 2 +-
 hw/misc/mac_via.c                              | 2 +-
 hw/misc/sifive_u_otp.c                         | 2 +-
 hw/misc/stm32l4x5_rcc.c                        | 2 +-
 hw/misc/xlnx-versal-cfu.c                      | 2 +-
 hw/net/rocker/rocker.c                         | 2 +-
 hw/net/xen_nic.c                               | 2 +-
 hw/net/xilinx_ethlite.c                        | 2 +-
 hw/nvram/eeprom_at24c.c                        | 2 +-
 hw/nvram/mac_nvram.c                           | 2 +-
 hw/nvram/spapr_nvram.c                         | 2 +-
 hw/nvram/xlnx-bbram.c                          | 2 +-
 hw/nvram/xlnx-efuse.c                          | 2 +-
 hw/pci-bridge/cxl_downstream.c                 | 2 +-
 hw/pci-bridge/cxl_root_port.c                  | 2 +-
 hw/pci-bridge/cxl_upstream.c                   | 2 +-
 hw/pci-bridge/gen_pcie_root_port.c             | 2 +-
 hw/pci/pci.c                                   | 2 +-
 hw/ppc/pnv_pnor.c                              | 2 +-
 hw/rtc/mc146818rtc.c                           | 2 +-
 hw/scsi/scsi-disk.c                            | 2 +-
 hw/scsi/scsi-generic.c                         | 2 +-
 hw/scsi/vhost-user-scsi.c                      | 2 +-
 hw/sd/sd.c                                     | 2 +-
 hw/sh4/sh7750.c                                | 2 +-
 hw/ssi/ibex_spi_host.c                         | 2 +-
 hw/ssi/xilinx_spi.c                            | 2 +-
 hw/timer/xilinx_timer.c                        | 2 +-
 hw/usb/ccid-card-passthru.c                    | 2 +-
 hw/usb/dev-serial.c                            | 2 +-
 hw/usb/redirect.c                              | 2 +-
 hw/vfio/pci.c                                  | 2 +-
 hw/virtio/vdpa-dev.c                           | 2 +-
 hw/virtio/vhost-user-fs.c                      | 2 +-
 hw/virtio/vhost-user-vsock.c                   | 2 +-
 hw/virtio/virtio-iommu-pci.c                   | 2 +-
 hw/xen/xen_pt.c                                | 2 +-
 target/s390x/cpu.c                             | 2 +-
 98 files changed, 97 insertions(+), 97 deletions(-)
 rename include/hw/{ => core}/qdev-properties-system.h (100%)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index b4d914624ee..7dc19d8a453 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -13,7 +13,7 @@
 
 #include "exec/hwaddr.h"
 #include "qapi/qapi-types-block-core.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 /* Configuration */
 
diff --git a/include/hw/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
similarity index 100%
rename from include/hw/qdev-properties-system.h
rename to include/hw/core/qdev-properties-system.h
diff --git a/include/net/net.h b/include/net/net.h
index 72b476ee1dc..45bc86fc86b 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -4,7 +4,7 @@
 #include "qemu/queue.h"
 #include "qapi/qapi-types-net.h"
 #include "net/queue.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #define MAC_FMT "%02X:%02X:%02X:%02X:%02X:%02X"
 #define MAC_ARG(x) ((uint8_t *)(x))[0], ((uint8_t *)(x))[1], \
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index c56af895d62..a92e0b70ef0 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -27,7 +27,7 @@
 
 #include "qemu/queue.h"
 #include "qapi/qapi-types-audio.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #ifdef CONFIG_GIO
 #include "gio/gio.h"
 #endif
diff --git a/migration/options.h b/migration/options.h
index d6f1742e5b9..0c3043f1ffb 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -15,7 +15,7 @@
 #define QEMU_MIGRATION_OPTIONS_H
 
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/client-options.h"
 
 /* migration properties */
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index 8fda78924d8..f6b34161a68 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -28,5 +28,5 @@ typedef enum memory_order {
 #include "hw/core/clock.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/core/irq.h"
diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 07aea375165..bc5c7afb3cd 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -14,7 +14,7 @@
 #include "system/spdm-socket.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
 
 static bool read_bytes(const int socket, uint8_t *buffer,
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
index 55c9f950662..d51cab2e20a 100644
--- a/hw/acpi/vmclock.c
+++ b/hw/acpi/vmclock.c
@@ -18,7 +18,7 @@
 #include "hw/acpi/vmclock.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "system/reset.h"
 
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index fcf9a94daf1..e87c0256964 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -18,7 +18,7 @@
 #include "hw/acpi/vmgenid.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "system/reset.h"
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 3ee73ee4594..acc75476c34 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "strongarm.h"
diff --git a/hw/block/fdc-isa.c b/hw/block/fdc-isa.c
index ebb3d2f7cd8..a10f34a20f5 100644
--- a/hw/block/fdc-isa.c
+++ b/hw/block/fdc-isa.c
@@ -36,7 +36,7 @@
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
 #include "system/block-backend.h"
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 1747f6506fd..4585640af92 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -36,7 +36,7 @@
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/block/block.h"
 #include "system/block-backend.h"
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 648e6bdc008..4a758f83dc7 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -27,7 +27,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index f93b812c024..d1673a1b411 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -40,7 +40,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 6a74bcb7a1b..423516cb301 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -36,7 +36,7 @@
 #include "hw/block/block.h"
 #include "hw/block/flash.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/bitmap.h"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 62295f187ca..4d81d2dc347 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -22,7 +22,7 @@
 #include "qemu/cutils.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/virtio-blk-common.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user-blk.h"
diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index c3515b6f7d0..30e135a244b 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 static int avr_usart_can_receive(void *opaque)
 {
diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 47e24c5bba1..d1e114f2dea 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -24,7 +24,7 @@
 #include "hw/char/bcm2835_aux.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 58c4c95fded..c24ece5fe88 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -32,7 +32,7 @@
 #include "hw/char/cadence_uart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "trace.h"
 
 #ifdef CADENCE_UART_ERR_DEBUG
diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index a5ec61a0044..c3645a553ec 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -27,7 +27,7 @@
 #include "chardev/char-serial.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 REG32(DATA, 0)
 REG32(STATE, 4)
diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
index 36607d0c1c7..a1b370b90be 100644
--- a/hw/char/debugcon.c
+++ b/hw/char/debugcon.c
@@ -30,7 +30,7 @@
 #include "chardev/char-fe.h"
 #include "hw/isa/isa.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define TYPE_ISA_DEBUGCON_DEVICE "isa-debugcon"
diff --git a/hw/char/digic-uart.c b/hw/char/digic-uart.c
index 04dec0df8a6..8a704dfcf50 100644
--- a/hw/char/digic-uart.c
+++ b/hw/char/digic-uart.c
@@ -35,7 +35,7 @@
 
 #include "hw/char/digic-uart.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 enum {
     ST_RX_RDY = (1 << 0),
diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 1dafc1e80c3..280d0413c6e 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -21,7 +21,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
 #define PCI_DEVICE_ID_HP_DIVA           0x1048
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 496bbc56dea..a2fb682f8be 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
index 387156d5e34..d1c2f249150 100644
--- a/hw/char/exynos4210_uart.c
+++ b/hw/char/exynos4210_uart.c
@@ -32,7 +32,7 @@
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 821b3218502..35bcb2a9676 100644
--- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 9731e664c1b..7be847d0932 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/char/grlib_uart.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index ac4a43af84e..3166f6d3094 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -30,7 +30,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 78d2c25f86f..080b7f6331c 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -22,7 +22,7 @@
 #include "hw/char/imx_serial.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/char/ipoctal232.c b/hw/char/ipoctal232.c
index 19f312b9d30..b66c20f4fa8 100644
--- a/hw/char/ipoctal232.c
+++ b/hw/char/ipoctal232.c
@@ -12,7 +12,7 @@
 #include "hw/ipack/ipack.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/bitops.h"
 #include "qemu/module.h"
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index 59ec24a15e8..85fc6eed3e5 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -10,7 +10,7 @@
 #include "hw/char/max78000_uart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
index 391674dbcc6..51edf917c94 100644
--- a/hw/char/mcf_uart.c
+++ b/hw/char/mcf_uart.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "hw/m68k/mcf.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
 
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 6087cabeb3c..73069232441 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -18,7 +18,7 @@
 #include "hw/char/nrf51_uart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 6708d7658bd..07bbc9443fb 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -29,7 +29,7 @@
 #include "chardev/char-parallel.h"
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f37ffd349f6..0b0af677988 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -25,7 +25,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-serial.h"
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 3c1cc43954b..f1c5d5ae6b3 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -26,7 +26,7 @@
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/char/renesas_sci.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index ed08cf42da2..9a16896d228 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -23,7 +23,7 @@
 #include "migration/vmstate.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/s390x/ebcdic.h"
 #include "qom/object.h"
 
diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
index ab444fe1fa4..179d12745cc 100644
--- a/hw/char/sclpconsole.c
+++ b/hw/char/sclpconsole.c
@@ -20,7 +20,7 @@
 #include "hw/s390x/sclp.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/s390x/event-facility.h"
 #include "chardev/char-fe.h"
 #include "qom/object.h"
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index f0af12c14f9..17796b93dd7 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -33,7 +33,7 @@
 #include "hw/core/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
 #define PCI_SERIAL_MAX_PORTS 4
diff --git a/hw/char/serial.c b/hw/char/serial.c
index cbff68a7111..adbd1d1d4ab 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -36,7 +36,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #define UART_LCR_DLAB   0x80    /* Divisor latch access bit */
 
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index 9cd79fce334..b3bed2bb7bf 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -30,7 +30,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sh4/sh.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
index 51e45351d95..2d1bc9cb8e2 100644
--- a/hw/char/shakti_uart.c
+++ b/hw/char/shakti_uart.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/shakti_uart.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/log.h"
 
 static uint64_t shakti_uart_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
index 473374d3de1..af17cf9a6ce 100644
--- a/hw/char/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -24,7 +24,7 @@
 #include "chardev/char-fe.h"
 #include "hw/core/irq.h"
 #include "hw/char/sifive_uart.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #define TX_INTERRUPT_TRIGGER_DELAY_NS 100
 
diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 17a17c47c36..1dd9fb155cb 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -7,7 +7,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define VTERM_BUFSIZE   16
diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
index 2c19ec69cc8..2bf0161fa58 100644
--- a/hw/char/stm32f2xx_usart.c
+++ b/hw/char/stm32f2xx_usart.c
@@ -26,7 +26,7 @@
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 8b208ba9b6a..664d03d6b96 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -27,7 +27,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "trace.h"
 
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 821a75c37a2..1d857bad9bc 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/s390x/3270-ccw.h"
 #include "qom/object.h"
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 8c2a6a9d1d3..25db0f019b8 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -16,7 +16,7 @@
 #include "qemu/module.h"
 #include "trace.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-char.h"
diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
index a0d142582ee..8ee098d9ad4 100644
--- a/hw/char/xen_console.c
+++ b/hw/char/xen_console.c
@@ -30,7 +30,7 @@
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/xen/interface/io/console.h"
 #include "hw/xen/interface/io/xs_wire.h"
 #include "hw/xen/interface/grant_table.h"
diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
index 9d81cd904c6..ba7e9e339b6 100644
--- a/hw/char/xilinx_uartlite.c
+++ b/hw/char/xilinx_uartlite.c
@@ -28,7 +28,7 @@
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
 #include "chardev/char-fe.h"
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d0a66358b5a..fe5464c7da1 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qapi-types-block.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 639d932b094..86b53a23ade 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
index 14b78f30a83..81e742f8667 100644
--- a/hw/i386/kvm/i8254.c
+++ b/hw/i386/kvm/i8254.c
@@ -32,7 +32,7 @@
 #include "system/runstate.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/kvm.h"
 #include "target/i386/kvm/kvm_i386.h"
 #include "qom/object.h"
diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
index 465df1c3af2..f93f0d6e7ea 100644
--- a/hw/intc/xilinx_intc.c
+++ b/hw/intc/xilinx_intc.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qom/object.h"
 
 #define D(x)
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index fb90a7d7c30..fa08ed6c217 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -35,7 +35,7 @@
 #include "chardev/char-fe.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index b86943c3245..3d4fe1a699a 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -30,7 +30,7 @@
 #include "qemu/module.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 
 #define IPMI_NETFN_CHASSIS            0x00
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 26baa1c3d6c..6eb20137a04 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -18,7 +18,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
index 17faf67e606..92a0c7918bc 100644
--- a/hw/misc/allwinner-sid.c
+++ b/hw/misc/allwinner-sid.c
@@ -26,7 +26,7 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/misc/allwinner-sid.h"
 #include "trace.h"
 
diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index bd7f59fec97..423e0a844fa 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/misc/allwinner-sramc.h"
 #include "trace.h"
 
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 790500d34de..1248f9e81bc 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
 #include "system/address-spaces.h"
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index fb69af52f62..b9162589a02 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -23,7 +23,7 @@
 #include "qemu/cutils.h"
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "system/kvm.h"
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 887397ae842..0c608c3dc63 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -28,7 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "system/rtc.h"
 #include "trace.h"
diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
index 1d352680468..899bc31745c 100644
--- a/hw/misc/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index c2b25e9a4de..cf7fa28cbe9 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -27,7 +27,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/registerfields.h"
 #include "trace.h"
 
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 80f9612b2ff..13cd597da49 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -19,7 +19,7 @@
 #include "qemu/units.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 
 #ifndef XLNX_VERSAL_CFU_APB_ERR_DEBUG
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 935e74fd7d1..3eb7b445113 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "hw/pci/msix.h"
 #include "net/net.h"
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 4ef1b7dd29a..f4d0b060130 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -38,7 +38,7 @@
 #include "hw/xen/xen-backend.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #include "hw/xen/interface/io/netif.h"
 #include "hw/xen/interface/io/xs_wire.h"
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 39e64a46e26..72b14811a9d 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -34,7 +34,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/misc/unimp.h"
 #include "net/net.h"
 #include "trace.h"
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index e947cf8a3b2..8b7f2dc13f1 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -15,7 +15,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "qom/object.h"
 
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index b048db0777a..efadb3c943c 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -28,7 +28,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/mac_nvram.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/block-backend.h"
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index c9202ddfcd4..58d81f77c88 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -37,7 +37,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qom/object.h"
 
 struct SpaprNvram {
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index aad445b9018..60ede7e40fb 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -32,7 +32,7 @@
 #include "system/blockdev.h"
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/nvram/xlnx-efuse.h"
 
 #ifndef XLNX_BBRAM_ERR_DEBUG
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 7eb156f9413..facbef3fc4c 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -32,7 +32,7 @@
 #include "qapi/error.h"
 #include "system/blockdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 #define TBIT0_OFFSET     28
 #define TBIT1_OFFSET     29
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1265e40c395..f7b131e67e8 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -14,7 +14,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index df359dee670..616d5d934cc 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -24,7 +24,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "hw/cxl/cxl.h"
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 019c311bb5b..6d708fadc25 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
index fa1cf5e58fd..2f7257d166a 100644
--- a/hw/pci-bridge/gen_pcie_root_port.c
+++ b/hw/pci-bridge/gen_pcie_root_port.c
@@ -16,7 +16,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2371a916809..5996229c813 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -31,7 +31,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/cpr.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index 1083e42ab57..365c4d78b8a 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -16,7 +16,7 @@
 #include "hw/core/loader.h"
 #include "hw/ppc/pnv_pnor.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 
 static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
 {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 56f8c79479e..ccbb2797169 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -30,7 +30,7 @@
 #include "hw/intc/kvm_irqcount.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/timer.h"
 #include "system/system.h"
 #include "system/replay.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 9c78c9e18e2..0f896c27f47 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -37,7 +37,7 @@
 #include "system/blockdev.h"
 #include "hw/block/block.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "system/dma.h"
 #include "system/system.h"
 #include "qemu/cutils.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2ac4fd66c37..0a676a16fa4 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -19,7 +19,7 @@
 #include "hw/scsi/scsi.h"
 #include "migration/qemu-file-types.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/scsi/emulation.h"
 #include "system/block-backend.h"
 #include "trace.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 89f06066b70..3612897d4b9 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -21,7 +21,7 @@
 #include "hw/core/fw-path-provider.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user-scsi.h"
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3df331d5611..5aa34f1d5bd 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -43,7 +43,7 @@
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index aff45320bc5..a0aa89ad318 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -31,7 +31,7 @@
 #include "system/system.h"
 #include "target/sh4/cpu.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "sh7750_regs.h"
 #include "sh7750_regnames.h"
 #include "hw/sh4/sh_intc.h"
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index a7dc0c2f032..50cf08de9c9 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -30,7 +30,7 @@
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index 6dcdd63916a..cf406d08246 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -33,7 +33,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/ssi/ssi.h"
 #include "qom/object.h"
 
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 57a2c7101d1..9c2969a2c4f 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -31,7 +31,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/ptimer.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 306dd7d9146..5ab7855272a 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -14,7 +14,7 @@
 #include <libcacard.h>
 #include "chardev/char-fe.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 286c7711f64..b238cb79375 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -14,7 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/usb/usb.h"
 #include "migration/vmstate.h"
 #include "desc.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 6fd04b7b421..fda5bbca676 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -42,7 +42,7 @@
 #include <usbredirfilter.h>
 
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/usb/usb.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6b71605dd97..a0a66b105aa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -28,7 +28,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "migration/vmstate.h"
 #include "migration/cpr.h"
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 3a6de7ebb43..f2377d2d501 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -21,7 +21,7 @@
 #include "qemu/cutils.h"
 #include "hw/core/qdev.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 0acd9580b13..ad6fcacf066 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -16,7 +16,7 @@
 #include "standard-headers/linux/virtio_fs.h"
 #include "qapi/error.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "qemu/error-report.h"
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index e20e0aee439..c2cd376e732 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/virtio/vhost-user-vsock.h"
 
 static const int user_feature_bits[] = {
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 9d32b8a7b3c..f5f6ce7359d 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -14,7 +14,7 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index c1b92d90cf9..0fe9c0aada8 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -59,7 +59,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
 #include "hw/xen/xen.h"
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index be99b2ab94c..da536fb30ed 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -31,7 +31,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "system/hw_accel.h"
 #include "hw/core/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
+#include "hw/core/qdev-properties-system.h"
 #include "hw/resettable.h"
 #include "fpu/softfloat-helpers.h"
 #include "disas/capstone.h"
-- 
2.51.1


