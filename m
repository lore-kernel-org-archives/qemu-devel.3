Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33850CD98C8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wa-00063z-E7; Tue, 09 Jun 2026 15:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wO-0005zc-O9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wL-00060x-P0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b4e1ade7so64265965e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032604; x=1781637404; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2DwmuT8tKhclQ1g1qavrDUDE5tcbEb5fZR0A04ACrTg=;
 b=lw8k0DMUjJ7lRuuVuw5+q+SImhumhj/u9RwO0eECn/QztEpi/LFfQvvlB+78M8mLQT
 G60LiBVZ8mLFDniMl2fVCznWNlA3Azce+lk0ANxNxZPAWMFlbwJFW38ITdum/ieWkdMB
 HxLxDo6R7fZt06H/2W1HUx3zjsuXtIn3AD1UZT19xNZhBO76+gXOSjf/LaheB2l68zWk
 yezgsfG0/Kg5IavwsPOQzpNTh7vfJNr2t8HjLFYjM0nTatNq1XjGMa7NHMPwAsC1nWsS
 VqUnKqoeZ6snWlIMc4oLsYkwjqF20fhxN9YHVTuR7o+SBdZrBmti+jAy7d4E0+NjLWCQ
 6znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032604; x=1781637404;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DwmuT8tKhclQ1g1qavrDUDE5tcbEb5fZR0A04ACrTg=;
 b=FvaD9jFHTSYfkBBJCrZviAMciUzVvuCESw6oKrlCjWQt1tadsos8gi9+5VnCF+w6SG
 mjuf9ODFQCp49mbqTp8Z6tQqLRdjU0ezgcjmgJZhHshrnBKvPRSC2b0ea7MV0PFKU0ag
 sDJdOZZuA3CZH4iijOCAXsiH33X59GUYhEj6i6+P5hOLN29yKIrZ2jnxFhczQtufZb6x
 GiybAkRcsGbloWZYx7/sZ7EEAMIvdG7ZQJgYIF1KdN7N8+n+YlDBupaV/2koiIDE47/i
 717WnWs3E8h2bUHvX6Xc449R0gmI3Ggdmc+Wp0cnHm7Zptv7eg8hofHElFFcdyJqX9I9
 Ym2w==
X-Gm-Message-State: AOJu0Yx84+EoDQhL3cW8vvtWwNGNCz4Ydh35d7syPx3X53Y5XzZD+Fhs
 htHIyBAkl4cvnQxwx4eANiC7hyoYX1g1HDfGO5B9dCHwy41qrwJYWeR9
X-Gm-Gg: Acq92OFf/nbTGBjHMZi1mATIYfHKYV+V/sslbzxaz3q5GTHzfcgP2EY3eZi215sU5jf
 zyjD1LZRYv+eX8+/E+ngIutNkFCooA/IG77UluTwWZQTW/OzRuxX7JGNhpzMFAvPRugixIzeWvK
 P8VQJS/ZizOBJYFewZ+s0KJV2RjtWnycyReR1A1wbrrBVJJA/q2pcrbjiRbJ3aNdgdPE2tt2oFl
 MIwa9dC/68g2uKbYgfiJ9kBM5neXbiCGTRy/kWAFFJmDrOYfdDrL05n+R+iQtBUzIbDKrNZ2yMn
 5cfvunTkS/7BkP0ek+ShJtCF9mU/RDEln29BHeQMfc0hAXsfsy0RUMFoohCiXxrImC8HO0LlI/e
 e9Q/WWFd6pnpoujVeu/tpGCQvz4cvuM6LoCCaeh8hU1Vn/gmGVmwzwosImMJF13RdeTG6h0VB5r
 clgBdJHJNTVwjZ9u/bAcpib15RGPBDFYlXEpx++w8LmXoWQRgMxOYK7m5pWLDb+DX01ZHu2ZxWt
 g==
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490c2604735mr343046885e9.20.1781032603823; 
 Tue, 09 Jun 2026 12:16:43 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3c1149sm444146535e9.4.2026.06.09.12.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:43 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH v7 00/12] virtio-console: notify about the terminal size
Date: Tue, 09 Jun 2026 21:16:10 +0200
Message-Id: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOQWrDMBCF4asEraswGo0kq6veo2ShqONYEFtBC
 qZp8N0rBwKmocu3+H7eXVQuiat4391F4TnVlKc23NtOxCFMJ5bpq22BgAa8QhnzVPOZZeGaflh
 6GwkVwTFAJxq6FO7T9yP4eWi7L3mU16FweGYALHplCUjtyaHBTio55YGGWj9OY0jnfczj2hpSv
 eZye3ybaS3+e2MmCdJ5NExEoY+0Ka03ZrPhqF64abzzrKN16MDCX26f3IJS/oXbxrUO7ghaQ3B
 hy5dl+QWR0JaxZgEAAA==
X-Change-ID: 20250912-console-resize-96c42140ba08
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=5433;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=JvG/s1HwbgQFzaww8ZVgPpLtn3Aw0c6cISimHJspuuE=;
 b=ibX0F6lzYjL67ffKmZHOpLUpSRipidk+7fC92e1ry3Acpfoon/kZf5ttf0KVIhevY+jp+pc8e
 L34b/BTSaclBMmEDymUKiM8mMna6G2x9R/FOQEcQuvnrOYrlp9pNzRy
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Summary of The Series
---------------------

