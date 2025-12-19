Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E89BD78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 18:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfO3-00034j-MV; Fri, 19 Dec 2025 13:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.4pwzoyzyxitt747=6z56s619hh12=dpz44wxocupzg0@em483429.getutm.app>)
 id 1vWfO2-00033m-1c
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:34 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.4pwzoyzyxitt747=6z56s619hh12=dpz44wxocupzg0@em483429.getutm.app>)
 id 1vWfO0-0007t5-G9
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766170458; h=Feedback-ID:
 X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=PJzM4nf57ZQ9qxDn+Kf5e75CJldile08LH1lAJ48S24=; b=VWMrmklstwWh9p/vt7XQcjmA10
 dDXrLkYRO89DTbSyBL3TDLZyAyy6rQHWaGctwWlTZtnj7gI+IfbcOThScQRgSff//4B4c8hmziGtT
 I6sv5K0t3l8ME+ETMYi0eAfDpJAtGmfgZd3h+8BhrDoQvxGlwQV3XbsK0QB7xryxm5NcgLs1p7cJN
 sbbBvYZV/f6CfuEsBPVKtXO02CaicXZ9OYHk8aAMZ2ou3o5Kf2kcFslXgr9/Vcfiqunb5H1HuldP/
 9DzzDY1/0EAKuF6f1nUWR9Me3tIKdf4QS74WD6Bmrhi38PSypnMuVU9cVKECr1D0Ie5Wtq3NUPuqS
 PP2YL//Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766169557; h=from : subject :
 to : message-id : date;
 bh=PJzM4nf57ZQ9qxDn+Kf5e75CJldile08LH1lAJ48S24=;
 b=aZPAs7UPBxSQWNbgYtnPRLBTvHdao/zx4pUKVp5BTYx5J7JFZ5rwEzljQqjXccKuRsWlg
 jwyAhCzc94CQjZytCuuunojWcx/2d2Ns9q1V8C0fpuihHbIoty2wsQD52zvWhADhMI4bteZ
 Q+86aLsi+L0z/vB9vLtvi3hgHvHYuWi4TcyYNQEJbcTVsCKQKTDE0pPuYZ7/ft8Y4MSCLLZ
 Kyrd9014Vp6uoXLCEt5zWqcDbfb1egdJF5wSy+eVq5Dl+/d4Sj+61lUXWfpi84aBayXF2Jo
 gSOvRYp1KXHBhOvReAHgnfxGJbCwZQqJPTldaQ/CCz2sUL+NzTGVwtj8+pQg==
Received: from [10.172.234.246] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNl-pH9R0x-7w; Fri, 19 Dec 2025 18:39:17 +0000
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWfNk-AIkwcC8uKAK-Diyw; Fri, 19 Dec 2025 18:39:16 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>
Subject: [PATCH RFC v2 0/6] virtio-gpu-virgl: introduce Venus support for macOS
Date: Fri, 19 Dec 2025 10:38:46 -0800
Message-ID: <20251219183853.4426-1-j@getutm.app>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: nThZuHukaXrl.aybCKsLiu9jX.TfkJngOsz4Z
Feedback-ID: 483429m:483429abrvJvs:483429s_mgBqpXZX
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.4pwzoyzyxitt747=6z56s619hh12=dpz44wxocupzg0@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

This brings Vulkan guest paravirtualization to macOS hosts. The bulk of the work
is being submitted to the virglrenderer project so this is a RFC for now.

In addition to Vulkan, we also introduce Metal texture scanout for GLES guests
as well. We also added Metal texture rendering in the Cocoa backend but that
builds upon the GLES work by Akihiko Odaki which is not currently upstream.

Fork with all dependent changes:
  https://github.com/utmapp/qemu/tree/submit/macos-venus
Instructions for building and testing with all related projects:
  https://gist.github.com/osy/a8f705050eed1c8421ad1a0855a8faa9

v2:
- Removed "virtio-gpu-virgl: check page alignment of blob mapping"
- Fixed build on Linux
- Restored check on blob resources
- Renamed new structs in console.c

Joelle van Dyne (6):
  egl-helpers: store handle to native device
  console: rename `d3d_tex2d` to `native`
  virtio-gpu-virgl: update virglrenderer defines
  virtio-gpu-virgl: support scanout of Metal textures
  console: add cleanup callback for ScanoutTexture
  virtio-gpu-virgl: add support for native blob scanout

 meson.build                   |   9 +++
 include/ui/console.h          |  31 +++++++++-
 include/ui/egl-helpers.h      |   2 +-
 include/ui/gtk.h              |   4 +-
 include/ui/sdl2.h             |   2 +-
 hw/display/virtio-gpu-virgl.c | 112 +++++++++++++++++++++++++++++++---
 hw/display/virtio-gpu.c       |  10 ++-
 ui/console.c                  |  60 +++++++++++++++---
 ui/dbus-console.c             |   2 +-
 ui/dbus-listener.c            |   8 +--
 ui/egl-headless.c             |   4 +-
 ui/egl-helpers.c              |   4 +-
 ui/gtk-egl.c                  |   4 +-
 ui/gtk-gl-area.c              |   4 +-
 ui/sdl2-gl.c                  |   2 +-
 ui/spice-display.c            |   2 +-
 16 files changed, 220 insertions(+), 40 deletions(-)

-- 
2.50.1 (Apple Git-155)


