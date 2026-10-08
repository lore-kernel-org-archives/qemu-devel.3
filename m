Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04DECA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEhPU-0007kn-Lo; Thu, 08 Oct 2026 02:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEhPH-0007Xr-0t
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEhPE-0000ki-WE
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791440104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7lR3YC/gBBURr2+yOaKT5TXCdHLjx5Uu46t8DzfHSU=;
 b=XK5er4V/t2RxqH2P8+/2KJASMdLXSPDAmx4p6xNPIuLOQw6gypbYGxujYhxlrA2kOMdUBc
 +e70KSfB3TwxiSE8VTwKL2pgzb2pQo2gOQpDk5A2hddyOF+5GQYwl6/8aD5TvLFDnoCZUs
 aAGTVuhBpSBymre/h8BZy8TcTBOTHAE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-kSF5cEt7PA-P98KxWrGqfQ-1; Thu,
 8 Oct 2026 06:15:00 +0000
X-MC-Unique: kSF5cEt7PA-P98KxWrGqfQ-1
X-Mimecast-MFC-AGG-ID: kSF5cEt7PA-P98KxWrGqfQ_1791440099
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 912BB180B5EE; Thu,  8 Oct 2026 06:14:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5BC21956040; Thu,  8 Oct 2026 06:14:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73A2421E6A04; Thu, 08 Oct 2026 08:14:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 19/19] hostmem: Automatically select set
 guest-memfd=on for in-place conversion
In-Reply-To: <20261007134323.1606088-20-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 7 Oct 2026 08:41:43 -0500")
References: <20261007134323.1606088-1-michael.roth@amd.com>
 <20261007134323.1606088-20-michael.roth@amd.com>
Date: Thu, 08 Oct 2026 08:14:25 +0200
Message-ID: <87h5iwpvlq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael Roth <michael.roth@amd.com> writes:

> When in-place conversion is enabled, both the shared memory and private
> memory must come from the same guest_memfd instance. Thus, the
> memory-backend-memfd options must in turn correspond to a guest_memfd
> instance, e.g. guest-memfd=on must be specified. Since there is no
> use-case for enabling in-place conversion without setting
> guest-memfd=on, just set it automatically if in-place conversion is
> enabled (unless guest-memfd has been explicitly set to 'off', in which
> case generate an informative error message).
>
> Also update the 'guest-memfd' documentation to note this behavior.
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
> index d62a214a91..4477756424 100644
> --- a/docs/system/guest-memfd.rst
> +++ b/docs/system/guest-memfd.rst
> @@ -53,6 +53,27 @@ exposed as an experimental for the time being:
>   * guest_memfd does not currently support the hugetlb=on option
>   * guest_memfd does not currently support Transparent Huge Pages
>  
> +In-place conversion
> +-------------------
> +
> +Newer kernels now support using a guest-memfd instance for both
> +private and shared memory at the same time by re-using the same
> +physical backing pages if a guest converts a GPA range between
> +shared and private. This is known as "in-place conversion".
> +
> +For some confidential computing architectures, like SEV-SNP and
> +TDX, this mode offers better performance due to not needing to
> +deallocate/reallocate between 2 separate pools of shared vs. private
> +memory every time the guest converts memory between shared/private.
> +For other architectures, this is the only supported mode of
> +operation.
> +
> +When in-place conversion is enabled, it is necessary to use the
> +memory-backend-memfd backend with guest-memfd=on as shown in the
> +"Usage" section. Because of this, guest-memfd=auto (which is the

Recommend to make this a link.

> +default) will result in the parameter being automatically enabled
> +if the confidential guest type enables in-place conversion.
> +
>  References
>  ----------
>  
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 84166c2457..5d66e67087 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -756,8 +756,9 @@
>  # @guest-memfd: if 'on', use guest-memfd to back the memory region.
>  #     See the :doc:`/system/guest-memfd` documentation for more
>  #     details.  If 'auto', the option will default to 'off'
> -#     currently, but in the future it may result in the option being
> -#     set to 'on' for QEMU configurations that explicitly require it.
> +#     unless the QEMU configuration explicitly requires it to be set,
> +#     e.g. if in-place conversion is enabled for confidential guest
> +#     types like sev-snp-guest.
>  #     (default: auto, since: 11.2)
>  #
>  # Features:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


