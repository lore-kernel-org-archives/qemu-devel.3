Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00319E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyCr-0006vb-I2; Wed, 18 Dec 2024 12:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNyCd-0006sE-Sw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNyCY-0008Op-57
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734544264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dJn8pH3fwdVepPKpL3hffJ+Q8S2e4aGrh7YHcjqe604=;
 b=WAOgTTe5lr7kb4ET05EZWLihw6sy+nMddB32ZjYbma/ISemc8qcAN+ioQMfiLs10zuFQXu
 U+qyCP3ua9/W2T5IH6HiV294o+X7Zzi4ysqflKJIgDbyh/qPewrxJFF4UZ6JbdrJ+1gcEC
 V4pxKSSzkydVbcjg90cByoH/zGE3npI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-3ZZYbjh_NPy19W0KWoVXXQ-1; Wed,
 18 Dec 2024 12:51:01 -0500
X-MC-Unique: 3ZZYbjh_NPy19W0KWoVXXQ-1
X-Mimecast-MFC-AGG-ID: 3ZZYbjh_NPy19W0KWoVXXQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE973195608C; Wed, 18 Dec 2024 17:50:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00BB3300F9B5; Wed, 18 Dec 2024 17:50:55 +0000 (UTC)
Date: Wed, 18 Dec 2024 17:50:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 armbru@redhat.com, pankaj.gupta@amd.com, huibo.wang@amd.com,
 jroedel@suse.com
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <Z2MLfIFzzyEWEy5T@redhat.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218154939.1114831-4-michael.roth@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 18, 2024 at 09:49:39AM -0600, Michael Roth wrote:
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
> for that here.
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
> 
> [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
>     https://www.amd.com/en/developer/sev.html
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json                 |  23 +++-
>  target/i386/kvm/kvm.c         |  10 ++
>  target/i386/sev-sysemu-stub.c |   5 +
>  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
>  target/i386/sev.h             |   2 +
>  5 files changed, 288 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 28ce24cd8d..6eaf0e7721 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1034,6 +1034,25 @@
>  #     firmware.  Set this to true to disable the use of VCEK.
>  #     (default: false) (since: 9.1)
>  #
> +# @certs-path: Path to certificate data that can be passed to guests via
> +#              SNP Extended Guest Requests. File should be in the format
> +#              described in the GHCB specification. (default: none)
> +#              (since: 10.0)

Can we document the required format here explicitly, rather than expecting
users to go searching for specs which are often practically impossible
to find, and even harder to read & interpret ?

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 1a4eb1ada6..2c41bdbccf 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -157,6 +157,9 @@ struct SevSnpGuestState {
>      char *id_auth_base64;
>      uint8_t *id_auth;
>      char *host_data;
> +    char *certs_path;
> +    int certs_fd;
> +    uint32_t certs_timeout;
>  
>      struct kvm_sev_snp_launch_start kvm_start_conf;
>      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> @@ -1355,6 +1358,215 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>      }
>  }
>  
> +static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
> +{
> +    int fd, ret;
> +
> +    if (sev_snp_guest->certs_fd != -1) {
> +        return 0;
> +    }
> +
> +    fd = qemu_open(sev_snp_guest->certs_path, O_RDONLY, NULL);
> +    if (fd == -1) {
> +        error_report("Unable to open certificate blob at path %s, ret %d",
> +                     sev_snp_guest->certs_path, fd);
> +        return fd;
> +    }
> +
> +    ret = qemu_lock_fd(fd, 0, 0, false);
> +    if (ret == -EAGAIN || ret == -EACCES) {
> +        ret = -EAGAIN;
> +        goto out_close;
> +    } else if (ret) {
> +        goto out_close;
> +    }

This locking scheme is likely unsafe. Consider this sequence

  * QEMU runs qemu_open(path)
  * External mgmt app runs unlink(path)
  * External mgmt app runs open(path)
  * External mgmt app runs lock(fd)
  * QEMU runs qemu_lock_fd(fd)

QEMU has successfully acquired a lock on an FD that corresponds to a
deleted file, not the current existing file.

Avoiding this problem requires either that the external mgmt app agrees
to *NEVER* unlink() the files under any circumstance, or for QEMU to
run its open + lock logic in a loop, checking 'stat' and 'fstat' before
opening and after locking, in order to detect a replaced file from its
changed inode.

I'm not inclined to rely on mgmt apps never unlink()ing as that's to
easy to mess up IMHO.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


