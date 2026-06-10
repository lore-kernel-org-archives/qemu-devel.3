Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE325CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGcd-0001zL-1u; Wed, 10 Jun 2026 06:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGca-0001yQ-LZ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGcY-00026g-Mj
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=byRR74NDGm+WD6x/zXeqXSSR1bPT8fCZhFGeJebyHcg=;
 b=IEj7vK68mZO4EV2b41oSdX5hsOYh2jNYYys6zkG7v7dugDW88KG6frONi2kcAkr7dTY9Wz
 zl3INWE4AWBEDsw8x8OpdSaVM99SdkZs6M5XodpewhWXW0GsT6NqfkynLhx3NojJvWyTqq
 /4X/DxzsQ17+Qh9GsXCk0dVvFnQoY8g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-VmL6yEhgPTSeGUTvOc_F9Q-1; Wed,
 10 Jun 2026 06:57:14 -0400
X-MC-Unique: VmL6yEhgPTSeGUTvOc_F9Q-1
X-Mimecast-MFC-AGG-ID: VmL6yEhgPTSeGUTvOc_F9Q_1781089033
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5CF41954115; Wed, 10 Jun 2026 10:57:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F3931954B09; Wed, 10 Jun 2026 10:57:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/22] ui: retire input-legacy.c
Date: Wed, 10 Jun 2026 14:56:42 +0400
Message-Id: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2pq2YIOu+A/Doo+pjIlA+iAaw
 r9LcevyJOeeu0LEQBjhVq0QcKFI07iDPFVgBz0+kJHbGSSXiit+ZZkYjXNOzDdG1V45pX0Nuz4
 H9PQ+Uvf+xzGbJ9pU9sUYKKYpfI6vRRTvT3YRjLNGKnFxaFrRYhfQDTqd7fSCftu2L7gQNcazA
 AAA
X-Change-ID: 20260609-ui-input-f4b63f6d6af3
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Zm3HWyS5AZ/YhSS6OSthZ8nJzYruQ2lwMyeEwrcGo6c=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGopQv6jDA3Ljqm6V70g5UJ3j0HA441z7HKZ8YTseycz+2kUO
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqKUL+AAoJENro4Ql1lpzlgK4P/04X
 O0L4hfxTmJxsPb49e09dXJnbmnJDuUSYx7sI29ZSHqU73fUjOSPcNGgkqYTEd8jZt4UFBMevmaO
 d77ZPiknkdSEjuqYspMjCCUijlsUL5OtaISPwaYFuHzzLM0aVJH5EqT5N9025J4JUQi4RTqJIFP
 IQkf5mTyqD+rOK7oRcIi0WgjwfwKRUlYoXR+Ht8g5+09UcUuD/RGgz2FyDp+MtaSyUtEXIPFOeq
 hMrUAw/AR2udqUKCcjb3o1eSIqlVmUwpBQHxc1pYfEjxX9hjv6MYgia+EhODki/tWs5jyrcHRPL
 DoARraXa624hHoyTBoGhmmMQ1aW2IkBjYBhHwdwv8VlZF2lEBlDo2tN1+Dc5t0pgPHUttPtSLi9
 /1Q7nOhE3f/8OQGJGBJ0HUZ4oNzFFIWiZVLjdvBpJ4dhSBV3qbkC4kNmCtpsZz/RkEy8kZmPwrC
 6DLYfqoB9vvZYxzP/Y+QIg7g6Bylxt1O002sOmZ6QgOF+628zN8bL/FxnR4ofWE+7cSG9l/EjvU
 9k8kRBT6SLGcsQnYM/hcUazoK5AFBa4tKHb9raS2b+kVXAToJ5VrUM/j7tvH/xfAppjzBwoGG8a
 OwnbSvrtkWxm+ECZqv9pHHAm4jmOiY5ML+hHP3WEK0sT+N+P8gd1H+YqDRNtyxPyZfRi6d1n8kh
 mD7TN
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi

This series cleans up the QEMU input subsystem by converting the last
legacy mouse API consumers and reworking how keyboard LED state (Caps
Lock, Num Lock, Scroll Lock) flows from emulated devices to UI backends.

The first patches are preparatory cleanups and fixes. Then legacy mouse
API consummers are converted. The second half introduces per-handler LED
state tracking in QemuInputHandlerState, convert the users, and drop the
old broadcast queue in the final patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v2:
- warn on qemu_input_handler_register() unused result, suggested by
  Philippe Mathieu-Daudé
- related extra fixes
- rebased, collect patch trailers
- Link to v1: https://lore.kernel.org/qemu-devel/20260609-ui-input-v1-0-42615deb818e@redhat.com

To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jan Kiszka <jan.kiszka@web.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>

---
Marc-André Lureau (22):
      hmp-commands.hx: fix button_state doc
      ui/hmp: move index_from_key() where it is used
      hw/i386/vmmouse: convert to QemuInputHandler API
      hw/usb/dev-wacom: convert to modern QemuInputHandler API
      ui: move LED and key utilities to input.c, delete input-legacy.c
      hw/input: replace fprint with LOG_GUEST_ERROR
      ui/input: remove double-notification on qemu_mouse_set()
      ui/input: remove dead declaration
      ui/input: add LED state tracking to QemuInputHandlerState
      hw/input/ps2: keep QemuInputHandlerState in PS2State
      hw/arm: keep QemuInputHandlerState in musicpal
      hw/input: keep QemuInputHandlerState in adb-kbd
      hw/input: keep QemuInputHandlerState in stellaris
      hw/m68k: keep QemuInputHandlerState in next-kbd
      ui/input: qemu_input_handler_register to warn for unused result
      hw/input/ps2: use qemu_input_handler_set_led() for LED state
      hw/input/hid: use qemu_input_handler_set_led() for LED state
      hw/input/virtio-input-hid: use qemu_input_handler_set_led() for LED state
      ui/vnc: switch LED handling to Notifier-based input API
      ui/spice: switch LED handling to Notifier-based input API
      ui/dbus: switch LED handling to Notifier-based input API
      ui/input: remove old LED handler broadcast queue

 include/hw/input/ps2.h               |   2 +
 include/hw/input/stellaris_gamepad.h |   2 +
 include/ui/console.h                 |  30 -----
 include/ui/input.h                   |   7 +-
 ui/vnc.h                             |   2 +-
 hw/arm/musicpal.c                    |  13 +-
 hw/i386/vmmouse.c                    | 115 ++++++++++++-----
 hw/input/adb-kbd.c                   |  17 ++-
 hw/input/hid.c                       |   3 +-
 hw/input/ps2.c                       |  28 ++++-
 hw/input/stellaris_gamepad.c         |  12 +-
 hw/input/virtio-input-hid.c          |  15 ++-
 hw/m68k/next-kbd.c                   |  11 +-
 hw/usb/dev-wacom.c                   | 155 ++++++++++++++---------
 tools/qemu-vnc/input.c               |  49 +++-----
 ui/dbus-console.c                    |  11 +-
 ui/input-legacy.c                    | 236 -----------------------------------
 ui/input.c                           |  76 ++++++++++-
 ui/spice-input.c                     |  10 +-
 ui/ui-hmp-cmds.c                     |  22 +++-
 ui/vnc.c                             |  11 +-
 hmp-commands.hx                      |   4 +-
 hw/i386/trace-events                 |   2 +-
 ui/meson.build                       |   1 -
 24 files changed, 404 insertions(+), 430 deletions(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260609-ui-input-f4b63f6d6af3

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


