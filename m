Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D1BCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 14:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE70O-00031e-I6; Wed, 29 Oct 2025 10:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE704-0002zb-5u
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:09 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vE6zw-0007Vv-3A
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 10:18:07 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-378d61ce75aso10677541fa.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761747474; x=1762352274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jH2ovA5kxRIknVuqXTGVDlJABoWI8fAisSqXcIX8I1g=;
 b=JzVRG/xoFRRvcwKNWJKTvrceDO9XrwULbXQ25kDquA9tfKrIyYCnbzD0pKHORTsvV3
 EXx4DP7QbPHTnbjGAHVicDVYi3WHGxJUq/haLJ1lSBE/1abVxin1vtQThwolTWXUU9IT
 rJ2vpxam1yaW4/mzoFlYzbm43FoLlmyGMO3h6/cDt4DC5RHn8NFbRxRxXVvEi2vzQmxn
 zFNlyo/3TJwissAHD9Gm0HyVzRtBOgdxQKOdJmEr6ID9S1jLdQc1YJiS0YWBFdh4GWp4
 /m58vs4hXhXybS7m/nnOz5N1cHEy2QzdALDcC38DBci+G7b6hUgoW+43S8uxVEL6dFwm
 ugtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761747474; x=1762352274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jH2ovA5kxRIknVuqXTGVDlJABoWI8fAisSqXcIX8I1g=;
 b=CsnJKpAQ4ymYUbIZuOXNODqtkGkh+qLxvhZweKwO1WbiYoYfhUPoUSxsUo9hVTDgrN
 pjSKeV3Cq/85z7u92uaVyfvKCeR0jnx7XbeVOz0IFPZ6VSNJclN7WmEAOo+C1Q8/ofCC
 LkXRnDBSItap/WTilyUj2Y9eMmPtRohh8CPt2QNSQjib3epw4M195FiRna1u5OOa5FZf
 eZ+F/NhYEgEpmDHfzItpPVCAEBc7lpcAzfysC7fXFiQP9Kl6PK8Z2TKIUgrPO9oxJbCJ
 M2V8Sf9Vl4vPX7JLfb9c/AVV0kNub6Mao5iZv5j9NqonkkqwDLJ4q5ib8OtIvPUlPTZg
 MFpg==
X-Gm-Message-State: AOJu0Yy9C79vMI9SctrjmN7xZ+gMRboLeGjkNXstHDMb4iUeBTJdRW0j
 zO9XnBq8n5k5jmWr3nPJD31E/3jNoD2ktgZynCzsBhIdlkoMSrrkvxhQGY2eeVs1808=
X-Gm-Gg: ASbGncvghEJUevJhRPAA45av8U6lYUyhQBVxTLoiBb6I2KeKZy/ZLvwNu8NdKEkZt28
 5wXFHyj5s8I04WYSa/efH3Irgs35TXaIvt4Vf8J6Z2RP3EKty58d81+RHRkMfIhn34mCcHHVdhG
 75Q7ugg3mVT4tKnizDwPrHUERkuqUw496u28r8FxV2wcy6kEp1d61c3l/zRtjToM2wdm9xJ8OFM
 9xkwVk8QQ4Amn3eKbr0z3gunMntpePjAE7QV2WBbxs4otfXinJxYt4K68ozEYFVD+fUJacTGOYU
 bqzuVsx5EUjISlKcsCwGGahZ4PBpidbFYluwB11G6ilFIYBPBGiOGYVHNL1f63ArHqGvkrgP7Hg
 VgEr536xxTLxg3HPAUpGS+/ZJwOYotqjAhFBukrdm+D8Oby8QNWYK7pjB9zn3Vc7YnZYsKQ2MjI
 dDeE4vdVPvK5ovCMOftRGXtcreZWshH/U/J5fJ
X-Google-Smtp-Source: AGHT+IEBrNVU+hn+SRIAuPZya/WmA2ki8vO2huTC3oRc92XivbIlrGXmXHTySsWrMeBvotcpiwXplA==
X-Received: by 2002:a05:651c:2207:b0:378:e30b:d1ee with SMTP id
 38308e7fff4ca-37a05eb559emr12499921fa.23.1761747473992; 
 Wed, 29 Oct 2025 07:17:53 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0d7655sm36173551fa.41.2025.10.29.07.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 07:17:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	edgar.iglesias@amd.com
Subject: [PULL v1 0/3] Microblaze signed division overflows
Date: Wed, 29 Oct 2025 15:17:46 +0100
Message-ID: <20251029141749.1274729-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit bc831f37398b51dfe65d99a67bcff9352f84a9d2:

  Merge tag 'hw-misc-20251028' of https://github.com/philmd/qemu into staging (2025-10-28 11:48:05 +0100)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xilinx-queue-2025-10-29.for-upstream

for you to fetch changes up to cfc1d54251d3b4c4cf21c4fa278c8aea2fe25a99:

  target/microblaze: Handle signed division overflows (2025-10-29 13:37:44 +0100)

----------------------------------------------------------------
Xilinx queue

----------------------------------------------------------------
Edgar E. Iglesias (3):
  target/microblaze: Remove unused arg from check_divz()
  target/microblaze: div: Break out raise_divzero()
  target/microblaze: Handle signed division overflows

 target/microblaze/cpu.h       |  1 +
 target/microblaze/op_helper.c | 53 ++++++++++++++++++++++-------------
 target/microblaze/translate.c | 12 ++------
 3 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.43.0


