Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A36C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4er8-0001s9-0o; Thu, 10 Sep 2026 09:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4er6-0001rz-LE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4er3-0003a7-Un
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789047016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I0SXExc26Odte8Sr8ekZBMCR88D97UmwyudeOzckHb0=;
 b=BdMQZ4Nl9TbfCp3vHDHdAab4FhUgB+s+XcCFBYmGAW+B1JEZ/6pnWmx2X75LFUsJzawLu9
 nROg7cT48flCcMdxxp3asjrLggkHubwVjr/2U9DiYbl9JMYIg/FfIsvGzmuWrHrU5rfm2D
 9HEfgcA8407cXgqCVcsnO/ay4CFR3pU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-XAfFQyVYOl28nK8P2Vg6CQ-1; Thu,
 10 Sep 2026 09:30:13 -0400
X-MC-Unique: XAfFQyVYOl28nK8P2Vg6CQ-1
X-Mimecast-MFC-AGG-ID: XAfFQyVYOl28nK8P2Vg6CQ_1789047012
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 245DE1955F73; Thu, 10 Sep 2026 13:30:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59AA0418; Thu, 10 Sep 2026 13:30:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 00/24] Various virtio-gpu/dmabuf related fixes
Message-Id: <20260910-virtio-gpu-cleanup-v1-0-ccb8927a671e@redhat.com>
Date: Thu, 10 Sep 2026 17:29:55 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6073;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=w8A8pTsG9/fX0Gt3R4Uf+pa3YhV3etR2RgL4x3v+7bM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqorDbpoNEAbbXt8X57kjHrmVgyLMLl7XTYwntP
 F/N6tg/M52JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqKw2wAKCRDa6OEJdZac
 5YFGD/9nDIh9Bn35zd0ij9f0RehEKeaxIa999ZSIdGDfi9pUHU9QIxNeRiWzFenBZkYfpwgoV/0
 H3cuUYRWqx/OTBtq2H13zv1jbDSysNGvopKtxfPG6yEcyvo2TtL4NFBAPC0I3vh4XV17+uGP3ty
 U8WPEvTXzuq4uW3S1rotvF1G0IGlLWWJkawJzhXUL0N/OGXTF4HgvkJt+49E1DseOPGitohP0bL
 L655lqGuXCuHzdSzaCHzBL+g8Lt2jB5rlbnQitTuxj1zc5N9vM6nybhwMR1K4082hPx2UT7/YJs
 NLX+GGSZoJOV7kZ5dD5eQQ2GtIBYYKPSpbqH9ejVWmSEAlbkQMAzYAAVzi4qAgQZNpWSJ7ye/Dc
 QF+77SeLYJYdv3wxdsJTvxgvegvmaCDST5Luz88EmARrddZEOc7mu2zWUNhS1nTBxlYf+ScPxmr
 LnvfiA5tZvvIfPVr3wuFAVbrpd5Xxqrl38thFShYhuaKlkYKFS1QypzS5rVz1rVmttfIVUD5pRc
 K4DeCMg4Q1tNmvfE/RiudkafqAHjG19vFs4rjkmQOmzbaZdrR7saG+PQZL3nVpd9mshsjAnK9Pz
 c2lOD7D5Jn9ap7MRR2p1Ox+pft5owQNY4U3s4IRpLnEvTTvVvllw2ImK2ZYzdFnvkgH+e+pDP8w
 dGKhwtmIDTGG/OQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/virtio-gpu-pr-v1

for you to fetch changes up to d26343c12d84227263b8d2fc89bac7632a98e00d:

  contrib/vhost-user-gpu: disable scanouts on resource unref (2026-09-10 17:29:47 +0400)

----------------------------------------------------------------
Various virtio-gpu/dmabuf related fixes

Hi,

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

thanks

To: qemu-devel@nongnu.org
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

---
Changes in v5:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v4: https://lore.kernel.org/qemu-devel/20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com

Changes in v4:
- replaced "ui: make GL context current before releasing DMA-BUF
  textures" with more complete "ui: make GL context current in display
  backend callbacks"
- rebase, drop eof line leftover, collect rb trailer
- Link to v3: https://lore.kernel.org/qemu-devel/20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com

Changes in v3:
- updated "virtio-gpu: fix use-after-free on blob cursor", now "clear res->blob on mapping cleanup"
- always disable GL when clearning scanout in "virtio-gpu: consolidate disabling scanout"
- drop "vhost-user-gpu: release DMA-BUFs on scanout disable" for now
- rebased, collect rb trailers
- Link to v2: https://lore.kernel.org/qemu-devel/20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com

Changes in v2: addresses Akihiko review
- reorder to have CVE fix first, easily back-portable (but also more
  limited fix)
- include virtio_gpu_{simple,virgl}_resource_new() patch, and other sent
  separately
- move draw_submitted from QemuDmaBuf to VirtualGfxConsole
- contrib/vhost-user-gpu: disable scanouts on resource unref
- drop rfc, collect rb, adjust commit messages
- Link to v1: https://lore.kernel.org/qemu-devel/20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com

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


