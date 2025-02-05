Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AC5C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeK8-0005SQ-GP; Wed, 05 Feb 2025 07:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfeK5-0005S6-Vw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:16:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tfeK3-0006WV-2X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738757761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsIwVFa6yLOKW+vVsSD4c+ZKT9wIuMs1HeimAfceEl4=;
 b=c/+QKHzjkFY5b5BtuyoU59TmTyBVyzU4OmQDJUSTJToHZiqd8bq32kSfLPpx3X4MZsP6t1
 hr6yYCoKN6P8X2mVmiK+Tv+5W12PsgFhqg6Zv+Tm7wJINeYsZn59GrqZ+pHf7OqnktUgTR
 s4/hCKfCvG2AaftXetu8+yUW+x43OPY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-Zgkjj6eWPx2MZY8ucWFUpw-1; Wed,
 05 Feb 2025 07:14:29 -0500
X-MC-Unique: Zgkjj6eWPx2MZY8ucWFUpw-1
X-Mimecast-MFC-AGG-ID: Zgkjj6eWPx2MZY8ucWFUpw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 222F01800875; Wed,  5 Feb 2025 12:14:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.40])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E398300018D; Wed,  5 Feb 2025 12:14:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EAFFF21E6A28; Wed, 05 Feb 2025 13:14:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: <qemu-devel@nongnu.org>,  Tom Lendacky <thomas.lendacky@amd.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  <eduardo@habkost.net>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,  <jroedel@suse.com>,
 <michael.roth@amd.com>
Subject: Re: [RFC PATCH v2 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support
 for certificate-fetching
In-Reply-To: <20250120213116.521519-4-huibo.wang@amd.com> (Melody Wang's
 message of "Mon, 20 Jan 2025 21:31:16 +0000")
References: <20250120213116.521519-1-huibo.wang@amd.com>
 <20250120213116.521519-4-huibo.wang@amd.com>
Date: Wed, 05 Feb 2025 13:14:24 +0100
Message-ID: <87o6zgzizj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Melody Wang <huibo.wang@amd.com> writes:

> From: Michael Roth <michael.roth@amd.com>
>
> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
>
> In some some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for this, the GHCB
> specification defines an Extended Guest Request where this certificate
> data can be provided in a special format described in the GHCB spec.
> This certificate data may be global or guest-specific depending on how
> the guest was configured. Rather than providing interfaces to manage
> these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> to request the certificate contents from userspace. Implement support
> for that in QEMU.
>
> To synchronize delivery of the certificates to the guest in a way where
> they will not be rendered invalid by updates to SNP firmware or
> attestation singing/endorsement keys by management tools outside the
> purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> obtain a shared/read lock on the certificate file prior to delivering
> them back to KVM. Only after this will the attestation report be
> retrieved from firmware and bundled with the certificate data, so QEMU
> must continue to hold the file lock until KVM confirms that the
> attestation report has been retrieved/bundled. This confirmation is done
> by way of the kvm_immediate_exit callback infrastructure that was
> introduced in a previous patch.

In review of v1, I inquired about the locking, and Mike explained it
some more.  I wonder whether we should work some of that into our
documentation.

> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>     https://www.amd.com/en/developer/sev.html
>
>   [Melody: Add a while(1) loop using the libvirt example with fstat and
>   stat for the locking certificate blob code in open_certs_locked() to
>   fix the recreation race problem suggested by Daniel P. Berrang=C3=A9. A=
nd
>   fix the json format and filename suggested by Markus Armbruster.]
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> ---
>  qapi/qom.json                 |  21 ++-
>  target/i386/kvm/kvm.c         |  10 ++
>  target/i386/sev-system-stub.c |   5 +
>  target/i386/sev.c             | 277 ++++++++++++++++++++++++++++++++++
>  target/i386/sev.h             |   2 +-
>  5 files changed, 313 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 28ce24cd8d..c6f9ad5d45 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1034,6 +1034,23 @@
>  #     firmware.  Set this to true to disable the use of VCEK.
>  #     (default: false) (since: 9.1)
>  #
> +# @certs-filename: Certificate data that can be passed to guests via
> +#     SNP Extended Guest Requests. File should be in the format
> +#     described in the GHCB specification. (default: none)

Is this referring to the "Guest Hypervisor Communication Block (GHCB)
Standardization" mentioned in the commit message?

That's 70 pages...  Where exactly is the file format specified?

> +#     (since: 10.0)
> +#
> +# @certs-timeout: Maximum time in milliseconds to wait to obtain a read =
lock
> +#     on the certificate file specified by @certs-filename. This is
> +#     not a cumulative value and only affects how long QEMU waits
> +#     before returning execution to the vCPU and informing the guest
> +#     of the timeout, so the guest can still continue retrying for
> +#     as long as it likes (which will be about 60 seconds for linux
> +#     guests at the time of this writing). If the guest-side timeout
> +#     is insufficient, set this higher to allow more time to fetch the
> +#     certificate. If the guest-side timeout is sufficient, set this
> +#     lower to reduce the likelihood of soft lockups in the guest.
> +#     (default: 100) (since: 10.0)
> +#

docs/devel/qapi-code-gen.rst:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1045,7 +1062,9 @@
>              '*id-auth': 'str',
>              '*author-key-enabled': 'bool',
>              '*host-data': 'str',
> -            '*vcek-disabled': 'bool' } }
> +            '*vcek-disabled': 'bool',
> +            '*certs-filename': 'str',
> +            '*certs-timeout': 'uint32' } }
>=20=20
>  ##
>  # @ThreadContextProperties:


