Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30500CA6004
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY1p-0004cS-3Z; Wed, 07 Oct 2026 16:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1Y-0004ZS-EU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:00 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1W-0002BI-R0
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404039; x=1822940039;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eii/Ddy1nMhhF7TtcuT2NL6phsSZI+C3se2iHxozDAg=;
 b=mC2KjF/gmM26KGGwQQedWPeGFCkwBy0zOs8YvRkhZK+mGOCGtZdVjNWI
 taa9aB2sdkb1j4/EmFxS1J5e1ViaY9IWD1Aa1U/VNjAT+2zWjm2JrWsXV
 YFnDyyehfX341GjvIVnKFbeiD2yznl9igPAM795UIlc2cgIhynDipa0Zc
 GYxYFX2Ano2OXvnaW9kdxjYDMtI5iYvfL8/radLztiX+iVOZTWsGADU4S
 89WimdhOqI6CowR1scBYzv6Q6CT1+PM4KecoQ0nU1u1BT+iMY3K+/dgPR
 pjcL0U0Xd8FClEsoexDrIGGIVPxca+tDQHN2+j2/TI8FFyGyQe1WcNc/o w==;
X-CSE-ConnectionGUID: MHqSftJdQdiMJrtfOGDIrg==
X-CSE-MsgGUID: +jrMmm/2TCS1VArzj+7sug==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178475"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178475"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:48 -0700
X-CSE-ConnectionGUID: C5+FqnIqSw2CGwcOl+7R6g==
X-CSE-MsgGUID: ocuLD+ToQ0qX+Gsj4GCqIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564961"
Received: from vkasired-desk1.fm.intel.com ([10.121.64.242])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:47 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v13 4/9] virtio-gpu-dmabuf: Use g_autofree for the list pointer
Date: Wed,  7 Oct 2026 13:09:23 -0700
Message-ID: <20261007201222.648687-5-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007201222.648687-1-vivek.kasireddy@intel.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 0ed8d9250e..6f05f367d0 100644
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
@@ -48,7 +48,6 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     for (i = 0; i < res->iov_cnt; i++) {
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
         if (!rb || rb->fd < 0) {
-            g_free(list);
             return;
         }
 
@@ -65,7 +64,6 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
         warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
                     strerror(errno));
     }
-    g_free(list);
 }
 
 static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
-- 
2.53.0


