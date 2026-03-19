Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D30108E1FE
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CIs-0002X6-Hh; Thu, 19 Mar 2026 08:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CIq-0002Wf-Sg
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CIo-0002io-MR
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jzP5BecdNiomkcl/7TisrOhvZPZy9QoNtdJcxx4ND5M=;
 b=WlC4lFyab7DtsD9QbueNzTQQdhg6Yv9N2+2usQEdy4dP7jYL0BvfMnB28V6ZYM43KETDnB
 SG2YeML2wGXbMQ/g5zyDR3061EFxsAJQyVbS6rqGC/HcE/Kk7hIxZaa34gQ7lX0FRC0mL/
 KTEDpQu9ipbryjGKpdi5D5KeasWwRtI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-8hiP8wxePqi72v__LAIH7g-1; Thu,
 19 Mar 2026 08:16:33 -0400
X-MC-Unique: 8hiP8wxePqi72v__LAIH7g-1
X-Mimecast-MFC-AGG-ID: 8hiP8wxePqi72v__LAIH7g_1773922591
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20DD019560AE; Thu, 19 Mar 2026 12:16:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D012D1955F2B; Thu, 19 Mar 2026 12:16:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 703E021E6937; Thu, 19 Mar 2026 13:16:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Shannon Zhao
 <shannon.zhaosl@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,  Matt Ochs
 <mochs@nvidia.com>,  Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 6/8] qdev: Add an OasMode property
In-Reply-To: <20260318184907.4060030-7-nathanc@nvidia.com> (Nathan Chen's
 message of "Wed, 18 Mar 2026 11:49:05 -0700")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-7-nathanc@nvidia.com>
Date: Thu, 19 Mar 2026 13:16:28 +0100
Message-ID: <87y0jo815v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Subject line: this patch doesn't add a property, it adds a property
*type*.  Easy enough to fix.

Nathan Chen <nathanc@nvidia.com> writes:

> From: Nathan Chen <nathanc@nvidia.com>
>
> Introduce a new enum type property allowing to set an Output Address
> Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
> value of N specifies an N-bit OAS.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

[...]

> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index 76ea0a09fa..5dbb4add91 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -61,3 +61,31 @@
>    'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
>              '10', '11', '12', '13', '14', '15', '16', '17', '18',
>              '19', '20' ] } # order matters, see ssid_size_mode_auto()
> +
> +##
> +# @OasMode:
> +#
> +# SMMUv3 Output Address Size configuration mode.
> +#
> +# @auto: derive from host IOMMU capabilities
> +#
> +# @32: 32-bit output address size
> +#
> +# @36: 36-bit output address size
> +#
> +# @40: 40-bit output address size
> +#
> +# @42: 42-bit output address size
> +#
> +# @44: 44-bit output address size
> +#
> +# @48: 48-bit output address size
> +#
> +# @52: 52-bit output address size
> +#
> +# @56: 56-bit output address size
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'OasMode',
> +  'data': [ 'auto', '32', '36', '40', '42', '44', '48', '52', '56' ] }

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


