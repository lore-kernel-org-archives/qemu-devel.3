Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91551C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Jc-0005eS-Jb; Fri, 15 Mar 2024 09:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JM-0005cD-NB
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:27 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7JF-0007X9-KR
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:24 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-51381021af1so2897782e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508155; x=1711112955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7a422lMoFqhS7qWnbusg1+rx0QiF01UmLh0mI1ZQEY0=;
 b=HN3TCHDXYLS6LMy4hk6gXVR2LxyUJq8I/ly2Tw+zZODMIcsNzMEm/hawiCIY7p4bqe
 ndisUQ1GJhjvNrmQ8bHmX/zpnH+EnHDrGYBKa2ZL/FHwse0p6/lE5QUyL9EVbarLKgY1
 y/LeN2eA+L2zuwfFA6zb6ye0DT7R5MLynwEy+rns3Mp+eH4uQ+aGNJiGzWBcFyKSyl+Z
 mXhwSUmzzmU/WttLdzgV4EvAO6IQuR2epZwQhN1W3vKOIlsD1V1tq4GOu25AwBQOp863
 R716Pof5cPYoJooM9Lm0WQfetMqpIjF56hfyRpRLtrScKZmJFoJDHFg1UN/9fyPwsaJ3
 vLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508155; x=1711112955;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7a422lMoFqhS7qWnbusg1+rx0QiF01UmLh0mI1ZQEY0=;
 b=qvZZQJ6wd1e8kC+6hbtbeb/kT8hjQq6WX84AG0yaIIjHkj3TPTGe3n/rYNWG6Iv3/d
 8UY97TXpmNAHUo9bjimKlPIZ7tZi8wpp7f/muo4IjmbOJrUig7Wi4z/IAX5Tuw/virq4
 fAhxB8SSajW6ucI5T05YwkijpAKsYUgSU9C0RaISjv9cqhvrfOpbkERTp6jYC/CguV+O
 l1PwV6ZGKIbFVHzECPK3i0Ox6DOlb8jMsA1HzCJXjpOclPPt+EQipyhbDILA3CI03fhj
 B5pAJPdrR3cWd+7WLDeC87Oyy4/c4KdMJQF0HNZGKs51VuBPult1i7i1vkfosv4Lfb3l
 MbrQ==
X-Gm-Message-State: AOJu0Yznn1F0M7HHBwCZM7LeOMKVzipCjYZd1H9xvJWlc28dtHLWLIBi
 dn1yuW0IZiKKyZvaVPiSiaz8K8tXlEuJEKIwJuHPUTbIqFoDVT4Ma5zkOqyfReL4M1CF4vNwx4+
 z
X-Google-Smtp-Source: AGHT+IFQmUy/dU+fupT8cYu33ialfeNRqZs47n4Rfj0aky+gjH4INiHFbcsT6qE9d0RgV4ZxVkrSVw==
X-Received: by 2002:a05:6512:468:b0:512:e02f:9fa7 with SMTP id
 x8-20020a056512046800b00512e02f9fa7mr2636463lfd.1.1710508154576; 
 Fri, 15 Mar 2024 06:09:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 gx27-20020a1709068a5b00b00a3d11feb32esm1690762ejc.186.2024.03.15.06.09.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:09:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 00/21] qapi: Make @query-cpu-definitions command
 target-agnostic
Date: Fri, 15 Mar 2024 14:08:48 +0100
Message-ID: <20240315130910.15750-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

Hi Alex, Markus,

Markus mentioned QAPI problems with the heterogeneous emulation
binary. My understanding is, while QAPI can use host-specific
conditional (OS, library available, configure option), it
shouldn't use target-specific ones.

This series is an example on how to remove target specific
bits from the @query-cpu-definitions command. Target specific
code is registered as CPUClass handlers, then a generic method
is used, iterating over all targets built in.

The first set of patches were already posted / reviewed last
year.

