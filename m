Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257F0C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4T-00068U-IT; Wed, 21 May 2025 18:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Q-00067a-IH
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4M-0005Y8-2w
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:54 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-231fc83a33aso45173235ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867065; x=1748471865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jjhvBQmc58bRfW1BmUaC+6dNwrbsuNXyv6FxaIjBx7E=;
 b=RPmoexCHTWiJgGpL95Zy0yPvAKPFdulMzK0mIVLHbbSGQm4OskAl84fzDYjU2n1F13
 ZuAj5qdSXYQxw1EVSDI8fruLBKeBxJLStGkPJAkSrjTDan0DQPdGfDaVQtZqGwFtt5re
 8wYyA1iPCiJuedhz4HRst2kt0t8boeLhoVowssy/HYv47J1SEkTu15vKRm0rFU2hFBhD
 hbiBiGdBVw8P4eVPMowQRxnuwYFFT2C4mjzYn4FDrFiC1tMCXWCc8YQ7K9xdVJB24zhj
 6J/y4y7CI/JpyH+xu/pcBQsqKQPQZhyq/SXXbft9Pg46c8LxwwlLKiCsOCWOHu/baSmH
 JpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867065; x=1748471865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjhvBQmc58bRfW1BmUaC+6dNwrbsuNXyv6FxaIjBx7E=;
 b=gIAzU188JkGX97w0vI3BqTziLAKRNBjbDGDD1gZ2Byv6+l9cgv1QEHzQiJ7vWqj2t+
 fOvoMPYEb+ZEZmvDlUvc4qOTRLUS04ETx4da9STwF4xCPRCtZ7kn7lx5RI0zCqUkt4nq
 MMGlFr/OdIbKV0wJzzUtvcAqGQ+ekVE9aD2s7/a2Y72UuuPhuCtIktGB3cx5Z2Cc/9iS
 oBbyP3pK0oqgI6tzEaD0n1OYOFc6S6SPn4ks6o0hAITfd4NTvTujwD/7cGvY5+uYoDJ9
 rXySJxQqRwkiLvrQUnl4xbfc3tAKP08TDwGo3ztclhC8YhNhJ7jUkhmOIMumaIejXrt/
 d/Pg==
X-Gm-Message-State: AOJu0YzmGeivpJgz2HQClpXbr7gT5zkwscuRbN2T032ZcBWrdEUzsQkg
 +Yqg762FR76CjJzumqvNDDGHW5pzJ1zogu3K+wOKEyd3f3+IR8E0jYd61RHmNlWcWt5Da0OOkRR
 0gBu+
X-Gm-Gg: ASbGncsS8+RcXBhEX///SF0ysWOnh13DANbb/BsGSzZV5mmFIUBlJ4afXq/mc6dlaTx
 QMifpda/IQoS/yBsk4Wx3s6iHEOUjjQnWS+3Av4Qy4OY3DSmdXTEJfAd2EsFcVdnK95WG99HRRy
 eSblOxhF783CDzsGzOGKjEtD1ZbV0VMxdQZUc5wzrS+y76vNr6u9XAxf5Yz/KnTUQl52wM+NHa3
 +rxo5QO34RXODPfZkqGyKr4H9EFMnYzJgT2xXGpILbrc2oY6SAV8Znb67yrrVBrZpidK8hm0KOK
 YCvGlhREiOUmx/eiXJQUJ2QLaApGf1sEN4uUYn224iPGP2SQBkiWyzuBYyodLA==
X-Google-Smtp-Source: AGHT+IEk6ZsYoI8i35UQ4KgUkxBEAVL7m0Qia61XjIay/ajvgl9bcFpnhGOwTwpPidBbN9lpi3qygA==
X-Received: by 2002:a17:902:ce87:b0:220:e924:99dd with SMTP id
 d9443c01a7336-231de3ace9emr320579305ad.34.1747867065113; 
 Wed, 21 May 2025 15:37:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 00/14] qapi: remove all TARGET_* conditionals from the
 schema
Date: Wed, 21 May 2025 15:37:26 -0700
Message-ID: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

This series exposes all qmp commands for any target unconditionally, allowing to
compile QAPI generated code without any TARGET conditionals.

Based on original RFC from Daniel P. Berrangé:
https://lore.kernel.org/qemu-devel/20250508135816.673087-1-berrange@redhat.com/

v3
--

- Change error message for rtc-reset-injection stub
- s/'*deprecated-props' : { 'type': ['str'] }/'*deprecated-props' : ['str'] }
- further cleanup in qapi/meson.build
- move qapi/machine-target.json deletion to s390x cpu commands commit
- cleanup qapi_outputs in qapi/meson.build
- All comment and commit description updates requested
- Rebase on top of master (conflict with s/SGX/Sgx/ case change)

