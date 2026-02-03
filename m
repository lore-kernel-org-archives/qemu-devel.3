Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E090E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAu1-0007EF-LV; Tue, 03 Feb 2026 02:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtv-000766-62
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:43 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAtt-0006Ca-8s
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103961; x=1801639961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OkuB3kYF7xmHNv/+0X3gXdvyD6tejLSYKJjk9QF/6DQ=;
 b=gc194OJha/mJz+CGeIOnYglW0bc/AN+sASx5g+uU3+OK28J4wMFafsbE
 KHk+El2OErOxlRAHcU120hF3MC33Kc8pZp1siYc5le4d3SLj0FBgxHBqA
 f7gT0kSIh2dgJGjDQoQrWo/SPXRkXEauOLHhjA3OTHWIwH1p5GJoTI2Lf
 zuscH/OpNJ6oJOanFOaNORd5MtyabZferznxRRtzjsVDNeq/wCpIlqnX2
 dL3MAWQHYq15/Pz8TLFQROm3X0UUnAjCiA1GikYs4/oE2gTyON9pRHefq
 /vFrqZCCqY6i0mAJfuczUa0CYan9VTGFLKarHAamdw0uSj1hkRQgoNiGB Q==;
X-CSE-ConnectionGUID: OZ1KsSw3Tsu9YPGcyRj4fA==
X-CSE-MsgGUID: SeoDQEfkSAyJ4+Z8nANI2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640893"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640893"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:34 -0800
X-CSE-ConnectionGUID: 65EfIQBISSaBPiSyaTdCcg==
X-CSE-MsgGUID: 2a+98WRIRXOp6kZocX/9bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373088"
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
Subject: [PATCH v5 04/12] virtio-gpu-dmabuf: Remove rcu_read_lock/unlock from
 virtio_gpu_create_udmabuf()
Date: Mon,  2 Feb 2026 23:30:11 -0800
Message-ID: <20260203073200.848183-5-vivek.kasireddy@intel.com>
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
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c34d4c85bc..0782bcf3a1 100644
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
2.50.1


