Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9FAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvCA-00083B-25; Mon, 22 Apr 2024 11:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvBt-0007ti-Fk
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvBq-0006Yn-F5
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713798160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M8UKMDNMdht0xCYu34T3ZRMGnjNKWNSBm/ALK2IpUgE=;
 b=ASo74cGyr2DqMQe7izAxied8SpS8NslI1BEdOF4u9EMmYMgdEyjXanfBAs6Qx4l5Rje+nv
 snWiPJvpk/Tu/pJAfEdWBYcvHoUfzSMt14aJx24cXUKz3u0JRPbmZ4nDlb/WLuvjJjL+E7
 IrjFrwNYKeIMGM0PnBft4+KIzEuyWLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-AYslrkmtNr-K4HsClg9zpQ-1; Mon, 22 Apr 2024 11:02:37 -0400
X-MC-Unique: AYslrkmtNr-K4HsClg9zpQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D4C780253A;
 Mon, 22 Apr 2024 15:02:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5541C0654C;
 Mon, 22 Apr 2024 15:02:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A144621E66C8; Mon, 22 Apr 2024 17:02:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  Tom Lendacky
 <thomas.lendacky@amd.com>,  "Paolo Bonzini" <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,  Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 36/49] i386/sev: Add KVM_EXIT_VMGEXIT handling for
 Extended Guest Requests
In-Reply-To: <20240320083945.991426-37-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 20 Mar 2024 03:39:32 -0500")
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-37-michael.roth@amd.com>
Date: Mon, 22 Apr 2024 17:02:35 +0200
Message-ID: <87frvdcues.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

Michael Roth <michael.roth@amd.com> writes:

> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
>
> In some some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for, the GHCB specification
> defines an Extended Guest Request where this certificate data can be
> provided in a special format described in the GHCB spec. This
> certificate data may be global or guest-specific depending on how the
> guest was configured. Rather than providing interfaces to manage these
> within the kernel, KVM handles this by forward the Extended Guest
> Requests on to userspace so the certificate data can be provided in the
> expected format.
>
> Add a certs-path parameter to the sev-snp-guest object so that it can
> be used to inject any certificate data into these Extended Guest
> Requests.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json     |  7 +++-
>  target/i386/sev.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index b25a3043da..7ba778af91 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -957,6 +957,10 @@
>  #             SNP_LAUNCH_FINISH command in the SEV-SNP firmware ABI
>  #             (default: all-zero)
>  #
> +# @certs-path: path to certificate data that can be passed to guests via
> +#              SNP Extended Guest Requests. File should be in the format
> +#              described in the GHCB specification. (default: none)

Is this a filename, or is it a search path of sorts?

> +#
>  # Since: 7.2
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -967,7 +971,8 @@
>              '*id-block': 'str',
>              '*id-auth': 'str',
>              '*auth-key-enabled': 'bool',
> -            '*host-data': 'str' } }
> +            '*host-data': 'str',
> +            '*certs-path': 'str' } }
>  
>  ##
>  # @ThreadContextProperties:

[...]


