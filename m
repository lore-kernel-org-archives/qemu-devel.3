Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2599AC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbNA-0008KD-T3; Wed, 05 Feb 2025 04:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbN8-0008K0-Kg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfbN6-0004R8-Tm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738746416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VMVgiAdSJJx4Yt6je91mqO890uzHAfBCBH1el+e/CQ=;
 b=PwFOgfbkaCa9bHj8pr4MKOiZG3kBaI35M7MaiWIXZc1uRfWe7hmNo+45n1lkWASyx547ok
 kdQvi9H5FwGSRF0+ow3WZaJNlzIHsJfyg2Nl2wlYsUJYiDK/6QRGpFB/TIf9O234n4fO12
 tPCnkzMiDRAQltiOWRw7sMZNyoHD36k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-Wq6XyF8mPdSeR_g2vWNSrA-1; Wed,
 05 Feb 2025 04:06:51 -0500
X-MC-Unique: Wq6XyF8mPdSeR_g2vWNSrA-1
X-Mimecast-MFC-AGG-ID: Wq6XyF8mPdSeR_g2vWNSrA
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB455180087B; Wed,  5 Feb 2025 09:06:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F3561800872; Wed,  5 Feb 2025 09:06:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F9ED21E6A28; Wed, 05 Feb 2025 10:06:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Igor
 Mammedov <imammedo@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Eric Blake <eblake@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Huacai Chen <chenhuacai@kernel.org>,  Rick
 Edgecombe <rick.p.edgecombe@intel.com>,  Francesco Lavra
 <francescolavra.fl@gmail.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v7 12/52] i386/tdx: Validate TD attributes
In-Reply-To: <20250124132048.3229049-13-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Fri, 24 Jan 2025 08:20:08 -0500")
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-13-xiaoyao.li@intel.com>
Date: Wed, 05 Feb 2025 10:06:45 +0100
Message-ID: <878qqk4v6i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Validate TD attributes with tdx_caps that only supported bits arer
> allowed by KVM.
>
> Besides, sanity check the attribute bits that have not been supported by
> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
> TD support lands in QEMU.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v7:
> - Define TDX_SUPPORTED_TD_ATTRS as QEMU supported mask, to validates
>   user's request. (Rick)
>
> Changes in v3:
> - using error_setg() for error report; (Daniel)
> ---
>  qapi/qom.json         |  16 +++++-
>  target/i386/kvm/tdx.c | 118 +++++++++++++++++++++++++++++++++++++++++-
>  target/i386/kvm/tdx.h |   3 ++
>  3 files changed, 134 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8740626c4ee6..a53000ca6fb4 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1060,11 +1060,25 @@
>  #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>  #     be set, otherwise they refuse to boot.
>  #
> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
> +#     Defaults to all zeros.
> +#
> +# @mrowner: ID for the guest TD=E2=80=99s owner (base64 encoded SHA384 d=
igest).
> +#     Defaults to all zeros.
> +#
> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
> +#     e.g., specific to the workload rather than the run-time or OS
> +#     (base64 encoded SHA384 digest).  Defaults to all zeros.

All three members are IDs, but only the first one has "id" in its name.
Odd.  Any particular reason for that?

> +#
>  # Since: 10.0
>  ##
>  { 'struct': 'TdxGuestProperties',
>    'data': { '*attributes': 'uint64',
> -            '*sept-ve-disable': 'bool' } }
> +            '*sept-ve-disable': 'bool',
> +            '*mrconfigid': 'str',
> +            '*mrowner': 'str',
> +            '*mrownerconfig': 'str' } }

The member names are abbreviations all run together, wheras QAPI/QMP
favors words-separated-with-dashes.  If you invented them, please change
them to QAPI/QMP style.  If they are established TDX terminology, keep
them as they are, but please show us your evidence.

>=20=20
>  ##
>  # @ThreadContextProperties:

[...]


