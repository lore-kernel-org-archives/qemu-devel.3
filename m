Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B59C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 13:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjfqE-00017t-Vg; Mon, 11 Mar 2024 09:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjfq5-00017L-Uo
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rjfps-0007pr-7H
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 09:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710164219;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IheZWDhBe9DbxPVN8HZzOVu3M0anV98upMkofxaYf2c=;
 b=IZV2p40csc72t/3XhsB8pPspbvbwN1orzDukJx7A6M6UAxJISlmPeGYt7CJ3U/Xsk6N8qu
 CeGb6z/6OXGqLbvWRl3v54huIsWH9O9Q0Q+Gjd+6pb1f9o7CgcQKvYXGjaVN+A7E3doNgk
 qW+uNtveEOdF0QrNaGyW0HhoVY8+IDs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-HcvJw1a9NNe7fCWP1FDopw-1; Mon,
 11 Mar 2024 09:36:57 -0400
X-MC-Unique: HcvJw1a9NNe7fCWP1FDopw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45DAE28C9805;
 Mon, 11 Mar 2024 13:36:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E865C04122;
 Mon, 11 Mar 2024 13:36:56 +0000 (UTC)
Date: Mon, 11 Mar 2024 13:36:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson.build: Always require an objc compiler on macos
 hosts
Message-ID: <Ze8I9hDQIJGGv0nt@redhat.com>
References: <20240311133334.3991537-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311133334.3991537-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Mar 11, 2024 at 01:33:34PM +0000, Peter Maydell wrote:
> We currently only insist that an ObjectiveC compiler is present on
> macos hosts if we're building the Cocoa UI.  However, since then
> we've added some other parts of QEMU which are also written in ObjC:
> the coreaudio audio backend, and the vmnet net backend.  This means
> that if you try to configure QEMU on macos with --disable-cocoa the
> build will fail:
> 
> ../meson.build:3741:13: ERROR: No host machine compiler for 'audio/coreaudio.m'
> 
> Since in practice any macos host will have an ObjC compiler
> available, rather than trying to gate the compiler detection on an
> increasingly complicated list of every bit of QEMU that uses ObjC,
> just require it unconditionally on macos hosts.
> 
> Resolves https://gitlab.com/qemu-project/qemu/-/issues/2138
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Per the commit message, in theory we could allow a no-objc
> build and disable coreaudio, vmnet, etc. But I didn't really see
> a reason why that would be useful, and it's bound to keep
> breaking unless we actively defend it in CI. So I preferred
> to simply require ObjC on macos.

Yeah, I think simplicity wins here, unless someone can provide
a compelling reason why they absolutely must be able to build
without objc being present, even if it were unused.

>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


> 
> diff --git a/meson.build b/meson.build
> index f9dbe7634e5..e3fab8ce9ff 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -66,7 +66,7 @@ if host_os == 'windows' and add_languages('cpp', required: false, native: false)
>    cxx = meson.get_compiler('cpp')
>  endif
>  if host_os == 'darwin' and \
> -   add_languages('objc', required: get_option('cocoa'), native: false)
> +   add_languages('objc', required: true, native: false)
>    all_languages += ['objc']
>    objc = meson.get_compiler('objc')
>  endif
> -- 
> 2.34.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


