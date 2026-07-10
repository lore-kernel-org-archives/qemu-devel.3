Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B9EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDqu-0002TG-UD; Fri, 10 Jul 2026 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqo-0002Rn-Nz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqm-0006aO-0z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso1078357f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1783699993; x=1784304793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QUjCcKagdrE6PWUt8AAGQg8Xz9miscY1zPA9EtzXkMU=;
 b=McymRBUQpDPCWOewm3AmSMJoHKxkOV7vIEguM3lG0BVrH+LmBU+hHBq/LTRArdqf87
 6UjUFirasrkMB1xWwD6HZz2mVSbcllmCy1qwFt+J4xzMcHc2h8aX3Gwko/8HnEFgYcVq
 scH3FvLD389f8H60PBiUjZlgTH2Fqt+8dAJ76LC0JYTqO0Bxr35/3+Xatg7TgLwzkjbm
 57sqQULl1L+sK4+wtxGsYFdbTJPahpa2LM4MIejPnKucALOdQYfnJEEMFWvpVOftygRD
 UCErzKOggdQ+0lUvCHXKx2mF/eGxgdjh6w+JyOl9Qvl7Tbnzhyf9yIWnANS4nBvhHm9f
 jnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699993; x=1784304793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QUjCcKagdrE6PWUt8AAGQg8Xz9miscY1zPA9EtzXkMU=;
 b=qw5FYSP3+a/Kw8qxRtiAiHWQ/YDBo3n6mKyYGaaDy0DJZowruEEyTUrK561DqxPk16
 TrM4xE31wF+QGWjI4Kn/eoJbDGAoBoJzHYzmViTgfKKfK1xHsaZeWqPxt/shjF/16dP6
 9ZeqH4k4MOCdlga+o5QEpsVNCfvlmMkUiqJ2OO7QCpXkQvn3IGCL7JzAd1NzL+/VNFaq
 u1CnopVwnWl4RVSdKsDfrl0gjVvvdTHRlnvktfQFcfR86H3c1Q8UMNCgKx++6AXV4GeQ
 3bGUyrnf9ZT2z5qTo8bHM84UbvPLHC0KRtCi4HCobF4TROZ8O7DKd+kE3zNzzG5Q3m+C
 PuIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDIOs60IhjEpX1MTMRw4oib+uAlhSB5TZPNpKyQqW4Bv0x4Vfd0t2hE1yKu9Ga9XhKicS+2mxdx0ng@nongnu.org
X-Gm-Message-State: AOJu0Yz/UJ+a7dRPbWClt8oMDGFX9OQewcknI3QL+Af4RgKoVGurbVOL
 HoV9UeZimbiImgzWSv6LIz+d2suHxq1p2/Lx6TalWzpgRFBvlvAEiTfW5HYNutxu06Q=
X-Gm-Gg: AfdE7cl3Bi9FKINnzqu+v3jWg0uBbEa0f+j9xbBk4WAhLQ5/JmFmxN53DOwM8aZkGQi
 l9B8Bl4gW+E8Thpz6kja8KitWvc5h6u9/Fc7ayxzNdUB4bYndtvRfM9/gy0EWcK48BbHogFt8Yu
 YjABHGdS4jVo3/b/Nhmc23imQDCtlafVn4eA5kaj3d6ctw0PW5t36jpYgCarzxEaPo5FEAT8ffO
 0bkhUKTPZ+EsqLBtf5hIDKHRq9m1m/h3c+EgKx/rqzETDKY5EjnHckOIxdGyOAE5wDg+UzO+lfw
 5t1+J6zGtYTGtHdxAXkFPdBsM1REO1b9YK0B+U8312RBCKmHiCIAjLDLnosMmL7M/hPJOkN+ldu
 ro2hYBQpbVz5za4/km1OS94fhL9Xo2hVKwdSn37CgVluKIiGKOTp1+vSZ2xZnx5o4KLK0mJDPzY
 S7zw==
X-Received: by 2002:adf:e188:0:b0:477:b22:488d with SMTP id
 ffacd0b85a97d-47df073b097mr14767713f8f.10.1783699993354; 
 Fri, 10 Jul 2026 09:13:13 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:5926:51ec:1f64:b9b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm59944836f8f.33.2026.07.10.09.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:13:12 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/3] iotests: fix three spurious local failures
Date: Fri, 10 Jul 2026 18:13:06 +0200
Message-ID: <20260710161309.1104712-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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
run on a Python 3.14 host. Unrelated to each other, sent as one series
since they came out of the same session.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>

Denis V. Lunev (3):
  iotests: run the test pool with the 'fork' start method
  iotests: skip FUSE tests when FUSE is not usable
  iotests/migrate-bitmaps-postcopy-test: drop the postcopy timing
    assertion

 tests/qemu-iotests/common.rc                       | 14 ++++++++++++++
 tests/qemu-iotests/testrunner.py                   |  6 ++++--
 tests/qemu-iotests/tests/file-io-error             |  4 +---
 tests/qemu-iotests/tests/fuse-allow-other          |  2 ++
 tests/qemu-iotests/tests/fuse-mmap-shared          |  9 ++++++---
 .../tests/migrate-bitmaps-postcopy-test            |  1 -
 6 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.53.0


