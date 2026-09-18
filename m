Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7E0C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZW1-0005kd-U2; Fri, 18 Sep 2026 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW0-0005kN-Fx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:36 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZVy-0007of-82
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:36 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so4135015e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741472; x=1790346272; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SQgaqLMdvm77ztqnKynGDa9N6b/YWwGIqrUrj0OIOIk=;
 b=GqAl1oNu/P2na6yYg+ogVdw4DKY4vVuDS01Dl/gKMP5ho2/okGnOTbWM39oYYKMP9B
 bfHrWwGNNXQ4LojB0hKIncnVwcpJ1iqfqIXbJP6+XLhtUxtXHWIIPN0edGRerozVVxKK
 2zn5ahSHjRhc+hXVLXBOv3bLJ5EmJfXz7txvY4qXe/AJdiep+xMpr+6nLaHzSmnHvVOC
 Tzio7L9XSpXhd8aaJip9Mo5xw8QXkXQwJhAdf/7sp+6XshpvrZtxwtctdlM1WpryLylL
 /NNdrscFj/vmwY6gINiE36o3CROGO5Z0o55Fqy0RF735tYqjZFGY0goOKt977ca2bFzZ
 ncTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741472; x=1790346272;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SQgaqLMdvm77ztqnKynGDa9N6b/YWwGIqrUrj0OIOIk=;
 b=1nUrew4DIKoywy0uN5ZqHh2U5snIdEJi9GuALMNjlUJ+59w/A6T04ugD09EWN/BZZt
 NfX4P1f46Fn2PlBhL4xHTOxgxI3pPhgI8u5fpQJN+O13kfcS4nPxedt6Bp2AXrgcrIFX
 Yyk8PjqF3h66m2Hvf4ii5Dq+L0ZSsT3FfUX3Pn9iGg/eKwfjCwKNEFquAjEn9Nc1Xmc1
 7DOXJfWyEz2K9c6tzpe9UDwlvzIaVkguTk8cJFdTifEIei8XGYNg2egqYqT+Z+IwqPyS
 pipub68CAIop5iMpSGxXgh3JbK/N6rYC3R+ctdusREXO8Bg/erCkyuWXJSj9TuVGwfmQ
 b5dQ==
X-Gm-Message-State: AFuF++ltflyi11N+oNSj/pv0cTpBEsUNvRIq9ZXKcZ7o6N60j804sEuM
 Qpb0J7EWvwFgUsoln2w5xRtiWNJPy5izT5tnTUbJ6vxVXydQ4bg35G0FxlGt6Wypid+LpqIRITV
 /kfYW
X-Gm-Gg: AYBFou2vkBVDb5FEyU8+3Oxjt7KhVPNWNEdpd8PMAG8ojITTzuNbnfD3y89mN+HEph4
 leI70UfpPb7rKGYebzQfwV9RDCNFxrE3zE2bxBWLy8wgqnBSlLREssXYeG6eOgKAbb/zU6w87MX
 1d4CxVRbKWH80bVfWBJwzTtLuQPJxzuJZwkUE/PBP1hrpcry3sAM2G4y2yQ+Di5fiRBoaBj5QAw
 EjKWIz81VnSWr6M5CfLMc9V/YzaVQ48UcLUJw5X+zl7r7ljnbaF+ySyjnu/405cZxB8e6nEad8I
 LbC+FJDGJ7rui/oGQVePQPnnbYswCEnaJbofsUKWWHybDYK5Ooa3zeLzRHWctOclRSA9wVGAS2l
 DQoMB+jRdenCUW5eBb9NR3zjwz2lGrngLJPZHTxJwv9p8eGubKVI3oe5ZDqAXcDcgB7L1I/jJuP
 naE6gzA/0V7MRk1E+eBwMBSZRS4xlHaYEuGQFRhXXNh5IBS1m9N7EOdT1zS/WoqycgrRQMxKD2
