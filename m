Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58071C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOkY7-0004xd-BX; Tue, 02 Jul 2024 16:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOkY4-0004wP-I2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:56:24 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sOkY2-0001GC-PD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719953782; x=1751489782;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=3vwg8wmA5DCsngLhZ8wHvJDzQzDYML4wcP8YeufEq3E=;
 b=PN0fJMlDm95396RoPCV11xFpeqIvBBXl7EjkNQ0MKc1fHqNaVW16UgSN
 2XHhZD6xbTjGFlZklFw/tiTPvok+AtQ/04Xo5XGy08NzCP4TgCqsEXEsL
 bOnzU2Cw3BKWEW9Wt06jCqfTFCjFz9d7iLi8eg04/V39ApXg6WcOEbpb/
 bbaI4E+0rbw3kNhEGSPXOPXV/P0wt6M3kpHOKR6g9dKkhqyKpjE9qdb5i
 1uHOQkZT5G2GgPJFcFGbSOVHmTHkp1LNEZMaGABlhreob5LsWKbGquuS7
 GcQhFtk+tGpZR+kVYKuVsI/Bb//1JCap9LxCN7WyM2Yxt0SRAOPcsccJ4 Q==;
X-CSE-ConnectionGUID: IdfNQ06MRlyeI2z+/Rh69Q==
X-CSE-MsgGUID: tmywFvQ7RrSN95PD6wWesw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28549753"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; d="scan'208";a="28549753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 13:56:16 -0700
X-CSE-ConnectionGUID: evh9ibklTee6XKoQoRuG+g==
X-CSE-MsgGUID: cocdOU6NQ4CQkEEG7dYktQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; d="scan'208";a="46085791"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa010.fm.intel.com with ESMTP; 02 Jul 2024 13:56:16 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] ui/dmabuf: Remove 'sync' from QemuDmaBuf struct
Date: Tue,  2 Jul 2024 13:55:03 -0700
Message-Id: <20240702205503.2774745-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702205503.2774745-1-dongwon.kim@intel.com>
References: <20240702205503.2774745-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Sync object is not used so removing it from QemuDmaBuf struct

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/dmabuf.h |  2 --
 ui/dmabuf.c         | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
index dc74ba895a..7f0f7f3f6e 100644
--- a/include/ui/dmabuf.h
+++ b/include/ui/dmabuf.h
@@ -36,13 +36,11 @@ uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
 uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
 int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
 bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
 void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
 void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
 void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
 void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
 
diff --git a/ui/dmabuf.c b/ui/dmabuf.c
index df7a09703f..2332292a08 100644
--- a/ui/dmabuf.c
+++ b/ui/dmabuf.c
@@ -23,7 +23,6 @@ struct QemuDmaBuf {
     uint32_t  backing_width;
     uint32_t  backing_height;
     bool      y0_top;
-    void      *sync;
     int       fence_fd;
     bool      allow_fences;
     bool      draw_submitted;
@@ -170,13 +169,6 @@ bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
     return dmabuf->y0_top;
 }
 
-void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
-{
-    assert(dmabuf != NULL);
-
-    return dmabuf->sync;
-}
-
 int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
 {
     assert(dmabuf != NULL);
@@ -210,12 +202,6 @@ void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
     dmabuf->fence_fd = fence_fd;
 }
 
-void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
-{
-    assert(dmabuf != NULL);
-    dmabuf->sync = sync;
-}
-
 void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
 {
     assert(dmabuf != NULL);
-- 
2.34.1


