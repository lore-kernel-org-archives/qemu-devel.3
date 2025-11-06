Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43ACCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 12:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGyoO-0001W1-Ny; Thu, 06 Nov 2025 07:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGyoI-0001VZ-IQ
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGyoG-0001iK-Jw
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 07:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762430986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIbqbdHXIO8IcVXazQV+xyUSTY5N91eC14TQuUWVu38=;
 b=QYJXh0mJj40KgJrfhODZEGRdvzFdU8S2J/UN3+ZPb0ovg0MVVx7m6NtqcnZ9QbZw8bbA7a
 DAvgb3DURvpfC917/VlwbI4Ps2mp1HQJJFRMT9F2vLdftxCwlSRQ7N6H6QLQYY55Nc2qOm
 4YSUYL/oi3yEO1wPB1cavM+QpIDvSvU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Bci6kUb5POaXeKovcy5Gpw-1; Thu,
 06 Nov 2025 07:09:43 -0500
X-MC-Unique: Bci6kUb5POaXeKovcy5Gpw-1
X-Mimecast-MFC-AGG-ID: Bci6kUb5POaXeKovcy5Gpw_1762430981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31E2F18002CA; Thu,  6 Nov 2025 12:09:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A939180049F; Thu,  6 Nov 2025 12:09:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D620F21E6A27; Thu, 06 Nov 2025 13:09:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Nikunj A
 Dadhania <nikunj@amd.com>,  Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,  Roy Hopkins
 <roy.hopkins@randomman.co.uk>,  Srikanth Aithal <srikanth.aithal@amd.com>
Subject: Re: [PATCH v3 8/9] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
In-Reply-To: <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
 (Naveen N. Rao's message of "Tue, 28 Oct 2025 16:13:33 +0530")
References: <cover.1761648149.git.naveen@kernel.org>
 <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
Date: Thu, 06 Nov 2025 13:09:37 +0100
Message-ID: <87cy5vgy66.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pardon my ignorance...

"Naveen N Rao (AMD)" <naveen@kernel.org> writes:

> Add support for configuring the TSC frequency when Secure TSC is enabled
> in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> guest objects, similar to the vCPU-specific property used by regular
> guests and TDX.

Which property exactly?

>                 A new property is needed since SEV-SNP guests require
> the TSC frequency to be specified during early SNP_LAUNCH_START command
> before any vCPUs are created.

Sounds awkward.

Do the two properties set the same thing at different times?

> The user-provided TSC frequency is set through KVM_SET_TSC_KHZ before
> issuing KVM_SEV_SNP_LAUNCH_START.
>
> Attempts to set TSC frequency on both the SEV_SNP object and the cpu
> object result in an error from KVM (on the vCPU ioctl), so do not add
> separate checks for the same.
>
> Sample command-line:
>   -machine q35,confidential-guest-support=sev0 \
>   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on,tsc-frequency=2500000000
>
> Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index c7dd2dd1b095..5daaf065b6b7 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1104,6 +1104,9 @@
>  # @secure-tsc: enable Secure TSC
>  #     (default: false) (since 10.2)
>  #
> +# @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
> +#     is enabled (default: zero) (since 10.2)

Is this likely to remain the only property that's only valied when
@secure-tsc is true?

> +#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1116,7 +1119,8 @@
>              '*author-key-enabled': 'bool',
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
> -            '*secure-tsc': 'bool' } }
> +            '*secure-tsc': 'bool',
> +            '*tsc-frequency': 'uint32' } }
>  
>  ##
>  # @TdxGuestProperties:


