Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E96C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:12:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEt-0003vI-EC; Wed, 13 Mar 2024 11:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEX-0003Zu-J4; Wed, 13 Mar 2024 11:09:35 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEU-0005ri-Uy; Wed, 13 Mar 2024 11:09:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 41EF760D8E;
 Wed, 13 Mar 2024 18:09:25 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-BZqVpFvQ; Wed, 13 Mar 2024 18:09:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342564;
 bh=bq1oSVHrO6mDu3NXsiJ7OwRGXqAr5Z7+VxKp4uo20dQ=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=VfucZFE1SYYUlqA6M6YsS3Gu4jvrdmENzShMOQDinf03k1nbKsdd+24QnhZPe0Q6N
 b3oC7A9tMGGP2zHP7kq3A2kGqUNnl6VsJCq5ztHguFBvHalp96n/yjG/CYNqtApXcY
 yZE0YplhnizTPlNMbRDSTevRFWSi0OXdfjjtUdHQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 00/15] block job API
Date: Wed, 13 Mar 2024 18:08:52 +0300
Message-Id: <20240313150907.623462-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The series aims to reach feature parity between job-* and block-job-*
APIs and finally deprecate block-job-* APIs.

01: new type-based unions for QAPI

02-07: rework block-job-change and add similar job-change command

08: support set-speed in new API (as an option to job-change)

09: support soft-cancelling ready mirror job in new API (as an
    option to job-complete)

10-14: prepare query-jobs to substitute query-block-jobs

15: finally, deprecate old APIs

RFC: the series are untested. I plan to move tests to using new APIs
instead of deprecated ones in v2.

Vladimir Sementsov-Ogievskiy (15):
  scripts/qapi: support type-based unions
  qapi: rename BlockJobChangeOptions to JobChangeOptions
  blockjob: block_job_change_locked(): check job type
  qapi: block-job-change: make copy-mode parameter optional
  qapi: JobChangeOptions: make type member optional and deprecated
  blockjob: move change action implementation to job from block-job
  qapi: add job-change
  qapi: job-change: support speed parameter
  qapi: job-complete: introduce no-block-replace option for mirror
  qapi: query-jobs: add information specific for job type
  job-qmp: job_query_single_locked: add assertion on job ret
  qapi: rename BlockDeviceIoStatus to IoStatus
  qapi: move IoStatus to common.json
  qapi: query-job: add block-job specific information
  qapi/block-core: derpecate block-job- APIs

 block/backup.c                              |  14 ++
 block/block-backend.c                       |  14 +-
 block/commit.c                              |  16 ++-
 block/mirror.c                              |  98 +++++++++-----
 block/monitor/block-hmp-cmds.c              |   4 +-
 block/stream.c                              |  14 ++
 blockdev.c                                  |   4 +-
 blockjob.c                                  |  39 +++---
 docs/about/deprecated.rst                   |  75 +++++++++++
 include/block/blockjob.h                    |  26 ++--
 include/block/blockjob_int.h                |   7 -
 include/qemu/job.h                          |  25 +++-
 include/sysemu/block-backend-global-state.h |   2 +-
 job-qmp.c                                   |  55 +++++++-
 job.c                                       |  35 ++++-
 qapi/block-core.json                        | 136 +++++++++++++++-----
 qapi/common.json                            |  16 +++
 qapi/job.json                               |  69 +++++++++-
 scripts/qapi/introspect.py                  |   5 +-
 scripts/qapi/schema.py                      |  50 ++++---
 scripts/qapi/types.py                       |   3 +-
 scripts/qapi/visit.py                       |  43 ++++++-
 stubs/meson.build                           |   1 +
 stubs/qapi-jobchangeoptions-mapper.c        |  13 ++
 tests/unit/test-bdrv-drain.c                |   2 +-
 tests/unit/test-block-iothread.c            |   2 +-
 tests/unit/test-blockjob.c                  |   2 +-
 27 files changed, 616 insertions(+), 154 deletions(-)
 create mode 100644 stubs/qapi-jobchangeoptions-mapper.c

-- 
2.34.1


