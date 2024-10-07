Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E419BCFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjKS-0007Rk-CN; Mon, 07 Oct 2024 04:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxjKQ-0007Ra-Eb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sxjKO-000703-Jb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728290571;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hgwzmtV5BraAQTKXC4qHZt7MlwzUlfHpJhq4r3pomqI=;
 b=JreRFqYL9E7TYbI9YSYCJ5BqkCbCQoIY9AwtFxKZDHq2dKQ+MAE5qYyghceA8MENd4hoIZ
 c7tukU8F9XNrMJNOH/MeIVwWMjz6zRVAAG3BRgDSVwEBZAw+Zm8ogMmW9aFbBvGHkT1zBy
 3bmMA/cwMNlrP17julF7xg23QbLOfxg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-6pVX0G-8NNuKdY8Qin9wDw-1; Mon,
 07 Oct 2024 04:42:48 -0400
X-MC-Unique: 6pVX0G-8NNuKdY8Qin9wDw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08F9195419F; Mon,  7 Oct 2024 08:42:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D6F619560AE; Mon,  7 Oct 2024 08:42:43 +0000 (UTC)
Date: Mon, 7 Oct 2024 09:42:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] meson: ensure we enable CMPXCHG128 on x86_64
Message-ID: <ZwOfAE7hk503w11E@redhat.com>
References: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Oct 04, 2024 at 03:01:23PM -0700, Pierrick Bouvier wrote:
> Alex discovered that CMPXCHG128 was not enabled when building for
> x86_64, resulting in slow execution for wide atomic instructions,
> creating a huge contention when combined with a high number of cpus
> (found while booting android aarch64 guest on x86_64 host).
> 
> The problem is that even though we enable -mcx16 option for x86_64, this
> is not used when testing for CMPXCHG128. Thus, we silently turn it off.
> 
> x86_64 is the only architecture adding machine flags for now, so the
> problem is limited to this host architecture.
> 
> Meson compiler tests are supposed to be independent of environment flags
> (https://mesonbuild.com/Reference-manual_returned_compiler.html#returned-by).
> However, CFLAGS are used anyway, thus masking the problem when using
> something like CFLAGS='-march=native'. This is a meson bug and was reported:
> https://github.com/mesonbuild/meson/issues/13757
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index b18c2a54ab5..af2ce595dcc 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2867,6 +2867,13 @@ if has_int128_type
>      config_host_data.set('CONFIG_ATOMIC128_OPT', has_atomic128_opt)
>  
>      if not has_atomic128_opt
> +
> +      host_flags = []
> +      if host_arch == 'x86_64'
> +        # for x86_64, x86_version must be >= 1, and we always enable cmpxchg16
> +        # in this case.
> +        host_flags += ['-mcx16']
> +      endif

IMHO, we shouldn't be assuming that the earlier code passed '-mcx16',
as it requires that we keep 2 far away parts of meson.build in sync.

>        config_host_data.set('CONFIG_CMPXCHG128', cc.links('''
>          int main(void)
>          {
> @@ -2874,7 +2881,8 @@ if has_int128_type
>            __sync_val_compare_and_swap_16(&x, y, x);
>            return 0;
>          }
> -      '''))
> +      ''',
> +      args: host_flags))

Just pass 'qemu_common_flags' here.

>      endif
>    endif
>  endif

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


