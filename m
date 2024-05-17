Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A6C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 15:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7z6q-00052Y-Qk; Fri, 17 May 2024 11:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6a-0004uc-MD
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:48 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7z6O-0005N9-29
 for qemu-devel@nongnu.org; Fri, 17 May 2024 11:02:44 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so456394966b.1
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715958149; x=1716562949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qrOV/DIyONqXTVdb+suvmpjn/SNPH0LdU+RCCwepbLA=;
 b=cwdcL51pqXVG+BID45FLT86hqxh4pGraPB/PahnGY93rb66jKrCIj33D7kMnjhcgLb
 7DCwfRoddBkRXsf0cnCJTALJPIo79G+Yeqk9ggiCGhq/WvDZs2J5uVpDADLZ+yvEI311
 TGXNWfWgovjpr9ql7SQHMRB2l6CgDygsO65/KX9Mks13JmyH9r1QmRsxcVllF03+1GJx
 ieBoO0a/MnAY2g5YtIOaAJ2+TbyuZOM6qe/KvRYSpISIsFB48Z0lpoup1tKyfe7i4zWm
 Qrvhae6Dzl+3yy3eYj6/paO7IhXjpT/YkSih+TrhLqgK8LfP3A/ZGP46E7OGqanp6IwL
 hkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715958149; x=1716562949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qrOV/DIyONqXTVdb+suvmpjn/SNPH0LdU+RCCwepbLA=;
 b=pVxffOYPA8dbXxG/rk4kkAbpt+TcyANSJieIqFgjCemV3prjbgTLKMKEaTZc/RwebZ
 5Nm50Cmo9LNOGBPOtQhkwCD2+TwXLcoOvu/ZcVnyZnq9OjmvWKNKHWLpPvU3nM2lRADf
 hm0X8wLd+/3h9vLdSi0vyQCpk6nnw5b9Iu43lB5Gx0Y5ViYVcscqAin7kv7QZc3nkrh8
 Wyjp3NAJ/RF6KasLl668pncti2TPW4HzWlx4Z2owQMU/29QGBp+dh2+E8JOxzcJSSMZZ
 kd1gpvl1dqW8kjSrbrzBc6JUlxKh0yYrpET/Ec/5gbwvFLR3CC5a58yUguuVq7pDnGiI
 5AOA==
X-Gm-Message-State: AOJu0YzN+oMRa9Df97yV7k+xPcYacOGTgVLXfSx4yC5yhCxaZEi2iEBN
 0jCs0/l1YEpyFkFakwpr6fVJ3eWejFgJOq9qP6dbTYLQW3CUxNoXZ84rdM+EG27urtkl6nIayq8
 s
X-Google-Smtp-Source: AGHT+IGKE0HEEPa8h+pQwOl+C1RErk6rN08vTX1/kkA8sek2YxcdZSTwrp5wN6lkpgxXPqb9cBgx3A==
X-Received: by 2002:a17:906:5a5a:b0:a5a:34ae:10ea with SMTP id
 a640c23a62f3a-a5a34ae118emr1284172966b.76.1715958149553; 
 Fri, 17 May 2024 08:02:29 -0700 (PDT)
Received: from localhost.localdomain ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b1773esm1122179466b.199.2024.05.17.08.02.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 May 2024 08:02:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/5] Misc HW patches & fixes for 2024-05-17
Date: Fri, 17 May 2024 17:02:22 +0200
Message-ID: <20240517150227.32205-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

WARNING & ERROR from checkpatch.pl in tests/unit/test-smp-parse.c
deliberately ignored.

The following changes since commit 85ef20f1673feaa083f4acab8cf054df77b0dbed:

  Merge tag 'pull-maintainer-may24-160524-2' of https://gitlab.com/stsquad/qemu into staging (2024-05-16 10:02:56 +0200)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20240517

for you to fetch changes up to 93a3048dcf4565c73f2aa1d751f7197e296f1f1f:

  tests: Gently exit from GDB when tests complete (2024-05-17 16:49:04 +0200)

----------------------------------------------------------------
Misc HW patches queue

- Fix build when GBM buffer management library is detected (Cédric)
- Fix PFlash block write (Gerd)
- Allow 'parameter=1' for SMP topology on any machine (Daniel)
- Allow guest-debug tests to run with recent GDB (Gustavo)

----------------------------------------------------------------

Cédric Le Goater (1):
  ui/console: Only declare variable fence_fd when CONFIG_GBM is defined

Daniel P. Berrangé (2):
  hw/core: allow parameter=1 for SMP topology on any machine
  tests: add testing of parameter=1 for SMP topology

Gerd Hoffmann (1):
  hw/pflash: fix block write start

Gustavo Romero (1):
  tests: Gently exit from GDB when tests complete

 hw/block/pflash_cfi01.c           |  8 ++-
 hw/core/machine-smp.c             | 84 ++++++++++---------------------
 tests/unit/test-smp-parse.c       | 16 ++++--
 ui/gtk-egl.c                      |  2 +-
 tests/guest-debug/test_gdbstub.py |  2 +-
 5 files changed, 44 insertions(+), 68 deletions(-)

-- 
2.41.0


