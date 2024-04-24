Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2407C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzgeZ-0003NX-1e; Wed, 24 Apr 2024 13:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeV-0003MS-Hi
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:27 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rzgeP-0004iK-5Z
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:43:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 50C10609CB;
 Wed, 24 Apr 2024 20:43:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8811::1:29])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kgPOp63Iaa60-2Cef4kAv; Wed, 24 Apr 2024 20:43:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713980594;
 bh=CwbyAIff+N5GEmqRyCgcenHqcP96VzePJztpyU8IeDY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=W3G5gnmmKfgG/TjAq7UdiCYEK0K50ohmbp79/PylzeDOe99jBYWjjFq2X2aqGhc0i
 NxeUYnUZ+wiTUUg4reXXoNVpRstBD/BC10mzberUmXAfyTg3x8CDp9J6sAj8ERpJXT
 tXEsjCDtfTXlQ42zHji+4wcoX2rLLZCHbnN/FVRo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v2 0/2] migration: do not exit on incoming failure
Date: Wed, 24 Apr 2024 20:42:43 +0300
Message-Id: <20240424174245.1237942-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy (2):
  migration: rework migrate_set_error() to migrate_report_err()
  qapi: introduce exit-on-error paramter for migrate-incoming

 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 79 +++++++++++++++-------------------
 migration/migration.h          |  5 ++-
 migration/multifd.c            | 18 +++-----
 migration/postcopy-ram.c       |  3 +-
 migration/savevm.c             | 16 +++----
 qapi/migration.json            |  7 ++-
 system/vl.c                    |  7 +--
 8 files changed, 60 insertions(+), 77 deletions(-)

-- 
2.34.1


