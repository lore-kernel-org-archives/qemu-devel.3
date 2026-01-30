Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E3E6BF10
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 21:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlvsP-0007wV-ML; Fri, 30 Jan 2026 16:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsO-0007w2-Df
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:18:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlvsM-0005VT-0a
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 16:18:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so20499045e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769807876; x=1770412676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNs2LarDFy0hsmo9TwTrY29oFsZoe+0raBiAeoatqOU=;
 b=PSDF+43J1fvd7XF6aPWFPpY3KUJGCK9UoUpEP6J4A5tuUiRqhKdn0YeGryPMhyWnW9
 KXMCqcFEQNTE/SJLguzYlYRaqqFrF5NWx9TO4ZqB8+vXocsbwlMN8IlirV88bHA7oTQv
 z2r5WynHhLMAIDZ4nBijD/QmqR11hvYdKAzDzf5I+yGmhiXRW2nYsUVRCkWna6wfPFnS
 U2kWADu7wB3Y2NreBmPWrjDXU8qufRN1MoPE5LfdLxhm/MQ3MRXmf1IFDvT40K262GF+
 Ae9wg717Prt6T+XNls5QCEABvndWtXZ+KhRtl1NULuVMs8SP6siwHUJaKMtjnmXrjcc1
 DlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769807876; x=1770412676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eNs2LarDFy0hsmo9TwTrY29oFsZoe+0raBiAeoatqOU=;
 b=wZSzfyO4gUOjOMU//tHi0VH4IbTXlWkfqLjVqCyp04b6NepgUcfkojntOHab+wq7wq
 1DlppdT1DnFMjAP1w+JL6OkNN7+iyeQUwN29ZzoIl82ZKLlTkebA8FX+hz+Yk3Ghl/Ll
 8h1LVipFsBvj/DCDIxpddFVJsCY2BqqK/7y6C7itd2CzZhms4C4IT65NGmS6MudwZB+m
 LMPBo9gANigt+TQOzqPyPeT0OgthahOzA7FHjywAm2UtV1oa3o5dh6u6yL7/hIM8gTLr
 CZDM9fn8jcJ/ogzVAS7sjsxqBaYkPxETSYACivAcnlUdGnw9VPF98lUpjE5oW/+UOGZX
 i6Rw==
X-Gm-Message-State: AOJu0YyXu7SKRjR1hzH4jkfFRyj2ZJ8gXONAwnTzQhnlQsol8tYoafaR
 LVSqnnTtVSw6yOyRWoHRFDi4e8tigBs7YJTZGKM2kC45LeRwjIQiOcy5CY7iP1FZVCKqwiRZnMz
 DYXw7QEQ=
X-Gm-Gg: AZuq6aIL+Z0uk5bL3WXT0jZ2O9rOJKdPTqP4qJkGhc62zFrK+/yzUNwuhfgRmSaA3ay
 IMRzloXo41zpnNCCBhOYAsFClrkgg6pSNw9/Zu3QJ1N9Hqc5ji7Rom2d+mGkBSkqc1a+9zAX9cD
 2QuM2fYuQzYl7ZZKuB1D5oQUVPjTwDgPDRx7gb8QbxPt1EtwLoRRJxfAF1Y/Vf+QaMhNCdMmttf
 txqhUno7VgVyCWgDB3SE8n4LMG6rSGdRIFhvi2UO6bsGRec/tJW5/jrMi9rydQMMdmtgLACnFbO
 U3euU69XEVyaDRdmTVX3XPeKN/mlHxz9/FwdP+eK03Ug8XOdjB8Q8wWuDYycSRWvHNVDs41G8Nm
 8QzqrZkwoLHOxPGuqiCs5KkVKEwJulD+uNBuLDooZsGwEwpQT9RUhl65bsy3k8Nfptx2fM4DpyQ
 3N9vm1zirLH6Q31YKTTULqaQNCQL4qzFfyabJMczAfbapDzMPM25ifXu12LD76
