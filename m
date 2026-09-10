Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947CAC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4piq-0003Lx-Pl; Thu, 10 Sep 2026 21:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPX-0001fz-3u
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oPT-000782-DO
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:42:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso195059f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083745; x=1789688545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WCtL81X0uEHdmpCjJ7DEK9oFi6EGro1MFiHuPeEFIS4=;
 b=IAORI5DB7qiQXEIYQTkD6uW9EKV0d9/6tl3HrqewMU6kv4nJu3JJkoRIrCXXyO6Hw9
 ag4y0zTJmXhN+Sk3axcejCrxUiWayC5Ru8ntvh02a/wuDVlzNEpzDeucNTUFTrbCuVFq
 QEtA1PD4ed6AsLNoi1mxd+DeHah4oSNcBZky/NpqPtOKa9ax7ZglE8luCkbw7Y/nFzGR
 y8moOwrDbhArW/1FS5wiVilWfQR3DI4z6REi1ONvfCy+ZnEhYpbHJXSzeS571qiSZsT7
 ds9sLnt5yY/3QyBhS489iE9u3clibnzRAXLE9NcRAvfoFgHZMBp31LN9ZdLhi4IRwyW6
 yNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083745; x=1789688545;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WCtL81X0uEHdmpCjJ7DEK9oFi6EGro1MFiHuPeEFIS4=;
 b=EYr1WHNu0BVez+JJg/bqelbKl6XHTLdWPpp2zGvApvoJVI9Z+R7kgEXHmGyOS75BlO
 8WWhDJJ9UrCsBB55ythx15l7Glr15Am8b5rzuQtvtvOqmiePF4OkhQ7aTgfICeKSK2vT
 PEpB4NIkZJncdx9xpwgrnCvvi6LOR/DbC7wXFWYbf8DrhnPJFXvmfOzwmSVb03Qd7Bci
 RR0CtsbM+lQRnfzzNMWP7pFyLC1i0bGyI+Mnb4y9h5YsscA2rqUOMU2lQtdY55wVmz2I
 3pr/Hq01KS6t0kiw5AmlS3dwU73OgTAileWadvi7zVPnbc7kiqMf9ruDmJLg04zyBumL
 mFyg==
X-Gm-Message-State: AFuF++nWsAk7NPUUqaKkkM5l1nEcWQyqJeBUFPaCkxuYJ8/9Ht9wMVo5
 wDnAT4/rCT5TzIa+CwnoAUSoaWYu9243BRGOgXdETVCttB1U/5rxPNGNGBsqVOW4grc=
X-Gm-Gg: AYBFou3XrEM+qrrfmK/BQvf2GITQ/9gyuYq8spZ8/9g8uziL+4wNGwPkebpmQ4MJqQn
 XQEhtWPgho+nHVPvdbP4FadjfNXz0FNt1hdcRkOiyQaEL0trj50cDrbsmW4P0hrNpQaCFc1DhKw
 rE5Bnx7WByoaWw1BaGWpF0XDnr2/P9DklpqYnCcGjcwX0SlPMbGUGx6+7wMcSa9JGrD465MFfcP
 yhB70L+GRBsFW75aE3hPy2PRF5MY6TA3VafFFPzkr0PsyWKstdZ8o6VOPcOs457h+NdA01EKrXx
 Ox/ftBtuNU4xIspJC0isPRT7pkGwLPJslhuaTzlgC0iey+CCOqq5VBZ/vaTxxM6n3/RbszyRmD5
 rZtLugCbYMk9jXD09hTSb6Wpq0TaengbfWEHQ1nWYxXRMQgLCd3PPOlU4Ff7+hZf8xdBkxjVAW9
 MO5xEYAQMEqegz2AXlj4HSZR//EKWM/OGBb3n8knQb7WTUVxRus5kDw8PKOlGAd1RKpGXDzQCGE
 MItUyk=
X-Received: by 2002:a05:600c:c3cc:10b0:499:da8b:1476 with SMTP id
 5b1f17b1804b1-49e6198d752mr10946045e9.14.1789083744744; 
 Thu, 10 Sep 2026 16:42:24 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:24 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 00/29] parallels: persistent dirty bitmaps and Format Extension
 hardening
