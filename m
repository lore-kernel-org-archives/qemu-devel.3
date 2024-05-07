Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1266DC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4PmJ-0005GN-Ad; Tue, 07 May 2024 14:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmH-0005GA-E5
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:01 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmE-0005KM-7F
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715107378; x=1746643378;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=f9xRJwLJsFiDTL2lMB5EUJl8SAvalH+AsTPRpIokTCM=;
 b=fTqUc6Of8IjtPq/GYC9OLIRwqd/z+gkWCSNW5jUvvzrjVbVDbd90yMn2
 U+Thcf2j26HT7Im/ZD59E+4MW78JCTRD/jQbWuY6DcGpM1G3zFepJEHgi
 VA6xbXTY6u4Avs59AhYz8dPqpWwBPtYLuJQ6ssKmr8pQh5RoJkVmImQ0E
 DXCElGaqTv9pxa3l4eQCY61QhIisdPuSYtpsDwfI5/ctA4SVgQgMFtD6A
 C5UDSXkMQDKs+jTmn/JHQNkj7rN4EKFBY9aCpF3UjRXypWhWxWMt/MNRI
 CxRsvyeIpXiIUECMxjOA+xYPKqgxfxJf3ysv1kavzqxe61eEKAXZFmU1i Q==;
X-CSE-ConnectionGUID: 4nNnkz+6QSa8eOvjHMn04w==
X-CSE-MsgGUID: gm7UUS4WT+meCPSlEujxfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22321485"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="22321485"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 11:42:55 -0700
X-CSE-ConnectionGUID: sRNfJU5wQkqhx4qWlMdrhQ==
X-CSE-MsgGUID: DHFVcrBUTq+3k8MEcWA2JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="29031350"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa006.jf.intel.com with ESMTP; 07 May 2024 11:42:55 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v13 0/6] ui/console: Private QemuDmaBuf struct
Date: Tue,  7 May 2024 11:37:51 -0700
Message-Id: <20240507183757.3383641-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

From: Your Name <you@example.com>

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

v8: Introduce new dmabuf.c and dmabuf.h and all helper functions in the second
    patch in the series (ui/console: new dmabuf.h and dmabuf.c for QemuDma....)
    (Philippe Mathieu-Daudé <philmd@linaro.org>)

v9: set dmabuf->allow_fences true when it is created in virtio-gpu-udmabuf

    removed unnecessary spaces were added in the patch,
    'ui/console: Use qemu_dmabuf_new() a...'

v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
     GPL to be in line with QEMU's default license
     (Daniel P. Berrangé <berrange@redhat.com>)

v11: New helpers added - qemu_dmabuf_dup_fd, qemu_dmabuf_close for duplicating
     and closing dmabuf->fd. And use them in places where applicable.
     (Daniel P. Berrangé <berrange@redhat.com>)

     qemu_dmabuf_free helper now close dmabuf->fd before freeing the struct to
     prevent any potential leakage (This eliminates the need for
     qemu_dmabuf_close in several places as qemu_dmabuf_close is done anyway.)
     (Daniel P. Berrangé <berrange@redhat.com>)

v12: --- qemu_dmabuf_free does not include qemu_dmabuf_close as there are cases
         where fd still needs to be used even after QemuDmaBuf struct is
         destroyed (virtio-gpu: res->dmabuf_fd)

     --- 'dmabuf' is now allocated space so it should be freed at the end of
         dbus_scanout_texture

v13: --- Immediately free dmabuf after it is released to prevent possible
         leaking of the ptr
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

     --- Use g_autoptr macro to define *dmabuf for auto clean up instead of
         calling qemu_dmabuf_free
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

Dongwon Kim (6):
  ui/gtk: Check if fence_fd is equal to or greater than 0
  ui/console: new dmabuf.h and dmabuf.c for QemuDmaBuf struct and
    helpers
  ui/console: Use qemu_dmabuf_get_..() helpers instead
  ui/console: Use qemu_dmabuf_set_..() helpers instead
  ui/console: Use qemu_dmabuf_new() and free() helpers instead
  ui/console: move QemuDmaBuf struct def to dmabuf.c

 include/hw/vfio/vfio-common.h   |   2 +-
 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/console.h            |  20 +--
 include/ui/dmabuf.h             |  49 +++++++
 hw/display/vhost-user-gpu.c     |  26 ++--
 hw/display/virtio-gpu-udmabuf.c |  27 ++--
 hw/vfio/display.c               |  32 ++---
 ui/console.c                    |   4 +-
 ui/dbus-console.c               |   9 +-
 ui/dbus-listener.c              |  71 +++++-----
 ui/dmabuf.c                     | 229 ++++++++++++++++++++++++++++++++
 ui/egl-headless.c               |  23 +++-
 ui/egl-helpers.c                |  59 ++++----
 ui/gtk-egl.c                    |  52 +++++---
 ui/gtk-gl-area.c                |  41 ++++--
 ui/gtk.c                        |  12 +-
 ui/spice-display.c              |  50 ++++---
 ui/meson.build                  |   1 +
 18 files changed, 518 insertions(+), 193 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.34.1


