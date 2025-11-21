Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB099CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcql-0005Tr-Lr; Fri, 21 Nov 2025 20:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbmt-0001Ql-Lo; Fri, 21 Nov 2025 19:47:39 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMbmi-0008An-7T; Fri, 21 Nov 2025 19:47:35 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3949116CA73;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E82DD321CAF;
 Fri, 21 Nov 2025 21:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 56/81] hw/display/xlnx_dp: Don't abort for unsupported
 graphics formats
Date: Fri, 21 Nov 2025 21:43:55 +0300
Message-ID: <20251121184424.1137669-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Peter Maydell <peter.maydell@linaro.org>

If the guest writes an invalid or unsupported value to the
AV_BUF_FORMAT register, currently we abort().  Instead, log this as
either a guest error or an unimplemented error and continue.

The existing code treats DP_NL_VID_CB_Y0_CR_Y1 as x8b8g8r8
via a "case 0" that does not use the enum constant name for some
reason; we leave that alone beyond adding a comment about the
weird code.

Documentation of this register seems to be at:
https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/AV_BUF_FORMAT-DISPLAY_PORT-Register

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1415
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251106145209.1083998-3-peter.maydell@linaro.org
(cherry picked from commit 032333eba77b83dfbd74071cc2971f0bda9a3d4f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 1ca7ab860d..6fd5601635 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -665,14 +665,28 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
     case DP_GRAPHIC_BGR888:
         s->g_plane.format = PIXMAN_b8g8r8;
         break;
+    case DP_GRAPHIC_RGBA5551:
+    case DP_GRAPHIC_RGBA4444:
+    case DP_GRAPHIC_8BPP:
+    case DP_GRAPHIC_4BPP:
+    case DP_GRAPHIC_2BPP:
+    case DP_GRAPHIC_1BPP:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented graphic format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        s->g_plane.format = PIXMAN_r8g8b8a8;
+        break;
     default:
-        error_report("%s: unsupported graphic format %u", __func__,
-                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
-        abort();
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid graphic format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        s->g_plane.format = PIXMAN_r8g8b8a8;
+        break;
     }
 
     switch (s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK) {
     case 0:
+        /* This is DP_NL_VID_CB_Y0_CR_Y1 ??? */
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
     case DP_NL_VID_Y0_CB_Y1_CR:
@@ -681,10 +695,39 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
     case DP_NL_VID_RGBA8880:
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
+    case DP_NL_VID_CR_Y0_CB_Y1:
+    case DP_NL_VID_Y0_CR_Y1_CB:
+    case DP_NL_VID_YV16:
+    case DP_NL_VID_YV24:
+    case DP_NL_VID_YV16CL:
+    case DP_NL_VID_MONO:
+    case DP_NL_VID_YV16CL2:
+    case DP_NL_VID_YUV444:
+    case DP_NL_VID_RGB888:
+    case DP_NL_VID_RGB888_10BPC:
+    case DP_NL_VID_YUV444_10BPC:
+    case DP_NL_VID_YV16CL2_10BPC:
+    case DP_NL_VID_YV16CL_10BPC:
+    case DP_NL_VID_YV16_10BPC:
+    case DP_NL_VID_YV24_10BPC:
+    case DP_NL_VID_Y_ONLY_10BPC:
+    case DP_NL_VID_YV16_420:
+    case DP_NL_VID_YV16CL_420:
+    case DP_NL_VID_YV16CL2_420:
+    case DP_NL_VID_YV16_420_10BPC:
+    case DP_NL_VID_YV16CL_420_10BPC:
+    case DP_NL_VID_YV16CL2_420_10BPC:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented video format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        s->v_plane.format = PIXMAN_x8b8g8r8;
+        break;
     default:
-        error_report("%s: unsupported video format %u", __func__,
-                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
-        abort();
+        qemu_log_mask(LOG_UNIMP, "%s: invalid video format %u",
+                      __func__,
+                      s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        s->v_plane.format = PIXMAN_x8b8g8r8;
+        break;
     }
 
     xlnx_dp_recreate_surface(s);
-- 
2.47.3


