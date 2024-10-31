Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0701E68960
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 09:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6RTn-0000gk-49; Thu, 31 Oct 2024 05:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6RTj-0000g6-EN
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 05:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6RTh-00069U-Qn
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 05:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730366908;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=opD8yU2sWxv0Mq2AIp1EHZru+nG3HCzouc/IYpajjnE=;
 b=CM68JtWuTDYah4VZrJbG+ap1X6uAnlOrme4KlwdXHUa1TDR8DjmacN2BcPFOf/nqQBNu9d
 a5zMPnUh4FCKLlRPUDc+UGcea2/vyrUTl4cjKn9NTSK20+Em1l3nSB5GOUtWHIY+9ezuWX
 rJVs2EeQRUjD+uBwqIOvrtP+FIPy2+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-8_9yn8CZOIa0R3hNrGlmDQ-1; Thu,
 31 Oct 2024 05:28:24 -0400
X-MC-Unique: 8_9yn8CZOIa0R3hNrGlmDQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C77CC1956046; Thu, 31 Oct 2024 09:28:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B33F91956086; Thu, 31 Oct 2024 09:28:16 +0000 (UTC)
Date: Thu, 31 Oct 2024 09:28:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH 07/12] win32: use compiler option instead of attribute
 gcc_struct
Message-ID: <ZyNNrKi2Of8j5WEh@redhat.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-8-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031040426.772604-8-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Wed, Oct 30, 2024 at 09:04:21PM -0700, Pierrick Bouvier wrote:
> This attribute is not recognized by clang, but the associated option is.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build                               | 8 ++++----
>  include/qemu/compiler.h                   | 7 +------
>  subprojects/libvhost-user/libvhost-user.h | 6 +-----
>  3 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index d8af08299e0..d0d5dbe1479 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -330,10 +330,10 @@ elif host_os == 'sunos'
>  elif host_os == 'haiku'
>    qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
>  elif host_os == 'windows'
> -  if not compiler.compiles('struct x { int y; } __attribute__((gcc_struct));',
> -                           args: '-Werror')
> -    error('Your compiler does not support __attribute__((gcc_struct)) - please use GCC instead of Clang')
> -  endif
> +  # https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html
> +  # We use this compilation option instead of relying on gcc_struct attribute
> +  # because clang does not support it (but supports the option).
> +  qemu_common_flags += ['-mno-ms-bitfields']
>  endif

Is this really safe for us to use ?   The current gcc_struct
attribute affects only structs marked as QEMU_PACKED. This
flag will affect all code.

If we call from QEMU code into Windows native APIs, and pass
or receive structs, then those structs' layouts would be
affected by this flag. I don't have a specific example, but
this feels unsafe to me, otherwise we would have done this
originally rather than only targetting internal packed structs
with the gcc_struct attribute.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


