Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D317C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTzE-0000pe-4b; Wed, 26 Jun 2024 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTzC-0000oc-5e; Wed, 26 Jun 2024 10:51:02 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTz9-0005UC-MW; Wed, 26 Jun 2024 10:51:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AA75560B8A;
 Wed, 26 Jun 2024 17:50:53 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eoRt0i0IXKo0-suQkD7sX; Wed, 26 Jun 2024 17:50:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719413453;
 bh=dNgwoHQal6rdWpuxTJDfWE2OVEHbh4SAoYO3xYiQGiE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=c/Pi47ewMGEQDXm+IwqeS/oZfufu+UU8/ias649r3ZOBV5xE4JBUgRGMtTRLOnfJY
 hAgovosi2PlLHkl6Tc7m6Z4Onus7MlNO4YIAmKtVZHrHZOOTxQrGmBb8kex+74mu5g
 IXqcx0ksNfEDx2/WkpeHJM+U71KkEmCh2GMWvDv0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 0/3] block-jobs: add final flush
Date: Wed, 26 Jun 2024 17:50:35 +0300
Message-Id: <20240626145038.458709-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Actually block job is not completed without the final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Mirror job already has mirror_flush() for this. So, it's OK.

Add similar things for other jobs: backup, stream, commit.

v2: rework stream and commit, also split into 3 commits.

Vladimir Sementsov-Ogievskiy (3):
  block/commit: implement final flush
  block/stream: implement final flush
  block/backup: implement final flush

 block/backup.c             |  2 +-
 block/block-copy.c         |  7 ++++
 block/commit.c             | 41 +++++++++++++++--------
 block/stream.c             | 67 +++++++++++++++++++++++---------------
 include/block/block-copy.h |  1 +
 5 files changed, 77 insertions(+), 41 deletions(-)

-- 
2.34.1


