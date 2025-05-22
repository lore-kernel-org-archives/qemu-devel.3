Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A39FC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFU-0001Dx-ME; Thu, 22 May 2025 15:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBF6-00011d-RC
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0006Tn-O5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:11 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30e5430ed0bso8228409a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940758; x=1748545558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y6R30qCsDcLMF5khuyJMZe5QuT1s3sa6vKuD4tE2yEo=;
 b=YuGz8IXuS77VnyneGz6aggdU7SJmDMFvF6KlAP2U15tNO5ApdFsNU40/ats7oJ3sI8
 aRv2l6Q9BvzecQhSmvzNHjDEE5CsH5Ai5TUKQahDZBhohitsfrCPsUykvFP/9hzSyZ+8
 eDLwgQCNYRSVnWgeYcEOTYoAGMGkUN/+A8xBwXO4jTxQ1dUncsuWWk4KWMk3pdwsYHGt
 aCbQhwAXAblfNC9F7O67f1TAfw9SXxwQNNLsfyBtt+JLSwTHc7Jl0PsVCmVQAX7H7AnV
 wwiKZILTNpgAPqnQjXJ+eS+DPG+0oPdeFvOo7Hy7KZrACb63/ercw6dEI4g6dPN7kFGl
 3opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940758; x=1748545558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6R30qCsDcLMF5khuyJMZe5QuT1s3sa6vKuD4tE2yEo=;
 b=b700ORo2NBHPuk1SSngxxlrdx0/ZE4YzULPjr+sNaBtI588JWlRGXprtwcBPoGuUGz
 f+pxytld+f0/GHDR4HmvuMhlKGWxIlQu7/TcGu+1EScpCxMN+EPLl+jL1iyNECoe/aQT
 qM/2igrFC9wvtqeN8lSjzxcY9/+Iqi6/CQcOsYy/ZpVRr+AAY9/+sJxw9DAAtPuunoZ3
 gqhOLvmDdnte8AHEJJO00NlNbe7Efa1KeL05mT9gOwAtbzDtWGIGgbg2V70N2dyAxo+3
 EQLYcC/SaubQxlD2FrJqtQ8uGyWf2ZkFGUfuURv+dSbBYj1pbaPnfaESUtncSPtlVgbd
 xR6Q==
X-Gm-Message-State: AOJu0YzQRS8JuHv4el8bkkSKGweoWYrb/PSlWcqxnfTq6webRpvC7qJe
 ULZfxAfQgTAJkLA42NQdEAQOijV38Pn9OFpv+VPPlXrh2sSMIy9X8MnkmbyOzYSRRULX7nyQsJR
 2zBL7
X-Gm-Gg: ASbGncsZl8D/EvXU8T+bhCHjDDrKBhrE62UAldaiCzOCg7v+BCp5qZ4wj712oXesvXG
 GmK0Qyg+UaDqyWxe5JKfDSGBiNpLFnDTTen94acyEBqRKyOQMdohPWsekuufjaUsx8gCgJPHRkl
 SOEMUpLnqWj65vDxuHIJTj3au95HEANXpY1kBVG22dJD2MnrCBR2gZ+YOcBgGkjK7ZF/xz09n9j
 rLXPvQkYq7Y1trHJiZ0kZ2yNCIXRn7e9+Rzv364veKKxGlqVB1U6tF9LGpViICXEKRmwE+78pUG
 yZusVQIjuyLnqTawPRpzjNhHVLbnU07XRkSBE5fTk29hRg2DrxY=
X-Google-Smtp-Source: AGHT+IGYgUJ+OufmeqdJznbzFVi55PtqQEY4HLlZ/wsQN4xbWpCBqeTe+iroORzEV2sAH3l2r/ggog==
X-Received: by 2002:a17:90b:5603:b0:2ee:9b2c:3253 with SMTP id
 98e67ed59e1d1-30e8323cd14mr35340884a91.30.1747940758003; 
 Thu, 22 May 2025 12:05:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 09/15] qapi: make most CPU commands unconditionally
 available
Date: Thu, 22 May 2025 12:05:36 -0700
Message-ID: <20250522190542.588267-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

This removes the TARGET_* conditions from all the CPU commands
that are conceptually target independent. Top level stubs are
provided to cope with targets which do not currently implement
all of the commands. Adjust the doc comments accordingly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                           |   1 -
 qapi/machine-target.json              | 397 --------------------------
 qapi/machine.json                     | 363 +++++++++++++++++++++++
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
 14 files changed, 437 insertions(+), 406 deletions(-)
 create mode 100644 stubs/monitor-cpu-s390x.c
 create mode 100644 stubs/monitor-cpu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 01684c5a3ff..9df6c818b28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1938,7 +1938,6 @@ F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
 F: qapi/machine-common.json
-F: qapi/machine-target.json
 F: include/hw/boards.h
 F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index d8dbda4b508..f19e34adaf9 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -6,403 +6,6 @@
 
 { 'include': 'machine-common.json' }
 
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
-            '*deprecated-props' : ['str'] },
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
 ##
 # @S390CpuPolarization:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index c8feb9fe17b..e6b4b2dfef8 100644
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
+            '*deprecated-props' : ['str'] } }
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
index 9689f6374e6..33afc3ec60e 100644
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


