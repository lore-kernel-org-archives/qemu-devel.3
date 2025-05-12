Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68877C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOjs-0001FL-Ar; Mon, 12 May 2025 04:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOib-0007co-M6
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:06 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOiY-0001l6-MC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so29152835e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039256; x=1747644056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8B0TCm05qe7PpunGHX/ka1ZgS/TRYp4ybH1gTnihvoA=;
 b=LVmRGpJBZK8+1+z1OnsHHHQEH6/fuOSJ7RcCQ2dU9ioDCRA0B8Zmpm9gqAHYOJ5Fql
 gn80Rvx1q7Xw7ufm7QMU435AE/UeE1A6D0YfVWpounMRNKl5FwF0uTnkcPy5vuEah0EZ
 2tMS+dFo79Hen1JtUdkD+N0/LEcCOR2d56wiMYwX0mHBHaK5I02wo2WGW7ay68uqhnPA
 Qlb5OYGAkRWgWsVd21txevz5mmZts2jbvGuYVW7LxycoMZZmsBFc5qBmX/j+X0AxQxYi
 iV3+YxAHwTGFpzRUW5iZhsw5tqVOkhF3VXrx08WW7VihmpFj135DWJDQ0qb+SIAJDqsk
 MxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039256; x=1747644056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8B0TCm05qe7PpunGHX/ka1ZgS/TRYp4ybH1gTnihvoA=;
 b=NLdG/Mvd0BUiYr5MD6TFDwJ4JKJdP4XR/Cjdy3cn1iaayQ7Y0Ly1cVHLpaykWO35dL
 hSR55uRgLLKjnb+wpF/FyZDr4nOIm+s8zcfc1GByjsqaYJ5MhqBIqlzN/mb7bAgg23Nk
 CylQ1XraVvhw6rHUCKT8nnjvmobp6hwWD+VeCCi8wY1RSIYka9SQHSOdc/BnImZDwI+K
 gFl3jkpkUipDgEZaEI4VLU8PGXGGNFG+YA0xOgEyGk+dKcVQXPTkPBW4RntTggn8Fe87
 j+akOimo1f75uV0vNrep3H/E2Va2tKXlfjw4qt06/4rHkgk8RA9b08qCcVjnjYutA6kp
 aXcw==
X-Gm-Message-State: AOJu0YxagJqkhimQhAamY1aOefide02eAPlATtxnGkZ2KXKWipfu7i6b
 kZKwMLXT7Ay4zc/MaZUt4x67yWY/FNjfBbkoBpi/Lx9bOBWPJHFdYt5eKqTDosnqqS9mzBSXnlJ
 4YkVJgw==
X-Gm-Gg: ASbGncvasbAjWGEQG/xZIMUcQfDHfeIGIn2R1qaQEa0ZwqTI0HpL7xZiRNVKgFtPIXj
 aTSjLWN0lsctxr7CO7KuWqSzRacMjb7izNjpBBkNsaA/876WL9kf3rHmh32tyLs3tQHkyUEGugQ
 Pi4KLLnTa1JiRA20j1/3ccZOSpHNeJWs1s178ApSxeMH7AWR3V7kmURtKgN7hYilyzVd2pNc9cs
 gHtk3MdsP6f3NxIlBnXIP7UNdnPxHKy7kVs3kGYMEngxnVD9QTkdwm8QLSykgOK5IeN3FxRsKXa
 Cv0oJ6Jj3l6LMbPJ4k1V91EFABMhPhpzgpPNqGHkW1efWQRHTRwok3Rl93mPtsrnCurKeA9IVuI
 k6Yh9eRj4wr2KsBbURw4Ztuo=
X-Google-Smtp-Source: AGHT+IEFKd4wMmqxKHShIanir9j7vBnmxKADZY2cko2vvlgImZfJk51CPKk1GT4S6Kxa+yezYQwANw==
X-Received: by 2002:a05:600c:a409:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-442d7800805mr74622165e9.7.1747039256424; 
 Mon, 12 May 2025 01:40:56 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bef4sm162315045e9.24.2025.05.12.01.40.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 07/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
Date: Mon, 12 May 2025 10:39:36 +0200
Message-ID: <20250512083948.39294-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


