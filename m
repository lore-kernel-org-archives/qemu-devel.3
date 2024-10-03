Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE9ECF857F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 11:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJv9-0000eB-8a; Thu, 03 Oct 2024 07:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJv8-0000e0-6W
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJv6-0004oS-OT
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6bth4926wIzHhVHfX8jPxrIgKBuo8dYA68LjeYUbCqs=;
 b=VXybySaBZPQP9V4QioT1x3nCTH0QnlAQQUb+5GU2tw1NPsvtZkM3L1yE7egnotFjw7OS8r
 E7X97sAwa58Ytu+Ty1z6fSjKhMV5JnaZJxoj7D/TBDOg3fXZ8rvJn6eNFehvYwFEroVO36
 T8cvZXyh3nF43YgXuz8aXcL/HrRszgk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-Yf8iHmtdMdmjD4slADuB2A-1; Thu,
 03 Oct 2024 07:22:51 -0400
X-MC-Unique: Yf8iHmtdMdmjD4slADuB2A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C833819560B1; Thu,  3 Oct 2024 11:22:49 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 08FC430000DF; Thu,  3 Oct 2024 11:22:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/16] UI-related fixes & shareable 2d memory with -display
 dbus
Date: Thu,  3 Oct 2024 15:22:27 +0400
Message-ID: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

This series adds Listener.Unix.Map interface to -display dbus, to allow shared
memory for the display (similar to Listener.Win32.Map interface).

While working on it, I collected a few fixes. I can re-send them in a different
series or queue them once they are reviewed.

thanks

Marc-André Lureau (16):
  hw/audio/hda: free timer on exit
  hw/audio/hda: fix memory leak on audio setup
  ui/dbus: fix leak on message filtering
  ui/win32: fix potential use-after-free with dbus shared memory
  ui/dbus: fix filtering all update messages
  ui/dbus: discard display messages on disable
  ui/dbus: discard pending CursorDefine on new one
  util/memfd: report potential errors on free
  ui/pixman: generalize shared_image_destroy
  ui/dbus: do not limit to one listener per connection / bus name
  ui/dbus: add trace for can_share_map
  ui/surface: allocate shared memory on !win32
  ui/dbus: add Listener.Unix.Map interface XML
  ui/dbus: implement Unix.Map
  virtio-gpu: allocate shareable 2d resources on !win32
  tests: add basic -display dbus Map.Unix test

 include/hw/virtio/virtio-gpu.h  |   4 +-
 include/ui/qemu-pixman.h        |   2 +
 include/ui/surface.h            |   8 ++
 hw/audio/hda-codec.c            |  33 ++++---
 hw/display/virtio-gpu.c         |  49 +++++-----
 tests/qtest/dbus-display-test.c |  64 ++++++++++++--
 ui/console.c                    |  50 ++++++-----
 ui/dbus-console.c               |  23 ++---
 ui/dbus-listener.c              | 152 ++++++++++++++++++++++++++++----
 ui/qemu-pixman.c                |  19 ++++
 util/memfd.c                    |   9 +-
 roms/openbios                   |   2 +-
 ui/dbus-display1.xml            |  45 ++++++++++
 ui/trace-events                 |   1 +
 14 files changed, 361 insertions(+), 100 deletions(-)

-- 
2.45.2.827.g557ae147e6


