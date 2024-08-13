Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D852C52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjkL-00006Q-PT; Tue, 13 Aug 2024 01:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkD-00005j-KZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:06:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjkB-0007ew-Sv
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:06:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d18d4b94cso3761780b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525608; x=1724130408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lNYFeOuj85AE3awp13lR8/SoEsR70saTNGG/oaEQdwE=;
 b=UZ66AyOADprc88wG0UZsBiAxWl3Q/BgFQXhV0zfxPXKMM6HJImMEvGLAzQYgZlTF59
 X2vJoQ2G5ajBzCVqJlhR+NFq5oi2nIK/MRQV/yWP+XaF32hBJAQc0pMyHQWfpHyX7Ceg
 d6uvpqo9IRuVvYgBu+DxwisLTh+4UVpYOR6vjmAFYF68GiOvDK1SHVyCpKFMsVKY+/Ra
 QxIOCBm81ylP5mlPiknIo0uhJm60k6oIpDrSZGf9jXvzoHfHWD1zhP/aXYrhpH/18WcV
 jO9pkol/sh83t9sOGNBrPO1ZHn9RgOPfAmJxF82UMPqFI5sVie5mFAdectnPXSsXgKnV
 AjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525608; x=1724130408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lNYFeOuj85AE3awp13lR8/SoEsR70saTNGG/oaEQdwE=;
 b=uH89HyDp0AYgnGcc7KBvFOBWWMl5zH47ujIpzd9z8MCa/s/OHmz4yIHaJcV9+LMz0K
 joOuPakjLM6Y+M+Z3JlA0czXJh2q1j96CmdWhuhE3jMaPOdMqGxJBVCqNgvYSHB8SoQ+
 C4zXbP8NSg2IC0sBzSlhiBPNmc21m1xV6FFK04JZ7FhDGUEIWHSNr/SHIXNquKlH38dW
 rqMNTOqWAx8tvv4vaMN/uAJ+fn+uIEcgyfyDs0VYBzu3tiDi9TSSW6q86zHpd1Vix5Ai
 QqPOM14iddRUAVoUUUTi0qPGtHTSDF+fkxyYYj/q+DlKmfJOPR5NE0UbUDCD08xUMFT3
 3W5Q==
X-Gm-Message-State: AOJu0YzLK3ujiqBg77huv7kedr9CMBds2fjCSnlbc4iRXN+dppbY8qMh
 wrLpAOLr/l+p5uVj+l5XvuHBCGDHS5EHcw+27AiqmGZiDqJnRYEAZ8JaSFCf
X-Google-Smtp-Source: AGHT+IHP97dS9zsUo2t3kah6akFT94qGGadxT6VT/jxNBf3KNOFZeY5Wi1LBYo2mWb9TdY+MOZ51LQ==
X-Received: by 2002:a05:6a00:2d93:b0:705:a450:a993 with SMTP id
 d2e1a72fcca58-712551a124fmr3123222b3a.17.1723525608463; 
 Mon, 12 Aug 2024 22:06:48 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:06:48 -0700 (PDT)
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
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v6 00/10] replay: fixes and new test cases
Date: Tue, 13 Aug 2024 15:06:27 +1000
Message-ID: <20240813050638.446172-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Since v5, I cut down the series significantly to just the better
reviewed parts, without adding new CI testing, since there are
still be a few hiccups. aarch64 had some hangs Alex noticed, and
x86_64 doesn't seem to be working anymore for me (with the big
replay_linux.py test). But with this series, things are much closer,
ppc64 does get through replay_linux.py (but requires some ppc
specific fixes and the new test to be added, so I leave that out
for now).

Hopefully we can get this minimal series in and in the next
release I'll try to get something stable enough for CI so it
doesn't keep breaking.

Thanks,
Nick

Nicholas Piggin (10):
  scripts/replay-dump.py: Update to current rr record format
  scripts/replay-dump.py: rejig decoders in event number order
  tests/avocado: excercise scripts/replay-dump.py in replay tests
  replay: allow runstate shutdown->running when replaying trace
  Revert "replay: stop us hanging in rr_wait_io_event"
  tests/avocado: replay_kernel.py add x86-64 q35 machine test
  chardev: set record/replay on the base device of a muxed device
  virtio-net: Use replay_schedule_bh_event for bhs that affect machine
    state
  virtio-net: Use virtual time for RSC timers
  savevm: Fix load_snapshot error path crash

 include/sysemu/replay.h        |   5 -
 include/sysemu/runstate.h      |   1 +
 accel/tcg/tcg-accel-ops-rr.c   |   2 +-
 chardev/char.c                 |  71 +++++++++-----
 hw/net/virtio-net.c            |  17 ++--
 migration/savevm.c             |   1 +
 replay/replay.c                |  23 +----
 system/runstate.c              |  31 +++++-
 scripts/replay-dump.py         | 167 ++++++++++++++++++++++-----------
 tests/avocado/replay_kernel.py |  31 +++++-
 tests/avocado/replay_linux.py  |  10 ++
 11 files changed, 245 insertions(+), 114 deletions(-)

-- 
2.45.2


