Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A4BC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKR38-0003xX-2t; Thu, 20 Jun 2024 19:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR36-0003xM-Da
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:36 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR33-0001h8-KR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718925514; x=1750461514;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cfovPrMmAbQv8m6x+P1xeV4rPLUwzYgIQK0B5J//SHo=;
 b=OiYF3h6cq91gYeSkufGOsJEUhfvyMyhbSFviN8Hv8/YytM8Sj8d9c+31
 DpYYwlzInZhc/M/JlWxLIHR+4hvs9V8wA3pjTYBtnjUTTIpLn1dR66ore
 8RqR8cuIzZ0nJn/84nNiijepNku6ZE8kPSrY3W33Bs7H0gYxBvd3hNndt
 UtGf1iveM5NP81E8tLLiFQKKifWweOSk6N+eZlF4DrOwes/75QaZUr8RQ
 AVcuv9T0t2i3Kt8PMD7PabK1VHyftwiMAdz6ZMzSMgGX23AZHgHvz9XD7
 q/LwCsXzaxkALC8W/I6lwchPZ7KdYKBriaUrguVTMm3vjAtfly1W1JvXY w==;
X-CSE-ConnectionGUID: DZXEtHInSKGai9w7HTeDPA==
X-CSE-MsgGUID: PJJEceAxQRyc/UnJ9JS7mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33482964"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="33482964"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 16:18:29 -0700
X-CSE-ConnectionGUID: SXuaR1GXTaW72VkeW9bA8A==
X-CSE-MsgGUID: E87QS2gaQVGVQqb8Esevww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="42359628"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 16:18:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/4] hw/display/virtio-gpu: Introducing asynchronous guest
 display render
Date: Thu, 20 Jun 2024 16:17:23 -0700
Message-Id: <20240620231727.235841-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Introducing new virtio-gpu param, 'render_sync' when guest scanout blob
is used (blob=true). The new param is used to specify when to start
rendering a guest scanout frame.

By default (and so far) rendering of the guest frame is started in
the draw event to make sure guest display update is sychronized with
host's vsync. But this method inevitably brings some extra wait because
most of time, the draw event is not happening right after the guest
scanout frame is flushed.

This delay often makes the guest stuck at certain frame for too long and
causes general performance degradation of graphic workloads on the guest's
side especially when the display update rate is high. This unwanted perf
drop can be reduced if the guest scanout frame is rendered as soon as it is
flushed through 'VIRTIO_GPU_CMD_RESOURCE_FLUSH' msg. The gl display
pipeline can be unblocked a lot earlier in this case so that guest can
move to the next display frame right away.

However, this "asynchrounous" render mode may cause some waste of resources
as the guest could produce more frames than what are actually displayed
on the host display. This is similar as running rendering apps with no vblank
or vsync option. This is why this feature should stay as optional.

The param 'render_sync' is set to 'true' by default and this is in line
with traditional way while setting it to 'false' is basically enabling
this asynchronouse mode.

Dongwon Kim (4):
  hw/display/virtio-gpu: Introducing render_sync param
  ui/egl-helpers: Consolidates create-sync and create-fence
  ui/gtk-egl: Start rendering of guest blob scanout if render_sync is
    off
  ui/gtk-gl-draw: Start rendering of guest blob scanout if render_sync
    is off

 include/hw/virtio/virtio-gpu.h  |  3 ++
 include/ui/dmabuf.h             |  4 +-
 include/ui/egl-helpers.h        |  3 +-
 hw/display/vhost-user-gpu.c     |  3 +-
 hw/display/virtio-gpu-udmabuf.c |  3 +-
 hw/display/virtio-gpu.c         |  2 +
 hw/vfio/display.c               |  3 +-
 ui/dbus-listener.c              |  2 +-
 ui/dmabuf.c                     | 11 +++-
 ui/egl-helpers.c                | 27 ++++------
 ui/gtk-egl.c                    | 93 ++++++++++++++++++---------------
 ui/gtk-gl-area.c                | 90 +++++++++++++++++++------------
 12 files changed, 146 insertions(+), 98 deletions(-)

-- 
2.34.1


