Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11D8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcMz-0007xb-GW; Thu, 15 May 2025 13:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMx-0007nw-Ds
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMv-00022V-5b
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso1602543b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330059; x=1747934859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L+vmlTrBRup78fIWUVJIeSxgSNP+xG82SoPynOifr50=;
 b=YudphHrIkIhpE5yuw2acVxBqgHXZmxIUqHcq55HzNojUjjF5EIL03DEEDdfODFT3F6
 dfdzJn1lR90MYQhsFEArQC3SPbozjRvo8oIWKHSOuj7SkgikxuNIhHOk+62452f9rzQ9
 +Pjxbagr8WMdxQ21pu3OspGrStxXx6IwywJbo+YIhAhWePPva+OObmRSEe9/ufI1Psro
 ZRfddHQqbWofnex4BE1YVOVVG9LF+QrdqnrMTwuRAG2N7nS0cYb85JP6ExdfQ52hxnAX
 vHupqQ4Rv/6AbOgMKZk2yHj1b4+tiLbYFTUHsStsoOvtC2XmsOqRFxg+mJmmCpDYCZ/e
 cs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330059; x=1747934859;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+vmlTrBRup78fIWUVJIeSxgSNP+xG82SoPynOifr50=;
 b=LCwuUp6NLKOJQxmcr1DcKYMgF/HlOY5EJhnlgLxw6BEIylGCHGte0WEsIgmcz3ERix
 UDrzJYbHwafc2EN++03rx9tsInp1eL2DY3tMI/QePVsK5XrOgHqHo2iwR2+PV0wC+3WX
 EFKNfMYny6rvx9Zq+hlzuntBjblNRqn5nl6X+6jvYxXYeV8oK91FVM6Y+B4WVT+6tNmW
 K1lQAOOMPpPis1QNsngkutC/QFy5Q82dOtUIJGMssT94xHNB/kdeyH2YaJO85WYMlkvf
 lcMiPmGrQ1Uus7JsfGb6eC9uzJlYGr6ToNpsfGJmXl62RbgqIYt+pkTWq+9eRkZj73CC
 GDgA==
X-Gm-Message-State: AOJu0Yw2jI9FaeVV/yWTOyyeXEdsOEzEtQ76YV9/m4USITtMfIXplzPf
 Zlee6z0beV7hqQStPT3vr6M06NZnXmUw9xi9L1Sy45bxBSeQLoAJPPJclm6VWCTSPAZfHc5hqu8
 aAAG4
X-Gm-Gg: ASbGncuegv7X7Z48zz5guIzEXbFQOcEn8fM6fSRs3ePGUF0MD8InP/ORQlx3txGq/pN
 WolHbTmruIMDe2k6P5hZe7epaO8fIIwtijq5ukdzBXdVNKNaGsQHfLGxWyAJ/rFEhp0zGN3Oxhm
 tjQXw+j1KIXo3ggIxJWdvCt3IEJ9T6ZqwXazevKPl6HGo45bXO/XgqvBgsGi+MpN9JJGNBtAJg+
 pWwIMh+46lIp3EZyFAi5xpKDjSNQSmnJzTc9CHMR/l5NfGHI0Z/lBg8/R+dShHW+j44olrOpwUN
 7fT5+mtPsQF6BzIVXKw67Z5Q3OjVursWeH1Ug9DhZCk7SiF8erY=
X-Google-Smtp-Source: AGHT+IGGxeJaVkdn+gx2pgnTFB16l1m4ecoj0XIOylI7zGSzLeHv8SMY0M5T5F2/rAhvIjx1+IA0wg==
X-Received: by 2002:a05:6a00:985:b0:73e:2dca:f91b with SMTP id
 d2e1a72fcca58-742a989fbf4mr291000b3a.18.1747330059408; 
 Thu, 15 May 2025 10:27:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 00/12] qapi: remove all TARGET_* conditionals from the
 schema
Date: Thu, 15 May 2025 10:27:20 -0700
Message-ID: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

Daniel P. Berrangé (9):
  qapi: expose rtc-reset-reinjection command unconditionally
  qapi: expand docs for SEV commands
  qapi: make SEV commands unconditionally available
  qapi: expose query-gic-capability command unconditionally
  qapi: make SGX commands unconditionally available
  qapi: make Xen event commands unconditionally available
  qapi: remove the misc-target.json file
  qapi: make most CPU commands unconditionally available
  qapi: make s390x specific CPU commands unconditionally available

Philippe Mathieu-Daudé (1):
  qapi: Make CpuModelExpansionInfo::deprecated-props optional and
    generic

Pierrick Bouvier (2):
  qapi: remove qapi_specific_outputs from meson.build
  qapi: make all generated files common

 MAINTAINERS                               |   1 -
 qapi/machine-s390x.json                   | 121 +++++
 qapi/machine-target.json                  | 523 ----------------------
 qapi/machine.json                         | 363 +++++++++++++++
 qapi/misc-arm.json                        |  49 ++
 qapi/{misc-target.json => misc-i386.json} | 154 +++----
 qapi/qapi-schema.json                     |   5 +-
 include/hw/s390x/cpu-topology.h           |   2 +-
 hw/i386/kvm/xen-stubs.c                   |  13 -
 hw/i386/kvm/xen_evtchn.c                  |   2 +-
 hw/i386/monitor.c                         |   2 +-
 hw/i386/sgx-stub.c                        |  13 -
 hw/i386/sgx.c                             |   2 +-
 hw/s390x/cpu-topology.c                   |   4 +-
 hw/s390x/s390-skeys.c                     |   1 -
 stubs/monitor-arm-gic.c                   |  12 +
 stubs/monitor-cpu-s390x-kvm.c             |  22 +
 stubs/monitor-cpu-s390x.c                 |  23 +
 stubs/monitor-cpu.c                       |  21 +
 stubs/monitor-i386-rtc.c                  |  11 +
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
 qapi/meson.build                          |  18 +-
 stubs/meson.build                         |   8 +
 37 files changed, 808 insertions(+), 705 deletions(-)
 create mode 100644 qapi/machine-s390x.json
 delete mode 100644 qapi/machine-target.json
 create mode 100644 qapi/misc-arm.json
 rename qapi/{misc-target.json => misc-i386.json} (76%)
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


