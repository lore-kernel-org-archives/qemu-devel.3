Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D587FEE4EE
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 18:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwOy9-0005El-L5; Sat, 28 Feb 2026 13:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOy7-0005EO-It
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:12 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1vwOy5-0002pw-A9
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 13:23:11 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-824b5f015bcso3667565b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 10:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772302988; x=1772907788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIy/qwW8DhmsA/gz1aMOdjK4wzunev82qsw+l2OLW9E=;
 b=bCJ3PI5Da/bTGribRvVgfFfP5ZL/PnAKIZvsULLsSSJod64JMQmXirW1+cFNtAdocP
 Vg0H1S8OG67LtF+BGlj4hBNJ6fQPKu3qpyocxaxTixDpyXeN+cPKFvxOxoovWOrQCXor
 vrFlQ9UpBPRq29Nd2ZsUpf8/awvz8EdoI2PLzJxFYrF+m5MxO2SntWBRIPQVK4FjFLk0
 83//EksoWMtO8UfiGEhLJuvGCB0Mc3IN2Y487LfUaLrlMUZkddMsH6dTY/dzspOYfGaY
 Wr3/E1eKJwMPRYH9vHeon1yhKvrefog9XcRnu9MrpsfjdpAGFt9nVlC3+6YEtYB4vAZI
 KGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772302988; x=1772907788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIy/qwW8DhmsA/gz1aMOdjK4wzunev82qsw+l2OLW9E=;
 b=PSpv//B5bgFcJmVq14RZyU28rYi96yTdfsvrndBO91+HHG/XZ5HXeXt0IFi4a1Jzwb
 1BYb73AzgkrNF5J7e1y3+kYM2UZACn7FUaNkap/1k6hiiwo/ZrzlU/DO0dzsGBE17zrP
 W/0lZyj40fQ+9vnih4NTWUN9BfvqpJaqPEuC+46l0Cpi3Bc+M+rIGjvyDKmB8SRQ96+g
 0sC05NSjLsnhL412WyCiFZPeSsU4FKHAdOF2Cj1XtcvK07ViAQo39EpN6OTenmUqcboc
 lfgTp1tkw9ebIsWsqZ63uMNyZgIdNGwqg+gg2mWuclvQw8W6vSEAAxdvo3BdLm4CFa2W
 fcTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWemc9Hi+nEnbTOcLNvAI4cLkaE4UCtM24/Duj7Dvuq32C33IpnKh2fzP/ugov+0PMEgsUgiD6nJi1i@nongnu.org
X-Gm-Message-State: AOJu0YyayfFv39HWDcvrLopsP99russE5WeE1nGef30vCkpa3hyf4+ug
 zgxFL74NnPWp4kl7TpcNBOjIuLtA1dfVcDaPeHPH9BS4klW+hM6PVGnl
X-Gm-Gg: ATEYQzxmrw3GgiEJxhuUuClUcloXo7GfU6BsfdNBbaU2gRwuqw2eNesbo6jplKRlcff
 w2TPRs1S19faqtaDsGpFOH239q0LyFmq22GgQ1LNq528dUpEHWzwWCPrLJrp9ZfPYQY66ZIcslV
 KAXC5NttAjmzodocx4VAPAgPXsjCAnZVeVuyS7t7e8JdI9N6g5E1AmkOjtYmrOVU94XbkeVlIUd
 VG5zyNuN8GjObDzY22cg5CZvHj0wsJqKmKx+b7X4QILlum3OFAkN1OklKyobsiCddezA5ARZTyn
 LNxWme9tbYXTAa46eFFk2MWr2SaviegaY4ml2qlz81YGEdO0YYlCfM9jYhBqv6A76plwTSralfT
 zny1Yb6+Ur4i76+Rfm5XP/TTqZvMJrpQhOMP5UE4olgks/HSpAahCjF4qi24lyqFWL9A+zoYq8D
 VUWKCMO/ZvOq0vzJ50c21E1vqBy5TNo6cUNsTRfmG0vGfm9ywZ9Aw2lSk8DAq36MpalgC7a2Uo3
 L6C9amd38rdsVHt7ap1ej/dkBEhN7AjjefE
X-Received: by 2002:a05:6a00:2d09:b0:821:8492:7f73 with SMTP id
 d2e1a72fcca58-8274da7a78fmr7182863b3a.63.1772302987769; 
 Sat, 28 Feb 2026 10:23:07 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8273a05e831sm8731008b3a.58.2026.02.28.10.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:07 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com
Cc: eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] virtio-rtc: Add basic virtio-rtc support
Date: Sat, 28 Feb 2026 18:22:46 +0000
Message-ID: <20260228182246.700714-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260228182246.700714-1-visitorckw@gmail.com>
References: <20260228182246.700714-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Introduce the core device and PCI bindings for the virtio-rtc device
(VIRTIO_ID_CLOCK).

