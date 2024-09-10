Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5F0EDE9AF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pb-0004mf-Iq; Tue, 10 Sep 2024 13:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pX-0004iI-Mw
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:08 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pV-0004Z2-49
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:07 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso1178191a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989943; x=1726594743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8nyoNX09OJlC7JXmPdXxdbGRDmYKJxyq3fTF8xRLDcI=;
 b=lpnXoWgJODMqls6QzMPsOa+mgXF/AQHUNc6M0HwU4bPRjIU/ruVFes+AkSgfBX1Jju
 WreWsaJuPvBWXN/x+MG9A1BxKa0YWW2T4ORpeZ8CaVZhHkAKvCDrHgmJ4ijcYVRsCUlh
 05OuvaUSdhGx37rBZBO3RhY72R9kGGM2yuVHarbjqTzSAWPtEsjCDcJ9a7TPCu2YlhlM
 cvSknY2/fOniSzIgdvLucyh4f2o0OvyBYiSCzACVmYdDax3ouu6TbnpEg5yT5UsR4vfe
 AK3MCoXCfYaN3L8KyZAKykWGn5GiUBOelWVW+o5y/vtdC2Mvjrpsg5ecEofxVHuTG2hM
 V+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989943; x=1726594743;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8nyoNX09OJlC7JXmPdXxdbGRDmYKJxyq3fTF8xRLDcI=;
 b=ssK3wyewxmw2QXNAQTnWT7FNHB5SqN93Iwcu+2jTDlfn0ugVRUA0UJtlPN6Q9vRL4W
 adxl5NeHKKE17Pi/lFL97WL3Fv7HJwOiFf10UsAC/BWh34R6WQwXabzMLODDmlY19Isz
 /Gb4ihB7lFeXOgHWRXUe90L4aYIX0xs1j4eq1n0V2KuIBJLYeERU/9WsCYaQDhGYf05P
 S5o7+t/acVVvQ027yIXi0bZFelYZUyxZh2HtgZ2ERJ1aQXWWCZEm65XQjly33/c/Chkc
 QSArglsVjD6uaNUNObWpNarutEP1lXDdo2ur0cqfc/p+LwENpvsaUTBSgenLx8YOez98
 DZNg==
X-Gm-Message-State: AOJu0YyJ0/FYnHyvmkxnjTSs6jj3N27uWYhYjZ50oL4lAzMXifPgj747
 uwNMfqgSs30VQ3ivorruHVypyr1Olz1vYHpMrkCVo4j9KLC20WFWEcJdm6s5fo4=
X-Google-Smtp-Source: AGHT+IHcRR7g18SAdvyeNS2tzmV0LOwOnMDkXx6ACl8XpI7SrSbbAncG/JmPSiQdqyQknboPsNYFUg==
X-Received: by 2002:a05:6402:2692:b0:5c2:53a1:c209 with SMTP id
 4fb4d7f45d1cf-5c40bc503d6mr168008a12.25.1725989942170; 
 Tue, 10 Sep 2024 10:39:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd46819sm4453096a12.31.2024.09.10.10.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A3215F762;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 00/10] Maintainer updates (testing, gdbstub) pre-PR
Date: Tue, 10 Sep 2024 18:38:50 +0100
Message-Id: <20240910173900.4154726-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

Testing

I've updated a number of the docker containers to deal with breakages
in the crossdev environments as bullseye moves to LTS. I've dropped
the armel environment which doesn't really add much to the armhf cross
build we have that works. i686 and mipsel cross containers are bumped
up to bookworm. Currently mips64el is still broken.

gdbstub

This brings in Gustavo's patches to support MTE for system mode
expanding on the previously implemented user mode support.

plugins

I've dropped the TCG plugins from the series so as not to make the
pull request too large. I'll roll a new series once I've sent the PR
for this.

Changes

  - moved mips64le TCG tests to use the debian-all-test-cross
  - fixed some --disable-tcg failures for the MTE patches

The following still need review:

  tests/docker: use debian-all-test-cross for mips64el tests

Alex Bennée (5):
  tests/docker: remove debian-armel-cross
  tests/docker: update debian i686 and mipsel images to bookworm
  tests/docker: use debian-all-test-cross for mips64el tests
  docs/devel: fix duplicate line
  scripts/ci: update the gitlab-runner playbook

Gustavo Romero (5):
  gdbstub: Use specific MMU index when probing MTE addresses
  gdbstub: Add support for MTE in system mode
  tests/guest-debug: Support passing arguments to the GDB test script
  tests/tcg/aarch64: Improve linker script organization
  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 docs/devel/testing/main.rst                   |   6 -
 configure                                     |   7 +-
 target/arm/gdbstub64.c                        |  23 ++-
 .gitlab-ci.d/container-cross.yml              |   6 -
 .gitlab-ci.d/crossbuilds.yml                  |   7 -
 scripts/ci/setup/gitlab-runner.yml            |  39 +++-
 .../dockerfiles/debian-armel-cross.docker     | 179 ------------------
 .../dockerfiles/debian-i686-cross.docker      |  10 +-
 .../dockerfiles/debian-mipsel-cross.docker    |  10 +-
 tests/guest-debug/run-test.py                 |   6 +
 tests/guest-debug/test_gdbstub.py             |   5 +
 tests/lcitool/refresh                         |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target     |  49 ++++-
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py         |  71 ++++---
 tests/tcg/aarch64/system/boot.S               |  11 ++
 tests/tcg/aarch64/system/kernel.ld            |  33 ++--
 tests/tcg/aarch64/system/mte.S                | 109 +++++++++++
 18 files changed, 310 insertions(+), 274 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-armel-cross.docker
 create mode 100644 tests/tcg/aarch64/system/mte.S

-- 
2.39.2


