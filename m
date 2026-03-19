Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263DD1088E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35qr-0004og-C0; Thu, 19 Mar 2026 01:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qj-0004mb-Qh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:13 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qh-0007uV-Gr
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897792; x=1805433792;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1J4eoFf4c2OuvI54QAuPBMcNUljr0h10rY6DxxOl8Dw=;
 b=lUa4X2YcCQ7nApneNNU5Y4MINQxBXuaY5siU/Kv0L4xlygMtkc9qJwSN
 9ZULJBHNvIDf7u7jEVMRwU8CB313kkRlOeVu45vn2nl7yntRHnikkMaL4
 GYhKhF2wtCQqToF5aHuxhAJ9g196kEi6FjsE1ulVzyGR5Oz/sCT72RHOR
 qHxAS+vDMuAJmRpHg56WWbk5DOQ71x1LdztueAp/OXW/2HBB/30kK9R47
 F+2wPfZX1x/l9U+rV7pyhUlUXj+1Wh+xyA6T53OOFBBowhPm5JN/sy44y
 LpkOdR1Zj4PigFhcsIrLaDKQ2i8crRK1DnulDWyGn+cxx0zTQOU0zXoWP A==;
X-CSE-ConnectionGUID: i62XiPfeSbWN+c1GHJSd/g==
X-CSE-MsgGUID: wm9MhUSYS5q6MsYz8oKvYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660378"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:06 -0700
X-CSE-ConnectionGUID: Fr2hl/pJRwiRdcW6dQTXFg==
X-CSE-MsgGUID: zg0ba3jmSgaWKPyTBzKJVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355521"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:03 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v12 04/10] virtio-gpu-dmabuf: Remove rcu_read_lock/unlock from
 virtio_gpu_create_udmabuf()
Date: Wed, 18 Mar 2026 22:15:53 -0700
Message-ID: <20260319052023.2088685-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

There is no need to wrap the call to qemu_ram_block_from_host() with
rcu_read_lock/unlock as we already hold a reference to the memory
region that owns the ram block. Note that, the reference was obtained
via dma_memory_map() while creating the mapping.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 776e5c4c64..64582f973c 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -43,10 +43,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
                      sizeof(struct udmabuf_create_item) * res->iov_cnt);
 
     for (i = 0; i < res->iov_cnt; i++) {
-        rcu_read_lock();
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
-        rcu_read_unlock();
-
         if (!rb || rb->fd < 0) {
             g_free(list);
             return;
-- 
2.53.0


