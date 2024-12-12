Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC81E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfIq-0000PB-7t; Thu, 12 Dec 2024 04:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfIP-0008Ti-E5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLfIN-0000oY-BP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733994942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1hi8Rsrd5xJM1UH4n1aYBVrLxGdPyimCMsMDwlYp/uQ=;
 b=BqLql+WAiyFWb4jK85Cuk7zTuQnFue1ooyKSa0uxfXwcUmaVBUb8fs/WRGf3jKOh608mgU
 Te7+2C3uCfRjtOAWF+eXCCZMt1XCz4IjCLxaRnu4rrfrymUp6AAKC8WcidSj/kHZkwedrl
 2YuIv1d1oH5Q6u39tjTA3ZLzfcAPvkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-OmannoLsPe2FXqizerVRqw-1; Thu,
 12 Dec 2024 04:15:38 -0500
X-MC-Unique: OmannoLsPe2FXqizerVRqw-1
X-Mimecast-MFC-AGG-ID: OmannoLsPe2FXqizerVRqw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10BBB19560B3; Thu, 12 Dec 2024 09:15:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E5CF300FA97; Thu, 12 Dec 2024 09:15:35 +0000 (UTC)
Date: Thu, 12 Dec 2024 09:15:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH] meson: Run some compiler checks using
 -Wno-unused-value
Message-ID: <Z1qptPHK6QOh_TRH@redhat.com>
References: <20241211231655.98148-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211231655.98148-1-philmd@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

On Thu, Dec 12, 2024 at 12:16:55AM +0100, Philippe Mathieu-Daudé wrote:
> When running Clang static analyzer on macOS I'm getting:


snip

> Fix by explicitly disabling -Wunused-value from these meson checks.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: Probably meson should do that in has_header_symbol() / has_type()?

How are you enabling the use of static analyzers ?  There are several
different ways to change compiler options and I vaguely recall some
approaches can trip up meson.


> ---
>  meson.build | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 147097c652e..a431aa982ac 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1166,7 +1166,8 @@ cocoa = dependency('appleframeworks',
>  vmnet = dependency('appleframeworks', modules: 'vmnet', required: get_option('vmnet'))
>  if vmnet.found() and not cc.has_header_symbol('vmnet/vmnet.h',
>                                                'VMNET_BRIDGED_MODE',
> -                                              dependencies: vmnet)
> +                                              dependencies: vmnet,
> +                                              args: '-Wno-unused-value')
>    vmnet = not_found
>    if get_option('vmnet').enabled()
>      error('vmnet.framework API is outdated')
> @@ -2690,7 +2691,7 @@ config_host_data.set('CONFIG_RTNETLINK',
>  config_host_data.set('CONFIG_SYSMACROS',
>                       cc.has_header_symbol('sys/sysmacros.h', 'makedev'))
>  config_host_data.set('HAVE_OPTRESET',
> -                     cc.has_header_symbol('getopt.h', 'optreset'))
> +                     cc.has_header_symbol('getopt.h', 'optreset', args: '-Wno-unused-value'))
>  config_host_data.set('HAVE_IPPROTO_MPTCP',
>                       cc.has_header_symbol('netinet/in.h', 'IPPROTO_MPTCP'))
>  
> @@ -2708,10 +2709,12 @@ config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
>  # has_type
>  config_host_data.set('CONFIG_IOVEC',
>                       cc.has_type('struct iovec',
> -                                 prefix: '#include <sys/uio.h>'))
> +                                 prefix: '#include <sys/uio.h>',
> +                                 args: '-Wno-unused-value'))
>  config_host_data.set('HAVE_UTMPX',
>                       cc.has_type('struct utmpx',
> -                                 prefix: '#include <utmpx.h>'))
> +                                 prefix: '#include <utmpx.h>',
> +                                 args: '-Wno-unused-value'))
>  
>  config_host_data.set('CONFIG_EVENTFD', cc.links('''
>    #include <sys/eventfd.h>
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


