Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEE0E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAu6-0007NV-Oi; Tue, 03 Feb 2026 02:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtw-000785-Qn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:46 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtv-0006DN-5F
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103963; x=1801639963;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sAIC02tFWxwAzWAC6ZXsDTdzNYZHqGEEMjqYME3SrNo=;
 b=VmhOuNUbYC4f4ShkbZxkwaR0QDX+h0m2nDWgpxfg3b/19GlGXvPk6HKK
 iY7ukT3i4wxgObVXaqebpK2HK/wFa4I/M2INWtL7N8pDLA+OaqwxFFqSM
 W6xdzVrxSwMGfVpL52L6Knjneug2xQF11vQVKlhGzZh93p0N0g0nnDzLx
 YRKM3ZqAf5hJIekTn/VZHKayOle0PSj581CnW/v6k2LeyZmSiGoUBEVLX
 FYS26L2EhkvoSg18exiBukZRmsQ6gahKAvJ2tfztp55gEUx4CXGk7r3j3
 dK9LDlUtz+SHaH9yTFM2Gs2OowEpdqbyOSkdI9ugl+u5g4ZzC+iHh4rvs A==;
X-CSE-ConnectionGUID: bq4EFVv+QGaTcN71JPGeqQ==
X-CSE-MsgGUID: nJM/Dwt2T16aEde1H8IvHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640901"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640901"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:35 -0800
X-CSE-ConnectionGUID: 10xOvO7UTvSSKf2OCxumrQ==
X-CSE-MsgGUID: 5NSPWgm5QlCV0OM4wlFufg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373095"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:35 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 05/12] virtio-gpu-dmabuf: Use g_autofree for the list
 pointer
Date: Mon,  2 Feb 2026 23:30:12 -0800
Message-ID: <20260203073200.848183-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203073200.848183-1-vivek.kasireddy@intel.com>
References: <20260203073200.848183-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avoid the manual g_free() calls for the list pointer by using
g_autofree in virtio_gpu_create_udmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 0782bcf3a1..8d67ef7c2a 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -29,7 +29,7 @@
 
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
-    struct udmabuf_create_list *list;
+    g_autofree struct udmabuf_create_list *list = NULL;
     RAMBlock *rb;
     ram_addr_t offset;
     int udmabuf, i;
@@ -45,7 +45,6 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            g_free(list);
             return;
         }
 
@@ -62,7 +61,6 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
         warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
                     strerror(errno));
     }
-    g_free(list);
 }
 
 static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
-- 
2.50.1


