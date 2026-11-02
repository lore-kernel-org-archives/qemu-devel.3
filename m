Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4218606A339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AfGn80D8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNmfW-0002rQ-9T; Mon, 02 Nov 2026 02:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmfQ-0002qi-9c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:41:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNmfO-0008Gt-7x
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:41:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793605265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AbQTEOxv8ZwaG1wAfldzrR3TNNh8QvFxvO3ZuscQ8yQ=;
 b=AfGn80D8VjYg64R/KjL17SjtQMPrc89l4L91WjSlfMwMN3FvzpIy3euq85JKvQo330gxIR
 1dIKRCCE+HV/FHMyaofe7oynEp0nheemfuIsJYFZh16ULPzZp0VsYv+mw0FjthRlXgdNfr
 OV85yl6BFWOPypE0l9Rt42x7+2iVfjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-qxVAqwh6Mc-1yQisZWx3ZA-1; Mon,
 02 Nov 2026 02:41:02 -0500
X-MC-Unique: qxVAqwh6Mc-1yQisZWx3ZA-1
X-Mimecast-MFC-AGG-ID: qxVAqwh6Mc-1yQisZWx3ZA_1793605261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A85DF1800D85; Mon,  2 Nov 2026 07:41:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D975180057F; Mon,  2 Nov 2026 07:41:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA83B21E6A04; Mon, 02 Nov 2026 08:40:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <pbonzini@redhat.com>,  <berrange@redhat.com>,
 <eduardo@habkost.net>,  <pankaj.gupta@amd.com>,  <huibo.wang@amd.com>
Subject: Re: [PATCH v4 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
In-Reply-To: <20261030125228.2160752-4-michael.roth@amd.com> (Michael Roth's
 message of "Fri, 30 Oct 2026 07:49:35 -0500")
References: <20261030125228.2160752-1-michael.roth@amd.com>
 <20261030125228.2160752-4-michael.roth@amd.com>
Date: Mon, 02 Nov 2026 08:40:57 +0100
Message-ID: <87v76fu1di.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Michael Roth <michael.roth@amd.com> writes:

> The GHCB specification[1] defines a VMGEXIT-based Guest Request
> hypercall to allow an SNP guest to issue encrypted requests directly to
> SNP firmware to do things like query the attestation report for the
> guest. These are generally handled purely in the kernel.
>
> In some cases, it's useful for the host to be able to additionally
> supply the certificate chain for the signing key that SNP firmware uses
> to sign these attestation reports. To allow for this, the GHCB
> specification defines an Extended Guest Request where this certificate
> data (along with other accompanying data) can be provided in a special
> format described in the GHCB spec.  This certificate data may be global
> or guest-specific depending on how the guest was configured. Rather than
> providing interfaces to manage these within the kernel, KVM provides a
> new KVM_EXIT_SNP_REQ_CERTS exit to request the certificate contents from
> userspace. Implement support for that in QEMU.
>
> To synchronize delivery of the certificates to the guest in a way where
> they will not be rendered invalid by updates to SNP firmware or
> attestation signing/endorsement keys by management tools outside the
> purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> obtain a shared/read lock on the certificate file prior to delivering
> them back to KVM. Only after this will the attestation report be
> retrieved from firmware and bundled with the certificate data, so QEMU
> must continue to hold the file lock until KVM confirms that the
> attestation report has been retrieved/bundled.
>
> This confirmation is done by way of the kvm_immediate_exit callback
> infrastructure that was introduced in a prior commit. Once the callback
> is issued (after the next KVM_RUN), the attestation report will have
> been fetched, so the report and certificate data fetched by QEMU should
> be consistent with one another, and the certificate lock can then be
> released. The included documentation updates have more details on how
> this is handled.
>
> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>     https://www.amd.com/en/developer/sev.html
>
> Co-developed-by: Melody Wang <huibo.wang@amd.com>
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


