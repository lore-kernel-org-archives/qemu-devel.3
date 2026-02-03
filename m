Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC58E8305C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAu7-0007QD-VT; Tue, 03 Feb 2026 02:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAu3-0007LP-AD
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:51 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vnAu0-0006Ca-GL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770103968; x=1801639968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X8bbVuNMXC8vykTe65Rw/x/WDTflG92gptyM4eDsVm8=;
 b=FKwHIB16aKEisXEuH6hHA3P6KQ9S+9JaWF77sJaIiF8xd3NttUiCezxd
 upkyQ2OewHSPOipnhsBYFhaf5iK7+sHptl9WX0qDnVQeb1dqthyy3cbIk
 OqUsE+JapdfEnXjFbKLkONqw1ptWFtvwEtXlzthNYgC0+5FPwfJExdt6s
 VY9yvFhBkHlOF8sbx7IeZ9hwvdFhTecozEq2Za1YE8erh9w7ebMfOISgx
 P7HtrtzTvRQDSXtVxabQGWF62N0DGQeqHttApi5dfHZbPZtGOEvIHdznT
 UJNuFt7Mk3XzZvBEwYVc17qDgHVWqO2De3Br2vH9q7/0NqRD6BB/RrudD Q==;
X-CSE-ConnectionGUID: wC+6mf9NSxSA0mjBapmqfA==
X-CSE-MsgGUID: 8ABG7TwXSxKgaNWRbK7dgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="82640922"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="82640922"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:37 -0800
X-CSE-ConnectionGUID: j5BXF9GyTaG6fvxYV9hHNw==
X-CSE-MsgGUID: qHlbABp0TRelZhCVvTN/Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; d="scan'208";a="247373111"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2026 23:32:37 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 09/12] vfio/device: Add a helper to lookup VFIODevice from
 memory region
Date: Mon,  2 Feb 2026 23:30:16 -0800
Message-ID: <20260203073200.848183-10-vivek.kasireddy@intel.com>
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

Instead of iterating over all QOM devices to find the VFIODevice
associated with a memory region, it is faster to just use the
vfio_device_list to lookup the VFIODevice.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..ecb3581fcc 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -644,3 +644,26 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
 };
+
+static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
+                               Error **errp)
+{
+    VFIODevice *vbasedev;
+    RAMBlock *first_rb;
+    ram_addr_t offset;
+
+    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
+    if (!first_rb) {
+        error_setg(errp, "Could not find first ramblock\n");
+        return false;
+    }
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev == first_rb->mr->dev) {
+            *vbasedevp = vbasedev;
+            return true;
+        }
+    }
+    error_setg(errp, "No VFIO device found to create dmabuf from\n");
+    return false;
+}
-- 
2.50.1


