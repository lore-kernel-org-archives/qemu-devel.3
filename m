Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3B7CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 10:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYhmD-0002Wg-8x; Sun, 14 Jun 2026 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhmA-0002VL-5C
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:11 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wYhm8-0005cc-B3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 06:09:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so1899744f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781431746; x=1782036546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrlG6cx2d3W3ukWS6VDWYalPvD+Gq3EG5da+LiZXtQM=;
 b=ugVyUP/lyM+pFhDqUimFnsuvfVP3prCGOw/Hq6nOqOv/fHxnAgBTFbvYSmc9im4m0z
 cesrv/0g6aHqKf0Tah3liUMDGuqdOOf4ewRm7Nc44Ss/k6m+Q+84JR0MMdf9NdtB1wSM
 EnFLtT0re3vWsqtZZx2WQJhAnSJbEjjf322ktpjucZhmwjICHrnFD43n5XJwMzMOQiC7
 Lfx783ZP+XcGYE+SyzWLQX0OKXVk8ON/+rVhqsa5uFLqGhuGwIswxZPs4WXlRTSKDPjF
 vZSs7w2mDBOlHKnnSTpTMwioLSdk01wYjh5kGw9sQoWzgaI5sm4eutKQkfKBmAzI1qwe
 iWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781431746; x=1782036546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZrlG6cx2d3W3ukWS6VDWYalPvD+Gq3EG5da+LiZXtQM=;
 b=N3v/q9QajKsfs9U0Sz5f9JJVfDGPT3MeOjEe9n5osRvAHh++dxFp3+XzKoRKgia7JX
 wD0arRU3hlElq/WqejjpkdC6Qqmm0DZfyFVQZhwfrEAKlOZpBMj6drtdTlslsONjke5W
 Trdd4UjEzY2nPWdHJd78VRgBfa/oztV4C8ipcdMM2fPgX2lB8kKDnnqho+pWThd2QScG
 65QlSy1oKYRfy/2VEWPyPXFfVxw5HsC+juTftcvDJVflKTE0VAEnd6nIeze2eDay59Hg
 pSmLN/6RpJ+Kj2icZ8BZRYaWyIqckFqXRCT1LEladz5cQDmn3sqFMEKl5ItN34+xKHF+
 /GDA==
X-Gm-Message-State: AOJu0YxwaL7CNFyLItHu2lrukLlWelVtjBjFpwG1krjAStqrZ6Pe1MOb
 gy9mtIvTWcRuYgI9EsnCmUbZyTvpyS/iS/BuCJgpSXXHBT0oPuNvjwbbQPboeDZ7O3VgfUtIIFL
 igzqN
X-Gm-Gg: Acq92OE65dPs5MeXaPRli75bMyhfJ9h4Mc833ZNKkWhMsGJ2XMPaJhiRnQ9XUwIlrsR
 QCuu65b6nJzbg3EACPJGKQfZyoj6IO5ICdmtMVCWY1FFmKZx0s95Fann7YIXCpDDKcbJ6nyNUPQ
 39SCDwnxaaZpkK9zQ0ShHyTIYc2ucmxzAyFT85G4VSrU2btI6pNSKzHbCadKSuAKYn8tPj2Q0LK
 chVghI4m/S8dsDHiM2iha2KnVz76hVzfElxCFh/M1p9R9jy7P3Gbo9sFEGipDuZhqhOA1fpgsoP
 UEnklGlHzsOSp4hAmZqCE2aImuJb1XzDdipIxdVZl6PbpKHdwvYkzDsxjNOEHLseTqz/1s4ldvD
 Y7obWWKKfX3FD+VrbW/8ss8Y9/KJ6iR/O06rL+C3g4FSBhIISX+lORGUmfvChk0vZCnaNuBue66
 9NLRFgcbKWpVmHlfeTWQt2m3Y=
X-Received: by 2002:a05:6000:4387:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-4606db965f0mr15268713f8f.9.1781431746355; 
 Sun, 14 Jun 2026 03:09:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm23490719f8f.18.2026.06.14.03.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 03:09:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1D785F946;
 Sun, 14 Jun 2026 11:09:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] testing: some minor QoL changes for functional tests
Date: Sun, 14 Jun 2026 11:08:58 +0100
Message-ID: <20260614100902.885698-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

I spend a lot of time trying to recreate functional test failures on
the command line where I can add gdbstub or run under rr. Invariably
this involves running the test with "env QEMU_TEST_KEEP_SCRATCH=1" and
then extracting the command line and tweaking it.

I finally got annoyed enough to look at the command line code and see
if I could do this a better way. Ideally I could just do something
like:

  ./pyvenv/bin/meson test --suite thorough func-arm-aspeed_anacapa --cmdline

but for now I'll stick with copy and pasting a line from the logs and
saving a few seconds removing all the QMP and console sockets.

I've also included the pylint change which is now reviewed and can be
picked up. If not I'll grab it next time I do a testing/next sweep.

Alex.

Alex Bennée (4):
  python/qemu: split arg between base and harness lists
  python/qemu: split console from harness args
  python/qemu: dump a developer friendly version of cmdline to logs
  tests/functional: tell pylint not to check c-modules

 python/qemu/machine/machine.py | 29 ++++++++++++++++++++++++-----
 tests/functional/pylintrc      |  1 +
 2 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.47.3