v2
--

- rtc-reset-reinjection now returns an error if the command is not applicable
  for current target (Markus & Daniel)

v1
--

- remove file qapi/misc-target.json (Markus)
- remove qapi/*-target.json from MAINTAINERS (Markus)
- remove qapi_specific_outputs from qapi/meson.build (Markus)
- update comment in rtc-reset-reinjection stub (Markus)
- build QAPI generated code only once

Daniel P. Berrangé (8):
  qapi: expose rtc-reset-reinjection command unconditionally
  qapi: expand docs for SEV commands
  qapi: make SEV commands unconditionally available
  qapi: expose query-gic-capability command unconditionally
  qapi: make SGX commands unconditionally available
  qapi: make Xen event commands unconditionally available
  qapi: remove the misc-target.json file
  qapi: make s390x specific CPU commands unconditionally available

Philippe Mathieu-Daudé (1):
  qapi: Make CpuModelExpansionInfo::deprecated-props optional and
    generic

Pierrick Bouvier (5):
  qapi: remove qapi_specific_outputs from meson.build
  qapi: make all generated files common
  qapi: use imperative style in documentation
  qapi/misc-i386: s/field will be set/field is set/
  qapi/misc-i386: move errors to their own documentation section

 MAINTAINERS                               |   1 -
 qapi/audio.json                           |   2 +-
 qapi/char.json                            |   4 +-
 qapi/cryptodev.json                       |   2 +-
 qapi/machine-s390x.json                   | 121 +++++
 qapi/machine-target.json                  | 523 ----------------------
 qapi/machine.json                         | 367 ++++++++++++++-
 qapi/migration.json                       |   8 +-
 qapi/misc-arm.json                        |  49 ++
 qapi/{misc-target.json => misc-i386.json} | 165 +++----
 qapi/qapi-schema.json                     |   5 +-
 qapi/ui.json                              |   8 +-
 include/hw/s390x/cpu-topology.h           |   2 +-
 hw/i386/kvm/xen-stubs.c                   |  13 -
 hw/i386/kvm/xen_evtchn.c                  |   2 +-
 hw/i386/monitor.c                         |   2 +-
 hw/i386/sgx-stub.c                        |   2 +-
 hw/i386/sgx.c                             |   2 +-
 hw/s390x/cpu-topology.c                   |   4 +-
 hw/s390x/s390-skeys.c                     |   1 -
 stubs/monitor-arm-gic.c                   |  12 +
 stubs/monitor-cpu-s390x-kvm.c             |  22 +
 stubs/monitor-cpu-s390x.c                 |  23 +
 stubs/monitor-cpu.c                       |  21 +
 stubs/monitor-i386-rtc.c                  |  12 +
 stubs/monitor-i386-sev.c                  |  36 ++
 stubs/monitor-i386-sgx.c                  |  17 +
 stubs/monitor-i386-xen.c                  |  16 +
 target/arm/arm-qmp-cmds.c                 |   4 +-
 target/i386/cpu-system.c                  |   2 +-
 target/i386/cpu.c                         |   2 +-
 target/i386/monitor.c                     |   1 -
 target/i386/sev-system-stub.c             |  32 --
 target/i386/sev.c                         |   2 +-
 target/loongarch/loongarch-qmp-cmds.c     |   2 +-
 target/mips/system/mips-qmp-cmds.c        |  12 +-
 target/ppc/ppc-qmp-cmds.c                 |  12 +-
 target/riscv/riscv-qmp-cmds.c             |   2 +-
 target/s390x/cpu_models_system.c          |   2 +-
 tests/qtest/qmp-cmd-test.c                |   1 +
 qapi/meson.build                          |  33 +-
 stubs/meson.build                         |   8 +
 42 files changed, 833 insertions(+), 724 deletions(-)
 create mode 100644 qapi/machine-s390x.json
 delete mode 100644 qapi/machine-target.json
 create mode 100644 qapi/misc-arm.json
 rename qapi/{misc-target.json => misc-i386.json} (75%)
 create mode 100644 stubs/monitor-arm-gic.c
 create mode 100644 stubs/monitor-cpu-s390x-kvm.c
 create mode 100644 stubs/monitor-cpu-s390x.c
 create mode 100644 stubs/monitor-cpu.c
 create mode 100644 stubs/monitor-i386-rtc.c
 create mode 100644 stubs/monitor-i386-sev.c
 create mode 100644 stubs/monitor-i386-sgx.c
 create mode 100644 stubs/monitor-i386-xen.c

-- 
2.47.2


