Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7280C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wecKx-0006qy-Vp; Tue, 30 Jun 2026 13:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wecKd-0006mN-Eh
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wecKX-0001mK-G2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 13:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782840783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SCt4eGn98246K6Xn1QLWU80/H2/G0pj2GXg//BLsdyo=;
 b=DESEoiJqZ+qR5CAhipqzLLHhrbnLjkwUeEGjOlfBULm2ONhnxckoF+kReEte8nh9YoJHrO
 OI0zFs3ZgMFhA/MLsh/AFWrBbj1qjT0tvLZqizeyYqa34OV8k67yhMXInt1x22NADKMyY3
 k+O3xLz9erBUJq3UO5VtcmNVUdlD5TQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-qKlv2bRPOAqRLQk9fxGZ3g-1; Tue,
 30 Jun 2026 13:32:59 -0400
X-MC-Unique: qKlv2bRPOAqRLQk9fxGZ3g-1
X-Mimecast-MFC-AGG-ID: qKlv2bRPOAqRLQk9fxGZ3g_1782840778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C9B0184A083; Tue, 30 Jun 2026 17:32:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED6C41956088; Tue, 30 Jun 2026 17:32:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] platform-bus: Align MMIO regions to host page size
Date: Tue, 30 Jun 2026 19:32:45 +0200
Message-ID: <20260630173245.2070268-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
place device regions (such as the 1KB "tpm-ppi" region) at offsets
that are not aligned to the host page size. This causes unnecessary
and noisy VFIO IOMMU warnings when starting VMs configured with
passed-through PCI devices:

  vfio_listener_valid_section received unaligned region tpm-ppi
    iova=0xc005000 offset_within_region=0x0
    qemu_real_host_page_size=0x10000

Fix this by ensuring the alignment used by the platform bus allocator
is at least qemu_real_host_page_size().

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/core/platform-bus.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index a2217a2deec7ab0f49b211c6658db02d13c319df..a17a38c1ba5491e2001fec5a29c188de67e93d11 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -140,6 +140,13 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
         return;
     }
 
+    /*
+     * Ensure alignment is at least the host page size so that IOMMU
+     * mappings (e.g. VFIO) work on hosts with large pages such as
+     * aarch64 with 64K pages.
+     */
+    alignment = MAX(alignment, qemu_real_host_page_size());
+
     /*
      * Look for empty space in the MMIO space that is naturally aligned with
      * the target device's memory region
-- 
2.54.0