This series adds terminal size support to the virtio-console device.
The goal is to make it possible to get a resizable terminal into a guest
without using e.g. ssh.

Support for detecting terminal size is added to stdio and vc backends,
but not pty and serial, because for the later it's unfortunately
impossible to get resize notifications.

A QMP command is added for notifying QEMU about the terminal size
of any chardev. This can be used by clients to support resizing for
devices where QEMU is not able to detect the size by itself (e.g. virsh
console).

There was a bug in Linux versions prior to 6.15 which caused the
dimensions to be interpreted incorrectly by the guest. The fix has
been backported to currently supported kernels, but to avoid making the
terminal harder to use on out of date guests, the feature is disabled
by default and must be enabled with the console-size property.

Limitations
-----------

There is still no documentation for the console-size property, which
would be nice to have so that people can discover this functionality.

Resizing support for the spice version of 'vc' chardev is still missing.

After migration, the guest is not informed about the new console size
(fixing this requires migration stream changes).

Full Changelog
--------------

v7:
- Rebased
- Renamed some functions
- Made virtio size support disabled by default
- "Since: 11.0" -> "Since: 11.1"
- Dropped "must exist" from chardev id param description in qmp docs
- Link to v6: https://lore.kernel.org/qemu-devel/20260119-console-resize-v6-0-33a7b0330a7a@gmail.com

v6:
- Rebased (renaming CharBackend -> CharFrontend)
- Virtio resize message code rewritten to fix corner cases
- Updated version numbers ('Since: 11.0', hw_compat_10_2)
- Added note to CHR_EVENT_RESIZE definition comment, explaining
  that only the focused frontend gets the event
- Fixed checkpatch warning (line length)
- Link to v5: https://lore.kernel.org/qemu-devel/20250921-console-resize-v5-0-89e3c6727060@gmail.com

v5:
- Rename chardev-resize -> chardev-window-size-changed
- Improve chardev-window-size-changed documentation
- Add partial implementation for 'vc' chardev
- Config space now returns port 0 size if multiport
- Console-size property completely disables size support
- Fix misnamed variables in char-win-stdio
- Link to v4: https://lore.kernel.org/qemu-devel/20250912-console-resize-v4-0-7925e444afc4@gmail.com

v4:
- Changed order of rows and cols fields
- Added support for terminal size on Windows
- Trace event is also emitted for legacy (non-multiport) drivers
- Minor fixes required because of changes in QEMU (DECLARE_INSTANCE_CHECKER, qmp-example)
- Updated version numbers ('Since: 10.2', hw_compat_10_1)
- Link to v3: https://lore.kernel.org/qemu-devel/20200629164041.472528-1-noh4hss@gmail.com

v3:
- Add resize messages over QMP, as suggested by Daniel

v2:
- Fix adding a new virtio feature bit to the virtio console device

---
Filip Hejsek (4):
      char-win-stdio: add support for terminal size
      ui/console-vc: forward text console size to vc chardev
      ui/gtk: forward gtk console size to vc chardev
      virtio-serial-bus: add terminal resize messages

Szymon Lukasz (8):
      chardev: add cols, rows fields
      chardev: add CHR_EVENT_RESIZE
      chardev: add qemu_chr_resize()
      char-mux: add support for the terminal size
      main-loop: change the handling of SIGWINCH
      char-stdio: add support for the terminal size
      qmp: add chardev-window-size-changed command
      virtio-console: notify the guest about terminal resizes

 backends/cryptodev-vhost-user.c   |  1 +
 chardev/char-fe.c                 | 13 +++++++
 chardev/char-mux.c                | 19 ++++++++-
 chardev/char-stdio.c              | 30 +++++++++++++++
 chardev/char-win-stdio.c          | 19 +++++++++
 chardev/char.c                    | 26 +++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/char/terminal3270.c            |  1 +
 hw/char/trace-events              |  1 +
 hw/char/virtio-console.c          | 35 +++++++++++++++--
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 hw/ipmi/ipmi_bmc_extern.c         |  1 +
 hw/scsi/vhost-user-scsi.c         |  1 +
 hw/usb/ccid-card-passthru.c       |  1 +
 hw/usb/dev-serial.c               |  1 +
 hw/usb/redirect.c                 |  1 +
 hw/virtio/vhost-user-base.c       |  1 +
 hw/virtio/vhost-user-scmi.c       |  1 +
 include/chardev/char-fe.h         | 10 +++++
 include/chardev/char.h            |  9 +++++
 include/hw/virtio/virtio-serial.h |  7 ++++
 include/qemu/main-loop.h          |  4 ++
 monitor/hmp.c                     |  1 +
 monitor/qmp.c                     |  1 +
 net/passt.c                       |  1 +
 net/vhost-user.c                  |  1 +
 qapi/char.json                    | 31 +++++++++++++++
 ui/console-vc.c                   |  8 ++++
 ui/curses.c                       | 11 +++---
 ui/gtk.c                          | 28 ++++++++++++++
 util/main-loop.c                  | 21 ++++++++++
 31 files changed, 356 insertions(+), 11 deletions(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20250912-console-resize-96c42140ba08

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


