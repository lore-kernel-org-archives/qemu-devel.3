Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17D5C3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 06:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGu08-0002T8-3y; Mon, 19 May 2025 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGu03-0002Sf-BB
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uGu00-0004Fd-6s
 for qemu-devel@nongnu.org; Mon, 19 May 2025 02:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747636155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pnhtRU97XUANwiTAJ6mtwcpEfz12BhLIkw+skaOol+g=;
 b=U5nczzuSiwkhd1qrYT+49GWCMlCh/B2wiDIBVhK3h+UFGA0Jdy/wrX2rDGQAe8ZnKAxxkp
 nv41k1Ykd0G9STgwnPEBid2P3dpQVRLIhUCqowWV4beVCtb4vF774N0wN0WMLIy3MSrzVo
 /UDEqJ7MnxoVY6EabI66EYnWTVp0ALw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-5qiNRq3AMrmOIUVy44M_vg-1; Mon,
 19 May 2025 02:29:13 -0400
X-MC-Unique: 5qiNRq3AMrmOIUVy44M_vg-1
X-Mimecast-MFC-AGG-ID: 5qiNRq3AMrmOIUVy44M_vg_1747636152
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB37C1800447; Mon, 19 May 2025 06:29:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CF7718003FD; Mon, 19 May 2025 06:29:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAC1C21E66C3; Mon, 19 May 2025 08:29:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  berrange@redhat.com,
 Markus
 Armbruster <armbru@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 09/12] qapi: make most CPU commands unconditionally
 available
In-Reply-To: <20250515172732.3992504-10-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 May 2025 10:27:29 -0700")
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
 <20250515172732.3992504-10-pierrick.bouvier@linaro.org>
Date: Mon, 19 May 2025 08:29:08 +0200
Message-ID: <875xhxjeq3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

[...]

> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> deleted file mode 100644
> index e153291a7fc..00000000000
> --- a/qapi/machine-target.json
> +++ /dev/null

[...]

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

We lose this note.  Intentional?

Perhaps because we also have the "Some architectures ..." paragraph
above?

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

We lose this note.  Intentional?

Perhaps because we also have the "Some architectures ..." paragraph
above?

> -#
> -# Since: 2.8
> -##
> -{ 'command': 'query-cpu-model-baseline',
> -  'data': { 'modela': 'CpuModelInfo',
> -            'modelb': 'CpuModelInfo' },
> -  'returns': 'CpuModelBaselineInfo',
> -  'if': 'TARGET_S390X' }

[...]


