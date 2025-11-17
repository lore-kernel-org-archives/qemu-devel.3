Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68691CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxpU-0008Fb-TG; Mon, 17 Nov 2025 06:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpS-0008Dm-PJ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:30 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpP-0005fO-J5
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:30 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso2160527f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380526; x=1763985326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2mFk16eA35+b526666aLfCHadkorYyQHQl7927DfZuw=;
 b=OpOZxKcD7itK7jvH8+sudkqgJ3wm2+DWVMSboMCKCqKIhWiuVsfzd2kIfrdQUOhLjv
 nO7/t2D4/jUKiOTa/S1FqTlLc1C8Y1TQgbVbYwmyHKRArsrB/jSK/uyS8udv5A9k9rHQ
 ne4TeW6d2If4NuM6kZGB+TBIgQM+VHdYfIGjwGOkfpfosmevfCu9y7R+c11fC0BVfwDo
 0IfW/+cL5iiULu/lMgimzPpkfkKisbndFJRLI3FhC9U8dMmFdYWmwSKyoS46rBBovuzH
 YwKeC4no5+KHmGA3rWxe5KxzEYT6IuTUZ/Gl7YJ9xKq+yZgyNfKbj1c/7EmczjCu6hpW
 voSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380526; x=1763985326;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mFk16eA35+b526666aLfCHadkorYyQHQl7927DfZuw=;
 b=lRR0JxqaczLL3cyQvjCgxMUIO+5dae1yDoY4/wACw1IwdqPkHPNzXvpg6X/lc3IGbU
 cyM1V1GrZunj0Dpawv2jnoi2/as70lBEh6ueJ+p/IUlo7BGZQtmH9Ds8z1rtMvfSTI11
 tojT1wTveXOEm1W5UzEoud122UgsGBw7rp9bbF2J/pRvPvTY81aNvzppcxmlKJRiXXTi
 UFAYhKfyrqPqWeCFxKgklkrUHkG/BAFGBLYmM1ggj8NnqRkSZgkmuokLqrex7mMBuRjX
 qSs3SpQE9MnP/1rUfASpJ//pwPj6TnO9IWNvTjaxtYku9AgMP7XbegotmkO/iRDzl2Cv
 OIYg==
X-Gm-Message-State: AOJu0YzwMFiwL5KTlHWvCP7ZNCVIFfRYkGqIKmbZ1OH9Zzkuy10surLB
 urlW8V4v2W64GRQIQyPAyE4DOVSi9APGsWqQFojYEXQLXz2BkiNyrX+zcck38JHoZPY=
X-Gm-Gg: ASbGncs5vTRHEdCc2S3UYfOahDUPo5B8OrGGrr9jMB1fCYXApSfZ8H8ovLQVX+fAxXO
 34SIbM9/ZBOkovxRP5zNaUziqoc5XMkmJKhUiuWbMQSJBQAWTF4fMzZ9XqnjPoyxjtDoK5W4OoE
 CkbIJbiB3WkXo2OwpXY93hUunI6jZdJvzBqQxL05m+fd/emUy8Hz8oL57uz8SG4xVgm6L81RiV1
 4oqhQ71+ETn0bD8Ko0RKkVGDS3bTiXRViunM8ZMNozf4WJPf23V9tgQxqdUA02Esh5nKERvWyN+
 a6L2DHjZl8B/vy1FSN+jAn4BVkiJE0PndzeBzuAdaiH/NcERGMuaYTRWUwnoRbfz89eB29jtulf
 9gQZ1+oueemkigf9E3XzPxIKtXDB5pzmibUIRYivjlco/V2RtXO/PZQ/QnmjDGFaz2vTKIybNfx
 4lIRZXYyAfecA=
X-Google-Smtp-Source: AGHT+IFIIAGYoLB+c7BjC3IOMhukgp1LH0I6j5kpRdg9Nij3UQNnI9u015V3d3MQDZt8JrcX61ijDQ==
X-Received: by 2002:a05:6000:2504:b0:429:b8f9:a887 with SMTP id
 ffacd0b85a97d-42b5935e272mr10291156f8f.6.1763380525904; 
 Mon, 17 Nov 2025 03:55:25 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b62dsm26004290f8f.24.2025.11.17.03.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0FCF05F860;
 Mon, 17 Nov 2025 11:55:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org
Subject: [PATCH v3 00/18] testing/next cleanups (docker,
 functional) - pre-PR-final-1
Date: Mon, 17 Nov 2025 11:55:05 +0000
Message-ID: <20251117115523.3993105-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

We have a new ppc64le custom runner box courtesy of OSUOSL. The
ansible scripts where updated in the last pull request and now we can
turn on the runner. The initial runs showed some issues so for v2 I've
kept the tests basic.

On the subject runners I've done some more template clean-ups to
improve maintainability and also tried to stop the custom runners
appearing when not prompted for. I've iterated on that for v2.

