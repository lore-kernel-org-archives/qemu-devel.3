Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35D9CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUEC-0007Uk-GZ; Mon, 08 Jun 2026 03:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUE9-0007UF-Lm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUE7-0008EA-NY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qqaOK8r+sR/Fb3hVSQ2kGr3FPhLfMsw7k5oHac/17Mk=;
 b=UHPuhVfb1ryVW98b/NAW0Fw3gudtAvyU/Y9hstPOLHCBe40TH04MQOIvsO3ceGrxysRsO3
 9daM6Awp0q6UfPNzJZ5gwh5eFGYqZS9L50aeDQf8qbFVbuCNF20yYWh0H5Pl0bkvZbZjpM
 crIKKcm3DYH/dEG4jL/Y0Nx6J0DRF6w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-zhrVk1RcM6qBjozeUEpEZw-1; Mon,
 08 Jun 2026 03:16:45 -0400
X-MC-Unique: zhrVk1RcM6qBjozeUEpEZw-1
X-Mimecast-MFC-AGG-ID: zhrVk1RcM6qBjozeUEpEZw_1780903004
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB9071944EBC; Mon,  8 Jun 2026 07:16:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 297D01800367; Mon,  8 Jun 2026 07:16:33 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/33] ui: better console hotplug support
Date: Mon, 08 Jun 2026 11:16:18 +0400
Message-Id: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6CMBAFf4Xs2Zq2UKSe/A/DgcLWromUtNBoC
 P8uxZvHSebNWyFiIIxwLVYImCiSH3eQpwJ6140PZDTsDJLLmiupmanYQkxzbWxXa3UpFezuFND
 S++jc2x/HxTyxn/M4G47i7MPnOEoie//NJBhnzWBKXjeVFGhvAQfXzefev6Ddtu0LHD+bPa0AA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5255;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mNrmUFZ53y0vdMM9U6ucO9QUTvCbHDpALVY8R+yqPAU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxHfTyGDgllKbBZxZJdQnf3a6gZ6fBnfVvqd
 GD0mU2dpCOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsRwAKCRDa6OEJdZac
 5byND/9cT64A6eKDEDQGk13TT1G9F9TWrAPLQL+KwV1R/6t0w9Hg+kTxfjWwIg7A4BAewBAzjBu
 /s03ZXufl/ZtGNILNVM30ul2mCQgWygJ0+1auHH7dAB2C6705BHtowBII5/Zxp6vZGeFTNPf0Ec
 Ki6jXIneNaG6NqrwiztnXRk0IdJGigka0i1+MLzoiX7fLb43RkkoflXrbIrtmZD2bvs+QmHKVBO
 76hhdrzVIPb/stjbPfb0lCqpjygESvBc24NluCmLODOq5GEfCE9GDGqG1qVj2p+ycBbmgYh/ZQ/
 d02li2xFGS+y13OZMLtJO/vVIf3jT5IjjA17kB57bjs/FlINIG7+lt6o2XV73a8vIffHX8UsRzD
 K8ZwEfbI+PJgcAdj8HOFJQI7iNW2mK6IHQ0pg4k1NZ/AUQkdygb7liSz28f34MbkcC9JZWe9of6
 ud0U8oIOvDUc37vO/bo1WNLCPnBzMnTyl1LXrLTRSHYTyqrwdXsDiBWYyAWFVmXKhtfs053uFYr
 4Ri2T9bQJeGlGypG9vr6WwDac7pxfETdV+3R/LDGcC/JhhNsa+ETk8UWRz+7zLXD1rZONq+Q9n4
 +msUl/X5my6EofMsL20J7q9lEAVKjSooCE30T01LdLtx1AXzZXqK77LqG/J8Z2DZSTPmwLoj3aZ
 5XcowIMR+0H9TPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
Marc-André Lureau (33):
      ui/gtk: fix bad widget realize on non-GFX VC
      build-sys: build with -fno-omit-frame-pointer with ASAN
      irq: add per-IRQ observer to fix qemu_irq_intercept_in leak
      scripts/lsan_suppressions: suppress fontconfig leaks
      vfio/pci: close display console during unrealize, not finalize
      glib-compat: add fallback for g_clear_fd/g_autofd
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

 meson.build                     |   2 +
 hw/vfio/pci.h                   |   1 +
 include/glib-compat.h           |  29 ++++
 include/hw/core/irq.h           |   6 +-
 include/ui/console.h            |  20 +++
 include/ui/egl-helpers.h        |   1 +
 include/ui/gtk.h                |   6 +-
 include/ui/qemu-spice-module.h  |   1 +
 include/ui/qemu-spice.h         |   9 +-
 ui/dbus.h                       |   3 +
 hw/core/irq.c                   |  12 +-
 hw/vfio/display.c               |  30 ++--
 hw/vfio/pci.c                   |   1 +
 system/qtest.c                  |   5 +-
 system/runstate.c               |   4 +-
 tests/qtest/dbus-display-test.c | 101 ++++++++++-
 ui/console-vc.c                 |  13 ++
 ui/console.c                    |  71 +++++++-
 ui/curses.c                     |  17 +-
 ui/dbus-console.c               |  14 +-
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
 35 files changed, 909 insertions(+), 185 deletions(-)
---
base-commit: 3390aba56c354637eccd2d5ab5fd6efc2f026f06
change-id: 20260529-b4-ui-909bfa695735

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


