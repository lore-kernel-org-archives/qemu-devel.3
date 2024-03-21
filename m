Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02A6CD11DC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 23:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnS58-0007NV-H9; Thu, 21 Mar 2024 19:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS55-0007Ms-V8
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:20 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS53-0007iR-9E
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711064658; x=1742600658;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=o5eeZ5PjQ4guq5ek1JNXl3LG73Va+haATfQ26hcn+UE=;
 b=OJAg3h0J4Yo6mRkGbQAVS9OQq92Z1JDmTZUYdn01U0+dUCLseQ87YRk5
 qDemPkqVWoLUjG33OmUaGY85ZrzUmi0IK/gCz255rxEUe8ONJgC8q5QuW
 t9o1Y6sps9CCFqJpr70fYHXjm/8CHQJrnBj7KPXqqyjt4iYT6rg5B4ga/
 DHwAOGVgO0bHgxBpVjQ2j6s8RXxRtc8KiAws4lT6b/2AyohUw6Z9Ewun6
 A3fVBPoMqDydmCuv4pJdOyF+Vdvlwv6DG9fAtrgQtwl4lMcrFLUlbM9ME
 JpkmgB3eW+h7hT2yRRnmB0/RwJuZXM4RcthqmULrIjoqGUcMRSHCG6T4x w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6217222"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6217222"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 16:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="14743273"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa006.fm.intel.com with ESMTP; 21 Mar 2024 16:44:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH v4 0/3] ui/console: Introduce helpers for creating and
Date: Thu, 21 Mar 2024 16:42:33 -0700
Message-Id: <20240321234236.3476163-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

QemuDmaBuf struct is defined and primarily used by ui/console/gl so it is
better to handle its creation, initialization and access within ui/console
rather than within hw modules such as hw/display/virtio-gpu,
hw/display/vhost-user-gpu and hw/vfio as well as ui/dbus-listener.

v4: refactored patches in the previous series
    
    made ui/dbus-listener and hw/display/vhost-user-gpu to use the new
    helpers

Dongwon Kim (3):
  ui/console: Introduce dpy_gl_dmabuf_get_height/width() helpers
  ui/console: Introduce dpy_gl_dmabuf_get_fd() helper
  ui/console: Introduce dpy_gl_create_dmabuf() helper

 include/hw/vfio/vfio-common.h   |  2 +-
 include/hw/virtio/virtio-gpu.h  |  2 +-
 include/ui/console.h            |  9 ++++++
 hw/display/vhost-user-gpu.c     | 12 +++----
 hw/display/virtio-gpu-udmabuf.c | 26 ++++++----------
 hw/vfio/display.c               | 36 +++++++++++----------
 ui/console.c                    | 55 +++++++++++++++++++++++++++++++++
 ui/dbus-listener.c              | 22 ++++++-------
 8 files changed, 109 insertions(+), 55 deletions(-)

-- 
2.34.1


