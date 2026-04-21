Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF60F94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHay-0000uw-2K; Tue, 21 Apr 2026 16:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHaw-0000uH-Qm
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHau-0008Bk-KW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9adj77LoG/K3NSf2FVkJM97xr60l2Lnk6pP8u4l8F+o=;
 b=ajerbpk+wXqBeUfT5fFWdrq54aYjQPhdJSFd44zmPn6uB4/8yc7+1NzEjjiJiP8A1Z4Zvf
 3bVwpoKS2/tlV/pwpIdImyciywwt/utFwTE0p6bT/basxpOz0NJm3EdMstIxmFfLlYXmhP
 wulYWp3IFfQzAEW5uMjA1+JF/fhCfZc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-zaZ-73_uNuWBmYQu99TxNw-1; Tue, 21 Apr 2026 16:21:14 -0400
X-MC-Unique: zaZ-73_uNuWBmYQu99TxNw-1
X-Mimecast-MFC-AGG-ID: zaZ-73_uNuWBmYQu99TxNw_1776802874
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a22dbeeb96so94192016d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802873; x=1777407673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9adj77LoG/K3NSf2FVkJM97xr60l2Lnk6pP8u4l8F+o=;
 b=oCugs/PpGUoUZO5aVJBGJXeqBO83VxDwbQjRpVM2aIGu0GK8cwlKzaFPbEv+zTgPpz
 slVlWsBYQP9vzGXr6OnlU+/M1Gkz8V/jXnA5UycJM7Xx0imPhNE/5PG6WB1amWbfRE/M
 5lSidaU5RKtMA1k4LdoyfQArXrFfro0GcSehP3sHgx7X8ALV/ChTLcaxykNy0z8lj6Jt
 lbHNxhlClHaK8BtMEH0PAwMZq2MS96vA60sC+xcIPZt+7oblEPAPCgaf6q/DVr163lm8
 xHlGsKj9afgIXnGlJvMuRqWRZsb1xJAgDRzcR62Pn1KIQQ5iDNHyDgjplU9mWLfdeBh+
 gXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802873; x=1777407673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9adj77LoG/K3NSf2FVkJM97xr60l2Lnk6pP8u4l8F+o=;
 b=T0rcYrml3Htn2oeOHCtkWjVvtVjFNSKO4cU1tX3CxDGrAS0GrdEE5e7B3yataqbpGp
 CsI87AtjXFnTKWo7r7S/9IHqaECNIRGtLuoZQ+GLzAZUP3nOXkUXkHTOsT0Af6DqYVfh
 Adn7+8w5tUtxehAOOe/7nOHSapsSdZPq1gh3lDaBpN/YiRYocihmkMRVO8A+8hxDSNpt
 nraeteV6xh/KyJvzd23L7FX64/i8j6tBbUPxojCU5cfLA0fPlh6foLjm1glgUA+glphM
 Vla1JiQ0/gnYGLuIDan6nWEgSljVb8SD2DggInClWc/aOD8EBv3pNpGYvDM18OG32/ex
 vnfQ==
X-Gm-Message-State: AOJu0YxRIco+02xBUEzVD7LHcOstfV9UT0tkbtDRNfpy9xMjaBSnUKjg
 gFcuXsmu6CB9ul+E7t/yWRYRQ+x3ueMoZgQoZxnLxXe+P5afGnhNZVMoJKmYboqoeltwpmKaFSy
 42otyb/0fzWY8SBml9vnxe6yh9w5MgvgqWcn2q9OSb6v4DUZlsh6LY6yZToPqmKILSeKth/gd3p
 Db1fDTRsRuiU+l4M+KgCK6SoYbrUIqzwJWNaeY3g==
