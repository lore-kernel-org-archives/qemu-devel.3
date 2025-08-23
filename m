Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE505CA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6H-0004Xh-Hz; Sat, 23 Aug 2025 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6D-0004Up-Te
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:34 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw69-00053t-Mn
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 549C78073C;
 Sun, 24 Aug 2025 00:48:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-0KWdIOvx; Sun, 24 Aug 2025 00:48:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985704;
 bh=wbBorqqEWfXJJFpeUpfDGfqpsSY88A9+GV2LqkdQv9s=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=NDKUuIGF+7Co4O9UQdkZ/bNp+7I7utvmVpzA8WV/DnMmLGoUQcdi+hG8NBS2o5vZ9
 jM1Jl8IQBvI8xeUfn5WNsN0X4Kug/inNldKFtnGs5iAYIWmwNSog3KRczLrkkyAtBm
 oM+7txnDxGpWzMhAcDHUbghkG1QzzIDhSvOTPTmk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 0/7] virtio-net: live-TAP local migration
Date: Sun, 24 Aug 2025 00:48:14 +0300
Message-ID: <20250823214821.48342-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

That's a kind of alternative to
[RFC V2 0/8] Live update: tap and vhost
https://patchew.org/QEMU/1752777568-236368-1-git-send-email-steven.sistare@oracle.com/

Instead of using CPR with additional stage and channel to pass FDs,
we just pass everything we need (including FDs) through main
migration channel (of-course, it should be unix socket). So,
it's similar to live-backend vhost-user-blk migration which I propose in
[PATCH 00/33] vhost-user-blk: live-backend local migration
https://patchew.org/QEMU/20250813164856.950363-1-vsementsov@yandex-team.ru/

The series is based on
[PATCH 00/33] vhost-user-blk: live-backend local migration
and
[PATCH v2 00/20] TAP initialization refactoring

The series is also pushed to tag up-tap-fd-migration-v1 here:
https://gitlab.com/vsementsov/qemu/-/tree/up-tap-fd-migration-v1?ref_type=tags

The series is working draft, so marked as RFC. Next steps would be
implementing a test, and smarter migration of vhostnet
(without reinitialization of vhost).

The last patch provides a kind of stand to test these series, and it
also can help with testing "[RFC V2 0/8] Live update: tap and vhost"

Based-on: <20250823160323.20811-1-vsementsov@yandex-team.ru>
Based-on: <20250823160323.20811-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (7):
  net/tap: add some trace points
  net/tap: keep exit notifier only when downscript set
  qapi: add interface for local TAP migration
  net/tap: implement interfaces for local migration
  virtio-net: support local tap migration
  net/tap: experimental support for vhost in local tap migration
  RFC: add python/tap-migration-stand.py

 hw/net/virtio-net.c            | 100 +++++++++-
 include/hw/virtio/virtio-net.h |   2 +
 include/net/tap.h              |   4 +
 migration/options.c            |   7 +
 migration/options.h            |   1 +
 net/tap.c                      | 226 ++++++++++++++++-----
 net/trace-events               |   7 +
 python/qemu/machine/machine.py |  37 ++--
 python/tap-migration-stand.py  | 348 +++++++++++++++++++++++++++++++++
 qapi/migration.json            |   9 +-
 qapi/net.json                  |  12 +-
 11 files changed, 681 insertions(+), 72 deletions(-)
 create mode 100755 python/tap-migration-stand.py

-- 
2.48.1


