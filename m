Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509B2CD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmv7c-0004l7-BI; Wed, 20 Mar 2024 08:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmv7a-0004kT-Eh
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:32:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmv7Q-0005Dy-2V
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710937950;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bRCs6pJZlFIY6ep11w8M2fUuPY6eTctoVDx3pBqwico=;
 b=RWlo4JbdFEO+8s/mhLXcnbkZW+UbAN171bkUa4xctx/I4GEgm4Fd3w/i2yK4/TyK7Oq5mg
 t017T7das9OLHKJpKkEaY51gaw83uKhvyURqZF3645vzivRMZno0ojsKXhYjGhP3wblg8L
 qwXZ7APxiFPa9VKrl1RkKveISPEqq4Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-HyhpaZ7BPIapRW4mNxVJ6g-1; Wed,
 20 Mar 2024 08:32:26 -0400
X-MC-Unique: HyhpaZ7BPIapRW4mNxVJ6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70D651C54460;
 Wed, 20 Mar 2024 12:32:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FA37492BDA;
 Wed, 20 Mar 2024 12:32:25 +0000 (UTC)
Date: Wed, 20 Mar 2024 12:32:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Subject: Re: [PATCH v3 28/49] i386/sev: Disable SMM for SNP
Message-ID: <ZfrXU1VZVak-OHIs@redhat.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-29-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320083945.991426-29-michael.roth@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

On Wed, Mar 20, 2024 at 03:39:24AM -0500, Michael Roth wrote:
> SNP does not support SMM.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  target/i386/sev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index b06c796aae..134e8f7c22 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -881,6 +881,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
>      SevCommonState *sev_common = SEV_COMMON(cgs);
>      MachineState *ms = MACHINE(qdev_get_machine());
> +    X86MachineState *x86ms = X86_MACHINE(ms);
>      char *devname;
>      int ret, fw_error, cmd;
>      uint32_t ebx;
> @@ -1003,6 +1004,13 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  
>      if (sev_snp_enabled()) {
>          ms->require_guest_memfd = true;
> +
> +        if (x86ms->smm == ON_OFF_AUTO_AUTO) {
> +            x86ms->smm = ON_OFF_AUTO_OFF;
> +        } else if (x86ms->smm == ON_OFF_AUTO_ON) {
> +            error_report("SEV-SNP does not support SMM.");
> +            goto err;
> +        }
>      }

This method has a 'Error **errp' parameter, so you must use
error_setg, not error_report.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


