Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9CEC27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 13:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI70t-000849-2t; Fri, 14 Jun 2024 09:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI70d-00082M-Iu
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sI70b-0001kc-O1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 09:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718371823;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TYiHbzTmtUK4QRRJjDLnRWwfPgs26MjZumaGRuYJPsg=;
 b=b/sXbKkIGr1DTimHU5sf58uPTejqC/A3zV0Hn6kd0buIpxNRKOTGFjehZ47GbCC6mdmg+5
 PoHhhKGTQiL38SPLv9ggf02hQGFDZ+RTshjszuicnbIf0/eSp2MO/wsfXOUfzpCXxO3cS+
 5soAJcFwmhvHsYEl//0hAlEUyiW5W78=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-euGQSUwtPy2rWZdca01Wbw-1; Fri,
 14 Jun 2024 09:30:19 -0400
X-MC-Unique: euGQSUwtPy2rWZdca01Wbw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6851F1955E84; Fri, 14 Jun 2024 13:30:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 644601956079; Fri, 14 Jun 2024 13:30:06 +0000 (UTC)
Date: Fri, 14 Jun 2024 14:30:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Trent Huber <trentmhuber@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] os-posix: Expand setrlimit() syscall compatibility
Message-ID: <ZmxF2lTY0hvS_HqV@redhat.com>
References: <20240614051422.13532-1-trentmhuber@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614051422.13532-1-trentmhuber@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 14, 2024 at 01:14:22AM -0400, Trent Huber wrote:
> Darwin (I'm running version 19.6.0) uses a subtly different version
> of the setrlimit() syscall as described in the COMPATIBILITY section
> of the macOS man page. I adjusted the way the rlim_cur member is set
> to accommodate and which shouldn't affect any non-Darwin systems.
> 
> Signed-off-by: Trent Huber <trentmhuber@gmail.com>
> ---
>  os-posix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/os-posix.c b/os-posix.c
> index a4284e2c07..5766346521 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -270,7 +270,7 @@ void os_setup_limits(void)
>          return;
>      }
>  
> -    nofile.rlim_cur = nofile.rlim_max;
> +    nofile.rlim_cur = OPEN_MAX < nofile.rlim_max ? OPEN_MAX : nofile.rlim_max;

There's no such constant OPEN_MAX on Linux, so this doesn't compile.

There is a sysconf() parameter _SC_OPEN_MAX, but we should not use
that as it is a dynamic value that just reflects what 'rlim_cur'
is set to, and would thus turn this into a no-op.

This should just be made conditional to macOS, since its the only
problematic platform that we known of.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


