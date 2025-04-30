Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FA8C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 07:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA1oy-0001c4-Aj; Wed, 30 Apr 2025 03:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1uA1ov-0001bP-Be
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:29 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1uA1ot-0004Dd-5t
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 03:25:29 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 72C0E1C05DA; Wed, 30 Apr 2025 09:25:25 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v5 0/7] Add VNC Open H.264 Encoding
Date: Wed, 30 Apr 2025 09:25:17 +0200
Message-Id: <20250430072524.3650582-1-dietmar@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 94.136.29.99 (failed)
Received-SPF: none client-ip=94.136.29.99;
 envelope-from=dietmar@zilli.proxmox.com; helo=zilli.proxmox.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, NO_DNS_FOR_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding

The noVNC HTML application recently added support for this encoding. There is
also an open pull request to add audio support to noVNC:

https://github.com/novnc/noVNC/pull/1952

With that in place, the web based VNC console is good enough to display
a VM showing a video with reasonable bandwidth.

Possible improvements:

- Dynamic switching to/from H264 mode at high change rates

We may also extend the RFB Audio protocol with "opus" encoding, because uncompressed
audio need too much bandwidth.

Changes in V5:

- Do not allow --gst-* arguments on the command line (initialize gst
  in vnc_init_func)
- fix broken build by moving cleanup code to vl.c

Changes in v4:

- style fixes and cleanup (as suggested by Marc and Daniel)
- use SPDX-License-Identifier for new file
- protect everything with #ifdef CONFIG_GSTREAMER
- simplify vnc_refresh as suggested by Daniel (avoid populating
  the rectangle array, do not use vs after it might be freed)
- make "h264" a boolean option
- add new "h264-encoders" options (colon separated)
- add a cleanup path for vnc instead of using shutdown notifiers.


Changes in v3:

- add license header
- sqash patch to remove libavcodec prefix
- use gst_clear_object and goto error
- use single g_object_set
- g_autoptr/g_new0
- document vnc_h264_send_framebuffer_update returnm value
- avoid mixed declarations
- use loop to retrieve samples
- initialize gst during argument processing
- add hardware encoders


Changes in v2:

- cleanup: h264: remove wrong libavcodec_ prefix from function names
- search for available h264 encoder, and only enable h264 if a
  encoder is available
- new vnc option to configure h264 at server side


Dietmar Maurer (7):
  new configure option to enable gstreamer
  add vnc h264 encoder
  vnc: h264: send additional frames after the display is clean
  h264: search for available h264 encoder
  h264: new vnc options to configure h264 at server side
  h264: add hardware encoders
  h264: stop gstreamer pipeline before destroying, cleanup on exit

 include/system/system.h       |   1 +
 include/ui/console.h          |   1 +
 meson.build                   |  10 +
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   3 +
 system/runstate.c             |   2 +
 system/vl.c                   |   7 +
 ui/meson.build                |   1 +
 ui/vnc-enc-h264.c             | 357 ++++++++++++++++++++++++++++++++++
 ui/vnc-jobs.c                 |  53 +++--
 ui/vnc.c                      |  84 +++++++-
 ui/vnc.h                      |  29 +++
 12 files changed, 532 insertions(+), 18 deletions(-)
 create mode 100644 ui/vnc-enc-h264.c

-- 
2.39.5


