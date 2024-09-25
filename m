Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8CBCCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVYp-0001mD-1F; Wed, 25 Sep 2024 13:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYO-0000KW-Le
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:55 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1stVYK-0000bS-4W
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:11:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-378f90ad32dso31612f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727284305; x=1727889105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YKiMcMVIgaI1u5EOrQ7wt/HfEOtyQ4ZcHqLFruvQEk8=;
 b=qgf8hvTyZaRG1U8A0vyqHLwZ5tG11Q4AgfZ4CB89J8o8N36qsW2P+678Su8vRvxdFr
 xOmsZF2ecKibrpKKZkiIt9oNKM4zZgbsOW4Gsl+JCPWvUZgJ0kk1RT1s25ITNliAHXXT
 i17GdsiqMk8jHcg2Ctb2mDI+H7z+VfQoIUmInBpGYf3+wMJ25CYd9TShiOelsc0k52jD
 /57viSVYljb/RQMVBb00oGIQg2TLmyFwtbyhGI7W80WDXLAvxRhsEkQ0FZUXFazbn/oF
 kV104mLOWrhqB7GeqMIRBQBjarsguexRkO6YxIjvwXWHUBAm6/9paXsA6EL5BmFs1cip
 2E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727284305; x=1727889105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YKiMcMVIgaI1u5EOrQ7wt/HfEOtyQ4ZcHqLFruvQEk8=;
 b=fE/gV6THGdCbpITSzQZ4LQVT7xaY6V6bS3MVhJq8ZWJ1tgh76zNYlUAlIJ9eHWDZOl
 0HuUC3lKIF1wm3/mCIsVLmTVnYIEiD8AehkDRxnje7ZLLxUjn4408pdbhXMqMEvvsckh
 Q/m6Kacx5M5AIv+pqcyCgbV14j08tSDwlQ6hIgHZyMOI6p2IEZt7np6951TSf5SIbcqE
 RsiBQAtPraejGPPeJ63TgEuY2alyxuHWHoNYGhvnFSsf/2xOrBQF6nqVQELaiwofNjAE
 eMbhTCEBPC9JLLTITuLMW4Rma4bhk9OL92tU0nSSMN1no9SVTot1D7vZGCA1jl1CSkMq
 iGlA==
X-Gm-Message-State: AOJu0YzfGPnWCz8DtU/j0nR+vkfiCskPR52vrtWu9SX0auQX1GC2+nlz
 0BVH37voejtXjQeaJ2TuEdeDdgkcA0lygc5lHDSpnmRF4CCUmQxH9Par+p+p/+4=
X-Google-Smtp-Source: AGHT+IGlSP0Jlk8NPTfdGfqLOuwAKaNghDViO1/OMw6Z7pw6Tee/O07cZuWwhv/1xXRFpiFAXO7XGg==
X-Received: by 2002:adf:fac5:0:b0:374:b685:672 with SMTP id
 ffacd0b85a97d-37cc248b5b4mr2184119f8f.26.1727284304867; 
 Wed, 25 Sep 2024 10:11:44 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc2c226esm4455006f8f.36.2024.09.25.10.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:11:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 542CF5F8E4;
 Wed, 25 Sep 2024 18:11:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, kvm@vger.kernel.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 00/10] maintainer updates (testing, gdbstub)
Date: Wed, 25 Sep 2024 18:11:30 +0100
Message-Id: <20240925171140.1307033-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Welcome to the first post KVM forum series. We have:

  - fix from Ilya for microblaze atomics
  - Pierrick's tsan updates
  - I've added my testing and gdbstub trees to MAINTAINERS
  - enabled a very basic aarch64_be-linux-user test
  - fixed the missing gdb XML fails that cause aarch64_be-linux-user to assert
  - finally I've made the mips64el cross compiler bookworm and allow_fail

Alex Bennée (6):
  testing: bump mips64el cross to bookworm and allow to fail
  tests/docker: add NOFETCH env variable for testing
  MAINTAINERS: mention my testing/next tree
  MAINTAINERS: mention my gdbstub/next tree
  config/targets: update aarch64_be-linux-user gdb XML list
  tests/tcg: enable basic testing for aarch64_be-linux-user

Ilya Leoshkevich (1):
  tests/docker: Fix microblaze atomics

Pierrick Bouvier (3):
  meson: hide tsan related warnings
  target/i386: fix build warning (gcc-12 -fsanitize=thread)
  docs/devel: update tsan build documentation

 MAINTAINERS                                   |  2 ++
 docs/devel/testing/main.rst                   | 26 +++++++++++---
 configure                                     |  5 +++
 configs/targets/aarch64_be-linux-user.mak     |  2 +-
 meson.build                                   | 10 +++++-
 target/i386/kvm/kvm.c                         |  4 +--
 tests/tcg/aarch64_be/hello.c                  | 35 +++++++++++++++++++
 .gitlab-ci.d/container-cross.yml              |  3 ++
 tests/docker/Makefile.include                 |  5 +--
 .../build-toolchain.sh                        |  8 +++++
 .../dockerfiles/debian-mips64el-cross.docker  | 10 +++---
 .../dockerfiles/debian-toolchain.docker       |  7 ++++
 tests/lcitool/refresh                         |  2 +-
 tests/tcg/Makefile.target                     |  7 +++-
 tests/tcg/aarch64_be/Makefile.target          | 17 +++++++++
 15 files changed, 125 insertions(+), 18 deletions(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

-- 
2.39.5


