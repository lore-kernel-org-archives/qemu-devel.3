Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C115C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNW-0000cR-GW; Thu, 15 May 2025 13:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcNA-0000Bs-PQ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN3-00027C-UK
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:54 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74251cb4a05so1780724b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330068; x=1747934868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/S75VeLd87oNOjUDzY2CVsW9grPZWTzktC5dbrQ243M=;
 b=chu6WrkOzc8S+a9rwu9WSpk1v6sMvEEugoSgOnguw19kEugVlNM8fOQBHuf2uY7jDh
 C+qX6X+H0ogqUK/FrbFn4U9ZjWF5WG4SAuPLm67KdrHxYgUyZocUsQutI/xh7g8BU1Hp
 J4+0gbPN6qPbtZH6GfwlQfIubWBQ+77FIYxgRNhV1QCMEgDWjhqJGs37T9c4N7NALngM
 d+FLF5GdopeU4E1aGnMOgPQcAxxkTTrmWGaWXHwXA6u4dhZCAsbOqsD+56HL0gXakyMD
 whZHoQAq1FkdkXLYlG1SNNkR6P1wDfuaopYIg059+HQuhS2SRJ4ByCIAHYeKt2fceq6v
 2D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330068; x=1747934868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/S75VeLd87oNOjUDzY2CVsW9grPZWTzktC5dbrQ243M=;
 b=AR3StmvyaHKOnWbNmQtVDnTMacH8V3fkN90rEsXiISCZtupu/r66gq4l0CTN0n1E6g
 7nbDrnaGKC+smYVtvRD1sigj/alWho1CBkKBXkrO3fc5XVlft3zUNvXkcG8wr8gKFLdC
 cKjBu4e9LtJ0aejvPia8wESnJNUZkEPvFgo02Y/zszyym6eMuWzsnACr4UXY0BN0rWdC
 Va0CgNCn89No7iaro87UUY5dvOnhSY7CAAk4CRR9mkVvhjkWI+ppzEnarLyXdUBjzzPf
 ryq1PdrS7Z7hkFT7jjICRJUWIw0voK/HPCm/D5sd/EXgambffLkFt3M3qhDgR5dv+2Vu
 X+Vg==
X-Gm-Message-State: AOJu0YxyQ04OpV6uYSOYrTqsJhy2b9EI+IGB3KAuoSesogtbTJdO/+5s
 XVgZJ1FnaR6cXkZwkmGl+yCHut50BEuIrJRBQ7RlVe8KJhASq8jRrmH9ta4jov27rs6MtAEpC8o
 wLDOt
X-Gm-Gg: ASbGncutmb7EZu258te5hYouMvLRp0fRSY53hB8wNe3j8MNY/EyVS4QmWj5h+pkhTWm
 mqGT48vqOlFseLoXHdC8MMxnJ3SjmYCe2M/s9CRxCAw6eivEb36o2TK+GPlXKp97h9kIhJG9cTc
 Sj/i86GLy4k2WWFTt7t+bAiwMv26ta5cuFEJhgbSkanjm2NJPut65z/MiMk3La+L5IqZTttyWcx
 EW3dG4MsxHeKbFZPXPraPXOThfoH3pNL1y4z9StjGn6Jab5CrAZdpSSnUlI4OGLtmIvTVkLhQLq
 2042QfCMokJ88gBPqk/BdgquMHqzh/JR43sjQE6zTR4g9ZHzck0=
X-Google-Smtp-Source: AGHT+IEZcz9GSOZGv6WMPLPEsF3XeNe8fLjx6qBax4B0yytd83vO9rehjCPl3t5sTnvXRYpZij+tEg==
X-Received: by 2002:a05:6a00:1797:b0:736:6043:69f9 with SMTP id
 d2e1a72fcca58-742a98abc88mr240521b3a.19.1747330067544; 
 Thu, 15 May 2025 10:27:47 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/12] qapi: make most CPU commands unconditionally
 available
