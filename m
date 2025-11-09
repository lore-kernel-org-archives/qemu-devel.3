Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F381FCD1297
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8g-0005XD-KG; Sun, 09 Nov 2025 00:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8Y-0005Vz-JX
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:50 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8X-0007aH-2j
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666729; x=1794202729;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4ssiyJyKb1dM2r+xpQ+t97aneJXk9s2pQd+SlFWTZtU=;
 b=CS5ulnVMh65QLEl4xumLvINxO5c5n0XIbb9Hvl3A/SQyYNfTNefV1khN
 7DKQYFbCtp7IL/glrkbmToDRq3uHnYWLGzq3elAI9Ew4UvvHz/jERC1aI
 f1Tvckjb7mh1LkYSYvEBioQ27KZ6QYi7BbrL31kVQk53J1WcYXOZJOeMQ
 QwIHcv5jfcveNIhCo4KI44NLaeRJqHFnKEegH8SgGxBk2DhdpRgVxKuiE
 IJufW9XWS/qyp6Q+D3s2K4mQOPzHsGPtml/SwhsCl4MSdRGj6VRHvT8SS
 FH1L/RlgR2xCXzHmnWv4bu8qmcKPekDBcR6GfztdHOl/fwoaJYY64h0um A==;
X-CSE-ConnectionGUID: /9jyfaL+QJm99YspZ2lg5Q==
X-CSE-MsgGUID: dk29Cy8iQSm+yiDtbvCWAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965785"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
X-CSE-ConnectionGUID: fZHmqQ8rT92s6JuirOXLGA==
X-CSE-MsgGUID: XeL1d4uGRZmeTtUX/KMpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129043"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 01/10] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Date: Sat,  8 Nov 2025 21:33:44 -0800
Message-ID: <20251109053801.2267149-2-vivek.kasireddy@intel.com>
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

There are cases when a blob resource's backing might get detached
and re-attached again such as when the underlying object is getting
migrated in the Guest. In these situations, we need to obtain a new
dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 43e88a4daf..199b18c746 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -937,6 +937,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
+
+    if (res->blob_size) {
+        virtio_gpu_init_udmabuf(res);
+    }
 }
 
 static void
-- 
2.50.1