This implementation provides a read-only clock that returns the host's
time (QEMU_CLOCK_HOST) to the guest. It handles fundamental control
requests, reporting a single supported clock of type
VIRTIO_RTC_CLOCK_UTC, and responds to standard read requests.

- Virtio RTC Spec:
https://github.com/oasis-tcs/virtio-spec/tree/master/device-types/rtc
- Linux Virtio RTC driver:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/virtio/virtio_rtc_driver.c?h=v7.0-rc1

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                    |   7 ++
 hw/virtio/Kconfig              |   5 +
 hw/virtio/meson.build          |   2 +
 hw/virtio/virtio-rtc-pci.c     |  65 +++++++++++
 hw/virtio/virtio-rtc.c         | 190 +++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio-rtc.h |  22 ++++
 6 files changed, 291 insertions(+)
 create mode 100644 hw/virtio/virtio-rtc-pci.c
 create mode 100644 hw/virtio/virtio-rtc.c
 create mode 100644 include/hw/virtio/virtio-rtc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762c..69dfd07a36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2522,6 +2522,13 @@ F: include/system/rng*.h
 F: backends/rng*.c
 F: tests/qtest/virtio-rng-test.c
 
+virtio-rtc
+M: Kuan-Wei Chiu <visitorckw@gmail.com>
+S: Maintained
+F: hw/virtio/virtio-rtc.c
+F: hw/virtio/virtio-rtc-pci.c
+F: include/hw/virtio/virtio-rtc.h
+
 virtio-nsm
 M: Alexander Graf <graf@amazon.com>
 M: Dorjoy Chowdhury <dorjoychy111@gmail.com>
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 8895682c61..fb8b53f287 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -76,6 +76,11 @@ config VIRTIO_MEM
     depends on VIRTIO_MEM_SUPPORTED
     select VIRTIO_MD
 
