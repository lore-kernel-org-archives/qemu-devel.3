Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE1E98E00
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQvl-0002wP-HA; Mon, 23 Feb 2026 03:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvh-0002vD-Tx
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:36 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvf-0004L5-G5
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771833871; x=1803369871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R+voCt8gQq6Y2SKx4ENrPxTbBWeBaPJn71IunQUW5Lg=;
 b=eBnmcimXLwU0gWp4fwH2+Uysrrp/hWU7JFzNaDlZkOxBjwdyp+o199Cv
 VckZwHXOgW7mc5lsRatwej0bCdzErCxFv4/BmOemDlyebvcYhdC8xd9PP
 ttJi/qR64SDAWojxx/Ep+RZQpS4TuABWIrR8ef74Q/JO5dbkVRgb59pow
 ZiB2yT+PiHzPgrvSdCES3Ds0CD0AtBmWXeWIqFLkKy8oB7PdUUggdS7MC
 0he8QoBYop9h1TAmcGEyIcYbSXaMunNCccb85GCbfdTrpOF+YojuXdUKX
 Af1WBf/YEVW65v8zv/KbIDlh4yk6NWeqku1tO0r9pfcxuv2p/SHatXq4Z Q==;
X-CSE-ConnectionGUID: FNO321T4SruAc7E44F24lg==
X-CSE-MsgGUID: UQg5gxGlQqy6UoPynH7J0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72027125"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="72027125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
X-CSE-ConnectionGUID: FX8AKnfoT3GFwJoUb3gRJg==
X-CSE-MsgGUID: 4lc9ounwRUuogFd7JK6biQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246079166"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 05/10] virtio-gpu-dmabuf: Use g_autofree for the list
 pointer
Date: Mon, 23 Feb 2026 00:00:09 -0800
Message-ID: <20260223080200.468558-6-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223080200.468558-1-vivek.kasireddy@intel.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
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
2.53.0


