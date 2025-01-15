Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5641DC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjg-0001es-5j; Wed, 15 Jan 2025 18:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCje-0001d1-Rd
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjd-0003su-2a
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43626213fffso8865245e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983419; x=1737588219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OuY7XK/c0FM5xJPshFmNC9eVlLzvGQYZs65GXrUSy+M=;
 b=vNBMtishQtPP/t538Uo+Ff72aptiBcuLeCTWDGokhQY7OSTuWG0ZeQQJRSUwyb7Yg/
 VbwkRe5ZHiME4gYGRNLD4vlmIKqvA8gLJtCHjmS/WfxbtOEjzbZGMkLWr2s04x8l/cZB
 eeI0BuymsPVIsW8McDb729KAaYq43Ihnx+fLYIcPhXGdy3LL6zWWqQL3MPMoVHKCdXKa
 FW0be2esMvOrm+6p4Zzf3HVnBvzNd7e125OXjO/jlaeSMZoiNdyK7KPAWOgTSOXdMOC5
 6Vw0YiAHb9Ytoe433xV95uaRUsgv7nQPNs51VEsx71LRYkC7k49+lloh9iy4XyfXnMpW
 kLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983419; x=1737588219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OuY7XK/c0FM5xJPshFmNC9eVlLzvGQYZs65GXrUSy+M=;
 b=WKfS/nxl84dgNnWtbcOKCapQI3GFd/w3MAjCOJZQKDFcPEX/bxTlAw3Ex5zZpqCyfM
 LrYpQv3lMV4h4W3pTIW35iRe1HYYwmvgijDcFTAc2DTYdPOQSsFnbrpg9pnoMVeTuqBV
 xcuj8bUmAmKpOBd24TysDfEYkTkymUi46DpSjDbY2A0WB16OBmW35WoduBTR7/AyE4vt
 2FUYoneP2M82ldZ9/yx5H+V2cWN5jl9RF61E9BuSoaDLF578vB1yjE8zVmYiQUkq7eZq
 AnGswGAhZH/sPkCQxc/dKvTAigO8O/E2/J/IKfuqUeGOMW5YJ7jJ2vH5EfBRSxq5Jr6L
 ZcpA==
X-Gm-Message-State: AOJu0YxYYI9Wv1a0rrIi7V4xs1pI502IUCysg2sTDGS4OrlfFPKDLiVK
 sUByYQM9Rv/oCrE+gelLdvtbzn8+knwdgLOZvewzgX5NHik0gy2bnHXw10y4ytI4wbplFPJ9fwn
 ZtwA=
X-Gm-Gg: ASbGncudGCw6hlVsCvF3O904fIcjdsi0/ldzMpG7O/vwzLHYylZlBdBfv2zfdTA2WG3
 x8sMJV47tVWTTC5YLtxtJhLdOCrEpzUAx6UgqUhpaaMMXxELeKUxDiJV+25el4Tym1NIjmOlduE
 +ctBtqcWFT4AnVKqKMAoWhm9YO1liKbt2hwVji0CytxFIkDGuNlwGdkIIMcq0rvNZftY2HGUWaU
 D3QXtorEmUvitIr+LLyFfz+h8WaHRR5+cAd02HMU4mNbbLzeHqM0RX0u9cvbgTgu6Ej4/N+dcvh
 QfsUsUhalGigI3EX51D5AvaQOOljIdk=
X-Google-Smtp-Source: AGHT+IFkqaiAf0xdKKh0b/pmQ7c7zqPgSwzWI6TXIrJoG+6WyJd7yrJkaBjhEO18U0vInVSSBrC4BA==
X-Received: by 2002:a05:6000:1889:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38bec4eecbemr318972f8f.3.1736983419051; 
 Wed, 15 Jan 2025 15:23:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bebd72582sm466070f8f.7.2025.01.15.15.23.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 09/21] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_MIGRATE_EXTRA definition
Date: Thu, 16 Jan 2025 00:22:35 +0100
Message-ID: <20250115232247.30364-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
---
 include/hw/virtio/virtio-pci.h |  4 ----
 hw/virtio/virtio-pci.c         | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 971c5fabd44..dd6eb9a4fc7 100644
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
index c773a9130c7..8dca3ae73e6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -144,13 +144,6 @@ static const VMStateDescription vmstate_virtio_pci = {
     }
 };
 
-static bool virtio_pci_has_extra_state(DeviceState *d)
-{
-    VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-
-    return proxy->flags & VIRTIO_PCI_FLAG_MIGRATE_EXTRA;
-}
-
 static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
@@ -2352,8 +2345,6 @@ static void virtio_pci_bus_reset_hold(Object *obj, ResetType type)
 static const Property virtio_pci_properties[] = {
     DEFINE_PROP_BIT("virtio-pci-bus-master-bug-migration", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
-    DEFINE_PROP_BIT("migrate-extra", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_MIGRATE_EXTRA_BIT, true),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
@@ -2601,7 +2592,6 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->load_queue = virtio_pci_load_queue;
     k->save_extra_state = virtio_pci_save_extra_state;
     k->load_extra_state = virtio_pci_load_extra_state;
-    k->has_extra_state = virtio_pci_has_extra_state;
     k->query_guest_notifiers = virtio_pci_query_guest_notifiers;
     k->set_guest_notifiers = virtio_pci_set_guest_notifiers;
     k->set_host_notifier_mr = virtio_pci_set_host_notifier_mr;
-- 
2.47.1


