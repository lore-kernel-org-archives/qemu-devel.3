Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D548C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUrr-0003nF-Cq; Mon, 24 Aug 2026 09:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrq-0003ms-JK
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:38 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrn-0002Zv-4C
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:38 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c2022323c37so544721566b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578653; x=1788183453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LAZ86AdpZN3Y5ffaea1LfKyxm73tAAgoLdLPN+YrP+k=;
 b=aV3hbd3BJQgtsqBDnWPSfdumMxhMD1NLaYAmYiWSBEZS6tDhvhD30QSh1tznZ5rr/v
 0C2UMLXKj5RhcvdxcUWmCeBN/F9wdZFabODtP/nQBf0w1wU2cOXlQHWywEBxefEC0ZSc
 p29RyKG7vGN8KdxV+TI9IH6vZLDWEDkTBVHy7EscmLNYwJA07g8y4ug8R347J+0Pr37i
 oYMCW7EODojQXeT+9iIM+0uQzXSszyu2xV05NzLdj0+C/YDJE0J5HmK2gcO0dpv/U6Fj
 S18OcljgCXKqdzID6StPunoRFjNKjq7k1a6cHcAK5u6CvWy5zHCukEgHZ8pXuqrK3wpp
 RHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578653; x=1788183453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LAZ86AdpZN3Y5ffaea1LfKyxm73tAAgoLdLPN+YrP+k=;
 b=tLmj8kUCj+sLn8CSdC0k8C32QUjOvdixo+0Vfeqs2GZxEJc355VS8WCGRzW7sAjBmR
 eJPUWjV7rLarnfpNNyQw1bAUWX4Ajwb2+dgfQgQ7FI1Lw8J0WxW4m4zVy2kjJlwfUxmk
 9CCgwDCeipU96Gvx+kdusp7P6trXTu3Az/BdnoE3Din6du1QE/8qSo40gfCgT0jkwcxW
 QEYlJY+W4iYUcoqMxQmXBjJyMfB3D94WkMSaPlZ2xZvIB8bSvo64/e3AnlG2NqjWxtD6
 8/MH/TwvMGNBVqaxMeNNKhwGXtA0PJM0T2KbHCblWW7ND8pC8f8WVXlN8iDYjMvYYYng
 uLOA==
X-Gm-Message-State: AFuF++mO4uK324YWHft9uPgAWtFnsG9OpPgLFx8zoM1hDtCdfOEQaXiI
 TeNFlvRjvP/Xhy66AL3COTKQt7NMMKlyZqtQm3l1lC4SY0yEdBemku5EPyLPeauCqs5+jzLxiLV
 N4LUl
X-Gm-Gg: AR+sD13aZSnPOapmVqttaqQkCShk5/g+CGJ3BfDxKKhPhpIZcw7wrtqoEKSvUrOsHE1
 ne3g5zM3vWVlvsPtv/X1t/jGt/kS1d+/ZRafedcIC/Jp82F8Rxz1AGKbpaRQVPqC02NL36LQS9t
 5Pg3sLzU6pxtGX4KQfqFNYUrnI3GRbcAramxw+u2MTUMdOEVmyWUy4021bfS0513Ia4I5AZ4Z5L
 50xA4GpWaHOa0RF+hRkuEkjGbO6Om6il/8DZZ5I2/C5ON87ynIQ3lufq299ad483ySjvH1nO7FK
 f/lI0q/srdHLOBS0DUWow/VcortfSGO3/7cAtpsNdq6+Xw+jD69Rdj3VBJmInkvQTLEUGxVTqZS
 +XJNUNnP0UAXRHAU63/45tvGUvqfUiBG4z4FPbp3K6OhFA95si2w5vREfNT0HksM5tYjeeOh/hQ
 mQy3Bkx9LJ43+lop1RGNGn6ccSnDvAsqOfpj5UaxqXczgKffBSRl1BVGTAhAGZS7MUeK3C
X-Received: by 2002:a17:907:d78b:b0:c24:d6f0:a53 with SMTP id
 a640c23a62f3a-c24d6f078dcmr379987766b.23.1787578652498; 
 Mon, 24 Aug 2026 06:37:32 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 0/5] qcow2: silent corruption when a dirty image becomes
 writable
Date: Mon, 24 Aug 2026 15:37:24 +0200
Message-ID: <20260824133729.1141990-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=den@openvz.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Today I have faced real data corrupt from our customer with the
situation very close to the one addressed in the patch
"qcow2: do not try to clear the dirty bit on a read-only node" and
that is interesting. I was really unsure that design is correct
but with today case I can say that correct thing was done.

The problem
-----------

