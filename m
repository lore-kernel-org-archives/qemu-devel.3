Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FCFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 06:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGAbl-0000Pd-BG; Sat, 17 May 2025 02:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGAbg-0000PF-ST
 for qemu-devel@nongnu.org; Sat, 17 May 2025 02:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGAbc-0002Hw-MB
 for qemu-devel@nongnu.org; Sat, 17 May 2025 02:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747461664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKQ0qDqRclUtnGUPcGbhuuVpQUFz9XmgNPuGRsjmIeI=;
 b=GmuPMbTSjnuxvMckx6jkNXYB0GVc7jIo3xgGIKU2bK6xjPDWdpCewzz0BG+Xq8GsXlpPQd
 gDlPgU9DvhWERf0f8WMQ6TTjYsVGN7jjZTdis96Z9OEND1RqcW99mZa5pkn20c4odEKJSI
 4fduzMtz3PiJNaQ9sngeuwUMOPLVoN0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-0ywW3ZgNM7S7WbKo9JLq8g-1; Sat,
 17 May 2025 02:01:01 -0400
X-MC-Unique: 0ywW3ZgNM7S7WbKo9JLq8g-1
X-Mimecast-MFC-AGG-ID: 0ywW3ZgNM7S7WbKo9JLq8g_1747461660
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE0D4195608C; Sat, 17 May 2025 06:00:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3450B18003FC; Sat, 17 May 2025 06:00:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9161521E66C2; Sat, 17 May 2025 08:00:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 09/12] qapi: make most CPU commands unconditionally
 available
In-Reply-To: <20250515172732.3992504-10-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:29 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-10-pierrick.bouvier@linaro.org>
Date: Sat, 17 May 2025 08:00:56 +0200
Message-ID: <87ldqvojxj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> This removes the TARGET_* conditions from all the CPU commands
> that are conceptually target independent. Top level stubs are
> provided to cope with targets which do not currently implement
> all of the commands.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  MAINTAINERS                           |   1 -
>  qapi/machine-target.json              | 522 --------------------------
>  qapi/machine.json                     | 363 ++++++++++++++++++
>  stubs/monitor-cpu-s390x.c             |  23 ++
>  stubs/monitor-cpu.c                   |  21 ++
>  target/arm/arm-qmp-cmds.c             |   2 +-
>  target/i386/cpu-system.c              |   2 +-
>  target/i386/cpu.c                     |   2 +-
>  target/loongarch/loongarch-qmp-cmds.c |   2 +-
>  target/mips/system/mips-qmp-cmds.c    |  12 +-
>  target/ppc/ppc-qmp-cmds.c             |  12 +-
>  target/riscv/riscv-qmp-cmds.c         |   2 +-
>  target/s390x/cpu_models_system.c      |   2 +-
>  stubs/meson.build                     |   2 +
>  14 files changed, 437 insertions(+), 531 deletions(-)
>  delete mode 100644 qapi/machine-target.json
>  create mode 100644 stubs/monitor-cpu-s390x.c
>  create mode 100644 stubs/monitor-cpu.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 476dcb46683..c2a6e6d1c1c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1927,7 +1927,6 @@ F: hw/core/numa.c
>  F: hw/cpu/cluster.c
>  F: qapi/machine.json
>  F: qapi/machine-common.json
> -F: qapi/machine-target.json
>  F: include/hw/boards.h
>  F: include/hw/core/cpu.h
>  F: include/hw/cpu/cluster.h

This needs to be delayed; see below.

> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> deleted file mode 100644
> index e153291a7fc..00000000000
> --- a/qapi/machine-target.json
> +++ /dev/null
> @@ -1,522 +0,0 @@
> -# -*- Mode: Python -*-
> -# vim: filetype=3Dpython
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
> -# See the COPYING file in the top-level directory.
> -
> -{ 'include': 'machine-common.json' }
> -
> -##
> -# @CpuModelInfo:
> -#
> -# Virtual CPU model.
> -#
> -# A CPU model consists of the name of a CPU definition, to which delta
> -# changes are applied (e.g. features added/removed).  Most magic
> -# values that an architecture might require should be hidden behind
> -# the name.  However, if required, architectures can expose relevant
> -# properties.
> -#
> -# @name: the name of the CPU definition the model is based on
> -#
> -# @props: a dictionary of QOM properties to be applied
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelInfo',
> -  'data': { 'name': 'str',
> -            '*props': 'any' } }
> -
> -##
> -# @CpuModelExpansionType:
> -#
> -# An enumeration of CPU model expansion types.
> -#
> -# @static: Expand to a static CPU model, a combination of a static
> -#     base model name and property delta changes.  As the static base
> -#     model will never change, the expanded CPU model will be the
> -#     same, independent of QEMU version, machine type, machine
> -#     options, and accelerator options.  Therefore, the resulting
> -#     model can be used by tooling without having to specify a
> -#     compatibility machine - e.g. when displaying the "host" model.
> -#     The @static CPU models are migration-safe.
> -#
> -# @full: Expand all properties.  The produced model is not guaranteed
> -#     to be migration-safe, but allows tooling to get an insight and
> -#     work with model details.
> -#
> -# .. note:: When a non-migration-safe CPU model is expanded in static
> -#    mode, some features enabled by the CPU model may be omitted,
> -#    because they can't be implemented by a static CPU model
> -#    definition (e.g. cache info passthrough and PMU passthrough in
> -#    x86).  If you need an accurate representation of the features
> -#    enabled by a non-migration-safe CPU model, use @full.  If you
> -#    need a static representation that will keep ABI compatibility
> -#    even when changing QEMU version or machine-type, use @static (but
> -#    keep in mind that some features may be omitted).
> -#
> -# Since: 2.8
> -##
> -{ 'enum': 'CpuModelExpansionType',
> -  'data': [ 'static', 'full' ] }
> -
> -##
> -# @CpuModelCompareResult:
> -#
> -# An enumeration of CPU model comparison results.  The result is
> -# usually calculated using e.g. CPU features or CPU generations.
> -#
> -# @incompatible: If model A is incompatible to model B, model A is not
> -#     guaranteed to run where model B runs and the other way around.
> -#
> -# @identical: If model A is identical to model B, model A is
> -#     guaranteed to run where model B runs and the other way around.
> -#
> -# @superset: If model A is a superset of model B, model B is
> -#     guaranteed to run where model A runs.  There are no guarantees
> -#     about the other way.
> -#
> -# @subset: If model A is a subset of model B, model A is guaranteed to
> -#     run where model B runs.  There are no guarantees about the other
> -#     way.
> -#
> -# Since: 2.8
> -##
> -{ 'enum': 'CpuModelCompareResult',
> -  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
> -
> -##
> -# @CpuModelBaselineInfo:
> -#
> -# The result of a CPU model baseline.
> -#
> -# @model: the baselined CpuModelInfo.
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelBaselineInfo',
> -  'data': { 'model': 'CpuModelInfo' },
> -  'if': 'TARGET_S390X' }
> -
> -##
> -# @CpuModelCompareInfo:
> -#
> -# The result of a CPU model comparison.
> -#
> -# @result: The result of the compare operation.
> -#
> -# @responsible-properties: List of properties that led to the
> -#     comparison result not being identical.
> -#
> -# @responsible-properties is a list of QOM property names that led to
> -# both CPUs not being detected as identical.  For identical models,
> -# this list is empty.  If a QOM property is read-only, that means
> -# there's no known way to make the CPU models identical.  If the
> -# special property name "type" is included, the models are by
> -# definition not identical and cannot be made identical.
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelCompareInfo',
> -  'data': { 'result': 'CpuModelCompareResult',
> -            'responsible-properties': ['str'] },
> -  'if': 'TARGET_S390X' }
> -
> -##
> -# @query-cpu-model-comparison:
> -#
> -# Compares two CPU models, @modela and @modelb, returning how they
> -# compare in a specific configuration.  The results indicates how
> -# both models compare regarding runnability.  This result can be
> -# used by tooling to make decisions if a certain CPU model will
> -# run in a certain configuration or if a compatible CPU model has
> -# to be created by baselining.
> -#
> -# Usually, a CPU model is compared against the maximum possible CPU
> -# model of a certain configuration (e.g. the "host" model for KVM).
> -# If that CPU model is identical or a subset, it will run in that
> -# configuration.
> -#
> -# The result returned by this command may be affected by:
> -#
> -# * QEMU version: CPU models may look different depending on the QEMU
> -#   version.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine-type: CPU model may look different depending on the
> -#   machine-type.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine options (including accelerator): in some architectures,
> -#   CPU models may look different depending on machine and accelerator
> -#   options.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * "-cpu" arguments and global properties: arguments to the -cpu
> -#   option and global properties may affect expansion of CPU models.
> -#   Using query-cpu-model-expansion while using these is not advised.
> -#
> -# Some architectures may not support comparing CPU models.  s390x
> -# supports comparing CPU models.
> -#
> -# @modela: description of the first CPU model to compare, referred to
> -#     as "model A" in CpuModelCompareResult
> -#
> -# @modelb: description of the second CPU model to compare, referred to
> -#     as "model B" in CpuModelCompareResult
> -#
> -# Returns: a CpuModelCompareInfo describing how both CPU models
> -#     compare
> -#
> -# Errors:
> -#     - if comparing CPU models is not supported
> -#     - if a model cannot be used
> -#     - if a model contains an unknown cpu definition name, unknown
> -#       properties or properties with wrong types.
> -#
> -# .. note:: This command isn't specific to s390x, but is only
> -#    implemented on this architecture currently.
> -#
> -# Since: 2.8
> -##
> -{ 'command': 'query-cpu-model-comparison',
> -  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
> -  'returns': 'CpuModelCompareInfo',
> -  'if': 'TARGET_S390X' }
> -
> -##
> -# @query-cpu-model-baseline:
> -#
> -# Baseline two CPU models, @modela and @modelb, creating a compatible
> -# third model.  The created model will always be a static,
> -# migration-safe CPU model (see "static" CPU model expansion for
> -# details).
> -#
> -# This interface can be used by tooling to create a compatible CPU
> -# model out two CPU models.  The created CPU model will be identical
> -# to or a subset of both CPU models when comparing them.  Therefore,
> -# the created CPU model is guaranteed to run where the given CPU
> -# models run.
> -#
> -# The result returned by this command may be affected by:
> -#
> -# * QEMU version: CPU models may look different depending on the QEMU
> -#   version.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine-type: CPU model may look different depending on the
> -#   machine-type.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine options (including accelerator): in some architectures,
> -#   CPU models may look different depending on machine and accelerator
> -#   options.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * "-cpu" arguments and global properties: arguments to the -cpu
> -#   option and global properties may affect expansion of CPU models.
> -#   Using query-cpu-model-expansion while using these is not advised.
> -#
> -# Some architectures may not support baselining CPU models.  s390x
> -# supports baselining CPU models.
> -#
> -# @modela: description of the first CPU model to baseline
> -#
> -# @modelb: description of the second CPU model to baseline
> -#
> -# Returns: a CpuModelBaselineInfo describing the baselined CPU model
> -#
> -# Errors:
> -#     - if baselining CPU models is not supported
> -#     - if a model cannot be used
> -#     - if a model contains an unknown cpu definition name, unknown
> -#       properties or properties with wrong types.
> -#
> -# .. note:: This command isn't specific to s390x, but is only
> -#    implemented on this architecture currently.
> -#
> -# Since: 2.8
> -##
> -{ 'command': 'query-cpu-model-baseline',
> -  'data': { 'modela': 'CpuModelInfo',
> -            'modelb': 'CpuModelInfo' },
> -  'returns': 'CpuModelBaselineInfo',
> -  'if': 'TARGET_S390X' }
> -
> -##
> -# @CpuModelExpansionInfo:
> -#
> -# The result of a cpu model expansion.
> -#
> -# @model: the expanded CpuModelInfo.
> -#
> -# @deprecated-props: an optional list of properties that are flagged as
> -#     deprecated by the CPU vendor.  The list depends on the
> -#     CpuModelExpansionType: "static" properties are a subset of the
> -#     enabled-properties for the expanded model; "full" properties are
> -#     a set of properties that are deprecated across all models for
> -#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
> -#
> -# Since: 2.8
> -##
> -{ 'struct': 'CpuModelExpansionInfo',
> -  'data': { 'model': 'CpuModelInfo',
> -            '*deprecated-props' : { 'type': ['str'] } },
> -  'if': { 'any': [ 'TARGET_S390X',
> -                   'TARGET_I386',
> -                   'TARGET_ARM',
> -                   'TARGET_LOONGARCH64',
> -                   'TARGET_RISCV' ] } }
> -
> -##
> -# @query-cpu-model-expansion:
> -#
> -# Expands a given CPU model, @model, (or a combination of CPU model +
> -# additional options) to different granularities, specified by @type,
> -# allowing tooling to get an understanding what a specific CPU model
> -# looks like in QEMU under a certain configuration.
> -#
> -# This interface can be used to query the "host" CPU model.
> -#
> -# The data returned by this command may be affected by:
> -#
> -# * QEMU version: CPU models may look different depending on the QEMU
> -#   version.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine-type: CPU model may look different depending on the
> -#   machine-type.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * machine options (including accelerator): in some architectures,
> -#   CPU models may look different depending on machine and accelerator
> -#   options.  (Except for CPU models reported as "static" in
> -#   query-cpu-definitions.)
> -# * "-cpu" arguments and global properties: arguments to the -cpu
> -#   option and global properties may affect expansion of CPU models.
> -#   Using query-cpu-model-expansion while using these is not advised.
> -#
> -# Some architectures may not support all expansion types.  s390x
> -# supports "full" and "static".  Arm only supports "full".
> -#
> -# @model: description of the CPU model to expand
> -#
> -# @type: expansion type, specifying how to expand the CPU model
> -#
> -# Returns: a CpuModelExpansionInfo describing the expanded CPU model
> -#
> -# Errors:
> -#     - if expanding CPU models is not supported
> -#     - if the model cannot be expanded
> -#     - if the model contains an unknown CPU definition name, unknown
> -#       properties or properties with a wrong type
> -#     - if an expansion type is not supported
> -#
> -# Since: 2.8
> -##
> -{ 'command': 'query-cpu-model-expansion',
> -  'data': { 'type': 'CpuModelExpansionType',
> -            'model': 'CpuModelInfo' },
> -  'returns': 'CpuModelExpansionInfo',
> -  'if': { 'any': [ 'TARGET_S390X',
> -                   'TARGET_I386',
> -                   'TARGET_ARM',
> -                   'TARGET_LOONGARCH64',
> -                   'TARGET_RISCV' ] } }
> -
> -##
> -# @CpuDefinitionInfo:
> -#
> -# Virtual CPU definition.
> -#
> -# @name: the name of the CPU definition
> -#
> -# @migration-safe: whether a CPU definition can be safely used for
> -#     migration in combination with a QEMU compatibility machine when
> -#     migrating between different QEMU versions and between hosts with
> -#     different sets of (hardware or software) capabilities.  If not
> -#     provided, information is not available and callers should not
> -#     assume the CPU definition to be migration-safe.  (since 2.8)
> -#
> -# @static: whether a CPU definition is static and will not change
> -#     depending on QEMU version, machine type, machine options and
> -#     accelerator options.  A static model is always migration-safe.
> -#     (since 2.8)
> -#
> -# @unavailable-features: List of properties that prevent the CPU model
> -#     from running in the current host.  (since 2.8)
> -#
> -# @typename: Type name that can be used as argument to
> -#     @device-list-properties, to introspect properties configurable
> -#     using -cpu or -global.  (since 2.9)
> -#
> -# @alias-of: Name of CPU model this model is an alias for.  The target
> -#     of the CPU model alias may change depending on the machine type.
> -#     Management software is supposed to translate CPU model aliases
> -#     in the VM configuration, because aliases may stop being
> -#     migration-safe in the future (since 4.1)
> -#
> -# @deprecated: If true, this CPU model is deprecated and may be
> -#     removed in some future version of QEMU according to the QEMU
> -#     deprecation policy.  (since 5.2)
> -#
> -# @unavailable-features is a list of QOM property names that represent
> -# CPU model attributes that prevent the CPU from running.  If the QOM
> -# property is read-only, that means there's no known way to make the
> -# CPU model run in the current host.  Implementations that choose not
> -# to provide specific information return the property name "type".  If
> -# the property is read-write, it means that it MAY be possible to run
> -# the CPU model in the current host if that property is changed.
> -# Management software can use it as hints to suggest or choose an
> -# alternative for the user, or just to generate meaningful error
> -# messages explaining why the CPU model can't be used.  If
> -# @unavailable-features is an empty list, the CPU model is runnable
> -# using the current host and machine-type.  If @unavailable-features
> -# is not present, runnability information for the CPU is not
> -# available.
> -#
> -# Since: 1.2
> -##
> -{ 'struct': 'CpuDefinitionInfo',
> -  'data': { 'name': 'str',
> -            '*migration-safe': 'bool',
> -            'static': 'bool',
> -            '*unavailable-features': [ 'str' ],
> -            'typename': 'str',
> -            '*alias-of' : 'str',
> -            'deprecated' : 'bool' },
> -  'if': { 'any': [ 'TARGET_PPC',
> -                   'TARGET_ARM',
> -                   'TARGET_I386',
> -                   'TARGET_S390X',
> -                   'TARGET_MIPS',
> -                   'TARGET_LOONGARCH64',
> -                   'TARGET_RISCV' ] } }
> -
> -##
> -# @query-cpu-definitions:
> -#
> -# Return a list of supported virtual CPU definitions
> -#
> -# Returns: a list of CpuDefinitionInfo
> -#
> -# Since: 1.2
> -##
> -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> -  'if': { 'any': [ 'TARGET_PPC',
> -                   'TARGET_ARM',
> -                   'TARGET_I386',
> -                   'TARGET_S390X',
> -                   'TARGET_MIPS',
> -                   'TARGET_LOONGARCH64',
> -                   'TARGET_RISCV' ] } }
> -

