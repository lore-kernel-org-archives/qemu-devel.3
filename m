Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBC7CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqZ-0002b9-Cq; Thu, 27 Nov 2025 08:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqT-0002ZR-5F
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqR-0001Cu-90
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVhaavhb2GPoBraNf9DUEEmc85CVGAd40biEW+z/h1w=;
 b=ZpIAwOykf8qzi5WDCJCPPheN18VsgjZFGNCfAnSjYu4f5sn1u4RMR4yxgxWH0EuNxA73ee
 vSecThN+TLyNOmYA2ZPmuB2pX48P0276btQI6e5fW0US2frVnEsKJWcagI0Rpn7P73sOlA
 y7smDe6edpRqUI9RpaLuCtuR341WPc4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-EilB7tNpNFCLtfxxjwedZA-1; Thu, 27 Nov 2025 08:15:32 -0500
X-MC-Unique: EilB7tNpNFCLtfxxjwedZA-1
X-Mimecast-MFC-AGG-ID: EilB7tNpNFCLtfxxjwedZA_1764249332
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b7336ad128cso83585566b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249331; x=1764854131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AVhaavhb2GPoBraNf9DUEEmc85CVGAd40biEW+z/h1w=;
 b=bPFnO/Dqo0lyJ+WTdztzH4GCeu2WPy5qRma+35Id3j7CvSczRnQWSXfIqaMcIeF9gS
 Cjt0bAG0sasJZeVXtiWk8OrqRzKDTdqiON+TNUDasCUKFeY6pgUNSwmjbHULN/DJYMmW
 oe+RhCLvqkguUNcKS+pi33NWL5fRHfVslgN99xBubu/wmiiWs5yIdaUk2ORb377YvoZP
 lxRcz3JIqPCzXDnIuhHEppcupJWfvTJOmWgrOz3vq0bAH2ZixithznZ9hc47Ey+mz8YO
 463uBu+Pmxmat6H5sETPlFP8/p+wiCS0IFX/fSDlTFfbPZgG7R4E0yfQaiuNLmmUE7Wf
 ZlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249331; x=1764854131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AVhaavhb2GPoBraNf9DUEEmc85CVGAd40biEW+z/h1w=;
 b=kHGWDvTuM0JUblQxb4yRGVzNxe9F9o2/svzGU0JmEEg7RMLcrf/6EeqXUB577xwMP9
 DDtV8JoOOk8iDKHhdqkToifTNwXI9iAbfQlLohdXQt9gHddyWeO/oEe0q9rcq1xJRvbG
 xexG4bKIH3szTOmteOSNoggJDTpKVIJ8vVnaI7okARgsrtlPgCDXnCC8egjGgUDYhuYT
 iuT49NqboWAZfcgtcyqYT5xpl52Oj8CkaJy89FHI7jm7svOFiuX7hIjzHs5je+xo7aJJ
 cZ4SWY7asT2rA0IIij4XtHQVkJvvbYm3KpTzyzC1kegSs8LaC+AH7l7/ffMoWn59OiEh
 h77Q==
X-Gm-Message-State: AOJu0YwISNlOdDhodlEfdrKeNOUTX6v+LNoRlfEjRlbc84bo8T1C2JzN
 Llh0U8HUR9efRdnctkkhjBcOcXb5pM8GtuNIudc12f37URTJbQTK/UZ6XyPZP7K3K9hOpPrqqXR
 YZUYpdA9Y0xhhDp9XuS99/FFvNinHuGwDZKnV5b/6HYvMaelReAqhKJZztEHChUZ1Iy2B0KA1TN
 sdZsOUmWTHQRvPHMZzCgq/+UiP0j+yHLSAxMPaZfWm
X-Gm-Gg: ASbGncu+d4/ofGp2FCczO0PDB01K3P7pLBVopjyFGGUl0FGq2r9FPurNfkZRVh6w3bz
 JDCJ5iyLODMXaxvO5Oi7gcsr5mD1P43j6W7qqKrHB1R6n/atA7cXHPpuQcrqcxIMYKuax+a7G31
 Ciojn8jLbfssxyU8d94crLwJRrglkpvNoduUU74aqpiIF37v8PK8AKnid4waSSs2RONLuaCicwX
 UpVwxG1h3JsgiSozfVRZR/3KvtAWnfv/GcCOuqOZGFwSRcWi/LiCUKVZnIkqJZNQCROGPzmQyc7
 lx/9v7SJg4oqx5Mi/uJ6ua9rOj2oHi2qwNNS3YS27nDcZSPvDWBCVqucl6vUSPlQJiDgBupXS7u
 dgKe6EPIKRfrxDfs1Wsujw6Vuq6cjCO5JVjPHbjW05pT8n6/cxfU0KOCTN2JmVaC8bKWqPlO6p/
 skIyip7TXviaNfKkI=
X-Received: by 2002:a17:907:1b12:b0:b76:7e0e:4246 with SMTP id
 a640c23a62f3a-b76c546da56mr1165980266b.12.1764249330708; 
 Thu, 27 Nov 2025 05:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb7zuvFVDfBZw913/shAVEqGxBXfvMcd4GyLcmQ1qqjnS3/+uV6HknX9zw/NBNxTVFYU4Xcg==
X-Received: by 2002:a17:907:1b12:b0:b76:7e0e:4246 with SMTP id
 a640c23a62f3a-b76c546da56mr1165976566b.12.1764249330169; 
 Thu, 27 Nov 2025 05:15:30 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59aed2esm159140266b.42.2025.11.27.05.15.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/28] include: move hw/fw-path-provider.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:54 +0100
Message-ID: <20251127131516.80807-8-pbonzini@redhat.com>
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
index cdf405b0f86..b356bd9762e 100644
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
2.51.1


