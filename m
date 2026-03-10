Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31277FCC9D2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrIP-0003bC-G1; Tue, 10 Mar 2026 03:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrIN-0003Zv-5G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrIL-0002F4-Ct
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773126858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7g9OVP6iUc/8aolW4hmlxMZu3x2Wv0N7m6TUy0jDWkk=;
 b=FziyEQDBZ2oIJoy8sAhyQU2RXtKbZQfau/AlYS+JpNLANCCYxDfsU62tgH/yR6ClYZFCfj
 68UQels4RE2T9RmPpMalVdIAePgseZiEjQ4zI8mSEhATKsqogPAvfSrS+rXglBgIfoESxz
 sKu+NC+Qy/NAElWAYgyFC42Lo0H1dK0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-EljrWCCnNKubNzxiHpQZ3Q-1; Tue,
 10 Mar 2026 03:14:14 -0400
X-MC-Unique: EljrWCCnNKubNzxiHpQZ3Q-1
X-Mimecast-MFC-AGG-ID: EljrWCCnNKubNzxiHpQZ3Q_1773126852
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D951956089; Tue, 10 Mar 2026 07:14:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 319541956095; Tue, 10 Mar 2026 07:14:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CF7821E6614; Tue, 10 Mar 2026 08:14:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Yi Liu
 <yi.l.liu@intel.com>,  Eric Auger <eric.auger@redhat.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 5/8] qdev: Add a SsidSizeMode property
In-Reply-To: <20260309192119.870186-6-nathanc@nvidia.com> (Nathan Chen's
 message of "Mon, 9 Mar 2026 12:21:16 -0700")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-6-nathanc@nvidia.com>
Date: Tue, 10 Mar 2026 08:14:08 +0100
Message-ID: <87jyvknolb.fsf@pond.sub.org>
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
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>

[...]

> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index f921d740f1..b372a3661b 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -45,3 +45,18 @@
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

This renders like

    Enum SsidSizeMode (Since: 11.0)

       SMMUv3 SubstreamID size configuration mode.

       Values:
          * auto -- derive from host IOMMU capabilities

          * 0 -- Not documented

          * 1 -- Not documented

          * 2 -- Not documented

          * 3 -- Not documented

          * 4 -- Not documented

          * 5 -- Not documented

          * 6 -- Not documented

          * 7 -- Not documented

          * 8 -- Not documented

          * 9 -- Not documented

          * 10 -- Not documented

          * 11 -- Not documented

          * 12 -- Not documented

          * 13 -- Not documented

          * 14 -- Not documented

          * 15 -- Not documented

          * 16 -- Not documented

          * 17 -- Not documented

          * 18 -- Not documented

          * 19 -- Not documented

          * 20 -- Not documented

       Values 0-20: SSIDSIZE value in bits.  0 disables SubstreamID.

Sadly, many existing enums also have undocumented members.  Some because
documenting them one by one would be kind of silly (e.g. QKeyCode).

I don't have a better idea right now, so this is just an observation,
not a demand.  Maybe John Snow (cc'ed) can some day dream up a better
way to do this.

> +{ 'enum': 'SsidSizeMode',
> +  'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
> +            '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ] }
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 193bc39059..24aebbe8f5 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -68,6 +68,7 @@
>          'S390CpuEntitlement',
>          'S390CpuPolarization',
>          'S390CpuState',
> +        'SsidSizeMode',
>          'String',
>          'StringWrapper',
>          'SysEmuTarget',


