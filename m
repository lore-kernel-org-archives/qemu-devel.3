Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547D2CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEhMQ-0005y2-4p; Thu, 08 Oct 2026 02:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEhMJ-0005vN-9i
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xEhMH-0000cz-7C
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 02:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791439919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZoP6DJV1dVljcwC85DxYwTcpMtYwWwv9PxinZuWJ+8=;
 b=I17z1ywj1em9HBjohNlC61Zq/Br8BkpumOiZL4Mrx27N9CoVjMHf8L9jpfakLL5qzCGkQ8
 HbN2+IW39UJC8B/3oTgeEzKMqbWsJojlNfSkZ6JjdHByq47FYVqMGGtboul+sxbAlyoXm3
 ScFYM/2sNR91qV+D1KJonVkuMjW44bo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-ec-VZ4teNga6FvuFlnXmrw-1; Thu,
 08 Oct 2026 02:11:55 -0400
X-MC-Unique: ec-VZ4teNga6FvuFlnXmrw-1
X-Mimecast-MFC-AGG-ID: ec-VZ4teNga6FvuFlnXmrw_1791439914
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCA031953972; Thu,  8 Oct 2026 06:11:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24D8B19772CB; Thu,  8 Oct 2026 06:11:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D5C4121E6A04; Thu, 08 Oct 2026 08:11:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 18/19] i386/sev: Add sev-snp-guest parameter to
 enable in-place conversion
In-Reply-To: <20261007134323.1606088-19-michael.roth@amd.com> (Michael Roth's
 message of "Wed, 7 Oct 2026 08:41:42 -0500")
References: <20261007134323.1606088-1-michael.roth@amd.com>
 <20261007134323.1606088-19-michael.roth@amd.com>
Date: Thu, 08 Oct 2026 08:11:50 +0200
Message-ID: <87ld88pvq1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> The sev-snp-guest object is currently used to provide confidential guest
> by using guest_memfd for private GPA ranges, and for shared GPA ranges
> the normal memory backend is used, i.e. "out-of-place" conversion
> between shared/private.
>
> Now that "in-place" conversion support is available in QEMU, add a
> parameter to select between these 2 modes of utilizing guest_memfd (it
> cannot be enabled transparently due to noticeable differences in
> behavior (e.g. memory usage accounting and lack of hugetlb support for
> shared GPA ranges) that userspace needs to be aware of when selecting
> the mode).
>
> Note that the actual capability checks for in-place conversion support
> in the host kernel will happen later in kvm_arch_init().
>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  qapi/qom.json     |  8 +++++++-
>  target/i386/sev.c | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 49f222796a..84166c2457 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1099,6 +1099,11 @@
>  # @tsc-frequency: set secure TSC frequency.  Only valid if Secure TSC
>  #     is enabled (default: zero) (since 11.1)
>  #
> +# @convert-in-place: If true, the same physical pages are reused
> +#     when memory is converted between shared and private states.
> +#     If false (default), separate allocations are used depending
> +#     on whether the page is private or shared.  (since 11.2)
> +#

Guidance on when to enable it?  Link to suitable docs would be fine.

>  # Since: 9.1
>  ##
>  { 'struct': 'SevSnpGuestProperties',
> @@ -1112,7 +1117,8 @@
>              '*host-data': 'str',
>              '*vcek-disabled': 'bool',
>              '*secure-tsc': 'bool',
> -            '*tsc-frequency': 'uint32' } }
> +            '*tsc-frequency': 'uint32',
> +            '*convert-in-place': 'bool'} }
>  
>  ##
>  # @TdxGuestProperties:

[...]


