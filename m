Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A40C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNDX-0008HG-4h; Mon, 29 Jan 2024 03:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=2aNT=JH=redhat.com=clg@ozlabs.org>)
 id 1rUNDV-0008H0-Ob
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:42:09 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=2aNT=JH=redhat.com=clg@ozlabs.org>)
 id 1rUNDT-00053B-UI
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:42:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TNhcS41pyz4wyl;
 Mon, 29 Jan 2024 19:42:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNhcR1vwpz4wby;
 Mon, 29 Jan 2024 19:41:59 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/2] vfio: use matching sizeof type
Date: Mon, 29 Jan 2024 09:41:49 +0100
Message-ID: <20240129084150.134050-2-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129084150.134050-1-clg@redhat.com>
References: <20240129084150.134050-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=2aNT=JH=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Do not use uint64_t for the type of the declaration and __u64 when
computing the number of elements in the array.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 4aa86f563c64cab9290efab54d20cb2a30c498aa..059bfdc07a85e2eb908df828c1f42104d683e911 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1118,7 +1118,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
                         sizeof(struct vfio_device_feature_dma_logging_report),
-                        sizeof(__u64))] = {};
+                        sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
     struct vfio_device_feature_dma_logging_report *report =
         (struct vfio_device_feature_dma_logging_report *)feature->data;
-- 
2.43.0


