Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06390CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd8p-0006Mt-5a; Fri, 21 Nov 2025 21:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcun-0000MY-3g; Fri, 21 Nov 2025 20:59:53 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMctH-00080E-Kh; Fri, 21 Nov 2025 20:59:48 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 09DFF16CA3D;
 Fri, 21 Nov 2025 21:44:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7FFED321C79;
 Fri, 21 Nov 2025 21:44:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dongwon Kim <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 02/81] ui/gtk-gl-area: Remove extra draw call in
 refresh
Date: Fri, 21 Nov 2025 21:43:01 +0300
Message-ID: <20251121184424.1137669-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Message-ID: <20251016150357.876415-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 0c6d6d79a5cbd538c6c0798b1068f37bfbbf9693)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index db93cd6204..ddb51efd5f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -137,7 +137,22 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     if (vc->gfx.guest_fb.dmabuf &&
         qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        gd_gl_area_draw(vc);
+        /*
+         * gd_egl_refresh() calls gd_egl_draw() if a DMA-BUF draw has already
+         * been submitted, but this function does not call gd_gl_area_draw() in
+         * such a case due to display corruption.
+         *
+         * Calling gd_gl_area_draw() is necessary to prevent a situation where
+         * there is a scheduled draw event but it won't happen bacause the window
+         * is currently in inactive state (minimized or tabified). If draw is not
+         * done for a long time, gl_block timeout and/or fence timeout (on the
+         * guest) will happen eventually.
+         *
+         * However, it is found that calling gd_gl_area_draw() here causes guest
+         * display corruption on a Wayland Compositor. The display corruption is
+         * more serious than the possible fence timeout so gd_gl_area_draw() is
+         * omitted for now.
+         */
         return;
     }
 
-- 
2.47.3


