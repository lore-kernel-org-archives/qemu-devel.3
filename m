Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3406C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 12:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O59-00081Z-77; Mon, 28 Apr 2025 08:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O50-0007sm-IK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:26 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O4x-00036B-2n
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:26 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so664322266b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845160; x=1746449960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5mQ9IZhr7/ovEKIiDLpqqFq4fpN84jvhC9IW2qym288=;
 b=oNS3W0+GyKYpCZo8zgP6lw4xwLTE6hxfSFiDnc52BtWCiqTVOzRP3DQJ2qhyQh7xNX
 ibshUxcki4nqrAVMXsVJkIoHdNEX2A5I+R1byZj9OcWpeBm6RtTk8zImUavm1BgfjIus
 D5x4mH8ju9kzLf/tz40ETsAXYkeDaqICYC7QqqWv88P5e0jMTVrKnYNOnFDchM7xfC1k
 gPGOqV4FRCVQdH7ziSYQyU+WfAS8SSvG/nXOyEWgpcwTfVPiIcGk4VTRmtekXXNpdpEn
 Uv3HP4n3w+SYq26WIY6OM/J5q9TmP/GNRqNorSxzWDjpyqVEc9Uv3CWSNZmOhsXI8H1N
 15WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845160; x=1746449960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5mQ9IZhr7/ovEKIiDLpqqFq4fpN84jvhC9IW2qym288=;
 b=OjiUPhFowEoVLKes2N3KjISiYIQtxr8JrCfBbyGG8JtOL8OiaBIPkYNGCOyui0NJho
 SDl2EjpP5owEEGwWuCM/PDrx/tD8fco50zJvVQMcBkgD0Sx/mHVqXtAJJ9TcXfwHi+Vl
 qACSUZaE0YuMF8mlTtNUUkwC67u2ecIQp9/2dJ8nRCwjDunDVA5f9cFg5LYvq8cB3Uq/
 0Um9AiO9RXC3pAvm2QmOggf/n/rm3zsYBBEXFWbsuit3pw6pbQwb3tdn2WUbcohDiB23
 cHbtoTM5euZFpELnG2wvJnFA27e9IF/PNj2jv5RarW/c411MnJHT5gioxrN/93PvND4I
 cGKw==
X-Gm-Message-State: AOJu0YzbEeJ24ylrKSsQ1XYepniOILyhCblYJJrTBsd7KbPnhY4eoYsB
 lsJY+sGhL+8hgEHei0rv3PCreO/CjyFavxGNEHaRQuUkSqrr7+RMlLQriHUhEas=
X-Gm-Gg: ASbGnctoO1D8+Tux7m9LjDReCtAGvSYD4ePR3i27XQbpLdR5F0mQfwiEV6+wukdTUvH
 fAnF1pNjf8Bkc+kO8wIWY97G2qRi70DmSxHS/NBxusn6Al6AGBnWKuWGndyqQMc/HvYGUtft4Rs
 SX1ATmEkMFp82AVy0vLvHVVNiTdYHg2uQmyZ+8prFs4dck0QW9dMUmzJbAX0OmzIGzIVSSAW/fg
 f00dxrQjkLUQyGK/2mvk8iHKHrbPJJkHoojCyT90jpfOJOWPGaXx3dg/R463Dr6yL6gfDHfQiir
 1gaArrqNRY3xm4GIfxRmZKlxiEmvshFPVr/37SSkp1w=
X-Google-Smtp-Source: AGHT+IH5xfUaHbJ07bPqoRiVPoWUEldLAazuA+mH0x8Bw2a9shQVtJTe4aSCtPdAeEyY2xv+5egWCQ==
X-Received: by 2002:a17:906:5801:b0:ace:7f5a:bc2 with SMTP id
 a640c23a62f3a-ace7f5a1787mr619522466b.37.1745845159976; 
 Mon, 28 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e41bbc3sm622870366b.3.2025.04.28.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42B225F905;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 0/9] Maintainer updates for May (testing, plugins, virtio-gpu)
Date: Mon, 28 Apr 2025 13:59:09 +0100
Message-Id: <20250428125918.449346-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now the tree is open here is the state of my current maintainer
queues. I've tagged the virtio-gpu changes as Cc: qemu-stable but
given how close to release we were it didn't seem worth rushing them
in for 10.0. I've included a MAINTAINERS patch just to make sure I can
route any more fixes until a more full time maintainer volunteers.

The following need review:

  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  contrib/plugins: allow setting of instructions per quantum
  contrib/plugins: add a scaling factor to the ips arg
  tests/tcg: make aarch64 boot.S handle different starting modes
  gitlab: disable debug info on CI builds
  tests/docker: expose $HOME/.cache as docker volume

Alex.

Alex Bennée (7):
  tests/docker: expose $HOME/.cache as docker volume
  gitlab: disable debug info on CI builds
  tests/tcg: make aarch64 boot.S handle different starting modes
  contrib/plugins: add a scaling factor to the ips arg
  contrib/plugins: allow setting of instructions per quantum
  MAINTAINERS: add myself to virtio-gpu for Odd Fixes
  hw/display: re-arrange memory region tracking

Manos Pitsidianakis (2):
  virtio-gpu: fix hang under TCG when unmapping blob
  virtio-gpu: refactor async blob unmapping

 MAINTAINERS                               |   3 +-
 docs/about/emulation.rst                  |   4 +
 include/system/memory.h                   |   1 +
 contrib/plugins/ips.c                     |  33 +++++-
 hw/display/virtio-gpu-virgl.c             |  60 +++++-----
 .gitlab-ci.d/buildtest-template.yml       |   1 +
 tests/docker/Makefile.include             |   1 +
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 127 +++++++++++++++++++++-
 9 files changed, 202 insertions(+), 31 deletions(-)

-- 
2.39.5


