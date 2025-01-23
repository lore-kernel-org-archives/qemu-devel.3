Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8935BC0218B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 19:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb2gE-0007xS-UR; Thu, 23 Jan 2025 14:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2gC-0007wZ-8E
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tb2g9-000365-RP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 14:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737659746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jrnirlf9ZJIkVhF6epTAbrL+q6DIhwBIu9riAysQ398=;
 b=GWHX6t4Lp7wEUU7WRq5UqLRVVGt9QvpPirfBr/Drp6NDD6dpcO7MX25cDWaUXp1hoLmD6r
 g8uIcNPMuWvMFRzv1v9o/g5qO0OXxCch5KZrW3ECY4me53WIDocO8MiN1pQZLCaopFnOWt
 Q33m6aWNWirBW3mStZlajp1ZxdStRvc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-g7l-uL1GM7yXt8KWe3Hm2Q-1; Thu,
 23 Jan 2025 14:15:41 -0500
X-MC-Unique: g7l-uL1GM7yXt8KWe3Hm2Q-1
X-Mimecast-MFC-AGG-ID: g7l-uL1GM7yXt8KWe3Hm2Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F117A1954196
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 19:15:40 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D6ED30001BE; Thu, 23 Jan 2025 19:15:38 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC 0/6] RFC: hw/display/virtio-gpu: problems with coloured cursors
Date: Thu, 23 Jan 2025 19:15:30 +0000
Message-ID: <20250123191536.142753-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Help needed ! This is not for merge, just demo.

I started working on a simple bug in the GTK-VNC 'alpha cursor' encoding
support and in testing that uncovered what appear to be several bugs in
QEMU related to cursor handling across different components.

The two core behaviours are seen:

 * In some display backends (SDL, GTK), areas of the cursor
   with partial alpha are less saturated than they ought to be.

   The cursor data virtio-gpu is receiving from the guest has
   had the alpha channel pre-multiplied into the RGB components.

   This is not apparent in the VNC backend, since the VNC server
   is *supposed* to pre-multiply alpha but forgot to do so. Thus
   the virtio-gpu issue is hiding the VNC server issue.

 * In some display backends (GTK, VNC), the cursor RGB components
   are reversed.

   The cursor data virtio-gpu is receiving from the guest appears
   to be in BGRA8888 format, while GTK/VNC both expect the data to
   be in RGBA8888 format.

   This is not apparent in the SDL backend, since that is telling
   SDL to use BGRA8888 format when loading the cursor.

This series has patches to virtio-gpu which reverse the RGB
components and un-multiply the alpha channel.

I am not especially confident this is correct though.

The virtio spec is light on details:

  https://docs.oasis-open.org/virtio/virtio/v1.1/cs01/virtio-v1.1-cs01.html#x1-3200007

but says

   "In 2D mode the virtio-gpu device provides support
    for ARGB Hardware cursors and multiple scanouts
    (aka heads)."

I'm unclear whether its reference to "ARGB" here implies that
seeing BGRA8888 data is intentional, or a guest kernel bug ?

The spec says nothing at all about alpha pre-multiplication.
I kind of think this is more likely to be a guest kernel bug,
but its possible the spec just forgot to mention this ?

Meanwhile I've absolutely no clue what impact endianness will
have on this mess. All my testing thus far has been x86_64
host (QEMU git HEAD) with x86_64 guest (Fedora 41).

The problem isn't obvious since guests usually have monochrome
cursors by default. To aid in testing, on *both* your host and
your guest OS do:

  git clone https://gitlab.com/berrange/cursordemo
  cd cursordemo
  ./setup.sh
  gnome-tweaks

Navigate to Apperance, and select "RGB" or "Rainbow" as the
cursor theme.

Now compare the guest OS rendered cursor to what you see on
the host OS. They should obviously match 100% since they're
using the same theme.

Daniel P. Berrangé (6):
  ui: add more cursor helper methods
  hw/display/virtio-gpu.c: reverse alpha pre-multiplication
  hw/display/virtio-gpu: fix pixel ordering from BGRA8888 to RGBA8888
  ui/vnc: pre-multiply alpha with alpha cursor
  ui/sdl: load cursor in RGBA8888 format not BGRA8888
  ui: add ability to dump the raw cursor bytes

 hw/display/virtio-gpu.c |  3 ++
 include/ui/console.h    |  7 +++++
 ui/cursor.c             | 70 +++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c               |  2 +-
 ui/vnc.c                |  7 ++++-
 5 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.47.1


