Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF41C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwor-0001t5-AZ; Sun, 27 Jul 2025 04:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoc-0001SP-BM
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:08 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoW-0000Aq-Rp
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ae0e0271d82so656632966b.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605177; x=1754209977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lH95b4uBs0vcMVHT3CcmxeT0bpVwl2ygjWpRhTjtzNs=;
 b=TVi1h0MfnzgW0QaaE7ZFcvvAPXsJ0T0iaJUp767trh239uYGUoIxxx3FwcO+m5mFsJ
 WZwji9NfngYbf3HdebTAPSyXn6OP+kyNwDwSl9ahXL3qmHJG2hlQ5EoFlK3yELSQ9o6v
 Ig2MTo/lZH+unGMKYguh6jExcpdFryjSd3DPLmeuWjPIJbrfftP7wuQvwlzJfLzduZSr
 hsLc+7C8DJPbpSTOR8RVTm3UXUFWY+T4MkxrwOjtHMuZlu4HN95dChDzk1Q765Ko4xXj
 c0JnzJxX98eHKjPqm2CnXVWqo/x5cfcyr69+JFHng+SWtEpRIlz0IIw+61NX4aRfiGrs
 Q1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605177; x=1754209977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lH95b4uBs0vcMVHT3CcmxeT0bpVwl2ygjWpRhTjtzNs=;
 b=LW7/7m1NFwTsPUUSTIaMWFW+M4sa/muRpblqOkC8ksVAOvUmiCvq07VlPLRQKprkr0
 aNpl0eQLaAz12/D08WBehUalPitbDyulsmcQV1Djqg7+62mCDVRSHu3TycvVwzgHtaYt
 JYePlLfbCOBO4EOVBclESmCCZ/v9iwEQHE7zdBDRfGNPhNfqP9FCz0ab+huNRcjVfDoo
 KTWlrByLOC4sEpT//f9H6dW82dco0SNdcSLYUz5GbPL3mASO7hMlE78bm/d/2gTOPfAG
 EOaH5F7DXUylCYDRF+mErHzTYrAY6o/4HDBMtRrXRtV/y6LqycNEHTi2DnRi8AQ/OzN3
 pBnw==
X-Gm-Message-State: AOJu0YwopiDQKd5+W9yDkHyujGHXyfoCO/EkBjTe5P8dPzxk6564NwaL
 zq1HJw1KZ9i728s/d+ttifQfnTt93f54Kw6YN4zP0gAhHmG+69KcsKtUXmPXx05rhfGnAZKg8f+
 niYAf
X-Gm-Gg: ASbGnctbjPJoWg20eJ+JNt1uvuxKMUOG/VD4nGUlghHiDnInGRn8x+AsUONxpx+TXxJ
 O2aPGytv5r6c9YbSAhMWZ1sjTIMGzW0f787IAoXFA4ZY1HTZJoGraW78PBUX28xmWr6zxhuxRkm
 +NE/DVGxfGj+fO0SdONVDHF5/RNqv4v4z4voa/adG8/rGx4VnMLoB9r+8ix07BNxYcbCHEQNC56
 GYgkVqK7Zo6MITiUYpmwpF4oUdAGV/8CBsc3utv8IC57vIHl0xrKpme1kBQSwb6bkSPpHisg+sW
 3oa6dzxF8RMe9YmoncOgLXeskvYkvUADY/lqYURMmdJsmB405i5nYuf16Fmujl1Hq3fxZdOb2gA
 5NAlw7s0zphgJzYJ4lO2XsVo=
X-Google-Smtp-Source: AGHT+IHNtXDuKeHd8+xDU8qX5k+dA43cNuU55VBYw8VvFbomgdR8d8Xb8bT2exn311Wfc+xPt1HxiQ==
X-Received: by 2002:a17:907:e84b:b0:ae7:ec3:ef41 with SMTP id
 a640c23a62f3a-af61950b3f4mr917442066b.45.1753605176852; 
 Sun, 27 Jul 2025 01:32:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af63589fe4asm258360566b.41.2025.07.27.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1809A5F7F1;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 10.1-rc1 00/14] documentation an testing updates
Date: Sun, 27 Jul 2025 09:32:39 +0100
Message-ID: <20250727083254.3826585-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

The following changes since commit c017386f28c03a03b8f14444f8671d3d8f7180fe:

  Merge tag 'pull-target-arm-20250725' of https://gitlab.com/pm215/qemu into staging (2025-07-25 08:24:52 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-rc1-maintainer-260725-1

for you to fetch changes up to cac08383f06dc378afb23913d65a95442bbd5516:

  tests/functional: expose sys.argv to unittest.main (2025-07-26 23:04:35 +0100)

----------------------------------------------------------------
documentation and test cleanups

  - improve clarity of user-mode docs
  - remove reference to TAP tarball
  - add new hypervisor test for aarch64 EL2
  - reduce combinatorial explosion of plugin tests
  - make docker-all-test-cross more friendly to non-x86 hosts
  - expose unittests to sysv.args for embedded help

----------------------------------------------------------------
Alex Bennée (14):
      docs/user: clarify user-mode expects the same OS
      docs/system: reword the TAP notes to remove tarball ref
      docs/user: clean up headings
      docs/user: slightly reword section on system calls
      docs/user: expand section on threading
      tests/functional: add hypervisor test for aarch64
      tests/tcg: skip libsyscall.so on softmmu tests
      tests/tcg: remove ADDITIONAL_PLUGINS_TESTS
      tests/tcg: don't include multiarch tests if not supported
      configure: expose PYTHON to test/tcg/config-host.mak
      tests/tcg: reduce the number of plugin tests combinations
      tests/docker: add --arch-only to qemu deps for all-test-cross
      tests/docker: handle host-arch selection for all-test-cross
      tests/functional: expose sys.argv to unittest.main

 docs/system/devices/net.rst                        | 16 +++--
 docs/user/index.rst                                |  5 +-
 docs/user/main.rst                                 | 60 +++++++++++-------
 configure                                          |  1 +
 .../dockerfiles/debian-all-test-cross.docker       | 34 ++++++-----
 tests/functional/meson.build                       |  1 +
 tests/functional/qemu_test/testcase.py             |  2 +-
 tests/functional/test_aarch64_kvm.py               | 71 ++++++++++++++++++++++
 tests/tcg/Makefile.target                          | 36 ++++++++---
 tests/tcg/multiarch/Makefile.target                |  8 ++-
 tests/tcg/multiarch/system/Makefile.softmmu-target | 16 +++--
 11 files changed, 192 insertions(+), 58 deletions(-)
 create mode 100755 tests/functional/test_aarch64_kvm.py

-- 
2.47.2