Date: Thu, 15 May 2025 10:27:29 -0700
Message-ID: <20250515172732.3992504-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_* conditions from all the CPU commands
that are conceptually target independent. Top level stubs are
provided to cope with targets which do not currently implement
all of the commands.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                           |   1 -
 qapi/machine-target.json              | 522 --------------------------
 qapi/machine.json                     | 363 ++++++++++++++++++
 stubs/monitor-cpu-s390x.c             |  23 ++
 stubs/monitor-cpu.c                   |  21 ++
 target/arm/arm-qmp-cmds.c             |   2 +-
 target/i386/cpu-system.c              |   2 +-
 target/i386/cpu.c                     |   2 +-
 target/loongarch/loongarch-qmp-cmds.c |   2 +-
 target/mips/system/mips-qmp-cmds.c    |  12 +-
 target/ppc/ppc-qmp-cmds.c             |  12 +-
 target/riscv/riscv-qmp-cmds.c         |   2 +-
 target/s390x/cpu_models_system.c      |   2 +-
 stubs/meson.build                     |   2 +
 14 files changed, 437 insertions(+), 531 deletions(-)
 delete mode 100644 qapi/machine-target.json
 create mode 100644 stubs/monitor-cpu-s390x.c
 create mode 100644 stubs/monitor-cpu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 476dcb46683..c2a6e6d1c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1927,7 +1927,6 @@ F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
 F: qapi/machine-common.json
