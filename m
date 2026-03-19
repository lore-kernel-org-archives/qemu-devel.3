Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504E5108E1F7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CB2-0007dp-9k; Thu, 19 Mar 2026 08:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CAz-0007dD-O3
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CAy-0005Tg-6b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m54XRd0nZ6sTrGrVzY56lWOujWfVkCzD0yGU6cHbbF0=;
 b=P2b03ZxW7Ly0b+LiY3oYeaEkkwmGDLOxI5Dz/L7sfCeG9uZtNe7N9otBv4MCAgbBAND4cK
 24vf0L/H4omAn0oxC3SFS2nYOc++p5LHs4SnPfbPj0BTAPkmnV/cvnQLHDJ947zLls1kHD
 tc8DH0tQqMwDXwhb22NY6ptLLQHbEys=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-7AfevvddMn-31oKFfP2djg-1; Thu,
 19 Mar 2026 08:08:27 -0400
X-MC-Unique: 7AfevvddMn-31oKFfP2djg-1
X-Mimecast-MFC-AGG-ID: 7AfevvddMn-31oKFfP2djg_1773922105
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F474195604F; Thu, 19 Mar 2026 12:08:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3888F1955D84; Thu, 19 Mar 2026 12:08:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB12721E6937; Thu, 19 Mar 2026 13:08:22 +0100 (CET)
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
Subject: Re: [PATCH v4 4/8] qdev: Add a SsidSizeMode property
In-Reply-To: <20260318184907.4060030-5-nathanc@nvidia.com> (Nathan Chen's
 message of "Wed, 18 Mar 2026 11:49:03 -0700")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-5-nathanc@nvidia.com>
Date: Thu, 19 Mar 2026 13:08:22 +0100
Message-ID: <875x6s9g3t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Nathan Chen <nathanc@nvidia.com> writes:

> From: Nathan Chen <nathanc@nvidia.com>
>
> Introduce a new enum type property allowing to set a Substream ID size
> for HW-accelerated smmuv3. Values are auto and 0..20. The auto value
> allows SSID size property to be derived from host IOMMU capabilities.
> A value of 0 disables SubstreamID, while non-zero values specify the
> SSID size in bits.
>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

[...]

> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index f921d740f1..76ea0a09fa 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -45,3 +45,19 @@
>  #                     { "version": 3, "emulated": false, "kernel": true } ] }
>  ##
>  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
> +
> +##
> +# @SsidSizeMode:
> +#
> +# SMMUv3 SubstreamID size configuration mode.
> +#
> +# @auto: derive from host IOMMU capabilities
> +#
> +# Values 0-20: SSIDSIZE value in bits.  0 disables SubstreamID.
> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'SsidSizeMode',
> +  'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
> +            '10', '11', '12', '13', '14', '15', '16', '17', '18',
> +            '19', '20' ] } # order matters, see ssid_size_mode_auto()

Make that "see ssidsize_mode_to_value()".

[...]


