Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA64C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 22:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpvHb-00063C-3h; Fri, 31 Jul 2026 18:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHZ-00062n-VU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpvHY-0007SC-6S
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 18:00:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1565191f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785535242; x=1786140042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rBzIw572nJiJtgZhzdHI29JhC6MCZxhECAbrxgyPImk=;
 b=ClHU5TXsHhHURqWOaPckn0YvphB8fO750IWl0RWXauXxZfKfjILKRN+g4vFNNV1xgn
 uPAez70LRcM9frY25JMj2/TP4a2x/w/eptC6W7pvenKzW9umDCIYN5MeTJjkuE21lMt/
 uf2YBVleVok3r9cNwYrnqvFUbOyS+8AVp+RJAeINQk8PdIEbWwk02JBzdxsgKkOS1oc9
 yBOlo8oWDEY/Zmud994vlw5RwGdwDyJkb0UME2Fa2OOPf8kwgtkUH2aakWMEXOFf0DaD
 OcQtkbNgerKge5y9Rlf7H698ZPmCcfkl5AEN4qjW5u3yvrAQdjqWwGONGanMm0k8wB1O
 3Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785535242; x=1786140042;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rBzIw572nJiJtgZhzdHI29JhC6MCZxhECAbrxgyPImk=;
 b=X3Mbg1rdtaWCZO0aVhDAQB+HGbthd0G4XjguKPimLxNMqgku2VUBdyOdmxattKBAvE
 V3Jx7GBYrahv3/V7cdoseiTRd3F8QnIpa7HUal6f+2iB4o4RgLWv5NLMm31LCtrk1n/o
 zUCP3OZjZSIaYKP2pLh+kUaPZfuLCRBHnTb1lMCWa793m93tkzvWpAWrd/Y14TJvVKkN
 NbWuAEsxGhzYobtAvSpJW4bdgHlSWGQVCNu/q4iaARuW5jFYcHysxLfbFw1sL1J/jpDE
 w2kyetGEc+odTPXs7QXoBb1xcR1V44aQNCWVZBJ8WpHGvH+4VBgARdBGxav3aeT9NnNe
 sM+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrL8WmZAXGsA/8jTLFIFSbIXyn7h1vN0wCGDUMYW2VEPbe9PtG0yEyf8U+5CWS6yDElKO1Ly5QL891N@nongnu.org
X-Gm-Message-State: AOJu0YzBb8qIpOwPdq+PCJRsc97MqDGvDDoit0md+iwFZ0/KxznjXRhn
 HCKamDwF2ZP+OMWb97kXXr+JhOqNVX3P+WUuahQ7W/9948Ha/VG0Pr3wtfvjxkbYFFo=
X-Gm-Gg: AR+sD10Tv9mW9DmLXL3ppsfhyA/PFLRz6ekuaxoHyuM1XzXVFrwUncKhJO8emHP4Ach
 QTNCIbTD2MLh7HmaaoMkzW8C7oW901ot0LQ9BswUX0HSnSL8rZvuza3STaEhrmDHBrC9xcfPr5h
 YUZPf6EjiN72TxD6FU727d5h5FT6L2Ml3NazrP3b9o0toweTMEwqDXaGsa2Ii2s6keJEBl4UDP5
 ONHmZUOwe4vdltMsCRxtrOv8H9TBaBUuF+/K/zH6FDB8CpvCNVh10vMUqAl+B1qD4cDRRj3zrib
 KX2KAW733GPh19RVyV05HnhudMHRf1VkWfycy1H5hSNW0fZE0R1+mUtGtHWwgy/skw23/WoW4de
 p56J0Pydn/uA/fZws1HevoMup5mLoyxMLAtaxFZd7Tzv9zAg2MLMCA4wZiC4QGfH3ONx+oVaMkQ
 seVaV3GdLfV3Abl9OXZHePgDXw14cdtnfH0UeeE5gNK4RiBRmd71aCI3pV
X-Received: by 2002:a05:6000:25c6:b0:47f:97a6:1334 with SMTP id
 ffacd0b85a97d-47fd731956emr2494648f8f.46.1785535242221; 
 Fri, 31 Jul 2026 15:00:42 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1758:fc6:a5f8:a15f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2cf1sm9711152f8f.10.2026.07.31.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 15:00:41 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/2] qcow2: silent corruption when a dirty image becomes
 writable
Date: Sat,  1 Aug 2026 00:00:37 +0200
Message-ID: <20260731220039.1765584-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>

Denis V. Lunev (2):
  qcow2: do not clear the dirty bit when reopening a read-only node
  qcow2: repair a dirty image when it becomes writable

 block/qcow2.c              | 25 ++++++++++++++++++++++---
 tests/qemu-iotests/039     | 35 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out | 22 ++++++++++++++++++++++
 3 files changed, 79 insertions(+), 3 deletions(-)

-- 
2.53.0


