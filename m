Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC61C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQ0N-0000kD-IQ; Wed, 12 Jun 2024 11:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0L-0000YE-EX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:17 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHQ0G-0004JL-2y
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:35:17 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so9291896a12.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718206509; x=1718811309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+qqLWSg7tRM2gGCJAJtzdTrDQlMzenU32kd2gKR8s2c=;
 b=IFwzhMeM/EOdHQ4AdvylGtteoGFnk18R5eflF8NJLRrDgEfj3vtQQkDR/V9ZrudKZv
 TxAf+cjf9ByNXgHLN3MHMW/fgUlbmXtrJjxjPPFEWvNmOHQIh4Z5Wercs0RhBPXbmjdo
 Um8JF3W+l2RFGnw4WoD7ZPUdKWV/Fwa95VR77+YFSRe73ZvZaYRQuqsga2Cr5eyQ59yu
 k8a7z9DXmvCyTGqlhqpcVDQlx8eHMKclnKN8/pb52DDg+vGmgWT1n5bKSOx+/k2ud4IL
 Y4szDw0qhQUAWu7jgJMr6IOm4DGHrx+W41Mq+1BFlAa015dVsiqqjZXdIRmEUJlHckeA
 aT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718206509; x=1718811309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qqLWSg7tRM2gGCJAJtzdTrDQlMzenU32kd2gKR8s2c=;
 b=XXE26QNSjYc/8QZD7N7AsBwAMvpb3tuJzUQZ1xm1q9eoFTtolVcTH9TnEYHVYVRhAK
 5sns+QccNAckW8qSESZg4S+2HmU4ui1Hr6KMRxwkBcUPOMNZykSuns2ZBwKPuHfF9PwI
 sOYoZoxtfm7RSt5gdW7ZtitaLC1Px+uaBi0HjaFrOQwWmlLAl1ZkHykYrWlJepaLJmrR
 bskaWlpwqqy4cNgOuzBTnzSzrBOJo2ZcJuhcz68NaqNKLj/Rve6ZG3wQqCMO7MsPoBEY
 RqRBLWxk8M8zwQ937q5qWeSQyLMOlAh4BUfpNJ3OXI80IpjmG/EI3MG5HMFKDt/w9MHB
 zXfA==
X-Gm-Message-State: AOJu0YwBgr5o9ruQ2nEStHcrA44a8YvvRiFY/vUkXsphjHPq7p3G8hM9
 qOnSbDRQ0MWKLUc/LUnlZf3fHwPQOf1VkdTwaMCD+dMBt0+2ywhaEpdMImQwpQI=
X-Google-Smtp-Source: AGHT+IERL/2jvHutLftjXOxlHqfrdjG3j3FdZVVa7m1ZXHMLA/R2foTn5KoIJagMPECFajcOPxgGQg==
X-Received: by 2002:a50:ab18:0:b0:57c:5764:15f1 with SMTP id
 4fb4d7f45d1cf-57caa9ba475mr1540370a12.29.1718206508979; 
 Wed, 12 Jun 2024 08:35:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c855b959bsm5045462a12.38.2024.06.12.08.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 08:35:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2563B5F893;
 Wed, 12 Jun 2024 16:35:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 0/9] maintainer updates (gdbstub, plugins, time control)
Date: Wed, 12 Jun 2024 16:34:59 +0100
Message-Id: <20240612153508.1532940-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This is the current state of my maintainer trees. The gdbstub patches
are just minor clean-ups. The main feature this brings in is the
ability for plugins to control time. This has been discussed before
but represents the first time plugins can "control" the execution of
the core. The idea would be to eventually deprecate the icount auto
modes in favour of a plugin and just use icount for deterministic
execution and record/replay.

Alex.

Akihiko Odaki (1):
  plugins: Ensure register handles are not NULL

Alex Bennée (6):
  include/exec: add missing include guard comment
  gdbstub: move enums into separate header
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API

Pierrick Bouvier (2):
  qtest: move qtest_{get, set}_virtual_clock to accel/qtest/qtest.c
  contrib/plugins: add ips plugin example for cost modeling

 include/exec/gdbstub.h                        |  11 +-
 include/gdbstub/enums.h                       |  21 +++
 include/qemu/qemu-plugin.h                    |  25 +++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   2 -
 accel/hvf/hvf-accel-ops.c                     |   2 +-
 accel/kvm/kvm-all.c                           |   2 +-
 accel/qtest/qtest.c                           |  13 ++
 accel/tcg/tcg-accel-ops.c                     |   2 +-
 contrib/plugins/ips.c                         | 164 ++++++++++++++++++
 gdbstub/user.c                                |   1 +
 monitor/hmp-cmds.c                            |   3 +-
 plugins/api.c                                 |  39 ++++-
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                 |  11 ++
 system/qtest.c                                |  37 +---
 system/vl.c                                   |   1 +
 target/arm/hvf/hvf.c                          |   2 +-
 target/arm/hyp_gdbstub.c                      |   2 +-
 target/arm/kvm.c                              |   2 +-
 target/i386/kvm/kvm.c                         |   2 +-
 target/ppc/kvm.c                              |   2 +-
 target/s390x/kvm/kvm.c                        |   2 +-
 util/qemu-timer.c                             |  26 +++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 29 files changed, 357 insertions(+), 61 deletions(-)
 create mode 100644 include/gdbstub/enums.h
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


