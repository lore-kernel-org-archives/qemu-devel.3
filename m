Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFBFC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jIT-0003SG-La; Tue, 30 Apr 2024 04:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIP-0003Nl-VK
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:05 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIM-0000vZ-Ed
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1663060D41;
 Tue, 30 Apr 2024 11:56:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id muME9V11IOs0-Q3bMqc1A; Tue, 30 Apr 2024 11:56:57 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714467417;
 bh=1+wrdB6JdLQGe8WF6UboKL65ysrjsgVMaRBJcTQGf80=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=vZDm0/uAPjp36n/Iadn7Drvq/x2oGjNaO+Uq4bClCIJeK7qQh+awdVCEMt3xw4o47
 c8zEOFeZ0QTnDJth/FSRns7Yj3wynpakUw+Z15u7HskWjmQVEUnDDUR/pR7vtctLPH
 PusHoai+jfU0pZb9lmSB84Iyx9G9J12USaiMzj9M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v6 0/5] migration: do not exit on incoming failure
Date: Tue, 30 Apr 2024 11:56:41 +0300
Message-Id: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v6:
01,02: add r-b by Peter
03: only fix potential use-after-free
04: rework error handling, drop r-b


v5:
- add "migration: process_incoming_migration_co(): fix reporting s->error"

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

Vladimir Sementsov-Ogievskiy (5):
  migration: move trace-point from migrate_fd_error to migrate_set_error
  migration: process_incoming_migration_co(): complete cleanup on
    failure
  migration: process_incoming_migration_co(): fix reporting s->error
  migration: process_incoming_migration_co(): rework error reporting
  qapi: introduce exit-on-error parameter for migrate-incoming

 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 54 ++++++++++++++++++++++++----------
 migration/migration.h          |  3 ++
 migration/trace-events         |  2 +-
 qapi/migration.json            |  7 ++++-
 system/vl.c                    |  3 +-
 6 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.34.1


