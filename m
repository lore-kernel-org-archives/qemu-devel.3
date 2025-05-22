Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2292C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBEp-0000uu-AP; Thu, 22 May 2025 15:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEm-0000uB-Ki
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEk-0006RZ-8j
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso210975b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940748; x=1748545548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qvoSiU2oEaTcNlVi5fKaSmduLQsgBHGwXgaoEWcRctE=;
 b=QTDPrgCdgAID4FJT+9Cv1WDWqNQ5sn242rBxEQHpGDjS+V+povb2GMBiBpSY2x23UF
 oHD+Nsj/2gkMyeYq57pwgOkkHjDyWG90KO1LgUx3WNBtyHBGoHR2ALmfUYJy26Sdpuwi
 YesMMP8ofgkjv2yqTqCZ+kDg4CfWWIPRfRsCq+yy7w+RR19YjvEgnxu0rRerL+hyVG+F
 w0+wE4KjbZmhA4pOUGIZl2pGrSWLSRY9z0eG7Fym5zK/bkyAqOQPFivTAK/Ti+6JZx1s
 vpy3mhVXQhKpDf9b2Vs77UYCq9SFFMbtpLzz6rocSMDON9QQyKg916eKFD5CiABE1MJM
 ia/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940748; x=1748545548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvoSiU2oEaTcNlVi5fKaSmduLQsgBHGwXgaoEWcRctE=;
 b=usGaMWId2XogXAcObOx0qgKObOnfUHnoAFws8tiEkFO3xw8qDnNqF1sFlrmivE+ZVr
 4V6cW/ibC0Tc+mZqw1Of4D+gid8CY+JybrSkTnVfYzTvEDDc40BC3jZJedLHCVGMJS9B
 Zsur6Bi+uHTrCb5xW/Pu0MSrFhK/kt0f7xhvdIWDllM6+7oMRmPqGzWVtA5yrXVmAwnG
 v/MXAxCWvGvY3aOPALXKiez4Zg6f90x3wab0IK5J7EW/BggslG6DrsoUMgMtejIjPLHD
 +j2EuE1OaawQykusp0mnoXA4Us22BU2Qkoc6QoRTA2w6YGUdlbz+u/fiKGLIJnM/5+gN
 EH9Q==
X-Gm-Message-State: AOJu0YwfLNjrvIMZY3ZcPkU6RDWq51n3dHybstaKmBcOnj7tV0qvoJ/y
 qbw4P+w+1gRZMgBQs7fLHIKOcv6IwDO1DxxmxHK/5EaxLEUxG8eZ51hlNouqk48lMOdFf9aN2YU
 TXVtb
X-Gm-Gg: ASbGncvEHs2L5EgBzeu1ZwnyWR+W0o0Wi5NsNV2Y66Z5q1rG0Fc7vi/gAWumtBblIbw
 z+sgghvPaEPduZCRhKk17KClClOSS+sEphaivAjly5n7S2/UlFiJfweTM36Y2oJJwBkKVE3vA8s
 zXdErnNNKOLKW1S6K0aJHPr98t8+iXrDM8papjLs1xJygPFwhH2x9vurn6m4arsZgZ64BiJTnCn
 Ed382U9xkZKFJaQMemxmpzSBWbeGsCL1sheGLGdcOwq0SM72hgI2gtTyrSxojCF7SDva4OjLPEE
 B7ImMlWhclmAdE58WXjJa1Ygj1p//1UpyRtaGcdp4/NmlqccRdg=
X-Google-Smtp-Source: AGHT+IH5xcalb99jPDZsnN/cQ/mE0zhaMwnL54H++DZ9jghAG6xocw3tj+FH/VPEnWkyV7fUcRIM/w==
X-Received: by 2002:a05:6a20:e614:b0:218:11d6:b66 with SMTP id
 adf61e73a8af0-21877a392aemr896624637.5.1747940748359; 
 Thu, 22 May 2025 12:05:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 00/15] qapi: remove all TARGET_* conditionals from the
 schema
Date: Thu, 22 May 2025 12:05:27 -0700
Message-ID: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

v4
--

- Update commit description to say that doc was updated accordingly (Markus)
- Fixed a rebase error in v3 where two patches were wrongly merged together

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

Pierrick Bouvier (6):
  qapi: make most CPU commands unconditionally available
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


