Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987AACFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObsi-000461-FC; Thu, 27 Nov 2025 08:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqv-0002fS-B0
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqj-0001Gz-73
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4KE57wrb8lisBfg0NrIH7xaAqi5XGDQZTTo6rKdZUQ=;
 b=eE0UO4P+qYQ6twDIlbvmo4UkU8UUiuX9ql2mnHjvsP6i7CGtSiwTsMCQgioFPHDfqf1x+k
 PfAXAYI8d6RgG3MVJ8C7b1TKIghxJZi2USUdoxtj63pXhIhDgWC7RWFb/NFQFpFPGLZrxO
 uAqb2FDM6iAevC5fHYlGRbjqCg4lMgc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-qsAiEOMsObeijav8Z8xQww-1; Thu, 27 Nov 2025 08:15:50 -0500
X-MC-Unique: qsAiEOMsObeijav8Z8xQww-1
X-Mimecast-MFC-AGG-ID: qsAiEOMsObeijav8Z8xQww_1764249349
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6411c626af4so978351a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249348; x=1764854148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D4KE57wrb8lisBfg0NrIH7xaAqi5XGDQZTTo6rKdZUQ=;
 b=ad0+8OQDA93p6HavOmhk4l+OOwDGnjfXx+bHlXbTzq6YaWb1DuSs+x+5j9iRCwGh6i
 pfIJBCpQdMDLG6YtXBsmqczS91Ux958ya0TqdphadAMkjeGQNLdrVDD1V+OUOg41Lo3D
 lWTp4MTHEf871Fb8CTyYv3Nx9e5ji/8pLMLtfP8mjvu9rvqD/XTWL8FhxXCBcUxdQqCm
 x2MHdHDG/M4wDafUJy0MkXUmfl6fXJR4YAPjvKqcCL+faCtiobMKU48r29yi3vJH4M5J
 CO/pWgmTD4nIQJGV6uB6Vx2DQ7xgYq7MW43qm8wFlQLVYY+EPChbl9eRfQ49kxiIb1IW
 yBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249348; x=1764854148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D4KE57wrb8lisBfg0NrIH7xaAqi5XGDQZTTo6rKdZUQ=;
 b=NI8odrRrlE+90kG7yyKFV1otcd5DgQQXRxQ/hso6qyBpLbei+yVd0hxgYcV9kaoq8t
 +CS8BKMD3eS+RuYFBm5RPuncoCM6au3cOxdVjI/v2RZRp/hLaeCw2/dhN3zMJTiyMSbX
 RyrRgXJrVOZDkTaytHsb95SNksBQDMPGPWgsG9ATlVR4VktdigipGVB1yLDgzDnDUuyS
 vkgj5nyF/BCqZldkI6ym1knYjcc6oyqv7bfUJ6q6jgU3yqeOXhftMlCokgStpmJv/pkP
 MoN3111CZ4FvPEA2rx9vKi3r73rEiJS4nLjM5b0XXmn9Kf6ZgMTf5G7JUhxmD/xVuf1v
 nApg==
X-Gm-Message-State: AOJu0YyPSqp3/YXGB0IyewsFJgWXlXCjJuAZ3fO/DQjvbvNhpkK6Ii41
 r88soaLcNAJ0NbXS4WEzeHgq6tRXAIkQA5y5ToOBSxeOxwZ1SAsq7OTb5bN/Lv7Kb5gH156dARi
 Di53p9cJPJ1AOmA7RIY1ewHi9yJq4NSueRFyTQTjaJvWKWvFyXcWnF3jkHCK4Afq8f9U0gMEIPr
 o0CVbl3NKsULfGX9Dn7rnVONeaBVeHFwmN93PHDLvG
X-Gm-Gg: ASbGncsoPUO55codNEcfK+MjV5hBvKYqp4kbr1sPrTL7d4p7m5MmXVQcRYBh6mqTLXp
 a+Zovv1ve/FOCAQLx5dFR6n3baVfNytVz3Q8GsUZut+2afT8O4wHd2AhIB6JZvpQfiNAdejtSP0
 uaWT5ZwwiQYQLXxR+TRoSVqBZY8Cofyw8tmSOYPG3Ksb0DB+JYz36R6i6F0JRCIAW8h6T7HkEZ4
 lIGStow0safeQH1v/x9lWCcF85szL2FPgE59FMWlpEeGJZyghDiMJLM25zR3JseK3h6W3N9Mu4c
 GoFakIB6SyyEos7IekXEni8TJyEvzqNojDOHM6X1/BGUMw/LOWVdHsGJS/8YkH/AXab9ZXIaX1U
 50+doboBnPCIym0SSG8CMkJ5GwpCdrmLRVNpZ0tlHxprc4Q/aYXnwWloiN5Mf8urlRhQaEI+0Un
 cEbzIBy0TCxix4RAc=
X-Received: by 2002:a05:6402:1d50:b0:640:ebe3:dd55 with SMTP id
 4fb4d7f45d1cf-645eb23f84emr8916723a12.6.1764249347553; 
 Thu, 27 Nov 2025 05:15:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnWuLnBZcxrl5O5Vrmalx8T3tl3xy776rikuos4MHWCODRYNyttKF4uIclFOXjJXKywX/crA==
