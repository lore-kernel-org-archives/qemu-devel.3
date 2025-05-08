Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B4C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0DS-0003FL-Ea; Thu, 08 May 2025 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uD0DP-0003F4-R5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uD0DO-0001zB-19
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746706740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRlUij8/HxhbNOyeA3KBfqL/+BCuaFEr9TB35/unyhI=;
 b=XBrNumBz3wHDxuGLuBfPv3FJ5YW3MymCCb4q1wuQ8t4BJNmpLmcPttVFOSKnoSJ+Q5YA/g
 9Qx0LSLn9BGEoXqr2KgiG6a4KbnRTNzU1x3C2vHg4fDTIV+bISkRQmuOR4qr5ksne3z2nO
 2+vvh+++mD+13WJ/Vfeb4nGGJHDIkT0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-qo8y7RBDMt22dWhEEApfMQ-1; Thu,
 08 May 2025 08:18:57 -0400
X-MC-Unique: qo8y7RBDMt22dWhEEApfMQ-1
X-Mimecast-MFC-AGG-ID: qo8y7RBDMt22dWhEEApfMQ_1746706735
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90CBD19560AB; Thu,  8 May 2025 12:18:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B55B180049D; Thu,  8 May 2025 12:18:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1431F21E6768; Thu, 08 May 2025 14:18:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  qemu-s390x@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Yanan Wang
 <wangyanan55@huawei.com>
Subject: Re: [RFC PATCH] qapi: Make CpuModelExpansionInfo::deprecated-props
 optional and generic
In-Reply-To: <20250429100419.20427-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 29 Apr 2025 12:04:19
 +0200")
References: <20250429100419.20427-1-philmd@linaro.org>
Date: Thu, 08 May 2025 14:18:52 +0200
Message-ID: <87v7qbcn2r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We'd like to have some unified QAPI schema. Having a structure field
> conditional to a target being built in is not very practical.
>
> While @deprecated-props is only used by s390x target, it is generic
> enough and could be used by other targets (assuming we expand
> CpuModelExpansionType enum values).
>
> Let's always include this field, regardless of the target, but
> make it optional.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  qapi/machine-target.json | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
> index 541f93eeb78..3b109b4af87 100644
> --- a/qapi/machine-target.json
> +++ b/qapi/machine-target.json
> @@ -244,19 +244,18 @@
>  #
>  # @model: the expanded CpuModelInfo.
>  #
> -# @deprecated-props: a list of properties that are flagged as
> +# @deprecated-props: an optional list of properties that are flagged as
>  #     deprecated by the CPU vendor.  The list depends on the
>  #     CpuModelExpansionType: "static" properties are a subset of the
>  #     enabled-properties for the expanded model; "full" properties are
>  #     a set of properties that are deprecated across all models for
> -#     the architecture.  (since: 9.1).
> +#     the architecture.  (since: 10.1 -- since 9.1 on s390x --).
>  #
>  # Since: 2.8
>  ##
>  { 'struct': 'CpuModelExpansionInfo',
>    'data': { 'model': 'CpuModelInfo',
> -            'deprecated-props' : { 'type': ['str'],
> -                                   'if': 'TARGET_S390X' } },
> +            '*deprecated-props' : { 'type': ['str'] } },

Make this

               '*deprecated-props' : ['str'] },

please.

>    'if': { 'any': [ 'TARGET_S390X',
>                     'TARGET_I386',
>                     'TARGET_ARM',


