Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EE8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts49I-0001GX-H5; Tue, 11 Mar 2025 14:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47p-0007MZ-Or
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ts47a-0006pc-MX
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741716868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwpKaV3fmKDMNdUS7RuFW4EDDxAFHDX7wsnRUNq1Lpc=;
 b=LdofrOUDy24lMp03BfNX/5EcC3qykPjCNIs/Rwv2g5olCLYdiO1VaBYfjhPcW1Jjag271y
 aYu1SECJFCAZ84kV4Xc9lgO1Z2Sf9Eu+kv+4nBXTxg+cJvyjQOCgFoVt59C+MZtJr7sk2G
 jqqe0ahVm37csLVLxcWws+SANgJ0kRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468--cqSlLaKPxOrw3Ntj4fh1A-1; Tue,
 11 Mar 2025 14:14:22 -0400
X-MC-Unique: -cqSlLaKPxOrw3Ntj4fh1A-1
X-Mimecast-MFC-AGG-ID: -cqSlLaKPxOrw3Ntj4fh1A_1741716861
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1DC819560B3; Tue, 11 Mar 2025 18:14:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1269418001EF; Tue, 11 Mar 2025 18:14:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: [PULL 18/21] hw/vfio: Compile iommufd.c once
Date: Tue, 11 Mar 2025 19:13:25 +0100
Message-ID: <20250311181328.1200431-19-clg@redhat.com>
In-Reply-To: <20250311181328.1200431-1-clg@redhat.com>
References: <20250311181328.1200431-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Removing unused "exec/ram_addr.h" header allow to compile
iommufd.c once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20250308230917.18907-6-philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250311085743.21724-8-philmd@linaro.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c   | 1 -
 hw/vfio/meson.build | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index df61edffc084360d9f332ae1d122518c0ecbb955..42c8412bbf50724dddb43f9b19a3aa40c8bc311d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -25,7 +25,6 @@
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
 #include "pci.h"
-#include "exec/ram_addr.h"
 
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 784eae4b55994a53d16b5af600b06b0f77f2b36f..5c9ec7e8971bc6e8146d173b6b957e5ed88f73b6 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,9 +4,6 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
-  'iommufd.c',
-))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
   'pci-quirks.c',
@@ -28,3 +25,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'migration-multifd.c',
   'cpr.c',
 ))
+system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
+  'iommufd.c',
+))
-- 
2.48.1


