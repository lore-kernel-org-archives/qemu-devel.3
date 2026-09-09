Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F7FC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4G5S-00028R-Cp; Wed, 09 Sep 2026 07:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5R-00028I-AX
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x4G5P-0005CD-8r
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 07:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788951805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UMMUW1xmVPyyqAqPm5aBE4ZfXsQh83TedrNQWrcwEO0=;
 b=GepeyX1LL2ycbjm0UfeCPVmnQ36fI+Z4mRFDw7SfledIbzrdlQ7pEdqCzEMY91MZAEt1q0
 bgNg7upvxy/fzmqXYvI23+HrnFWhQtF1hYoa/Do+72losPBKsIx1rLhVw8zc6CRgOuywSM
 7JkciSFO1LmzJZLp0bMluRvbF6W+48E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-VqvbucGsPQeglk0EQELlhA-1; Wed,
 09 Sep 2026 07:03:22 -0400
X-MC-Unique: VqvbucGsPQeglk0EQELlhA-1
X-Mimecast-MFC-AGG-ID: VqvbucGsPQeglk0EQELlhA_1788951801
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 803E61954AE4; Wed,  9 Sep 2026 11:03:20 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C2C81800446; Wed,  9 Sep 2026 11:03:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/24] Various virtio-gpu/dmabuf related fixes
Date: Wed, 09 Sep 2026 15:03:05 +0400
Message-Id: <20260909-virtio-gpu-cleanup-v3-0-99266590e79d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ7CIBgFr2JYi+FHsLjyHsYFlK8tRksDLdE0v
 btQF8bEuJzkvZkZRQgOIjpuZhQgueh8n4FvN6judN8CdjYzYoRJUjGBkwuj87gdJlzfQPfTgG1
 jmNG0EopLlI9DgMY9Vun58uY4mSvUYzGVRefi6MNzrSZadn8DiWKCLTdGUmaUOohTANvpcVf7O
 yqFxD4ORfY/HSw7qDBCgzSEMP7lWJblBfzlKocLAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M+gORmNBQZ/5c1ic1UV4mp3tydBZ6D83rcHapWODEjQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoTzyzNXOmOaheu0pkhEIx8owCM62vjFULYUVu
 eVCe6nfa8iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqE88gAKCRDa6OEJdZac
 5TQsD/4q/b91ebrpox2CIiMaBm4JIWBvY1qOnOqxMBgS9Z1HT9xGh63ToRia42iiuM0ZOtJD+MJ
 NtiNw2bkt8sqyuO7WcSpj3X6MsgknklXNhShkokGOFgKyl6N1Gt6aCrM6DXbi8X1cC/l30q1eAA
 nSMUNQw3UMDnfsfbg6ag56BOmw4b3fOBWUk8VbQ7ILacGFcRt9YusYt3q7Ok7lKo4PiJtLcj/3B
 aTHiupfmYd4dPoD30t7YyAJJjZd5NpY19rFk6RRtN4gVk/WIXyCiyWFu+vrBIZawdp9WyC7YuyC
 VOexpA2TOgrb4q4Jr0FkOjOv/J4NUVpYQnLQXXl870gCmtfItFpwtmGuOBu2AhknC6McbvG8zX+
 x7idSVGqPdwq+zlH+EKMieeOpZkhvUKjrdHu1PpL3gaWRPy53Yudy/AIfS9hyd0ePoyXAohXg+r
 IUAXtDBAAz2B8+xxov+erNKSrtUMIcLhq3Y2LL+dNEc72v5wMaY8TtBAQ0vY4dOKl7lLUABrTPY
 qgjxvwS9ox5V80LtFC2pwEucKn0PBWiJmErAYmk28SZ5lFBz+B7pUglcApXy5LjjagKQ/JkRcIn
 JiY4kg08nvr467pVxmXeufS1QJpEQLvHYCk1qlXgefdwH+2MlTGOd7jI14urj8eyDJSasKpPDlC
 7w5jp8EOPEJCP5Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
      contrib/vhost-user-gpu: disable scanouts on resource unref

 contrib/vhost-user-gpu/vhost-user-gpu.c |  28 ++----
 contrib/vhost-user-gpu/virgl.c          |  12 +++
 hw/display/vhost-user-gpu.c             |   1 -
 hw/display/virtio-gpu-rutabaga.c        |  38 ++++----
 hw/display/virtio-gpu-udmabuf-stubs.c   |   2 +-
 hw/display/virtio-gpu-udmabuf.c         |  89 ++++++-------------
 hw/display/virtio-gpu-virgl.c           | 131 +++++++++++++++++-----------
 hw/display/virtio-gpu.c                 | 150 +++++++++++++++++++++-----------
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
 ui/gtk.c                                |  43 +++++----
 ui/sdl2-gl.c                            |   6 ++
 ui/spice-display.c                      |   2 +
 23 files changed, 432 insertions(+), 368 deletions(-)
---
base-commit: 1df256f5968e9f7c3c4533a1383b071c044a36d6
change-id: 20260825-virtio-gpu-cleanup-dfb2ba185936

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


