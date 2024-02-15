Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD481C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 12:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raaqb-0004oC-Ru; Thu, 15 Feb 2024 07:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raaqa-0004ni-Dp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:28:12 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkhapov@yandex-team.ru>)
 id 1raaqX-0007Za-CY
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 07:28:11 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:378d:0:640:d5c4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 96B6C60B6B;
 Thu, 15 Feb 2024 15:28:04 +0300 (MSK)
Received: from rkhapov-nux.yandex.net (unknown
 [2a02:6b8:82:604:e806:5ea2:b505:d402])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2Sofch4IeOs0-FzOkV0Im; Thu, 15 Feb 2024 15:28:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1708000083;
 bh=mEFQTZA3xDDWv0dTOMpSK63HRSQ/WKgYI6ap4BoICMY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=rnAfEoz85RG3//AwCBPBdhE3kUx8XF6htrwj7I1hrJqDBn2J0raQceEipTg2rw1SG
 sj+hQPCZl3fk6ECTZ4XpG/xNKlyDBw4nHUTkAH0scLBkBqoPkJBPyBjUfPzqVpsYb3
 UT25mU8S+PEvY5ipjTacpCscu0QcimIsVcJUoaTs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Roman Khapov <rkhapov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 yc-core@yandex-team.ru, Roman Khapov <rkhapov@yandex-team.ru>
Subject: [PATCH v2 0/2] Field 'reason' for MIGRATION event
Date: Thu, 15 Feb 2024 17:27:57 +0500
Message-Id: <20240215122759.1438581-1-rkhapov@yandex-team.ru>
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

This is resending of series 20240215082659.1378342-1-rkhapov@yandex-team.ru,
where patch subjects numbers were broken in patch 2/2.

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
 migration/migration.c | 128 ++++++++++++++++++++++++++++--------------
 migration/migration.h |   5 +-
 migration/multifd.c   |  10 ++--
 migration/savevm.c    |  24 ++++----
 qapi/migration.json   |   3 +-
 6 files changed, 112 insertions(+), 64 deletions(-)

-- 
2.34.1


