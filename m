Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6EDC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RZQ-0000ew-8n; Tue, 15 Sep 2026 07:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZ7-0000e7-Lp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:11 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZ3-0005PL-Ka
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:09 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350f89so1603010f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789472582; x=1790077382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QX7411/5ED/T+bhUYNtfHfCA651QxXurBZ0xSbIhwWw=;
 b=BEMgAyjez4qequrqAOhoCM2hYbRwlWvAI1E9UHnM+1f11pTUA35RTVPs+DGANGVhS1
 qtf32/ZBCOK22uwJXuS0rwDOIPabgzBP6UdxwjlyBdjfbW8xLGt5oUgBJzaFE7ao0UG8
 5GfUtdTrmYGe+JqHl6iQjR1mZ47jBFwmHPqX2jCa5vbyW3orQ0mSCfq0JMZmq6H0mzvc
 kTxpDcmAS0gE9E7tViwCk2ixw5fL8SdfplwHSCgH1Fu/27OPwlr3hlu3HMrXovRDXDL9
 ZsJ89HaZUDG14X7xGki1eq6ySDkFTKIjqyiJViObjFnEAjhfV5EiWISRPCcd0MHUMdVW
 iSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472582; x=1790077382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QX7411/5ED/T+bhUYNtfHfCA651QxXurBZ0xSbIhwWw=;
 b=RRQB9HmEm2guSXkthiqWovJZmnk9sAw3Y8nITVnseKRsVnduBY57WpeJtmkWoqFH13
 HEeK7KZpTNlbPDhi9X36dHLsffjrYuSGT1dNJgGovHim/vSmXA+q7uzXPA1hCkCeZMbu
 YnSx1LOOXueMRKN361t0HaLt6lVyFc2hZz++L7JZHC7oavAawPf8WoNhfhd3zzmJQZg/
 QHm+5J842wgaLxNh8XFD7HiXcfTaPNKTxw9y/zd3FhgyeACQ21J24AHBA6KxaAMvDwWe
 ZJrS3edRTkajN83C6mI6GTup3dpiLd9YRPvGJTeXvkojIe4pDmN4VV6/YFJxBqMSdig4
 ZNyQ==
X-Gm-Message-State: AFuF++ldqq51pugmCiISb6AAERpVx53CDX1VfRHil9jX/i1VXZfjWBnC
 C1mCX5qPR01t7FKfkNnQnLP31GqhQvT+NtP9OmhrYndIEzng6W3gzaOHEic0M01L18Ibs7qzbxm
 4/OBI
X-Gm-Gg: AYBFou3U/O53M2R25o4qYAwz56j2ure5TZS/0R124OiOUD2aMLcp+/BYIcwjmLo5Mo7
 vfjtxmZFgG5NCFrxgYmP9nJLvAKUlVZWLXrggv+qDctwg/HY1j8w/yDAuHD5QcpEOKP+g8vDk3C
 7i3yx1RRZI8oa/m9PPpkhKJVs9XgnYfFY4K5OHuN08UYsB+0h4RmD7CfLCDSi4ReWC4JddoAqUx
 4u/+hMSF3Z1Nu7svMVMo3jOzWkf0Ve6lMfrXpNVkEL6uXyH+J53TwiAPGyPsfaJ04bh73ZdxikZ
 pFlGaQcAf5luHimB1PpktVMg4d7GhZGMF+gY5LXdmEz1gtXh7M/3OUM89+PE6CsfEuPzjV8g3wZ
 bFY+rQUMIaRgFKftxJISAz38O532uMUTV5JJcuHDiHG4ifCHGBVuZMbLRajV8q8+KpSxyP9pHuH
 NFwuzBUAAAV3kDdzXPDkzUQaNkXQb4Z3ofatgN+lCRAksPQkXytqCOcyQweGEtDVPAnKC7
X-Received: by 2002:a05:6000:41c8:b0:487:a9c:a287 with SMTP id
 ffacd0b85a97d-4870a9ca378mr525635f8f.50.1789472581774; 
 Tue, 15 Sep 2026 04:43:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:33e6:6107:4678:322f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm33648081f8f.22.2026.09.15.04.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:43:01 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/3] parallels: report the stored dirty bitmaps in qemu-img info
Date: Tue, 15 Sep 2026 13:42:55 +0200
Message-ID: <20260915114258.3862446-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

The following changes since commit 5f664cd37aec17e8145aa117d8da68f507edc8f1:

  Merge tag 'ui-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-09-13 15:54:17 -1000)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-09-15

for you to fetch changes up to ba48db334ba3ae0b89015583057468e127cb903c:

  iotests: cover the qemu-img bitmap operations on parallels (2026-09-15 13:30:29 +0200)

----------------------------------------------------------------
parallels patches

- report the stored dirty bitmaps in qemu-img info, the way qcow2
  reports its bitmap directory
- cover storing a bitmap and the qemu-img bitmap operations in the
  parallels iotests

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>

----------------------------------------------------------------
Denis V. Lunev (3):
      parallels: report the stored dirty bitmaps in qemu-img info
      iotests: cover storing a parallels dirty bitmap
      iotests: cover the qemu-img bitmap operations on parallels

 block/parallels-ext.c                         |  26 +++
 block/parallels.c                             |  20 +++
 block/parallels.h                             |   3 +
 qapi/block-core.json                          |  45 +++++-
 tests/qemu-iotests/tests/parallels-bitmap     | 217 +++++++++++++++++++++++++-
 tests/qemu-iotests/tests/parallels-bitmap.out |  57 +++++++
 tests/qemu-iotests/tests/parallels-checks     |   6 +
 tests/qemu-iotests/tests/parallels-checks.out |  19 +++
 8 files changed, 390 insertions(+), 3 deletions(-)

-- 
2.53.0