+config VIRTIO_RTC
+    bool
+    default y
+    depends on VIRTIO
+
 config VHOST_VSOCK_COMMON
     bool
     depends on VIRTIO
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 6675b63ce6..68c89495a1 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -55,6 +55,7 @@ else
 endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc.c'))
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
@@ -78,6 +79,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pc
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-input-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VIRTIO_RTC', if_true: files('virtio-rtc-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm-pci.c', 'cbor-helpers.c'), libcbor])
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-pci.c'))
diff --git a/hw/virtio/virtio-rtc-pci.c b/hw/virtio/virtio-rtc-pci.c
new file mode 100644
index 0000000000..fe25f21fbc
--- /dev/null
+++ b/hw/virtio/virtio-rtc-pci.c
@@ -0,0 +1,65 @@
+/*
+ * Virtio RTC PCI Bindings
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/virtio/virtio-pci.h"
+#include "hw/virtio/virtio-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+
+typedef struct VirtIORtcPCI {
+    VirtIOPCIProxy parent_obj;
+    VirtIORtc vdev;
+} VirtIORtcPCI;
+
+#define TYPE_VIRTIO_RTC_PCI "virtio-rtc-pci-base"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIORtcPCI, VIRTIO_RTC_PCI)
+
+static void virtio_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+    VirtIORtcPCI *dev = VIRTIO_RTC_PCI(vpci_dev);
+    DeviceState *vdev = DEVICE(&dev->vdev);
+
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void virtio_rtc_pci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    k->realize = virtio_rtc_pci_realize;
+
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_10_BASE + VIRTIO_ID_CLOCK;
+    pcidev_k->revision = 0x00;
+    pcidev_k->class_id = PCI_CLASS_SYSTEM_RTC;
+}
+
+static void virtio_rtc_pci_instance_init(Object *obj)
+{
+    VirtIORtcPCI *dev = VIRTIO_RTC_PCI(obj);
+
+    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+                      TYPE_VIRTIO_RTC);
+}
+
+static const VirtioPCIDeviceTypeInfo virtio_rtc_pci_info = {
+    .base_name = TYPE_VIRTIO_RTC_PCI,
+    .non_transitional_name = "virtio-rtc-pci",
+    .instance_size = sizeof(VirtIORtcPCI),
+    .instance_init = virtio_rtc_pci_instance_init,
+    .class_init = virtio_rtc_pci_class_init,
+};
+
+static void virtio_rtc_pci_register(void)
+{
+    virtio_pci_types_register(&virtio_rtc_pci_info);
+}
+
+type_init(virtio_rtc_pci_register);
diff --git a/hw/virtio/virtio-rtc.c b/hw/virtio/virtio-rtc.c
new file mode 100644
index 0000000000..32de9c1650
--- /dev/null
+++ b/hw/virtio/virtio-rtc.c
@@ -0,0 +1,190 @@
+/*
+ * Virtio RTC device core
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/iov.h"
+#include "qemu/timer.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-rtc.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_rtc.h"
+
+static void virtio_rtc_handle_request(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement *elem;
+    struct virtio_rtc_req_head req_head;
+    size_t written;
+
+    while ((elem = virtqueue_pop(vq, sizeof(VirtQueueElement)))) {
+        if (elem->out_num < 1 || elem->in_num < 1) {
+            virtio_error(vdev, "virtio-rtc: request missing in/out buffers");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req_head,
+                       sizeof(req_head)) != sizeof(req_head)) {
+            virtio_error(vdev, "virtio-rtc: request header too short");
+            virtqueue_detach_element(vq, elem, 0);
+            g_free(elem);
+            break;
+        }
+
+        written = 0;
+
+        switch (le16_to_cpu(req_head.msg_type)) {
+        case VIRTIO_RTC_REQ_CFG: {
+            struct virtio_rtc_resp_cfg resp = {0};
+            resp.head.status = VIRTIO_RTC_S_OK;
+            resp.num_clocks = cpu_to_le16(1);
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_CLOCK_CAP: {
+            struct virtio_rtc_req_clock_cap req;
+            struct virtio_rtc_resp_clock_cap resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                           sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+                resp.type = VIRTIO_RTC_CLOCK_UTC;
+            }
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_CROSS_CAP: {
+            struct virtio_rtc_req_cross_cap req;
+            struct virtio_rtc_resp_cross_cap resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                     sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+            }
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        case VIRTIO_RTC_REQ_READ: {
+            struct virtio_rtc_req_read req;
+            struct virtio_rtc_resp_read resp = {0};
+
+            if (iov_to_buf(elem->out_sg, elem->out_num, 0, &req,
+                           sizeof(req)) != sizeof(req)) {
+                resp.head.status = VIRTIO_RTC_S_EINVAL;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+                break;
+            }
+
+            if (le16_to_cpu(req.clock_id) != 0) {
+                resp.head.status = VIRTIO_RTC_S_ENODEV;
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp.head));
+            } else {
+                resp.head.status = VIRTIO_RTC_S_OK;
+                resp.clock_reading =
+                    cpu_to_le64(qemu_clock_get_ns(QEMU_CLOCK_HOST));
+                written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                       sizeof(resp));
+            }
+            break;
+        }
+        default: {
+            struct virtio_rtc_resp_head resp = {0};
+            resp.status = VIRTIO_RTC_S_EOPNOTSUPP;
+            written = iov_from_buf(elem->in_sg, elem->in_num, 0, &resp,
+                                   sizeof(resp));
+            break;
+        }
+        }
+
+        virtqueue_push(vq, elem, written);
+        virtio_notify(vdev, vq);
+        g_free(elem);
+    }
+}
+
+static void virtio_rtc_device_realize(DeviceState *dev, Error **errp)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORtc *vrtc = VIRTIO_RTC(dev);
+
+    virtio_init(vdev, VIRTIO_ID_CLOCK, 0);
+    vrtc->vq = virtio_add_queue(vdev, 64, virtio_rtc_handle_request);
+}
+
+static void virtio_rtc_device_unrealize(DeviceState *dev)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VirtIORtc *vrtc = VIRTIO_RTC(dev);
+
+    virtio_delete_queue(vrtc->vq);
+    virtio_cleanup(vdev);
+}
+
+static uint64_t virtio_rtc_get_features(VirtIODevice *vdev, uint64_t f,
+                                        Error **errp)
+{
+    return f;
+}
+
+static const VMStateDescription vmstate_virtio_rtc = {
+    .name = "virtio-rtc",
+    .minimum_version_id = 1,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void virtio_rtc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    vdc->realize = virtio_rtc_device_realize;
+    vdc->unrealize = virtio_rtc_device_unrealize;
+    vdc->get_features = virtio_rtc_get_features;
+    dc->vmsd = &vmstate_virtio_rtc;
+}
+
+static const TypeInfo virtio_rtc_info = {
+    .name = TYPE_VIRTIO_RTC,
+    .parent = TYPE_VIRTIO_DEVICE,
+    .instance_size = sizeof(VirtIORtc),
+    .class_init = virtio_rtc_class_init,
+};
+
+static void virtio_rtc_register_types(void)
+{
+    type_register_static(&virtio_rtc_info);
+}
+
+type_init(virtio_rtc_register_types)
diff --git a/include/hw/virtio/virtio-rtc.h b/include/hw/virtio/virtio-rtc.h
new file mode 100644
index 0000000000..51aa35201a
--- /dev/null
+++ b/include/hw/virtio/virtio-rtc.h
@@ -0,0 +1,22 @@
+/*
+ * Virtio RTC device
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_VIRTIO_RTC_H
+#define QEMU_VIRTIO_RTC_H
+
+#include "hw/virtio/virtio.h"
+#include "qom/object.h"
+
+#define TYPE_VIRTIO_RTC "virtio-rtc-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIORtc, VIRTIO_RTC)
+
+struct VirtIORtc {
+    VirtIODevice parent_obj;
+    VirtQueue *vq;
+};
+
+#endif
-- 
2.53.0.473.g4a7958ca14-goog