X-Received: by 2002:a05:600c:34cb:b0:47e:e91d:73c0 with SMTP id
 5b1f17b1804b1-482db4921bbmr54268245e9.19.1769807875883; 
 Fri, 30 Jan 2026 13:17:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4824sm25921038f8f.1.2026.01.30.13.17.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Jan 2026 13:17:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: jpcottin@google.com, Markus Armbruster <armbru@redhat.com>,
 Roman Kiryanov <rkir@google.com>, Will Hollins <whollins@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 1/2] bulk: Stop forward-declaring enum typedefs
Date: Fri, 30 Jan 2026 22:17:45 +0100
Message-ID: <20260130211746.46667-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130211746.46667-1-philmd@linaro.org>
References: <20260130211746.46667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The C99 standard chapter §6.7.2.2 point 4 mentions:

  Each enumerated type shall be compatible with char, a signed
  integer type, or an unsigned integer type. The choice of type
  is implementation-defined, but shall be capable of representing
  the values of all the members of the enumeration.

Align with that recommendation by defining the typedef
along with the enum.

For information, building with -Werror=pedantic was reporting:

  In file included from ../../ui/kbd-state.c:10:
  include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
     12 | typedef enum QKbdModifier QKbdModifier;
        |              ^
  ...

Reported-by: Roman Kiryanov <rkir@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/riscv/riscv-iommu-bits.h          |  4 ++--
 hw/riscv/riscv-iommu.h               |  2 --
 include/hw/misc/auxbus.h             | 11 ++++-------
 include/hw/pci/pci_device.h          |  5 ++---
 include/hw/ssi/ssi.h                 |  6 ++----
 include/hw/xen/interface/io/xenbus.h |  5 ++---
 include/io/channel.h                 | 11 ++++-------
 include/system/replay.h              | 10 ++++------
 include/ui/clipboard.h               | 15 ++++++---------
 include/ui/kbd-state.h               |  6 ++----
 pc-bios/s390-ccw/virtio.h            |  5 ++---
 tests/qtest/libqos/qgraph_internal.h | 10 ++++------
 hw/core/loader.c                     |  5 ++---
 hw/display/xlnx_dp.c                 | 11 ++++-------
 hw/dma/xlnx_dpdma.c                  | 10 ++++------
 qapi/opts-visitor.c                  |  7 ++-----
 qapi/string-output-visitor.c         |  6 ++----
 tests/unit/check-qom-proplist.c      |  6 ++----
 18 files changed, 50 insertions(+), 85 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 47fe01bee58..281afa7bc3f 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -96,11 +96,11 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
 #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
 
-enum riscv_iommu_igs_modes {
+typedef enum riscv_iommu_igs_modes {
     RISCV_IOMMU_CAP_IGS_MSI = 0,
     RISCV_IOMMU_CAP_IGS_WSI,
     RISCV_IOMMU_CAP_IGS_BOTH
-};
+} riscv_iommu_igs_mode;
 
 /* 5.4 Features control register (32bits) */
 #define RISCV_IOMMU_REG_FCTL            0x0008
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2dabd86941b..fbf70fb81e1 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -25,8 +25,6 @@
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
 
