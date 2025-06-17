Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4769DC7114A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 04:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5f-0002pX-1O; Tue, 17 Jun 2025 00:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5d-0002pL-Ni
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:29 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5a-0007jV-EN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135107; x=1781671107;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=I+dHJkRqnK7RdWj8Yy0ZciU0L8tdHQE03w6f0mO2YGs=;
 b=Gkz3pBdmHqb3dY7jFY/76UiUptz7+MS0cPkoljpJ40ASv4qBaQN8ftpI
 M9LNyIOMX60IpE/dZk6I6pPkG29TmA6kyLqYoSiEUL5TD1j1rJTTDql/N
 By7/KFGyUThyCHLj2BkzYMkKTXW301p+1QKN1skFeGERAAmf09Vw0MQhh
 m3Jz8CiCU6wbhrY8bZD5+O8LFrHZ8vTIfW34lq6k+grsR97vHPrIwiig7
 saJ7LzhNpiF30N1A11Ub/gXpdwyQsehFDkOHVCdLNlPckKUc4MxXw63RD
 jvX+dZDtGOMd+3MEVl1zG2r+Eu4dWOK7eRESy7tOULJgE3IfTaEqbVuJk A==;
X-CSE-ConnectionGUID: afycRTjHQ+iMcb0Mj0+5mQ==
X-CSE-MsgGUID: F6yh9N44QYicli9VSwhNRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432271"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432271"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:22 -0700
X-CSE-ConnectionGUID: oiTDxJNDRR2hVN/a9Q1z2g==
X-CSE-MsgGUID: UAcfWlyVTk6jf/8Q+kJJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551026"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:21 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,
 Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 0/7] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Mon, 16 Jun 2025 21:32:24 -0700
Message-ID: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
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

v5 -> v6:
- Collect Marc-André's RB tag
- Instead of having the user provide both encoder and codec options,
  just have a single option to collect the preferred codec that
  would only be used with the Gstreamer encoder (Daniel)
- Use gstreamer:h264 as the default codec if the user did not provide
  any codecs and if gl=on is enabled

v4 -> v5 (suggestions from Marc-André):
- Fix the errors (mostly 80 chars limit violations) identified by
  scripts/checkpatch.pl
- Rename the globals to have a spice_ prefix for consistency
- Rename MAX_REFRESH_RATE to DEFAULT_MAX_REFRESH_RATE
- Added comments to explain how/when the gl_draw request is submitted
  to spice server in the remote clients case
- Fix the mem_obj leak that would occur when the associated texture
  is destroyed or when an error is encountered while creating a
  texture from an fd (Dmitry and Michael)
- Merged Michael's patch to fix the mem_obj leak into this series and
  added his Co-developed-by tag to the relevant patches

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
Cc: Daniel P. Berrangé <berrange@redhat.com>

Vivek Kasireddy (7):
  ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
  ui/spice: Enable gl=on option for non-local or remote clients
  ui/spice: Add an option for users to provide a preferred video codec
  ui/spice: Add an option to submit gl_draw requests at fixed rate
  ui/console-gl: Add a helper to create a texture with linear memory
    layout
  ui/spice: Create a new texture with linear layout when gl=on is
    specified
  ui/spice: Blit the scanout texture if its memory layout is not linear

 include/ui/console.h       |   3 +
 include/ui/spice-display.h |   5 +
 include/ui/surface.h       |   1 +
 qemu-options.hx            |  13 +++
 ui/console-gl.c            |  54 +++++++++
 ui/egl-helpers.c           |   6 +
 ui/spice-core.c            |  31 +++++
 ui/spice-display.c         | 226 ++++++++++++++++++++++++++++++++++---
 8 files changed, 323 insertions(+), 16 deletions(-)

-- 
2.49.0


