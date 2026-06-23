Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689E6CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvoP-0002L4-Ey; Tue, 23 Jun 2026 03:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvoN-0002Ku-VC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:44:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvoM-0007f3-2J
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G5WYtLmPNXfWZlL3rMBz+uTLfhov7CiA+R1q1b9wnTo=;
 b=FcY0Wfv9+lyhLWGw/k6XuWNAFmZ6Nda4wQDQ2JnA8PGNFmeH5b0pNYbeVi11UrF2ZcLWpY
 LKQhyYMPWuEkCUoaX5uDv4zf0VIOvKJkRLXDxskVM3+68gFhRdimBHJGuLvUrTVMzxO4n1
 UabfAgDAi2eoBX1/5JT6U09PBuWeB6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-x_-eFMU2OyWFO-fQn9JobQ-1; Tue,
 23 Jun 2026 03:44:39 -0400
X-MC-Unique: x_-eFMU2OyWFO-fQn9JobQ-1
X-Mimecast-MFC-AGG-ID: x_-eFMU2OyWFO-fQn9JobQ_1782200678
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 345BE1956056; Tue, 23 Jun 2026 07:44:37 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8027195608E; Tue, 23 Jun 2026 07:44:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v4 00/34] ui: better console hotplug support
Date: Tue, 23 Jun 2026 11:44:15 +0400
Message-Id: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNSw7CIBgE4Ks0rMXwKAiuvIdxAe2PxcTWQNtom
 t5dqGl8LSeZb2ZCEYKHiPbFhAKMPvquTaHcFKhqTHsG7OuUESNMEsE0tiUePNZEW2ekFjsuUOr
 eAjh/X3aOp1eOg71A1WecG42PfRcey9FIc+93c6SYYFVbTqQqGQV3CFA3pt9W3RXl0ZG9mSRqZ
 SwxDUZyIcAQ9c/4B6N0ZTyxHbOVtUk5A19snucnIaDVDBsBAAA=
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
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6375;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9iwamJ5FV33ylH7sKoHpA0C0B7c25XdoCSfJDaUraiw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldnH4voAsTQ+zKLnFoNk2UxSclLS+Hy/DGR
 l7zInp+Zz+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5eQCD/9si1azUMPCZXeE4S64iSH9ImaZMA1/UZS5EVqagb6SuCRmHhrP7r5hYmR+uKaX5idnzVp
 jv0m7TCWctJWb0DbG0Ov8INNKli9MRUk+sNmdGdCBjMI+Fa1eDb9RXxIpy/iyRnsLbdg1ICDarB
 wM0H+BCWsHSAbp2fDCuMkvXF4qL5edhX7VhD5TKugPW9Myu+s91VVQS8freWA8UOICgMFUVJrIt
 QtSOFE7k6BgcZBW6Xt86r1mvaW02IwpiNqsoSmvLHHCf2/nkZLQgIwOLUrpWXn+LhRdAse8UKK3
 +rh9k2OPYrfmsWmmcnwewQpbO0Zw+QuOtCjioG99V6VVBYgWh2tiFfoskFSQzluMOJDel0FBy0H
 3LUUwENR2Bb+76XGYqWEPLuZvC32fw07rVYQEDvrC3ul/I6lgFvbqg85XEq0Y4MJJCL6PkP8MyV
 8Cnob2Jb1tYh+naO91ABOU4NTd1H25XXqNn+5tjqKPYh73P5INdufWqY9CVI3/o/nFSW0DciYE3
 rASb25GZOm73NWnfbpPBzQZBR9BVuhllP7W4NSSGFPFgsKs4jcWuURvMxc3Q4F1f2Ic7frnlM4T
 P81J8VCwZcoIipNG5gJA4slptda2hHVmlNdXQvSO+sm4o0bA7tUXcYH3PAB8BpO5BRHm1UNAqru
 Nzot5zaZNL6uFfQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Changes in v4:
- call vfio_display_exit() in vfio_pci_realize() error path
- drop resetting gl ctxt to NULL on dbus console dispose (incorrect)
- add mdpy doc suggestions from Cédric
- rebased
- Link to v3: https://lore.kernel.org/qemu-devel/20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com

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
Marc-André Lureau (34):
      ui/gtk: fix bad widget realize on non-GFX VC
      build-sys: build with -fno-omit-frame-pointer with ASAN
      irq: add per-IRQ observer to fix qemu_irq_intercept_in leak
      scripts/lsan_suppressions: suppress fontconfig leaks
      vfio/pci: close display console during unrealize, not finalize
      docs: add mdpy mdev vfio display testing guide
      glib-compat: add fallback for g_clear_fd/g_autofd
      util: make notifer_remove() safer
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

 MAINTAINERS                     |   1 +
 docs/devel/index-internals.rst  |   1 +
 docs/devel/vfio-mdpy.rst        |  90 ++++++++++
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
 hw/vfio/pci.c                   |   2 +
 system/qtest.c                  |   5 +-
 system/runstate.c               |   4 +-
 tests/qtest/dbus-display-test.c | 101 ++++++++++-
 ui/console-vc.c                 |  13 ++
 ui/console.c                    |  77 ++++++++-
 ui/curses.c                     |  17 +-
 ui/dbus-console.c               |   6 +
 ui/dbus.c                       | 106 ++++++++++--
 ui/egl-headless.c               |  31 ++++
 ui/egl-helpers.c                |  19 ++
 ui/gtk-clipboard.c              |  15 ++
 ui/gtk.c                        | 375 +++++++++++++++++++++++++++++++---------
 ui/sdl2.c                       |  23 ++-
 ui/spice-app.c                  |  10 +-
 ui/spice-core.c                 |  25 ++-
 ui/spice-display.c              |  52 ++++++
 ui/spice-input.c                |  53 ++++--
 ui/spice-module.c               |   5 +
 ui/ui-qmp-cmds.c                |   3 +
 util/notify.c                   |   2 +-
 scripts/lsan_suppressions.txt   |  15 +-
 ui/cocoa.m                      |  19 +-
 ui/meson.build                  |   4 +-
 39 files changed, 1005 insertions(+), 189 deletions(-)
---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260529-b4-ui-909bfa695735

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