X-Received: by 2002:a05:6402:1d50:b0:640:ebe3:dd55 with SMTP id
 4fb4d7f45d1cf-645eb23f84emr8916653a12.6.1764249346327; 
 Thu, 27 Nov 2025 05:15:46 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035d4csm1486050a12.21.2025.11.27.05.15.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/28] include: move hw/qdev-core.h to hw/core/, rename
Date: Thu, 27 Nov 2025 14:15:04 +0100
Message-ID: <20251127131516.80807-18-pbonzini@redhat.com>
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

Call it hw/core/qdev.h to avoid the duplication in the name.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/qdev-api.rst                 | 2 +-
 hw/audio/intel-hda.h                    | 2 +-
 hw/core/guest-loader.h                  | 2 +-
 hw/s390x/ccw-device.h                   | 2 +-
 hw/s390x/ipl.h                          | 2 +-
 hw/usb/canokey.h                        | 2 +-
 hw/usb/ccid.h                           | 2 +-
 hw/usb/u2f.h                            | 2 +-
 include/block/aio.h                     | 2 +-
 include/hw/acpi/acpi_aml_interface.h    | 2 +-
 include/hw/acpi/acpi_dev_interface.h    | 2 +-
 include/hw/acpi/cpu.h                   | 2 +-
 include/hw/acpi/memory_hotplug.h        | 2 +-
 include/hw/acpi/vmclock.h               | 2 +-
 include/hw/acpi/vmgenid.h               | 2 +-
 include/hw/core/cpu.h                   | 2 +-
 include/hw/core/generic-loader.h        | 2 +-
 include/hw/{qdev-core.h => core/qdev.h} | 0
 include/hw/cpu/cluster.h                | 2 +-
 include/hw/cpu/core.h                   | 2 +-
 include/hw/display/dm163.h              | 2 +-
 include/hw/fsi/fsi-master.h             | 2 +-
 include/hw/fsi/fsi.h                    | 2 +-
 include/hw/fsi/lbus.h                   | 2 +-
 include/hw/hyperv/vmbus.h               | 2 +-
 include/hw/i2c/i2c.h                    | 2 +-
 include/hw/i386/sgx-epc.h               | 2 +-
 include/hw/input/adb.h                  | 2 +-
 include/hw/ipack/ipack.h                | 2 +-
 include/hw/ipmi/ipmi.h                  | 2 +-
 include/hw/isa/isa.h                    | 2 +-
 include/hw/mem/memory-device.h          | 2 +-
 include/hw/mem/pc-dimm.h                | 2 +-
 include/hw/misc/auxbus.h                | 2 +-
 include/hw/misc/led.h                   | 2 +-
 include/hw/misc/vmcoreinfo.h            | 2 +-
 include/hw/nvram/xlnx-bbram.h           | 2 +-
 include/hw/nvram/xlnx-efuse.h           | 2 +-
 include/hw/ppc/pnv_adu.h                | 2 +-
 include/hw/ppc/pnv_lpc.h                | 2 +-
 include/hw/ppc/pnv_occ.h                | 2 +-
 include/hw/ppc/pnv_psi.h                | 2 +-
 include/hw/ppc/pnv_sbe.h                | 2 +-
 include/hw/ppc/spapr_cpu_core.h         | 2 +-
 include/hw/ppc/spapr_drc.h              | 2 +-
 include/hw/ppc/spapr_tpm_proxy.h        | 2 +-
 include/hw/ppc/xics.h                   | 2 +-
 include/hw/qdev-properties.h            | 2 +-
 include/hw/register.h                   | 2 +-
 include/hw/s390x/ap-device.h            | 2 +-
 include/hw/s390x/event-facility.h       | 2 +-
 include/hw/s390x/storage-attributes.h   | 2 +-
 include/hw/s390x/storage-keys.h         | 2 +-
 include/hw/s390x/tod.h                  | 2 +-
 include/hw/scsi/scsi.h                  | 2 +-
 include/hw/sd/sd.h                      | 2 +-
 include/hw/ssi/ssi.h                    | 2 +-
 include/hw/sysbus.h                     | 2 +-
 include/hw/usb/usb.h                    | 2 +-
 include/hw/virtio/virtio-bus.h          | 2 +-
 include/hw/virtio/virtio.h              | 2 +-
 include/hw/watchdog/wdt_diag288.h       | 2 +-
 include/hw/xen/xen-bus.h                | 2 +-
 include/monitor/qdev.h                  | 2 +-
 migration/migration.h                   | 2 +-
 backends/hostmem.c                      | 2 +-
 block/block-backend.c                   | 2 +-
 hw/acpi/erst.c                          | 2 +-
 hw/acpi/memory_hotplug.c                | 2 +-
 hw/arm/allwinner-h3.c                   | 2 +-
 hw/arm/allwinner-r40.c                  | 2 +-
 hw/arm/npcm7xx_boards.c                 | 2 +-
 hw/arm/npcm8xx_boards.c                 | 2 +-
 hw/arm/realview.c                       | 2 +-
 hw/arm/smmuv3.c                         | 2 +-
 hw/audio/model.c                        | 2 +-
 hw/block/vhost-user-blk.c               | 2 +-
 hw/char/sh_serial.c                     | 2 +-
 hw/core/cpu-system.c                    | 2 +-
 hw/core/cpu-user.c                      | 2 +-
 hw/core/gpio.c                          | 2 +-
 hw/core/qdev-clock.c                    | 2 +-
 hw/core/qdev-fw.c                       | 2 +-
 hw/core/qdev-hotplug.c                  | 2 +-
 hw/core/qdev-user.c                     | 2 +-
 hw/core/vm-change-state-handler.c       | 2 +-
 hw/display/artist.c                     | 2 +-
 hw/fsi/aspeed_apb2opb.c                 | 2 +-
 hw/hyperv/hv-balloon.c                  | 2 +-
 hw/i2c/i2c_mux_pca954x.c                | 2 +-
 hw/ppc/pnv_homer.c                      | 2 +-
 hw/remote/machine.c                     | 2 +-
 hw/remote/remote-obj.c                  | 2 +-
 hw/remote/vfio-user-obj.c               | 2 +-
 hw/scsi/vhost-user-scsi.c               | 2 +-
 hw/sd/core.c                            | 2 +-
 hw/tpm/tpm_ppi.c                        | 2 +-
 hw/vfio/iommufd.c                       | 2 +-
 hw/virtio/vdpa-dev.c                    | 2 +-
 hw/xen/xen_pvdev.c                      | 2 +-
 monitor/hmp.c                           | 2 +-
 qom/object.c                            | 2 +-
 qom/qom-hmp-cmds.c                      | 2 +-
 qom/qom-qmp-cmds.c                      | 2 +-
 stubs/hotplug-stubs.c                   | 2 +-
 stubs/sysbus.c                          | 2 +-
 system/bootdevice.c                     | 2 +-
 system/physmem.c                        | 2 +-
 system/qtest.c                          | 2 +-
 tests/qtest/fuzz/generic_fuzz.c         | 2 +-
 ui/console.c                            | 2 +-
 ui/vdagent.c                            | 2 +-
 ui/vnc.c                                | 2 +-
 113 files changed, 112 insertions(+), 112 deletions(-)
 rename include/hw/{qdev-core.h => core/qdev.h} (100%)

