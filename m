Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7BAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 22:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxZxD-0001Me-4a; Thu, 18 Apr 2024 18:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZxB-0001M6-Fa
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:01 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rxZx8-0001zY-QQ
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 18:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713478199; x=1745014199;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zMo+V3IpXArcnXconZhIycHEkykSIGGhGGouKONu9co=;
 b=FVdHZkY+OROn2Lfi8j2kmXA+hnzQxQakcfV1zP829jtGsQK8zziR8JPV
 7DV4agMYBXx0/f8LiaWlDzLuSGexQRuMlOfvtLaJwMR1qo30OurVKwox/
 u/2Sn9nZMmieqgbrJ/WxwMaBLs0biADY3lMmNSxZBPGtiSbC7oYIIDeby
 juw0DkXUJZO3CSi4TQd08tqEBoUdkSOA3nWc/sK1F3uAcnypkfBb0NKzV
 4AHMKY5ynzs9kfkJr1fJ2BOM0VrP4TIGMIexvrhJ8ioVgIq0qN09FNRaN
 /LiGenoXkhXcdx08sMdeFe9QMstfw3Jt6p2H6QqYDJH+kdnQ6m4H1dUuL g==;
X-CSE-ConnectionGUID: RdC5Wl8DQPCXJ9GAwWem5w==
X-CSE-MsgGUID: 0/j70ltHT5SlsQoMb/hHyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12002024"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="12002024"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Apr 2024 15:09:55 -0700
X-CSE-ConnectionGUID: HwrYUK8hSbKpsrIiZSUwSA==
X-CSE-MsgGUID: iI7btlQYQZmoNHbNCDFv6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; d="scan'208";a="60559327"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 15:09:55 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com
Subject: [PATCH v7 0/5] ui/console: Private QemuDmaBuf struct
Date: Thu, 18 Apr 2024 15:05:36 -0700
Message-Id: <20240418220541.931134-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

v7: included minor fix (ui/gtk: Check if fence_fd is equal to or greater than 0)
    (Marc-André Lureau <marcandre.lureau@redhat.com>)
    
    migrated all helpers and QemuDmaBuf struct into dmabuf.c and their prototypes
    to dmabuf.h for better encapsulation (ui/dmabuf: New dmabuf.c and dmabuf.h..)
    (Daniel P. Berrangé <berrange@redhat.com> and
     Marc-André Lureau <marcandre.lureau@redhat.com>)

    removed 'dpy_gl' from all helpers' names
    Defined autoptr clean up function for QemuDmaBuf*
    (Daniel P. Berrangé <berrange@redhat.com>)

    Minor corrections
    
Dongwon Kim (5):
  ui/gtk: Check if fence_fd is equal to or greater than 0
  ui/console: Introduce qemu_dmabuf_get_..() helpers
  ui/console: Introduce qemu_dmabuf_set_..() helpers
  ui/console: Introduce qemu_dmabuf_new() and free() helpers
  ui/dmabuf: New dmabuf.c and dmabuf.h for QemuDmaBuf struct and helpers

 include/hw/vfio/vfio-common.h   |   2 +-
 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/console.h            |  21 +--
 include/ui/dmabuf.h             |  38 ++++++
 hw/display/vhost-user-gpu.c     |  32 +++--
 hw/display/virtio-gpu-udmabuf.c |  27 ++--
 hw/vfio/display.c               |  35 ++---
 ui/console.c                    |   5 +-
 ui/dbus-console.c               |   9 +-
 ui/dbus-listener.c              |  71 +++++-----
 ui/dmabuf.c                     | 223 ++++++++++++++++++++++++++++++++
 ui/egl-headless.c               |  23 +++-
 ui/egl-helpers.c                |  59 +++++----
 ui/gtk-egl.c                    |  52 +++++---
 ui/gtk-gl-area.c                |  41 ++++--
 ui/gtk.c                        |  12 +-
 ui/spice-display.c              |  50 ++++---
 ui/meson.build                  |   1 +
 18 files changed, 512 insertions(+), 193 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.34.1


