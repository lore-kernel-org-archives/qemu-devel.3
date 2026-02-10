Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D517DEA3F0F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 07:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vphlR-0004yV-Ht; Tue, 10 Feb 2026 02:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphlP-0004xy-De
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:23 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vphlN-0004oR-LE
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 02:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770706941; x=1802242941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qXg+ylIgNJYyiez2ZWJ7vvZcreZYGOhcBt9sUvBPrjs=;
 b=Hsg7Jcb1kSeF0e/iVSPcBz4Lqrmmh6VZLTT+NyDbz7Z6mZTJdEqxo5xO
 h5j0ZV5yX3Rk8vKoazgYASkDQ8dcAdk2v4IR4MeohNsFuKPqw4bLN2wSG
 fUqu4gdWqOQD4SBgRa0Ycl5C1kUH2h3otoJn8BmkbXpG6bkJEHY/x68uD
 r4JgrM3MF99IVxG3u8EqZq7NYV72a7hDfgaUHpRDMegACTW9+irBx7oNO
 KKFGL/5IdsM1t/wE6KtgTrXzNb3JJShg9ujgHubzBqss2Psx4Rw9K4+gJ
 OWP0vDbI/CAOJ52ZYJnRT1ejUV34qISh9NdjIrziMXgArkYwsjDkMKG7t A==;
X-CSE-ConnectionGUID: 7NBpzE6QSg2VrxCFKEH4/Q==
X-CSE-MsgGUID: N5bKI6DISLKBhV3aHF1vNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="72012163"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72012163"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:14 -0800
X-CSE-ConnectionGUID: W2LcRSG9R6+OEpOJFixW+Q==
X-CSE-MsgGUID: 84CAHjn/TMi1juvervwFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="210920544"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 23:02:14 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v6 05/11] virtio-gpu-dmabuf: Use g_autofree for the list
 pointer
Date: Mon,  9 Feb 2026 22:59:45 -0800
Message-ID: <20260210070155.1176081-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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


