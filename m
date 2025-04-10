Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F2C369A6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 11:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2pzb-00088C-Bw; Thu, 10 Apr 2025 07:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dietmar@zilli.proxmox.com>)
 id 1u2pzY-00087C-Q2
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:45 -0400
Received: from [94.136.29.99] (helo=zilli.proxmox.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@zilli.proxmox.com>) id 1u2pzW-0000E9-Uk
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 07:22:44 -0400
Received: by zilli.proxmox.com (Postfix, from userid 1000)
 id 71BD11C15C7; Thu, 10 Apr 2025 13:22:40 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com
Cc: Dietmar Maurer <dietmar@proxmox.com>
Subject: [PATCH v2 0/6] Add VNC Open H.264 Encoding
Date: Thu, 10 Apr 2025 13:22:32 +0200
Message-Id: <20250410112238.3550155-1-dietmar@proxmox.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
- Support for hardware encoders

We may also extend the RFB Audio protocol with "opus" encoding, because uncompressed
audio need too much bandwidth.

Changes in v2:

- cleanup: h264: remove wrong libavcodec_ prefix from function names
- search for available h264 encoder, and only enable h264 if a
  encoder is available
- new vnc option to configure h264 at server side


Dietmar Maurer (6):
  new configure option to enable gstreamer
  add vnc h264 encoder
  vnc: h264: send additional frames after the display is clean
  h264: remove wrong libavcodec_ prefix from function names
  h264: search for available h264 encoder
  h264: new vnc option to configure h264 at server side

 meson.build                   |  10 +
 meson_options.txt             |   2 +
 scripts/meson-buildoptions.sh |   5 +-
 ui/meson.build                |   1 +
 ui/vnc-enc-h264.c             | 335 ++++++++++++++++++++++++++++++++++
 ui/vnc-jobs.c                 |  49 +++--
 ui/vnc.c                      |  62 ++++++-
 ui/vnc.h                      |  29 +++
 8 files changed, 476 insertions(+), 17 deletions(-)
 create mode 100644 ui/vnc-enc-h264.c

-- 
2.39.5


