Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FABC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwgZ-0007B7-JZ; Wed, 17 Apr 2024 00:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwwgX-0007Ag-8D
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:14:13 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwwgU-0006Id-Hi
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713327250; x=1744863250;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Qv/WIm7hCZH55zo85ivBbvXe6E7qyc2WvkjiZAtHKO0=;
 b=VUlBp5UvL3EyOMXOCL5A/l7jFmTzV471jL6CIwZAj8IEg+tiDZCtYLyz
 74E9Q1npcWJUUdNhZq+RhBa7RkoqS6LDrOE+rv2c1GDMbLOO8/+M0DIm5
 ZpUSbLyVHHHSTIeY7dhPOedwtDpdsfEPjBVPefjKNQWjeexXN5EpOjAmU
 jCuKj9n8S20464pojsep1qBpmx7/aegOTguDpmCQsyclcB2eVpHuVcBdt
 NX6T7fLGJ3TNCSJ7V4l7FRwHSyejTaM41sipsSwwY2EmSmE/d5A5cGAmF
 GhMxFLhwibOsO5yuJCkYoiieVIi0Ir1eqvv7IxUs1H4Z3p86v3NDRk9BB Q==;
X-CSE-ConnectionGUID: qHG2Gz8aRoyU0hR9JLxPyw==
X-CSE-MsgGUID: 9agh93xURzSqaAQVT4wdKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12582846"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="12582846"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 21:14:06 -0700
X-CSE-ConnectionGUID: dYhjzjyiSeyQXGmWX25gMA==
X-CSE-MsgGUID: Szb/li7RQ/qnL4TIgZwYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="22491570"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa009.jf.intel.com with ESMTP; 16 Apr 2024 21:14:06 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v6 0/3] ui/console: Private QemuDmaBuf struct
Date: Tue, 16 Apr 2024 21:09:51 -0700
Message-Id: <20240417040954.55641-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

This series introduces privacy enhancements to the QemuDmaBuf struct
and its contained data to bolster security. it accomplishes this by
introducing of helper functions for allocating, deallocating, and
accessing individual fields within the struct and replacing all direct
references to individual fields in the struct with methods using helpers
throughout the codebase.

This change was made based on a suggestion from Marc-André Lureau
<marcandre.lureau@redhat.com>

(Resumitting same patch series with this new cover-leter)

v6: fixed some typos in patch - 
    ui/console: Introduce dpy_gl_qemu_dmabuf_get_..() helpers)

Dongwon Kim (3):
  ui/console: Introduce dpy_gl_qemu_dmabuf_get_..() helpers
  ui/console: Introduce dpy_gl_qemu_dmabuf_set_..() helpers
  ui/console: Introduce dpy_gl_qemu_dmabuf_new() and free() helpers

 include/hw/vfio/vfio-common.h   |   2 +-
 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/console.h            |  28 +++++
 hw/display/vhost-user-gpu.c     |  32 +++---
 hw/display/virtio-gpu-udmabuf.c |  27 ++---
 hw/vfio/display.c               |  35 ++++---
 ui/console.c                    | 180 +++++++++++++++++++++++++++++++-
 ui/dbus-console.c               |   9 +-
 ui/dbus-listener.c              |  71 +++++++------
 ui/egl-headless.c               |  23 ++--
 ui/egl-helpers.c                |  59 ++++++-----
 ui/gtk-egl.c                    |  52 +++++----
 ui/gtk-gl-area.c                |  41 +++++---
 ui/gtk.c                        |   8 +-
 ui/spice-display.c              |  50 +++++----
 15 files changed, 449 insertions(+), 172 deletions(-)

-- 
2.34.1


