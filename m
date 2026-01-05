Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B33BC2A088
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 10:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vchxw-0004w4-NL; Mon, 05 Jan 2026 05:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vchxm-0004uX-TZ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vchxl-0007Hj-Ao
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767609444;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2ZlvNUV05u8Qi3iZLdgYtH7S9543Wp7Fsz+j9Y1350U=;
 b=JvR2W/2MERg/a2hf5h5hFSen34NjCmt0Pg2tqTWLkeoOWtZ+tfQCraBQq1duA6VW2jbnkS
 4PdnPmbi/cOc4dFuwAieM9JoATNsPNuy9scEvYYNxyHtOig7j4+0YNrgtSM3CGUiutykC/
 ASn4pruGu93zfBtEa0blnOMHYlL1+gM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-tKJzy5hyMV6yobkiQS2O1Q-1; Mon,
 05 Jan 2026 05:37:22 -0500
X-MC-Unique: tKJzy5hyMV6yobkiQS2O1Q-1
X-Mimecast-MFC-AGG-ID: tKJzy5hyMV6yobkiQS2O1Q_1767609441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03C7F19560B2; Mon,  5 Jan 2026 10:37:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C22A19560A7; Mon,  5 Jan 2026 10:37:19 +0000 (UTC)
Date: Mon, 5 Jan 2026 10:37:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, philmd@linaro.org
Subject: Re: [PATCH] monitor: disable "info kvm" if !KVM
Message-ID: <aVuUXHT9dt9-ytkG@redhat.com>
References: <20260105034309.11308-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105034309.11308-1-guobin@linux.alibaba.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 05, 2026 at 11:43:09AM +0800, Bin Guo wrote:

Missing commit message explaining why we should do this ?

The 'hmp_info_kvm' implementation is unconditionally built and this patch
isn't changing that, so this result in building unused code.

Conceptually even if KVM is not built, it makes sense to have an
'info kvm' command to tell the user that KVM is not available.

> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  hmp-commands-info.hx | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 41674dcbe1..1927649493 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -294,6 +294,7 @@ SRST
>      being coalesced.
>  ERST
>  
> +#if defined(CONFIG_KVM)
>      {
>          .name       = "kvm",
>          .args_type  = "",
> @@ -301,6 +302,7 @@ ERST
>          .help       = "show KVM information",
>          .cmd        = hmp_info_kvm,
>      },
> +#endif
>  
>  SRST
>    ``info kvm``
> -- 
> 2.50.1 (Apple Git-155)
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


