Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C555FC6169
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spA4a-0005kv-9g; Fri, 13 Sep 2024 13:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4X-0005dQ-NN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1spA4U-0005sR-3n
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:27:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-378e5d4a80eso6521f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726248418; x=1726853218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2dzQLuxRk3ZcH5KfpARLW/rp/sE29yXJC5EjCti8cqQ=;
 b=u6gm3ZYIxy4dHr4C1lnR0wxTc3ZhEFL2cuPQ23X6zdKe2luruzavfqRTyVWWhKJnDQ
 L9qarFrXtXsPmJc/jtRohQC3QPxWlNHIesAn7HbVvTBJB0ParObg1AazB2eiRDWpARrF
 mk3u/VRA+TyNXHCPYLIHYVPdpbAB+lpYmEInRidNe5IbpG8RT+psn61iqDJcO8D0tKH8
 2mr8HE+TF6wH2HcuxF433P7qmUaaHvV7MQsDeTzOgyjNpO4O1Ownf9mPTvApAJBiF74Q
 KO1m5eI3DRwSeX7psMZ47Ua0W8I4YQuT2kawxH9EsH92NobzCuA2eHJjBKgp0MncBS8R
 tp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726248418; x=1726853218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2dzQLuxRk3ZcH5KfpARLW/rp/sE29yXJC5EjCti8cqQ=;
 b=YkVobgmeQEslfrA7u/nzdCPl2eWA6pDTnGHQoGcRBEBgzfIL8QoBMDEMoi88qY5z9W
 CQgCve2mL+BoYzzni9KVDtZIWNXG75Akc5a/kB5JddGCqeSQhvgH9o3lcfyQeoobQQOK
 gBVsUwkzCFI3MG1bfy9FX5MGEh5y3RprLAsDf+0510owNiSz2sWLqZ5DB+4LJlbN4oBA
 NsDRe+e2q7ttSn0xKPF6AfM7R84Wd8ZZPmMaZ95rZeWeOy2N00MQInSXPxPoTq9ifuld
 ep6lYdvDbelpJahWdZeDYG0wV3S5vsVgTa27SOHKM77zkwoLlLfsvhjrgane5hxymH3O
 FdBw==
X-Gm-Message-State: AOJu0YychMNCA7X31EgeStQkxyQFBXWq0FF/91xR8V7LyTH0LhfVYZWZ
 MNH1zNxYGDg7kRvKxF70Mbqb8pM6X5zJpqeHKE0u0/UpsHUuNZniZvmTy8Zh84k=
X-Google-Smtp-Source: AGHT+IFNpeCw+lnp98HNmuulI7lXqNTV2xa/zQ3zLQ8R4fx08bAc2ZKWawb6/XNOeIeSfTJPZTvLUg==
X-Received: by 2002:adf:f30b:0:b0:371:8dcc:7f9e with SMTP id
 ffacd0b85a97d-378c2cd3e05mr4315254f8f.2.1726248417582; 
 Fri, 13 Sep 2024 10:26:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd468fesm7875310a12.39.2024.09.13.10.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 10:26:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1ABF75F897;
 Fri, 13 Sep 2024 18:26:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-s390x@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 00/17] tcg plugins pre-PR (deprecations, mem apis,
 contrib plugins)
Date: Fri, 13 Sep 2024 18:26:38 +0100
Message-Id: <20240913172655.173873-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

I think all these are ready to go having been mostly reviewed in previous
series. The following still need review:

  util/timer: avoid deadlock when shutting down
  tests/tcg: add a system test to check memory instrumentation
  tests/tcg: ensure s390x-softmmu output redirected
  tests/tcg/multiarch: add test for plugin memory access (0 acks, 1 sobs, 1 tbs)

Alex.

Akihiko Odaki (1):
  contrib/plugins: Add a plugin to generate basic block vectors

Alex Bennée (8):
  deprecation: don't enable TCG plugins by default on 32 bit hosts
  deprecation: don't enable TCG plugins by default with TCI
  contrib/plugins: control flow plugin
  tests/tcg: clean up output of memory system test
  tests/tcg: only read/write 64 bit words on 64 bit systems
  tests/tcg: ensure s390x-softmmu output redirected
  tests/tcg: add a system test to check memory instrumentation
  util/timer: avoid deadlock when shutting down

Pierrick Bouvier (6):
  plugins: save value during memory accesses
  plugins: extend API to get latest memory value accessed
  tests/tcg: add mechanism to run specific tests with plugins
  tests/tcg: allow to check output of plugins
  tests/tcg/plugins/mem: add option to print memory accesses
  tests/tcg/multiarch: add test for plugin memory access

Rowan Hart (2):
  plugins: add plugin API to read guest memory
  plugins: add option to dump write argument to syscall plugin

 docs/about/deprecated.rst                     |  19 +
 docs/about/emulation.rst                      |  44 +-
 configure                                     |  32 +-
 accel/tcg/atomic_template.h                   |  66 ++-
 include/hw/core/cpu.h                         |   4 +
 include/qemu/plugin.h                         |   4 +
 include/qemu/qemu-plugin.h                    |  64 ++-
 contrib/plugins/bbv.c                         | 158 +++++++
 contrib/plugins/cflow.c                       | 384 ++++++++++++++++++
 plugins/api.c                                 |  53 +++
 plugins/core.c                                |   6 +
 tcg/tcg-op-ldst.c                             |  66 ++-
 tests/tcg/multiarch/system/memory.c           | 123 ++++--
 tests/tcg/multiarch/test-plugin-mem-access.c  | 177 ++++++++
 tests/tcg/plugins/mem.c                       | 248 ++++++++++-
 tests/tcg/plugins/syscall.c                   | 117 ++++++
 util/qemu-timer.c                             |  14 +-
 accel/tcg/atomic_common.c.inc                 |  13 +-
 accel/tcg/ldst_common.c.inc                   |  38 +-
 contrib/plugins/Makefile                      |   2 +
 plugins/qemu-plugins.symbols                  |   2 +
 tests/tcg/Makefile.target                     |  12 +-
 tests/tcg/alpha/Makefile.softmmu-target       |   2 +-
 tests/tcg/alpha/Makefile.target               |   3 +
 tests/tcg/multiarch/Makefile.target           |  11 +
 tests/tcg/multiarch/check-plugin-output.sh    |  36 ++
 .../multiarch/system/Makefile.softmmu-target  |   6 +
 .../system/validate-memory-counts.py          | 129 ++++++
 tests/tcg/ppc64/Makefile.target               |   5 +
 tests/tcg/s390x/Makefile.softmmu-target       |   7 +-
 30 files changed, 1762 insertions(+), 83 deletions(-)
 create mode 100644 contrib/plugins/bbv.c
 create mode 100644 contrib/plugins/cflow.c
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh
 create mode 100755 tests/tcg/multiarch/system/validate-memory-counts.py

-- 
2.39.2