Stuff deleted above is added to qapi/machine.json.  Okay.

Stuff deleted below is gone until the next commit adds it back to
machine-s390x.json.  Build fails.  Oops :)

> -##
> -# @S390CpuPolarization:
> -#
> -# An enumeration of CPU polarization that can be assumed by a virtual
> -# S390 CPU
> -#
> -# Since: 8.2
> -##
> -{ 'enum': 'S390CpuPolarization',
> -  'data': [ 'horizontal', 'vertical' ],
> -  'if': 'TARGET_S390X'
> -}
> -
> -##
> -# @set-cpu-topology:
> -#
> -# Modify the topology by moving the CPU inside the topology tree, or
> -# by changing a modifier attribute of a CPU.  Absent values will not
> -# be modified.
> -#
> -# @core-id: the vCPU ID to be moved
> -#
> -# @socket-id: destination socket to move the vCPU to
> -#
> -# @book-id: destination book to move the vCPU to
> -#
> -# @drawer-id: destination drawer to move the vCPU to
> -#
> -# @entitlement: entitlement to set
> -#
> -# @dedicated: whether the provisioning of real to virtual CPU is
> -#     dedicated
> -#
> -# Features:
> -#
> -# @unstable: This command is experimental.
> -#
> -# Since: 8.2
> -##
> -{ 'command': 'set-cpu-topology',
> -  'data': {
> -      'core-id': 'uint16',
> -      '*socket-id': 'uint16',
> -      '*book-id': 'uint16',
> -      '*drawer-id': 'uint16',
> -      '*entitlement': 'S390CpuEntitlement',
> -      '*dedicated': 'bool'
> -  },
> -  'features': [ 'unstable' ],
> -  'if': { 'all': [ 'TARGET_S390X' , 'CONFIG_KVM' ] }
> -}
> -
> -##
> -# @CPU_POLARIZATION_CHANGE:
> -#
> -# Emitted when the guest asks to change the polarization.
> -#
> -# The guest can tell the host (via the PTF instruction) whether the
> -# CPUs should be provisioned using horizontal or vertical
> -# polarization.
> -#
> -# On horizontal polarization the host is expected to provision all
> -# vCPUs equally.
> -#
> -# On vertical polarization the host can provision each vCPU
> -# differently.  The guest will get information on the details of the
> -# provisioning the next time it uses the STSI(15) instruction.
> -#
> -# @polarization: polarization specified by the guest
> -#
> -# Features:
> -#
> -# @unstable: This event is experimental.
> -#
> -# Since: 8.2
> -#
> -# .. qmp-example::
> -#
> -#     <- { "event": "CPU_POLARIZATION_CHANGE",
> -#          "data": { "polarization": "horizontal" },
> -#          "timestamp": { "seconds": 1401385907, "microseconds": 422329 =
} }
> -##
> -{ 'event': 'CPU_POLARIZATION_CHANGE',
> -  'data': { 'polarization': 'S390CpuPolarization' },
> -  'features': [ 'unstable' ],
> -  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> -}
> -
> -##
> -# @CpuPolarizationInfo:
> -#
> -# The result of a CPU polarization query.
> -#
> -# @polarization: the CPU polarization
> -#
> -# Since: 8.2
> -##
> -{ 'struct': 'CpuPolarizationInfo',
> -  'data': { 'polarization': 'S390CpuPolarization' },
> -  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> -}
> -
> -##
> -# @query-s390x-cpu-polarization:
> -#
> -# Features:
> -#
> -# @unstable: This command is experimental.
> -#
> -# Returns: the machine's CPU polarization
> -#
> -# Since: 8.2
> -##
> -{ 'command': 'query-s390x-cpu-polarization', 'returns': 'CpuPolarization=
Info',
> -  'features': [ 'unstable' ],
> -  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
> -}

[...]


