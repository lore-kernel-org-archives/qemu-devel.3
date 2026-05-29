Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85752CD6E52
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvCw-00017o-9e; Fri, 29 May 2026 07:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvCs-00017a-ND
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvCq-0008A4-8z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2kqfhySzL7LO70bYJPfcneVehcDFw6u4UA/X1U+Mq9w=;
 b=S9bwDX5q2diwBgkErLnZtPrGg2poqB513fmQR0Z+/ayua1mQn3VtLbSFRoiqrXYLrJBa+i
 36D8ohHBj1e36E6lp8tmIueuH0Nz3U7Qp9VD+k5fXqtO4OwGh/Pp6uY/QJv+aiWv/eMq9f
 ov7yFC5OncAq3kE+/MVywyj4Rr4xLqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-8tv5FLv6NSqJuf2Edhe2aA-1; Fri,
 29 May 2026 07:16:43 -0400
X-MC-Unique: 8tv5FLv6NSqJuf2Edhe2aA-1
X-Mimecast-MFC-AGG-ID: 8tv5FLv6NSqJuf2Edhe2aA_1780053402
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13F401800367; Fri, 29 May 2026 11:16:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C592D1686; Fri, 29 May 2026 11:16:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 00/32] ui: better console hotplug support
Date: Fri, 29 May 2026 15:16:21 +0400
Message-Id: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3SQT3dJMXUsDy6S0RDNLU3NjUyWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQDOQ7WFaQAAAA==
X-Change-ID: 20260529-b4-ui-909bfa695735
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4440;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YxuoBdLfbhz9GcFijxPVq5OYQbzmFyvLio5KDk7MkpU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWOjWGXvD4nSWJPpN0DsOVuB2yJ0AI0F3/OH
 Z5qht++5uKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jgAKCRDa6OEJdZac
 5QYnD/46g5c6kZRlxOhkA3+6WTfmg9EijcKt+rmQ8h/AVrqyg20m6FB0ynaWMFUShRYgJPvUFME
 FXqjILIGK4Ck2uOuqXGktxFLG8j6s+5IRXnNE5a0Rco0ulVl3numCZTYYkkxZgd+ZnAqX5vjlDL
 SPqMk0jo7y52cSDqpEwDV62UPb95Jo9t+sxncXtXfXoXmhy+4/GPn13ushVUmzsigv7xS09RUDj
 GGXV8kWVQOFJeKbJEFqw8mH3n9q1/MRMO2VN42NQwp2oZ/238ELMUYrinCi3UXzgCVI9GcC06Df
 p6KZbQHLMTvw0lqnLBsgAHVreOwqcmX6boBUpG/qp7GyNprG0Jol5cWKSawoueG5zZekNVoO+Rb
 UyJTmUBHlhp5z/51PQ9jNbn2A5KCHSgofdb7AWbBsOOZUtsOOC35w4yf7x0n2jdsoX8a1ig3m+c
 cG0BOzO9r0eGMuh30upDtrCgedb5sd7U/GvrN2J9kljJL1BEaqCFc2tvP1eghEVKAwVkiLNRNum
 avndfFkVGDMtS/levwAquuj3Nl3IPpBrkUaOZEjA8cN1uHqwhtlMqAA8edkZkJzW261bmWpbeK8
 YxZ2bWiYc93oE/QsL4ECtWeEFi/1tE51Q77lul9gGOFBUpDztyILNKUgj9nh7umCytlqHjQTRsK
 9+cB9oUxgtn+woQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series improves handling of dynamic consoles in ui/ (commit
9588d67e72 "console: minimal hotplug suport" added basic unplug &
replug).  It allows for better hotplug of vfio-pci display devices or
bochs-display (the other device supporting hotplug today), with GTK and
D-Bus backends.

As usual, the first patches are various preliminary cleanups and fixes I
hit while developping the rest, they could be merged earlier. I improved
the display cleanup to replace the scattered atexit() handler, making
leaks more visible to sanitizers.

