Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57281C61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoHo-0005qF-PW; Tue, 25 Aug 2026 06:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoHn-0005q0-Ho
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wyoHk-0005ZR-Iw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787653299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+XRGIOTxVcrVwebvEkYKAMRouqsc52yuiDdr0MSuFZU=;
 b=eTrFU1zIfW1FUMx/0L/fn1rwTSaOnwY5F0Fc/HDSU7scczxEPZNg93LB3bWRCCTzX/jAvY
 5y/QcmyPcCQGwvI8Zm+42cpjl+Gsf3GgtfroDDiS4Wc3ptbr15invpE7v7jLpWamYBQylr
 4bXUcOoMH78mGy0ZauXgzb/bcbD1QAA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-oATCl09WP7OTjEBWP_olYg-1; Tue,
 25 Aug 2026 06:21:26 -0400
X-MC-Unique: oATCl09WP7OTjEBWP_olYg-1
X-Mimecast-MFC-AGG-ID: oATCl09WP7OTjEBWP_olYg_1787653285
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41569184B3B6; Tue, 25 Aug 2026 10:21:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B41430002EE; Tue, 25 Aug 2026 10:21:19 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/18] RFC: various virtio-gpu/dmabuf related fixes
Date: Tue, 25 Aug 2026 14:20:37 +0400
Message-Id: <20260825-virtio-gpu-cleanup-v1-0-d3bb612b9975@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrE1CheAqYtHWYESqaVUk4u6K5
 Vv8f4Enx+ShTS5wdLDnzUTkaQJ6lmYi5CEaRCaqrBYlHux23nCyAfVK0gSLw6iEknldNkUFMbS
 ORj6/adf/9kEtpPf3BPf9AFiRe7F2AAAA
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
 swing <swing@mail.exp.sh>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3501;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=psObioel+J552nBCVodghbTSbcKnDXiNptNHPE6p8ok=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjWyX0GV8J8QtYDng6mXs0Aogp9C1Ex/d47BTq
 1K59oiXDIiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao1slwAKCRDa6OEJdZac
 5amzEACaXcOi6RuUgD4pb8iV7Tyujsaub2MdY5JIb3aIE+/zQcI0b5Ql1R17wp8hVOZRxh/FwNc
 V7NIxFK73MmVgeZa3eEqKOyWg2sB0rKQsgdehhMIwgaXEpdQm8vhX0mW7sxAqSMgXS5WkQuGgPV
 UwfMXIh3+tG8ZByEm1iyHyczNH1xtx8ynUCXhjnPxVi2djvr9NRn2xffoy1diiAKoozDkt/OC89
 5Ge1kUcyNtiVuu/BO+rSMIXf7wLuNSh1xdDG1XwVrnPvDc+EcKKF4RfQuwjgJEtfeJwvNY3a3ne
 j4lt41Lz2nLakTFfYl3hyZ8PVYZ/okhYlKSEHz/C3P68nDV1ajXS13z4AZB355+l1EqhbDT0/W7
 MyuCxz6RYJyw2OBtK6o6M27IGPmGZtyQZyAsxjhhyCe9mr1/jGgKYrx+oBxDKIlZXROiW/i85t6
 Q7RqJTtgJgsnIebFuuSu1pgZtxjzN+0RxmdruyuX6EkmGA8UQU8kDvc5Qg+HzACizreT4RJpMPM
 rjyZdWya6qSnyqvskk7EBNCu4CG2cVRK5RZ/c14NfpXWCdZUc9Z5V1uPurkg8RgcXkxwWoaKJRJ
 j5bk2sjLUbU6ZTQLxY5KL3KKwYFILIjA4zyQfOyLx77phAN7NnSlQyOHNYNBNhjAKbj6loKcHZ+
 I96M7wUtqqAU0rQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series makes each virtio_gpu_scanout own its current dmabuf and
uses resource_id to track which resource it displays. It also makes
QemuDmaBuf own its file descriptors and moves GTK fence state out of the
dmabuf.

Those changes touch a lot of area and I have done basic testing with the
various backends. I would not recommend backporting them to stable:
there is a high risk of introducing regressions. Yet, I don't know how
to address all the problems uncovered by CVE-2026-66020 in a simple
patch series. Help welcome!

thanks 

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (18):
      ui/gtk: move GL fence tracking from QemuDmaBuf to VirtualGfxConsole
      ui/dbus: disable scanout iff dmabuf is current
      virtio-gpu: store the scanout DMABUF in virtio_gpu_scanout
      ui/console: disable GL scanout when dmabuf is the active one
      ui/sdl2: clear guest_fb.dmabuf on release
      ui/dmabuf: own and close fds on free
      virtio-gpu: release the dmabuf when a scanout is disabled
      contrib/vhost-user-gpu: drop scanout_bitmask bookkeeping
      virtio-gpu-rutabaga: fix scanout handling
      virtio-gpu: disable blob scanouts on mapping cleanup
      virtio-gpu: drop scanout_bitmask bookkeeping
      virtio-gpu: release dmabuf when switching to a surface
      virtio-gpu/virgl: release dmabuf when a texture replaces a scanout
      virtio-gpu: consolidate disabling scanout
      virtio-gpu: minor refactoring
      virtio-gpu/virgl: disable scanouts on resource unref
      virtio-gpu: initialize dmabuf_fd to -1
      virtio-gpu: fix use-after-free on blob cursor after detach

 contrib/vhost-user-gpu/vhost-user-gpu.c | 28 +++-------
 hw/display/vhost-user-gpu.c             |  1 -
 hw/display/virtio-gpu-rutabaga.c        | 26 +++++++---
 hw/display/virtio-gpu-udmabuf-stubs.c   |  2 +-
 hw/display/virtio-gpu-udmabuf.c         | 90 +++++++++++----------------------
 hw/display/virtio-gpu-virgl.c           | 75 +++++++++++++++------------
 hw/display/virtio-gpu.c                 | 82 +++++++++++++++++++-----------
 hw/vfio/display.c                       |  1 -
 include/hw/virtio/virtio-gpu.h          | 18 ++-----
 include/ui/dmabuf.h                     |  5 --
 include/ui/egl-helpers.h                |  4 +-
 include/ui/gtk.h                        |  8 +--
 ui/console.c                            |  3 ++
 ui/dbus-listener.c                      | 69 +++++++++++++++++--------
 ui/dmabuf.c                             | 51 +++----------------
 ui/egl-helpers.c                        | 15 +++---
 ui/gtk-egl.c                            | 30 ++++++-----
 ui/gtk-gl-area.c                        | 12 ++---
 ui/gtk.c                                | 31 +++++++++---
 ui/sdl2-gl.c                            |  5 ++
 20 files changed, 277 insertions(+), 279 deletions(-)
---
base-commit: 82706188517bd102ed25f1931c4cb041ecf3ef50
change-id: 20260825-virtio-gpu-cleanup-dfb2ba185936

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


