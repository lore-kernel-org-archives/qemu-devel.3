Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E93410F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYT2-0006Uq-Vg; Wed, 08 Apr 2026 15:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY48-0006Kz-Hu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCF-00026l-Ru
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vPGwVEPm25tSQpDsHhbt2i6JsuPl+TWsf9MJqPYEbeQ=;
 b=d4Kocig//KHjnCTrQ1m8jBPJEbbk+QIKYEnKE2wVmTsPMit8itmQP3KVEjHr91mZ+U3jhz
 ni0XBSw/A8TaB5Me/2qb09iB9dIZhVd7nKFxeCNmQlRqqXOMjbADGMxFQOgtrFH+0RBN4m
 Vs9KWetm50tzrLP3eiM0bwJ9v5K4SrA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Tsv1w9nHMv69WVGXS_ix7Q-1; Wed, 08 Apr 2026 12:56:03 -0400
X-MC-Unique: Tsv1w9nHMv69WVGXS_ix7Q-1
X-Mimecast-MFC-AGG-ID: Tsv1w9nHMv69WVGXS_ix7Q_1775667363
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4b81c632so3267431cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667362; x=1776272162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vPGwVEPm25tSQpDsHhbt2i6JsuPl+TWsf9MJqPYEbeQ=;
 b=DTWm8ZmyyGgONwr6EOyoJqKWKPAt0hgkgxy/kjToZ4wUnw18T9RELkjVEK79wmC1tK
 qRohfgXmK8Ci3KGQFNFXZ+O6ZUZiEdC/Zto1On9v+3CRare12RsfYxASNd5uukuVaJKX
 7cPcmc4VIHmrRfMXBzB7BxSfmF6etmZGFinf9U5ekSJa/AckOAYCcdjP9Qgnv3IsVWyo
 FVh7WU4DKelSB0WVaodoc8bJI0WjhqgCUYo5yio9Xr0bXiA9A2BnbM6LHBkYx7PxDZCN
 cpdAOgnpJEG1cW4tCmIEr7cOF0QSqTnTY6FSp65QWXAQSTUQkbSjSWSeQJvUtZhPsII/
 LuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667362; x=1776272162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPGwVEPm25tSQpDsHhbt2i6JsuPl+TWsf9MJqPYEbeQ=;
 b=GF3ut/sOsez5uuOtF17HSmzxb2kQkRe/iJCtkTbEA1DoE3ZRbDgSozNxETRictcfto
 IEeiE2K2u9hcrL14K69Zhxm/tEh6ipIE8Oca7Q/LPpxJVyWbJFRbCMSMy160BBV/PtNK
 r766sFVG2vf8lpcsnk5dSWDecBl8dgocl4vEbyQu4rtbJIRFucjF2B3LkN2pw6MXBeIr
 abcgOPNAvPDjslQgWndIFpavPt3RgBmSVXiSG3POlyI/3yDOrl2eUS4OK3zux+WKpSEj
 08bi1wD0f25g0yf92luHbAWZoP9d6TUK/ERsCMwFRn6vOLJOPXfVcaZzMzIXU3JUyaDS
 vNeA==
X-Gm-Message-State: AOJu0YzULKI8cmvXUKHh5W1n5QHlZrFFArEHGxTzi3DrEMuMShgHtX1j
 d1mRcUk1dCnOZgVlkkwyRx39ZPQvQvLNdffR+CimOKecVgjy6mUaEZG6TVf+jmX/+G63OADm6lU
 72BUjC3/KzM+vilGfgSAj1JU3Ftk55lrHB3uAnB/sPODsIpRkPPHfogNr28Qyka7n55xf54qlRD
 U+6LVRgnmGUqI2MK/MwIvxwyFVRqDBvB4FsWxIkA==
X-Gm-Gg: AeBDietGyIbb2c6uuF+N3KWvB15EmwU7oPZqGwFq1YSTtfGPwiVkkMq0kCAOWFEqsHf
 stFHfG0ZAqqfO53Y4tvplzSC7YY8tzfGqWWw0LZCMpehCUD+lQzCeVX4S4o5riUDVALECZc/GfG
 z4sKjA2w8yDgMAXBAlSsdJIHiQsCGQwgwGW8aEuo0wu6+vemw2fnCNmdZa7UaKO2uPbk7WuLcB3
 TdXAM5IBumkjqxn8Rb9rxelFBaXojsAMVuXUEo08e4OPqywzszcSWYLIU55OSRUImQjHmFStDwQ
 QFWg51GjxbMxzE5HZjBSpMRNrb4qYnqVwF+TXMD7Hwap60nuVE6otx5qXRvFPB6BDzJ3CDj7lxZ
 fKZo3m2UU0RRWU5Lsq57bJRBaTrZ9zNMRBeOhYC9KD6I+
X-Received: by 2002:a05:622a:145:b0:50d:643b:378f with SMTP id
 d75a77b69052e-50d643b421amr330586841cf.57.1775667362229; 
 Wed, 08 Apr 2026 09:56:02 -0700 (PDT)
X-Received: by 2002:a05:622a:145:b0:50d:643b:378f with SMTP id
 d75a77b69052e-50d643b421amr330586031cf.57.1775667361445; 
 Wed, 08 Apr 2026 09:56:01 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: [PATCH 00/14] migration/vfio: Fix a few issues on API misuse or
 statistic reports
