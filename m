Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CE3C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 09:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7te0-0001VT-JC; Fri, 17 May 2024 05:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7tdy-0001VG-Un
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7tdl-0006cK-1G
 for qemu-devel@nongnu.org; Fri, 17 May 2024 05:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715937156;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IE3FSYVikvu5n72OJ0VEJA/xQ83Vm15yLEwhA1ohotY=;
 b=FNkaAnRJVqX7vLEQpGUgjwHP4m7YtFCSuaqm05Jq0/hbeIujIx83Sf3JBVihHicEC9DiRC
 G+I5zOp4n9mJVgSM6NCwGBxyCkXYiBCtKInQcskwJU4dDA0yW+H49+Kzh6ykL3A0PSQceA
 PUvw+XW3clYZyViqjPkF1XZlZ9viTVc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-eQYQvg80MuKTrStGAsJHpw-1; Fri,
 17 May 2024 05:12:32 -0400
X-MC-Unique: eQYQvg80MuKTrStGAsJHpw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76FCC29AA3BB;
 Fri, 17 May 2024 09:12:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DB1E2026D68;
 Fri, 17 May 2024 09:12:31 +0000 (UTC)
Date: Fri, 17 May 2024 10:12:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 3/3] crypto: Allow building with GnuTLS but without
 Libtasn1
Message-ID: <ZkcfffathdJlq67Y@redhat.com>
References: <20240502095642.93368-1-philmd@linaro.org>
 <20240502095642.93368-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240502095642.93368-4-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, May 02, 2024 at 11:56:42AM +0200, Philippe Mathieu-Daudé wrote:
> We only use Libtasn1 in unit tests. As noted in commit d47b83b118
> ("tests: add migration tests of TLS with x509 credentials"), having
> GnuTLS without Libtasn1 is a valid configuration, so do not require
> Libtasn1, to avoid:
> 
>   Dependency gnutls found: YES 3.7.1 (cached)
>   Run-time dependency libtasn1 found: NO (tried pkgconfig)
> 
>   ../meson.build:1914:10: ERROR: Dependency "libtasn1" not found, tried pkgconfig

Did you actually try to build without libtasn1 present ?

If I remove /usr/lib64/pkgconfig/libtasn1.pc, then the prior
check for 'gnutls' itself will fail, as libtasn1 is declared
to be a dep of gnutls in its pkg-config file, regardless of
what QEMU askes for:

$ pkg-config --cflags --libs gnutls
Package libtasn1 was not found in the pkg-config search path.
Perhaps you should add the directory containing `libtasn1.pc'
to the PKG_CONFIG_PATH environment variable
Package 'libtasn1', required by 'gnutls', not found

I'm still willing to merge this, because from QEMU's POV,
libtasn1 isn't required.

> 
> Fixes: ba7ed407e6 ("configure, meson: convert libtasn1 detection to meson")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  meson.build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/meson.build b/meson.build
> index 5db2dbc12e..837a2bdb56 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1912,6 +1912,7 @@ endif
>  tasn1 = not_found
>  if gnutls.found()
>    tasn1 = dependency('libtasn1',
> +                     required: false,
>                       method: 'pkg-config')
>  endif
>  keyutils = not_found
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


