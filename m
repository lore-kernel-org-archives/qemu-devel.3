Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889D6C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TgW-0003AJ-8P; Fri, 04 Sep 2026 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2TgU-00039B-VL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2TgS-0004yQ-WB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788527419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TeZur46BI+LshXAiGl63RIYYZ2iz5+BSYxTa8iNcifs=;
 b=XjHcVj7FWc5WY0EIXaSrYkgnLcLlNFkZ5BpT5iOuWZj4O2v5Ewszb8vOSsc+p0+FtFhVoZ
 KfhsU0KzO1iaYaGV6m1g/KeTA/EFMr3CbJ/2zqSW8QzTQI+QKxxzoSmOOIwH8eMXnZuoXP
 3ZTB3mYEEMNX2PfuL0aSsYMqTPgo1UQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-coJ4zKrdMxG20F5dj_DTEg-1; Fri,
 04 Sep 2026 09:10:15 -0400
X-MC-Unique: coJ4zKrdMxG20F5dj_DTEg-1
X-Mimecast-MFC-AGG-ID: coJ4zKrdMxG20F5dj_DTEg_1788527414
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B09D9180AD5C; Fri,  4 Sep 2026 13:10:13 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F9CF1955F10; Fri,  4 Sep 2026 13:10:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/25] Various virtio-gpu/dmabuf related fixes
Date: Fri, 04 Sep 2026 17:10:04 +0400
Message-Id: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4XM2jG0BARX/odh0ccAY5SStjQaw
 r8LuHd5knPPXSCQZwpwzRbwlDiwGzeQpwzMoMaekO3GIHNZ5bUsMbGP7LCfZjRPUuM8oe201Er
 UZVNUsA0nTx2/j+i9/XGY9YNM3Eu7MXCIzn+O1yR27+9BEpijLbSuhNRNcylvnuyg4tm4F7Tru
 n4BKB9FHMcAAAA=
X-Change-ID: 20260825-virtio-gpu-cleanup-dfb2ba185936
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 swing <swing@mail.exp.sh>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4381;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+iGOzfQSvZNAf6mEzZ4Mi7rpeQeIenP4TbNrypdbNcE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmsMvINb7zLw2wP/YBAoGVmoZW1sCigwVO6ZKE
 RMKt1vb5XqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaprDLwAKCRDa6OEJdZac
 5TCpEACdmU9dUiA1tTMfYtHjr1hquTL2SbD7Hybm7sQycBj2LIiSOt1DpBbU288hOkyBiwRZrGx
 LCIzGV+NgESTd7fziJtGTy/KBjfR9T7V28AFgXJLPXD717MY97uak08VqL+y5mNBrgu8CB0iF5I
 mswEsZxO9VUGYHHjcN+i4Kl5eVPcNwCvld4kl6sykqqoRb+ie4i7HGEiSqJoigUWhS5wI/gNA7t
 HCKX1Ss5D1QdpUPn6tLm61fhF3IH5+5V6U1qHe7eOxVu0wT7CeQcWMO1hvKOBKN2aIApIISTqyo
 HQrdaR3YLe4sPoL7yVbZSQeG1t2i1OUO6VRskFHcZ05sX2dEQgKKErI69hNm2SrJNn3CYso0wX7
 TG8XXpUzhv9MNrLjsggtClVqRVcYhYWcF7XaqgcfkVbc2Z7dfIRGJKQYq3GX0SHsHbeuExdJdHs
 N3fLD7EoNCDPCr/ofAdai3AjK/7ozg7fjQRjge214pBHf8aQaEctff5U+oRBxaPKP7O35avvMfo
 lFCWG65+A3MdCkb72g5ggjxYRU4tIxswQuDf3uCXjxA8lAM3hpsVs68NF8Qz99udXVfr3K9JWoM
 UUaMPU/zv9EYiE4IXJwIVMfuVBrIa3oSwEzrMJjubBBhT7E7ozjEYmVA8yExhMp99Jh64qJEcae
 y37AmZHvg9rc0/Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2: addresses Akihiko review
- reorder to have CVE fix first, easily back-portable (but also more
  limited fix)
- include virtio_gpu_{simple,virgl}_resource_new() patch, and other sent
  separately
- move draw_submitted from QemuDmaBuf to VirtualGfxConsole
- contrib/vhost-user-gpu: disable scanouts on resource unref
- drop rfc, collect rb, adjust commit messages
- Link to v1: https://lore.kernel.org/qemu-devel/20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com

---
Marc-André Lureau (25):
      virtio-gpu: disable blob scanouts on mapping cleanup
      virtio-gpu: fix use-after-free on blob cursor after detach
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
      ui: make GL context current before releasing DMA-BUF textures
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
      vhost-user-gpu: release DMA-BUFs on scanout disable, reset and finalize
      contrib/vhost-user-gpu: disable scanouts on resource unref

 contrib/vhost-user-gpu/vhost-user-gpu.c |  28 ++----
 contrib/vhost-user-gpu/virgl.c          |  12 +++
 hw/display/vhost-user-gpu.c             |  19 ++++-
 hw/display/virtio-gpu-rutabaga.c        |  38 ++++-----
 hw/display/virtio-gpu-udmabuf-stubs.c   |   2 +-
 hw/display/virtio-gpu-udmabuf.c         |  89 +++++++------------
 hw/display/virtio-gpu-virgl.c           | 131 +++++++++++++++++-----------
 hw/display/virtio-gpu.c                 | 147 +++++++++++++++++++++-----------
 hw/vfio/display.c                       |   1 -
 include/hw/virtio/virtio-gpu.h          |  31 ++++---
 include/ui/dmabuf.h                     |   7 --
 include/ui/egl-helpers.h                |   4 +-
 include/ui/gtk.h                        |  14 ++-
 ui/console.c                            |   3 +
 ui/dbus-listener.c                      |  69 ++++++++++-----
 ui/dmabuf.c                             |  64 ++------------
 ui/egl-headless.c                       |   2 +
 ui/egl-helpers.c                        |  15 ++--
 ui/gtk-egl.c                            |  55 +++++++-----
 ui/gtk-gl-area.c                        |  33 ++++---
 ui/gtk.c                                |  43 ++++++----
 ui/sdl2-gl.c                            |   6 ++
 ui/spice-display.c                      |   2 +
 23 files changed, 449 insertions(+), 366 deletions(-)
---
base-commit: 99e54ab5e7a6efc945af6d5661842155d1f3fc7a
change-id: 20260825-virtio-gpu-cleanup-dfb2ba185936

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