X-Received: by 2002:a05:600c:3107:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49fc5669346mr34912435e9.6.1789741472214; 
 Fri, 18 Sep 2026 07:24:32 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cfd1dasm60815465e9.9.2026.09.18.07.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C7275F8B4;
 Fri, 18 Sep 2026 15:24:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/17] check-tcg and docker cleanups
Date: Fri, 18 Sep 2026 15:24:11 +0100
Message-ID: <20260918142429.336497-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
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

The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:

  Merge tag 'pull-ufs-20260918' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-09-17 15:18:09 -1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-more-check-tcg-docker-meson-180926-1

for you to fetch changes up to 2e92f9cfdf050d987b9ab551088a7678bebfb613:

  gitlab: drop check-tcg from clang-system job (2026-09-18 14:03:58 +0100)

----------------------------------------------------------------
check-tcg and docker cleanups

  - regenerate meson-buildoptions.sh to match master
  - revert cross_cc logic back into configure
  - ensure configure also honours --containers
  - simplify compiler probing to support just vdso and rom building
  - remove libc requirements from s390x system test
  - ensure meson and Makefile.include triggered containers are the same
  - allow the container registry to be configured
  - remove some unused cruft from docker.py
  - fix some variable expansion typos
  - update the gitlab @user mappings
  - make meson built docker images use :console
  - fix build container volume mapping for out of tree builds
  - drop check-tcg from gitlab jobs without compilers

----------------------------------------------------------------
Alex Bennée (13):
      scripts: update meson-buildoptions.sh
      Revert "configure: remove cross_cc and gdb detection logic"
      configure: ensure it also honours container configuration
      configure: re-purpose the tcg test compiler configs for vdso building
      tests/tcg: prefix meson built docker tags with qemu/
      tests/tcg: use --add-current-user when building containers
      tests/tcg: don't define tests when missing compilers
      tests/docker: add container registry to configure and use
      tests/docker: remove used _read_qemu_dockerfile
      tests/docker: add specific command to parser
      gitlab: update the @user id mapping file
      tests/tcg: add console property to docker image custom target
      gitlab: drop check-tcg from clang-system job

Anders Roxell (1):
      tests/docker: fix ccache directory variable expansion

Daniel P. Berrangé (1):
      configure: correctly honour --disable-containers

Ilya Leoshkevich (2):
      tests/tcg/s390x: Provide the libc bits needed by the system tests
      tests/tcg: Fix building outside of the source tree

 configure                               | 465 +++++++++++++++++++++++++++++++-
 tests/tcg/s390x/libc/stdio.h            |  11 +
 tests/tcg/s390x/libc/string.h           |  12 +
 .gitlab-ci.d/buildtest.yml              |   2 +-
 .gitlab-map-auto                        |   8 +-
 linux-user/aarch64/Makefile.vdso        |   2 +-
 linux-user/arm/Makefile.vdso            |   2 +-
 linux-user/hppa/Makefile.vdso           |   2 +-
 linux-user/i386/Makefile.vdso           |   2 +-
 linux-user/loongarch64/Makefile.vdso    |   2 +-
 linux-user/ppc/Makefile.vdso            |   2 +-
 linux-user/riscv/Makefile.vdso          |   2 +-
 linux-user/s390x/Makefile.vdso          |   2 +-
 linux-user/sh4/Makefile.vdso            |   2 +-
 linux-user/x86_64/Makefile.vdso         |   2 +-
 meson_options.txt                       |   3 +
 scripts/coverity-scan/run-coverity-scan |   2 +-
 scripts/gitlab-map-update               |   2 +-
 scripts/meson-buildoptions.py           |   3 +-
 scripts/meson-buildoptions.sh           |  58 +++-
 tests/docker/Makefile.include           |   6 +-
 tests/docker/docker.py                  |  28 +-
 tests/tcg/meson.build                   |  30 ++-
 tests/tcg/s390x/system/meson.build      |   2 +
 24 files changed, 599 insertions(+), 53 deletions(-)
 create mode 100644 tests/tcg/s390x/libc/stdio.h
 create mode 100644 tests/tcg/s390x/libc/string.h

-- 
2.47.3


