Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5142FD6AB18
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8PS2-0003jA-Bf; Thu, 02 Apr 2026 17:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PS1-0003ir-Gc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:41 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w8PRz-0004aV-OW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:19:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B0A760008;
 Thu,  2 Apr 2026 21:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D8AC116C6;
 Thu,  2 Apr 2026 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775164770;
 bh=eNz4TXeQwYYgzP9FaqhnGrCXXRK7/qAMuiJdSkNwQv4=;
 h=From:Subject:Date:To:Cc:From;
 b=TxUdEPvbekbNd6XvuhhwHAZjQNaY2r9aO8C4MFOakkkTWeNIR2iMfccDXjoVGQAvs
 uUH8Alqgn78BMC7EhBdh68u7s8DoCEVnB62+9T2EXVdkNLAqLedZPrBOihQsdWitvk
 nu60kLCpMDZHw9IpG8tAhSTE4w78/SPRy4dafz+MYaotFL7d7DHQFTWROf4xRFSkuy
 gwGB+lfzBXfNeHgYl5pKMSnOgTdpJT5SdTmBowj+wTZYUMWi9nVlCrMOjnECcytIqn
 qbuxMQYocrHyLIQ1FF6NemxtvtnzWStMK5M5QZl5urMuMpPwP3w+MjJOam7wb0M5p2
 YFKrGTeCqsB1w==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/5] monitor: add dynamic QMP monitor hotplug support
Date: Thu, 02 Apr 2026 23:19:15 +0200
Message-Id: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPdzmkC/yWMyw7CIBBFf6WZtZNQNNX4K8YF0GlB5eFA1aTpv
 wu6PDf3nBUysaMM524FppfLLoYK/a4DY1WYCd1YGaSQgzgIie/Id3z6hD4GVyKjjSU9lhknrY5
 m6E+0HzVUPTFN7vNLX65/zou+kSmt1x5aZULNKhjbJq9yIYZt+wKAziXmlQAAAA==
X-Change-ID: 20260402-work-qmp-monitor-hotplug-fba7c618e3db
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eNz4TXeQwYYgzP9FaqhnGrCXXRK7/qAMuiJdSkNwQv4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSeuxsfNnPG3tz26n6m8ED+O9k39EzeJO1/kOHHkLjm1
 YIFQmkfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYisJaRYWdT5ja2F7xv+1mD
 pp/bJH7x/p5d75aJ7945z/LquqRtl00ZGY5f9b2WWTYped60VPm2Xyxc+7rClmdZ5gs9+nfUIkf
 rLSMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I've currently implemented a bridge that bridges QMP and Varlink in
systemd. This allows sytemd-vmspawn to control virtual machines and
containers through a unified Varlink interface. Varlink allows protocol
upgrades. For example, it is possible to switch from Varlink to say
http. I'm allow Varlink clients to upgrade from the Varlink interfact to
the native QMP interface. Such clients get a new monitor assigned that
allows them to manage the virtual machine directly via QMP. The main
monitor remains unaffected and tied to the generic Varlink interface.
We can't pre-allocate monitors as we have no control over how many
protocol upgrades we actually get but it won't just be one. And having
unused monitors around really isn't ideal either.

Having the ability to hotplug monitors would really be helpful. I'm not
yet super well-versed in qemu internals so this might be done wrong but
testing works so far.

My systemd patch that triggerd this is at
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
Christian Brauner (5):
      monitor: store monitor id and dynamic flag in Monitor struct
      monitor/qmp: add infrastructure for safe dynamic monitor removal
      qapi: add monitor-add, monitor-remove, query-monitors commands
      tests/qtest: add tests for dynamic monitor add/remove
      tests/functional: add e2e test for dynamic QMP monitor hotplug

 include/monitor/monitor.h                        |   3 +-
 monitor/monitor-internal.h                       |   8 ++
 monitor/monitor.c                                |  15 +++-
 monitor/qmp-cmds-control.c                       |  94 ++++++++++++++++++++
 monitor/qmp.c                                    |  41 ++++++++-
 qapi/control.json                                | 106 +++++++++++++++++++++++
 tests/functional/generic/meson.build             |   1 +
 tests/functional/generic/test_monitor_hotplug.py | 102 ++++++++++++++++++++++
 tests/qtest/qmp-test.c                           | 101 +++++++++++++++++++++
 9 files changed, 467 insertions(+), 4 deletions(-)
---
base-commit: b6a7d06213e5d2f7d124d16418bc289c4a8a4b82
change-id: 20260402-work-qmp-monitor-hotplug-fba7c618e3db


