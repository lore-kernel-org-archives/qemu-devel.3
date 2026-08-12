Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F33C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95nu-0004R1-11; Tue, 22 Sep 2026 15:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x95nk-0004Iu-NP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:05:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x95ni-0000Kh-23
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790103911; x=1821639911;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I10IjXrajxEoVnxsBoxWypiFCSvAVGXc2aq+h72n9S0=;
 b=Rc9jXX/NmDnfG/j7MYtsUhVqDVtHMqlghCnYhbNiz2CWv8uaTVTq7Qhd
 MVaV32GrZuqymy8MvK5ZNAlDQw1l+6ub2ZJ+I8IpGtjziI+3j+PrrrEqz
 dwQIAczAIggj8osZBDuWvU4oOeW7FJ6IIFWn3Sm4f/LawFDrPUj763u9K
 JJRorl3hfw+C1LCTczCbzBrYvYFPS/M6uc8fnOJeSPe3LHPlMX0ptC3y1
 P/xJuIdV8a22mTqzAfoV8RuNH+x1L9ID7FmXhsBDi/RNxNtHVi9Of+U6N
 8M/sxyTuKE6R91FzkvJ61T4Tr0x0QR0IrTV9yzP/xPeAUz2EZRU+fWPKF Q==;
X-CSE-ConnectionGUID: rU5fuSBXT/6OP5q48xBPSg==
X-CSE-MsgGUID: C2kov0LiT7Cbhj3TxnNc9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108239531"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="108239531"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 12:05:08 -0700
X-CSE-ConnectionGUID: bMaT9BJ4SZmgaGdWHoSgXg==
X-CSE-MsgGUID: slthk4FkQ1W6L2/hFfWm6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; d="scan'208";a="299517251"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.80.113.172])
 by fmviesa002.fm.intel.com with ESMTP; 22 Sep 2026 12:05:07 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/usb/host-libusb: Avoid assertion on invalid altsetting
Date: Wed, 12 Aug 2026 02:24:03 -0700
Message-Id: <20260812092403.37511-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Liang1 Yang <liang1.yang@intel.com>

Log warning and skip the interface instead of asserting in qemu
host-libusb when there is invalid altsetting index during fast
USB device hotplug/unplug.

This is to prevent guest vm from crashing which is caused by
QEMU task abort.

Signed-off-by: Liang1 Yang <liang1.yang@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/usb/host-libusb.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 629505c6d3..56cfc90f9b 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -884,10 +884,32 @@ static void usb_host_ep_update(USBHostDevice *s)
     if (rc != 0) {
         return;
     }
+
+    /* Log and skip if configuration is NULL or has no interfaces */
+    if (!conf || conf->bNumInterfaces == 0) {
+        warn_report("usb-host: ignoring invalid configuration "
+                    "for device %s (bus=%03d, addr=%03d)",
+                    udev->product_desc, s->bus_num, s->addr);
+
+        if (conf) {
+            libusb_free_config_descriptor(conf);
+        }
+
+        return;
+    }
+
     trace_usb_host_parse_config(s->bus_num, s->addr,
                                 conf->bConfigurationValue, true);
 
     for (i = 0; i < conf->bNumInterfaces; i++) {
+        if (conf->interface[i].num_altsetting == 0 ||
+            !conf->interface[i].altsetting) {
+            warn_report("usb-host: skipping interface (index %d) with no "
+                        "alternate settings on %s (bus=%03d, addr=%03d)",
+                        i, udev->product_desc, s->bus_num, s->addr);
+            continue;
+        }
+
         /*
          * The udev->altsetting array indexes alternate settings
          * by the interface number. Get the 0th alternate setting
@@ -897,8 +919,19 @@ static void usb_host_ep_update(USBHostDevice *s)
         intf = &conf->interface[i].altsetting[0];
         alt = udev->altsetting[intf->bInterfaceNumber];
 
-        if (alt != 0) {
-            assert(alt < conf->interface[i].num_altsetting);
+        if (alt > 0) {
+            if (alt >= conf->interface[i].num_altsetting) {
+                /*
+                 * libusb reports a temporary invalid altsetting index during
+                 * fast hotplug/unplug. Instead of aborting, log a warning and
+                 * skip the interface.
+                 */
+                warn_report("usb-host: ignoring out-of-bounds altsetting=%d "
+                            "for interface %d (index %d) on %s (bus=%03d, addr=%03d)",
+                            alt, intf->bInterfaceNumber, i,
+                            udev->product_desc, s->bus_num, s->addr);
+                continue;
+            }
             intf = &conf->interface[i].altsetting[alt];
         }
 
-- 
2.43.0


