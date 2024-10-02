Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44BECF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw00n-0003jv-B9; Wed, 02 Oct 2024 10:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00Q-0003T4-GD; Wed, 02 Oct 2024 10:07:09 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sw00G-000567-8t; Wed, 02 Oct 2024 10:06:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3644B609FF;
 Wed,  2 Oct 2024 17:06:47 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S6cR231IXeA0-Mre5wuhk; Wed, 02 Oct 2024 17:06:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727878006;
 bh=z0QkAhbNxQ2kH1qjWpzcYpPUOuwPfwgrKKlnr1g4BpE=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=IaE+4homGgawSUwl7XJ9FIQoKsNDE9Sz4Cp6ZRp6EY6yqAQAFMJFovtSGNL4pSoRB
 BEfpqhuTH03MhJRqQuBM3QJvg1C85ZVul2Szi9yokylHKSfN76drG8jIVxXgZ6uqmx
 2Zu2Vq7Glfz5xtjt5WqGTElGNBBuIN1asWYNTKWY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com
Subject: [PATCH v3 0/7] introduce job-change qmp command
Date: Wed,  2 Oct 2024 17:06:09 +0300
Message-Id: <20241002140616.561652-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all!

Here is new job-change command - a replacement for (becoming deprecated)
block-job-change, as a first step of my "[RFC 00/15] block job API"

v3:
01: add a-b by Markus
03: add a-b by Markus, s/9.1/9.2/ in QAPI
05: update commit message, s/9.1/9.2/ in QAPI
06: update commit message (and subject!), s/9.1/9.2/ in deprecated.rst

Vladimir Sementsov-Ogievskiy (7):
  qapi: rename BlockJobChangeOptions to JobChangeOptions
  blockjob: block_job_change_locked(): check job type
  qapi: block-job-change: make copy-mode parameter optional
  blockjob: move change action implementation to job from block-job
  qapi: add job-change
  qapi/block-core: deprecate block-job-change
  iotests/mirror-change-copy-mode: switch to job-change command

 block/mirror.c                                | 13 +++++---
 blockdev.c                                    |  4 +--
 blockjob.c                                    | 20 ------------
 docs/about/deprecated.rst                     |  5 +++
 include/block/blockjob.h                      | 11 -------
 include/block/blockjob_int.h                  |  7 -----
 include/qemu/job.h                            | 12 +++++++
 job-qmp.c                                     | 15 +++++++++
 job.c                                         | 23 ++++++++++++++
 qapi/block-core.json                          | 31 ++++++++++++++-----
 .../tests/mirror-change-copy-mode             |  2 +-
 11 files changed, 90 insertions(+), 53 deletions(-)

-- 
2.34.1


