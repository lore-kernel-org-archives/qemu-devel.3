Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74243C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKB1-0002NU-5H; Thu, 16 Jul 2026 07:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKAz-0002IM-C8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:49 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKAx-0005Dt-Ju
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:49 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47defd0c1c5so2448799f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784200965; x=1784805765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ywb9wMcCqQGY5fA7ISlUJpyxSz9uBohQJAm1rN2/7VI=;
 b=X2aTWC5FU2D25RpQcqb1yVu9y/GAdHsMtksVXv42Mui/dcxQa8C5iHkhPsUsCQAqUf
 wZSsXjg1h2C34vguPfvRXeKaKO0YAG9QpZRkNRS5xlzTh2BCjv+QlqX/Xn+I7I83LPiI
 T/qdHuZkLhddGGHEvZolkLjlQLqix6a36oT2WPgXR2bix3W9VxqRNTNHYePTAZoYT2ED
 zoHu1kNTfswYj2cSOBdeHM/Fs1K4hkvC0awQXUbsORnX2uSCY/qG1kXG7HhiCC6OIgaA
 /1TOZKLU8pkThQH/NzI6zb7k6ri6+SKxsoyGht2oKGmDbwloogoC3QIPHDKiXadlCkiw
 bshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784200965; x=1784805765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ywb9wMcCqQGY5fA7ISlUJpyxSz9uBohQJAm1rN2/7VI=;
 b=mgqs046zmfAfQOnziF/LwtGLLLM7Ca9Bk+HN5Hd+zHdl+26NBoYA1+RTBC1X9YiyFH
 3Lx5wyewzCEzbpALBcuXBYSDGrhr4nhmbQdjlpVUEhJB0NBTySsZYUr4phb4brw0C8os
 3KHZtUndiHhjlow3XDGoSrDjvdtAZRX/g/SCvLzvilC4K9mBchkvecCW20KpFdRsWZBL
 CIo+aik+9TqdnFUeexJ6AF+0JFM9DuzFuUfgYImAx4IlGxk75U4mEUVU16cXh2tOOtsD
 Ms+UbUQ2oFgiEDpyVhDOoolDBSc+sIMZzdHzYxwIKHN0Jc7DSZ6B6/ZM4SfQ+fFYvlma
 BFRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8vivMdx8ys4b60ln3fgvjCFjEzQZrEY7mYs5keTYewEHEfd3bkFltlXR3WTFMlZAt/xPRChLihUoc@nongnu.org
X-Gm-Message-State: AOJu0Yy/7Lf0iSKsCFSMXgUy59KEUOmpvBoDVgOp79CNBMgu13B0ialh
 Ei6CqAN0gbHfwutCqZOHTDuNVe8uRaERxKtwP3MBUu37yG53oNwlzfuWPo4iN57pEmE=
X-Gm-Gg: AfdE7ckUjVGVYauEQEQOY+SyZJfCMx5ZzOQW4lvzMXYemi4LfBYUDnDb6fvdOezRcPW
 OKrTl/iwvy3Gk1ojWFI03+793R29/AHzsPiqTdx/Cnmv59aEFEIwOopWF1pETGIHC6VIjq2RebZ
 TV72dAizcyNIj7b8sdiocfFSXdpFwliTBTvNbaDuD0kmoqnP4s2SMHCZzbgF+TJ6rTeIrObtxSG
 txWS9h1GXSTlakYaBtWowYtc4r5mPEltNBPrVXWsBbXhDkKKbeZwTMrufHxNF7tnKcdN2nuTzAD
 WY+VG3R5hjoYYsosRUnttiXxj1A2KDyBtzqVFB59Cgv9QgoIMjBMIKQvx9PCTyAIvhWW1ZRzvji
 81QY7p2MEkScRJ8KwwgP/IVMGPSiccCl1yOHF3clPmNAFPEEnXdVTrRs2KKxZAoBykq4ssSZqJl
 A=
X-Received: by 2002:a05:6000:29c2:b0:47f:4fc4:1db9 with SMTP id
 ffacd0b85a97d-47f4fc41f12mr5376972f8f.34.1784200965201; 
 Thu, 16 Jul 2026 04:22:45 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4ca9:146f:3485:e2c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm24019672f8f.24.2026.07.16.04.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:22:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 0/3] block: reject persistent bitmaps a node can never store
Date: Thu, 16 Jul 2026 13:22:39 +0200
Message-ID: <20260716112242.3000035-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
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

qmp_block_dirty_bitmap_add() and the incoming-migration bitmap loader
both create a persistent bitmap with bdrv_create_dirty_bitmap(), which
always creates it writable, without checking whether the node can
actually be written to. A persistent bitmap added to an already
read-only or inactive node stays writable in memory on a node that
can never store it, and the next global inactivation (migration
completion, save, or any other bdrv_inactivate_all() caller) fails
trying to flush it back:

  Lost persistent bitmaps during inactivation of node '<node>': No write access
  migration_block_inactivate: bdrv_inactivate_all() failed: -22

Patch 1 rejects this at block-dirty-bitmap-add (and, wrapped in a
transaction, denies the whole transaction). Patch 2 closes the same
hole on the incoming-migration path. Patch 3 fixes a knock-on
regression from patch 1's approach: a bitmap that was rejected from
ever being written can still exist in memory read-only and must
remain removable without requiring write access.

v1 -> v2
* approach changed to deny rather than adopt (Vladimir)
* added patch to add permission check on migration path
* added patch to change permissions check on bitmap drop to more natural

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Denis V. Lunev (3):
  block/monitor: reject persistent bitmap add on a read-only node
  migration/block-dirty-bitmap: reject bitmap load onto ro node
  block/monitor: allow dropping a bitmap never stored on disk

 block/monitor/bitmap-qmp-cmds.c               | 19 +++++++----
 block/qcow2-bitmap.c                          |  9 +++++
 migration/block-dirty-bitmap.c                | 22 +++++++++----
 qapi/block-core.json                          |  4 ++-
 tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
 .../tests/migrate-bitmaps-test.out            |  4 +--
 .../tests/remove-bitmap-from-backing          | 29 +++++++++++++++-
 .../tests/remove-bitmap-from-backing.out      | 22 ++++++++++++-
 8 files changed, 124 insertions(+), 18 deletions(-)

-- 
2.53.0


