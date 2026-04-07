Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AE4FF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXL-00009h-8F; Tue, 07 Apr 2026 14:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wABTx-0003xC-77
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:01 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1wA0vm-0007bX-JL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:33:04 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C7B39416BE;
 Tue,  7 Apr 2026 07:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D697C116C6;
 Tue,  7 Apr 2026 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775547180;
 bh=McMCEJCD2QmIBezTAHXNBYH5nhWhqi9NahlqALGxo0o=;
 h=From:Subject:Date:To:Cc:From;
 b=UtlZRx+Zp8I1OVbO0Nynk9B4+jWwa5s/oT3XaWDzpWEjh0V/igmZyXwPyfqvsBXPf
 4On9OUsDKwuLtbE2YYuhwpyt5ZBdUu5qs9UQz+PFdVkmns5lX65c1bWnBppmLTnXZ6
 36kzs/Qpv/28Kf6CqsTCiJNU6eI65ttIt/hdu1Frf9J570v7NiMXjW8DcyenknVT4U
 i1jFBBvyoSB1bCelOOHkCqQe2cMy9O82yWm6NOEEKun5UVULMzPEOMf8GhuSLr6eHr
 8IdHIv3HmYgKnqWHGmKhrFzVvA8EJurEXNj1uzFF5kK98T9DKmNW7FwTWxabnESBCe
 25sdT09xdHwHw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/5] monitor: add dynamic QMP monitor hotplug support
Date: Tue, 07 Apr 2026 09:32:44 +0200
Message-Id: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByz1GkC/43OOxKCMBAG4Ks4qV2HBAG18h6ORR4rRCXBDaCOw
 91NtNHGsfz38e0+WECyGNhm9mCEow3Wuxjy+YzpRroawZqYmchEmS0zAVdPJ7i0HbTe2d4TNL7
 vzkMNByUrXfIV5kaxuN4RHuztRe/27xwGdUTdJy9NKBkQFEmnm1RqZeiRUqOxIcr311MjT8Af9
 0cOGZQ5z2WhjSmq5faE5PC88FSz9MAoPqXihySiJE2h0Bix5pX8kqZpegJLswdRNgEAAA==
X-Change-ID: 20260402-work-qmp-monitor-hotplug-fba7c618e3db
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4490; i=brauner@kernel.org;
 h=from:subject:message-id; bh=McMCEJCD2QmIBezTAHXNBYH5nhWhqi9NahlqALGxo0o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRe2ax0MWDjeT7vEP+XO5Ps4yYpfync/zztvBGDpfivw
 9dDK27Hd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkoATDfzfzD+eOK7ot2TBX
 aFrZ/r2fDxvsZXPfkL370u+FegIHOhQYGXrFudUWBB87Vr+I8fO559WKN02m//gU9lxkZ33fpcJ
 yD3YA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU supports runtime hotplug for chardevs, devices, block backends,
and netdevs. Monitors are the only major subsystem that lacks this --
all QMP monitors must be configured at launch via -mon or -qmp CLI
options.

This series adds monitor-add, monitor-remove, and query-monitors QMP
commands so that management tools can create independent QMP sessions
on demand at runtime.

I've implemented a QMP-to-Varlink bridge in systemd. This allows
systemd-vmspawn to control virtual machines and containers through a
unified Varlink interface. Varlink allows protocol upgrades. For
example, it is possible to switch from Varlink to say http. I'm
allowing Varlink clients to upgrade from the Varlink interface to the
native QMP interface. Such clients get a new monitor assigned that
allows them to manage the virtual machine directly via QMP. The main
monitor remains unaffected and tied to the generic Varlink interface. We
can't pre-allocate monitors as we have no control over how many protocol
upgrades we actually get but it won't just be one. And having unused
monitors around really isn't ideal either.

Having the ability to hotplug monitors would really be helpful. I'm not
yet super well-versed in qemu internals so this might be done wrong but
testing works so far.

My systemd patch that triggered this is at
https://github.com/systemd/systemd/pull/41449.

The usage pattern mirrors chardev hotplug:

  -> chardev-add id=qmp-extra backend=socket,...
  -> monitor-add id=extra-qmp chardev=qmp-extra
  [client connects to socket, gets QMP greeting, negotiates, sends commands]
  -> monitor-remove id=extra-qmp
  -> chardev-remove id=qmp-extra

Patches 1-2 add the data model (id/dynamic/dead fields in Monitor) and
the infrastructure for safe per-monitor destruction without shutting
down the shared dispatcher coroutine.

Patch 3 adds the QAPI schema and command handlers.

Patches 4-5 add qtest unit tests and a functional e2e test that
performs a full hotplug -> connect -> handshake -> unplug cycle.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Use SPDX license identifier in functional test.
- Use framework's socket_dir() helper instead of manual tempfile
  handling for socket paths in the functional test, drop tearDown().
- Tighten struct field comments in monitor-internal.h.
- Wrap long qtest_add_func() registration line.
- Link to v2: https://patch.msgid.link/20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org

Changes in v2:
- Fix use-after-free in self-removal path: skip monitor_resume() when
  the monitor is dead to avoid scheduling a BH against a monitor that
  is about to be freed by monitor_qmp_destroy().
- Hold monitor_lock in monitor_find_by_id() to prevent races with
  the I/O thread BH that appends to mon_list.
- Deduplicate monitor-remove commit message: trim the gcontext/out_watch
  explanation that repeated the infrastructure commit, reference
  monitor_cancel_out_watch() instead.
- Add missing test descriptions to patch 4 (chardev-in-use, CLI monitor
  rejection, HMP monitor rejection) and patch 5 (self-removal, large
  response, events).
- Fix cover letter wording.
- Link to v1: https://patch.msgid.link/20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org

---
Christian Brauner (5):
      monitor: store monitor id and dynamic flag in Monitor struct
      monitor/qmp: add infrastructure for safe dynamic monitor removal
      qapi: add monitor-add, monitor-remove, query-monitors commands
      tests/qtest: add tests for dynamic monitor add/remove
      tests/functional: add e2e test for dynamic QMP monitor hotplug

 include/monitor/monitor.h                        |   3 +-
 monitor/monitor-internal.h                       |  11 ++
 monitor/monitor.c                                |  70 +++++++--
 monitor/qmp-cmds-control.c                       | 111 ++++++++++++++
 monitor/qmp.c                                    |  77 +++++++++-
 qapi/control.json                                | 104 +++++++++++++
 tests/functional/generic/meson.build             |   1 +
 tests/functional/generic/test_monitor_hotplug.py | 170 +++++++++++++++++++++
 tests/qtest/qmp-test.c                           | 186 +++++++++++++++++++++++
 9 files changed, 717 insertions(+), 16 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260402-work-qmp-monitor-hotplug-fba7c618e3db


