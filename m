Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF94E7716C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdcS-0003B0-Oi; Tue, 03 Dec 2024 19:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcK-000394-0a
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdcH-0005Kn-Qo
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0fl4riJXkkfo/96dvAXYYNvSSH0WhrAGlbwismyIdZM=;
 b=QGFvOE8duz/R3dsR0McK5iAgDhqa3iYMhccgJ2lDYz0Su/xmZwrE6E35nC/fLaD90vwGDx
 lNx/mqyWy9Y8r0wfGKWp8c9BnV5iLgqjIag3SVWGJ62tidsjXGJSfJdj0hMbpfPpn9X5bd
 MAfSNAWdeTCSfXOXVpHHg8Pe0Dwvexo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Mv-23AFRNvS9CZz_ZROqbA-1; Tue, 03 Dec 2024 19:51:42 -0500
X-MC-Unique: Mv-23AFRNvS9CZz_ZROqbA-1
X-Mimecast-MFC-AGG-ID: Mv-23AFRNvS9CZz_ZROqbA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b665521dabso93600185a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273501; x=1733878301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fl4riJXkkfo/96dvAXYYNvSSH0WhrAGlbwismyIdZM=;
 b=m10N2yjbLpFddftJ+XWuWP0G+LtmcIwB/FFhy5Ay+QDdxhnw+vx1XyXqvIsGpC5OK0
 mDvJQf9eQQ2PThte1uIbUGQkAIq1673qzK06D2PtwdQogSMxy0O0e0LB3LruEUtJwvxG
 DHHuAdMeTHl3ul9CRO6ntGaxRmXqut8s/Ui8g9j7z/qrZHjNskRzPVwAS6A4T29ySxRR
 Lta9RpR+hFj21VYbmOkNHe8WrCTy9S2VYlaloEflh6Tbwcw+CxKkTcQnJ0tUgTInl1oF
 Fq9PT6x4JBFZ6C/SMdP3eusWM56/kHiZ9aBLbRLiAzDAoVGMqmJYjxNzzP8PC8uPF2Fp
 Jzrg==
X-Gm-Message-State: AOJu0YwRHixjOTzXlQzJ3LX0rCqHSFIPTMspOQFTXN+xe0Gpqf0s4vK6
 dkDgfCmP8fwYE/t8Vtsq0Jzcw65ICQChrJWIE7lJ+OOHhyhlaoI3mzzCuq8wEJn+AUgZ9YoatgQ
 rm+nW2DwzQ4r/laVdiJXhzzLFjEfm+ZBX9tfGMXpfTQWTXifCchBNk9AJNJQnFkrbnixQVefcSx
 18JUVbytTavyPybuSFm6fOsdH+cKoEaGZY5Q==
X-Gm-Gg: ASbGnctGeoyweMXfcQeY/ihtFDEhao4BxjcdF5zKm8WNwBQ0iAqp49jGQX0u7v13pVs
 iW/thvU4J+GAc12gappJFn0zXgajJtXo3Nkqt8KAzmFz4tX/F+eO0HKBwD6E6NKWxNXwI7372yp
 7/ub5JgYVdvMcNZ7nm11pGQbwyk/o9caj211HBz1K08iW8Ohm+HQZULPw8wRfHaSNi31ZcYSY8k
 8ZN8BfJg4kE+pqRskIo66VFAt82DJegZGV7lYxuKH9PnwXHzQhfkoa9wmnn/vcF6m4ZaySgpm3F
 xO4RYXCezt0Vn1o4HN+dcPdflw==
X-Received: by 2002:a05:620a:46a6:b0:7b1:1fdd:d54f with SMTP id
 af79cd13be357-7b683a8337dmr4455284885a.29.1733273501367; 
 Tue, 03 Dec 2024 16:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiUF98Rg12DlKRKFA9F7XlETaUWaxwRZvTvLbkMQuWlcfC93WhPHc19OYxX09T5kjAqAUFcw==
X-Received: by 2002:a05:620a:46a6:b0:7b1:1fdd:d54f with SMTP id
 af79cd13be357-7b683a8337dmr4455279485a.29.1733273500854; 
 Tue, 03 Dec 2024 16:51:40 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492cb81sm559974785a.34.2024.12.03.16.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:51:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, peterx@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH RFC 00/11] migration/block: disk activation rewrite
Date: Tue,  3 Dec 2024 19:51:27 -0500
Message-ID: <20241204005138.702289-1-peterx@redhat.com>
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

I started looking at this problem as a whole when reviewing Fabiano's
series, especially the patch (for a QEMU crash [1]):

https://lore.kernel.org/r/20241125144612.16194-5-farosas@suse.de

The proposed patch could work, but it's unwanted to add such side effect to
migration.  So I start to think about whether we can provide a cleaner
approach, at least remove that "we must active the disk for migration"
dependency, because migration really don't need the disks to be active..

It's also a pure wish that, if bdrv_inactivate_all() could be benign to be
called even if all disks are already inactive.  Then problem also gone.
After all, similar call on bdrv_activate_all() upon all-active disks is all
fine.  I hope that wish could still be fair.

And when I was looking at that, I found more things spread all over the
place on disk activation.  I decided to clean all of them up, while
hopefully fixing the QEMU crash [1] too.

So this is what I came up with as of today.  Marking RFC as of now, just to
collect some feedbacks first.  At least I'd like to go with one more patch
to deprecate late-block-active - not deprecating its function, but make it
always happen (which is the default as of now for Libvirt), which should
hopefully be migration-ABI-safe.

With the help of Fabiano's test cases, I at least am sure this series works
for the ping pong migrations, and all existing qtests.

Let me know, thanks.

[1] https://gitlab.com/qemu-project/qemu/-/issues/2395

Fabiano Rosas (4):
  tests/qtest/migration: Move more code under only_target
  tests/qtest/migration: Don't use hardcoded strings for -serial
  tests/qtest/migration: Support cleaning up only one side of migration
  tests/qtest/migration: Test successive migrations

Peter Xu (7):
  migration: Add helper to get target runstate
  migration/block: Make late-block-active the default
  migration/block: Apply late-block-active behavior to postcopy
  migration/block: Fix possible race with block_inactive
  migration/block: Merge block reactivations for fail/cancel
  migration/block: Extend the migration_block_* API to dest side
  migration/block: Apply the migration_block_* API to postcopy

 migration/migration.h           |  33 ++++-
 tests/qtest/migration-helpers.h |   2 +
 migration/migration.c           | 177 +++++++++++-----------
 migration/savevm.c              |  32 ++--
 tests/qtest/migration-helpers.c |   8 +
 tests/qtest/migration-test.c    | 252 +++++++++++++++++++++++++-------
 6 files changed, 344 insertions(+), 160 deletions(-)

-- 
2.47.0


