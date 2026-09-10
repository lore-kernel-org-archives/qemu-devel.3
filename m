Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A263C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4hF1-0004Vg-8b; Thu, 10 Sep 2026 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4hEI-0004Fx-Kr
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 12:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4hED-0003lb-7C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 12:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789056138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NotSW32JrainzY7i82xNaKIM19HMzdP0dArUGsMAsjE=;
 b=PDgKgNkV5LF4kU8AjhZfI8R+w0h6V8kVt/M7ALZOqjsvnb/Jub4AWP3QXOlrl8UzATGdha
 iRBI0QNFhMOwuOON2KXg3JpVHyLHCDqtBiWAXwGoJcc8MOrLBeFeOpaZM9SXDJ5E4VhTIn
 8s+F/YSsEIdNynNwR0X6Fvh+lvvEA6g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-g41Ev5lEOfSYpK39sQiwDA-1; Thu,
 10 Sep 2026 12:02:15 -0400
X-MC-Unique: g41Ev5lEOfSYpK39sQiwDA-1
X-Mimecast-MFC-AGG-ID: g41Ev5lEOfSYpK39sQiwDA_1789056134
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79F8C1954204; Thu, 10 Sep 2026 16:02:14 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8AFB418; Thu, 10 Sep 2026 16:02:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [GIT PULL v2 00/24] Various virtio-gpu/dmabuf related fixes
Date: Thu, 10 Sep 2026 20:02:11 +0400
Message-ID: <20260910-virtio-gpu-cleanup-v2-0-82555d04f70c@redhat.com>
In-Reply-To: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
References: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4156;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jRI6D0P6ODCicYBtEHr9Y7GcVaaFvcAYgcR8YgjTGS4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqotPxcSzh9w6KkYJKZ0LbpNLl608luAx+h2x/6
 tBq5rpaqLyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqLT8QAKCRDa6OEJdZac
 5RDBEAC2smVUGH8YAL3xGw/eJv0KLqKwaKt04yqrsAQ3sQDYbuV5MP4s0EdeLxpC1rPiVXsOCSE
 GgmlBUlgDuFsNo/byoxclwU4T3YHX2aHQUYD9g5Li5yGACXqyPvsScKmJHYiLGlTR1z5JTqX8/E
 +gnQ2JuR/vFuX/e7Mvm9oLX0mnNoB187UcPCGYzMJOeHUO/GmdojjmzBy26IM2Q3zf1b6oplvdr
 T9ktS8+SnkbDbiLCuGaqrfHwdIb26y6aubwHLFxnPc+JYJzS0XnB855RskJVET9UUZ6qMpjtupX
 fd9Y5QgI/PGh+5LO8KN78Hcun9kuYzcKq2tdDNIHs7THjMHeQVMAcTCp6LIGTdsQab/FfTHVeOJ
 h0dD2SK9+XgkaLbt+TAWr4ImmUz1uZSNQTu17Awb8/9xtDPP8NA3lkL+1DKVH7kXQfd84bO4nwK
 R7TJx1ppG7FS0J+28PZVqmA3G8ZVahetS05dtpFy7tnKkKZe5h/MPT6AyHbVp2tPhthgT7o7f8K
 oGqiWrbpEY+1qZyazc3OAyKantgGFBu+F5W+4h2e7MIXYRbet1h+FZb63UBPb2MKNn4/49zf2w3
 gi9IJx56/0UsuSSBuVh9ObNLfgNpsKv1/3h9RqQaydFk0hQGSAr13WNsH7KH94MtVto00icufJm v
 59R7x3AeTOnuzQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v2

for you to fetch changes up to d6e516555805b95a7a935c3fd74568dabf7796f2:

  contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09-10 19:59:43 +0400)

----------------------------------------------------------------
Various virtio-gpu/dmabuf related fixes

While working on CVE-2026-66020 (which had a few revision on list), I
kept finding several places where virtio-gpu scanout and dmabuf
ownership was unclear.

The CVE comes from using a blob after RESOURCE_DETACH_BACKING has
unmapped its memory. Following that path also found stale dmabuf
references, duplicated scanout bookkeeping, and inconsistent cleanup
between display backends.

Those changes touch a lot of area and I have done basic testing with the
various backends. I would not recommend backporting them all to stable.
The first 2 patches address CVE-2026-66020 in the general case and
should be safe to backport.

----------------------------------------------------------------
Marc-André Lureau (24):
      virtio-gpu: disable blob scanouts on mapping cleanup
      virtio-gpu: clear res->blob on mapping cleanup
      hw/display/virtio-gpu: introduce virtio_gpu_{simple,virgl}_resource_new()
      virtio-gpu/virgl: free BHs and timers on renderer reset
      hw/display/virtio-gpu: set share_handle for udmabuf blob resources
      ui/gtk: move GL fence tracking from QemuDmaBuf to VirtualGfxConsole
      ui/gtk: move draw_submitted from QemuDmaBuf to VirtualGfxConsole
      ui/dbus: disable scanout iff dmabuf is current
      virtio-gpu: store the scanout DMABUF in virtio_gpu_scanout
      ui/console: disable GL scanout when dmabuf is the active one
      ui/sdl2: clear guest_fb.dmabuf on release
      ui/dmabuf: own and close fds on free
      ui: make GL context current in display backend callbacks
      virtio-gpu: release the dmabuf when a scanout is disabled
      contrib/vhost-user-gpu: drop scanout_bitmask bookkeeping
      virtio-gpu-rutabaga: fix scanout handling
      virtio-gpu: drop scanout_bitmask bookkeeping
      virtio-gpu: release dmabuf when switching to a surface
      virtio-gpu/virgl: release dmabuf when a texture replaces a scanout
      virtio-gpu: consolidate disabling scanout
      virtio-gpu: minor refactoring
      virtio-gpu/virgl: disable scanouts on resource unref
      virtio-gpu: extract virtio_gpu_disable_scanout_for_resource helper
      contrib/vhost-user-gpu: disable scanouts on resource unref

 contrib/vhost-user-gpu/vhost-user-gpu.c |  28 ++----
 contrib/vhost-user-gpu/virgl.c          |  12 +++
 hw/display/vhost-user-gpu.c             |   1 -
 hw/display/virtio-gpu-rutabaga.c        |  38 ++++----
 hw/display/virtio-gpu-udmabuf-stubs.c   |   2 +-
 hw/display/virtio-gpu-udmabuf.c         |  89 +++++++------------
 hw/display/virtio-gpu-virgl.c           | 135 ++++++++++++++++++-----------
 hw/display/virtio-gpu.c                 | 148 +++++++++++++++++++++-----------
 hw/vfio/display.c                       |   1 -
 include/hw/virtio/virtio-gpu.h          |  31 ++++---
 include/ui/dmabuf.h                     |   7 --
 include/ui/egl-helpers.h                |   4 +-
 include/ui/gtk.h                        |  14 ++-
 ui/console.c                            |   3 +
 ui/dbus-listener.c                      |  69 ++++++++++-----
 ui/dmabuf.c                             |  65 ++------------
 ui/egl-headless.c                       |  17 ++++
 ui/egl-helpers.c                        |  15 ++--
 ui/gtk-egl.c                            |  55 +++++++-----
 ui/gtk-gl-area.c                        |  33 ++++---
 ui/gtk.c                                |  43 ++++++----
 ui/sdl2-gl.c                            |   7 ++
 ui/spice-display.c                      |   2 +
 23 files changed, 450 insertions(+), 369 deletions(-)


