Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45A2C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 06:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9eCl-0000cS-MZ; Tue, 29 Apr 2025 02:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCc-0000YT-Hp
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:22 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1u9eCa-0005Ma-KB
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 02:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745907141; x=1777443141;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X8bkKeZ6iP/uoINx+upLqqZFShFKcJNLcZmGz3zJiEs=;
 b=Q/HOo6qU5iC4FJjptg/0Tj4ozrjaUnc6sr/SNXoxOAQNbCqmdpRaGKiH
 tQhktxRjPROLU0/Xpr3GUqB36DKVVhhz/9WJ8NZOwIuFQUhbZF6Ceonkb
 QerPaDnGnLMPmJLUv4yw0DwdWFR7MSTzHHteGQyK1SjlA/GcowbJuIS4/
 Qlq3jjZKxoEOS/h8+wOJIXUZoegmMJpTAsxUsxEdnp2gB8a19xHHRyOLp
 195inVIFeAw1giRVwTEc3ndoNL/LWPxJfasRl+avctYFLl3fJRmBc4IQe
 6Jltm6CUlvFXHE96LIfRVt+G7ls5JBvZfpxnERn8WozU7JBZiuDHh32eK w==;
X-CSE-ConnectionGUID: 2FDRzKz+QuanvbKEMud1RA==
X-CSE-MsgGUID: Y0WpwXaSQiWMm2Z6hUaHtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58169825"
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="58169825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:10 -0700
X-CSE-ConnectionGUID: f01IJIG6QuimBU7puSjgVA==
X-CSE-MsgGUID: zbPUi2pSQACUdM//FF+WKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,248,1739865600"; d="scan'208";a="133687164"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 23:12:05 -0700
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
Subject: [PATCH v3 0/6] ui/spice: Enable gl=on option for non-local or remote
 clients
Date: Mon, 28 Apr 2025 23:08:24 -0700
Message-ID: <20250429060952.59508-1-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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
the iGPU/dGPU on the host machine via the Gstreamer framework.

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

Vivek Kasireddy (6):
  ui/spice: Add an option for users to provide a preferred codec
  ui/spice: Enable gl=on option for non-local or remote clients
  ui/spice: Submit the gl_draw requests at 60 FPS for remote clients
  ui/console-gl: Add a helper to create a texture with linear memory
    layout
  ui/spice: Create a new texture with linear layout when gl=on is
    enabled
  ui/spice: Blit the scanout texture if its memory layout is not linear

 include/ui/console.h       |   2 +
 include/ui/spice-display.h |   4 +
 qemu-options.hx            |   5 +
 ui/console-gl.c            |  28 ++++++
 ui/spice-core.c            |  16 ++++
 ui/spice-display.c         | 184 +++++++++++++++++++++++++++++++++----
 6 files changed, 223 insertions(+), 16 deletions(-)

-- 
2.49.0