The PPC and S390X targets still need work (help welcomed),
however the code is useful enough to be tested and see if this
is a good approach.

The only drawback is a change in QAPI introspection, because
targets not implementing @query-cpu-definitions were returning
"CommandNotFound". My view is this was an incomplete
implementation, rather than a feature.

Regards,

Phil.

Philippe Mathieu-Daudé (21):
  target/i386: Declare CPU QOM types using DEFINE_TYPES() macro
  target/mips: Declare CPU QOM types using DEFINE_TYPES() macro
  target/ppc: Declare CPU QOM types using DEFINE_TYPES() macro
  target/sparc: Declare CPU QOM types using DEFINE_TYPES() macro
  cpus: Open code OBJECT_DECLARE_TYPE() in OBJECT_DECLARE_CPU_TYPE()
  target/i386: Make X86_CPU common to new I386_CPU / X86_64_CPU types
  target/mips: Make MIPS_CPU common to new MIPS32_CPU / MIPS64_CPU types
  target/sparc: Make SPARC_CPU common to new SPARC32_CPU/SPARC64_CPU
    types
  qapi: Merge machine-common.json with qapi/machine.json
  qapi: Make CpuModel* definitions target agnostic
  qapi: Make CpuDefinitionInfo target agnostic
  system: Introduce QemuArchBit enum
  system: Introduce cpu_typename_by_arch_bit()
  system: Introduce QMP generic_query_cpu_definitions()
  target/arm: Use QMP generic_query_cpu_definitions()
  target/loongarch: Use QMP generic_query_cpu_definitions()
  target/riscv: Use QMP generic_query_cpu_definitions()
  target/i386: Use QMP generic_query_cpu_definitions()
  target/ppc: Factor ppc_add_alias_definitions() out
  target/ppc: Use QMP generic_query_cpu_definitions()
  qapi: Make @query-cpu-definitions target-agnostic

 MAINTAINERS                           |   3 +-
 qapi/machine-common.json              |  21 ----
 qapi/machine-target.json              | 167 +-------------------------
 qapi/machine.json                     | 166 ++++++++++++++++++++++++-
 qapi/qapi-schema.json                 |   1 -
 include/hw/core/cpu.h                 |   7 +-
 include/hw/core/sysemu-cpu-ops.h      |  14 +++
 include/sysemu/arch_init.h            |  71 +++++++----
 target/i386/cpu-qom.h                 |  16 ++-
 target/mips/cpu-qom.h                 |  13 +-
 target/ppc/cpu-models.h               |   4 +
 target/riscv/cpu.h                    |   2 +
 target/s390x/cpu.h                    |   2 +-
 target/sparc/cpu-qom.h                |   9 +-
 system/cpu-qmp-cmds.c                 |  71 +++++++++++
 system/cpu-qom-helpers.c              |  58 +++++++++
 target/arm/arm-qmp-cmds.c             |  27 -----
 target/i386/cpu.c                     |  77 ++++++------
 target/loongarch/loongarch-qmp-cmds.c |  25 ----
 target/mips/cpu.c                     |  34 ++++--
 target/mips/sysemu/mips-qmp-cmds.c    |  31 -----
 target/ppc/cpu_init.c                 |  53 ++++----
 target/ppc/ppc-qmp-cmds.c             |  31 +----
 target/riscv/cpu.c                    |   1 +
 target/riscv/riscv-qmp-cmds.c         |  13 +-
 target/sparc/cpu.c                    |  35 ++++--
 tests/qtest/cpu-plug-test.c           |   2 +-
 qapi/meson.build                      |   1 -
 system/meson.build                    |   2 +
 29 files changed, 515 insertions(+), 442 deletions(-)
 delete mode 100644 qapi/machine-common.json
 create mode 100644 system/cpu-qmp-cmds.c
 create mode 100644 system/cpu-qom-helpers.c

-- 
2.41.0


