Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877CC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwx8-0003yQ-JL; Wed, 15 Jul 2026 06:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx7-0003yB-MI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx6-0000uQ-70
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso5212799f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784111694; x=1784716494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yTExx5ZXlY2S3DlS3NgL1hfZFKEyJ3gJB3X5/60/z1A=;
 b=Ipu9Fyc/UhCvQcRoXF5Ga2gBzIOCssk7PEP6H5Lfv3BV5/0B2XuD/jR5IUuZj+jYrK
 iuQF6Yu3QYpBAo9ClfxwXEi7nHl9BH1Z/dw/xtpooXRG/PMMAx2r7kp7L6h7QtsWVhIm
 d27CgahO3DJyd7eBvK7HPnDg6qjzmmfvuuprfs8dhdsY24+UuhOK6fTDbQw7AwEJlmzh
 2kpqVczGmzTNLmXYSn78PVOYvLaFfE7q1pZsnr2C26uv7q0OdbtbfJQcENYFtTnXMn3G
 gql6nWwG1xuWyRIc2rowZUQgnUthzFRLwCQtbzjHClUeLF3oPTztxtw9yb94MsJc+myz
 V17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111694; x=1784716494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTExx5ZXlY2S3DlS3NgL1hfZFKEyJ3gJB3X5/60/z1A=;
 b=UPcK/ItG+FrZfmnMzAR/udP/iJ9kDfEgx0pV/M0Dg0ezu0X9gbx/Y/UmDz3ROjlxmP
 zrkYkf+F5AJvka1ROhwHFdDJi38QdMvfOq/xs/00fHjHwAy2Z5e2AqnFiRz7FHdxC29u
 PwmTyjnT3p4cR5ZDUHhPfFngPIUX/pj1TECl2QDJz9CkDoFILmy4ex3A3uR9G54ZJBoR
 01aQRrw3XUy1qPPbYixMXPWB0F8194cAnc7zsMCMs7kYK0iRJugfpg4gGMO3mXHVx3f8
 XLUS5/HZ8T2YHeudcWwimY01RLswylFon2LDIz2OE9Ht+GEZSKQkdTf6C1EuWjRN+hoz
 6PNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpD6sUIIQ6yLpmEAKT/VVUPRpNdlKnhbrfLEGB51uzDnsgOOW097UqnADUXjPaQf6tzZgEJLbGBMOol@nongnu.org
X-Gm-Message-State: AOJu0YxCVRvEsZ3R1aZn5p5W/aufEm4Ry/A8iFG6CktQhn7dvjwidaSG
 3HOj4whcpuRutF2kCZw7OAKJuyhqOJQvIxZzaBAWPWtOmAS6AsBaOleQRhbMlY0CbHM=
X-Gm-Gg: AfdE7cmDrBcqMPBkvCfbkdJPKx9khVshs7GAi23aPMdsAdHzyXhsvPutuNGqGLdSqJu
 tjo1SDDQKG/7520ZppiO5wOPVpsVqCiJipQsGzMEa4cBxOMYa3R5cHHab3+ynVfvlVurv8mDhvk
 +EXKfCogdVDdaDHv0CrjWzOMai5VVn963MYNzzXk44B9fjjJbYqO71A0xkp7hnVhhVijtq1aej5
 6/G4rxFoTST/gP0VYIVQKgAOSN5okUfCi3MRb1pFuhuy3w5k1KHvpylkOEl1hw/n4IyuNdn+iVy
 CZapxkLMQ57GXuCgsWPD28BcW5LGya/mkvhVP4Uf8cRmpJNTFYygr/u1xmKaznMxIlznNOTir1t
 Z42BuwIUjv1xxEpBQRx3PMXM6lm+Z+YL/lbPU145Lcq5t44HUXX7bUfXbpISzVT6yNcJFcroGB4
 LO0Q==
X-Received: by 2002:a05:6000:1844:b0:47d:f54d:399d with SMTP id
 ffacd0b85a97d-47f4fcd59f5mr2516994f8f.19.1784111693884; 
 Wed, 15 Jul 2026 03:34:53 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:c44f:405f:37a5:5992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm17292644f8f.18.2026.07.15.03.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:34:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 0/3] iotests: fix three spurious local failures
Date: Wed, 15 Jul 2026 12:34:48 +0200
Message-ID: <20260715103451.1930909-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=den@openvz.org; helo=mail-wr1-x431.google.com
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

Three independent fixes found while chasing a clean './check -qcow2'
run on a Python 3.14 host. Unrelated to each other, sent as one
series since they came out of the same session.

v2:
- patch 1: drop the now-unused 'Pool' import (Kevin)
- patch 2: rename _notrun_on_no_fuse to _notrun_on_fuse_error (Kevin)
- patch 3: replace the dropped assertion with a check that bitmap0's
  content on the destination has not reached its final value right
  after RESUME, throttling migration bandwidth

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Denis V. Lunev (3):
  iotests: run the test pool with the 'fork' start method
  iotests: skip FUSE tests when FUSE is not usable
  iotests/migrate-bitmaps-postcopy-test: replace the timing assertion
    with a content check

 tests/qemu-iotests/common.rc                      | 14 ++++++++++++++
 tests/qemu-iotests/testrunner.py                  |  4 ++--
 tests/qemu-iotests/tests/file-io-error            |  4 +---
 tests/qemu-iotests/tests/fuse-allow-other         |  2 ++
 tests/qemu-iotests/tests/fuse-mmap-shared         |  9 ++++++---
 .../tests/migrate-bitmaps-postcopy-test           | 15 ++++++++++++++-
 6 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.53.0


