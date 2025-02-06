Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C309C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 22:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgAnp-0005j1-CC; Thu, 06 Feb 2025 17:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tgAnn-0005il-VQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:56:55 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tgAnm-0000vo-16
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 17:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738882614; x=1770418614;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q/jnEpsDmilQqNLaKnOhLJEeViWTbTjBq589qG6CioU=;
 b=kKF0SUW6rX/1Dt7vsJ8XPDlU8rQn4rb3hjjWV+Ggy8P9v3CIr4/8bQos
 k3vDrWDqeybZvOtOxafFqO8dsvy9tHHDosjzvVCk0Yn4jGl7iW8l77KBV
 CJLd/l/2VIskqTAMn8se4pIaHHDgw7/+u8rp5XkK6V5j+TpaR9cdCOcZa
 HWqiHy5SDbbuxC53IpJZzVFK4jNIInmDnrA6J+zFR+KUuUUEvTnd/etXC
 DmHhoKFF0Fq29Q0y40DTcr+EmicvqmQC5GSD0Q4qaitSNzNxUqZZhTriQ
 /v9gdAxArjyGcAPzwjnfMioOLUGrHL1MpNWDlG7/hmt7IiL6XER6z/ciV A==;
X-CSE-ConnectionGUID: zHStq51TQB65jcpN9JyZWg==
X-CSE-MsgGUID: 8OfoJvRgS1eQgEOytaCZng==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39643591"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; d="scan'208";a="39643591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 14:56:50 -0800
X-CSE-ConnectionGUID: mHvWfbOrQm6Pw0xydGU6/w==
X-CSE-MsgGUID: bpFG+/lRTG6MNM+dx8896Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112246192"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa008.jf.intel.com with ESMTP; 06 Feb 2025 14:56:49 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Thu,  6 Feb 2025 14:53:04 -0800
Message-Id: <20250206225304.1739418-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
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

From: Dongwon Kim <dongwon.kim@intel.com>

This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
which causes some guest display corruption when gtk-gl-area
is used for GTK rendering (e.g. Wayland Compositor) possibly due to
simulataneous accesses on the guest frame buffer by host compositor
and the guest.

Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-gl-area.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2c9a0db425..9f7dc697f2 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -129,7 +129,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
         return;
     }
 
-- 
2.34.1