Finally fileserver.linaro.org is being shutdown at the end of the year
so I have migrated the tests to a new server. Those changes have a Cc:
qemu-stable@nongnu.org tag as they will need back-porting.

For v3 its mostly GitLab clean-up for the rules as suggested by danpb.
I did fix-up the download URL for the KVM test which I only picked up
because running a staging build in my context tripped up on it. I now
have a fancy new alias in .git/config:

  [alias]
          push-ci-fake-staging = push -o ci.variable=QEMU_CI_UPSTREAM=stsquad -f gitlab HEAD:staging

Which will run as if you are pushing to staging although it will fail
if you don't have access to the custom runners.

Only one still needs review:

  gitlab: make custom runners need QEMU_CI to run

I left existing r-b's in the other patches as the changes where only
tweaks.

Alex.

Alex Bennée (17):
  tests/docker: drop --link from COPYs in emsdk docker
  libvirt-ci: bump libvirt-ci to latest version
  tests/lcitool: update ENV stazas outputted by refresh
  tests/docker: add coreutils to the package list
  tests: move test_xen assets to share.linaro.org
  tests: move test_virt assets to share.linaro.org
  tests: move test_netdev_ethtool to share.linaro.org
  tests: move test_kvm_xen to share.linaro.org
  tests: move test_kvm to share.linaro.org
  tests: move test_virt_gpu to share.linaro.org
  gitlab: add initial ppc64le custom-runner test
  gitlab: use template for ubuntu-24.04-s390x jobs
  gitlab: simplify the ubuntu-24.04-aarch64 rules
  gitlab: suppress custom runners being triggered by schedule
  gitlab: make custom runners need QEMU_CI to run
  gitlab: make the schedule rules a bit more general
  gitlab: add a weekly container building job

Pierrick Bouvier (1):
  docs/about/emulation: update assets for uftrace plugin documentation

 docs/about/emulation.rst                      |  20 +-
 docs/devel/testing/ci-jobs.rst.inc            |   6 +
 .gitlab-ci.d/base.yml                         |   4 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars           |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars             |   2 +-
 .gitlab-ci.d/container-template.yml           |   5 +
 .gitlab-ci.d/containers.yml                   |  39 ++++
 .gitlab-ci.d/custom-runners.yml               |   1 +
 .../custom-runners/debian-13-ppc64le.yml      |  45 +++++
 .../custom-runners/ubuntu-24.04-aarch64.yml   |  49 ++---
 .../custom-runners/ubuntu-24.04-s390x.yml     | 189 +++++++-----------
 .../ci/setup/debian/debian-13-ppc64le.yaml    |   1 +
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   1 +
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   1 +
 tests/docker/Makefile.include                 |  11 +
 tests/docker/dockerfiles/alpine.docker        |  11 +-
 tests/docker/dockerfiles/centos9.docker       |  11 +-
 .../dockerfiles/debian-amd64-cross.docker     |  21 +-
 .../dockerfiles/debian-arm64-cross.docker     |  21 +-
 .../dockerfiles/debian-armhf-cross.docker     |  21 +-
 .../dockerfiles/debian-i686-cross.docker      |  21 +-
 .../dockerfiles/debian-mips64el-cross.docker  |  21 +-
 .../dockerfiles/debian-mipsel-cross.docker    |  21 +-
 .../dockerfiles/debian-ppc64el-cross.docker   |  21 +-
 .../dockerfiles/debian-riscv64-cross.docker   |  24 +--
 .../dockerfiles/debian-s390x-cross.docker     |  21 +-
 tests/docker/dockerfiles/debian.docker        |  13 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     |   8 +-
 .../dockerfiles/fedora-rust-nightly.docker    |  11 +-
 .../dockerfiles/fedora-win64-cross.docker     |  19 +-
 tests/docker/dockerfiles/fedora.docker        |  11 +-
 tests/docker/dockerfiles/opensuse-leap.docker |  11 +-
 tests/docker/dockerfiles/ubuntu2204.docker    |  11 +-
 tests/functional/aarch64/test_kvm.py          |   4 +-
 tests/functional/aarch64/test_virt.py         |   5 +-
 tests/functional/aarch64/test_virt_gpu.py     |   8 +-
 tests/functional/aarch64/test_xen.py          |  12 +-
 tests/functional/x86_64/test_kvm_xen.py       |  17 +-
 .../functional/x86_64/test_netdev_ethtool.py  |  14 +-
 tests/lcitool/libvirt-ci                      |   2 +-
 tests/lcitool/projects/qemu.yml               |   1 +
 tests/lcitool/refresh                         |   6 +-
 tests/vm/generated/freebsd.json               |   1 +
 43 files changed, 393 insertions(+), 351 deletions(-)
 create mode 100644 .gitlab-ci.d/custom-runners/debian-13-ppc64le.yml

-- 
2.47.3


