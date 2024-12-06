Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAADEE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJb0H-0000CX-K9; Fri, 06 Dec 2024 11:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJb0F-0000C9-2u
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJb0D-00032e-5t
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733501782;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZKj98b2bDFZtI9qhO+pMCYw+TumxQOg8W1FAj7bR+F4=;
 b=aOnbEy8SvamzxVDnE8ualCWqZezvNSqb25vDRCZ6w8OT/i8Pdo28ftXDRBrPr6jWSRuKKK
 MdiKmJ+FkN6BNCWlnzJxpYT9gbXVn6WMZ6ggDBB0ze1RC4WtcaNvk7cAuuVjR4mGEceQ9r
 gFhEwn8qEVuESWFEaBNoXsMhf6eD7gM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-GCa6Vn-ZNUKP59LP6FWafw-1; Fri,
 06 Dec 2024 11:16:19 -0500
X-MC-Unique: GCa6Vn-ZNUKP59LP6FWafw-1
X-Mimecast-MFC-AGG-ID: GCa6Vn-ZNUKP59LP6FWafw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33C56195421F; Fri,  6 Dec 2024 16:16:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 805101955F3E; Fri,  6 Dec 2024 16:16:15 +0000 (UTC)
Date: Fri, 6 Dec 2024 16:16:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH v2] sched_attr: Do not define for glibc >= 2.41
Message-ID: <Z1MjS9fmqO4SLwli@redhat.com>
References: <20241011193140.1047648-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241011193140.1047648-1-raj.khem@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

ping: this patch hasn't been merged for 9.2.0 afaict, so I
presume we're broken with latest glibc...

On Fri, Oct 11, 2024 at 12:31:40PM -0700, Khem Raj wrote:
> glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
> and struct sched_attr. Therefore, it needs to be checked for here as well before
> defining sched_attr
> 
> Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0
> 
> Fixes builds with glibc/trunk
> 
> [1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> v2: Use SCHED_ATTR_SIZE_VER0 instead of glibc version check
> 
>  linux-user/syscall.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 1354e75694..caecbb765d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -359,7 +359,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
>  #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
>  _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
>            unsigned long *, user_mask_ptr);
> -/* sched_attr is not defined in glibc */
> +/* sched_attr is not defined in glibc < 2.41 */
> +#ifndef SCHED_ATTR_SIZE_VER0
>  struct sched_attr {
>      uint32_t size;
>      uint32_t sched_policy;
> @@ -372,6 +373,7 @@ struct sched_attr {
>      uint32_t sched_util_min;
>      uint32_t sched_util_max;
>  };
> +#endif
>  #define __NR_sys_sched_getattr __NR_sched_getattr
>  _syscall4(int, sys_sched_getattr, pid_t, pid, struct sched_attr *, attr,
>            unsigned int, size, unsigned int, flags);
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


