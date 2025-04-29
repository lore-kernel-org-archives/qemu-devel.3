Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5368C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9le0-0001Yx-Fd; Tue, 29 Apr 2025 10:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldy-0001NX-0B
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:06 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9ldw-0006Kh-5A
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ee651e419so3152528f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935742; x=1746540542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJvF5VVqWRoBuruHMFkUoRv70wTkjLmBdIDnHMXKE5w=;
 b=EFil7s1UHwWd5OWtuX3OP5lQ+aJACrJJM20E5KYBj1VEWhaZWGL7icZoSYZtVzamTT
 sz5K67Jb8dLq4Ibs6M4urgley4+lUJZFRfVeYWRySrEaVRH1wFrAHAq6we/tMXci9QFn
 A5r5oQdsfSfMnlwdU2PBUxZkfDYvdevv3RmIellcgNz49K3EXHgWlsRJvYreOHbEGios
 asLa3x3Q+J6GBN6/1NGHzeWJ7wANRsquL+tWPyNpFHYvEcxG04uDLuCilgy2sTRjAZrx
 8vMkcNMaHTq732+l+cl76sGSLKNuXhbhe8Q/5CsktGNjjOC1VMbEjLVokuvEhfIFmqC1
 ZJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935742; x=1746540542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xJvF5VVqWRoBuruHMFkUoRv70wTkjLmBdIDnHMXKE5w=;
 b=bzyMXHLKnJBfI8cLOfAh0xrwzOc+Gttu96n9RymWOlYtqxGh2YOd1pfiSJgf8GzwWp
 jmHVL0l1Fo5a8oy7HIpBHVMb9ENk8NdTQyikv9gMybqbx0J9AuTFsrnH9iQzlrv4eCDQ
 6IwXBIA9VWCIWy5kJT+sAjHnUYsRvdNhNL1zi31yb9m+jHAOeSxUezNB7rV3mxx5kP2O
 07K3cOcFpoFKa9LPinerLPk3PbGB2sr8ineWzJJR2nov/sHaCHPfYSjymAL2CPyzot+U
 cp5OdkMu4A3RPcNoLG+RW8EU+FjNZBEtbsc7+0P710AeTt+k4TzGFM6lo4sB4l1LIhOh
 8I1Q==
X-Gm-Message-State: AOJu0YwmxWcL/+b1isUdNdsIEchJVOBCz6BeFAxOvMUKmevHnXGhG2Mp
 mV7aXOWxhEBuml9PXkAul/ohnZeEjHjJ/46kqpdzHE1LAIJ9JMxdjGwD+cYDSCETJiLSod3NH9r
 S
X-Gm-Gg: ASbGncssU8p41L7HIHs+u3LjTiKkGxjaUVYkSt0egXJW9FoL4ttp6Tx6QVRgNrU/L2k
 xxczzfCGzQBnTAezPabsUvVZfjqq++kgePpsqXuSuWHr6UdhaadNatkw42i5Oo+f8+9eymoglRm
 v3wDRuFB0sYUwuICeZdGycWHtIBqB4oRprQq/25nYJv1tDTYvwvairxH3IinydcHmoNf5jo9xwh
 QBKPiplwymFTLseW0FXPq89CeGuakuLqeKXqUyr8fWD20/pkwEijTBzouscxQ+LAKly5uFwH5G6
 BrkFOSmbVDmzhKsYkUDBNWHafvXNuQ4sCo3q+j9X4cvcqEJ9he9qP4qsVR4qlYlrCH8aD1QPr92
 XJKgQTZwJvYoAq5kpz7wB
X-Google-Smtp-Source: AGHT+IHqhQZj26CkbljySSOi/m4T68KKNHqofreXrVFW0zi09YQEdDBKJr7vuuVmRYZg6Qr/vVZx5Q==
X-Received: by 2002:a05:6000:400e:b0:3a0:6ae3:a1a with SMTP id
 ffacd0b85a97d-3a08a3517damr2748285f8f.23.1745935742143; 
 Tue, 29 Apr 2025 07:09:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073c8ca72sm13769517f8f.4.2025.04.29.07.09.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 07/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
Date: Tue, 29 Apr 2025 16:08:13 +0200
Message-ID: <20250429140825.25964-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VIRTIO_PCI_FLAG_MIGRATE_EXTRA was only used by the
hw_compat_2_4[] array, via the 'migrate-extra=true'
property. We removed all machines using that array,
lets remove all the code around VIRTIO_PCI_FLAG_MIGRATE_EXTRA.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 31ec144509f..d39161766e0 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -32,7 +32,6 @@ DECLARE_OBJ_CHECKERS(VirtioPCIBusState, VirtioPCIBusClass,
 enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
-    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
     VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
@@ -57,9 +56,6 @@ enum {
 /* virtio version flags */
 #define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
 
-/* migrate extra state */
-#define VIRTIO_PCI_FLAG_MIGRATE_EXTRA (1 << VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT)
-
 /* have pio notification for modern device ? */
 #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
     (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 0fa8fe49556..a3e2e007d6c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -146,9 +146,7 @@ static const VMStateDescription vmstate_virtio_pci = {
 
 static bool virtio_pci_has_extra_state(DeviceState *d)
 {
-    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-
-    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
+    return true;
 }
 
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
@@ -2349,8 +2347,6 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 static const Property virtio_pci_properties[] = {
     DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
-    DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
-- 
2.47.1


