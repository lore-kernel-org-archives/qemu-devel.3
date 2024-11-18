Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEA4D591B3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8Yu-0001VA-LH; Mon, 18 Nov 2024 15:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Ys-0001UF-7Z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:30 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yq-0002O3-Ja
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:29 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cefc36c5d4so3549829a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731962487; x=1732567287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T3Jmnxh/DpdyG00jy7Wcdnj5y4BPl3ldQ3b2JlRIXWs=;
 b=LBTPh2aOWzbCee9VPWrgAV2vEi2XlQRCfrklNSY/Opz23A791P95Q2C4WBOZv58nPE
 /ulbq2lmr45dvqCJJe/bFYv8PsxgTwIOOSPtrDT6OGysRlq8ygtlZs//3Fne82jkynFW
 LwZKUeJJRwgXK62gOxWBspATTg0GRTI5GAbRuMK60NbIN7jewdqk1qSFFFbDg4SE+jh4
 sZxV8qzqbOvQ2BxV7BRfetZiQIweH7+l5GSrxIipEZKPWboh+N8oIivErKgXWml54l/f
 Lo3mF2f0lOwoC8YEhk5yIlTddTuYBIjTnEGvDzvtrBEEh0LnyO/WTbPqO0bMByNQVo0R
 ltNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731962487; x=1732567287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3Jmnxh/DpdyG00jy7Wcdnj5y4BPl3ldQ3b2JlRIXWs=;
 b=wwK7+NbemDYRFiktXwvpGkHOQkAOeBQvqZAWId3Hn+utESzLhWAFyYSB0LZVPUcQl2
 RTPtwjY75a0sK3zq5crHlAbYODt0+AXE3bSshGMr+OfZZJ6ntL52qah1wtDOQM8kswAv
 lu+z/ARB+Hm1Y6AO62Uv2y2x16F+HvMmbwzD7VmBY+ODQLeW2G0oHsIMEtp9FqE5JhN8
 9/bEJFUtIn7EO4qSxMdFDGBSarbsdnTi+XNSRspyi5u+5HHN8xrvXji9IxT0e8NuDjyl
 ToV+68tJ8/LR1eydIsiogkZo1/ynGCY85td4VNo9j8vXBa3DHVpXDC2XdsLqO8ze9342
 7gLw==
X-Gm-Message-State: AOJu0YyErnG+IL1cT8sjfyFAyauBQQnCJQTfXmyGwDJRAK/sKvmrnvnW
 h6+8yY5l4srhyIUMKA29uIEJWkgTz0UAtHAFDEANoqNGLw8bL7cuAN1vT9Z0W2ZLvlp6hmi1fjo
 0
X-Google-Smtp-Source: AGHT+IFW7k5us/tm2Dl7A6I52NfSav2nd9/VyGhxXm89nvkcwJ51VF3Yo261v/Aq0vuZBtY9DV1AOA==
X-Received: by 2002:a17:907:60d1:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-aa48347e824mr1450545066b.36.1731962487150; 
 Mon, 18 Nov 2024 12:41:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e08161csm571294266b.178.2024.11.18.12.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 12:41:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E97F5F8C1;
 Mon, 18 Nov 2024 20:41:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.2 0/4] updates (virtio-gpu, gdbstub testing, MAINTAINERS)
Date: Mon, 18 Nov 2024 20:41:19 +0000
Message-Id: <20241118204123.3083310-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

The following changes since commit 0fbc798e4f51d6d2bc05f4965b0eae74ba204471:

  Merge tag 'pull-vfio-20241118' of https://github.com/legoater/qemu into staging (2024-11-18 10:04:04 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-9.2-rc-updates-181124-1

for you to fetch changes up to d6902d7022ba1405a991c94a99b37259d0a6d3a7:

  hw/display: check frame buffer can hold blob (2024-11-18 15:54:48 +0000)

----------------------------------------------------------------
Misc fixes for 9.2

  - fix remaining gdbstub test cases to exit cleanly
  - update MAINTAINERS with qemu-rust mailing list details
  - re-factor virtio-gpu and fix coverity warnings

----------------------------------------------------------------
Alex Bennée (2):
      hw/display: factor out the scanout blob to fb conversion
      hw/display: check frame buffer can hold blob

Ilya Leoshkevich (1):
      tests/tcg: Stop using exit() in the gdbstub testcases

Manos Pitsidianakis (1):
      MAINTAINERS: CC rust/ patches to qemu-rust list

 MAINTAINERS                                       |  5 ++
 include/hw/virtio/virtio-gpu.h                    | 15 ++++++
 hw/display/virtio-gpu-virgl.c                     | 22 +--------
 hw/display/virtio-gpu.c                           | 59 ++++++++++++++---------
 tests/guest-debug/test_gdbstub.py                 | 14 ++++--
 tests/tcg/multiarch/gdbstub/interrupt.py          |  4 +-
 tests/tcg/multiarch/gdbstub/prot-none.py          |  4 +-
 tests/tcg/multiarch/gdbstub/test-proc-mappings.py |  4 +-
 8 files changed, 73 insertions(+), 54 deletions(-)

-- 
2.39.5


