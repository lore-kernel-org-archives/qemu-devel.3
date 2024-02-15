Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65EA1C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raX5R-0007uT-LZ; Thu, 15 Feb 2024 03:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raX5Q-0007uD-GG
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:27:16 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raX5O-0004eX-Jq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:27:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:36ad:0:640:5aad:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 76D8D611AC;
 Thu, 15 Feb 2024 11:27:06 +0300 (MSK)
Received: from rkhapov-nux.yandex.net (unknown
 [2a02:6b8:82:604:e806:5ea2:b505:d402])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4RkUWR5IgKo0-WDaZG9Gg; Thu, 15 Feb 2024 11:27:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1707985625;
 bh=NyDYNroxU0pS4XHXexMJByeeztRBF8CZA8qk7CO85go=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=MuGsYktCXPHoFhbnfz7L38iPRKTvQP5Thh5iSeJfwrCKGapd+2AJjFT8dTNYtQafa
 yJUYp0GbekW1MixMILsDUfd7drWHVUU1R11aO31n+MEbUB/Vc2iNAJQTGNfYPaXver
 HVD8+DtafvdgVPf7uDXl6iLOZQs4UurJmqkH43b0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Roman Khapov <rkhapov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 yc-core@yandex-team.ru, Roman Khapov <rkhapov@yandex-team.ru>
Subject: [PATCH 0/2] Add field reason to event MIGRATION
Date: Thu, 15 Feb 2024 13:26:57 +0500
Message-Id: <20240215082659.1378342-1-rkhapov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=rkhapov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sometimes, when migration fails, it is hard to find out
the cause of the problems: you have to grep qemu logs.
At the same time, there is MIGRATION event, which looks like
suitable place to hold such error descriptions.

To handle situation like this (maybe one day it will be useful
for other MIGRATION statuses to have additional 'reason' strings),
the general optional field 'reason' can be added.

The series proposes next changes:

1. Adding optional 'reason' field of type str into
   qapi/migration.json MIGRATION event

2. Passing some error description as reason for every place, which
   sets migration state to MIGRATION_STATUS_FAILED

After the series, MIGRATION event will looks like this:
{"execute": "qmp_capabilities"}
{"return": {}}
{"event": "MIGRATION", "data": {"status": "setup"}}
{"event": "MIGRATION", "data": {"status": "failed", "reason": "Failed to connect to '/tmp/sock.sock': No such file or directory"}}

Roman Khapov (2):
  qapi/migration.json: add reason to MIGRATION event
  migration: add error reason for failed MIGRATION events

 migration/colo.c      |   6 +-
 migration/migration.c | 127 ++++++++++++++++++++++++++++--------------
 migration/migration.h |   5 +-
 migration/multifd.c   |  10 ++--
 migration/savevm.c    |  24 ++++----
 qapi/migration.json   |   3 +-
 6 files changed, 111 insertions(+), 64 deletions(-)

-- 
2.34.1


