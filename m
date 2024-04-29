Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3BCC41513
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 07:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1LsI-0005Wf-CC; Mon, 29 Apr 2024 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Ls7-0005V0-4R
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:56:24 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Lrz-0003ZB-9M
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 03:56:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D343860B30;
 Mon, 29 Apr 2024 10:56:08 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xtKJiB1IWmI0-5E3TUprU; Mon, 29 Apr 2024 10:56:08 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714377368;
 bh=LTPZpa6b2SIAJLiaZOK+A2tg2vHsnx4VgJLqurSbzjc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=l5UWIk6lqO3hkAytxKG9cywi5J/51ak1aCGBWRdVEITkQQcpJuZkPbKrWTQi6JvJK
 ZogfIuIXFCEpUQ4WMI2RiZSvFALHReNxny/NMoIHfgbt6lF2E09kiS+qHDR2Iawmwd
 5EmXo5cJgKfMcqX7yCdLo7Bf3tCa5DoSv5r2WGUU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v4 0/4] migration: do not exit on incoming failure
Date: Mon, 29 Apr 2024 10:55:37 +0300
Message-Id: <20240429075541.1959050-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

The series brings an option to not immediately exit on incoming
migration failure, giving a possibility to orchestrator to get the error
through QAPI and shutdown QEMU by "quit".

v4:
- add r-b and a-b by Fabiano and Markus
- improve wording in 04 as Markus suggested

v3:
- don't refactor the whole code around setting migration error, it seems
  too much and necessary for the new feature itself
- add constant
- change behavior for HMP command
- split some things to separate patches
- and more, by Peter's suggestions


New behavior can be demonstrated like this:

bash:

(
cat <<EOF
{'execute': 'qmp_capabilities'}
{'execute': 'migrate-set-capabilities', 'arguments': {'capabilities': [{'capability': 'events', 'state': true}]}}
{'execute': 'migrate-incoming', 'arguments': {'uri': 'exec:echo x', 'exit-on-error': false}}
EOF
sleep 1
cat <<EOF
{'execute': 'query-migrate'}
{'execute': 'quit'}
EOF
) | ./build/qemu-system-x86_64 -incoming 'defer' -qmp stdio -nographic -nodefaults

output:

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 9}, "package": "v9.0.0-149-gb6295ad58c"}, "capabilities": ["oob"]}}
{"return": {}}
{"return": {}}
{"timestamp": {"seconds": 1714068847, "microseconds": 263907}, "event": "MIGRATION", "data": {"status": "setup"}}
{"return": {}}
{"timestamp": {"seconds": 1714068847, "microseconds": 266696}, "event": "MIGRATION", "data": {"status": "active"}}
qemu-system-x86_64: Not a migration stream
{"timestamp": {"seconds": 1714068847, "microseconds": 266766}, "event": "MIGRATION", "data": {"status": "failed"}}
{"return": {"status": "failed", "error-desc": "load of migration failed: Invalid argument"}}
{"timestamp": {"seconds": 1714068848, "microseconds": 237187}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
{"return": {}}


Vladimir Sementsov-Ogievskiy (4):
  migration: move trace-point from migrate_fd_error to migrate_set_error
  migration: process_incoming_migration_co(): complete cleanup on
    failure
  migration: process_incoming_migration_co(): rework error reporting
  qapi: introduce exit-on-error parameter for migrate-incoming

 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 57 ++++++++++++++++++++++++----------
 migration/migration.h          |  3 ++
 migration/trace-events         |  2 +-
 qapi/migration.json            |  7 ++++-
 system/vl.c                    |  3 +-
 6 files changed, 54 insertions(+), 20 deletions(-)

-- 
2.34.1


