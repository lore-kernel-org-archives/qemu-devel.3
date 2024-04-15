Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F72EC00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 23:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwVUG-0004iY-QC; Mon, 15 Apr 2024 19:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwVUC-0004iE-0r
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 19:11:41 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwVU9-0004QK-GX
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 19:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713222697; x=1744758697;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oA97uoLFIG4YNBofuSYlUCZtF7Xgrry/BcznABh7n/E=;
 b=KXdoll1zmMXsCaHb4WDPxX1mWGk82JttA1itwxAIadlA4AX84PQOXrdp
 aPr9WI2jveHdo5d75i92qo0MtjZ75vqBK0mbHK/0svMMVxZWp4sFxDB8y
 ZjETGhBF215dO6HL93fD6JAHyo9Hf1uECpshKgIm1nSgXBJorqZ/zWNSe
 2ctfBmQXFZjNfdfQxPC6rH/NtDCFFRg/+IFYca9F+ktMyelsmmkbi53Im
 1jUdmVOVTjFQbfzpn1imH9ZxwZmr3ij32k2tHv0jkssIj7KqwpGQhX0jS
 08AqdaIeEkG42QGOVuXWozMAa9xkAbg9FfHDGbLzuC23vPM6R9k3uo2gB w==;
X-CSE-ConnectionGUID: W45FS5+gQpKnjWM1UI/+MQ==
X-CSE-MsgGUID: R7PrmhEGT9eLy9plC0ioIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19242736"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; d="scan'208";a="19242736"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 16:11:34 -0700
X-CSE-ConnectionGUID: sZl1p9oNR/WOeO1PE9r5Xg==
X-CSE-MsgGUID: ermwUZulSBqQhDnhJTFx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; d="scan'208";a="26726943"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa004.fm.intel.com with ESMTP; 15 Apr 2024 16:11:35 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v5 0/3] ui/console: Private QemuDmaBuf struct
Date: Mon, 15 Apr 2024 16:07:21 -0700
Message-Id: <20240415230724.9573-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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