-F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
deleted file mode 100644
index e153291a7fc..00000000000
--- a/qapi/machine-target.json
+++ /dev/null
@@ -1,522 +0,0 @@
-# -*- Mode: Python -*-
-# vim: filetype=python
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or later.
-# See the COPYING file in the top-level directory.
-
-{ 'include': 'machine-common.json' }
-
-##
-# @CpuModelInfo:
-#
-# Virtual CPU model.
-#
-# A CPU model consists of the name of a CPU definition, to which delta
-# changes are applied (e.g. features added/removed).  Most magic
-# values that an architecture might require should be hidden behind
-# the name.  However, if required, architectures can expose relevant
-# properties.
-#
-# @name: the name of the CPU definition the model is based on
-#
-# @props: a dictionary of QOM properties to be applied
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelInfo',
-  'data': { 'name': 'str',
-            '*props': 'any' } }
-
-##
-# @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
-#
-# @static: Expand to a static CPU model, a combination of a static
-#     base model name and property delta changes.  As the static base
-#     model will never change, the expanded CPU model will be the
-#     same, independent of QEMU version, machine type, machine
-#     options, and accelerator options.  Therefore, the resulting
-#     model can be used by tooling without having to specify a
-#     compatibility machine - e.g. when displaying the "host" model.
-#     The @static CPU models are migration-safe.
-#
-# @full: Expand all properties.  The produced model is not guaranteed
-#     to be migration-safe, but allows tooling to get an insight and
-#     work with model details.
-#
-# .. note:: When a non-migration-safe CPU model is expanded in static
-#    mode, some features enabled by the CPU model may be omitted,
-#    because they can't be implemented by a static CPU model
-#    definition (e.g. cache info passthrough and PMU passthrough in
-#    x86).  If you need an accurate representation of the features
-#    enabled by a non-migration-safe CPU model, use @full.  If you
-#    need a static representation that will keep ABI compatibility
-#    even when changing QEMU version or machine-type, use @static (but
-#    keep in mind that some features may be omitted).
-#
-# Since: 2.8
-##
-{ 'enum': 'CpuModelExpansionType',
-  'data': [ 'static', 'full' ] }
-
-##
-# @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g. CPU features or CPU generations.
-#
-# @incompatible: If model A is incompatible to model B, model A is not
-#     guaranteed to run where model B runs and the other way around.
-#
-# @identical: If model A is identical to model B, model A is
-#     guaranteed to run where model B runs and the other way around.
-#
-# @superset: If model A is a superset of model B, model B is
-#     guaranteed to run where model A runs.  There are no guarantees
-#     about the other way.
-#
-# @subset: If model A is a subset of model B, model A is guaranteed to
-#     run where model B runs.  There are no guarantees about the other
-#     way.
-#
-# Since: 2.8
-##
-{ 'enum': 'CpuModelCompareResult',
-  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
-
-##
-# @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
-#
-# @model: the baselined CpuModelInfo.
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelBaselineInfo',
-  'data': { 'model': 'CpuModelInfo' },
-  'if': 'TARGET_S390X' }
-
-##
-# @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
-#
-# @result: The result of the compare operation.
-#
-# @responsible-properties: List of properties that led to the
-#     comparison result not being identical.
-#
-# @responsible-properties is a list of QOM property names that led to
-# both CPUs not being detected as identical.  For identical models,
-# this list is empty.  If a QOM property is read-only, that means
-# there's no known way to make the CPU models identical.  If the
-# special property name "type" is included, the models are by
-# definition not identical and cannot be made identical.
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelCompareInfo',
-  'data': { 'result': 'CpuModelCompareResult',
-            'responsible-properties': ['str'] },
-  'if': 'TARGET_S390X' }
-
-##
-# @query-cpu-model-comparison:
-#
-# Compares two CPU models, @modela and @modelb, returning how they
-# compare in a specific configuration.  The results indicates how
-# both models compare regarding runnability.  This result can be
-# used by tooling to make decisions if a certain CPU model will
-# run in a certain configuration or if a compatible CPU model has
-# to be created by baselining.
-#
-# Usually, a CPU model is compared against the maximum possible CPU
-# model of a certain configuration (e.g. the "host" model for KVM).
-# If that CPU model is identical or a subset, it will run in that
-# configuration.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU
-#   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine-type: CPU model may look different depending on the
-#   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine options (including accelerator): in some architectures,
-#   CPU models may look different depending on machine and accelerator
-#   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu
-#   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support comparing CPU models.  s390x
-# supports comparing CPU models.
-#
-# @modela: description of the first CPU model to compare, referred to
-#     as "model A" in CpuModelCompareResult
-#
-# @modelb: description of the second CPU model to compare, referred to
-#     as "model B" in CpuModelCompareResult
-#
-# Returns: a CpuModelCompareInfo describing how both CPU models
-#     compare
-#
-# Errors:
-#     - if comparing CPU models is not supported
-#     - if a model cannot be used
-#     - if a model contains an unknown cpu definition name, unknown
-#       properties or properties with wrong types.
-#
-# .. note:: This command isn't specific to s390x, but is only
-#    implemented on this architecture currently.
-#
-# Since: 2.8
-##
-{ 'command': 'query-cpu-model-comparison',
-  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelCompareInfo',
-  'if': 'TARGET_S390X' }
-
-##
-# @query-cpu-model-baseline:
-#
-# Baseline two CPU models, @modela and @modelb, creating a compatible
-# third model.  The created model will always be a static,
-# migration-safe CPU model (see "static" CPU model expansion for
-# details).
-#
-# This interface can be used by tooling to create a compatible CPU
-# model out two CPU models.  The created CPU model will be identical
-# to or a subset of both CPU models when comparing them.  Therefore,
-# the created CPU model is guaranteed to run where the given CPU
-# models run.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU
-#   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine-type: CPU model may look different depending on the
-#   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine options (including accelerator): in some architectures,
-#   CPU models may look different depending on machine and accelerator
-#   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu
-#   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support baselining CPU models.  s390x
-# supports baselining CPU models.
-#
-# @modela: description of the first CPU model to baseline
-#
-# @modelb: description of the second CPU model to baseline
-#
-# Returns: a CpuModelBaselineInfo describing the baselined CPU model
-#
-# Errors:
-#     - if baselining CPU models is not supported
-#     - if a model cannot be used
-#     - if a model contains an unknown cpu definition name, unknown
-#       properties or properties with wrong types.
-#
-# .. note:: This command isn't specific to s390x, but is only
-#    implemented on this architecture currently.
-#
-# Since: 2.8
-##
-{ 'command': 'query-cpu-model-baseline',
-  'data': { 'modela': 'CpuModelInfo',
-            'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelBaselineInfo',
-  'if': 'TARGET_S390X' }
-
-##
-# @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
-#
-# @model: the expanded CpuModelInfo.
-#
-# @deprecated-props: an optional list of properties that are flagged as
-#     deprecated by the CPU vendor.  The list depends on the
-#     CpuModelExpansionType: "static" properties are a subset of the
-#     enabled-properties for the expanded model; "full" properties are
-#     a set of properties that are deprecated across all models for
-#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
-#
-# Since: 2.8
-##
-{ 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo',
-            '*deprecated-props' : { 'type': ['str'] } },
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
-
-##
-# @query-cpu-model-expansion:
-#
-# Expands a given CPU model, @model, (or a combination of CPU model +
-# additional options) to different granularities, specified by @type,
-# allowing tooling to get an understanding what a specific CPU model
-# looks like in QEMU under a certain configuration.
-#
-# This interface can be used to query the "host" CPU model.
-#
-# The data returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU
-#   version.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine-type: CPU model may look different depending on the
-#   machine-type.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * machine options (including accelerator): in some architectures,
-#   CPU models may look different depending on machine and accelerator
-#   options.  (Except for CPU models reported as "static" in
-#   query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu
-#   option and global properties may affect expansion of CPU models.
-#   Using query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support all expansion types.  s390x
-# supports "full" and "static".  Arm only supports "full".
-#
-# @model: description of the CPU model to expand
-#
-# @type: expansion type, specifying how to expand the CPU model
-#
-# Returns: a CpuModelExpansionInfo describing the expanded CPU model
-#
-# Errors:
-#     - if expanding CPU models is not supported
-#     - if the model cannot be expanded
-#     - if the model contains an unknown CPU definition name, unknown
-#       properties or properties with a wrong type
-#     - if an expansion type is not supported
-#
-# Since: 2.8
-##
-{ 'command': 'query-cpu-model-expansion',
-  'data': { 'type': 'CpuModelExpansionType',
-            'model': 'CpuModelInfo' },
-  'returns': 'CpuModelExpansionInfo',
-  'if': { 'any': [ 'TARGET_S390X',
-                   'TARGET_I386',
-                   'TARGET_ARM',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
-
-##
-# @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
-#
-# @name: the name of the CPU definition
-#
-# @migration-safe: whether a CPU definition can be safely used for
-#     migration in combination with a QEMU compatibility machine when
-#     migrating between different QEMU versions and between hosts with
-#     different sets of (hardware or software) capabilities.  If not
-#     provided, information is not available and callers should not
-#     assume the CPU definition to be migration-safe.  (since 2.8)
-#
-# @static: whether a CPU definition is static and will not change
-#     depending on QEMU version, machine type, machine options and
-#     accelerator options.  A static model is always migration-safe.
-#     (since 2.8)
-#
-# @unavailable-features: List of properties that prevent the CPU model
-#     from running in the current host.  (since 2.8)
-#
-# @typename: Type name that can be used as argument to
-#     @device-list-properties, to introspect properties configurable
-#     using -cpu or -global.  (since 2.9)
-#
-# @alias-of: Name of CPU model this model is an alias for.  The target
-#     of the CPU model alias may change depending on the machine type.
-#     Management software is supposed to translate CPU model aliases
-#     in the VM configuration, because aliases may stop being
-#     migration-safe in the future (since 4.1)
-#
-# @deprecated: If true, this CPU model is deprecated and may be
-#     removed in some future version of QEMU according to the QEMU
-#     deprecation policy.  (since 5.2)
-#
-# @unavailable-features is a list of QOM property names that represent
-# CPU model attributes that prevent the CPU from running.  If the QOM
-# property is read-only, that means there's no known way to make the
-# CPU model run in the current host.  Implementations that choose not
-# to provide specific information return the property name "type".  If
-# the property is read-write, it means that it MAY be possible to run
-# the CPU model in the current host if that property is changed.
-# Management software can use it as hints to suggest or choose an
-# alternative for the user, or just to generate meaningful error
-# messages explaining why the CPU model can't be used.  If
-# @unavailable-features is an empty list, the CPU model is runnable
-# using the current host and machine-type.  If @unavailable-features
-# is not present, runnability information for the CPU is not
-# available.
-#
-# Since: 1.2
-##
-{ 'struct': 'CpuDefinitionInfo',
-  'data': { 'name': 'str',
-            '*migration-safe': 'bool',
-            'static': 'bool',
-            '*unavailable-features': [ 'str' ],
-            'typename': 'str',
-            '*alias-of' : 'str',
-            'deprecated' : 'bool' },
-  'if': { 'any': [ 'TARGET_PPC',
-                   'TARGET_ARM',
-                   'TARGET_I386',
-                   'TARGET_S390X',
-                   'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
-
-##
-# @query-cpu-definitions:
-#
-# Return a list of supported virtual CPU definitions
-#
-# Returns: a list of CpuDefinitionInfo
-#
-# Since: 1.2
-##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
-  'if': { 'any': [ 'TARGET_PPC',
-                   'TARGET_ARM',
-                   'TARGET_I386',
-                   'TARGET_S390X',
-                   'TARGET_MIPS',
-                   'TARGET_LOONGARCH64',
-                   'TARGET_RISCV' ] } }
-
-##
-# @S390CpuPolarization:
-#
-# An enumeration of CPU polarization that can be assumed by a virtual
-# S390 CPU
-#
-# Since: 8.2
-##
-{ 'enum': 'S390CpuPolarization',
-  'data': [ 'horizontal', 'vertical' ],
-  'if': 'TARGET_S390X'
-}
-
-##
-# @set-cpu-topology:
-#
-# Modify the topology by moving the CPU inside the topology tree, or
-# by changing a modifier attribute of a CPU.  Absent values will not
-# be modified.
-#
-# @core-id: the vCPU ID to be moved
-#
-# @socket-id: destination socket to move the vCPU to
-#
-# @book-id: destination book to move the vCPU to
-#
-# @drawer-id: destination drawer to move the vCPU to
-#
-# @entitlement: entitlement to set
-#
-# @dedicated: whether the provisioning of real to virtual CPU is
-#     dedicated
-#
-# Features:
-#
-# @unstable: This command is experimental.
-#
-# Since: 8.2
-##
-{ 'command': 'set-cpu-topology',
-  'data': {
-      'core-id': 'uint16',
-      '*socket-id': 'uint16',
-      '*book-id': 'uint16',
-      '*drawer-id': 'uint16',
-      '*entitlement': 'S390CpuEntitlement',
-      '*dedicated': 'bool'
-  },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
-}
-
-##
-# @CPU_POLARIZATION_CHANGE:
-#
-# Emitted when the guest asks to change the polarization.
-#
-# The guest can tell the host (via the PTF instruction) whether the
-# CPUs should be provisioned using horizontal or vertical
-# polarization.
-#
-# On horizontal polarization the host is expected to provision all
-# vCPUs equally.
-#
-# On vertical polarization the host can provision each vCPU
-# differently.  The guest will get information on the details of the
-# provisioning the next time it uses the STSI(15) instruction.
-#
-# @polarization: polarization specified by the guest
-#
-# Features:
-#
-# @unstable: This event is experimental.
-#
-# Since: 8.2
-#
-# .. qmp-example::
-#
-#     <- { "event": "CPU_POLARIZATION_CHANGE",
-#          "data": { "polarization": "horizontal" },
-#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 } }
-##
-{ 'event': 'CPU_POLARIZATION_CHANGE',
-  'data': { 'polarization': 'S390CpuPolarization' },
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
-}
-
-##
-# @CpuPolarizationInfo:
-#
-# The result of a CPU polarization query.
-#
-# @polarization: the CPU polarization
-#
-# Since: 8.2
-##
-{ 'struct': 'CpuPolarizationInfo',
-  'data': { 'polarization': 'S390CpuPolarization' },
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
-}
-
-##
-# @query-s390x-cpu-polarization:
-#
-# Features:
-#
-# @unstable: This command is experimental.
-#
-# Returns: the machine's CPU polarization
-#
-# Since: 8.2
-##
-{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarizationInfo',
-  'features': [ 'unstable' ],
-  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
-}
diff --git a/qapi/machine.json b/qapi/machine.json
index c8feb9fe17b..a357604e6d1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1916,3 +1916,366 @@
 ##
 { 'command': 'dump-skeys',
   'data': { 'filename': 'str' } }
+
+##
+# @CpuModelInfo:
+#
+# Virtual CPU model.
+#
+# A CPU model consists of the name of a CPU definition, to which delta
+# changes are applied (e.g. features added/removed).  Most magic
+# values that an architecture might require should be hidden behind
+# the name.  However, if required, architectures can expose relevant
+# properties.
+#
+# @name: the name of the CPU definition the model is based on
+#
+# @props: a dictionary of QOM properties to be applied
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelInfo',
+  'data': { 'name': 'str',
+            '*props': 'any' } }
+
+##
+# @CpuModelExpansionType:
+#
+# An enumeration of CPU model expansion types.
+#
+# @static: Expand to a static CPU model, a combination of a static
+#     base model name and property delta changes.  As the static base
+#     model will never change, the expanded CPU model will be the
+#     same, independent of QEMU version, machine type, machine
+#     options, and accelerator options.  Therefore, the resulting
+#     model can be used by tooling without having to specify a
+#     compatibility machine - e.g. when displaying the "host" model.
+#     The @static CPU models are migration-safe.
+#
+# @full: Expand all properties.  The produced model is not guaranteed
+#     to be migration-safe, but allows tooling to get an insight and
+#     work with model details.
+#
+# .. note:: When a non-migration-safe CPU model is expanded in static
+#    mode, some features enabled by the CPU model may be omitted,
+#    because they can't be implemented by a static CPU model
+#    definition (e.g. cache info passthrough and PMU passthrough in
+#    x86).  If you need an accurate representation of the features
+#    enabled by a non-migration-safe CPU model, use @full.  If you
+#    need a static representation that will keep ABI compatibility
+#    even when changing QEMU version or machine-type, use @static (but
+#    keep in mind that some features may be omitted).
+#
+# Since: 2.8
+##
+{ 'enum': 'CpuModelExpansionType',
+  'data': [ 'static', 'full' ] }
+
+##
+# @CpuModelCompareResult:
+#
+# An enumeration of CPU model comparison results.  The result is
+# usually calculated using e.g. CPU features or CPU generations.
+#
+# @incompatible: If model A is incompatible to model B, model A is not
+#     guaranteed to run where model B runs and the other way around.
+#
+# @identical: If model A is identical to model B, model A is
+#     guaranteed to run where model B runs and the other way around.
+#
+# @superset: If model A is a superset of model B, model B is
+#     guaranteed to run where model A runs.  There are no guarantees
+#     about the other way.
+#
+# @subset: If model A is a subset of model B, model A is guaranteed to
+#     run where model B runs.  There are no guarantees about the other
+#     way.
+#
+# Since: 2.8
+##
+{ 'enum': 'CpuModelCompareResult',
+  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
+
+##
+# @CpuModelBaselineInfo:
+#
+# The result of a CPU model baseline.
+#
+# @model: the baselined CpuModelInfo.
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelBaselineInfo',
+  'data': { 'model': 'CpuModelInfo' } }
+
+##
+# @CpuModelCompareInfo:
+#
+# The result of a CPU model comparison.
+#
+# @result: The result of the compare operation.
+#
+# @responsible-properties: List of properties that led to the
+#     comparison result not being identical.
+#
+# @responsible-properties is a list of QOM property names that led to
+# both CPUs not being detected as identical.  For identical models,
+# this list is empty.  If a QOM property is read-only, that means
+# there's no known way to make the CPU models identical.  If the
+# special property name "type" is included, the models are by
+# definition not identical and cannot be made identical.
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelCompareInfo',
+  'data': { 'result': 'CpuModelCompareResult',
+            'responsible-properties': ['str'] } }
+
+##
+# @query-cpu-model-comparison:
+#
+# Compares two CPU models, @modela and @modelb, returning how they
+# compare in a specific configuration.  The results indicates how
+# both models compare regarding runnability.  This result can be
+# used by tooling to make decisions if a certain CPU model will
+# run in a certain configuration or if a compatible CPU model has
+# to be created by baselining.
+#
+# Usually, a CPU model is compared against the maximum possible CPU
+# model of a certain configuration (e.g. the "host" model for KVM).
+# If that CPU model is identical or a subset, it will run in that
+# configuration.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU
+#   version.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine-type: CPU model may look different depending on the
+#   machine-type.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine options (including accelerator): in some architectures,
+#   CPU models may look different depending on machine and accelerator
+#   options.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu
+#   option and global properties may affect expansion of CPU models.
+#   Using query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support comparing CPU models.  s390x
+# supports comparing CPU models.
+#
+# @modela: description of the first CPU model to compare, referred to
+#     as "model A" in CpuModelCompareResult
+#
+# @modelb: description of the second CPU model to compare, referred to
+#     as "model B" in CpuModelCompareResult
+#
+# Returns: a CpuModelCompareInfo describing how both CPU models
+#     compare
+#
+# Errors:
+#     - if comparing CPU models is not supported by the target
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
+#
+# Since: 2.8
+##
+{ 'command': 'query-cpu-model-comparison',
+  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelCompareInfo' }
+
+##
+# @query-cpu-model-baseline:
+#
+# Baseline two CPU models, @modela and @modelb, creating a compatible
+# third model.  The created model will always be a static,
+# migration-safe CPU model (see "static" CPU model expansion for
+# details).
+#
+# This interface can be used by tooling to create a compatible CPU
+# model out two CPU models.  The created CPU model will be identical
+# to or a subset of both CPU models when comparing them.  Therefore,
+# the created CPU model is guaranteed to run where the given CPU
+# models run.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU
+#   version.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine-type: CPU model may look different depending on the
+#   machine-type.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine options (including accelerator): in some architectures,
+#   CPU models may look different depending on machine and accelerator
+#   options.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu
+#   option and global properties may affect expansion of CPU models.
+#   Using query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support baselining CPU models.  s390x
+# supports baselining CPU models.
+#
+# @modela: description of the first CPU model to baseline
+#
+# @modelb: description of the second CPU model to baseline
+#
+# Returns: a CpuModelBaselineInfo describing the baselined CPU model
+#
+# Errors:
+#     - if baselining CPU models is not supported by the target
+#     - if a model cannot be used
+#     - if a model contains an unknown cpu definition name, unknown
+#       properties or properties with wrong types.
+#
+# Since: 2.8
+##
+{ 'command': 'query-cpu-model-baseline',
+  'data': { 'modela': 'CpuModelInfo',
+            'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelBaselineInfo' }
+
+##
+# @CpuModelExpansionInfo:
+#
+# The result of a cpu model expansion.
+#
+# @model: the expanded CpuModelInfo.
+#
+# @deprecated-props: an optional list of properties that are flagged as
+#     deprecated by the CPU vendor.  The list depends on the
+#     CpuModelExpansionType: "static" properties are a subset of the
+#     enabled-properties for the expanded model; "full" properties are
+#     a set of properties that are deprecated across all models for
+#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
+#
+# Since: 2.8
+##
+{ 'struct': 'CpuModelExpansionInfo',
+  'data': { 'model': 'CpuModelInfo',
+            '*deprecated-props' : { 'type': ['str'] } } }
+
+##
+# @query-cpu-model-expansion:
+#
+# Expands a given CPU model, @model, (or a combination of CPU model +
+# additional options) to different granularities, specified by @type,
+# allowing tooling to get an understanding what a specific CPU model
+# looks like in QEMU under a certain configuration.
+#
+# This interface can be used to query the "host" CPU model.
+#
+# The data returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU
+#   version.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine-type: CPU model may look different depending on the
+#   machine-type.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * machine options (including accelerator): in some architectures,
+#   CPU models may look different depending on machine and accelerator
+#   options.  (Except for CPU models reported as "static" in
+#   query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu
+#   option and global properties may affect expansion of CPU models.
+#   Using query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support all expansion types.  s390x
+# supports "full" and "static".  Arm only supports "full".
+#
+# @model: description of the CPU model to expand
+#
+# @type: expansion type, specifying how to expand the CPU model
+#
+# Returns: a CpuModelExpansionInfo describing the expanded CPU model
+#
+# Errors:
+#     - if expanding CPU models is not supported
+#     - if the model cannot be expanded
+#     - if the model contains an unknown CPU definition name, unknown
+#       properties or properties with a wrong type
+#     - if an expansion type is not supported
+#
+# Since: 2.8
+##
+{ 'command': 'query-cpu-model-expansion',
+  'data': { 'type': 'CpuModelExpansionType',
+            'model': 'CpuModelInfo' },
+  'returns': 'CpuModelExpansionInfo' }
+
+##
+# @CpuDefinitionInfo:
+#
+# Virtual CPU definition.
+#
+# @name: the name of the CPU definition
+#
+# @migration-safe: whether a CPU definition can be safely used for
+#     migration in combination with a QEMU compatibility machine when
+#     migrating between different QEMU versions and between hosts with
+#     different sets of (hardware or software) capabilities.  If not
+#     provided, information is not available and callers should not
+#     assume the CPU definition to be migration-safe.  (since 2.8)
+#
+# @static: whether a CPU definition is static and will not change
+#     depending on QEMU version, machine type, machine options and
+#     accelerator options.  A static model is always migration-safe.
+#     (since 2.8)
+#
+# @unavailable-features: List of properties that prevent the CPU model
+#     from running in the current host.  (since 2.8)
+#
+# @typename: Type name that can be used as argument to
+#     @device-list-properties, to introspect properties configurable
+#     using -cpu or -global.  (since 2.9)
+#
+# @alias-of: Name of CPU model this model is an alias for.  The target
+#     of the CPU model alias may change depending on the machine type.
+#     Management software is supposed to translate CPU model aliases
+#     in the VM configuration, because aliases may stop being
+#     migration-safe in the future (since 4.1)
+#
+# @deprecated: If true, this CPU model is deprecated and may be
+#     removed in some future version of QEMU according to the QEMU
+#     deprecation policy.  (since 5.2)
+#
+# @unavailable-features is a list of QOM property names that represent
+# CPU model attributes that prevent the CPU from running.  If the QOM
+# property is read-only, that means there's no known way to make the
+# CPU model run in the current host.  Implementations that choose not
+# to provide specific information return the property name "type".  If
+# the property is read-write, it means that it MAY be possible to run
+# the CPU model in the current host if that property is changed.
+# Management software can use it as hints to suggest or choose an
+# alternative for the user, or just to generate meaningful error
+# messages explaining why the CPU model can't be used.  If
+# @unavailable-features is an empty list, the CPU model is runnable
+# using the current host and machine-type.  If @unavailable-features
+# is not present, runnability information for the CPU is not
+# available.
+#
+# Since: 1.2
+##
+{ 'struct': 'CpuDefinitionInfo',
+  'data': { 'name': 'str',
+            '*migration-safe': 'bool',
+            'static': 'bool',
+            '*unavailable-features': [ 'str' ],
+            'typename': 'str',
+            '*alias-of' : 'str',
+            'deprecated' : 'bool' } }
+
+##
+# @query-cpu-definitions:
+#
+# Return a list of supported virtual CPU definitions
+#
+# Returns: a list of CpuDefinitionInfo
+#
+# Since: 1.2
+##
+{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
diff --git a/stubs/monitor-cpu-s390x.c b/stubs/monitor-cpu-s390x.c
new file mode 100644
index 00000000000..71e794482b5
--- /dev/null
+++ b/stubs/monitor-cpu-s390x.c
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+
+CpuModelCompareInfo *
+qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
+                               CpuModelInfo *infob,
+                               Error **errp)
+{
+    error_setg(errp, "CPU model comparison is not supported on this target");
+    return NULL;
+}
+
+CpuModelBaselineInfo *
+qmp_query_cpu_model_baseline(CpuModelInfo *infoa,
+                             CpuModelInfo *infob,
+                             Error **errp)
+{
+    error_setg(errp, "CPU model baseline is not supported on this target");
+    return NULL;
+}
diff --git a/stubs/monitor-cpu.c b/stubs/monitor-cpu.c
new file mode 100644
index 00000000000..a8c7ee89b9d
--- /dev/null
+++ b/stubs/monitor-cpu.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    error_setg(errp, "CPU model expansion is not supported on this target");
+    return NULL;
+}
+
+CpuDefinitionInfoList *
+qmp_query_cpu_definitions(Error **errp)
+{
+    error_setg(errp, "CPU model definitions are not supported on this target");
+    return NULL;
+}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index ef18c867ca4..cca6b9722b2 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index 55f192e8193..b1494aa6740 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -24,7 +24,7 @@
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qom/qom-qobject.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 
 #include "cpu-internal.h"
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ec908d7d360..91f89919487 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -38,7 +38,7 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/reset.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 6f732d80f3f..f5f1cd0009d 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index 7340ac70ba0..d98d6623f2f 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -7,9 +7,19 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    error_setg(errp, "CPU model expansion is not supported on this target");
+    return NULL;
+}
+
 static void mips_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index a25d86a8d19..7022564604f 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -28,7 +28,8 @@
 #include "qemu/ctype.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
@@ -175,6 +176,15 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
     return -EINVAL;
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    error_setg(errp, "CPU model expansion is not supported on this target");
+    return NULL;
+}
+
 static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d0a324364dd..8ba8aa0d5f8 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qobject/qbool.h"
 #include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 4351182f720..9d84faa3c9e 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -19,7 +19,7 @@
 #include "qapi/visitor.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qobject/qdict.h"
-#include "qapi/qapi-commands-machine-target.h"
+#include "qapi/qapi-commands-machine.h"
 
 static void list_add_feat(const char *name, void *opaque);
 
diff --git a/stubs/meson.build b/stubs/meson.build
index 0ef11976a2f..3b2fad0824f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -82,6 +82,8 @@ if have_system
   stub_ss.add(files('monitor-i386-sev.c'))
   stub_ss.add(files('monitor-i386-sgx.c'))
   stub_ss.add(files('monitor-i386-xen.c'))
+  stub_ss.add(files('monitor-cpu.c'))
+  stub_ss.add(files('monitor-cpu-s390x.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


