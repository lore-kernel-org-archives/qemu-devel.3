Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CC4C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgmf-0006nT-DI; Mon, 24 Jun 2024 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmc-0006lX-Op
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sLgmW-0007eI-Kb
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:18:46 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cc1c00ba6so4960247a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719224318; x=1719829118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G7VsWS18FlsKfZhjTe+PQ6m9VKRsw6bNfLxEfQofpJk=;
 b=ZROxOTuvm/n7slF3a0pQs5voJ91kTnLcexmy4MUY6A+YDWri7K6eyTfXOXJfOclKkq
 yBoV29nGA4905KhXwXqzjla2023Cleq3VmcrB8ZvqW+iEab0G0THa8dgmSczhrGWjNMN
 uT7oCRcWSTgZNu4lA7itaRGmSawWji2WOzycUrtVWgh722mIL5l/5LMIJKZc7cL03cPu
 cSYS+7/VaEOVRm2a1kFwtjLDePQQkS6kqfKKREKxnjIqTEV/BxXn+6CCebnc1FdAG8J4
 RB+Ph+ce+0A0gLG1cKlme3PZZ0Yv1sIy+5MBmLKAxQUGpFh9cp4C7h1jusyoq5AW7ICG
 aKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224318; x=1719829118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G7VsWS18FlsKfZhjTe+PQ6m9VKRsw6bNfLxEfQofpJk=;
 b=PsmVpgRADvSCjJPaVl0Pbua4k2I8M7pAxYzGMkbeRj+biQIgk6nLKpBMMijEfs4U0K
 4+Fy/yGGiRSSJhFrvQ4GR2T86a3R9N35xlLrvapZGidWF/7I680aLbbrZZAFedoHeBeV
 TQNXYS48lK1b0mQqAo09uA4RfVwtr53dsWgK8hG0bQSl41GqM1mZ6gsRy2XS1xmUuM/W
 i6LTRVPB0hYxDwXv7iAy3AXn1x2wr9CqUj3uYKjAfbrVOsDldqFhd024VxAzq95zPilj
 9j6/GKj05gFZeDiZUrUVjFxvMLK6tlUZkm7gw68nEu8deytjOkVHNpkiXeILfabQktbz
 QqrA==
X-Gm-Message-State: AOJu0Yyixugld4q4aXyPPdoggc4pBqjXG347caqlKjwM5xQ3Td/AgEEJ
 uFUXoSQcJOdpDUAEdHGxIrRbwk3GjO9CHNc0oyCMkxGoBWTRuwBUa/MhrRoXNChQNjNMaw/UPh7
 K
X-Google-Smtp-Source: AGHT+IEDyD9EB0uNc/TqRVmhWGgrpafDUh8yoQ75iM19UcEpcobkyA+b/4QNQSLNTh2j9Q4FO8nSkQ==
X-Received: by 2002:a50:9555:0:b0:57d:4cbc:cb59 with SMTP id
 4fb4d7f45d1cf-57d4cbccbf9mr2547353a12.25.1719224317686; 
 Mon, 24 Jun 2024 03:18:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d347a0710sm4104536a12.24.2024.06.24.03.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:18:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C9735F789;
 Mon, 24 Jun 2024 11:18:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/12] maintainer updates (plugins, gdbstub)
Date: Mon, 24 Jun 2024 11:18:24 +0100
Message-Id: <20240624101836.193761-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:

  Merge tag 'pull-target-arm-20240622' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-06-22 09:56:49 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-june24-240624-1

for you to fetch changes up to fce3d48038e9f38e3e342a59f76c7f9f9b043ed2:

  accel/tcg: Avoid unnecessary call overhead from qemu_plugin_vcpu_mem_cb (2024-06-24 10:15:23 +0100)

----------------------------------------------------------------
maintainer updates (plugins, gdbstub):

  - add missing include guard comment to gdbstub.h
  - move gdbstub enums into separate header
  - move qtest_[get|set]_virtual_clock functions
  - allow plugins to manipulate the virtual clock
  - introduce an Instructions Per Second plugin
  - fix inject_mem_cb rw mask tests
  - allow qemu_plugin_vcpu_mem_cb to shortcut when no memory cbs

----------------------------------------------------------------
Akihiko Odaki (1):
      plugins: Ensure register handles are not NULL

Alex Bennée (7):
      include/exec: add missing include guard comment
      gdbstub: move enums into separate header
      sysemu: add set_virtual_time to accel ops
      qtest: use cpu interface in qtest_clock_warp
      sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
      plugins: add time control API
      plugins: add migration blocker

Max Chou (1):
      accel/tcg: Avoid unnecessary call overhead from qemu_plugin_vcpu_mem_cb

Pierrick Bouvier (3):
      qtest: move qtest_{get, set}_virtual_clock to accel/qtest/qtest.c
      contrib/plugins: add Instructions Per Second (IPS) example for cost modeling
      plugins: fix inject_mem_cb rw masking

 include/exec/gdbstub.h                             |  11 +-
 include/gdbstub/enums.h                            |  21 +++
 include/qemu/qemu-plugin.h                         |  27 ++++
 include/qemu/timer.h                               |  15 ++
 include/sysemu/accel-ops.h                         |  18 ++-
 include/sysemu/cpu-timers.h                        |   3 +-
 include/sysemu/qtest.h                             |   2 -
 accel/hvf/hvf-accel-ops.c                          |   2 +-
 accel/kvm/kvm-all.c                                |   2 +-
 accel/qtest/qtest.c                                |  13 ++
 accel/tcg/plugin-gen.c                             |   4 +-
 accel/tcg/tcg-accel-ops.c                          |   2 +-
 contrib/plugins/ips.c                              | 164 +++++++++++++++++++++
 gdbstub/user.c                                     |   1 +
 monitor/hmp-cmds.c                                 |   3 +-
 plugins/api.c                                      |  49 +++++-
 plugins/core.c                                     |   4 +-
 ...us-get-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                      |  11 ++
 system/qtest.c                                     |  37 +----
 system/vl.c                                        |   1 +
 target/arm/hvf/hvf.c                               |   2 +-
 target/arm/hyp_gdbstub.c                           |   2 +-
 target/arm/kvm.c                                   |   2 +-
 target/i386/kvm/kvm.c                              |   2 +-
 target/ppc/kvm.c                                   |   2 +-
 target/s390x/kvm/kvm.c                             |   2 +-
 util/qemu-timer.c                                  |  26 ++++
 accel/tcg/ldst_common.c.inc                        |   8 +-
 contrib/plugins/Makefile                           |   1 +
 plugins/qemu-plugins.symbols                       |   2 +
 stubs/meson.build                                  |   2 +-
 32 files changed, 379 insertions(+), 67 deletions(-)
 create mode 100644 include/gdbstub/enums.h
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


