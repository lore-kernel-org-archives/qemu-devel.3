Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3B0CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVTw-0004RA-Nj; Fri, 19 Jun 2026 05:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1waVTu-0004Qe-RB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1waVTt-0001mw-6n
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781861143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMlqmyyFgUF8NnVSUFxygt+NxV37HopokOxz2jLoL8w=;
 b=gIoFVDPuShC+TowlTk7SNeAaCvglboVO2jTbpOfij3QEVGuZdEWeszRG3/S3wdzoalK6uF
 /REEzBXiToFLIbZyEn2gOsLimSwRUv1RxqJAd0XNLipHilJzF67c6C0iqth0xHHzJdeZ91
 nkMsoOTVeB1b/7bMHoe8u6+7UBk8OV4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-SRX2vnCHOjOXGTdULzwoTg-1; Fri,
 19 Jun 2026 05:25:39 -0400
X-MC-Unique: SRX2vnCHOjOXGTdULzwoTg-1
X-Mimecast-MFC-AGG-ID: SRX2vnCHOjOXGTdULzwoTg_1781861137
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44BE61955F26; Fri, 19 Jun 2026 09:25:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 528331956088; Fri, 19 Jun 2026 09:25:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF91921E6A01; Fri, 19 Jun 2026 11:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  kvmarm@lists.linux.dev,
 Eric Auger <eric.auger@redhat.com>,  Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Marc Zyngier <maz@kernel.org>,  Oliver
 Upton <oliver.upton@linux.dev>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Andrea Bolognani <abologna@redhat.com>,  Jiri
 Denemark <jdenemar@redhat.com>,  Gavin Shan <gshan@redhat.com>,  Shameer
 Kolothum <skolothumtho@nvidia.com>,  Sebastian Ott <sebott@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jinqian Yang
 <yangjinqian1@huawei.com>,  Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [RFC PATCH v2 23/29] target/arm/qmp: add query-arm-cpu-props-info
In-Reply-To: <20260605083358.1320563-24-khushit.shah@nutanix.com> (Khushit
 Shah's message of "Fri, 5 Jun 2026 08:33:52 +0000")
References: <20260605083358.1320563-1-khushit.shah@nutanix.com>
 <20260605083358.1320563-24-khushit.shah@nutanix.com>
Date: Fri, 19 Jun 2026 11:25:33 +0200
Message-ID: <87o6h6hofm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Khushit Shah <khushit.shah@nutanix.com> writes:

> Introduce 'query-arm-cpu-props-info' QMP command. This command returns
> information about ARM CPU model properties, including their name, type,
> supported values on the given host, and composite parent if any.
>
> This provides management layer necessary information to determine
> migration compatibility off a VM on different host.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  qapi/misc-arm.json              | 41 ++++++++++++++++
>  stubs/qmp-arm-gic.c             |  6 +++
>  target/arm/arm-cpu-props-stub.c | 13 +++++
>  target/arm/arm-cpu-props.c      | 85 +++++++++++++++++++++++++++++++++
>  target/arm/arm-cpu-props.h      |  5 ++
>  target/arm/arm-qmp-cmds.c       | 44 +++++++++++++++++
>  target/arm/cpu-idregs.c         | 71 +++++++++++++++++++++++++++
>  target/arm/cpu-idregs.h         |  8 ++++
>  8 files changed, 273 insertions(+)
>
> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index 4dc66d00e5..1a3fb140c4 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -46,6 +46,47 @@
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
>  
> +##
> +# @CpuPropInfo:

CpuPropertyInfo for consistency with type names such as ObjectPropertyInfo.

> +#
> +# Information about a specific ARM CPU model property.
> +#
> +# @name: the name of the property
> +#
> +# @type: the type of the property, any of ('string', 'boolean',
> +#     'number').
> +#
> +# @supported-values: the set of values the host hardware supports
> +#     for the property, a list of strings.

I figure the set of values depends on the host, i.e. it isn't known at
compile time.  Correct?

Are the possible property names known at compile time?

List of strings is fine when the values are strings.  When they're not,
the interface requires its users to parse strings, which is something we
try hard to avoid in QAPI/QMP.

> +#
> +# @composite: name of the encapsulating composite property if any.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'CpuPropInfo',
> +  'data': { 'name': 'str',
> +            'type': 'str',
> +            'supported-values': 'any',

Description above claims "list of strings".  If that's accurate, it
should be ['str'] here.  Else, the description needs fixing.

> +            '*composite': 'str' } }
> +
> +##
> +# @query-arm-cpu-props-info:
> +#
> +# Returns information about most of ARM CPU named model properties.

Imperative mood, please: Return information ...

> +# This does not include composite properties or properties already
> +# defined by QEMU like (sveNNNN, pmu, etc), This only returns all
> +# the newly defined properties like ('feat_*', 'hw_prop_*', etc).

"newly defined" compared to what?

> +#
> +# With this upper management layers can find out what property values

Comma after this, I think.

> +# are supported on the given host.
> +#
> +# Requires KVM to be enabled.

What happens when it isn't?

> +#
> +# Since: 11.1
> +##
> +{ 'command': 'query-arm-cpu-props-info',
> +  'returns': ['CpuPropInfo'] }
> +
>  ##
>  # @SsidSizeMode:
>  #

[...]


