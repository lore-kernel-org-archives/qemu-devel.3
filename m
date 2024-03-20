Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28549C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvAa-0007ZA-6w; Wed, 20 Mar 2024 08:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmvAY-0007Xa-74
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmvAR-00064t-Hj
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710938138;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=K5bhn2dwTvZHL2QD2WfC2AZX9DEbxPOtGZ1fjXI2/e8=;
 b=Ib2Z/ixCiWMDIBcRmCL1Aoca+rTCJgorH5PyTZpbXjfXXCBL+xlfYV9f7XPqjhdnzAZ33L
 XOckMGkFg3ulsiz9rT359ql7ukcSzv3uRn5WY8LSBQ5e/g5VxgiMBKUjDjfCEcj+B+OamN
 R9cg0Qgly7+BY/GGy/kPx4VPgRB1RyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-OTNDOuB8PoG4MEsZYgcqHQ-1; Wed, 20 Mar 2024 08:35:34 -0400
X-MC-Unique: OTNDOuB8PoG4MEsZYgcqHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F237885A58B;
 Wed, 20 Mar 2024 12:35:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14E7640C6CB3;
 Wed, 20 Mar 2024 12:35:31 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:35:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 23/49] i386/sev: Add a sev_snp_enabled() helper
Message-ID: <ZfrX_SkgXPF1FbCp@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-24-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-24-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 03:39:19AM -0500, Michael Roth wrote:
> Add a simple helper to check if the current guest type is SNP. Also have
> SNP-enabled imply that SEV-ES is enabled as well, and fix up any places
> where the sev_es_enabled() check is expecting a pure/non-SNP guest.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/sev.c | 13 ++++++++++++-
>  target/i386/sev.h |  2 ++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 7e6dab642a..2eb13ba639 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c


> @@ -933,7 +942,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>                           __func__);
>              goto err;
>          }
> +    }
>  
> +    if (sev_es_enabled() && !sev_snp_enabled()) {
>          if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
>              error_report("%s: guest policy requires SEV-ES, but "
>                           "host SEV-ES support unavailable",

Opps, pre-existing bug here - this method has an 'Error **errp'
parameter, so should be using 'error_report'.

There are several more examples of this in this method that
predate your patch series.  Can you put a patch at the start
of this series that fixes them before introducing SNP.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


