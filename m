Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F23CC54754
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj1-0001O3-AB; Wed, 14 May 2025 19:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiy-0001GJ-7P
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:20 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLiw-00031j-9P
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:19 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-af51596da56so213443a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266076; x=1747870876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hV+Eqa8t8C/H2nvJsqD+sk8+D76UncNSLAFm8m6dk08=;
 b=K5HDoJlSwIbV/BfhN/HJi+2QyX1QGAVVjL4es3t/LZUszgA4rw7JTWLOE8TNt9mjPJ
 gy+ujpbmqrj6Sb5O+ord1iradwGoLO7C/kN1XeaR+GjAaL5XS5N0F6OTgXD3yOTFT1Dm
 IM1gMZaaxxi+zkK9l8F9JWaQLfbCXjBBn681l07M4b7sft/TFzZafdJceHntb2Q+THET
 KjO5nLKOyzcepTC5n6ExEXaJH/zHpW3Fjz3ckbPC+MDEhLOqDuXqHSBt3oEsKBleASN8
 sV/MRmXFTzUMm/y/5Y9xLH5Y6rKTgrIlWPGRt01jXPcsi4i26hAFECEizrlABndbk1Cw
 VRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266076; x=1747870876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hV+Eqa8t8C/H2nvJsqD+sk8+D76UncNSLAFm8m6dk08=;
 b=B6tILBizDZZ7nWJFYGmknA1RenuMvaZ61dfhLbg+Q0AUy7uZI/dNwupg7raBAVLnUP
 R7AqftnAcv86J7w8mMCoQ7JmIH0xtFMwYNHhXXBHfj5x10TtjoaJtyBbmnlHfB6qVmZ6
 JMH9HtXi7qOIa7LLgXKCt6szTzD/g+g2L3YQo2l3JgnwCc97Xf7clXjO6X21ATF7MsFk
 alUmIG70u6QBeGabXHoTBmOvi/yiFQVPlhNdHCCNfuVz5uV6N+vxUe6Qc7tx6o1xSyIj
 xdKwIUSASeVUYup6KfA/0AObEl+GAmU5AwyCigsatcYYkiF4J378wybbSeQ5PxMhbAmF
 p9ZA==
X-Gm-Message-State: AOJu0Yw7OMzb+/aa76H7eGjbEFhvCuTsi23m03OkYH3KVjTSXd7rJhHu
 y2k1uos/FHuabzz3KdDRJEdBejbDKLkZIGkpopbC05yI5AcmRf9Xz2oV44fbFxjbh5/kJHKeu/T
 1VDU=
X-Gm-Gg: ASbGncs0MVyetf+5ZMZpZeYNIAZUr5KeGCGUez3l9hbNAm7EN6zCtWxQFefokXf0ZK2
 Aykc0QnylzA2N1VbRTHOUykIUD5UOLGABaBaxKpYDpJ6H+8jRXm6zlY3Kujq3EO1+7IFowKTp8V
 hHfGE7uWD7081xy0PL70m2yPpQ1skJ4YnVuHVov5Ri7OW4YUNqT7kowbG0ucdwcnSzd/83dHSNG
 t9BbVp3VYr6DAOLXM3bHfM2FjjfTlnQBB1O+m4RiAVpSLXxFhbmkSr3o95r/2sO9xaZlrjw6hZW
 jitUshtR3w9YLpVG6KbubXpeURsIvq5ubXU3BJZWuNDYonVqL/w=
X-Google-Smtp-Source: AGHT+IHU077U2jb+Dcxb5a1hTqxFUeAbSryEvAMGxLcf3pI46W7bxV9UCd6UIrXM8dvcfQYA/0u7mA==
X-Received: by 2002:a17:903:2349:b0:21f:4649:fd49 with SMTP id
 d9443c01a7336-231982c6f68mr74745145ad.49.1747266075787; 
 Wed, 14 May 2025 16:41:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12] qapi: remove all TARGET_* conditionals from the schema
Date: Wed, 14 May 2025 16:40:56 -0700
Message-ID: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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
 stubs/monitor-i386-rtc.c                  |  14 +
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
 37 files changed, 811 insertions(+), 705 deletions(-)
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