Then console ADDED/REMOVED notifications are added, so display backends
can react to hotplug. The GTK code is rework a bit to allow easier
hotplug events handling. Finally, D-Bus supports is implemented with a
qtest to exercise it.

thanks

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (32):
      ui/gtk: fix bad widget realize on non-GFX VC
      build-sys: build with -fno-omit-frame-pointer with ASAN
      irq: add per-IRQ observer to fix qemu_irq_intercept_in leak
      scripts/lsan_suppressions: suppress fontconfig leaks
      vfio/pci: close display console during unrealize, not finalize
      glib-compat: add fallback for g_clear_fd/g_autofd
      ui/dbus: remove mouse handler on dispose
      ui/qmp: keep a reference of console across yield
      ui: stop ui timer when closing
      ui/console: init gl_unblock_timer in qemu_console_init
      ui/spice: remove dead spice_displays
      ui/spice: add cleanup on shutdown
      ui: add display cleanup infrastructure
      ui/curses: implement display cleanup
      ui/sdl2: implement display cleanup
      ui/spice-app: implement display cleanup
      ui/egl: implement display and EGL cleanup
      ui/cocoa: implement display cleanup
      ui/dbus: implement display cleanup
      ui/gtk: implement display cleanup
      ui/console: add console event notifier infrastructure
      ui/console: fire console ADDED/REMOVED notifications
      ui/console-vc: fire ADDED/REMOVED notifications
      ui/gtk: convert VirtualConsole storage from fixed array to GPtrArray
      ui/gtk: move global display settings out of per-console init
      ui/gtk: fix tab re-insertion order on window close
      ui/gtk: centralize console menu and shortcut management
      ui/gtk: handle console hotplug/unplug events
      ui/console: register console in QOM tree dynamically
      ui/console: unregister console from QOM tree on close
      ui/dbus: handle console hotplug/unplug events
      tests/qtest: add D-Bus display hotplug test

 meson.build                     |   2 +
 hw/vfio/pci.h                   |   1 +
 include/glib-compat.h           |  29 ++++
 include/hw/core/irq.h           |   1 +
 include/ui/console.h            |  20 +++
 include/ui/egl-helpers.h        |   1 +
 include/ui/gtk.h                |   6 +-
 include/ui/qemu-spice-module.h  |   1 +
 include/ui/qemu-spice.h         |   9 +-
 ui/dbus.h                       |   3 +
 hw/core/irq.c                   |  10 +-
 hw/vfio/display.c               |  30 ++--
 hw/vfio/pci.c                   |   1 +
 system/qtest.c                  |   3 -
 system/runstate.c               |   4 +-
 tests/qtest/dbus-display-test.c | 101 ++++++++++-
 ui/console-vc.c                 |  13 ++
 ui/console.c                    |  71 +++++++-
 ui/curses.c                     |  17 +-
 ui/dbus-console.c               |   9 +
 ui/dbus.c                       | 106 ++++++++++--
 ui/egl-headless.c               |  31 ++++
 ui/egl-helpers.c                |  19 +++
 ui/gtk-clipboard.c              |  15 ++
 ui/gtk.c                        | 369 +++++++++++++++++++++++++++++++---------
 ui/sdl2.c                       |  23 ++-
 ui/spice-app.c                  |  10 +-
 ui/spice-core.c                 |  25 ++-
 ui/spice-display.c              |  52 ++++++
 ui/spice-input.c                |  52 ++++--
 ui/spice-module.c               |   5 +
 ui/ui-qmp-cmds.c                |   3 +
 scripts/lsan_suppressions.txt   |  15 +-
 ui/cocoa.m                      |  19 ++-
 ui/meson.build                  |   4 +-
 35 files changed, 901 insertions(+), 179 deletions(-)
---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260529-b4-ui-909bfa695735

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


