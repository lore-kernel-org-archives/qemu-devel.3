Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE73C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 01:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzoNJ-0000Ee-6B; Wed, 24 Apr 2024 21:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzoNF-0000Cn-J0
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 21:58:10 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rzoNC-0003SC-KR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 21:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714010286; x=1745546286;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NssENG/BLB+VQ8+Ug+hIIc9NuSReNpyZ4sH+DjGyHHw=;
 b=ETFK0Da7w/vZ9VvgSxxusgK0bRxCA9OdmPz1Bn3YEYdByFSOZR0PF5sz
 K2tX3EQkxqRS4Nbv5O2zwpRjAbqcJPn40VcQhN2s7SHrDHKFPeD/fQ7Xm
 zj10ZS49gneWz2R5uy7E0KOwVALWQziVk1skTNRmRPmdvhcTPGK/Fdc0A
 4I7OCvY1Y4+EFk9lSBxwKrqTjKs9kvQwy+BPPOfCbsDzjfw/tkqhDbdX/
 M8mM5/o5TwxQXF1ZOWfLgSJCl4ogoL+6HUgirhm/ti95Ys0po2Tk7Wy0d
 GQhAAEPK5nK1umd+4/wf8BCHDaseh3USD0MMfoUCdAM2IWqZpNwJk3PGc w==;
X-CSE-ConnectionGUID: hZdmcCEyQPubpBXCNaz43g==
X-CSE-MsgGUID: p9rWj/QcTpOcC27jsx5CqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9890067"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9890067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 18:58:02 -0700
X-CSE-ConnectionGUID: tcq2GxEIT3O5XK8/K3P4gw==
X-CSE-MsgGUID: gbRx3wSYQq+49D8b3a1Xaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; d="scan'208";a="24914182"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa009.fm.intel.com with ESMTP; 24 Apr 2024 18:58:03 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v12 0/6] ui/console: Private QemuDmaBuf struct
Date: Wed, 24 Apr 2024 18:53:36 -0700
Message-Id: <20240425015342.1033815-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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
 ui/dbus-listener.c              |  72 +++++-----
 ui/dmabuf.c                     | 229 ++++++++++++++++++++++++++++++++
 ui/egl-headless.c               |  23 +++-
 ui/egl-helpers.c                |  59 ++++----
 ui/gtk-egl.c                    |  52 +++++---
 ui/gtk-gl-area.c                |  41 ++++--
 ui/gtk.c                        |  12 +-
 ui/spice-display.c              |  50 ++++---
 ui/meson.build                  |   1 +
 18 files changed, 519 insertions(+), 193 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.34.1


