Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351E0CD98D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKF-000058-OO; Thu, 11 Jun 2026 05:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKE-0008WP-5N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKC-0004Np-1V
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y8Y4MaxhkcWmKmOUNUCvyy9DmUpyOcCJZgTBXrpBrGU=;
 b=dDKvT5ye54RxrcFhh4QISwRo93pUCfCBfcR/y2bhEO7GSWo3iRSR7CaHxiKMxTS3wkpGBo
 cS0UvjJ83CeeKDTtp7zdUi2IFoj8knv98RFOveXAnU05nnNYKalm7JRLBcLCUq6Lu60jmC
 KZZ4F4atVeRFUWcP81Gc1E74pPzbDFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-yZoQpV5PMFeOPWKtrhXqxw-1; Thu,
 11 Jun 2026 05:03:39 -0400
X-MC-Unique: yZoQpV5PMFeOPWKtrhXqxw-1
X-Mimecast-MFC-AGG-ID: yZoQpV5PMFeOPWKtrhXqxw_1781168618
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B127180060B; Thu, 11 Jun 2026 09:03:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D321180057F; Thu, 11 Jun 2026 09:03:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 00/35] ui: better console hotplug support
Date: Thu, 11 Jun 2026 13:03:15 +0400
Message-Id: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12N0Q6CIBhGX8VxHQ1BCLrqPVoXoL/5t6UOlNWc7
 x7YWqvLs33nfAsJ4BECORYL8RAx4NAnELuC1J3tr0CxSUw444pJbqir6IzUMONaq4w8CEnSdvT
 Q4mPrnC9vDrO7QT1lOS86DNPgn9tRLPPuvxlLyqhunGBKV7yE9uSh6ey0r4c7ydHIv5pi+qPxp
 BmwSkgJlulfbV3XF1aJFFPkAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6101;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=L888QriIUJxW/nHZ/ceM76r9oYXO93nludNayH9jUp0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnnct4a+8xWk7IIGmDsSXl+620cwYIFXI8ozs
 7W6ZBKNU4CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53AAKCRDa6OEJdZac
 5bAtEACjle2uTWFW+CmfbXKwE4NyyuZPW29/Jr3WS/Hiyk0Lc0zfNmd4Co3Bk1pRA4GxURi7UzV
 80UWTPKJakCukYvrfvjFx6Cp1nBqkBy877cP68iNdngsYHnBEzhcbYa8A1/VqUIV4/s9/3PacaA
 9IEWGcDaIJINU/3CVF0p+Pep1GiH2XNm9uoOlZgVnlqVYgBfVjNxvsh4qiGNHIpFmVU6vnL7ZhI
 DheUKtuGr1gc38mcJMO9CKaI9rpe3g6O05K7RfwoTnzfqB+Twf/pKdEaKDteFwIYqjTOg4+aHoa
 pcGPx8Ml3nnHZ7r23tSTIARR7MQwQqHeH2JLOGcbMft1kuDj9GCHk0s9PEUKJxkEN872qHHkJxL
 hl/899kaWw1JhzJ9+mREcrtUgYNWmfF2fmpTbEweRPsKMbC7SKOS+tRpXEr5OcmSihtb+D4dI3e
 Dv4yawUp9/2OFfCemr9HXMhZNLezf5Zs7nTRMP2YL9OhsfXfmrYcpyNA9fBv6aDxC61Kr8Yhwh/
 iETiwIlxsY87L4J3T3o6Tu4iQJ6vhpdLdpohs0n55eZO2YAN9rf3dZV65m+e+qdOkVkrmoD9z31
 REsJlZxKgka+dn+7KsJT5qmz+oLIitmOVrORZPg3eZ/TeWuEpjv6XQVbcAZZP6aJuzvr0PSGg/y
 JDQ0Zn2ckoGgByw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
Changes in v3:
- added "docs: start a vfio-pci document" patch
- gtk: some cleanup order fixes in gd_vc_free()
- gtk: drop unwanted show-tabs on console-add
- added "util: make notifer_remove() safer" 
- made dbus led handler removal idempotent
- vfio: close dmabufs before closing console
- vfio: removed bad set_display_gl_ctx(NULL) call
- vfio: fixed dpy->region exit/finalize with pre-check
- fix console registration after x-exit-preconfig
- rebased & collected patch trailers
- Link to v2: https://lore.kernel.org/qemu-devel/20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com

Changes in v2:
- add "ui/dbus: remove led handler", suggested by Akihiko
- fix compilation with -Dvte=disabled
- rebased, collect trailers
- Link to v1: https://lore.kernel.org/qemu-devel/20260529-b4-ui-v1-0-8db3068421ef@redhat.com

To: qemu-devel@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

---
Marc-André Lureau (35):
      ui/gtk: fix bad widget realize on non-GFX VC
      build-sys: build with -fno-omit-frame-pointer with ASAN
      irq: add per-IRQ observer to fix qemu_irq_intercept_in leak
      scripts/lsan_suppressions: suppress fontconfig leaks
      vfio/pci: close display console during unrealize, not finalize
      docs: start a vfio-pci document
      glib-compat: add fallback for g_clear_fd/g_autofd
      util: make notifer_remove() safer
      ui/dbus: remove mouse handler on dispose
      ui/dbus: remove led handler
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

 MAINTAINERS                     |   1 +
 docs/devel/index-internals.rst  |   1 +
 docs/devel/vfio-mdpy.rst        |  83 +++++++++
 meson.build                     |   2 +
 hw/vfio/pci.h                   |   1 +
 include/glib-compat.h           |  29 ++++
 include/hw/core/irq.h           |   6 +-
 include/ui/console.h            |  20 +++
 include/ui/egl-helpers.h        |   1 +
 include/ui/gtk.h                |   7 +-
 include/ui/qemu-spice-module.h  |   1 +
 include/ui/qemu-spice.h         |   9 +-
 ui/dbus.h                       |   3 +
 hw/core/irq.c                   |  12 +-
 hw/vfio/display.c               |  29 ++--
 hw/vfio/pci.c                   |   1 +
 system/qtest.c                  |   5 +-
 system/runstate.c               |   4 +-
 tests/qtest/dbus-display-test.c | 101 ++++++++++-
 ui/console-vc.c                 |  13 ++
 ui/console.c                    |  77 ++++++++-
 ui/curses.c                     |  17 +-
 ui/dbus-console.c               |  14 +-
 ui/dbus.c                       | 106 ++++++++++--
 ui/egl-headless.c               |  31 ++++
 ui/egl-helpers.c                |  19 ++
 ui/gtk-clipboard.c              |  15 ++
 ui/gtk.c                        | 375 +++++++++++++++++++++++++++++++---------
 ui/sdl2.c                       |  23 ++-
 ui/spice-app.c                  |  10 +-
 ui/spice-core.c                 |  25 ++-
 ui/spice-display.c              |  52 ++++++
 ui/spice-input.c                |  52 ++++--
 ui/spice-module.c               |   5 +
 ui/ui-qmp-cmds.c                |   3 +
 util/notify.c                   |   2 +-
 scripts/lsan_suppressions.txt   |  15 +-
 ui/cocoa.m                      |  19 +-
 ui/meson.build                  |   4 +-
 39 files changed, 1004 insertions(+), 189 deletions(-)
---
base-commit: de5d8bfd6105d3dd3ae668df9762df244a6d1506
change-id: 20260529-b4-ui-909bfa695735

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


