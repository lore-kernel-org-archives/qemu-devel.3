Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CCFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvCP-00054V-IJ; Tue, 30 Jul 2024 18:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCN-0004uy-I8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYvCL-0006Uy-Pj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:20:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso27123365e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378000; x=1722982800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MintP0wize/JyFBaMUoPoghZCF3wdgvih+vERvdHduU=;
 b=yaVBVAUHOxF0HPGswRPzRswxFN7NKzOUZ91ivIbE3RSrWnLMbbCGyCGq7cV5PRhDP4
 BZ7rvr4qW3hs/cx2hOIVViuX/qjhg+AWlIMRpVQmidZWTjtgyCDOtr8sb5M0x4XmqUoI
 516tUYZXsMQQmlLumk9rklmlWOq6i+XtF9pUZo/0Pxk6dJCfYQErXs+1YHccJBB7Yw52
 EjJO2ayHorI79Z55JC+ATSkmXxvGGUO/KL0xn2sZCFVOcwHi5qUwJqtTKhL230jChdVL
 RY6zzknO2vM1FBzolUNvNIPlk2mxBXo+ymlvs4PcmWM9GsqgaA95eNLeTYC63QSHd9Sm
 6HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378000; x=1722982800;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MintP0wize/JyFBaMUoPoghZCF3wdgvih+vERvdHduU=;
 b=KrWYEg3RrjeWR6aFxNEmzoOajEtLdEikybV4FCcEiMkuWs+o5AIk3zpfxULVgL163L
 kOZLSXorUvNMB1WZusk9QjsrkY3OGUjdSoycw6CR8CoYSAvF0+Wn2tX0FwzLg+P611Hx
 J3aj6ySACd42Xq/vOSa6AdYoPpiFOMoGCi9Sn3LKBBNxdmKXGlYReTiHobNit1L3KCBV
 7xW6vvtkNCDiO6uHiWQFpwQidyX3fi4DtgBbRATFi5T3xqNmpcgCyGPLZqfC5LXj0vMw
 CB4J304tdOXqv2DgIHsx8lxZvwbY00vu5UkTFDkD/zHWRsE+HMgnYieiDQv1dKBfNrGm
 cX1g==
X-Gm-Message-State: AOJu0YxFaOFTH+BIooj1trc5zHxaYPO93PTI/az8/P8zG3A4DLPe6mzB
 lFhmn0ubYsp/BzvDLlDUHRbk13KHjJ657jWsyKunxX2EnI0nh5OEZdaE6bg+MAUM1IV48DyGKtD
 G9LU=
X-Google-Smtp-Source: AGHT+IFaE8sNreQGtwOGJjI9Vu8MhSBUFNHfWG20UQux9paJM1Hhax9iFJormmuxCxNsme/EbV7pHA==
X-Received: by 2002:a05:600c:a01:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-42811d9f21fmr85573775e9.16.1722377999606; 
 Tue, 30 Jul 2024 15:19:59 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36857d5asm15575516f8f.84.2024.07.30.15.19.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jul 2024 15:19:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 0/6] Docs testing patches
Date: Wed, 31 Jul 2024 00:19:51 +0200
Message-ID: <20240730221957.34533-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The following changes since commit ef009e4b4dc0421464008e6e303b892141ede579:

  Merge tag 's390x-20240730' of https://github.com/davidhildenbrand/qemu into staging (2024-07-30 19:21:58 +1000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/docs-testing-20240731

for you to fetch changes up to 7b60b971cc2f52ed2a69006a2ad709df2831cd67:

  osdep.h: Clean up no-longer-needed back-compat for macOS 10 (2024-07-31 00:15:00 +0200)

----------------------------------------------------------------
Docs & testing patch queue

- Test QAPI firmware.json schema (Thomas)
- Handle new env.doc2path() return value (Peter)
- Improve how assets are used by some Avocado tests (Cleber)
- Remove obsolete check for macOS 10 (Peter)

----------------------------------------------------------------

Cleber Rosa (3):
  tests/avocado: mips: fallback to HTTP given certificate expiration
  tests/avocado: mips: add hint for fetchasset plugin
  tests/avocado: test_arm_emcraft_sf2: handle RW requirements for asset

Peter Maydell (2):
  docs/sphinx/depfile.py: Handle env.doc2path() returning a Path not a
    str
  osdep.h: Clean up no-longer-needed back-compat for macOS 10

Thomas Weißschuh (1):
  docs: add test for firmware.json QAPI

 docs/meson.build                    |  5 +++++
 docs/sphinx/depfile.py              |  2 +-
 include/qemu/osdep.h                |  3 +--
 tests/avocado/boot_linux_console.py | 24 ++++++++++++++----------
 4 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.45.2