X-Gm-Gg: AeBDieuz0Z+2okqEpgWOWRO4jjVHtGsPsmE6KU0zMxzmXQOkObiBiFidSdloqoUcuRV
 Q2YIeN8yFcJ0gqU4Vym1bSp1RnlgnGtzI6bNtS2gunuAfgqMmceQP6hijEQyfZ8eWkkltYuyX72
 I14TN3hG4yuCSlU6rwgNim0aWj5zc9FVwj8RtEp4Lq1Ymjh/tDPsSG8NwNOIUwdLiOmMziFEcX0
 XTU2a5nEA3tBAir+ekMk7scubexAOLNXioCkDiu2G3N2p86pFCmKzWB5ilq4xKF13qX4/Kkwlt8
 RB5QA1AaavPKc1VpKR9OzXenorhBE3Kb2v+RWA4gVeUKV31za4WtxYBgTgzC6c35nVUig6HyJEg
 TDJYilMPHN2EK4efMDdu+qXiXVtKd73owqVtKzuKXdNzv3RA44gpodiHGPw==
X-Received: by 2002:a05:6214:33ca:b0:89c:d808:c255 with SMTP id
 6a1803df08f44-8b0281d57b4mr338200676d6.37.1776802873169; 
 Tue, 21 Apr 2026 13:21:13 -0700 (PDT)
X-Received: by 2002:a05:6214:33ca:b0:89c:d808:c255 with SMTP id
 6a1803df08f44-8b0281d57b4mr338199506d6.37.1776802872432; 
 Tue, 21 Apr 2026 13:21:12 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 00/16] migration/vfio: Fix a few issues on API misuse or
 statistic reports
Date: Tue, 21 Apr 2026 16:20:54 -0400
Message-ID: <20260421202110.306051-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

CI:  https://gitlab.com/peterx/qemu/-/pipelines/2469074018
rfc: https://lore.kernel.org/r/20260319231302.123135-1-peterx@redhat.com
v1:  https://lore.kernel.org/r/20260408165559.157108-1-peterx@redhat.com

v2:
- Added tags
- Patch 4
  - Fix and rework doc for @save_query_pending [Juraj]
  - Trace "exact" in trace_vfio_state_pending() [Avihai]
  - Avoid mentioning "pre-copy" in vfio.rst doc for query [Avihai]
- Patch 12
  - English errors [Fabiano]
- Patch 13
  - Remove " (bytes)" in HMP line [Fabiano]
- Added patch "qemu-iotests: Add query-migrate test for dirty-bitmap"
  - This covers a bug that I found when testing v1
- Added patch "vfio/migration: Add tracepoints for precopy/stopcopy query
  ioctls" to be able to dump the raw results from the two VFIO ioctls
- Replace patch "migration: Make qemu_savevm_query_pending() available
  anytime" with patch "migration: Remember total dirty bytes in mig_stats"
  - I fell back to "cache the total dirty bytes" idea on this one to avoid
    complication of save_query_pending() invoked anywhere.

Overview
========

VFIO migration was merged quite a while, but we do still see things off
here and there.  This series tries to address some of them, but only based
on my limited understandings.

Two major issues I wanted to resolve:

(1) VFIO reports state_pending_{exact|estimate}() differently

It reports stop-only sizes in exact() only (which includes both precopy and
stopcopy data), while in estimate() it only reports precopy data.  This is
violating the API.  It was done like it to trigger proper sync on the VFIO
ioctls only but it was only a workaround.  This series should fix it by
introducing stopcopy size reporting facility for vmstate handlers.

(2) expected_downtime / remaining doesn't take VFIO devices into account

When query migration, QEMU reports one field called "expected-downtime".
The document was phrasing this almost from RAM perspective, but ideally it
should be about an estimated blackout window (in milliseconds) if we
switchover anytime, based on known information.

This didn't yet took VFIO into account, especially in the case of VFIO
devices that may contain a large amount of device states (like GPUs).

For problem (2), the use case should be that an mgmt app when migrating a
VFIO GPU device needs to always adjust downtime for migration to converge,
because when it's involved normal downtime like 300ms will normally not
suffice.

Now the issue with that is the mgmt doesn't have a good way to know exactly
how well the precopy goes with the whole system and the GPU device.

