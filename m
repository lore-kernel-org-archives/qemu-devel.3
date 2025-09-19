Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F243CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzc3t-0003nK-Ik; Fri, 19 Sep 2025 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzc3r-0003mo-19
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzc3k-0005cj-3E
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758291956;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqQXbDfsN693Pf58VPUSWBhSRY+3aGV0qGV9Sa5wdk0=;
 b=PQda2Q7XSeOhKycuQPIVSKgUmiC1TCzVU+ios+8tLgSDrWiq0oEBq26xGfVoRfGYb2aJ+e
 57UMD5DaUiXURh8E9kRiS6du4bqKew4mTaGlYO/MYrRcm5JsCLajpZlKeUIpCgkYMXctiU
 fXz36Fo1vUbZjMb2oi76B66YXysC9Q0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-7fAE6LZOMKexZQW9JiIXEw-1; Fri,
 19 Sep 2025 10:25:53 -0400
X-MC-Unique: 7fAE6LZOMKexZQW9JiIXEw-1
X-Mimecast-MFC-AGG-ID: 7fAE6LZOMKexZQW9JiIXEw_1758291950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 252581956089; Fri, 19 Sep 2025 14:25:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A7F01955F21; Fri, 19 Sep 2025 14:25:46 +0000 (UTC)
Date: Fri, 19 Sep 2025 15:25:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 16/24] build-sys: cfi_debug and safe_stack are not
 compatible
Message-ID: <aM1n5j0WzFVaaqVK@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-17-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919133320.240145-17-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 19, 2025 at 05:33:10PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> It fails to link on fedora >= 41:
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memcpy':
> (.text.__sanitizer_internal_memcpy+0x0): multiple definition of `__sanitizer_internal_memcpy'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memcpy+0x0): first defined here
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memmove':
> (.text.__sanitizer_internal_memmove+0x0): multiple definition of `__sanitizer_internal_memmove'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memmove+0x0): first defined here
> /usr/bin/ld: /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.safestack.a(safestack.cpp.o): in function `__sanitizer_internal_memset':
> (.text.__sanitizer_internal_memset+0x0): multiple definition of `__sanitizer_internal_memset'; /usr/bin/../lib/clang/20/lib/x86_64-redhat-linux-gnu/libclang_rt.ubsan_standalone.a(sanitizer_libc.cpp.o):(.text.__sanitizer_internal_memset+0x0): first defined here
> 
> cfi_debug seems to pull ubsan which has conflicting symbols with safe_stack.

If this is caused by the switch of dockerfiles from Fedora 40 to 41,
then this commit should be ordered earlier in the series before that
switch so that we are bisectable.

Also if this is a regression in F41 it is probably worth a bug report
against clang in Fedora, that could be referenced in the commit msg.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  meson.build                | 16 ++++++++++------
>  .gitlab-ci.d/buildtest.yml |  6 +++---
>  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 6ade30f36a..856c8f1a85 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -681,13 +681,17 @@ if get_option('cfi')
>      error('-fsanitize-cfi-icall-generalize-pointers is not supported by the compiler')
>    endif
>    if get_option('cfi_debug')
> -    if cc.compiles('int main () { return 0; }',
> -                   name: '-fno-sanitize-trap=cfi-icall',
> -                   args: ['-flto', '-fsanitize=cfi-icall',
> -                          '-fno-sanitize-trap=cfi-icall'] )
> -      cfi_flags += '-fno-sanitize-trap=cfi-icall'
> +    if get_option('safe_stack')
> +      error('cfi_debug is not compatible with safe_stack')

IIUC error() terminates meson execution, so it could just
have an 'endif' where and avoid re-indenting all the
following code.

>      else
> -      error('-fno-sanitize-trap=cfi-icall is not supported by the compiler')
> +      if cc.compiles('int main () { return 0; }',
> +                    name: '-fno-sanitize-trap=cfi-icall',
> +                    args: ['-flto', '-fsanitize=cfi-icall',
> +                            '-fno-sanitize-trap=cfi-icall'] )
> +        cfi_flags += '-fno-sanitize-trap=cfi-icall'
> +      else
> +        error('-fno-sanitize-trap=cfi-icall is not supported by the compiler')
> +      endif
>      endif
>    endif
>    add_global_arguments(cfi_flags, native: false, language: all_languages)
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 8378b663b6..94d646c5a7 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -479,7 +479,7 @@ build-cfi-aarch64:
>      LD_JOBS: 1
>      AR: llvm-ar
>      IMAGE: fedora
> -    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
>        --enable-safe-stack --disable-slirp
>      TARGETS: aarch64-softmmu
>      MAKE_CHECK_ARGS: check-build
> @@ -517,7 +517,7 @@ build-cfi-ppc64-s390x:
>      LD_JOBS: 1
>      AR: llvm-ar
>      IMAGE: fedora
> -    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
>        --enable-safe-stack --disable-slirp
>      TARGETS: ppc64-softmmu s390x-softmmu
>      MAKE_CHECK_ARGS: check-build
> @@ -555,7 +555,7 @@ build-cfi-x86_64:
>      LD_JOBS: 1
>      AR: llvm-ar
>      IMAGE: fedora
> -    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi --enable-cfi-debug
> +    CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-cfi
>        --enable-safe-stack --disable-slirp
>      TARGETS: x86_64-softmmu
>      MAKE_CHECK_ARGS: check-build
> -- 
> 2.51.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


