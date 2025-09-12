Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17508CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 11:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux1re-0006eP-1j; Fri, 12 Sep 2025 07:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux1rU-0006d3-PY
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux1rS-0006DS-UW
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757676153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBBrlNDeYgfjdowSghqxoXE7iIKNSQ/itbg/58J5Nuw=;
 b=FPYUXtb8t6HkhKGsiUiBoForoj6P7WDLLjETYG114WBDKD0s8wKUZtwMb0fAliec0ijvzX
 qW5NUinI5ckv/mlNujjjVAREsO4FXRiROwykoK2MW63GCzSUFxClOqnJn1uo5zZw721zfp
 G13geAA5a2sG6EkybXKuipyyF4tUMJI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-ZOMYNIcVPL-jhWTgVzYORw-1; Fri,
 12 Sep 2025 07:22:28 -0400
X-MC-Unique: ZOMYNIcVPL-jhWTgVzYORw-1
X-Mimecast-MFC-AGG-ID: ZOMYNIcVPL-jhWTgVzYORw_1757676146
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 882511800451; Fri, 12 Sep 2025 11:22:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F176518003FC; Fri, 12 Sep 2025 11:22:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 683E721E6A27; Fri, 12 Sep 2025 13:22:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Sean Christopherson
 <seanjc@google.com>,  qemu-devel <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Nikunj A Dadhania
 <nikunj@amd.com>,  Tom Lendacky <thomas.lendacky@amd.com>,  Michael Roth
 <michael.roth@amd.com>,  Neeraj Upadhyay <neeraj.upadhyay@amd.com>,  Roy
 Hopkins <roy.hopkins@randomman.co.uk>,  Ketan Chaturvedi
 <Ketan.Chaturvedi@amd.com>
Subject: Re: [RFC PATCH 6/7] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
In-Reply-To: <23a293fca3e2ac22c7da052123e27c2794f40932.1757589490.git.naveen@kernel.org>
 (Naveen N. Rao's message of "Thu, 11 Sep 2025 17:24:25 +0530")
References: <cover.1757589490.git.naveen@kernel.org>
 <23a293fca3e2ac22c7da052123e27c2794f40932.1757589490.git.naveen@kernel.org>
Date: Fri, 12 Sep 2025 13:22:23 +0200
Message-ID: <87frcr9aq8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

"Naveen N Rao (AMD)" <naveen@kernel.org> writes:

> Add support for configuring the TSC frequency when Secure TSC is enabled
> in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> guest objects, similar to the vCPU-specific property used by regular
> guests and TDX. A new property is needed since SEV-SNP guests require
> the TSC frequency to be specified during early SNP_LAUNCH_START command
> before any vCPUs are created.
>
> The user-provided TSC frequency is set through KVM_SET_TSC_KHZ before
> issuing KVM_SEV_SNP_LAUNCH_START.
>
> Co-developed-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> Signed-off-by: Ketan Chaturvedi <Ketan.Chaturvedi@amd.com>
> Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index b05a475ef499..5b99148cb790 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1102,6 +1102,9 @@
>  #
>  # @secure-tsc: enable Secure TSC (default: false) (since 10.2)
>  #
> +# @tsc-frequency: set secure TSC frequency. Only valid if Secure TSC
> +#     is enabled (default: zero) (since 10.2)

Two spaces between sentences for consistency, please.

> +#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1114,7 +1117,8 @@
>              '*author-key-enabled': 'bool',
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
> -            '*secure-tsc': 'bool' } }
> +            '*secure-tsc': 'bool',
> +            '*tsc-frequency': 'uint32' } }
>  
>  ##
>  # @TdxGuestProperties:


