Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16CEC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtoce-0007uj-Oc; Tue, 11 Aug 2026 11:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocd-0007u9-Eq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:35 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocM-00046R-G5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:35 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so5484391a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786462936; x=1787067736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z4HjFwPizF1XiGDK5/730THxCreYP5Hk3iH1cf1B/Po=;
 b=CwFdmRdg9ELy3qQRcqDncWKs+a+NZRjIVGaFmmFdGmCqwRtWM/T0c8VubYX0asBYGw
 Q1t35+deErNAK1gKEHRUl4NHzx5jZhqHekM4NJZbTKG4/8IHrWbeWhF+xQIYvzigUAnJ
 A4Fgko910EXMVtanBmEhS8NBSKd2YlLqnLhNdfvFVBiG2PciLbGa/z0WArOoTqERlqJ3
 JeheN7C7zWGyEefRR6FmD6g24XxNZ8gJ2ESYFYoqKNEnPLP7qi+cktWnlfDPwgJLozE+
 1Gvj/stIzMg/gbkoBkk8iJRt/hHH2DzGEvx468s9O8uEaK+HJLWhagOA10xw2K/YceVg
 IjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462936; x=1787067736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z4HjFwPizF1XiGDK5/730THxCreYP5Hk3iH1cf1B/Po=;
 b=pPcv9JSw/SrqHq7m8T9jOwZPjqoTPgDPm2uGeW/wJjny2fogUr2UITZXmS8JaFrDHj
 ha3Kprhioq/+xvSbIXt5cgLcJ6Qhg3jkhdd49GxEwC1ffxoyu/3Foy3zM70vCC9pWzio
 zZFbQhbrOM5Sv7IEAbCzPb6N6+04pePMyrZdB3Rz7INmhACXk6DrAUXyDIKHfiJwlSQe
 ygYMrtXq3hxrr7+y6kHVq6VJ8O531sNwGZv1kqm3oX3UqqDsaUtaXPk/C9TNhhe1+WXg
 xgykNrP7WMXHvbZ1D3gWPJXz/aa8lZRjMKtBzTJ5kc5QDr784avAAsBl6cXl+7teFMg8
 +IUQ==
X-Gm-Message-State: AOJu0Yx7lmwpiRWVJXuGuye4VpfzIzLUSCJWswfvabIhrqS9FHYLV863
 /64OjxZwkA1dEHINlrlA6r0M/mpZW61kxPLkGEs3RhY13rny944pdge4+H+psND8J/3/ts+7MXt
 bEz2t
X-Gm-Gg: AR+sD11moGhvevHadFK460Y5tMS1Px+gQr29RQ9W8RNz8xtbUKYUb1IvmV5TF3vy/L1
 SIcrCCFAYzlY430f7dJf06hfjHVkdH5k/pp+dTajCYrHeyE7NnKHdJcW2Mg6VrnHMWuW09l3bhO
 ZpjXQc8k595hIa92jl81OeoeG+aupMziwXeKs2UwQURpbyEyr/7d4YYDDkqImKZA3VRyuCHWWBD
 ToZTCH3WCCWAtH8Bg3VROxKuPhGc6Hm5qPESZORjqvhklGfV4WKP0rhe6hs3XyYD2UHLXsi3C5B
 9n/znUQ5TRC9djV0W0BsyIjre1IWd49p1CCLpQPf2BldB+dz16/pf8MH/7irQv9+Rwd1hkAVCwh
 2Hzkc+RS9k1bIPkplwXiLtif4oFJ2YTRCzhMMIhePN+4kspwM3i+Yx4JSJfGyygMQQxIYVCjONH
 JosTbEGC+xoTBtt5rshTL3RBsOrMLHInpeAqNJl+dIdZ2c8n23Yyyhy6Bc
X-Received: by 2002:a05:6402:24c4:b0:6a1:245e:525a with SMTP id
 4fb4d7f45d1cf-6a36452cbf9mr1899470a12.19.1786462936418; 
 Tue, 11 Aug 2026 08:42:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362e34d4bsm841128a12.12.2026.08.11.08.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:42:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 0/4] qcow2: silent corruption when a dirty image becomes
 writable
Date: Tue, 11 Aug 2026 17:42:09 +0200
Message-ID: <20260811154213.184947-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=den@openvz.org; helo=mail-ed1-x534.google.com
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

Changes in v2
-------------

 - A failed repair no longer falls through to qcow2_reopen_bitmaps_rw().
   qcow2_signal_corruption() has already cleared bs->drv at that point,
   so there is nothing left to reopen. bdrv_reopen() also reported
   success in that case and handed the caller a dead node, which needed
   a block layer change, patch 2. (Hanna)

 - Repair only when the node has just become writable. With lazy
   refcounts the dirty bit stays set for the whole writable session, so
   repairing whenever the node is writable made every read-write to
   read-write reopen, blockdev-reopen changing l2-cache-size for
   instance, scan the metadata of a live image under bdrv_drain_all()
   and clear the dirty bit its session still owns. Patch 3 records the
   writability the reopen started from. (Andrey)

 - Three new cases in iotests 039: the read-write reopen that must not
   check the image, the failed repair that must fail the reopen, and
   the read-only reopen that must keep the dirty bit.

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

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org

Denis V. Lunev (4):
  qcow2: do not clear the dirty bit when reopening a read-only node
  block: let bdrv_reopen_commit_post() report a failure
  block: remember the writability a reopen starts from
  qcow2: repair a dirty image when it becomes writable

 block.c                          | 19 +++++++--
 block/qcow2.c                    | 29 +++++++++++--
 include/block/block-common.h     |  1 +
 include/block/block_int-common.h |  5 ++-
 tests/qemu-iotests/039           | 70 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out       | 41 +++++++++++++++++++
 6 files changed, 156 insertions(+), 9 deletions(-)


base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
-- 
2.53.0


