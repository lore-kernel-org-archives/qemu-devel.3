Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D3C3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyd-0000eL-6K; Wed, 07 May 2025 19:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyb-0000dX-OZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyX-00079D-9E
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:14:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso5011165ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659691; x=1747264491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+Do/vb7CoxT02dLkA4A4DxgTWo5tvmeFtdtT48tXERE=;
 b=hbX9DG7CnS1WjfTnz6aqmy765xP7VpLn8XxayT0rdq/+1FFWuKBPSZcwebkUr+sB0K
 Y8/hZck1c5jH4G8ye2dbq1COWdnZG+sS/TPzMzBUtKcHvZ1wEb1AVqfjQRSfWk1frIKp
 xMa5cYbLBruk6Kg0vSzhlh235DJwpPNXRR80WKsKxxAhke8npnbeyNdso2Z2k15ni9BS
 4UAY8AB6ng5QkPZ7JJY26DCWiHSX0sSmhRrhho7YvF/55Nko9d013O1BvT+S+eCoymHe
 75shmU30Uhcwacmt2Gy2SjJ8jjdJ9BAvYXofbvZ9Br2cpaT0/oLZuGHF9IfqlKSP//EC
 LXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659691; x=1747264491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+Do/vb7CoxT02dLkA4A4DxgTWo5tvmeFtdtT48tXERE=;
 b=Cr/ozpI2EY5ucnLQO17PMX0WULIXz6f7zlZIQ06bPesDrnN7UazBy7KNwjY0z9K++T
 aT0n0IruLzWDrcOZArC9Xey8OBnabK/J4UXiz9+U1fuJI/Ef4pYLjPUFDQuYvWqOHBMq
 ml3iaE/PqGlaCRi6AblhqauEXwmegyJS9uVgM1rcj72l6pfIdTadNO0fSbkW3YfvAPjx
 5X/LQiqYKf63Z4GMgU8umRFyywE/ZPCXIoHbVnM4fwz9UNJYbIboDAUPxQUrB9s750Ax
 JeuWAujq39rzK8eU9hVd05TUavP6pJMZYnrdouS3yL/PAslAmxBqrQpfiKOTP9z1q8nL
 6tcA==
X-Gm-Message-State: AOJu0YxW3eHOrMgZ5/pgKgKLuYG7SCZvzV+65wCGfi7romsqSOts/ol7
 l3VDWHSustz8DjxgmDEpKTqBkY74nOCM0agkfewTxNptgUX23AzlGR3Ul7gVxOOdPX37M4hwaCU
 vchx0eg==
X-Gm-Gg: ASbGncvMJ0+oTXHIvS2TgEcuf3flt++tMkrgoVwj75Wbru8Fxti5E8mXgpHAqZoP0TN
 /5kAsfC01FmKxwK5iRtiM8xMXVuRXRpjwSI93A2K0k3JcVoRxaBIRa+ZXdRaSrXZbaFncLGpp+3
 /1iJirvTpsnNQvSqzwC/pwcOBskq7QvkitLu5eeRvxhQcUw2SolC7QHx6d80qryS9KrW55C8ji7
 HP2ksOqbf0um6Ab38aKqAXydopcBPGqvZEsT6MvQoV8MLWp3x/N8i4tmf8rV6cG0QOBmD09kmoB
 k4ek/4qfamHk6cjMZssRo6YXMOZSEFAfWTZBA36K
X-Google-Smtp-Source: AGHT+IHs5CfDK2GCKiCe+RxJXLwNTQp2ze8vfoW/DPt8E7dabIGKqTV2ldkb9xscvB8ZWWEZY3yb0Q==
X-Received: by 2002:a17:903:3bc4:b0:22e:3ea4:b55c with SMTP id
 d9443c01a7336-22e863c2f76mr16100575ad.30.1746659691189; 
 Wed, 07 May 2025 16:14:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:14:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 00/13] single-binary: make QAPI generated files common
Date: Wed,  7 May 2025 16:14:30 -0700
Message-ID: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

This series compiles QAPI generated once, while keeping the same schema and
commands exposed to the QAPI consumer.

Steps:
- Introduce a new json entry, named 'runtime_if' (name is not definitive,
  see patch 1), to allow dynamic check about exposing a given entry/command or
 not.
- Conditionally expose the QMP schema based on those conditionals.
- Conditonally register commands
- Conditinally visit fields during JSON marshalling
- Extend existing qemu/target-info.h with the helpers needed.
- Modify QAPI json to use runtime conditionals
- Compile QAPI generated code as common - no more target specifics

Note: A final annex (do not merge) is included to see the differences in the
generated QAPI code, so you don't need to pull and see it by yourself.

Original RFC (and context)
--------------------------
https://patchew.org/QEMU/20250424183350.1798746-1-pierrick.bouvier@linaro.org/

