Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C24C3ABD8
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOf2-0006Y0-Aj; Wed, 14 May 2025 22:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOf0-0006Rg-4b
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:26 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uFOex-0005hp-F9
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747277363; x=1778813363;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nQL7AbhEDORsemmTADCDOWS7p035Qry/aV1L5jbzG90=;
 b=KMHRSGmk9lSTCkA8jiYJQCh6r9fl1TBn4AXJBruy7f+NGSKZOEYaFpO8
 KKFlAtHkDQ4e5Xl8Tv6Bz6NElCaTr7/rZQZO1euRo+VlE0rMeO5s5k9PJ
 LeJpHq/cCma383iLsFwSAquZz1h8cYM5VaACnWBIvo8IDtjxXVQhV2G7s
 7I2BBP9NNNbYpuNWlAt4sQRzopbDagAb9VxTZKeU/ZQvp83I7kDj+qk2e
 +GNxU6xoz0VfFTCQHUjpzJkpzHu7ZlpGAveRCka6pHugqoiZglXSFV7aC
 IqYYPR36hA3mUwRifrlJ37Ii+03tgODl8o3GV1qsTlWNbRgxCwFVD9bWd A==;
X-CSE-ConnectionGUID: LZJVWwKlQSeRTJU0XX46eA==
X-CSE-MsgGUID: giWR+3rjQPKn5p8DgAdGoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="36819288"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="36819288"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
X-CSE-ConnectionGUID: bMubVbUBTfy9uNPWh0+sFA==
X-CSE-MsgGUID: RdB/ZhijQGSFwzCBZfDi7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; d="scan'208";a="142246642"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 19:49:19 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 0/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Wed, 14 May 2025 19:45:38 -0700
Message-ID: <20250515024734.758335-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

To address the limitation that this option is incompatible with
remote clients, this patch series adds an option to select a
preferred codec and also enable gl=on option for clients that
are connected via the network. In other words, with this option
enabled (and the below linked Spice series merged), it would be
possible to have Qemu share a dmabuf fd with Spice, which would
then forward it to a hardware or software based encoder and
eventually send the data associated with the fd to a client that
could be located on a different machine.

Essentially, this patch series provides a hardware accelerated,
opensource VDI option for users using Qemu and Spice by leveraging
the iGPU/dGPU on the host machine to encode the Guest FB via the
Gstreamer framework.

v3 -> v4 (suggestions from Marc-André):
- Add a new parameter to make max_refresh_rate configurable
- Have surface_gl_create_texture_from_fd() return bool after checking
  for errors
- Remove the check for PIXMAN_r5g6b5() in spice_gl_replace_fd_texture()
- Report errors in spice_gl_replace_fd_texture() when someting fails
- Use glGetError() correctly by adding an additional (dummy) call
  before checking for actual errors (Dmitry)
- Add a new patch to check fd values in egl_dmabuf_export_texture()
- Rebase on Qemu master

v2 -> v3:
- Check for errors after invoking glImportMemoryFdEXT() using
  glGetError() and report the error to user (Dmitry)

v1 -> v2:
- Replace the option name preferred-codec with video-codecs (Marc-André)
- Add a warning when an fd cannot be created from texture (Marc-André)
- Add a new patch to blit the scanout texture into a linear one to
  make it work with virgl
- Rebased and tested against the latest Spice master

Tested with the following Qemu parameters:
-device virtio-vga,max_outputs=1,xres=1920,yres=1080,blob=true
-spice port=3001,gl=on,disable-ticketing=on,video-codecs=gstreamer:h264

and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.

Associated Spice server MR (merged):
https://gitlab.freedesktop.org/spice/spice/-/merge_requests/229

---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Alex Bennée <alex.bennee@linaro.org>

Vivek Kasireddy (7):
  ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
  ui/spice: Add an option for users to provide a preferred codec
  ui/spice: Enable gl=on option for non-local or remote clients
  ui/spice: Add an option to submit gl_draw requests at fixed rate
  ui/console-gl: Add a helper to create a texture with linear memory
    layout
  ui/spice: Create a new texture with linear layout when gl=on is
    enabled
  ui/spice: Blit the scanout texture if its memory layout is not linear

 include/ui/console.h       |   2 +
 include/ui/spice-display.h |   5 +
 qemu-options.hx            |  10 ++
 ui/console-gl.c            |  32 ++++++
 ui/egl-helpers.c           |   6 ++
 ui/spice-core.c            |  27 +++++
 ui/spice-display.c         | 212 ++++++++++++++++++++++++++++++++++---
 7 files changed, 278 insertions(+), 16 deletions(-)

-- 
2.49.0


