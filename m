Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C13CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8t-0005bx-IW; Sun, 09 Nov 2025 00:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8c-0005XH-DL
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:58 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8a-0007Zb-O9
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666733; x=1794202733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4MuIlqBaBvnfMbTuPCJMsBMQ1nurHwaBScGrpDh4BWI=;
 b=S8ok2TrXE/k6WqZ/PTmug6JUbdwrWGtFJ5caGtfg5F6JQMkK/Q+ZHu+3
 f8ZkFcBnBUJKx6dkWXd5Bm3nLyM71I7jdCIk6kwTWoW6LA7UGcIqVD3to
 Fcbk+UwjGRpw00JczK6M4gECd5MM2PoTShO0tM/BDGhFDGaYC7gZeqt7F
 Vb+mJvka/H4lQb3aHkHnXmYp6vO34gY007SUIsEJqyytPbYEMWLyiCOnr
 3wnPiADG6XfjNfQ7CSfNoKspas2VWPJxsDD0Q1ZTnAGKPhtoBgYTK4v2N
 DyDcbXujGqF3g7Ad+n+3Yzli2o1/vbmRWXwJJ8+zfYZyTGJiRpwZYbyNQ Q==;
X-CSE-ConnectionGUID: r/20hd60SqO27BoNXfM2mQ==
X-CSE-MsgGUID: Nb5gmpi0Rs2e2tq0LyH0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965793"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965793"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:41 -0800
X-CSE-ConnectionGUID: EguJ80UJQwqD0AnkSUjteA==
X-CSE-MsgGUID: KfR4f3qaRiOynHV93I+xcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129069"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:41 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
Date: Sat,  8 Nov 2025 21:33:52 -0800
Message-ID: <20251109053801.2267149-10-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a helper to check whether the addresses in an iovec array
belong to the same memory region or not. This is useful to verify
before trying to create a dmabuf from an iovec array.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c34d4c85bc..80143034d4 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -27,6 +27,31 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static bool qemu_iovec_same_memory_regions(const struct iovec *iov, int iov_cnt)
+{
+    RAMBlock *rb, *curr_rb;
+    ram_addr_t offset;
+    int i;
+
+    rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
+    if (!rb) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Could not find ramblock/memory region\n", __func__);
+        return false;
+    }
+
+    for (i = 1; i < iov_cnt; i++) {
+	curr_rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+	if (curr_rb != rb) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: memory regions not same for iov entries\n",
+                          __func__);
+            return false;
+	}
+    }
+    return true;
+}
+
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     struct udmabuf_create_list *list;
@@ -137,6 +162,10 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
+        if (!qemu_iovec_same_memory_regions(res->iov, res->iov_cnt)) {
+            return;
+        }
+
         virtio_gpu_create_udmabuf(res);
         if (res->dmabuf_fd < 0) {
             return;
-- 
2.50.1


