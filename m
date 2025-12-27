Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790A6E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPr-0002Nw-VO; Sat, 27 Dec 2025 04:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPn-0002Lq-41
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPl-0002Jd-BK
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NH4AbEhMDNj1w9MP13tf9nDpr24WI1sJGsuQBiB53Bs=;
 b=Hsft2Gop2V3xSHoiMraO9GF5cY/neiYAH2nwhC17LXRpMI2ajSi7rMQAxBf1KdRgmEfLun
 ultMZyNEvfsWnbIAAgvuknpPmH5rRJ9bMIKKHpqrCTulr85PAQgIzNscjaXa/AGri5+8DQ
 isduprz5zx8fDc5dHIghM86j9IkI5Wk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-dZQApyp_PS2Kflfla_lieA-1; Sat, 27 Dec 2025 04:16:41 -0500
X-MC-Unique: dZQApyp_PS2Kflfla_lieA-1
X-Mimecast-MFC-AGG-ID: dZQApyp_PS2Kflfla_lieA_1766827000
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so6220230f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766826999; x=1767431799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NH4AbEhMDNj1w9MP13tf9nDpr24WI1sJGsuQBiB53Bs=;
 b=afLmjkIPwa3y1gDHYiHE72g19ywFZRb5U+vV4UiMSuo0K2vqHAel9+5ZL2h8x7EeD3
 uXNKVNv6FI09RzxS8fxNDlnmaFO4b1XaHfWFD7KOlGkfjuAd+9DpgaJR9qi7X2jMkGv9
 62zuIcquylL3vbN9XKHjGZ9+Z8jS12jpcojxdBSkgf4BH8MulNHf6C9xesY9KHgvpDJL
 OOBZHuskxWS9fUltoN+kbiARDKw9U2cvtEp75a7KoMZtSwPKjaf1dXToAUs/N4JJKktg
 NU76z6tYD/NRf35gVvptYLkhWk7wfks6C9J5+O0cblvJX3yucr8t449Z7MXSB0Dx80C2
 xEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826999; x=1767431799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NH4AbEhMDNj1w9MP13tf9nDpr24WI1sJGsuQBiB53Bs=;
 b=bInKZmyi4D4bo6Pde90FoiuYLcrPHX13l6cIz/2XocNH6RamB50hck0jNe6VeFsHhG
 jHcPrpnv9Tx/inYUBiTv93XWnsJ1hwG+CuSwfelXVBPcUklMzivciEzWvcsAIJGDftml
 XWQe9nTREIAWTK7xArgWhSt+qCw4fh4xpiU1csHQMKY4rUrMeQD1eDrF9J/W7CJEW3y8
 PZNp/qumBwSbK7dIaGf8MsyevQn8qEHh/oLtOTydhT15jlOTcvpwI9hbkbBBVgtStHCE
 SOiaQAw3scmun7QApJ7asgXz3kEkLEG7Hes7Au4TifBTmRrp9/lZhKJq+UHBkuCJgYZO
 l6LQ==
X-Gm-Message-State: AOJu0Yx46wo9ASgrREpQmMi6/yv8GQKYS/Az+wNWUrsJbL2KOL6/4ycK
 FxwCoURdehjyu+W6qxHtMBwgrzs4cTa/c88VXIgbR/8PYXOOfVLkPbtZ3OiAxRqdRwUBdBZdEH3
 wQsnqkPvfghDKn9dnKDpinJBfBXxVirBMeEGodyvmXRcOYAqe94gft/kQbTr2VAP540K1QsYFUv
 QXxxPYvUQrKj/Z+RIZFN4trWIPYg3vQ0TibgSeYQmT
X-Gm-Gg: AY/fxX43IVHxTQFZktyLXFaf6JucbrB8dvKUQ0QQxmJMKh5aHLkU7YBlcOPl7DqSaTg
 lS2BnHIbK8FtBdNTNuoPnq3YzGTkvL4F6Ka0ZckgZG8nK2kPJtNQdgv310SOiP2O6QBHRwYrisF
 KC2mH2O34IxVm8UAtrggWVO9hlo5sEN+2gfpyRlIdT0Qk3z1UduyzH2U3sMRqMXTTbvs2lROYHU
 DCF4+OB1kvjFbvQiPCDj7QQuQ9nBEPBHsTNgH4W7jyqacuwKRT+mShNfi8WIqaAHKJb/95NqCLX
 2VI2k29DdGODpNHeR6joVHHDJkO45BSEbkYbD7CM41UdrXcU91Cy8bOhTwZyp5TwVBzwE27/4h3
 YJ+62xko45KnPUvzLHOnGkX21rvCCRlg4XCIYnDhSpMBuoSVfAcgf+MXQ+ygGK6wgM7JE7aBRev
 i9RGcGBi+17NnwWXs=
