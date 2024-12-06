Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FCBE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRJ-00030D-K1; Fri, 06 Dec 2024 18:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRH-0002zg-Tp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRF-0005oR-Ku
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krqioHoTQdNwRuvR7MtcrFGHS6xQJDw54AA3n1d4vks=;
 b=PQ23eijbVAadqBUcqq2dwwV14RQc1xbdWK3QoxoNDDeXVeKmIN2MSSZGBpWoyczO60Vi47
 /QvelwZvElk03bXP3gon/vR94emC971xcaiEXkH/TXQ1akREXSQwza1hkX+j54AGhLmKYW
 IxudjncEcAeIU9z0eRJrL2ERC16ALDw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-zA9cu5YnM3CppgpR5cwVYQ-1; Fri, 06 Dec 2024 18:08:42 -0500
X-MC-Unique: zA9cu5YnM3CppgpR5cwVYQ-1
X-Mimecast-MFC-AGG-ID: zA9cu5YnM3CppgpR5cwVYQ
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a817be161bso6690815ab.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526521; x=1734131321;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krqioHoTQdNwRuvR7MtcrFGHS6xQJDw54AA3n1d4vks=;
 b=rsDShtXtitLsBnBMJFq16kn0ExMvlnHjiUb2H311m8h3cfK/Zm7yA1CNVVGcJR3PgV
 l2pkysWvFF/3P+xKmsVNcDfJrajDBGurmC98xmtqyPIXj7+sPmgIzaU1dtqrqhQoVkv2
 yDPfpeamrHXL2W/YeX6JtdA7rSlkRTa8EeA/Xvi6Waw6+eATHczKtLQ21rASjGkyip7o
 YqqTLMUPFMEBDJoylyETmqbo84M8/PDqwgyYJTA35+32Xc0I6ORdFl5hjyh6xQ7FAy2e
 bG1QQN4zrtYUdK5tYGlzuFapI3XJupzwC9rOFSmUrb1wbNlYFzpQB/1zMUIEUCuA5+g4
 F6Aw==
X-Gm-Message-State: AOJu0Yyl8/twD01vdYFxnEX7zDeBWJ2H41aZs/AOpdSTWLnEf5J/6MaV
 jgZUHaVRekKY613pwp7/6jpG2xIaKEvQRP8xIcasNqsnZ4Cj2cH16TeUh7hjkuEMZX70oJU9mGt
 nq1LgnDjL/F2cZvEWQOx5Zzq9FgVIWoqQ2rKfNNojLDCJ/oXUPZTaDrVQHFFtYxZIhkOMZfdEwf
 1Jhv6tNQF2UPslsFdmKzO5DzpA4pAvTkIuzQ==
X-Gm-Gg: ASbGncvecBLkDnNX9C9mYGhlDr9UyT7Nu1TWEVnzGcfMXke2kBbLOJsvi3FuVv9jSWf
 n8/lWe3U1xZ8VgxTD+j7HD9kclrro2cNTNysw/3kHu2v4p7/UTthrcmzJquacNf680xUCxD7Ttb
 hwYJ7ipvTYxiDN6pzNINLpHTrripr/Kr8KHK/GhMpTCnO7Xz1GEs9Ee2lFLmBsP7Ei2klaJ3olV
 tcwR3iK7kt3phSeJD1mwVaqHGec6qcQakC7p0lzy/XFG18FC0INZgY3lpwZfjZoLqWXk5zScTuo
 CMv/ivuwGZELnepWf2Gqq6Bk5A==
X-Received: by 2002:a92:c562:0:b0:3a7:deb1:169f with SMTP id
 e9e14a558f8ab-3a80757edb8mr107138885ab.6.1733526521133; 
 Fri, 06 Dec 2024 15:08:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDuZh2dKNI/TVr031mOB8HwicTQrWZdC/RNjUpnJJaL4Z4X0lJIXWyAdmu8y40iBzRuWqLNg==
X-Received: by 2002:a92:c562:0:b0:3a7:deb1:169f with SMTP id
 e9e14a558f8ab-3a80757edb8mr107138615ab.6.1733526520681; 
 Fri, 06 Dec 2024 15:08:40 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/6] migration/block: disk activation rewrite