Pierrick Bouvier (13):
  qapi: introduce 'runtime_if' for QAPI json
  qapi/introspect: generate schema as a QObject directly
  qobject/qlit: allow to hide dict or list entries
  qapi/introspect: hide fields in schema
  qapi/commands: register commands conditionally
  qapi/visit: hide fields in JSON marshalling
  qapi: add access to qemu/target-info.h
  qemu/target-info: implement missing helpers
  qapi: transform target specific 'if' in runtime checks
  qapi: add weak stubs for target specific commands
  qapi: make all generated files common
  [ANNEX] build/qapi: reference
  [ANNEX] build/qapi: after series

 meson.build                                   |     2 +-
 qapi/machine-target.json                      |    84 +-
 qapi/misc-target.json                         |    48 +-
 build/qapi/qapi-builtin-types.h               |   184 +
 build/qapi/qapi-builtin-visit.h               |    68 +
 build/qapi/qapi-commands-acpi.h               |    21 +
 build/qapi/qapi-commands-audio.h              |    21 +
 build/qapi/qapi-commands-authz.h              |    19 +
 build/qapi/qapi-commands-block-core.h         |   105 +
 build/qapi/qapi-commands-block-export.h       |    35 +
 build/qapi/qapi-commands-block.h              |    38 +
 build/qapi/qapi-commands-char.h               |    36 +
 build/qapi/qapi-commands-common.h             |    19 +
 build/qapi/qapi-commands-compat.h             |    19 +
 build/qapi/qapi-commands-control.h            |    27 +
 build/qapi/qapi-commands-crypto.h             |    19 +
 build/qapi/qapi-commands-cryptodev.h          |    21 +
 build/qapi/qapi-commands-cxl.h                |    35 +
 build/qapi/qapi-commands-dump.h               |    25 +
 build/qapi/qapi-commands-ebpf.h               |    23 +
 build/qapi/qapi-commands-error.h              |    19 +
 build/qapi/qapi-commands-introspect.h         |    21 +
 build/qapi/qapi-commands-job.h                |    33 +
 build/qapi/qapi-commands-machine-common.h     |    19 +
 build/qapi/qapi-commands-machine-target.h     |    32 +
 build/qapi/qapi-commands-machine.h            |    89 +
 build/qapi/qapi-commands-migration.h          |    89 +
 build/qapi/qapi-commands-misc-target.h        |    41 +
 build/qapi/qapi-commands-misc.h               |    52 +
 build/qapi/qapi-commands-net.h                |    30 +
 build/qapi/qapi-commands-pci.h                |    21 +
 build/qapi/qapi-commands-pragma.h             |    19 +
 build/qapi/qapi-commands-qdev.h               |    26 +
 build/qapi/qapi-commands-qom.h                |    37 +
 build/qapi/qapi-commands-replay.h             |    28 +
 build/qapi/qapi-commands-rocker.h             |    27 +
 build/qapi/qapi-commands-run-state.h          |    25 +
 build/qapi/qapi-commands-sockets.h            |    19 +
 build/qapi/qapi-commands-stats.h              |    23 +
 build/qapi/qapi-commands-tpm.h                |    31 +
 build/qapi/qapi-commands-trace.h              |    23 +
 build/qapi/qapi-commands-transaction.h        |    22 +
 build/qapi/qapi-commands-uefi.h               |    19 +
 build/qapi/qapi-commands-ui.h                 |    59 +
 build/qapi/qapi-commands-vfio.h               |    19 +
 build/qapi/qapi-commands-virtio.h             |    29 +
 build/qapi/qapi-commands-yank.h               |    23 +
 build/qapi/qapi-commands.h                    |    60 +
 build/qapi/qapi-emit-events.h                 |    85 +
 build/qapi/qapi-events-acpi.h                 |    21 +
 build/qapi/qapi-events-audio.h                |    19 +
 build/qapi/qapi-events-authz.h                |    19 +
 build/qapi/qapi-events-block-core.h           |    43 +
 build/qapi/qapi-events-block-export.h         |    23 +
 build/qapi/qapi-events-block.h                |    24 +
 build/qapi/qapi-events-char.h                 |    22 +
 build/qapi/qapi-events-common.h               |    19 +
 build/qapi/qapi-events-compat.h               |    19 +
 build/qapi/qapi-events-control.h              |    19 +
 build/qapi/qapi-events-crypto.h               |    19 +
 build/qapi/qapi-events-cryptodev.h            |    19 +
 build/qapi/qapi-events-cxl.h                  |    19 +
 build/qapi/qapi-events-dump.h                 |    21 +
 build/qapi/qapi-events-ebpf.h                 |    19 +
 build/qapi/qapi-events-error.h                |    19 +
 build/qapi/qapi-events-introspect.h           |    19 +
 build/qapi/qapi-events-job.h                  |    21 +
 build/qapi/qapi-events-machine-common.h       |    19 +
 build/qapi/qapi-events-machine-target.h       |    22 +
 build/qapi/qapi-events-machine.h              |    27 +
 build/qapi/qapi-events-migration.h            |    29 +
 build/qapi/qapi-events-misc-target.h          |    19 +
 build/qapi/qapi-events-misc.h                 |    24 +
 build/qapi/qapi-events-net.h                  |    32 +
 build/qapi/qapi-events-pci.h                  |    19 +
 build/qapi/qapi-events-pragma.h               |    19 +
 build/qapi/qapi-events-qdev.h                 |    24 +
 build/qapi/qapi-events-qom.h                  |    23 +
 build/qapi/qapi-events-replay.h               |    20 +
 build/qapi/qapi-events-rocker.h               |    19 +
 build/qapi/qapi-events-run-state.h            |    45 +
 build/qapi/qapi-events-sockets.h              |    19 +
 build/qapi/qapi-events-stats.h                |    19 +
 build/qapi/qapi-events-tpm.h                  |    19 +
 build/qapi/qapi-events-trace.h                |    19 +
 build/qapi/qapi-events-transaction.h          |    20 +
 build/qapi/qapi-events-uefi.h                 |    19 +
 build/qapi/qapi-events-ui.h                   |    49 +
 build/qapi/qapi-events-vfio.h                 |    21 +
 build/qapi/qapi-events-virtio.h               |    19 +
 build/qapi/qapi-events-yank.h                 |    19 +
 build/qapi/qapi-events.h                      |    60 +
 build/qapi/qapi-features.h                    |    28 +
 build/qapi/qapi-init-commands.h               |    20 +
 build/qapi/qapi-introspect.h                  |    19 +
 build/qapi/qapi-types-acpi.h                  |    78 +
 build/qapi/qapi-types-audio.h                 |   537 +
 build/qapi/qapi-types-authz.h                 |   103 +
 build/qapi/qapi-types-block-core.h            |  3643 ++
 build/qapi/qapi-types-block-export.h          |   313 +
 build/qapi/qapi-types-block.h                 |   161 +
 build/qapi/qapi-types-char.h                  |   728 +
 build/qapi/qapi-types-common.h                |   175 +
 build/qapi/qapi-types-compat.h                |    57 +
 build/qapi/qapi-types-control.h               |   110 +
 build/qapi/qapi-types-crypto.h                |   527 +
 build/qapi/qapi-types-cryptodev.h             |   106 +
 build/qapi/qapi-types-cxl.h                   |   247 +
 build/qapi/qapi-types-dump.h                  |   100 +
 build/qapi/qapi-types-ebpf.h                  |    55 +
 build/qapi/qapi-types-error.h                 |    32 +
 build/qapi/qapi-types-introspect.h            |   244 +
 build/qapi/qapi-types-job.h                   |   140 +
 build/qapi/qapi-types-machine-common.h        |    91 +
 build/qapi/qapi-types-machine-target.h        |   172 +
 build/qapi/qapi-types-machine.h               |   922 +
 build/qapi/qapi-types-migration.h             |   900 +
 build/qapi/qapi-types-misc-target.h           |   238 +
 build/qapi/qapi-types-misc.h                  |   241 +
 build/qapi/qapi-types-net.h                   |   549 +
 build/qapi/qapi-types-pci.h                   |   152 +
 build/qapi/qapi-types-pragma.h                |    18 +
 build/qapi/qapi-types-qdev.h                  |    59 +
 build/qapi/qapi-types-qom.h                   |  1049 +
 build/qapi/qapi-types-replay.h                |    54 +
 build/qapi/qapi-types-rocker.h                |   231 +
 build/qapi/qapi-types-run-state.h             |   312 +
 build/qapi/qapi-types-sockets.h               |   220 +
 build/qapi/qapi-types-stats.h                 |   231 +
 build/qapi/qapi-types-tpm.h                   |   194 +
 build/qapi/qapi-types-trace.h                 |    65 +
 build/qapi/qapi-types-transaction.h           |   197 +
 build/qapi/qapi-types-uefi.h                  |    52 +
 build/qapi/qapi-types-ui.h                    |  1263 +
 build/qapi/qapi-types-vfio.h                  |    42 +
 build/qapi/qapi-types-virtio.h                |   307 +
 build/qapi/qapi-types-yank.h                  |    83 +
 build/qapi/qapi-types.h                       |    59 +
 build/qapi/qapi-visit-acpi.h                  |    38 +
 build/qapi/qapi-visit-audio.h                 |   136 +
 build/qapi/qapi-visit-authz.h                 |    54 +
 build/qapi/qapi-visit-block-core.h            |   962 +
 build/qapi/qapi-visit-block-export.h          |    99 +
 build/qapi/qapi-visit-block.h                 |    56 +
 build/qapi/qapi-visit-char.h                  |   235 +
 build/qapi/qapi-visit-common.h                |    58 +
 build/qapi/qapi-visit-compat.h                |    31 +
 build/qapi/qapi-visit-control.h               |    54 +
 build/qapi/qapi-visit-crypto.h                |   165 +
 build/qapi/qapi-visit-cryptodev.h             |    48 +
 build/qapi/qapi-visit-cxl.h                   |    67 +
 build/qapi/qapi-visit-dump.h                  |    43 +
 build/qapi/qapi-visit-ebpf.h                  |    36 +
 build/qapi/qapi-visit-error.h                 |    23 +
 build/qapi/qapi-visit-introspect.h            |   103 +
 build/qapi/qapi-visit-job.h                   |    51 +
 build/qapi/qapi-visit-machine-common.h        |    42 +
 build/qapi/qapi-visit-machine-target.h        |    73 +
 build/qapi/qapi-visit-machine.h               |   311 +
 build/qapi/qapi-visit-migration.h             |   241 +
 build/qapi/qapi-visit-misc-target.h           |    96 +
 build/qapi/qapi-visit-misc.h                  |    98 +
 build/qapi/qapi-visit-net.h                   |   171 +
 build/qapi/qapi-visit-pci.h                   |    69 +
 build/qapi/qapi-visit-pragma.h                |    20 +
 build/qapi/qapi-visit-qdev.h                  |    33 +
 build/qapi/qapi-visit-qom.h                   |   263 +
 build/qapi/qapi-visit-replay.h                |    33 +
 build/qapi/qapi-visit-rocker.h                |    78 +
 build/qapi/qapi-visit-run-state.h             |    99 +
 build/qapi/qapi-visit-sockets.h               |    91 +
 build/qapi/qapi-visit-stats.h                 |    89 +
 build/qapi/qapi-visit-tpm.h                   |    91 +
 build/qapi/qapi-visit-trace.h                 |    35 +
 build/qapi/qapi-visit-transaction.h           |    94 +
 build/qapi/qapi-visit-uefi.h                  |    33 +
 build/qapi/qapi-visit-ui.h                    |   370 +
 build/qapi/qapi-visit-vfio.h                  |    25 +
 build/qapi/qapi-visit-virtio.h                |   113 +
 build/qapi/qapi-visit-yank.h                  |    45 +
 build/qapi/qapi-visit.h                       |    61 +
 include/qemu/target-info.h                    |    14 +
 include/qobject/qlit.h                        |    12 +
 build/qapi/qapi-builtin-types.c               |   227 +
 build/qapi/qapi-builtin-visit.c               |   448 +
 build/qapi/qapi-commands-acpi.c               |    87 +
 build/qapi/qapi-commands-audio.c              |    87 +
 build/qapi/qapi-commands-authz.c              |    26 +
 build/qapi/qapi-commands-block-core.c         |  1931 +
 build/qapi/qapi-commands-block-export.c       |   341 +
 build/qapi/qapi-commands-block.c              |   431 +
 build/qapi/qapi-commands-char.c               |   457 +
 build/qapi/qapi-commands-common.c             |    26 +
 build/qapi/qapi-commands-compat.c             |    26 +
 build/qapi/qapi-commands-control.c            |   230 +
 build/qapi/qapi-commands-crypto.c             |    26 +
 build/qapi/qapi-commands-cryptodev.c          |    87 +
 build/qapi/qapi-commands-cxl.c                |   370 +
 build/qapi/qapi-commands-dump.c               |   191 +
 build/qapi/qapi-commands-ebpf.c               |    95 +
 build/qapi/qapi-commands-error.c              |    26 +
 build/qapi/qapi-commands-introspect.c         |    87 +
 build/qapi/qapi-commands-job.c                |   345 +
 build/qapi/qapi-commands-machine-common.c     |    26 +
 build/qapi/qapi-commands-machine-target.c     |   386 +
 build/qapi/qapi-commands-machine.c            |  1626 +
 build/qapi/qapi-commands-migration.c          |  1415 +
 build/qapi/qapi-commands-misc-target.c        |   628 +
 build/qapi/qapi-commands-misc.c               |   740 +
 build/qapi/qapi-commands-net.c                |   263 +
 build/qapi/qapi-commands-pci.c                |    87 +
 build/qapi/qapi-commands-pragma.c             |    26 +
 build/qapi/qapi-commands-qdev.c               |   177 +
 build/qapi/qapi-commands-qom.c                |   400 +
 build/qapi/qapi-commands-replay.c             |   212 +
 build/qapi/qapi-commands-rocker.c             |   286 +
 build/qapi/qapi-commands-run-state.c          |   173 +
 build/qapi/qapi-commands-sockets.c            |    26 +
 build/qapi/qapi-commands-stats.c              |   156 +
 build/qapi/qapi-commands-tpm.c                |   221 +
 build/qapi/qapi-commands-trace.c              |   134 +
 build/qapi/qapi-commands-transaction.c        |    69 +
 build/qapi/qapi-commands-uefi.c               |    26 +
 build/qapi/qapi-commands-ui.c                 |   734 +
 build/qapi/qapi-commands-vfio.c               |    26 +
 build/qapi/qapi-commands-virtio.c             |   347 +
 build/qapi/qapi-commands-yank.c               |   130 +
 build/qapi/qapi-commands.c                    |    24 +
 build/qapi/qapi-emit-events.c                 |    79 +
 build/qapi/qapi-events-acpi.c                 |    53 +
 build/qapi/qapi-events-audio.c                |    23 +
 build/qapi/qapi-events-authz.c                |    23 +
 build/qapi/qapi-events-block-core.c           |   323 +
 build/qapi/qapi-events-block-export.c         |    53 +
 build/qapi/qapi-events-block.c                |    83 +
 build/qapi/qapi-events-char.c                 |    53 +
 build/qapi/qapi-events-common.c               |    23 +
 build/qapi/qapi-events-compat.c               |    23 +
 build/qapi/qapi-events-control.c              |    23 +
 build/qapi/qapi-events-crypto.c               |    23 +
 build/qapi/qapi-events-cryptodev.c            |    23 +
 build/qapi/qapi-events-cxl.c                  |    23 +
 build/qapi/qapi-events-dump.c                 |    53 +
 build/qapi/qapi-events-ebpf.c                 |    23 +
 build/qapi/qapi-events-error.c                |    23 +
 build/qapi/qapi-events-introspect.c           |    23 +
 build/qapi/qapi-events-job.c                  |    53 +
 build/qapi/qapi-events-machine-common.c       |    23 +
 build/qapi/qapi-events-machine-target.c       |    57 +
 build/qapi/qapi-events-machine.c              |   110 +
 build/qapi/qapi-events-migration.c            |   143 +
 build/qapi/qapi-events-misc-target.c          |    23 +
 build/qapi/qapi-events-misc.c                 |    83 +
 build/qapi/qapi-events-net.c                  |   203 +
 build/qapi/qapi-events-pci.c                  |    23 +
 build/qapi/qapi-events-pragma.c               |    23 +
 build/qapi/qapi-events-qdev.c                 |    83 +
 build/qapi/qapi-events-qom.c                  |    23 +
 build/qapi/qapi-events-replay.c               |    23 +
 build/qapi/qapi-events-rocker.c               |    23 +
 build/qapi/qapi-events-run-state.c            |   280 +
 build/qapi/qapi-events-sockets.c              |    23 +
 build/qapi/qapi-events-stats.c                |    23 +
 build/qapi/qapi-events-tpm.c                  |    23 +
 build/qapi/qapi-events-trace.c                |    23 +
 build/qapi/qapi-events-transaction.c          |    23 +
 build/qapi/qapi-events-uefi.c                 |    23 +
 build/qapi/qapi-events-ui.c                   |   228 +
 build/qapi/qapi-events-vfio.c                 |    53 +
 build/qapi/qapi-events-virtio.c               |    23 +
 build/qapi/qapi-events-yank.c                 |    23 +
 build/qapi/qapi-events.c                      |    23 +
 build/qapi/qapi-features.c                    |    14 +
 build/qapi/qapi-init-commands.c               |   576 +
 build/qapi/qapi-introspect.c                  | 32177 ++++++++++++++++
 build/qapi/qapi-types-acpi.c                  |    67 +
 build/qapi/qapi-types-audio.c                 |   360 +
 build/qapi/qapi-types-authz.c                 |   114 +
 build/qapi/qapi-types-block-core.c            |  2488 ++
 build/qapi/qapi-types-block-export.c          |   211 +
 build/qapi/qapi-types-block.c                 |    77 +
 build/qapi/qapi-types-char.c                  |   560 +
 build/qapi/qapi-types-common.c                |   151 +
 build/qapi/qapi-types-compat.c                |    50 +
 build/qapi/qapi-types-control.c               |   113 +
 build/qapi/qapi-types-crypto.c                |   415 +
 build/qapi/qapi-types-cryptodev.c             |   113 +
 build/qapi/qapi-types-cxl.c                   |   134 +
 build/qapi/qapi-types-dump.c                  |    83 +
 build/qapi/qapi-types-ebpf.c                  |    44 +
 build/qapi/qapi-types-error.c                 |    31 +
 build/qapi/qapi-types-introspect.c            |   268 +
 build/qapi/qapi-types-job.c                   |    92 +
 build/qapi/qapi-types-machine-common.c        |    94 +
 build/qapi/qapi-types-machine-target.c        |   137 +
 build/qapi/qapi-types-machine.c               |   811 +
 build/qapi/qapi-types-migration.c             |   606 +
 build/qapi/qapi-types-misc-target.c           |   221 +
 build/qapi/qapi-types-misc.c                  |   186 +
 build/qapi/qapi-types-net.c                   |   378 +
 build/qapi/qapi-types-pci.c                   |   163 +
 build/qapi/qapi-types-pragma.c                |    20 +
 build/qapi/qapi-types-qdev.c                  |    20 +
 build/qapi/qapi-types-qom.c                   |   659 +
 build/qapi/qapi-types-replay.c                |    42 +
 build/qapi/qapi-types-rocker.c                |   166 +
 build/qapi/qapi-types-run-state.c             |   218 +
 build/qapi/qapi-types-sockets.c               |   210 +
 build/qapi/qapi-types-stats.c                 |   227 +
 build/qapi/qapi-types-tpm.c                   |   176 +
 build/qapi/qapi-types-trace.c                 |    55 +
 build/qapi/qapi-types-transaction.c           |   218 +
 build/qapi/qapi-types-uefi.c                  |    59 +
 build/qapi/qapi-types-ui.c                    |   987 +
 build/qapi/qapi-types-vfio.c                  |    33 +
 build/qapi/qapi-types-virtio.c                |   261 +
 build/qapi/qapi-types-yank.c                  |    81 +
 build/qapi/qapi-types.c                       |    20 +
 build/qapi/qapi-visit-acpi.c                  |   200 +
 build/qapi/qapi-visit-audio.c                 |  1183 +
 build/qapi/qapi-visit-authz.c                 |   261 +
 build/qapi/qapi-visit-block-core.c            |  9436 +++++
 build/qapi/qapi-visit-block-export.c          |   667 +
 build/qapi/qapi-visit-block.c                 |   311 +
 build/qapi/qapi-visit-char.c                  |  1625 +
 build/qapi/qapi-visit-common.c                |   187 +
 build/qapi/qapi-visit-compat.c                |    90 +
 build/qapi/qapi-visit-control.c               |   270 +
 build/qapi/qapi-visit-crypto.c                |  1112 +
 build/qapi/qapi-visit-cryptodev.c             |   210 +
 build/qapi/qapi-visit-cxl.c                   |   452 +
 build/qapi/qapi-visit-dump.c                  |   188 +
 build/qapi/qapi-visit-ebpf.c                  |    78 +
 build/qapi/qapi-visit-error.c                 |    29 +
 build/qapi/qapi-visit-introspect.c            |   683 +
 build/qapi/qapi-visit-job.c                   |   188 +
 build/qapi/qapi-visit-machine-common.c        |   148 +
 build/qapi/qapi-visit-machine-target.c        |   400 +
 build/qapi/qapi-visit-machine.c               |  2477 ++
 build/qapi/qapi-visit-migration.c             |  1918 +
 build/qapi/qapi-visit-misc-target.c           |   598 +
 build/qapi/qapi-visit-misc.c                  |   600 +
 build/qapi/qapi-visit-net.c                   |  1583 +
 build/qapi/qapi-visit-pci.c                   |   482 +
 build/qapi/qapi-visit-pragma.c                |    20 +
 build/qapi/qapi-visit-qdev.c                  |    95 +
 build/qapi/qapi-visit-qom.c                   |  2164 ++
 build/qapi/qapi-visit-replay.c                |    90 +
 build/qapi/qapi-visit-rocker.c                |   617 +
 build/qapi/qapi-visit-run-state.c             |   453 +
 build/qapi/qapi-visit-sockets.c               |   571 +
 build/qapi/qapi-visit-stats.c                 |   566 +
 build/qapi/qapi-visit-tpm.c                   |   388 +
 build/qapi/qapi-visit-trace.c                 |   119 +
 build/qapi/qapi-visit-transaction.c           |   536 +
 build/qapi/qapi-visit-uefi.c                  |   143 +
 build/qapi/qapi-visit-ui.c                    |  2346 ++
 build/qapi/qapi-visit-vfio.c                  |    43 +
 build/qapi/qapi-visit-virtio.c                |   889 +
 build/qapi/qapi-visit-yank.c                  |   188 +
 build/qapi/qapi-visit.c                       |    20 +
 monitor/qmp-cmds-control.c                    |     2 +-
 qapi/commands-weak-stubs.c                    |    38 +
 qobject/qlit.c                                |    10 +-
 target-info.c                                 |   117 +
 tests/unit/test-qobject-input-visitor.c       |     6 +-
 build/qapi/qapi-commands-acpi.trace-events    |     4 +
 build/qapi/qapi-commands-audio.trace-events   |     4 +
 build/qapi/qapi-commands-authz.trace-events   |     2 +
 .../qapi-commands-block-core.trace-events     |    84 +
 .../qapi-commands-block-export.trace-events   |    16 +
 build/qapi/qapi-commands-block.trace-events   |    20 +
 build/qapi/qapi-commands-char.trace-events    |    18 +
 build/qapi/qapi-commands-common.trace-events  |     2 +
 build/qapi/qapi-commands-compat.trace-events  |     2 +
 build/qapi/qapi-commands-control.trace-events |    10 +
 build/qapi/qapi-commands-crypto.trace-events  |     2 +
 .../qapi/qapi-commands-cryptodev.trace-events |     4 +
 build/qapi/qapi-commands-cxl.trace-events     |    18 +
 build/qapi/qapi-commands-dump.trace-events    |     8 +
 build/qapi/qapi-commands-ebpf.trace-events    |     4 +
 build/qapi/qapi-commands-error.trace-events   |     2 +
 .../qapi-commands-introspect.trace-events     |     4 +
 build/qapi/qapi-commands-job.trace-events     |    16 +
 .../qapi-commands-machine-common.trace-events |     2 +
 .../qapi-commands-machine-target.trace-events |    14 +
 build/qapi/qapi-commands-machine.trace-events |    64 +
 .../qapi/qapi-commands-migration.trace-events |    60 +
 .../qapi-commands-misc-target.trace-events    |    24 +
 build/qapi/qapi-commands-misc.trace-events    |    30 +
 build/qapi/qapi-commands-net.trace-events     |    12 +
 build/qapi/qapi-commands-pci.trace-events     |     4 +
 build/qapi/qapi-commands-pragma.trace-events  |     2 +
 build/qapi/qapi-commands-qdev.trace-events    |     8 +
 build/qapi/qapi-commands-qom.trace-events     |    16 +
 build/qapi/qapi-commands-replay.trace-events  |    10 +
 build/qapi/qapi-commands-rocker.trace-events  |    10 +
 .../qapi/qapi-commands-run-state.trace-events |     8 +
 build/qapi/qapi-commands-sockets.trace-events |     2 +
 build/qapi/qapi-commands-stats.trace-events   |     6 +
 build/qapi/qapi-commands-tpm.trace-events     |     8 +
 build/qapi/qapi-commands-trace.trace-events   |     6 +
 .../qapi-commands-transaction.trace-events    |     4 +
 build/qapi/qapi-commands-uefi.trace-events    |     2 +
 build/qapi/qapi-commands-ui.trace-events      |    30 +
 build/qapi/qapi-commands-vfio.trace-events    |     2 +
 build/qapi/qapi-commands-virtio.trace-events  |    12 +
 build/qapi/qapi-commands-yank.trace-events    |     6 +
 build/qapi/qapi-commands.trace-events         |     2 +
 build/qapi/qapi-init-commands.trace-events    |     2 +
 qapi/meson.build                              |     4 +-
 scripts/qapi/commands.py                      |    10 +-
 scripts/qapi/common.py                        |    16 +-
 scripts/qapi/expr.py                          |    18 +-
 scripts/qapi/gen.py                           |    56 +-
 scripts/qapi/introspect.py                    |    38 +-
 scripts/qapi/schema.py                        |    47 +-
 scripts/qapi/visit.py                         |     4 +
 418 files changed, 119094 insertions(+), 101 deletions(-)
 create mode 100644 build/qapi/qapi-builtin-types.h
 create mode 100644 build/qapi/qapi-builtin-visit.h
 create mode 100644 build/qapi/qapi-commands-acpi.h
 create mode 100644 build/qapi/qapi-commands-audio.h
 create mode 100644 build/qapi/qapi-commands-authz.h
 create mode 100644 build/qapi/qapi-commands-block-core.h
 create mode 100644 build/qapi/qapi-commands-block-export.h
 create mode 100644 build/qapi/qapi-commands-block.h
 create mode 100644 build/qapi/qapi-commands-char.h
 create mode 100644 build/qapi/qapi-commands-common.h
 create mode 100644 build/qapi/qapi-commands-compat.h
 create mode 100644 build/qapi/qapi-commands-control.h
 create mode 100644 build/qapi/qapi-commands-crypto.h
 create mode 100644 build/qapi/qapi-commands-cryptodev.h
 create mode 100644 build/qapi/qapi-commands-cxl.h
 create mode 100644 build/qapi/qapi-commands-dump.h
 create mode 100644 build/qapi/qapi-commands-ebpf.h
 create mode 100644 build/qapi/qapi-commands-error.h
 create mode 100644 build/qapi/qapi-commands-introspect.h
 create mode 100644 build/qapi/qapi-commands-job.h
 create mode 100644 build/qapi/qapi-commands-machine-common.h
 create mode 100644 build/qapi/qapi-commands-machine-target.h
 create mode 100644 build/qapi/qapi-commands-machine.h
 create mode 100644 build/qapi/qapi-commands-migration.h
 create mode 100644 build/qapi/qapi-commands-misc-target.h
 create mode 100644 build/qapi/qapi-commands-misc.h
 create mode 100644 build/qapi/qapi-commands-net.h
 create mode 100644 build/qapi/qapi-commands-pci.h
 create mode 100644 build/qapi/qapi-commands-pragma.h
 create mode 100644 build/qapi/qapi-commands-qdev.h
 create mode 100644 build/qapi/qapi-commands-qom.h
 create mode 100644 build/qapi/qapi-commands-replay.h
 create mode 100644 build/qapi/qapi-commands-rocker.h
 create mode 100644 build/qapi/qapi-commands-run-state.h
 create mode 100644 build/qapi/qapi-commands-sockets.h
 create mode 100644 build/qapi/qapi-commands-stats.h
 create mode 100644 build/qapi/qapi-commands-tpm.h
 create mode 100644 build/qapi/qapi-commands-trace.h
 create mode 100644 build/qapi/qapi-commands-transaction.h
 create mode 100644 build/qapi/qapi-commands-uefi.h
 create mode 100644 build/qapi/qapi-commands-ui.h
 create mode 100644 build/qapi/qapi-commands-vfio.h
 create mode 100644 build/qapi/qapi-commands-virtio.h
 create mode 100644 build/qapi/qapi-commands-yank.h
 create mode 100644 build/qapi/qapi-commands.h
 create mode 100644 build/qapi/qapi-emit-events.h
 create mode 100644 build/qapi/qapi-events-acpi.h
 create mode 100644 build/qapi/qapi-events-audio.h
 create mode 100644 build/qapi/qapi-events-authz.h
 create mode 100644 build/qapi/qapi-events-block-core.h
 create mode 100644 build/qapi/qapi-events-block-export.h
 create mode 100644 build/qapi/qapi-events-block.h
 create mode 100644 build/qapi/qapi-events-char.h
 create mode 100644 build/qapi/qapi-events-common.h
 create mode 100644 build/qapi/qapi-events-compat.h
 create mode 100644 build/qapi/qapi-events-control.h
 create mode 100644 build/qapi/qapi-events-crypto.h
 create mode 100644 build/qapi/qapi-events-cryptodev.h
 create mode 100644 build/qapi/qapi-events-cxl.h
 create mode 100644 build/qapi/qapi-events-dump.h
 create mode 100644 build/qapi/qapi-events-ebpf.h
 create mode 100644 build/qapi/qapi-events-error.h
 create mode 100644 build/qapi/qapi-events-introspect.h
 create mode 100644 build/qapi/qapi-events-job.h
 create mode 100644 build/qapi/qapi-events-machine-common.h
 create mode 100644 build/qapi/qapi-events-machine-target.h
 create mode 100644 build/qapi/qapi-events-machine.h
 create mode 100644 build/qapi/qapi-events-migration.h
 create mode 100644 build/qapi/qapi-events-misc-target.h
 create mode 100644 build/qapi/qapi-events-misc.h
 create mode 100644 build/qapi/qapi-events-net.h
 create mode 100644 build/qapi/qapi-events-pci.h
 create mode 100644 build/qapi/qapi-events-pragma.h
 create mode 100644 build/qapi/qapi-events-qdev.h
 create mode 100644 build/qapi/qapi-events-qom.h
 create mode 100644 build/qapi/qapi-events-replay.h
 create mode 100644 build/qapi/qapi-events-rocker.h
 create mode 100644 build/qapi/qapi-events-run-state.h
 create mode 100644 build/qapi/qapi-events-sockets.h
 create mode 100644 build/qapi/qapi-events-stats.h
 create mode 100644 build/qapi/qapi-events-tpm.h
 create mode 100644 build/qapi/qapi-events-trace.h
 create mode 100644 build/qapi/qapi-events-transaction.h
 create mode 100644 build/qapi/qapi-events-uefi.h
 create mode 100644 build/qapi/qapi-events-ui.h
 create mode 100644 build/qapi/qapi-events-vfio.h
 create mode 100644 build/qapi/qapi-events-virtio.h
 create mode 100644 build/qapi/qapi-events-yank.h
 create mode 100644 build/qapi/qapi-events.h
 create mode 100644 build/qapi/qapi-features.h
 create mode 100644 build/qapi/qapi-init-commands.h
 create mode 100644 build/qapi/qapi-introspect.h
 create mode 100644 build/qapi/qapi-types-acpi.h
 create mode 100644 build/qapi/qapi-types-audio.h
 create mode 100644 build/qapi/qapi-types-authz.h
 create mode 100644 build/qapi/qapi-types-block-core.h
 create mode 100644 build/qapi/qapi-types-block-export.h
 create mode 100644 build/qapi/qapi-types-block.h
 create mode 100644 build/qapi/qapi-types-char.h
 create mode 100644 build/qapi/qapi-types-common.h
 create mode 100644 build/qapi/qapi-types-compat.h
 create mode 100644 build/qapi/qapi-types-control.h
 create mode 100644 build/qapi/qapi-types-crypto.h
 create mode 100644 build/qapi/qapi-types-cryptodev.h
 create mode 100644 build/qapi/qapi-types-cxl.h
 create mode 100644 build/qapi/qapi-types-dump.h
 create mode 100644 build/qapi/qapi-types-ebpf.h
 create mode 100644 build/qapi/qapi-types-error.h
 create mode 100644 build/qapi/qapi-types-introspect.h
 create mode 100644 build/qapi/qapi-types-job.h
 create mode 100644 build/qapi/qapi-types-machine-common.h
 create mode 100644 build/qapi/qapi-types-machine-target.h
 create mode 100644 build/qapi/qapi-types-machine.h
 create mode 100644 build/qapi/qapi-types-migration.h
 create mode 100644 build/qapi/qapi-types-misc-target.h
 create mode 100644 build/qapi/qapi-types-misc.h
 create mode 100644 build/qapi/qapi-types-net.h
 create mode 100644 build/qapi/qapi-types-pci.h
 create mode 100644 build/qapi/qapi-types-pragma.h
 create mode 100644 build/qapi/qapi-types-qdev.h
 create mode 100644 build/qapi/qapi-types-qom.h
 create mode 100644 build/qapi/qapi-types-replay.h
 create mode 100644 build/qapi/qapi-types-rocker.h
 create mode 100644 build/qapi/qapi-types-run-state.h
 create mode 100644 build/qapi/qapi-types-sockets.h
 create mode 100644 build/qapi/qapi-types-stats.h
 create mode 100644 build/qapi/qapi-types-tpm.h
 create mode 100644 build/qapi/qapi-types-trace.h
 create mode 100644 build/qapi/qapi-types-transaction.h
 create mode 100644 build/qapi/qapi-types-uefi.h
 create mode 100644 build/qapi/qapi-types-ui.h
 create mode 100644 build/qapi/qapi-types-vfio.h
 create mode 100644 build/qapi/qapi-types-virtio.h
 create mode 100644 build/qapi/qapi-types-yank.h
 create mode 100644 build/qapi/qapi-types.h
 create mode 100644 build/qapi/qapi-visit-acpi.h
 create mode 100644 build/qapi/qapi-visit-audio.h
 create mode 100644 build/qapi/qapi-visit-authz.h
 create mode 100644 build/qapi/qapi-visit-block-core.h
 create mode 100644 build/qapi/qapi-visit-block-export.h
 create mode 100644 build/qapi/qapi-visit-block.h
 create mode 100644 build/qapi/qapi-visit-char.h
 create mode 100644 build/qapi/qapi-visit-common.h
 create mode 100644 build/qapi/qapi-visit-compat.h
 create mode 100644 build/qapi/qapi-visit-control.h
 create mode 100644 build/qapi/qapi-visit-crypto.h
 create mode 100644 build/qapi/qapi-visit-cryptodev.h
 create mode 100644 build/qapi/qapi-visit-cxl.h
 create mode 100644 build/qapi/qapi-visit-dump.h
 create mode 100644 build/qapi/qapi-visit-ebpf.h
 create mode 100644 build/qapi/qapi-visit-error.h
 create mode 100644 build/qapi/qapi-visit-introspect.h
 create mode 100644 build/qapi/qapi-visit-job.h
 create mode 100644 build/qapi/qapi-visit-machine-common.h
 create mode 100644 build/qapi/qapi-visit-machine-target.h
 create mode 100644 build/qapi/qapi-visit-machine.h
 create mode 100644 build/qapi/qapi-visit-migration.h
 create mode 100644 build/qapi/qapi-visit-misc-target.h
 create mode 100644 build/qapi/qapi-visit-misc.h
 create mode 100644 build/qapi/qapi-visit-net.h
 create mode 100644 build/qapi/qapi-visit-pci.h
 create mode 100644 build/qapi/qapi-visit-pragma.h
 create mode 100644 build/qapi/qapi-visit-qdev.h
 create mode 100644 build/qapi/qapi-visit-qom.h
 create mode 100644 build/qapi/qapi-visit-replay.h
 create mode 100644 build/qapi/qapi-visit-rocker.h
 create mode 100644 build/qapi/qapi-visit-run-state.h
 create mode 100644 build/qapi/qapi-visit-sockets.h
 create mode 100644 build/qapi/qapi-visit-stats.h
 create mode 100644 build/qapi/qapi-visit-tpm.h
 create mode 100644 build/qapi/qapi-visit-trace.h
 create mode 100644 build/qapi/qapi-visit-transaction.h
 create mode 100644 build/qapi/qapi-visit-uefi.h
 create mode 100644 build/qapi/qapi-visit-ui.h
 create mode 100644 build/qapi/qapi-visit-vfio.h
 create mode 100644 build/qapi/qapi-visit-virtio.h
 create mode 100644 build/qapi/qapi-visit-yank.h
 create mode 100644 build/qapi/qapi-visit.h
 create mode 100644 build/qapi/qapi-builtin-types.c
 create mode 100644 build/qapi/qapi-builtin-visit.c
 create mode 100644 build/qapi/qapi-commands-acpi.c
 create mode 100644 build/qapi/qapi-commands-audio.c
 create mode 100644 build/qapi/qapi-commands-authz.c
 create mode 100644 build/qapi/qapi-commands-block-core.c
 create mode 100644 build/qapi/qapi-commands-block-export.c
 create mode 100644 build/qapi/qapi-commands-block.c
 create mode 100644 build/qapi/qapi-commands-char.c
 create mode 100644 build/qapi/qapi-commands-common.c
 create mode 100644 build/qapi/qapi-commands-compat.c
 create mode 100644 build/qapi/qapi-commands-control.c
 create mode 100644 build/qapi/qapi-commands-crypto.c
 create mode 100644 build/qapi/qapi-commands-cryptodev.c
 create mode 100644 build/qapi/qapi-commands-cxl.c
 create mode 100644 build/qapi/qapi-commands-dump.c
 create mode 100644 build/qapi/qapi-commands-ebpf.c
 create mode 100644 build/qapi/qapi-commands-error.c
 create mode 100644 build/qapi/qapi-commands-introspect.c
 create mode 100644 build/qapi/qapi-commands-job.c
 create mode 100644 build/qapi/qapi-commands-machine-common.c
 create mode 100644 build/qapi/qapi-commands-machine-target.c
 create mode 100644 build/qapi/qapi-commands-machine.c
 create mode 100644 build/qapi/qapi-commands-migration.c
 create mode 100644 build/qapi/qapi-commands-misc-target.c
 create mode 100644 build/qapi/qapi-commands-misc.c
 create mode 100644 build/qapi/qapi-commands-net.c
 create mode 100644 build/qapi/qapi-commands-pci.c
 create mode 100644 build/qapi/qapi-commands-pragma.c
 create mode 100644 build/qapi/qapi-commands-qdev.c
 create mode 100644 build/qapi/qapi-commands-qom.c
 create mode 100644 build/qapi/qapi-commands-replay.c
 create mode 100644 build/qapi/qapi-commands-rocker.c
 create mode 100644 build/qapi/qapi-commands-run-state.c
 create mode 100644 build/qapi/qapi-commands-sockets.c
 create mode 100644 build/qapi/qapi-commands-stats.c
 create mode 100644 build/qapi/qapi-commands-tpm.c
 create mode 100644 build/qapi/qapi-commands-trace.c
 create mode 100644 build/qapi/qapi-commands-transaction.c
 create mode 100644 build/qapi/qapi-commands-uefi.c
 create mode 100644 build/qapi/qapi-commands-ui.c
 create mode 100644 build/qapi/qapi-commands-vfio.c
 create mode 100644 build/qapi/qapi-commands-virtio.c
 create mode 100644 build/qapi/qapi-commands-yank.c
 create mode 100644 build/qapi/qapi-commands.c
 create mode 100644 build/qapi/qapi-emit-events.c
 create mode 100644 build/qapi/qapi-events-acpi.c
 create mode 100644 build/qapi/qapi-events-audio.c
 create mode 100644 build/qapi/qapi-events-authz.c
 create mode 100644 build/qapi/qapi-events-block-core.c
 create mode 100644 build/qapi/qapi-events-block-export.c
 create mode 100644 build/qapi/qapi-events-block.c
 create mode 100644 build/qapi/qapi-events-char.c
 create mode 100644 build/qapi/qapi-events-common.c
 create mode 100644 build/qapi/qapi-events-compat.c
 create mode 100644 build/qapi/qapi-events-control.c
 create mode 100644 build/qapi/qapi-events-crypto.c
 create mode 100644 build/qapi/qapi-events-cryptodev.c
 create mode 100644 build/qapi/qapi-events-cxl.c
 create mode 100644 build/qapi/qapi-events-dump.c
 create mode 100644 build/qapi/qapi-events-ebpf.c
 create mode 100644 build/qapi/qapi-events-error.c
 create mode 100644 build/qapi/qapi-events-introspect.c
 create mode 100644 build/qapi/qapi-events-job.c
 create mode 100644 build/qapi/qapi-events-machine-common.c
 create mode 100644 build/qapi/qapi-events-machine-target.c
 create mode 100644 build/qapi/qapi-events-machine.c
 create mode 100644 build/qapi/qapi-events-migration.c
 create mode 100644 build/qapi/qapi-events-misc-target.c
 create mode 100644 build/qapi/qapi-events-misc.c
 create mode 100644 build/qapi/qapi-events-net.c
 create mode 100644 build/qapi/qapi-events-pci.c
 create mode 100644 build/qapi/qapi-events-pragma.c
 create mode 100644 build/qapi/qapi-events-qdev.c
 create mode 100644 build/qapi/qapi-events-qom.c
 create mode 100644 build/qapi/qapi-events-replay.c
 create mode 100644 build/qapi/qapi-events-rocker.c
 create mode 100644 build/qapi/qapi-events-run-state.c
 create mode 100644 build/qapi/qapi-events-sockets.c
 create mode 100644 build/qapi/qapi-events-stats.c
 create mode 100644 build/qapi/qapi-events-tpm.c
 create mode 100644 build/qapi/qapi-events-trace.c
 create mode 100644 build/qapi/qapi-events-transaction.c
 create mode 100644 build/qapi/qapi-events-uefi.c
 create mode 100644 build/qapi/qapi-events-ui.c
 create mode 100644 build/qapi/qapi-events-vfio.c
 create mode 100644 build/qapi/qapi-events-virtio.c
 create mode 100644 build/qapi/qapi-events-yank.c
 create mode 100644 build/qapi/qapi-events.c
 create mode 100644 build/qapi/qapi-features.c
 create mode 100644 build/qapi/qapi-init-commands.c
 create mode 100644 build/qapi/qapi-introspect.c
 create mode 100644 build/qapi/qapi-types-acpi.c
 create mode 100644 build/qapi/qapi-types-audio.c
 create mode 100644 build/qapi/qapi-types-authz.c
 create mode 100644 build/qapi/qapi-types-block-core.c
 create mode 100644 build/qapi/qapi-types-block-export.c
 create mode 100644 build/qapi/qapi-types-block.c
 create mode 100644 build/qapi/qapi-types-char.c
 create mode 100644 build/qapi/qapi-types-common.c
 create mode 100644 build/qapi/qapi-types-compat.c
 create mode 100644 build/qapi/qapi-types-control.c
 create mode 100644 build/qapi/qapi-types-crypto.c
 create mode 100644 build/qapi/qapi-types-cryptodev.c
 create mode 100644 build/qapi/qapi-types-cxl.c
 create mode 100644 build/qapi/qapi-types-dump.c
 create mode 100644 build/qapi/qapi-types-ebpf.c
 create mode 100644 build/qapi/qapi-types-error.c
 create mode 100644 build/qapi/qapi-types-introspect.c
 create mode 100644 build/qapi/qapi-types-job.c
 create mode 100644 build/qapi/qapi-types-machine-common.c
 create mode 100644 build/qapi/qapi-types-machine-target.c
 create mode 100644 build/qapi/qapi-types-machine.c
 create mode 100644 build/qapi/qapi-types-migration.c
 create mode 100644 build/qapi/qapi-types-misc-target.c
 create mode 100644 build/qapi/qapi-types-misc.c
 create mode 100644 build/qapi/qapi-types-net.c
 create mode 100644 build/qapi/qapi-types-pci.c
 create mode 100644 build/qapi/qapi-types-pragma.c
 create mode 100644 build/qapi/qapi-types-qdev.c
 create mode 100644 build/qapi/qapi-types-qom.c
 create mode 100644 build/qapi/qapi-types-replay.c
 create mode 100644 build/qapi/qapi-types-rocker.c
 create mode 100644 build/qapi/qapi-types-run-state.c
 create mode 100644 build/qapi/qapi-types-sockets.c
 create mode 100644 build/qapi/qapi-types-stats.c
 create mode 100644 build/qapi/qapi-types-tpm.c
 create mode 100644 build/qapi/qapi-types-trace.c
 create mode 100644 build/qapi/qapi-types-transaction.c
 create mode 100644 build/qapi/qapi-types-uefi.c
 create mode 100644 build/qapi/qapi-types-ui.c
 create mode 100644 build/qapi/qapi-types-vfio.c
 create mode 100644 build/qapi/qapi-types-virtio.c
 create mode 100644 build/qapi/qapi-types-yank.c
 create mode 100644 build/qapi/qapi-types.c
 create mode 100644 build/qapi/qapi-visit-acpi.c
 create mode 100644 build/qapi/qapi-visit-audio.c
 create mode 100644 build/qapi/qapi-visit-authz.c
 create mode 100644 build/qapi/qapi-visit-block-core.c
 create mode 100644 build/qapi/qapi-visit-block-export.c
 create mode 100644 build/qapi/qapi-visit-block.c
 create mode 100644 build/qapi/qapi-visit-char.c
 create mode 100644 build/qapi/qapi-visit-common.c
 create mode 100644 build/qapi/qapi-visit-compat.c
 create mode 100644 build/qapi/qapi-visit-control.c
 create mode 100644 build/qapi/qapi-visit-crypto.c
 create mode 100644 build/qapi/qapi-visit-cryptodev.c
 create mode 100644 build/qapi/qapi-visit-cxl.c
 create mode 100644 build/qapi/qapi-visit-dump.c
 create mode 100644 build/qapi/qapi-visit-ebpf.c
 create mode 100644 build/qapi/qapi-visit-error.c
 create mode 100644 build/qapi/qapi-visit-introspect.c
 create mode 100644 build/qapi/qapi-visit-job.c
 create mode 100644 build/qapi/qapi-visit-machine-common.c
 create mode 100644 build/qapi/qapi-visit-machine-target.c
 create mode 100644 build/qapi/qapi-visit-machine.c
 create mode 100644 build/qapi/qapi-visit-migration.c
 create mode 100644 build/qapi/qapi-visit-misc-target.c
 create mode 100644 build/qapi/qapi-visit-misc.c
 create mode 100644 build/qapi/qapi-visit-net.c
 create mode 100644 build/qapi/qapi-visit-pci.c
 create mode 100644 build/qapi/qapi-visit-pragma.c
 create mode 100644 build/qapi/qapi-visit-qdev.c
 create mode 100644 build/qapi/qapi-visit-qom.c
 create mode 100644 build/qapi/qapi-visit-replay.c
 create mode 100644 build/qapi/qapi-visit-rocker.c
 create mode 100644 build/qapi/qapi-visit-run-state.c
 create mode 100644 build/qapi/qapi-visit-sockets.c
 create mode 100644 build/qapi/qapi-visit-stats.c
 create mode 100644 build/qapi/qapi-visit-tpm.c
 create mode 100644 build/qapi/qapi-visit-trace.c
 create mode 100644 build/qapi/qapi-visit-transaction.c
 create mode 100644 build/qapi/qapi-visit-uefi.c
 create mode 100644 build/qapi/qapi-visit-ui.c
 create mode 100644 build/qapi/qapi-visit-vfio.c
 create mode 100644 build/qapi/qapi-visit-virtio.c
 create mode 100644 build/qapi/qapi-visit-yank.c
 create mode 100644 build/qapi/qapi-visit.c
 create mode 100644 qapi/commands-weak-stubs.c
 create mode 100644 build/qapi/qapi-commands-acpi.trace-events
 create mode 100644 build/qapi/qapi-commands-audio.trace-events
 create mode 100644 build/qapi/qapi-commands-authz.trace-events
 create mode 100644 build/qapi/qapi-commands-block-core.trace-events
 create mode 100644 build/qapi/qapi-commands-block-export.trace-events
 create mode 100644 build/qapi/qapi-commands-block.trace-events
 create mode 100644 build/qapi/qapi-commands-char.trace-events
 create mode 100644 build/qapi/qapi-commands-common.trace-events
 create mode 100644 build/qapi/qapi-commands-compat.trace-events
 create mode 100644 build/qapi/qapi-commands-control.trace-events
 create mode 100644 build/qapi/qapi-commands-crypto.trace-events
 create mode 100644 build/qapi/qapi-commands-cryptodev.trace-events
 create mode 100644 build/qapi/qapi-commands-cxl.trace-events
 create mode 100644 build/qapi/qapi-commands-dump.trace-events
 create mode 100644 build/qapi/qapi-commands-ebpf.trace-events
 create mode 100644 build/qapi/qapi-commands-error.trace-events
 create mode 100644 build/qapi/qapi-commands-introspect.trace-events
 create mode 100644 build/qapi/qapi-commands-job.trace-events
 create mode 100644 build/qapi/qapi-commands-machine-common.trace-events
 create mode 100644 build/qapi/qapi-commands-machine-target.trace-events
 create mode 100644 build/qapi/qapi-commands-machine.trace-events
 create mode 100644 build/qapi/qapi-commands-migration.trace-events
 create mode 100644 build/qapi/qapi-commands-misc-target.trace-events
 create mode 100644 build/qapi/qapi-commands-misc.trace-events
 create mode 100644 build/qapi/qapi-commands-net.trace-events
 create mode 100644 build/qapi/qapi-commands-pci.trace-events
 create mode 100644 build/qapi/qapi-commands-pragma.trace-events
 create mode 100644 build/qapi/qapi-commands-qdev.trace-events
 create mode 100644 build/qapi/qapi-commands-qom.trace-events
 create mode 100644 build/qapi/qapi-commands-replay.trace-events
 create mode 100644 build/qapi/qapi-commands-rocker.trace-events
 create mode 100644 build/qapi/qapi-commands-run-state.trace-events
 create mode 100644 build/qapi/qapi-commands-sockets.trace-events
 create mode 100644 build/qapi/qapi-commands-stats.trace-events
 create mode 100644 build/qapi/qapi-commands-tpm.trace-events
 create mode 100644 build/qapi/qapi-commands-trace.trace-events
 create mode 100644 build/qapi/qapi-commands-transaction.trace-events
 create mode 100644 build/qapi/qapi-commands-uefi.trace-events
 create mode 100644 build/qapi/qapi-commands-ui.trace-events
 create mode 100644 build/qapi/qapi-commands-vfio.trace-events
 create mode 100644 build/qapi/qapi-commands-virtio.trace-events
 create mode 100644 build/qapi/qapi-commands-yank.trace-events
 create mode 100644 build/qapi/qapi-commands.trace-events
 create mode 100644 build/qapi/qapi-init-commands.trace-events

-- 
2.47.2


