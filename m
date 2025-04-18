Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BAAC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 11:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5jvJ-0005O1-Oa; Fri, 18 Apr 2025 07:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u5jvH-0005Mk-Tr
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:19 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u5jv3-0005fU-TT
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 07:30:19 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 2F35C1C160C; Fri, 18 Apr 2025 13:29:58 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v3 0/9] Add VNC Open H.264 Encoding
Date: Fri, 18 Apr 2025 13:29:44 +0200
Message-Id: <20250418112953.1744442-1-dietmar@proxmox.com>
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

As defined by:

https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#open-h-264-encoding

The noVNC HTML application recently added support for this encoding. There is
also an open pull request to add audio support to noVNC:

https://github.com/novnc/noVNC/pull/1952

With that in place, the web based VNC console is good enough to display
a VM showing a video with reasonable bandwidth.

Possible improvements:

- Dynamic switching to/from H264 mode at high change rates
- do not compute all rects in vnc_update_client to reduce CPU load

We may also extend the RFB Audio protocol with "opus" encoding, because uncompressed
audio need too much bandwidth.

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


Dietmar Maurer (9):
  new configure option to enable gstreamer
  add vnc h264 encoder
  vnc: h264: send additional frames after the display is clean
  h264: search for available h264 encoder
  h264: new vnc option to configure h264 at server side
  h264: add hardware encoders
  h264: do not reduce vnc update speed while we have an active h264
    stream
  vnc: initialize gst during argument processing
  h264: register shutdown notifiers, stop pipeline in
    destroy_encoder_context

 meson.build                   |  10 +
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   5 +-
 system/vl.c                   |   8 +
 ui/meson.build                |   1 +
 ui/vnc-enc-h264.c             | 401 ++++++++++++++++++++++++++++++++++
 ui/vnc-jobs.c                 |  49 +++--
 ui/vnc.c                      |  63 +++++-
 ui/vnc.h                      |  30 +++
 9 files changed, 551 insertions(+), 18 deletions(-)
 create mode 100644 ui/vnc-enc-h264.c

-- 
2.39.5


