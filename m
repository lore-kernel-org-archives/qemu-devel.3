Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B3DD31A09
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 06:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfufL-0001vz-E7; Wed, 14 Jan 2026 01:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf4-0001py-5d
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:22 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vfuf1-0004A1-5W
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 01:47:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 087B38077D;
 Wed, 14 Jan 2026 09:47:14 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c88::1:7])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ClNQD90AqW20-LhQ8baom; Wed, 14 Jan 2026 09:47:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768373233;
 bh=F8Fu1PGmjQTnBc0qlUzsZ4pTahAoIwFbVe92/GdHpiQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=WdDmN07JtuM5u5qmVCAUuWfdj5bSPpKh+f+F49vqefpTG/l5RKHQO2LZ3fsQEVE1N
 mQV0W9XvXmo+PdMzr18udj2rrB5dORcVSRYdv9BBkepsEcxvqu+WtAssOXYizzdZEB
 QOjhsWwwYx2AkTTVfjdsXyWXqaXDtf7/aMlarkmk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 0/5] qemu-file: qemu_file_get_fd() cleanup
Date: Wed, 14 Jan 2026 09:47:05 +0300
Message-ID: <20260114064710.176268-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

Here are some generic improvements around qemu_file_get_fd() interface
and failure path.

Vladimir Sementsov-Ogievskiy (5):
  vmstate-types: get_fd(): handle qemu_file_get_fd() failure
  qemu-file: qemu_file_get_fd(): fail if no expected fd come
  qemu-file: qemu_file_get_fd(): get byte in one shot
  qemu-file: qemu_file_get_fd(): check service byte itself
  qemu-file: qemu_file_get_fd(): improve interface

 migration/qemu-file.c     | 41 ++++++++++++++++++++++++---------------
 migration/qemu-file.h     |  2 +-
 migration/vmstate-types.c |  5 +++--
 3 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.48.1