X-Received: by 2002:a05:6000:25c3:b0:430:f879:a0fc with SMTP id
 ffacd0b85a97d-4324e4cb9f4mr30676223f8f.21.1766826998856; 
 Sat, 27 Dec 2025 01:16:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1l6pc8IqaFFNHn7fd+wFNxuZsFSW3se8DJYc6r1tMmA76PAdpWlGGJgqCY2cRjmSSkCoOaA==
X-Received: by 2002:a05:6000:25c3:b0:430:f879:a0fc with SMTP id
 ffacd0b85a97d-4324e4cb9f4mr30676193f8f.21.1766826998206; 
 Sat, 27 Dec 2025 01:16:38 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82f6asm51476575f8f.27.2025.12.27.01.16.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 008/153] include: move hw/fw-path-provider.h to hw/core/
Date: Sat, 27 Dec 2025 10:13:55 +0100
Message-ID: <20251227091622.20725-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 include/hw/{ => core}/fw-path-provider.h | 0
 include/hw/virtio/vhost-scsi-common.h    | 2 +-
 hw/core/fw-path-provider.c               | 2 +-
 hw/core/qdev-fw.c                        | 2 +-
 hw/ppc/mac_newworld.c                    | 2 +-
 hw/ppc/mac_oldworld.c                    | 2 +-
 hw/ppc/pegasos.c                         | 2 +-
 hw/ppc/spapr.c                           | 2 +-
 hw/scsi/vhost-scsi-common.c              | 2 +-
 hw/scsi/vhost-scsi.c                     | 2 +-
 hw/scsi/vhost-user-scsi.c                | 2 +-
 hw/sparc64/sun4u.c                       | 2 +-
 12 files changed, 11 insertions(+), 11 deletions(-)
 rename include/hw/{ => core}/fw-path-provider.h (100%)

diff --git a/include/hw/fw-path-provider.h b/include/hw/core/fw-path-provider.h
similarity index 100%
rename from include/hw/fw-path-provider.h
rename to include/hw/core/fw-path-provider.h
diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
index d54d9c916f2..7f34c7cb4fe 100644
--- a/include/hw/virtio/vhost-scsi-common.h
+++ b/include/hw/virtio/vhost-scsi-common.h
@@ -16,7 +16,7 @@
 
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "qom/object.h"
 
 #define TYPE_VHOST_SCSI_COMMON "vhost-scsi-common"
diff --git a/hw/core/fw-path-provider.c b/hw/core/fw-path-provider.c
index 4840faefd1a..2a9da1aa4a2 100644
--- a/hw/core/fw-path-provider.c
+++ b/hw/core/fw-path-provider.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "qemu/module.h"
 
 char *fw_path_provider_get_dev_path(FWPathProvider *p, BusState *bus,
diff --git a/hw/core/qdev-fw.c b/hw/core/qdev-fw.c
index a31958355ff..a587d2ddf90 100644
--- a/hw/core/qdev-fw.c
+++ b/hw/core/qdev-fw.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "hw/qdev-core.h"
 
 const char *qdev_fw_name(DeviceState *dev)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index bdc6c7ed7fe..3a6e47eb8b7 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -66,7 +66,7 @@
 #include "hw/misc/macio/macio.h"
 #include "hw/ppc/openpic.h"
 #include "hw/loader.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 8d35080b9d1..8f9ce68b8b0 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -43,7 +43,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/loader.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 3b48a54e7a0..e7396a729f3 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -26,7 +26,7 @@
 #include "system/qtest.h"
 #include "hw/core/boards.h"
 #include "hw/loader.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6f2d10330d6..7c695ac4ecc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -43,7 +43,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "qemu/log.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "net/net.h"
 #include "system/device_tree.h"
diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index 43525ba46d3..0bb4305de61 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -24,7 +24,7 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 
 int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp)
 {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 239138c9316..573a44b2b3e 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -26,7 +26,7 @@
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/virtio-bus.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "hw/qdev-properties.h"
 #include "qemu/cutils.h"
 #include "system/system.h"
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 25f2d894e7c..0d7bbb52aba 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -18,7 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 961d599f48d..62ceb7eef4d 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -54,7 +54,7 @@
 #include "hw/sysbus.h"
 #include "hw/ide/pci.h"
 #include "hw/loader.h"
-#include "hw/fw-path-provider.h"
+#include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "trace.h"
 #include "qom/object.h"
-- 
2.52.0


