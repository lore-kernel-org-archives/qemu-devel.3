Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE21F3D5E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 13:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9NGR-0006VQ-Bg; Sun, 05 Apr 2026 09:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGK-0006Tn-Pd
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:37 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGI-0006cW-SZ
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:36 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 351256001A;
 Sun,  5 Apr 2026 13:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935D9C116C6;
 Sun,  5 Apr 2026 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775394692;
 bh=Mv1cwnfF+cb83p3K4P7Z7Twk5nRgBI0T46wsJ+2+Z3c=;
 h=From:Subject:Date:To:Cc:From;
 b=Xw/tVr9sZktgI3/Aw6c49UVnA6V9E8NrwSz6ZOgUa9KVO2DR7m/mxIkOB2an8Yn8J
 yQUqpRgGxXBCPFj4euDpcV4GCG3iJpISJmNku0glx9oEtkOAA4QwR357948C9mI3wp
 TkgL5uRZUPSWGXkQBqKorGlLfW4SKrlubRx7IauAoNOoJWHK23RjtdEwhRd9LZ7ECj
 M57N+JaeSPbCCBU9ktUg8HdTb+jwqPgEWl1mADChhYeax4EEbFQpJ31qW9hjz2B6Ao
 KqUM4SllwU09LRWOKGbG9tfZTqZc3GO37M+4hBTIbpwCDGrj2sz/+qIh20dH8DsKhP
 DovYagXcarRRg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/5] monitor: add dynamic QMP monitor hotplug support
Date: Sun, 05 Apr 2026 15:11:16 +0200
Message-Id: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHRf0mkC/42OyxKCMAxFf4Xp2ji8cVz5Hw6LPgJUoMUUUIfh3
 23xB1yem+TcbMwhaXTsGm2McNVOW+MhPUVMdty0CFp5ZmmclnEep/Cy1MNznGC0Rs+WoLPzNCw
 tNIJXskwumCnB/PlE2Oj3ob7XP3aLeKCcgy9sCO4QBHEjuxCN3M1IYdBp582f46k1CYI/+tcEY
 iizJOOFVKqo8luPZHA4W2pZve/7F2Pj4pDsAAAA
X-Change-ID: 20260402-work-qmp-monitor-hotplug-fba7c618e3db
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4078; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Mv1cwnfF+cb83p3K4P7Z7Twk5nRgBI0T46wsJ+2+Z3c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReiq974Bz2KO6ZyOHmN4LGkz4l5qhxXuJhXP753Y64U
 7/mJTgkd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0XmG/44TlX/u9LPI7Lat
 9G+44vv41HKhl4duycw52L1dKIDHwI7hn4numi9nZltPPSHvkn/4qM3EnG03m5yMRNos2LIcj09
 5xAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=brauner@kernel.org; helo=tor.source.kernel.org
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
 tests/functional/generic/test_monitor_hotplug.py | 183 ++++++++++++++++++++++
 tests/qtest/qmp-test.c                           | 185 +++++++++++++++++++++++
 9 files changed, 729 insertions(+), 16 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260402-work-qmp-monitor-hotplug-fba7c618e3db


