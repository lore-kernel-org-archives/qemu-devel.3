Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB54C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 02:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz5sU-0002gX-29; Mon, 22 Apr 2024 22:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sR-0002g8-TJ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:23 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rz5sL-00034P-JJ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 22:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713839237; x=1745375237;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TZ4Rcq+b/U50SC5LMVI/ZIHtb4OkWd+cRz5+Y/HBUAc=;
 b=eykRr6VdFt0P0pxJ8qmMGAgmHP8JqepHK+7uhJscIS8JV2X5ME9aV7Ts
 p2lCJNM1SxDw/AfDcf0H/Sjlkh6FPNRUVN99ibVprIjjHkTBxantLTyc1
 qApRNFQrqRXD70cTv8EEcUxnaKKjPNf88uEDdLH5E+DNfhViCf4LpnAij
 sBYNq9YRCYgALQ4Ek5i8mAg40XnAozrgtpXel798l6dyrwMO/PuP0uI8r
 cjciTjAkaG24n3uB68o9EL0J/cFUbCVbV4WXIgFpO1MCMS5BE4Js5UDaO
 9ck7jFOYGyeUyaqd2S/kOPgCfD7FijFi7jroPcXnsyvLjakXwGLe9xvLo Q==;
X-CSE-ConnectionGUID: qFDLKRGaQsCYSblppW9o7w==
X-CSE-MsgGUID: HdEFRi2lRs+/xj7Uh7IOXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26920033"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="26920033"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 19:27:12 -0700
X-CSE-ConnectionGUID: 9m8Bp3IvRxOTnPSC+vHrPQ==
X-CSE-MsgGUID: pHAPlGwoTvKZUd/VSOC+Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; d="scan'208";a="29009367"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa005.jf.intel.com with ESMTP; 22 Apr 2024 19:27:12 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	berrange@redhat.com,
	philmd@linaro.org
Subject: [PATCH v10 0/6] ui/console: Private QemuDmaBuf struct
Date: Mon, 22 Apr 2024 19:22:47 -0700
Message-Id: <20240423022253.1003295-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
 include/ui/dmabuf.h             |  47 ++++++++
 hw/display/vhost-user-gpu.c     |  32 +++--
 hw/display/virtio-gpu-udmabuf.c |  27 ++---
 hw/vfio/display.c               |  35 +++---
 ui/console.c                    |   4 +-
 ui/dbus-console.c               |   9 +-
 ui/dbus-listener.c              |  71 ++++++-----
 ui/dmabuf.c                     | 208 ++++++++++++++++++++++++++++++++
 ui/egl-headless.c               |  23 ++--
 ui/egl-helpers.c                |  59 +++++----
 ui/gtk-egl.c                    |  52 +++++---
 ui/gtk-gl-area.c                |  41 ++++---
 ui/gtk.c                        |  12 +-
 ui/spice-display.c              |  50 ++++----
 ui/meson.build                  |   1 +
 18 files changed, 505 insertions(+), 192 deletions(-)
 create mode 100644 include/ui/dmabuf.h
 create mode 100644 ui/dmabuf.c

-- 
2.34.1