qcow2_do_open() repairs an image carrying QCOW2_INCOMPAT_DIRTY, but only
for a node that is writable from the start:

    if (!(flags & BDRV_O_CHECK) && bdrv_is_writable(bs) &&
        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {

A node opened read-only skips it, correctly, since it resolves nothing
and writes nothing. Nothing revisits the question when that same node
later becomes writable, and bdrv_reopen() is not an exotic way to get
there: commit_active_start() and commit_start() both reopen the base
read-write for the duration of the job, so an ordinary block-commit onto
a read-only backing file is enough.

With lazy refcounts the refcount blocks are not written again once the
dirty bit is set, so an image left behind by a killed QEMU has an
on-disk refcount block that accounts for the metadata clusters and
nothing else. Every data cluster reads as free. s->free_cluster_index
starts at 0, so the first allocation after such a reopen starts at the
front of the image and hands out clusters that L2 entries still point
at.

The result is aliasing: two guest offsets mapped onto one host cluster,
so the guest reads back data belonging to some other offset. Nothing
about this fails. No I/O error is reported, the corrupt bit stays clear,
and a clean close clears the dirty bit as well, so no later open will
repair the image either. Afterwards qemu-img check reports

    ERROR cluster N refcount=1 reference=2
    ERROR cluster N refcount=0 reference=1
    ERROR OFLAG_COPIED data cluster: l2_entry=<host>|COPIED refcount=0

and the only runtime witness, if something eventually frees one of those
clusters, is a bare

    qcow2_free_clusters failed: Invalid argument

on stderr, with the guest none the wiser.

How it looked in production
---------------------------

A VM was killed while its storage was unavailable, leaving a 100 GiB
volume dirty. It came back with a snapshot-revert overlay on top, so the
volume itself was now the read-only backing file, and the overlay was
committed into it two and a half hours later. 8082 host clusters ended
up referenced by two L2 entries each, roughly 8 GiB of guest data
cross-mapped. The guest filesystem began failing metadata verification
on buffers holding fragments of unrelated files.

Two properties of the damage are worth recording, because they are what
told us this was not a race:

 - aliasing is exactly two-way, never three or more, which is a single
   monotonic sweep of the allocator rather than a window hit repeatedly;

 - it stops dead at the host cluster that was the image end at the
   moment the volume was made writable. Everything allocated after that
   point is intact.

qemu-img check -r all makes the metadata self-consistent again, and then
honestly reports no errors, but it cannot un-alias anything. The guest
data stays wrong.

Reproducer
----------

Under a second, no guest and no block job required:

  qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on base.qcow2 1G
  qemu-io -f qcow2 -c "write -P 0xaa 0 100M" -c flush \
          -c "sigraise 9" base.qcow2

  qemu-io -r -f qcow2 base.qcow2 \
      <<< $'reopen -w\nwrite -P 0xbb 900M 100M\nquit'

  qemu-io -r -f qcow2 -c "read -v 0 16" base.qcow2
  # 00000000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb

The flush is load-bearing: it writes out the L2 cache but not the
refcount blocks, which is exactly the asymmetry the bug needs. Guest
fsyncs supply it in production, so a long-running VM is the ideal
victim. qemu-img commit of an overlay reaches the same state through
commit_active_start().
v1:
https://lore.kernel.org/qemu-devel/20260731220039.1765584-1-den@openvz.org/
v2:
https://lore.kernel.org/qemu-devel/20260811173857.396571-1-den@openvz.org/
v3:
https://lore.kernel.org/qemu-devel/20260819120558.3870413-1-den@openvz.org/

Notes for review
----------------

 - The repair still runs under bdrv_drain_all(), so a block-commit onto
   a large dirty base stalls guest I/O for the length of a full metadata
   scan. Rejecting the reopen instead would be cheap, but block-commit
   depends on it succeeding, so repairing in place is the only option.

 - .bdrv_reopen_commit_post() runs after the transaction is committed
   and cannot roll anything back, so a negative return value reports an
   unusable node rather than rejecting the reopen. That is unusual, and
   it is the only channel available: there is no failable hook once the
   node holds BLK_PERM_WRITE.

Changes in v4
-------------

 - patch 5: block-stream and change-backing-file document the repair as
   well, they reopen read-write too. (Andrey)
 - patch 5: the message says why a failed repair does not mark the image
   corrupt. (Andrey)
 - patch 5: each of those notes is one or two lines now.
 - Cc: qemu-stable restored, QAPI maintainers added to patch 5.

Changes in v3
-------------

 - patch 1: the same bug aborts QEMU, not only fails a reopen, when the
   file node below is writable; the message says so and iotests 039
   covers the read-write to read-only direction as well. (Andrey)
 - patch 2: new, a reopen of a node whose driver is gone segfaults in
   bdrv_reopen_queue_child() and asserts in bdrv_reopen_prepare(), which
   is the crash a failed repair would reach through commit_clean();
   bdrv_reopen_prepare() reports it instead, iotests 060 covers it.
   (Andrey)
 - patch 3: bdrv_reopen_multiple() documents that a failure means either
   nothing changed or the reopen went through and left an unusable tree;
   no caller changes. (Andrey)
 - patch 3: an implementation which fails must set an error, asserted,
   and the loop skips a node whose driver is already gone.
 - patch 4: the pre-reopen flags are recorded as int old_flags rather
   than a bool, with a bdrv_reopen_was_writable() accessor for drivers.
   (Andrey)
 - patch 5: the failure names the node and keeps the errno of the check.
   (Andrey)
 - patch 5: a failed repair drops the driver instead of calling
   qcow2_signal_corruption(), which would write the corrupt bit into the
   header for what may be a transient ENOSPC.
 - patch 5: blockdev-reopen and block-commit document the failure and the
   state it leaves. (Andrey)
 - patch 5: iotests 040 covers a commit onto a dirty base through both
   commit_start() and commit_active_start(), and the failed repair.
   (Andrey)

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org

Denis V. Lunev (5):
  qcow2: do not clear the dirty bit when reopening a read-only node
  block: reject a reopen of an unusable node instead of crashing
  block: let bdrv_reopen_commit_post() report a failure
  block: remember the flags a reopen starts from
  qcow2: repair a dirty image when it becomes writable

 block.c                          |  55 ++++++++++++--
 block/qcow2.c                    |  33 ++++++++-
 include/block/block-common.h     |   1 +
 include/block/block_int-common.h |  11 ++-
 qapi/block-core.json             |  19 +++++
 tests/qemu-iotests/039           | 110 ++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out       |  56 ++++++++++++++
 tests/qemu-iotests/040           | 122 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out       |   4 +-
 tests/qemu-iotests/060           |  30 ++++++++
 tests/qemu-iotests/060.out       |  13 ++++
 11 files changed, 439 insertions(+), 15 deletions(-)


base-commit: fa19879df1658f96ac07365fca8835b7decd6995
-- 
2.53.0