Date: Fri,  6 Dec 2024 18:08:32 -0500
Message-ID: <20241206230838.1111496-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/1577280033
 (note: it's a pipeline of two patchsets, to save CI credits and time)

v1: https://lore.kernel.org/r/20241204005138.702289-1-peterx@redhat.com

This is v2 of the series, removing RFC tag, because my goal is to have them
(or some newer version) merged.

The major change is I merged last three patches, and did quite some changes
here and there, to make sure the global disk activation status is always
consistent.  The whole idea is still the same.  I say changelog won't help.

I also temporarily dropped Fabiano's ping-pong test cases to avoid
different versions floating on the list (as I know a new version is coming
at some point. Fabiano: you're taking over the 10.0 pulls, so I assume
you're aware so there's no concern on order of merges).  I'll review the
test cases separately when they're ready, but this series is still tested
with that pingpong test and it keeps working.

I started looking at this problem as a whole when reviewing Fabiano's
series, especially the patch (for a QEMU crash [1]):

https://lore.kernel.org/r/20241125144612.16194-5-farosas@suse.de

The proposed patch could work, but it's unwanted to add such side effect to
migration.  So I start to think about whether we can provide a cleaner
approach, because migration doesn't need the disks to be active to work at
all.  Hence we should try to avoid adding a migration ABI (which doesn't
matter now, but may matter some day) into prepare phase on disk activation
status.  Migration should happen with disks inactivated.

It's also a pure wish that, if bdrv_inactivate_all() could be benign to be
called even if all disks are already inactive.  Then the bug is also gone.
After all, similar call on bdrv_activate_all() upon all-active disks is all
fine.  I hope that wish could still be fair.  But I don't know well on
block layer to say anything meaningful.

And when I was looking at that, I found more things spread all over the
place on disk activation.  I decided to clean all of them up, while
hopefully fixing the QEMU crash [1] too.

For this v2, I did some more tests, I want to make sure all the past paths
keep working at least on failure or cancel races, also in postcopy failure
cases.  So I did below and they all run pass (when I said "emulated" below,
I meant I hacked something to trigger those race / rare failures, because
they aren't easy to trigger with vanilla binary):

- Tested generic migrate_cancel during precopy, disk activation won't be
  affected.  Disk status reports correct values in tracepoints.

- Test Fabiano's ping-pong migration tests on PAUSED state VM.

- Emulated precopy failure before sending non-iterable, disk inactivation
  won't happen, and also activation won't trigger after migration cleanups
  (even if activation on top of activate disk is benign, I checked traces
  to make sure it'll provide consistent disk status, skipping activation).

- Emulated precopy failure right after sending non-iterable. Disks will be
  inactivated, but then can be reactivated properly before VM starts.

- Emulated postcopy failure when sending the packed data (which is after
  disk invalidated), and making sure src VM will get back to live properly,
  re-activate the disks before starting.

- Emulated concurrent migrate_cancel at the end of migration_completion()
  of precopy, after disk inactivated.  Disks can be reactivated properly.

  NOTE: here if dest QEMU didn't quit before migrate_cancel,
  bdrv_activate_all() can crash src QEMU.  This behavior should be the same
  before/after this patch.

Comments welcomed, thanks.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2395

Peter Xu (6):
  migration: Add helper to get target runstate
  qmp/cont: Only activate disks if migration completed
  migration/block: Make late-block-active the default
  migration/block: Apply late-block-active behavior to postcopy
  migration/block: Fix possible race with block_inactive
  migration/block: Rewrite disk activation

 include/migration/misc.h |   4 ++
 migration/migration.h    |   6 +-
 migration/block-active.c |  94 +++++++++++++++++++++++++++
 migration/colo.c         |   2 +-
 migration/migration.c    | 136 +++++++++++++++------------------------
 migration/savevm.c       |  46 ++++++-------
 monitor/qmp-cmds.c       |  22 +++----
 migration/meson.build    |   1 +
 migration/trace-events   |   3 +
 9 files changed, 188 insertions(+), 126 deletions(-)
 create mode 100644 migration/block-active.c

-- 
2.47.0


