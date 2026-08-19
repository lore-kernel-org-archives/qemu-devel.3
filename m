Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC76C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf3d-00045L-6B; Wed, 19 Aug 2026 08:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3W-00044u-HU
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3U-0007pe-6H
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso7840715e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787141162; x=1787745962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l6aPmScY7Z6DY5JWYZOOTGttzdKqvHZcS28Qbt4S94o=;
 b=eYIc6CoieeWbHteomE0fQaDduK0ohLBAM0EHqvYab+QwTWJ5P9BNj2vWusNgRQiSN2
 TM86kWjrDxUJIsfab+HrZUoXTxWIiRvYQS89T7JVCpLZA8bfYqC/fKf7T938X9BYu3CA
 wdwG0YCPWU8YtrJy1HTVNKvcY+XwuFkJMnlvw28EnMRbZ4dFblenUdEErr8xLjfS/bzg
 DMhueGWZNuxSS8IYXnmF/2YFN44jQudv64+XXGvTjS5GVTkuHY09hcDxYc4J6Ee8JVpc
 6/SdkysElwm/5p6bUZRuBHlMdo30xTUmhPeYQgW40yYVGeJLSScDNT/3nEl/FUfAqjtT
 t6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141162; x=1787745962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l6aPmScY7Z6DY5JWYZOOTGttzdKqvHZcS28Qbt4S94o=;
 b=cK+i3TvQaNHTQid0xfTP6AqUyHFC+M5HwDctgS1oiZeKaCnHCwmdzGWiMiYL+OSifr
 QYWWOIwedMvYgdfFAImPIDwBk9ImDZSyCNK0JRVnG6DKBfGZS2/BsyBOHSGyrY+87GGl
 eYzlOHenDJ02RC2QYpXTGiUYcwscT4iKQm+ZnSBwiaZKt/a8j8QLkVqMs8mTPAV5kv2N
 /CECEl3O1TpjF+74jQueBiUjU6EcFRPbFZAiLmABcoP1hYn7I0BsCr/lqXA3BIbtI5DY
 erm0cUnGRYxeW2QpA8P1r0jkpyMzl+qa0UE47H3lumpURs6c/6a/Ils42SawJFxr0+p2
 R/8g==
X-Gm-Message-State: AOJu0YyEjnheRQfZU5dJybgnz9xNqB/VUBQr29F/BsLNj/CcItj66U84
 ANVSf0pVfDbujKvQf+AGatN+Vd0gXYB6SqYExHBU5E3u87mUv/4CaaVr6oLZ01ocSRdLyXbahm5
 u5a/d
X-Gm-Gg: AR+sD10POkSULRSu2EEvvDAOEtDm/NRKaqB9zgJgI9D3TMyut+dELlGB71zRtajDDPG
 Slf1Rq0/zQXiUl8STvIUuafYT9ySSX44G29ZIPtr8VT0p4FVVJiMAig6qPcOu0/KxmwQ4iNzMkt
 eVCBvbuepLA+C7Ioo6cpBQ110vrw4RjftS2Kx0hV2SLHEOPO4KWWQVUF29EoEkc2cBq3xmm4M1I
 BXJyGGwajU3/lwzZ7UId7NcdDUwsGxqbtT2upC7P/BsNPHojrgJG3DgHXW/6DSem2QjlBS1qtlq
 Zcl/mExyVpyClzhsqkEm6fWcOufdmF2zxBVDFq9JIarD9kDLnmM6huu0Pe8A5zEDSRfOlgfir7y
 dN/YMZwu77Fl1o1AY+KAyjytqqqXBrXR9CDMosTuBj0ZVcZDjSR/u0SwfJRupMDtWtYHJAj4sjb
 osyJLZZKjOWqeMHTToInm/prdmeAFQFimNUw6/f/eCBRqDoYqAchopoV2lqQ==
X-Received: by 2002:a05:600d:8495:10b0:499:adb4:a922 with SMTP id
 5b1f17b1804b1-499adb4a9camr35036685e9.12.1787141161787; 
 Wed, 19 Aug 2026 05:06:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:258d:1706:7089:f765])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm59244785e9.6.2026.08.19.05.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:06:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 0/5] qcow2: silent corruption when a dirty image becomes
 writable
Date: Wed, 19 Aug 2026 14:05:53 +0200
Message-ID: <20260819120558.3870413-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

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
 qapi/block-core.json             |  16 ++++
 tests/qemu-iotests/039           | 110 ++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out       |  56 ++++++++++++++
 tests/qemu-iotests/040           | 122 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out       |   4 +-
 tests/qemu-iotests/060           |  30 ++++++++
 tests/qemu-iotests/060.out       |  13 ++++
 11 files changed, 436 insertions(+), 15 deletions(-)


base-commit: fa19879df1658f96ac07365fca8835b7decd6995
-- 
2.53.0


