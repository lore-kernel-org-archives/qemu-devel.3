Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AE8C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romTr-0002Ej-Ku; Mon, 25 Mar 2024 11:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romTp-0002Eb-Rt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1romTn-0002am-AI
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711381397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zl3xzxWuLTYzrlL7SOyOLvi9ayOBX8dA3GicXUzd3g=;
 b=GsDVeoxAuzW5Q6J9NxaMcLx95Oq+7PEYCbQdPg4fAyIYwt8Fe0JxzxWgflgiKyqpGxGX7m
 Gibw/i0ErjxMK65Muf1M+8qkEC2HIp8eWSdhRZm9WTg5O4Ys9zGFL9rock76D+saGB6dF/
 /7t+1meF9Dila/vERIz+hTPtakwBfcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-f6rpvgmmPnqWKABW9JRtjQ-1; Mon, 25 Mar 2024 11:43:15 -0400
X-MC-Unique: f6rpvgmmPnqWKABW9JRtjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A19888F3B3;
 Mon, 25 Mar 2024 15:43:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3385E1C060A4;
 Mon, 25 Mar 2024 15:43:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 475E221E669D; Mon, 25 Mar 2024 16:43:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [PATCH v1] qapi: document parameters of query-cpu-model-* QAPI
 commands
In-Reply-To: <20240325150141.342720-1-david@redhat.com> (David Hildenbrand's
 message of "Mon, 25 Mar 2024 16:01:41 +0100")
References: <20240325150141.342720-1-david@redhat.com>
Date: Mon, 25 Mar 2024 16:43:10 +0100
Message-ID: <87edbyjp0x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

David Hildenbrand <david@redhat.com> writes:

> Let's document the parameters of these commands, so we can remove them
> from the "documentation-exceptions" list.
>
> While at it, extend the "Returns:" documentation as well, fixing a wrong
> use of CpuModelBaselineInfo vs. CpuModelCompareInfo for
> query-cpu-model-comparison.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@linaro.org>
> Cc: Yanan Wang <wangyanan55@huawei.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  qapi/machine-target.json | 46 +++++++++++++++++++++++++++-------------
>  qapi/pragma.json         |  3 ---
>  2 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 519adf3220..7883616cce 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -124,11 +124,12 @@
>  ##
>  # @query-cpu-model-comparison:
>  #
> -# Compares two CPU models, returning how they compare in a specific
> -# configuration.  The results indicates how both models compare
> -# regarding runnability.  This result can be used by tooling to make
> -# decisions if a certain CPU model will run in a certain configuration
> -# or if a compatible CPU model has to be created by baselining.
> +# Compares two CPU models, @modela and @modelb, returning how they
> +# compare in a specific configuration.  The results indicates how
> +# both models compare regarding runnability.  This result can be
> +# used by tooling to make decisions if a certain CPU model will
> +# run in a certain configuration or if a compatible CPU model has
> +# to be created by baselining.
>  #
>  # Usually, a CPU model is compared against the maximum possible CPU
>  # model of a certain configuration (e.g. the "host" model for KVM).
> @@ -154,7 +155,14 @@
>  # Some architectures may not support comparing CPU models.  s390x
>  # supports comparing CPU models.
>  #
> -# Returns: a CpuModelBaselineInfo
> +# @modela: description of the first CPU model to compare, referred to as
> +#     "model A" in CpuModelCompareResult
> +#
> +# @modelb: description of the second CPU model to compare, referred to as
> +#     "model B" in CpuModelCompareResult
> +#
> +# Returns: a CpuModelCompareInfo, describing how both CPU models

Scratch the comma?

> +#     compare
>  #
>  # Errors:
>  #     - if comparing CPU models is not supported
> @@ -175,9 +183,9 @@
>  ##
>  # @query-cpu-model-baseline:
>  #
> -# Baseline two CPU models, creating a compatible third model.  The
> -# created model will always be a static, migration-safe CPU model (see
> -# "static" CPU model expansion for details).
> +# Baseline two CPU models, @modela and @modelb, creating a compatible
> +# third model.  The created model will always be a static,
> +# migration-safe CPU model (see "static" CPU model expansion for details=
).
>  #
>  # This interface can be used by tooling to create a compatible CPU
>  # model out two CPU models.  The created CPU model will be identical
> @@ -204,7 +212,11 @@
>  # Some architectures may not support baselining CPU models.  s390x
>  # supports baselining CPU models.
>  #
> -# Returns: a CpuModelBaselineInfo
> +# @modela: description of the first CPU model to baseline
> +#
> +# @modelb: description of the second CPU model to baseline
> +#
> +# Returns: a CpuModelBaselineInfo, describing the baselined CPU model

Scratch the comma?

>  #
>  # Errors:
>  #     - if baselining CPU models is not supported
> @@ -243,10 +255,10 @@
>  ##
>  # @query-cpu-model-expansion:
>  #
> -# Expands a given CPU model (or a combination of CPU model +
> -# additional options) to different granularities, allowing tooling to
> -# get an understanding what a specific CPU model looks like in QEMU
> -# under a certain configuration.
> +# Expands a given CPU model, @model, (or a combination of CPU model +
> +# additional options) to different granularities, specified by
> +# @type, allowing tooling to get an understanding what a specific
> +# CPU model looks like in QEMU under a certain configuration.
>  #
>  # This interface can be used to query the "host" CPU model.
>  #
> @@ -269,7 +281,11 @@
>  # Some architectures may not support all expansion types.  s390x
>  # supports "full" and "static". Arm only supports "full".
>  #
> -# Returns: a CpuModelExpansionInfo
> +# @model: description of the CPU model to expand
> +#
> +# @type: expansion type, specifying how to expand the CPU model
> +#
> +# Returns: a CpuModelExpansionInfo, describing the expanded CPU model
>  #
>  # Errors:
>  #     - if expanding CPU models is not supported
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 6929ab776e..0d82bc1a03 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -90,9 +90,6 @@
>          'XDbgBlockGraph',
>          'YankInstanceType',
>          'blockdev-reopen',
> -        'query-cpu-model-baseline',
> -        'query-cpu-model-comparison',
> -        'query-cpu-model-expansion',
>          'query-rocker',
>          'query-rocker-ports',
>          'query-stats-schemas',

Reviewed-by: Markus Armbruster <armbru@redhat.com>


