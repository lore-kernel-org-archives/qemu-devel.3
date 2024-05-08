Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC116C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 18:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lZT-0005rX-Io; Wed, 08 May 2024 13:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZQ-0005pC-QA
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:12 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4lZM-0002rt-NJ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715191149; x=1746727149;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KwhRNbYOH0yc+Xp7vRr20wWnhTCo9O6FnDllrMs7fVo=;
 b=dX4c32eKEFkNpyZAvTnuv/ej9JPdXi7sEQ6MzQsDvZeSTAChI6p70gEc
 j6yRbNoUM8o25/H4H1kTFptrtH0fukbh004VPzrLytVJsexD9hmgc0Q4C
 QfHVAYH+m6VjV4Alxes60cigqv9ca/JsT/GIBtLKDsZMwBgab8hyikByc
 EbZyq5IZ420ODBttPSEkn9sJ3dXcjVLXGvlu3wbJ3MpY2dZsOqvZcp5Hj
 WC7IzCQTNqnLNAGTDU67s0wq2wnyAaIrlFVGCzrYeGLH/6R1pcN/7T4Lu
 3ubi7HHJqcJYPZaYGcVRz5YzCmiwwXvH2JuUuq/37sDVgjdNB7ZJakDpP A==;
X-CSE-ConnectionGUID: /stMf1IGS8uhmQaOhuLouA==
X-CSE-MsgGUID: 7ZnRLwYbSaOhxvtf3+FFyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14887673"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="14887673"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 10:59:02 -0700
X-CSE-ConnectionGUID: KIv/69EqQvG5iDT95R+72A==
X-CSE-MsgGUID: ecQP4kSkRlCWpCgzsYaqEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; d="scan'208";a="29541298"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa008.jf.intel.com with ESMTP; 08 May 2024 10:59:01 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v14 0/6] ui/console: Private QemuDmaBuf struct
Date: Wed,  8 May 2024 10:53:57 -0700
Message-Id: <20240508175403.3399895-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
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

v13: --- Immediately free dmabuf after it is released to prevent possible
         leaking of the ptr
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

     --- Use g_autoptr macro to define *dmabuf for auto clean up instead of
         calling qemu_dmabuf_free
         (Marc-André Lureau <marcandre.lureau@redhat.com>)

v14: In ui/console: Use qemu_dmabuf_new() and free() helpers instead

     --- (vhost-user-gpu) Change qemu_dmabuf_free back to g_clear_pointer
         as it was done because of some misunderstanding (v13).

     --- (vhost-user-gpu) g->dmabuf[m->scanout_id] needs to be set to NULL
         to prevent freed dmabuf to be accessed again in case if(fd==-1)break;
         happens (before new dmabuf is allocated). Otherwise, it would cause
         invalid memory access when the same function is executed. Also NULL
         check should be done before qemu_dmabuf_close (it asserts dmabuf!=NULL.).
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
 hw/display/vhost-user-gpu.c     |  32 +++--
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
 18 files changed, 524 insertions(+), 193 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.34.1


