Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A889BC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVw-0003Z3-MX; Tue, 06 May 2025 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSU-000733-3I
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSR-0001SE-K4
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:45 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so34833695e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542381; x=1747147181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms9JBoeprQUPiUptapCDzYpBSk9NyAFnoD9mnSvk1Zo=;
 b=SGcrTxIclfO5EuzzSgKMfcwt6D9P9SrwuaeHJ2+TZnccVZHQeHLg1P++a1C/HbquHf
 vgaBtpxj+OOUAZRkXFEy99AVObklxlStKJNUsRxRO4lS4TAINPMjR44iKqqBLRFZUchE
 JG9MVk1BxpQQvRxI2K/NckIOQ9Tk0i3prdVSwL5UVt891V3NoALLGl4w1kGldcP07Ue/
 6AqgVCjqb3IPap0o0XPa4+ToRcgcxCdtIeIlzghoOXLj0bweLol0lUq9J6CnetbL844D
 oOMYpP3kFkBa+NwPhYpE10rqvtzhJPCqqs1k81qbPnCaDB04sV2TSKaa2c5yYr+RT40U
 ulbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542381; x=1747147181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms9JBoeprQUPiUptapCDzYpBSk9NyAFnoD9mnSvk1Zo=;
 b=CnTRKlt5O5AWF1MYgUAm5LKEafzCcDcxebOq4y3TU1lZNtSTmfpHmm/DBugMWYz4en
 CKDxkgwFWVDg+YUt6UEIqSc706+CzcUJImP1CsaQzwZ8k34luunpdozoXcMK82vlu/O3
 3elLL8G83fjIjX8VgQs1DVkrX2G3O02cEnvYJpLhiLzDp9GzOHSbPhgubcO3HXCD+0XA
 BEqu87cDIDU0JGG/1RPiXbPW1iqF+uhbCVWgMkxT6rI5EcdRk9Hr8+nszz9T0/4iUbTB
 7P6BH7UtJCdy4gJAJCNDgr0V3f6vwYYFeSo2k+tuZJrADo7Sg37T8uqjFTme8CjWdUyP
 Brgw==
X-Gm-Message-State: AOJu0YwAVJP9CzKY4J1s+SsgRu4X+T24QJG/F/ipatjmsH6tP7iHzezq
 9hscyKB2KJuyCrQBz67g/Ce77oS19KSjHHdrPL6bWTMURP7D9aZ6sYllYkSVAqQg+rLcoNhob2F
 z
X-Gm-Gg: ASbGncti3xhI7qe/li4t2kYzTc3BYxt+YAVhIxvD0BpSfEu5UnsFpQWYNodNUPb3hRX
 Ftg4z9sUp4/r2qAt4ZQbfTpXfoinfTQvJc6I0zWnTOeiquQ3eM00i3VSV4J9DZK1Gg2SLfkaTGV
 tP9dJU2+qfOoxYV1CEvhwuPcO4HPqsx/DJ5O4T2FH3AL2cG6wwEkKm96ca4i0OKqNj3njD1U3cO
 rY3gSiZXx4660cl9V81Wy4PP6Udt8aB8ZBwgh1SndRLf3bR8S0hFf+NBk2OJCCWf87HmFDKZpLs
 XrkxqQ0rIWPjY7b1ZIw4gdGpzCMV3yn2zLPcK+xhukKBKCpRPmkoG/HkL627ovDjBGcMtZwzc93
 +CG8Jd9g3XlXeWjnzsyrx
X-Google-Smtp-Source: AGHT+IEYzgv16XUdJv58V/Uju7IuXSgx+bGjKcBUd7ESl8loCaLmlcXbNhqkVG8W6JbNOulJ3EUBwg==
X-Received: by 2002:a05:6000:40dc:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-3a0b43afdb6mr23610f8f.4.1746542381427; 
 Tue, 06 May 2025 07:39:41 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2ad7688sm219322085e9.3.2025.05.06.07.39.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 07/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
Date: Tue,  6 May 2025 16:38:53 +0200
Message-ID: <20250506143905.4961-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
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


