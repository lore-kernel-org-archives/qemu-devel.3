Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D151098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c84-0007Xk-VJ; Fri, 20 Mar 2026 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c81-0007Vy-3D
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:13 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c7z-0005V8-5N
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:12 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9793fa5371so275413166b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021869; x=1774626669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5A29bmhPdP4a5ill44kTkdJ53yf5zB+hEJbcpDnFIqI=;
 b=WJ7mn4tM+lWw61xGyWiZk7DXD/4gOET/4CY1qLzJYIhi4l0rXdaXgYC63FYwtgtJbA
 eusT/ReKx7urL0sduT7b27fdRZYgNcewH8Nf6e8q4BDMukqkF03lTbwv0RcbLcGAQqEN
 TOE4LSKv342iwN4ypC8Z3QEZFM84USCO5rIJ4y6d8KOW5jzRCFFxiJngHse13KNXG2za
 J+pKKjGX+YK1ClXpGy6n2l92bQrtN62smd01h2F3nw/0qAkyLsq9O9eg4nkwAnpmApM1
 1hn4abqptSEhWM+9OqYj3MYRn7fJ5R/VjabSSgQIJ9S30bH5PVZnFiaYGcowkW8qeN8w
 9TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021869; x=1774626669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5A29bmhPdP4a5ill44kTkdJ53yf5zB+hEJbcpDnFIqI=;
 b=MgjCzTKWEj7NoszIDXa1/1vOisDHc1GvW5wrTgf5mMdr8FrvLUaPWcbnSBs3TmKIJs
 Ex9bm4nIOCjJNR2ovQAYnLc0twJdAu5STIXHc+QGEvV/v77o1ofIzkzIjOSQShyX12+L
 3nNbTMi+unC00M2/OOr6DMOiL5RLdTu3lMeEcor2qwxKDX0HthJtlFAI00hzQHbZlIrB
 quPN4kO/CmkX4HdDuJi+3aULBKeafaQnUAJDu2ifVpIx5v79NLh2EUrY2EgqxU+GXvVd
 Iqraoftn8uJ/OwlNdyGB5u+Y4et0F7DB7wmULpFl/C891gzASjm2Hc5DARHqhPWlxyxq
 HAuw==
X-Gm-Message-State: AOJu0YxIX3wf5ebN3/LzV+QqMtvULVLS4X99JcGIWurcMNfDHCZqlCVC
 UYzlQrvttQfjdCWddaWHbFRZVlfKalBv04hL5xbNiec6F1yO5htvLImse0YMvojcM5k=
X-Gm-Gg: ATEYQzzKXv67KQHn0I9o4KuAXJpn5zTz53kbd60M/Yr28Lxu+bKETzopyiMKeoLnDtB
 6yELMJDtK1xg2VHIYJr6LVDBpQphG3vaD92a/qvLyc8VjutF/sINUArrrHv2XEEkWnrD1aq6oEx
 3ZpYoMUi1lNQnl1huv7+C8VluioLH4W8ToTUrD+D0t5mC4mDGXvEni4QSQL9GVyRpoOjceoSWlu
 srDWs82pZcwe4Ida8f3EcuaxmNa1zwh8M+lYHSw6OLXSvGQQNWt4fBADxrNraz3bQnSW1TckOh0
 BTfO5ivRyzUUYHc8x4vBhgjU5U5vSBvS69T1G5FdKmI3NshWFNu7V8tZUxxjF9eFkL6i1o++d8U
 yIXL46KOxC0ZsGYO7/Gi/EBMuGHJIluVBKdSkSB4MDCyqTZe3qx2/Mx60u5NzRq0zD30r1dybTn
 jght5lZwiDCEoJuYCdL1GVXuE=
X-Received: by 2002:a17:907:c903:b0:b96:e593:fd1e with SMTP id
 a640c23a62f3a-b982ee996a0mr177005566b.0.1774021869154; 
 Fri, 20 Mar 2026 08:51:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f42c8fsm167210366b.9.2026.03.20.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6B525F82D;
 Fri, 20 Mar 2026 15:51:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 0/8] testing/next: gdb-multiarch, check-tcg, docker,
 vbsa tests (pre-PR)
Date: Fri, 20 Mar 2026 15:50:59 +0000
Message-ID: <20260320155107.2143191-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

This is the current status of my testing tree. The gdb-multiarch and
filtering changes should be pretty uncontroversial. I've also picked
up some stray testing patches that where hanging around on the list.

I'll roll the PR on Monday.

v3
  - gdb-multiarch tests should work now Phillipe's stuff is merged
  - grabbed Thomas' ncat and opensuse patches

v2

  - mostly tweaks to the vbsa test (see inline comments on commit)
  - dropped the zip and send_key patches

Alex.

Alex Bennée (3):
  tests/tcg: allow filtering of TCG tests
  tests/functional: allow tests to define decompression target
  tests/functional: add VBSA linux tests

Matheus Tavares Bernardino (1):
  tests/tcg/multiarch/linux-test: use portable alternative for dirent64

Thomas Huth (4):
  tests/lcitool: Remove python3-sqlite3 from the list of needed packages
  tests/lcitool: Update openSUSE to version 16
  tests/docker: Update the opensuse-leap container file to version 16
  tests: Replace ncat with socat in migration test and drop ncat from
    containers

 configure                                     |   1 -
 tests/tcg/multiarch/linux/linux-test.c        |   5 +-
 .../ci/setup/debian/debian-13-ppc64le.yaml    |   1 -
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   1 -
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   1 -
 tests/Makefile.include                        |   8 +-
 tests/docker/dockerfiles/alpine.docker        |   1 -
 tests/docker/dockerfiles/centos9.docker       |   1 -
 .../dockerfiles/debian-amd64-cross.docker     |   1 -
 .../dockerfiles/debian-arm64-cross.docker     |   1 -
 .../dockerfiles/debian-armhf-cross.docker     |   1 -
 .../dockerfiles/debian-i686-cross.docker      |   1 -
 .../dockerfiles/debian-mips64el-cross.docker  |   1 -
 .../dockerfiles/debian-mipsel-cross.docker    |   1 -
 .../dockerfiles/debian-ppc64el-cross.docker   |   1 -
 .../dockerfiles/debian-riscv64-cross.docker   |   1 -
 .../dockerfiles/debian-s390x-cross.docker     |   1 -
 tests/docker/dockerfiles/debian.docker        |   1 -
 .../dockerfiles/fedora-rust-nightly.docker    |   1 -
 .../dockerfiles/fedora-win64-cross.docker     |   1 -
 tests/docker/dockerfiles/fedora.docker        |   1 -
 tests/docker/dockerfiles/opensuse-leap.docker |  35 +++--
 tests/docker/dockerfiles/ubuntu2204.docker    |   1 -
 tests/functional/aarch64/test_virt_vbsa.py    | 122 ++++++++++++++++--
 tests/functional/migration.py                 |   4 +-
 tests/functional/qemu_test/testcase.py        |   9 +-
 tests/lcitool/mappings.yml                    |  58 ---------
 tests/lcitool/projects/qemu.yml               |   2 -
 tests/lcitool/refresh                         |   2 +-
 tests/tcg/Makefile.target                     |  12 +-
 30 files changed, 156 insertions(+), 121 deletions(-)

-- 
2.47.3