diff --git a/docs/devel/qdev-api.rst b/docs/devel/qdev-api.rst
index 3f35eea025a..27b534ba127 100644
--- a/docs/devel/qdev-api.rst
+++ b/docs/devel/qdev-api.rst
@@ -4,4 +4,4 @@
 QEMU Device (qdev) API Reference
 ================================
 
-.. kernel-doc:: include/hw/qdev-core.h
+.. kernel-doc:: include/hw/core/qdev.h
diff --git a/hw/audio/intel-hda.h b/hw/audio/intel-hda.h
index 8d710eee5d6..174cf694f49 100644
--- a/hw/audio/intel-hda.h
+++ b/hw/audio/intel-hda.h
@@ -1,7 +1,7 @@
 #ifndef HW_INTEL_HDA_H
 #define HW_INTEL_HDA_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 /* --------------------------------------------------------------------- */
diff --git a/hw/core/guest-loader.h b/hw/core/guest-loader.h
index 07f4b4884b8..214ccf1ba5d 100644
--- a/hw/core/guest-loader.h
+++ b/hw/core/guest-loader.h
@@ -14,7 +14,7 @@
 #ifndef GUEST_LOADER_H
 #define GUEST_LOADER_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 struct GuestLoaderState {
diff --git a/hw/s390x/ccw-device.h b/hw/s390x/ccw-device.h
index 4439feb1403..15f64cfb636 100644
--- a/hw/s390x/ccw-device.h
+++ b/hw/s390x/ccw-device.h
@@ -12,7 +12,7 @@
 #ifndef HW_S390X_CCW_DEVICE_H
 #define HW_S390X_CCW_DEVICE_H
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/css-bridge.h"
 
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 505cded490c..086e57681c2 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -17,7 +17,7 @@
 #include "exec/target_page.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
diff --git a/hw/usb/canokey.h b/hw/usb/canokey.h
index 1b60d734850..3d489a36ce7 100644
--- a/hw/usb/canokey.h
+++ b/hw/usb/canokey.h
@@ -10,7 +10,7 @@
 #ifndef CANOKEY_H
 #define CANOKEY_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_CANOKEY "canokey"
 #define CANOKEY(obj) \
diff --git a/hw/usb/ccid.h b/hw/usb/ccid.h
index 6b82a55bd4c..4959f7ea0c1 100644
--- a/hw/usb/ccid.h
+++ b/hw/usb/ccid.h
@@ -10,7 +10,7 @@
 #ifndef CCID_H
 #define CCID_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 typedef struct CCIDCardInfo CCIDCardInfo;
