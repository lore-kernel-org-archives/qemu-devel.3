Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE17BCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 11:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux1qJ-0005oj-LJ; Fri, 12 Sep 2025 07:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux1pw-0005Zr-6l
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux1pq-00065B-7k
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 07:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757676053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gSEQ4Qczks8i0U7Ra7o1VfmOwUG1VbNgYYjOq2bb5cc=;
 b=Ur4kWVDqNJ4JbJofBZ5Am8qURVHIfC5UDM4Wur/1NZSOjwcb3r8A/XYLTl90ihfaMlFECY
 6PHAd8TdTvzAM8cmJJe2Fpft5TUJQ0ekkZgifzAnTyu14tSAGcs73zHsE6FRrtfE04id9Y
 HCT0kN/ZV3HHddbPGfVLjN3JAt55b68=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-9qeUdjA9PSKj3r4VcW3dHw-1; Fri,
 12 Sep 2025 07:20:49 -0400
X-MC-Unique: 9qeUdjA9PSKj3r4VcW3dHw-1
X-Mimecast-MFC-AGG-ID: 9qeUdjA9PSKj3r4VcW3dHw_1757676047
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39BF5180045C; Fri, 12 Sep 2025 11:20:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E59A19560B1; Fri, 12 Sep 2025 11:20:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2B6D21E6A27; Fri, 12 Sep 2025 13:20:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Sean Christopherson
 <seanjc@google.com>,  qemu-devel <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>,  "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>,  Tom Lendacky
 <thomas.lendacky@amd.com>,  Michael Roth <michael.roth@amd.com>,  Neeraj
 Upadhyay <neeraj.upadhyay@amd.com>,  Roy Hopkins
 <roy.hopkins@randomman.co.uk>
Subject: Re: [RFC PATCH 3/7] target/i386: SEV: Add support for enabling
 debug-swap SEV feature
In-Reply-To: <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
 (Naveen N. Rao's message of "Thu, 11 Sep 2025 17:24:22 +0530")
References: <cover.1757589490.git.naveen@kernel.org>
 <0a77cf472bc36fee7c1be78fc7d6d514d22bca9a.1757589490.git.naveen@kernel.org>
Date: Fri, 12 Sep 2025 13:20:43 +0200
Message-ID: <87jz239at0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

> Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
> SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
> objects. Though the boolean property is available for plain SEV guests,
> check_sev_features() will reject setting this for plain SEV guests.

Let's see whether I understand...

It's a property of sev-guest and sev-snp-guest objects.  These are the
"SEV guest objects".

I guess a sev-snp-guest object implies it's a SEV-SNP guest, and setting
@debug-swap on such an object just works.

With a sev-guest object, it's either a "plain SEV guest" or a "SEV-ES"
guest.

If it's the latter, setting @debug-swap just works.

If it's the former, and you set @debug-swap to true, then KVM
accelerator initialization will fail later on.  This might trigger
fallback to TCG.

Am I confused?

> Add helpers for setting and querying the VMSA SEV features so that they
> can be re-used for subsequent VMSA SEV features, and convert the
> existing SVM_SEV_FEAT_SNP_ACTIVE definition to use the BIT() macro for
> consistency with the new feature flag.
>
> Sample command-line:
>   -machine q35,confidential-guest-support=sev0 \
>   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on
>
> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 830cb2ffe781..71cd8ad588b5 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1010,13 +1010,17 @@
>  #     designated guest firmware page for measured boot with -kernel
>  #     (default: false) (since 6.2)
>  #
> +# @debug-swap: enable virtualization of debug registers (default: false)
> +#              (since 10.2)

Please indent like this:

   # @debug-swap: enable virtualization of debug registers
   #     (default: false) (since 10.2)

> +#
>  # Since: 9.1
>  ##
>  { 'struct': 'SevCommonProperties',
>    'data': { '*sev-device': 'str',
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',
> -            '*kernel-hashes': 'bool' } }
> +            '*kernel-hashes': 'bool',
> +            '*debug-swap': 'bool' } }
>  
>  ##
>  # @SevGuestProperties:


