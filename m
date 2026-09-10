Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BA7C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Zyp-0003Fm-SE; Thu, 10 Sep 2026 04:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zyo-0003FX-Nt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4Zym-0004s5-BE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789028274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HtYXp2dT09lVCADm0PA3f0pHwNqGfg+aKgCZp0AW7VA=;
 b=XcyBhf5hUO4Dbhw8OCUnc4a4PsGbO6VPrj8xvsAhFUfyn0bNYilHJo4njZbLxKNfM2TrGf
 kDEoWe0u6tWndZZ4/hQHaJVUJoPD0kKAk3WJhgmYTjEarjPbpvwtVc8sqWLuavLYQw3zh4
 gLgEavGBCvIRt+p3hVvS/Dsy3Y+f+ik=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-lChu7-1xNVqRcA0o-YbKUw-1; Thu,
 10 Sep 2026 04:17:51 -0400
X-MC-Unique: lChu7-1xNVqRcA0o-YbKUw-1
X-Mimecast-MFC-AGG-ID: lChu7-1xNVqRcA0o-YbKUw_1789028270
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C82061800762; Thu, 10 Sep 2026 08:17:49 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B40D1956040; Thu, 10 Sep 2026 08:17:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 00/24] Various virtio-gpu/dmabuf related fixes
Date: Thu, 10 Sep 2026 12:17:28 +0400
Message-Id: <20260910-virtio-gpu-cleanup-v4-0-7d623714bd71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwW7CMBAE0F9BPuPKXseG5cR/VD3Y8SZxVZLIT
 iwQyr/XoYeCQBxHmnlzZYlioMQOmyuLlEMKQ19Ctd2wurN9Szz4khkIMGIPmucQpzDwdpx5/UO
 2n0fuGwfOyr1GZVgZjpGacL6hn19/Oc3um+ppldZGF9I0xMvtNcu19/YgSy64V84ZCQ5xp4+Rf
 Genj3o4sfUhw7+BonppQDGkdtqScUKAejLUvYEvDVUMRDBGo6Ad+gdjWZZfBmXpEU8BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6Q0QU5d1/kucdklENQnxyfu3PhK1VfGRs2mIzpPdmdg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqomenHPUezbjkpB+OUZVGog3OUB64Z9d/tRoHO
 HaiE7UHVbWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqJnpwAKCRDa6OEJdZac
 5ZAMD/4pYOPytii/zUStyuWVz+LsgHy8OfRCe+A0jJIFKP8Ack9VNfDcX/4MoNY8Awaum0iUNZf
 gaUH7dNb1zkxxoUYOPcxM8THYTu9+AvLBOpjTV4jJROW2D3FkTIShw0GKbvTbVp+t/RgnMB5c9l
 JHSq4B7HLZP5zQhRu/TOeg0XThAqP+Huoc4yJCAUc0VCerU06lSSOFaK3rH3Prol3sURS64rCHg
 A/E+0zPbgqVb4X39WFDnGiH1ho43PwGuTfsnrjx5AGbX5L9QTtbAGcyTFACWQXLqJPATfsBDHfa
 V0coRgWwLlyw4F5TlBecogtRYTgWFUjEJA6wOI2c773+TLhL4D5nIYCk5tJxJDfaqB6Bsfiy7Q7
 Gt/sC0UsaszLh4Dn0tsc7XWKzt9KOMlXoQ2ID7Rd3NsR4VXTxuGFsFg59lkhvh2TLMIMilSW0VM
 lhWzWxu+bXbDRk5QKO6MQb+w2ICgXQnHT3tf+VVESSvGQjniH2pfUGHjTISkMSL7wmv8CxUniKw
 oWN4n0BrdaXUNLrUUiePX/7Fw/edGhS2vAYRYHALnM2HHO+jqDU+A2jnOmS/H97435Kyb1aOJzc
 nSQ0ncMRoaM78XswKru6dxdHcX4W6bUcUwUnIHiPHFixarYgS3ALK4QlSRdfXngUZwnanXs+aVt
 udPGhq8qR6+U8XA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

---
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
 hw/display/virtio-gpu-udmabuf.c         |  89 ++++++-------------
 hw/display/virtio-gpu-virgl.c           | 135 +++++++++++++++++-----------
 hw/display/virtio-gpu.c                 | 150 +++++++++++++++++++++-----------
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
 ui/gtk.c                                |  43 +++++----
 ui/sdl2-gl.c                            |   7 ++
 ui/spice-display.c                      |   2 +
 23 files changed, 452 insertions(+), 369 deletions(-)
---
base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
change-id: 20260825-virtio-gpu-cleanup-dfb2ba185936

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