Date: Wed,  8 Apr 2026 12:55:44 -0400
Message-ID: <20260408165559.157108-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2437886506
rfc: https://lore.kernel.org/r/20260319231302.123135-1-peterx@redhat.com

This is v1 of this series.  I dropped RFC because I feel like I collected
enough feedback on previous version on what is uncertain, meanwhile I also
managed to borrow a system with nVidia RTX6000 2GB vGPU and tested it.

There're too many trivial things changed since RFC->v1 here, let me only
mention what majorly has changed:

- This version will assume both VFIO ioctls (reporting either precopy or
  stopcopy size) may report anything (say, garbage), and it shouldn't crash
  QEMU.  It will affect what got reported with downtime or remaining data,
  but that's best effort so it's expected.  With that in mind, I dropped
  patch 3 as Avihai suggested.  IOW, I expect no concern on either overflow
  / underflow or atomicity on reading these values from the VFIO drivers.

- The cached stopcopy_bytes for VFIO reflects always the total size
  (includes precopy sizes).

- Introduced one new patch to report "system-wide" remaining data, which
  will start to include VFIO remaining device data.  We can't squash that
  directly into "ram" section of query-migrate QMP results, so I introduced
  a new "remaining" field in query-migrate result for it.

- One more patch "migration: Make qemu_savevm_query_pending() available
  anytime" trying to fix a very hard to hit race condition I found when
  testing against virtio-net-failover tests.  I can only hit it if I run
  tens of concurrent tests, but it will be needed to fix a crash.

Otherwise the major things should be kept almost as-is.  I should also
addressed all comments I received from rfc version.  Please shoot if I
missed something.

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

Tested this series with an assigned VFIO device GRID RTX6000-2B, FB memory
2GB.

The test covers both correct reporting of system-wise remaining data (which
used to only cover RAM), and the expected downtime.  I verified that using
the expected downtime I can converge a VFIO migration immediately according
to the value reported. Test process as below:

Start the VM and kick off migration until it spins at the end, not
converging with default 300ms downtime.  It's common for a 2GB vGPU device
due to both huge stopsize reported and dramally small mbps reported.

As a start, update avail-switchover (I chose 1GB over a real 10Gbps port):

This will stablize bandwidth.

Libvirt's domjobinfo won't be able to see the real remaining data because
libvirt still doesn't support the new "remaining" field, however we can
still see expected_downtime will be reported correctly now (instead of
reporting zero, before this patch applied):

Data remaining:   0.000 B
Memory remaining: 0.000 B
Expected downtime: 1910         ms

If we peek through QEMU monitor, we'll see with the change the system-wise
remaining data to be 1.9GB (even if RAM keeps reporting 0), and expected
downtime keeps the same as what domjobinfo reports as 1.9 seconds:

Status:                 active
Time (ms):              total=336919, setup=10, exp_down=1910
Remaining (bytes):      1.91 GiB
RAM info:
  Throughput (Mbps):    460.09
  Sizes:                pagesize=4 KiB, total=32 GiB
  Transfers:            transferred=12.7 GiB, remain=0 B
    Channels:           precopy=12.7 GiB, multifd=0 B, postcopy=0 B, vfio=0 B
    Page Types:         normal=3306906, zero=7745576
  Page Rates (pps):     transfer=14010, dirty=8039
  Others:               dirty_syncs=247045

It means 1.91 seconds are required as lowest downtime per math.

We can try to set something lower than that, migration will not converge:

...
...

Then if we update downtime_limit to be slightly larger than expected downtime:

Migration will complete almost immediately.

Peter Xu (14):
  migration: Fix low possibility downtime violation
  migration/qapi: Rename MigrationStats to MigrationRAMStats
  vfio/migration: Cache stop size in VFIOMigration
  migration/treewide: Merge @state_pending_{exact|estimate} APIs
  migration: Use the new save_query_pending() API directly
  migration: Introduce stopcopy_bytes in save_query_pending()
  vfio/migration: Fix incorrect reporting for VFIO pending data
  migration: Make qemu_savevm_query_pending() available anytime
  migration: Move iteration counter out of RAM
  migration: Introduce a helper to return switchover bw estimate
  migration: Calculate expected downtime on demand
  migration: Fix calculation of expected_downtime to take VFIO info
  migration/qapi: Introduce system-wise "remaining" reports
  migration/qapi: Update unit for avail-switchover-bandwidth

 docs/about/removed-features.rst   |   2 +-
 docs/devel/migration/main.rst     |   9 +-
 docs/devel/migration/vfio.rst     |   9 +-
 qapi/migration.json               |  32 +++---
 hw/vfio/vfio-migration-internal.h |   8 ++
 include/migration/register.h      |  59 ++++------
 migration/migration-stats.h       |  13 ++-
 migration/migration.h             |  10 +-
 migration/savevm.h                |   9 +-
 hw/s390x/s390-stattrib.c          |   9 +-
 hw/vfio/migration.c               |  92 +++++++++-------
 migration/block-dirty-bitmap.c    |  10 +-
 migration/migration-hmp-cmds.c    |   5 +
 migration/migration.c             | 172 +++++++++++++++++++++---------
 migration/ram.c                   |  40 ++-----
 migration/savevm.c                |  73 +++++++------
 hw/vfio/trace-events              |   3 +-
 migration/trace-events            |   3 +-
 18 files changed, 313 insertions(+), 245 deletions(-)

-- 
2.53.0