-typedef enum riscv_iommu_igs_modes riscv_iommu_igs_mode;
-
 struct RISCVIOMMUState {
     /*< private >*/
     DeviceState parent_obj;
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 5bfdd05e152..11f1a87d44f 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -29,16 +29,13 @@
 #include "hw/core/qdev.h"
 #include "qom/object.h"
 
-typedef enum AUXCommand AUXCommand;
-typedef enum AUXReply AUXReply;
-
 #define TYPE_AUXTOI2C "aux-to-i2c-bridge"
 OBJECT_DECLARE_SIMPLE_TYPE(AUXTOI2CState, AUXTOI2C)
 
 #define TYPE_AUX_SLAVE "aux-slave"
 OBJECT_DECLARE_SIMPLE_TYPE(AUXSlave, AUX_SLAVE)
 
-enum AUXCommand {
+typedef enum AUXCommand {
     WRITE_I2C = 0,
     READ_I2C = 1,
     WRITE_I2C_STATUS = 2,
@@ -46,15 +43,15 @@ enum AUXCommand {
     READ_I2C_MOT = 5,
     WRITE_AUX = 8,
     READ_AUX = 9
-};
+} AUXCommand;
 
-enum AUXReply {
+typedef enum AUXReply {
     AUX_I2C_ACK = 0,
     AUX_NACK = 1,
     AUX_DEFER = 2,
     AUX_I2C_NACK = 4,
     AUX_I2C_DEFER = 8
-};
+} AUXReply;
 
 #define TYPE_AUX_BUS "aux-bus"
 OBJECT_DECLARE_SIMPLE_TYPE(AUXBus, AUX_BUS)
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea50113..85e57fa5ca1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -43,13 +43,12 @@ struct PCIDeviceClass {
     bool sriov_vf_user_creatable;
 };
 
-enum PCIReqIDType {
+typedef enum PCIReqIDType {
     PCI_REQ_ID_INVALID = 0,
     PCI_REQ_ID_BDF,
     PCI_REQ_ID_SECONDARY_BUS,
     PCI_REQ_ID_MAX,
-};
-typedef enum PCIReqIDType PCIReqIDType;
+} PCIReqIDType;
 
 struct PCIReqIDCache {
     PCIDevice *dev;
diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 6d6d8ccb3d4..d576e8cb061 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -16,19 +16,17 @@
 #include "hw/core/qdev.h"
 #include "qom/object.h"
 
-typedef enum SSICSMode SSICSMode;
-
 #define TYPE_SSI_PERIPHERAL "ssi-peripheral"
 OBJECT_DECLARE_TYPE(SSIPeripheral, SSIPeripheralClass,
                     SSI_PERIPHERAL)
 
 #define SSI_GPIO_CS "ssi-gpio-cs"
 
-enum SSICSMode {
+typedef enum SSICSMode {
     SSI_CS_NONE = 0,
     SSI_CS_LOW,
     SSI_CS_HIGH,
-};
+} SSICSMode;
 
 /* Peripherals.  */
 struct SSIPeripheralClass {
diff --git a/include/hw/xen/interface/io/xenbus.h b/include/hw/xen/interface/io/xenbus.h
index 9cd0cd7c670..3fe2f53c22c 100644
--- a/include/hw/xen/interface/io/xenbus.h
+++ b/include/hw/xen/interface/io/xenbus.h
@@ -16,7 +16,7 @@
  * the state of the connection between the driver and the kernel's device
  * layers.
  */
-enum xenbus_state {
+typedef enum xenbus_state {
     XenbusStateUnknown       = 0,
 
     XenbusStateInitialising  = 1,
@@ -47,8 +47,7 @@ enum xenbus_state {
     XenbusStateReconfiguring = 7,
 
     XenbusStateReconfigured  = 8
-};
-typedef enum xenbus_state XenbusState;
+} XenbusState;
 
 #endif /* _XEN_PUBLIC_IO_XENBUS_H */
 
diff --git a/include/io/channel.h b/include/io/channel.h
index 1b02350437d..fb6ec407a91 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -38,9 +38,8 @@ OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
 #define QIO_CHANNEL_READ_FLAG_RELAXED_EOF 0x2
 #define QIO_CHANNEL_READ_FLAG_FD_PRESERVE_BLOCKING 0x4
 
-typedef enum QIOChannelFeature QIOChannelFeature;
 
-enum QIOChannelFeature {
+typedef enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_FD_PASS,
     QIO_CHANNEL_FEATURE_SHUTDOWN,
     QIO_CHANNEL_FEATURE_LISTEN,
@@ -48,16 +47,14 @@ enum QIOChannelFeature {
     QIO_CHANNEL_FEATURE_READ_MSG_PEEK,
     QIO_CHANNEL_FEATURE_SEEKABLE,
     QIO_CHANNEL_FEATURE_CONCURRENT_IO,
-};
+} QIOChannelFeature;
 
 
-typedef enum QIOChannelShutdown QIOChannelShutdown;
-
-enum QIOChannelShutdown {
+typedef enum QIOChannelShutdown {
     QIO_CHANNEL_SHUTDOWN_READ = 1,
     QIO_CHANNEL_SHUTDOWN_WRITE = 2,
     QIO_CHANNEL_SHUTDOWN_BOTH = 3,
-};
+} QIOChannelShutdown;
 
 typedef gboolean (*QIOChannelFunc)(QIOChannel *ioc,
                                    GIOCondition condition,
diff --git a/include/system/replay.h b/include/system/replay.h
index f8715ca9feb..ed34256d8bb 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -19,17 +19,16 @@
 #include "qemu/audio.h"
 
 /* replay clock kinds */
-enum ReplayClockKind {
+typedef enum ReplayClockKind {
     /* host_clock */
     REPLAY_CLOCK_HOST,
     /* virtual_rt_clock */
     REPLAY_CLOCK_VIRTUAL_RT,
     REPLAY_CLOCK_COUNT
-};
-typedef enum ReplayClockKind ReplayClockKind;
+} ReplayClockKind;
 
 /* IDs of the checkpoints */
-enum ReplayCheckpoint {
+typedef enum ReplayCheckpoint {
     CHECKPOINT_CLOCK_WARP_START,
     CHECKPOINT_CLOCK_WARP_ACCOUNT,
     CHECKPOINT_RESET_REQUESTED,
@@ -40,8 +39,7 @@ enum ReplayCheckpoint {
     CHECKPOINT_INIT,
     CHECKPOINT_RESET,
     CHECKPOINT_COUNT
-};
-typedef enum ReplayCheckpoint ReplayCheckpoint;
+} ReplayCheckpoint;
 
 typedef struct ReplayNetState ReplayNetState;
 
diff --git a/include/ui/clipboard.h b/include/ui/clipboard.h
index 62a96ce9ff5..2704434ded9 100644
--- a/include/ui/clipboard.h
+++ b/include/ui/clipboard.h
@@ -20,9 +20,6 @@
  * is supported for now.
  */
 
-typedef enum QemuClipboardType QemuClipboardType;
-typedef enum QemuClipboardNotifyType QemuClipboardNotifyType;
-typedef enum QemuClipboardSelection QemuClipboardSelection;
 typedef struct QemuClipboardPeer QemuClipboardPeer;
 typedef struct QemuClipboardNotify QemuClipboardNotify;
 typedef struct QemuClipboardInfo QemuClipboardInfo;
@@ -36,10 +33,10 @@ extern const VMStateDescription vmstate_cbinfo;
  * @QEMU_CLIPBOARD_TYPE_TEXT: text/plain; charset=utf-8
  * @QEMU_CLIPBOARD_TYPE__COUNT: type count.
  */
-enum QemuClipboardType {
+typedef enum QemuClipboardType {
     QEMU_CLIPBOARD_TYPE_TEXT,
     QEMU_CLIPBOARD_TYPE__COUNT,
-};
+} QemuClipboardType;
 
 /* same as VD_AGENT_CLIPBOARD_SELECTION_* */
 /**
@@ -50,12 +47,12 @@ enum QemuClipboardType {
  * @QEMU_CLIPBOARD_SELECTION_SECONDARY: secondary selection (dunno).
  * @QEMU_CLIPBOARD_SELECTION__COUNT: selection count.
  */
-enum QemuClipboardSelection {
+typedef enum QemuClipboardSelection {
     QEMU_CLIPBOARD_SELECTION_CLIPBOARD,
     QEMU_CLIPBOARD_SELECTION_PRIMARY,
     QEMU_CLIPBOARD_SELECTION_SECONDARY,
     QEMU_CLIPBOARD_SELECTION__COUNT,
-};
+} QemuClipboardSelection;
 
 /**
  * struct QemuClipboardPeer
@@ -81,10 +78,10 @@ struct QemuClipboardPeer {
  *
  * Clipboard notify type.
  */
-enum QemuClipboardNotifyType {
+typedef enum QemuClipboardNotifyType {
     QEMU_CLIPBOARD_UPDATE_INFO,
     QEMU_CLIPBOARD_RESET_SERIAL,
-};
+} QemuClipboardNotifyType;
 
 /**
  * struct QemuClipboardNotify
diff --git a/include/ui/kbd-state.h b/include/ui/kbd-state.h
index 1f37b932eb6..3522ebe51b9 100644
--- a/include/ui/kbd-state.h
+++ b/include/ui/kbd-state.h
@@ -9,9 +9,7 @@
 
 #include "qapi/qapi-types-ui.h"
 
-typedef enum QKbdModifier QKbdModifier;
-
-enum QKbdModifier {
+typedef enum QKbdModifier {
     QKBD_MOD_NONE = 0,
 
     QKBD_MOD_SHIFT,
@@ -23,7 +21,7 @@ enum QKbdModifier {
     QKBD_MOD_CAPSLOCK,
 
     QKBD_MOD__MAX
-};
+} QKbdModifier;
 
 typedef struct QKbdState QKbdState;
 
diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
index 5c5e808a500..67fd0da9fd2 100644
--- a/pc-bios/s390-ccw/virtio.h
+++ b/pc-bios/s390-ccw/virtio.h
@@ -173,13 +173,12 @@ struct VirtioBlkConfig {
 } __attribute__((packed));
 typedef struct VirtioBlkConfig VirtioBlkConfig;
 
-enum guessed_disk_nature_type {
+typedef enum guessed_disk_nature_type {
     VIRTIO_GDN_NONE     = 0,
     VIRTIO_GDN_DASD     = 1,
     VIRTIO_GDN_CDROM    = 2,
     VIRTIO_GDN_SCSI     = 3,
-};
-typedef enum guessed_disk_nature_type VirtioGDN;
+} VirtioGDN;
 
 VirtioGDN virtio_guessed_disk_nature(void);
 void virtio_assume_eckd(void);
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index 87fab1f9f0d..e2e740a59db 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -27,8 +27,6 @@
 #include "qgraph.h"
 
 typedef struct QOSGraphMachine QOSGraphMachine;
-typedef enum QOSEdgeType QOSEdgeType;
-typedef enum QOSNodeType QOSNodeType;
 
 /* callback called when the walk path algorithm found a
  * valid path
@@ -36,19 +34,19 @@ typedef enum QOSNodeType QOSNodeType;
 typedef void (*QOSTestCallback) (QOSGraphNode *path, int len);
 
 /* edge types*/
-enum QOSEdgeType {
+typedef enum QOSEdgeType {
     QEDGE_CONTAINS,
     QEDGE_PRODUCES,
     QEDGE_CONSUMED_BY
-};
+} QOSEdgeType;
 
 /* node types*/
-enum QOSNodeType {
+typedef enum QOSNodeType {
     QNODE_MACHINE,
     QNODE_DRIVER,
     QNODE_INTERFACE,
     QNODE_TEST
-};
+} QOSNodeType;
 
 /* Graph Node */
 struct QOSGraphNode {
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5cbfba0a86d..5b6f022428c 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1688,15 +1688,14 @@ HumanReadableText *qmp_x_query_roms(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-typedef enum HexRecord HexRecord;
-enum HexRecord {
+typedef enum HexRecord {
     DATA_RECORD = 0,
     EOF_RECORD,
     EXT_SEG_ADDR_RECORD,
     START_SEG_ADDR_RECORD,
     EXT_LINEAR_ADDR_RECORD,
     START_LINEAR_ADDR_RECORD,
-};
+} HexRecord;
 
 /* Each record contains a 16-bit address which is combined with the upper 16
  * bits of the implicit "next address" to form a 32-bit address.
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index a24e95f0a73..1ab2375625c 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -212,7 +212,7 @@
 #define DP_GRAPHIC_DMA_CHANNEL              (3)
 #define DP_VIDEO_DMA_CHANNEL                (0)
 
-enum DPGraphicFmt {
+typedef enum DPGraphicFmt {
     DP_GRAPHIC_RGBA8888 = 0 << 8,
     DP_GRAPHIC_ABGR8888 = 1 << 8,
     DP_GRAPHIC_RGB888 = 2 << 8,
@@ -225,9 +225,9 @@ enum DPGraphicFmt {
     DP_GRAPHIC_2BPP = 9 << 8,
     DP_GRAPHIC_1BPP = 10 << 8,
     DP_GRAPHIC_MASK = 0xF << 8
-};
+} DPGraphicFmt;
 
-enum DPVideoFmt {
+typedef enum DPVideoFmt {
     DP_NL_VID_CB_Y0_CR_Y1 = 0,
     DP_NL_VID_CR_Y0_CB_Y1 = 1,
     DP_NL_VID_Y0_CR_Y1_CB = 2,
@@ -254,10 +254,7 @@ enum DPVideoFmt {
     DP_NL_VID_YV16CL_420_10BPC = 23,
     DP_NL_VID_YV16CL2_420_10BPC = 24,
     DP_NL_VID_FMT_MASK = 0x1F
-};
-
-typedef enum DPGraphicFmt DPGraphicFmt;
-typedef enum DPVideoFmt DPVideoFmt;
+} DPVideoFmt;
 
 static const VMStateDescription vmstate_dp = {
     .name = TYPE_XLNX_DP,
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 32f56036a4c..ef5488b3eca 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -122,15 +122,15 @@
 
 #define DPDMA_FRAG_MAX_SZ                     (4096)
 
-enum DPDMABurstType {
+typedef enum DPDMABurstType {
     DPDMA_INCR = 0,
     DPDMA_FIXED = 1
-};
+} DPDMABurstType;
 
-enum DPDMAMode {
+typedef enum DPDMAMode {
     DPDMA_CONTIGOUS = 0,
     DPDMA_FRAGMENTED = 1
-};
+} DPDMAMode;
 
 struct DPDMADescriptor {
     uint32_t control;
@@ -153,8 +153,6 @@ struct DPDMADescriptor {
     uint32_t crc;
 };
 
-typedef enum DPDMABurstType DPDMABurstType;
-typedef enum DPDMAMode DPDMAMode;
 typedef struct DPDMADescriptor DPDMADescriptor;
 
 static bool xlnx_dpdma_desc_is_last(DPDMADescriptor *desc)
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 3d1a28b4191..66b1b931a31 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -20,8 +20,7 @@
 #include "qapi/visitor-impl.h"
 
 
-enum ListMode
-{
+typedef enum ListMode {
     LM_NONE,             /* not traversing a list of repeated options */
 
     LM_IN_PROGRESS,      /*
@@ -58,9 +57,7 @@ enum ListMode
                            * No more QemuOpt instance in the list.
                            * The traversal has been completed.
                            */
-};
-
-typedef enum ListMode ListMode;
+} ListMode;
 
 struct OptsVisitor
 {
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 5115536b153..5d175773356 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -17,7 +17,7 @@
 #include <math.h>
 #include "qemu/range.h"
 
-enum ListMode {
+typedef enum ListMode {
     LM_NONE,             /* not traversing a list of repeated options */
     LM_STARTED,          /* next_list() ready to be called */
 
@@ -48,9 +48,7 @@ enum ListMode {
     LM_UNSIGNED_INTERVAL,/* Same as above, only for an unsigned interval. */
 
     LM_END,              /* next_list() called, about to see last element. */
-};
-
-typedef enum ListMode ListMode;
+} ListMode;
 
 struct StringOutputVisitor
 {
diff --git a/tests/unit/check-qom-proplist.c b/tests/unit/check-qom-proplist.c
index ee3c6fb32b1..6f3dbc4407a 100644
--- a/tests/unit/check-qom-proplist.c
+++ b/tests/unit/check-qom-proplist.c
@@ -40,15 +40,13 @@ typedef struct DummyObjectClass DummyObjectClass;
 DECLARE_INSTANCE_CHECKER(DummyObject, DUMMY_OBJECT,
                          TYPE_DUMMY)
 
-typedef enum DummyAnimal DummyAnimal;
-
-enum DummyAnimal {
+typedef enum DummyAnimal {
     DUMMY_FROG,
     DUMMY_ALLIGATOR,
     DUMMY_PLATYPUS,
 
     DUMMY_LAST,
-};
+} DummyAnimal;
 
 const QEnumLookup dummy_animal_map = {
     .array = (const char *const[]) {
-- 
2.52.0


