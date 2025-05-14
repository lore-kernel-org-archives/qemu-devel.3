Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE03C3ABDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 17:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFFYz-0003Wa-VP; Wed, 14 May 2025 13:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFYm-0003FA-Ol
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uFFYl-0007s8-56
 for qemu-devel@nongnu.org; Wed, 14 May 2025 13:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747242381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ENcWQhSiq/mDYXzO0B3NWUXB9XTPdOHL4+pzW85tp58=;
 b=BnWNoKvdGt19QMrxqM/8LRpjil1efkf3PnpJs4Y7tjh6LT/SRtry19Ry9gksrcTLArMq7n
 Rvhv/R/GY+Wg8O1p5hfwy20i2TTjFtznkvnuGxqFDumhujCCVd109rmtMBfRHcPmZfh96t
 xuoC+p/PEM6oxsz6B69BgDbQRz7qHDU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-SQdxvN-HNw28ptnKDS580Q-1; Wed,
 14 May 2025 13:06:17 -0400
X-MC-Unique: SQdxvN-HNw28ptnKDS580Q-1
X-Mimecast-MFC-AGG-ID: SQdxvN-HNw28ptnKDS580Q_1747242376
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFF4E18007E1; Wed, 14 May 2025 17:06:15 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E30F030001B0; Wed, 14 May 2025 17:06:11 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com,
	philmd@linaro.org
Subject: [PATCH 19/22] hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
Date: Wed, 14 May 2025 19:01:06 +0200
Message-ID: <20250514170431.2786231-20-eric.auger@redhat.com>
In-Reply-To: <20250514170431.2786231-1-eric.auger@redhat.com>
References: <20250514170431.2786231-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some sysbus devices have conditionnal mmio regions. This
happens for instance with the hw/acpi/ged device. In that case
it becomes difficult to predict which index a specific MMIO
region corresponds to when one needs to mmio map the region.
Introduce a new helper that takes the name of the region instead
of its index. If the region is not found this returns -1.
Otherwise it maps the corresponding index and returns this latter.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/sysbus.h |  1 +
 hw/core/sysbus.c    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 7dc88aaa27..18fde8a7b4 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -82,6 +82,7 @@ void sysbus_connect_irq(SysBusDevice *dev, int n, qemu_irq irq);
 bool sysbus_is_irq_connected(SysBusDevice *dev, int n);
 qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
 void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
+int sysbus_mmio_map_name(SysBusDevice *dev, const char*name, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e71367adfb..ec69e877a2 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -151,6 +151,17 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
     sysbus_mmio_map_common(dev, n, addr, false, 0);
 }
 
+int sysbus_mmio_map_name(SysBusDevice *dev, const char *name, hwaddr addr)
+{
+    for (int i = 0; i < dev->num_mmio; i++) {
+        if (!strcmp(dev->mmio[i].memory->name, name)) {
+            sysbus_mmio_map(dev, i, addr);
+            return i;
+        }
+    }
+    return -1;
+}
+
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority)
 {
-- 
2.49.0


