Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5C4C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJcR-0005rR-0O; Thu, 20 Jun 2024 11:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcP-0005pK-0C
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:33 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJcM-0007xc-Lb
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:22:32 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52bc27cfb14so1406977e87.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896949; x=1719501749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GwfYtHiFW+MpVchR1W1uIXCNJBxRS/LzmnaKh+rSEqQ=;
 b=sZY5ACzp7bOCBp+FhGT38ZooWcvsKrkeg53nucQYio6y45RNPhVUQbUc3QiY7V0JeA
 BiulyxsG5uJCKCL81/KpRe3ZicBoBOeaWu5DVU/1mjhoFFbpwn46PMQJdEl1lPo9AHhy
 DYUA2CeAnP6vIG0MyB106yWDJ577DLqbMCJG0vJiMTBmR5Oxcl9sXqMlNqsbOxIJfBnA
 Q7EGVnbq058xpX5LspyHnDp7+Oxgp19VM/tNhnZPFnj/EBIP9zzSKhxVQT5lvqMhjnA1
 kUAfkEBK0rXD6UVKqAo+luT2hZFM0HkLcauootK+LmYKDfdMs/i9rLJzVPSEF5rVjVRG
 qkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896949; x=1719501749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwfYtHiFW+MpVchR1W1uIXCNJBxRS/LzmnaKh+rSEqQ=;
 b=JlbmCo7ZgVGfl/Jyv/f1qKvLaBLWcd/P87vTYBSPnGvts4/H+l1LcFvkSusGF46CrA
 bbUJPZYvTRMv26SVAixHPokdpp7VQ6nmKRLB4o+cFgEIiTVLgSvE5kY6zPi7aC5/JGIf
 uIPA9s7diSX9gq0Q9356IbQSA798zWZQXes9N1OvNGJDhK4M1rZP5m5BCWSOiMTycwJO
 NRrwT3B16TlinJ8NIPUJ/kZorKwGbbybesJyw9LdRxMP7AvtGSHOfP7j1NysGMMtpMCC
 a+Ju50zmoD58vkM5uJ3DHl+hn4AIIKsRViA3DA74dETVBkoZ2BMCq1bT8zILO9UQhrP6
 OZcg==
X-Gm-Message-State: AOJu0YxGKrr5b1QmUwfmVoFphe+QQ6V7VMLB1LmAD7izLvxYiz+zP6Eu
 NtSQwWUCQ/ULIc6RvOENd7z5wAbGylC948/tDy+94/uvzTXmSFwlNs794ZSKZEo=
X-Google-Smtp-Source: AGHT+IHZreEf/CgFmxklps2fJVXNdKgoEAsSXSn/BfkNWtTHxKRx0rK3p7tmSxgo5+bmw/ROdFHpnQ==
X-Received: by 2002:a05:6512:3123:b0:52b:bdbd:2c54 with SMTP id
 2adb3069b0e04-52ccaa369acmr4081172e87.34.1718896946911; 
 Thu, 20 Jun 2024 08:22:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f600cde92sm708227466b.205.2024.06.20.08.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:22:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F14C35F7B1;
 Thu, 20 Jun 2024 16:22:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jamie Iles <quic_jiles@quicinc.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Nicholas Piggin <npiggin@gmail.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/12] maintainer updates pre-PR (gdbstub, plugins,
 time control)
Date: Thu, 20 Jun 2024 16:22:08 +0100
Message-Id: <20240620152220.2192768-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

v2
  - merged in Pierrick's fixes
  - added migration blocker
  - added Max's plugin tweak

I'll send the PR on Monday if nothing comes up. The following still need review:

  plugins: add migration blocker

Alex.

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
  accel/tcg: Avoid unnecessary call overhead from
    qemu_plugin_vcpu_mem_cb

Pierrick Bouvier (3):
  qtest: move qtest_{get, set}_virtual_clock to accel/qtest/qtest.c
  contrib/plugins: add Instructions Per Second (IPS) example for cost
    modeling
  plugins: fix inject_mem_cb rw masking

 include/exec/gdbstub.h                        |  11 +-
 include/gdbstub/enums.h                       |  21 +++
 include/qemu/qemu-plugin.h                    |  27 +++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   2 -
 accel/hvf/hvf-accel-ops.c                     |   2 +-
 accel/kvm/kvm-all.c                           |   2 +-
 accel/qtest/qtest.c                           |  13 ++
 accel/tcg/plugin-gen.c                        |   4 +-
 accel/tcg/tcg-accel-ops.c                     |   2 +-
 contrib/plugins/ips.c                         | 164 ++++++++++++++++++
 gdbstub/user.c                                |   1 +
 monitor/hmp-cmds.c                            |   3 +-
 plugins/api.c                                 |  47 ++++-
 plugins/core.c                                |   4 +-
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
 accel/tcg/ldst_common.c.inc                   |   8 +-
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 32 files changed, 377 insertions(+), 67 deletions(-)
 create mode 100644 include/gdbstub/enums.h
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


