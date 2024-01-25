Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13B1C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT2Hg-0006lP-2A; Thu, 25 Jan 2024 11:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2HY-0006gf-NG
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:08:48 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rT2HX-0000Ku-7g
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 11:08:48 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so2417775a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 08:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706198925; x=1706803725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Pd/jgm3i8BiJcTfpRjRhE7BuCi5lZZ356Tc7kG72gQ=;
 b=LIHIXtf3Fp0E8yKKIqcvB5jN8WMRDO11xNg/K/yohvCHtckCAQ9y5dAZJcPFGwg2SQ
 HFutPqP7VThox+f2YQYB/wCqESN/iIIegRF1ImlJ8gizvAE0xU3zkEXyKV33vfzGTQ2C
 nHm2u1CANQVroXN9oDLNo9FxYJF6EypGUUtT0zQhwkncWaR+qjg9DQ/bPSA6v6TYvW0+
 pIG0whvbHBmVZqjotMVOd/GN3TwveAPZJFwOaCYttLD4VUSnZIH1cj/xKqG84d4cZGqA
 n2264snHbi3bcehHaEjT/i6z/DTWAUa1RfCoX9V4U4rNEXaDNxXY5SwxO+Q7wQTg/YIp
 SiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706198925; x=1706803725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Pd/jgm3i8BiJcTfpRjRhE7BuCi5lZZ356Tc7kG72gQ=;
 b=vKlwhdoNdzITPv1TvawOXgPiMaLZBcu8GGXVGLGQbtKSlAoSMQnK8CMCe7ZGvrsVKD
 rY5NgSV6sdv6hM3FiNfMpc6WRVMcdwObWCEDnfWe0a1vljvWwV5hrPLujdfj2QJb2V9C
 g8CogJDtXfGrNaLrsYAxhPOdooHvJxTnaGVDoSA8jo4f/yYbQ9SCR6iVDzqcuJPFPofJ
 pNRUec0nj7xVJOQV1uO4Imai4z0Ps0+qoFcHkqLTj7vASsTT1+a4AQbUE6xUlEoPx8Me
 zqbfGcrsK4SMslxjFNx9KmoWvIqlndiH/+O84LqAgnPTK/Dp/Fk3DybUoeW+5r7+xlpv
 FKKQ==
X-Gm-Message-State: AOJu0YxQSjF28Fjo2pQNHA0f8Jm6RaK+Qdh0FKK8WE0IzFIv9ZhVRe7U
 PiDudyPzKQ6RdKHKoPC4iuLc7OhfcG9E18t55VPezr1niOggyNYqA0afCrdf
X-Google-Smtp-Source: AGHT+IHlfIiqYpZcDxkn4igAlXeyX2yjF3r3j3mH4vpkZmkhQUGaRX79c5V0B0merJ2L/0XzNNT1BA==
X-Received: by 2002:a17:90a:be09:b0:290:6c4:ad45 with SMTP id
 a9-20020a17090abe0900b0029006c4ad45mr1063116pjs.39.1706198924786; 
 Thu, 25 Jan 2024 08:08:44 -0800 (PST)
Received: from wheely.local0.net (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b00293851b198csm14190pjb.56.2024.01.25.08.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 08:08:44 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v2 0/4] replay: minor fixes and tests
Date: Fri, 26 Jan 2024 02:08:31 +1000
Message-ID: <20240125160835.480488-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

replay-dump.py script still chokes quite easily on a trace of
Linux boot, so I revived some  patches from last year that fix
the script and add some test cases for it.

The runstate patch doesn't have a test case (yet), but you can
hit the problem by replaying to the machine shutdown and then
reverse-stepping.

Thanks,
Nick

Since v1:
- Rebase onto script that now has initial v12 support.
- avocado tests now also cover replay_kernel.py because
  replay_linux.py is very heavyweight and flaky. replay_kernel is
  feasible to run in CI and general hacking.
- Rearrange replay-dump.py decoders.

Nicholas Piggin (4):
  replay: allow runstate shutdown->running when replaying trace
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests

 include/sysemu/runstate.h      |   1 +
 replay/replay.c                |   2 +
 system/runstate.c              |  19 ++++
 scripts/replay-dump.py         | 172 +++++++++++++++++++++++----------
 tests/avocado/replay_kernel.py |  16 +++
 tests/avocado/replay_linux.py  |  16 +++
 6 files changed, 173 insertions(+), 53 deletions(-)

-- 
2.42.0


