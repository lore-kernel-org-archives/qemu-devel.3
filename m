Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2DCC30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQPT-0007Je-Fh; Wed, 26 Jun 2024 07:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPQ-0007HE-1n; Wed, 26 Jun 2024 07:01:52 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQPM-0003S5-Sy; Wed, 26 Jun 2024 07:01:50 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1c20:0:640:f632:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5560B60F1E;
 Wed, 26 Jun 2024 14:01:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id P1OLrj0IhSw0-1TaEdKql; Wed, 26 Jun 2024 14:01:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719399700;
 bh=58T4tRCg4CRL4fpzaivwd8UNT5oKhRrVe86fLXtqedc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=dK5mZnqKdXl2eJ9BHgQlY1N3Bvw8dA7w4nflcK+puTvh0Jo1M9nbVU+fWvsxnRl4B
 S23XXLQali2x/wa7jsJJHupC8zUKB2wyEEpmwSTArG/uAOQRBw2Tqsg2XRhilTFTSc
 dSY8J7iXoy6Vea5CnKkLYDRA1TS+liNmPDftg2BQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, pkrempa@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 0/7] introduce job-change qmp command
Date: Wed, 26 Jun 2024 14:01:17 +0300
Message-Id: <20240626110124.374336-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi all!

This is an updated first part of my "[RFC 00/15] block job API"
Supersedes: <20240313150907.623462-1-vsementsov@yandex-team.ru>

v2:
- only job-change for now, as a first step
- drop "type-based unions", and keep type parameter as is for now (I now
  doubt that this was good idea, as it makes QAPI protocol dependent on
  context)
03: improve documentation
06: deprecated only block-job-change for now
07: new

Vladimir Sementsov-Ogievskiy (7):
  qapi: rename BlockJobChangeOptions to JobChangeOptions
  blockjob: block_job_change_locked(): check job type
  qapi: block-job-change: make copy-mode parameter optional
  blockjob: move change action implementation to job from block-job
  qapi: add job-change
  qapi/block-core: derpecate block-job-change
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