diff --git a/hw/usb/u2f.h b/hw/usb/u2f.h
index 8bff13141af..85ff7d0ffab 100644
--- a/hw/usb/u2f.h
+++ b/hw/usb/u2f.h
@@ -26,7 +26,7 @@
 #ifndef U2F_H
 #define U2F_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define U2FHID_PACKET_SIZE 64
 #define U2FHID_PENDING_IN_NUM 32
diff --git a/include/block/aio.h b/include/block/aio.h
index 6049e6a0f4c..cc3d5f25a24 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -24,7 +24,7 @@
 #include "qemu/thread.h"
 #include "qemu/timer.h"
 #include "block/graph-lock.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 
 typedef struct BlockAIOCB BlockAIOCB;
diff --git a/include/hw/acpi/acpi_aml_interface.h b/include/hw/acpi/acpi_aml_interface.h
index 11748a88664..4be1b4acda6 100644
--- a/include/hw/acpi/acpi_aml_interface.h
+++ b/include/hw/acpi/acpi_aml_interface.h
@@ -3,7 +3,7 @@
 
 #include "qom/object.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_ACPI_DEV_AML_IF "acpi-dev-aml-interface"
 typedef struct AcpiDevAmlIfClass AcpiDevAmlIfClass;
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 8294f8f0ccc..5927e40eaff 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -3,7 +3,7 @@
 
 #include "qapi/qapi-types-acpi.h"
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 /* These values are part of guest ABI, and can not be changed */
 typedef enum {
diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index a64d19445cc..557219d2c63 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -13,7 +13,7 @@
 #define ACPI_CPU_H
 
 #include "qapi/qapi-types-acpi.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/core/boards.h"
diff --git a/include/hw/acpi/memory_hotplug.h b/include/hw/acpi/memory_hotplug.h
index 38841d7b065..eb7f460afec 100644
--- a/include/hw/acpi/memory_hotplug.h
+++ b/include/hw/acpi/memory_hotplug.h
@@ -2,7 +2,7 @@
 #define QEMU_HW_ACPI_MEMORY_HOTPLUG_H
 
 #include "qapi/qapi-types-acpi.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 
diff --git a/include/hw/acpi/vmclock.h b/include/hw/acpi/vmclock.h
index 5605605812c..d88176d1951 100644
--- a/include/hw/acpi/vmclock.h
+++ b/include/hw/acpi/vmclock.h
@@ -2,7 +2,7 @@
 #define ACPI_VMCLOCK_H
 
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qemu/uuid.h"
 #include "qom/object.h"
 
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index fb135d5bcbe..10985412726 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -2,7 +2,7 @@
 #define ACPI_VMGENID_H
 
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qemu/uuid.h"
 #include "qom/object.h"
 
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9615051774d..f6f17df9e64 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_CPU_H
 #define QEMU_CPU_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "disas/dis-asm.h"
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loader.h
index 19d87b39c8b..ed6d3ba9309 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -19,7 +19,7 @@
 #define GENERIC_LOADER_H
 
 #include "elf.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 struct GenericLoaderState {
diff --git a/include/hw/qdev-core.h b/include/hw/core/qdev.h
similarity index 100%
rename from include/hw/qdev-core.h
rename to include/hw/core/qdev.h
diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 53fbf36af54..b79de065ad1 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -20,7 +20,7 @@
 #ifndef HW_CPU_CLUSTER_H
 #define HW_CPU_CLUSTER_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 /*
diff --git a/include/hw/cpu/core.h b/include/hw/cpu/core.h
index 98ab91647eb..22c53ff288a 100644
--- a/include/hw/cpu/core.h
+++ b/include/hw/cpu/core.h
@@ -9,7 +9,7 @@
 #ifndef HW_CPU_CORE_H
 #define HW_CPU_CORE_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define TYPE_CPU_CORE "cpu-core"
diff --git a/include/hw/display/dm163.h b/include/hw/display/dm163.h
index 4377f77bb75..e1d2e05abc0 100644
--- a/include/hw/display/dm163.h
+++ b/include/hw/display/dm163.h
@@ -13,7 +13,7 @@
 #define HW_DISPLAY_DM163_H
 
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_DM163 "dm163"
 OBJECT_DECLARE_SIMPLE_TYPE(DM163State, DM163);
diff --git a/include/hw/fsi/fsi-master.h b/include/hw/fsi/fsi-master.h
index b634ecd3938..60ddaa994f7 100644
--- a/include/hw/fsi/fsi-master.h
+++ b/include/hw/fsi/fsi-master.h
@@ -8,7 +8,7 @@
 #define FSI_FSI_MASTER_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/fsi/fsi.h"
 #include "hw/fsi/cfam.h"
 
diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
index f34765ed80b..26d7e89c228 100644
--- a/include/hw/fsi/fsi.h
+++ b/include/hw/fsi/fsi.h
@@ -8,7 +8,7 @@
 #define FSI_FSI_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/fsi/lbus.h"
 #include "qemu/bitops.h"
 
diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
index 12519073cd3..1b894509fe4 100644
--- a/include/hw/fsi/lbus.h
+++ b/include/hw/fsi/lbus.h
@@ -7,7 +7,7 @@
 #ifndef FSI_LBUS_H
 #define FSI_LBUS_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qemu/units.h"
 #include "system/memory.h"
 
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 06b948bbb08..e0ef2f2c02e 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -12,7 +12,7 @@
 
 #include "system/system.h"
 #include "system/dma.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "migration/vmstate.h"
 #include "hw/hyperv/vmbus-proto.h"
 #include "qemu/uuid.h"
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1ba..dd5930f4b5e 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_I2C_H
 #define QEMU_I2C_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 /* The QEMU I2C implementation only supports simple transfers that complete
diff --git a/include/hw/i386/sgx-epc.h b/include/hw/i386/sgx-epc.h
index 41d55da4799..ba976611628 100644
--- a/include/hw/i386/sgx-epc.h
+++ b/include/hw/i386/sgx-epc.h
@@ -12,7 +12,7 @@
 #ifndef QEMU_SGX_EPC_H
 #define QEMU_SGX_EPC_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/i386/hostmem-epc.h"
 
 #define TYPE_SGX_EPC "sgx-epc"
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index 20fced15f70..10791958302 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -26,7 +26,7 @@
 #ifndef ADB_H
 #define ADB_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define MAX_ADB_DEVICES 16
diff --git a/include/hw/ipack/ipack.h b/include/hw/ipack/ipack.h
index d86ef84233c..fdd6c069c5a 100644
--- a/include/hw/ipack/ipack.h
+++ b/include/hw/ipack/ipack.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_IPACK_H
 #define QEMU_IPACK_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index cd581aa1342..dabbb9ec5d8 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -26,7 +26,7 @@
 #define HW_IPMI_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define MAX_IPMI_MSG_SIZE 300
diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index a82c5f1004f..94bff33fcc7 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -5,7 +5,7 @@
 
 #include "system/memory.h"
 #include "system/ioport.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define ISA_NUM_IRQS 16
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index c0a58087ccc..10adcd3b8c0 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -13,7 +13,7 @@
 #ifndef MEMORY_DEVICE_H
 #define MEMORY_DEVICE_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/qapi-types-machine.h"
 #include "qom/object.h"
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index e0dbdd43dca..f2df951bafd 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -17,7 +17,7 @@
 #define QEMU_PC_DIMM_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define TYPE_PC_DIMM "pc-dimm"
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 0051e039471..5bfdd05e152 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -26,7 +26,7 @@
 #define HW_MISC_AUXBUS_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 typedef enum AUXCommand AUXCommand;
diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
index 29c08795708..4d077a7c43e 100644
--- a/include/hw/misc/led.h
+++ b/include/hw/misc/led.h
@@ -9,7 +9,7 @@
 #define HW_MISC_LED_H
 
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_LED "led"
 
diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
index 1aa44771632..3cafc7d42e1 100644
--- a/include/hw/misc/vmcoreinfo.h
+++ b/include/hw/misc/vmcoreinfo.h
@@ -12,7 +12,7 @@
 #ifndef VMCOREINFO_H
 #define VMCOREINFO_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "standard-headers/linux/qemu_fw_cfg.h"
 #include "qom/object.h"
 
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index ad2e4a250f5..63558dbc329 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -27,7 +27,7 @@
 #define XLNX_BBRAM_H
 
 #include "system/block-backend.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
 #include "hw/register.h"
diff --git a/include/hw/nvram/xlnx-efuse.h b/include/hw/nvram/xlnx-efuse.h
index ef14fb0528a..08a9ce790d7 100644
--- a/include/hw/nvram/xlnx-efuse.h
+++ b/include/hw/nvram/xlnx-efuse.h
@@ -28,7 +28,7 @@
 #define XLNX_EFUSE_H
 
 #include "system/block-backend.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_XLNX_EFUSE "xlnx-efuse"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxEFuse, XLNX_EFUSE);
diff --git a/include/hw/ppc/pnv_adu.h b/include/hw/ppc/pnv_adu.h
index f9dbd8c8b37..d3a935a46d6 100644
--- a/include/hw/ppc/pnv_adu.h
+++ b/include/hw/ppc/pnv_adu.h
@@ -11,7 +11,7 @@
 
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_lpc.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_PNV_ADU "pnv-adu"
 
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 266d56214f8..c219f87b169 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -22,7 +22,7 @@
 
 #include "system/memory.h"
 #include "hw/ppc/pnv.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/isa/isa.h" /* For ISA_NUM_IRQS */
 
 #define TYPE_PNV_LPC "pnv-lpc"
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 013ea2e53e3..84bdf5004da 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -21,7 +21,7 @@
 #define PPC_PNV_OCC_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_PNV_OCC "pnv-occ"
 OBJECT_DECLARE_TYPE(PnvOCC, PnvOCCClass,
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index cf7f95a6b1f..8a04860aa8b 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "hw/ppc/xics.h"
 #include "hw/ppc/xive.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_PNV_PSI "pnv-psi"
 OBJECT_DECLARE_TYPE(PnvPsi, PnvPsiClass,
diff --git a/include/hw/ppc/pnv_sbe.h b/include/hw/ppc/pnv_sbe.h
index 48a8b86a80b..d5d76a4de16 100644
--- a/include/hw/ppc/pnv_sbe.h
+++ b/include/hw/ppc/pnv_sbe.h
@@ -21,7 +21,7 @@
 #define PPC_PNV_SBE_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_PNV_SBE "pnv-sbe"
 OBJECT_DECLARE_TYPE(PnvSBE, PnvSBEClass, PNV_SBE)
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 68f70834832..273bb332020 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -10,7 +10,7 @@
 #define HW_SPAPR_CPU_CORE_H
 
 #include "hw/cpu/core.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "target/ppc/cpu-qom.h"
 #include "target/ppc/cpu.h"
 #include "qom/object.h"
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 9ff42909c93..bb80f95d91e 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -16,7 +16,7 @@
 #include <libfdt.h>
 #include "qom/object.h"
 #include "system/runstate.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/error.h"
 
 #define TYPE_SPAPR_DR_CONNECTOR "spapr-dr-connector"
diff --git a/include/hw/ppc/spapr_tpm_proxy.h b/include/hw/ppc/spapr_tpm_proxy.h
index 96d2a9697e5..831d36a02ff 100644
--- a/include/hw/ppc/spapr_tpm_proxy.h
+++ b/include/hw/ppc/spapr_tpm_proxy.h
@@ -14,7 +14,7 @@
 #define HW_SPAPR_TPM_PROXY_H
 
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TYPE_SPAPR_TPM_PROXY "spapr-tpm-proxy"
 OBJECT_DECLARE_SIMPLE_TYPE(SpaprTpmProxy, SPAPR_TPM_PROXY)
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 097fcdf00f9..3f78e371221 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -29,7 +29,7 @@
 #define XICS_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define XICS_IPI        0x2
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 60b81330097..d8745d4c65f 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -1,7 +1,7 @@
 #ifndef QEMU_QDEV_PROPERTIES_H
 #define QEMU_QDEV_PROPERTIES_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 /**
  * Property:
diff --git a/include/hw/register.h b/include/hw/register.h
index 7b0f4c8b7a6..b3d20fee7d3 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -11,7 +11,7 @@
 #ifndef REGISTER_H
 #define REGISTER_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/memory.h"
 #include "hw/registerfields.h"
 #include "qom/object.h"
diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
index e502745de5e..f746addb428 100644
--- a/include/hw/s390x/ap-device.h
+++ b/include/hw/s390x/ap-device.h
@@ -11,7 +11,7 @@
 #ifndef HW_S390X_AP_DEVICE_H
 #define HW_S390X_AP_DEVICE_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define TYPE_AP_DEVICE       "ap-device"
diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-facility.h
index eac7a511003..5c556f2b4d8 100644
--- a/include/hw/s390x/event-facility.h
+++ b/include/hw/s390x/event-facility.h
@@ -16,7 +16,7 @@
 #define HW_S390_SCLP_EVENT_FACILITY_H
 
 #include "qemu/thread.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/s390x/sclp.h"
 #include "qom/object.h"
 
diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
index b5c6d8fa552..66716a97c05 100644
--- a/include/hw/s390x/storage-attributes.h
+++ b/include/hw/s390x/storage-attributes.h
@@ -12,7 +12,7 @@
 #ifndef S390_STORAGE_ATTRIBUTES_H
 #define S390_STORAGE_ATTRIBUTES_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "monitor/monitor.h"
 #include "qom/object.h"
 
diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index ac303001f57..2d02936c31c 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -12,7 +12,7 @@
 #ifndef S390_STORAGE_KEYS_H
 #define S390_STORAGE_KEYS_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "monitor/monitor.h"
 #include "qom/object.h"
 
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 0935e850891..bcb20994c87 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -11,7 +11,7 @@
 #ifndef HW_S390_TOD_H
 #define HW_S390_TOD_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "tcg/s390-tod.h"
 #include "qom/object.h"
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 044bd048b49..83782339d4b 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -3,7 +3,7 @@
 
 #include "block/aio.h"
 #include "hw/block/block.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "scsi/utils.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 91b5c40a5f8..d12f24955a5 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -30,7 +30,7 @@
 #ifndef HW_SD_H
 #define HW_SD_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define OUT_OF_RANGE            (1 << 31)
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 2ad8033d8f5..6d6d8ccb3d4 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -13,7 +13,7 @@
 #ifndef QEMU_SSI_H
 #define QEMU_SSI_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 typedef enum SSICSMode SSICSMode;
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 69eb62e29c8..c0d18d9e00b 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -3,7 +3,7 @@
 
 /* Devices attached directly to the main system bus.  */
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/memory.h"
 #include "qom/object.h"
 
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h
index 26a9f3ecdee..78e2ceedd7f 100644
--- a/include/hw/usb/usb.h
+++ b/include/hw/usb/usb.h
@@ -26,7 +26,7 @@
  */
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 7ab8c9dab05..1a2d3961565 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -25,7 +25,7 @@
 #ifndef VIRTIO_BUS_H
 #define VIRTIO_BUS_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/virtio/virtio.h"
 #include "qom/object.h"
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d97529c3f1e..91ff2fa21a5 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -15,7 +15,7 @@
 #define QEMU_VIRTIO_H
 
 #include "system/memory.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/virtio/virtio-features.h"
 #include "net/net.h"
 #include "migration/vmstate.h"
diff --git a/include/hw/watchdog/wdt_diag288.h b/include/hw/watchdog/wdt_diag288.h
index f72c1d3318d..c76f7e5d36b 100644
--- a/include/hw/watchdog/wdt_diag288.h
+++ b/include/hw/watchdog/wdt_diag288.h
@@ -1,7 +1,7 @@
 #ifndef WDT_DIAG288_H
 #define WDT_DIAG288_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qom/object.h"
 
 #define TYPE_WDT_DIAG288 "diag288"
diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index bdbf1ed6fd0..4416123f1f9 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -8,7 +8,7 @@
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/xen/xen_backend_ops.h"
 #include "qemu/notify.h"
 #include "qemu/queue.h"
diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index de33637869b..f85f25738d5 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -1,7 +1,7 @@
 #ifndef MONITOR_QDEV_H
 #define MONITOR_QDEV_H
 
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 /*** monitor commands ***/
 
diff --git a/migration/migration.h b/migration/migration.h
index 213b33fe6e5..fbe02d5bb1a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -15,7 +15,7 @@
 #define QEMU_MIGRATION_H
 
 #include "exec/cpu-common.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/qapi-types-migration.h"
 #include "qobject/json-writer.h"
 #include "qemu/thread.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index d5834916648..67827c42b87 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -21,7 +21,7 @@
 #include "qemu/mmap-alloc.h"
 #include "qemu/madvise.h"
 #include "qemu/cutils.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #ifdef CONFIG_NUMA
 #include <numaif.h>
diff --git a/block/block-backend.c b/block/block-backend.c
index f8d6ba65c11..050e5b95350 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -16,7 +16,7 @@
 #include "block/blockjob.h"
 #include "block/coroutines.h"
 #include "block/throttle-groups.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/blockdev.h"
 #include "system/runstate.h"
 #include "system/replay.h"
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 099cabb7ab7..10bbe37c170 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/memory.h"
 #include "qom/object.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 2f17d45907d..1ddfdd17b75 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -2,7 +2,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qapi/error.h"
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 6c4c369e991..757c89ef39f 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index f6d4117a068..396e886af47 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -23,7 +23,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index fda375eb4c3..729306b33c5 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -23,7 +23,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/core/loader.h"
 #include "hw/nvram/eeprom_at24c.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 292f44d807c..7252edf3dcb 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -22,7 +22,7 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 65506768e41..d7f96b9d3e4 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -18,7 +18,7 @@
 #include "hw/net/lan9118.h"
 #include "hw/net/smc91c111.h"
 #include "hw/pci/pci.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index ae4fba15991..e391842dc33 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -22,7 +22,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
 #include "exec/target_page.h"
diff --git a/hw/audio/model.c b/hw/audio/model.c
index 40929c6e77a..ff4e4b24528 100644
--- a/hw/audio/model.c
+++ b/hw/audio/model.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "monitor/qdev.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f69428..b399eab51a1 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -20,7 +20,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/virtio-blk-common.h"
diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
index ee430dd3d26..008a2ea2f04 100644
--- a/hw/char/sh_serial.c
+++ b/hw/char/sh_serial.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/sh4/sh.h"
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index f601a083d14..5d5a4357399 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -24,7 +24,7 @@
 #include "exec/cputlb.h"
 #include "system/memory.h"
 #include "qemu/target-info.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
 #include "migration/vmstate.h"
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index 7176791851b..270afe5b9f6 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "migration/vmstate.h"
diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 11f26a2f2dd..37cda5ce4d3 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
 
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index b96525951cd..6e2967e433e 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "hw/core/qdev-clock.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/error.h"
 
 /*
diff --git a/hw/core/qdev-fw.c b/hw/core/qdev-fw.c
index a587d2ddf90..f1489c02dfc 100644
--- a/hw/core/qdev-fw.c
+++ b/hw/core/qdev-fw.c
@@ -17,7 +17,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/fw-path-provider.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 const char *qdev_fw_name(DeviceState *dev)
 {
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index d2c39806c53..1d547e0dbdf 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -10,7 +10,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 
diff --git a/hw/core/qdev-user.c b/hw/core/qdev-user.c
index 3d421d8f4e5..051f8fbd02d 100644
--- a/hw/core/qdev-user.c
+++ b/hw/core/qdev-user.c
@@ -7,7 +7,7 @@
  */
 #include "qemu/osdep.h"
 #include "qom/object.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 void qdev_create_fake_machine(void)
 {
diff --git a/hw/core/vm-change-state-handler.c b/hw/core/vm-change-state-handler.c
index 99c642b5587..2c111350298 100644
--- a/hw/core/vm-change-state-handler.c
+++ b/hw/core/vm-change-state-handler.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/runstate.h"
 
 static int qdev_get_dev_tree_depth(DeviceState *dev)
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 5efa9e45ffd..e6fed03786e 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/core/loader.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
diff --git a/hw/fsi/aspeed_apb2opb.c b/hw/fsi/aspeed_apb2opb.c
index 172ba16b0c0..b9d72f3ecf6 100644
--- a/hw/fsi/aspeed_apb2opb.c
+++ b/hw/fsi/aspeed_apb2opb.c
@@ -13,7 +13,7 @@
 #include "trace.h"
 
 #include "hw/fsi/aspeed_apb2opb.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 #define TO_REG(x) (x >> 2)
 
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index ac024accfcd..deb20d7b6a3 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -19,7 +19,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "monitor/qdev.h"
 #include "qapi/error.h"
diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index a8ef640cd25..fd317f56701 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -19,7 +19,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_slave.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 2208ffe632c..fb394cc6e09 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -22,7 +22,7 @@
 #include "exec/hwaddr.h"
 #include "system/memory.h"
 #include "system/cpus.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_chip.h"
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index e4b47838bad..ced782f6a9c 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -21,7 +21,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/remote/iohub.h"
 #include "hw/remote/iommu.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/remote/vfio-user-obj.h"
 #include "hw/pci/msi.h"
 
diff --git a/hw/remote/remote-obj.c b/hw/remote/remote-obj.c
index 3402068ab9e..86192dc8dad 100644
--- a/hw/remote/remote-obj.c
+++ b/hw/remote/remote-obj.c
@@ -13,7 +13,7 @@
 #include "qemu/notify.h"
 #include "qom/object_interfaces.h"
 #include "io/channel.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/remote/machine.h"
 #include "io/channel-util.h"
 #include "qapi/error.h"
diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 13cda2f4813..4eb036a5469 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -54,7 +54,7 @@
 #include "qemu/main-loop.h"
 #include "system/system.h"
 #include "libvfio-user.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/pci/pci.h"
 #include "qemu/timer.h"
 #include "system/memory.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 0d7bbb52aba..2c79522b09a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/core/fw-path-provider.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/sd/core.c b/hw/sd/core.c
index d3c9017445e..3568a81e809 100644
--- a/hw/sd/core.c
+++ b/hw/sd/core.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/sd/sd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index 984d3d10808..f0c34291dc9 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "system/memory_mapping.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/acpi/tpm.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bb5775aa711..32e8615ad3b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -20,7 +20,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "system/iommufd.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
index 4a7b9709761..57739385a96 100644
--- a/hw/virtio/vdpa-dev.c
+++ b/hw/virtio/vdpa-dev.c
@@ -19,7 +19,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/virtio/vhost.h"
diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index fe95b62d133..e36370e2ee9 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "hw/xen/xen-bus-helper.h"
 #include "hw/xen/xen_pvdev.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 34e2b8f748b..f068cc76106 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include <dirent.h>
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
diff --git a/qom/object.c b/qom/object.c
index 4f32c1aba7d..ff8ede8a328 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index a00a564b1e2..32e40630c96 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -6,7 +6,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/error.h"
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 57f1898cf61..48b38d2b7f7 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -15,7 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "block/qdict.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-qom.h"
diff --git a/stubs/hotplug-stubs.c b/stubs/hotplug-stubs.c
index 7aadaa29bd5..23a1678dbbc 100644
--- a/stubs/hotplug-stubs.c
+++ b/stubs/hotplug-stubs.c
@@ -12,7 +12,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 HotplugHandler *qdev_get_hotplug_handler(DeviceState *dev)
 {
diff --git a/stubs/sysbus.c b/stubs/sysbus.c
index d8da90caae5..68b771226fa 100644
--- a/stubs/sysbus.c
+++ b/stubs/sysbus.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 
 BusState *sysbus_get_default(void)
 {
diff --git a/system/bootdevice.c b/system/bootdevice.c
index 8acdbfb0a57..9538b08983f 100644
--- a/system/bootdevice.c
+++ b/system/bootdevice.c
@@ -28,7 +28,7 @@
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/boards.h"
 
 typedef struct FWBootEntry FWBootEntry;
diff --git a/system/physmem.c b/system/physmem.c
index edc384f4fa1..ba69be2d082 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -36,7 +36,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "system/xen.h"
diff --git a/system/qtest.c b/system/qtest.c
index 6cf686a31ec..7c8507fe7cb 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -19,7 +19,7 @@
 #include "system/ioport.h"
 #include "system/memory.h"
 #include "exec/tswap.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "hw/core/cpu.h"
 #include "qemu/accel.h"
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index c848eec3b93..e8bb7bb0d56 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -22,7 +22,7 @@
 #include "string.h"
 #include "system/memory.h"
 #include "system/ramblock.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
 #include "hw/core/boards.h"
diff --git a/ui/console.c b/ui/console.c
index 2d00828c538..f445db11389 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "ui/console.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
diff --git a/ui/vdagent.c b/ui/vdagent.c
index ddb91e75c64..e2a570a1d8a 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -5,7 +5,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
diff --git a/ui/vnc.c b/ui/vnc.c
index 0d499b208b9..6d91d1370c6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -28,7 +28,7 @@
 #include "vnc.h"
 #include "vnc-jobs.h"
 #include "trace.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
 #include "system/system.h"
 #include "system/runstate.h"
 #include "qemu/error-report.h"
-- 
2.51.1