The hope is fixed expected_downtime will provide one way for the mgmt app
to have a reasonable hint for downtime to setup to converge a migration.

Meanwhile, with a system-wise "remaining" field introduced, mgmt can query
this results at beginning of each iteration to know if a stall is
happening, IOW, if it's likely that this migration will not converge at
all.  When detected, mgmt can start to consider the expected_downtime value
reported above for converging this migration.  See more on testing below.

Tests
=====

Thanks to Cédric on help testing v2.  One thing to mention is we did
encounter one case where we observed reported dirty size overflowed for
uint64_t (on both expected_downtime and system remaining data).

Quotes from test results from Cédric, migrating a RHEL9 VM with a vGPU
(NVIDIA L4-2B) and an MLX5 VF, from a RHEL9 host (vGPU mdev) to a RHEL10
host (vGPU VF), with the vGPU under load (glxgears):

(qemu) info migrate
Status:                 active
Time (ms):              total=21140, setup=86, exp_down=152455434886355 <---- !?!
Remaining:              16 EiB                                          <---- !?!
RAM info:
  Throughput (Mbps):    967.98
  Sizes:                pagesize=4 KiB, total=4 GiB
  Transfers:            transferred=2.29 GiB, remain=4.7 MiB
    Channels:           precopy=1.91 GiB, multifd=0 B, postcopy=0 B, vfio=387 MiB
    Page Types:         normal=499427, zero=559708
  Page Rates (pps):     transfer=0, dirty=1892
  Others:               dirty_syncs=3

It got fixed itself after a few more rounds of iterations, so it also
didn't affects migration ultimately.  Further attempts didn't reproduce it
after I added the tracepoint patch. It would be good if someone knows if it
was a known driver issue.

For detailed testing steps, please refer to v1's cover letter.

Peter Xu (16):
  qemu-iotests: Add query-migrate test for dirty-bitmap
  migration: Fix low possibility downtime violation
  migration/qapi: Rename MigrationStats to MigrationRAMStats
  vfio/migration: Cache stop size in VFIOMigration
  migration/treewide: Merge @state_pending_{exact|estimate} APIs
  migration: Use the new save_query_pending() API directly
  migration: Introduce stopcopy_bytes in save_query_pending()
  vfio/migration: Fix incorrect reporting for VFIO pending data
  migration: Move iteration counter out of RAM
  migration: Introduce a helper to return switchover bw estimate
  migration: Calculate expected downtime on demand
  migration: Fix calculation of expected_downtime to take VFIO info
  migration: Remember total dirty bytes in mig_stats
  migration/qapi: Introduce system-wise "remaining" reports
  migration/qapi: Update unit for avail-switchover-bandwidth
  vfio/migration: Add tracepoints for precopy/stopcopy query ioctls

 docs/about/removed-features.rst               |   2 +-
 docs/devel/migration/main.rst                 |   9 +-
 docs/devel/migration/vfio.rst                 |   9 +-
 qapi/migration.json                           |  32 ++--
 hw/vfio/vfio-migration-internal.h             |   8 +
 include/migration/register.h                  |  59 +++---
 migration/migration-stats.h                   |  20 +-
 migration/migration.h                         |   2 +-
 migration/savevm.h                            |   7 +-
 hw/s390x/s390-stattrib.c                      |   9 +-
 hw/vfio/migration.c                           | 123 +++++++-----
 migration/block-dirty-bitmap.c                |  10 +-
 migration/migration-hmp-cmds.c                |   5 +
 migration/migration.c                         | 177 +++++++++++++-----
 migration/ram.c                               |  40 +---
 migration/savevm.c                            |  42 ++---
 hw/vfio/trace-events                          |   5 +-
 migration/trace-events                        |   3 +-
 .../tests/migrate-bitmaps-postcopy-test       |   6 +
 19 files changed, 322 insertions(+), 246 deletions(-)

-- 
2.53.0


