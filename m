Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A83C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 17:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tizEg-0005JA-D1; Fri, 14 Feb 2025 12:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tizEd-0005Ie-Un
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:12:16 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1tizEb-00013I-2o
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 12:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739553133; x=1771089133;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Owxe539c8/NPNVCeBaNuhsnyk4TAdK3I07Vnra6HODY=;
 b=fTjMgLW9Tdbq0RT0E9wtvNy4YxFbUiyMzunBvTBfp8jIKka2lzcsivm4
 ALSkxOt8MLruvWm/yAmiW3Uodi8MQOa3S56I2FTCFskTTw+WHrN2ZaCx4
 vLd/7wHtaEEaFR9IqlNzuOMR+PwX8xbDet4ZU8seqSAACjr0HRSF5eQq1
 BwZyC8TDQyM70bQKTRAmCSbL/s4/eU7UhJzlbXXI+rtwnR2G26qMcEXBH
 wfU9b8qy5V2I0LdlZVgaSvWO0Gw6HtvGRU7RHF+h6qQkbddSR2H9rfiWy
 +gWW8vuxisCUnj/Ae/hs18vd4pNT62x0L9xmwkUoKUq2jdguK83Jiueih w==;
X-CSE-ConnectionGUID: 833QVL3VTpKbdpbISuTpCQ==
X-CSE-MsgGUID: emJFP+X9QJqxBlqEp5TppQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50938532"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; d="scan'208";a="50938532"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2025 09:12:08 -0800
X-CSE-ConnectionGUID: IhAU9kNwRMWUEaTut+38RA==
X-CSE-MsgGUID: O9mOJuoOQNmsx4GqVbvAUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; d="scan'208";a="144360578"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 09:12:08 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] ui/gtk-gl-area: Remove extra draw call in refresh
Date: Fri, 14 Feb 2025 09:08:13 -0800
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206225304.1739418-1-dongwon.kim@intel.com>
References: <20250206225304.1739418-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
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

v2: Added "Fixes" tag

Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
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