Date: Fri, 11 Sep 2026 01:41:53 +0200
Message-ID: <20260910234222.3039975-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
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

The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-09-11

for you to fetch changes up to 94336eedb1c98792d595f729c7a284e9e91e6158:

  tests: Add parallels format support to image-fleecing (2026-09-11 00:54:38 +0200)

----------------------------------------------------------------
parallels patches

- harden the Format Extension parser against a crafted image
- add persistent dirty bitmap support: store, remove and report them
- let image extensions be updated in read-write mode
- make qemu-img check report the damage it is meant to report
  instead of dying on it
- drop the unused clusters at the end of the image
- cover the new behaviour in the parallels iotests, and run more of
  the generic ones on parallels

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

----------------------------------------------------------------
Alexander Ivanov (4):
      parallels: Set s->used_bmap to NULL in parallels_free_used_bitmap()
      parallels: Make mark_used() a global function
      parallels: Create used bitmap even if checks needed
      tests: Turned on 256, 299, 304 and block-status-cache for parallels format

Denis V. Lunev (25):
      parallels: fix out-of-bounds read in format extension parsing
      parallels: validate dirty bitmap granularity
      parallels: bound the bitmap L1 table against the bitmap size
      parallels: reject a Format Extension outside the image file
      parallels: allocate the Format Extension cluster gracefully
      parallels: fix GSList leak on the format extension success path
      iotests: cover the Parallels format extension parser
      parallels: split inactivation out and add the activation counterpart
      iotests: cover inactivating a read-only node
      parallels: Limit search in parallels_mark_used to the last marked cluster
      parallels: Move host clusters allocation to a separate function
      parallels: do not let the check die on what it is meant to report
      parallels: Drop unused clusters at the end of the image
      parallels: Remove unnecessary data_end field
      parallels: Add dirty bitmaps saving
      parallels: Let image extensions work in RW mode
      parallels: Handle L1 entries equal to one
      iotests: cover the Format Extension against the leak check
      iotests: run the persistent dirty bitmap test on parallels
      parallels: reject a bitmap L1 entry outside the data area
      parallels: do not trust the bitmaps of an image which was not closed
      parallels: implement removing a stored dirty bitmap
      iotests: rename parallels-read-bitmap to parallels-bitmap
      iotests: cover a broken Format Extension and a combined repair
      tests: Add parallels format support to image-fleecing

 block/parallels-ext.c                              | 457 ++++++++++++++++++++-
 block/parallels.c                                  | 432 ++++++++++++-------
 block/parallels.h                                  |  20 +-
 tests/qemu-iotests/165                             |  18 +-
 tests/qemu-iotests/256                             |   2 +-
 tests/qemu-iotests/299                             |   2 +-
 tests/qemu-iotests/304                             |   2 +-
 tests/qemu-iotests/tests/block-status-cache        |   2 +-
 tests/qemu-iotests/tests/image-fleecing            |  14 +-
 tests/qemu-iotests/tests/inactive-node-nbd         |  14 +
 tests/qemu-iotests/tests/inactive-node-nbd.out     |   8 +
 tests/qemu-iotests/tests/parallels-bitmap          | 260 ++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out      |  49 +++
 tests/qemu-iotests/tests/parallels-checks          | 229 +++++++++++
 tests/qemu-iotests/tests/parallels-checks.out      | 174 ++++++++
 tests/qemu-iotests/tests/parallels-read-bitmap     |  53 ---
 tests/qemu-iotests/tests/parallels-read-bitmap.out |   6 -
 17 files changed, 1498 insertions(+), 244 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/parallels-bitmap
 create mode 100644 tests/qemu-iotests/tests/parallels-bitmap.out
 delete mode 100755 tests/qemu-iotests/tests/parallels-read-bitmap
 delete mode 100644 tests/qemu-iotests/tests/parallels-read-bitmap.out

-- 
2.53.0


