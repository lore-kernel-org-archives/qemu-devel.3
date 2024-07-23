Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C5C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 03:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW6Iz-0002Eu-RY; Mon, 22 Jul 2024 23:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Iv-0002Bp-9Z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:11 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW6Ip-0001kR-KI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 23:35:08 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-66498fd4f91so46772577b3.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 20:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721705698; x=1722310498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nB3islV+RKc7OBd+uXsmirOy1TbpP0Anp04ALMZzybk=;
 b=v/eu5Ogn0KSjca6o1T6x/XYT0qzC0f1AIi6wNEqZo9QZl+4eGGKhXlgUyUq+49dLq+
 UzMyrAfNCCy/PnpZmBZ/+yuJA5A7p2kNokWfiSp9ia7bBs+5mXmypMuJrPQkluOLDRtX
 vdAvRn4yO8SK1/JTBvOWRaOwHesm5cAn9BakTvgCoCtdSGVBWBBqvNJ4Db6+6Lt8NqzH
 vE4THrTvZnzf8W5qo6gtJMILFGqRRbEqolOL63TFJQ47MGZ87TdvQouQFJqxu0WyhKUc
 MRSjt7OxUg76RlzVIJ1TNxxR6qhP/Qqa5kB5P5udGD98Ss427lHSJbtDx66EMCH5gbUA
 YabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721705698; x=1722310498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nB3islV+RKc7OBd+uXsmirOy1TbpP0Anp04ALMZzybk=;
 b=YCkZbyGPeqFmCoFx5Z+EHSkc0LowLGX2+LiuUiXul7Uam6kO5/hrkHx40YBvIgztKu
 dAWXpj7Jfq7hfSKAmx0gAlKl4SyHfol0dUFeCVBpC2chznh4gibOeyDEbqUyO6pG/xJV
 jafzL4kFML5icV9zMptjxXOSN61gQbN6RCE3adT2j0s85t4x9jlLc02pd38VHuRwLQtH
 bu1Ww1/v5af04Njhkh6Lme/wv+jj68/1W7ILP+kZ1XSBICrd/n/ZNdyl2Da+gWPoYcaA
 8bdC2ONFGBGjUFrGkl6u8oNyW3N5coVxpbJ8GvF9j4QT4whvgtq7ev1e5xFugXG3UyW+
 ttJw==
X-Gm-Message-State: AOJu0YwBHx+sT/oasESA8LYryPt0OAcmH/LV/83wJxMlPav06s0BU7wC
 9f/y29Gl6LOBtod+t6s05ojyoect873tv4Vzz/Hs1K7RTDmqH3r0GxhGFfxCVwtKPv+oOONXSen
 /elSZ5g==
X-Google-Smtp-Source: AGHT+IEe0VBR5sVqbHc9ZcRgxqWGqstWlzB9sGhjhat/l9cWMqwZA4NxLFnZlfUYFIo5tffA2jOGYQ==
X-Received: by 2002:a05:690c:2713:b0:654:c11:602f with SMTP id
 00721157ae682-66adab25017mr90115387b3.40.1721705697924; 
 Mon, 22 Jul 2024 20:34:57 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d2b96bfcasm2171380b3a.87.2024.07.22.20.34.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 20:34:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/12] tcg patch queue
Date: Tue, 23 Jul 2024 13:34:39 +1000
Message-ID: <20240723033451.546151-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
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

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240723

for you to fetch changes up to 3f57638a7eae5b56f65224c680654a2aaaa09379:

  target/riscv: Simplify probing in vext_ldff (2024-07-23 10:57:42 +1000)

----------------------------------------------------------------
accel/tcg: Export set/clear_helper_retaddr
target/arm: Use set_helper_retaddr for dc_zva, sve and sme
target/ppc: Tidy dcbz helpers
target/ppc: Use set_helper_retaddr for dcbz
target/s390x: Use set_helper_retaddr in mem_helper.c

----------------------------------------------------------------
BALATON Zoltan (1):
      target/ppc/mem_helper.c: Remove a conditional from dcbz_common()

Richard Henderson (11):
      accel/tcg: Move {set,clear}_helper_retaddr to cpu_ldst.h
      target/arm: Use set/clear_helper_retaddr in helper-a64.c
      target/arm: Use set/clear_helper_retaddr in SVE and SME helpers
      target/ppc: Hoist dcbz_size out of dcbz_common
      target/ppc: Split out helper_dbczl for 970
      target/ppc: Merge helper_{dcbz,dcbzep}
      target/ppc: Improve helper_dcbz for user-only
      target/s390x: Use user_or_likely in do_access_memset
      target/s390x: Use user_or_likely in access_memmove
      target/s390x: Use set/clear_helper_retaddr in mem_helper.c
      target/riscv: Simplify probing in vext_ldff

 accel/tcg/user-retaddr.h      |  28 ------------
 include/exec/cpu_ldst.h       |  34 ++++++++++++++
 target/ppc/helper.h           |   6 ++-
 accel/tcg/cpu-exec.c          |   3 --
 accel/tcg/user-exec.c         |   1 -
 target/arm/tcg/helper-a64.c   |  14 +++++-
 target/arm/tcg/sme_helper.c   |  16 +++++++
 target/arm/tcg/sve_helper.c   |  42 +++++++++++++----
 target/ppc/mem_helper.c       |  52 ++++++++++++---------
 target/ppc/translate.c        |  24 ++++++----
 target/riscv/vector_helper.c  |  31 +++++++------
 target/s390x/tcg/mem_helper.c | 103 ++++++++++++++++++++++++++----------------
 12 files changed, 224 insertions(+), 130 deletions(-)
 delete mode 100644 accel/tcg/user-retaddr.h

