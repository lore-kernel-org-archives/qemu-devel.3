Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0776AC54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHnF-0004x8-If; Wed, 28 Aug 2024 08:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjHnD-0004qu-Tv
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:28:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sjHn9-00027Z-JB
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724848128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Zt5r48uIqzU9wc3SieuVmVxlkzgDymlhYNyKIxhJfcg=;
 b=LShf0aWLUIYkxviGZjxalJcAlVFT7fqj5sUesVzRGfBs8QYI7rNu47kgnCL/Fd5heYBkH4
 9P/MLGz+ILSppPq8uOO7yMOid6NUAQQ7tAvQFRG+F3Se7yQR5XxGDwFo0YNubQRhcKpLzL
 zU0ji8LxI0Pq5Fda6dllw5MvddZvXJc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-PI9G6oJ7OPCfgmYGyw2xYg-1; Wed,
 28 Aug 2024 08:28:42 -0400
X-MC-Unique: PI9G6oJ7OPCfgmYGyw2xYg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1437B195420D; Wed, 28 Aug 2024 12:28:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8372719560A3; Wed, 28 Aug 2024 12:28:34 +0000 (UTC)
Date: Wed, 28 Aug 2024 13:28:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 3/9] configure, meson: detect Rust toolchain
Message-ID: <Zs8X7dV4XczEM5YU@redhat.com>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-3-35579191f17c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828-rust-pl011-v9-3-35579191f17c@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Aug 28, 2024 at 07:11:44AM +0300, Manos Pitsidianakis wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Include the correct path and arguments to rustc in the native
> and cross files (native compilation is needed for procedural
> macros).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  meson.build |  8 +++-----
>  2 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/configure b/configure
> index 019fcbd0ef7b07e7b0280b358099cae72c73aa98..9ef6005c557fc627c7c6c732b4c92ed1b934f474 100755
> --- a/configure
> +++ b/configure
> @@ -207,6 +207,8 @@ for opt do
>    ;;
>    --objcc=*) objcc="$optarg"
>    ;;
> +  --rustc=*) RUSTC="$optarg"
> +  ;;
>    --cpu=*) cpu="$optarg"
>    ;;
>    --extra-cflags=*)
> @@ -252,6 +254,9 @@ python=
>  download="enabled"
>  skip_meson=no
>  use_containers="yes"
> +# do not enable by default because cross compilation requires --rust-target-triple
> +rust="disabled"
> +rust_target_triple=""
>  gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
>  gdb_arches=""
>  
> @@ -317,6 +322,8 @@ windmc="${WINDMC-${cross_prefix}windmc}"
>  pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
>  sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
>  
> +rustc="${RUSTC-rustc}"
> +
>  check_define() {
>  cat > $TMPC <<EOF
>  #if !defined($1)
> @@ -636,6 +643,8 @@ for opt do
>    ;;
>    --objcc=*)
>    ;;
> +  --rustc=*)
> +  ;;
>    --make=*)
>    ;;
>    --install=*)
> @@ -755,8 +764,14 @@ for opt do
>    ;;
>    --container-engine=*) container_engine="$optarg"
>    ;;
> +  --rust-target-triple=*) rust_target_triple="$optarg"
> +  ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
> +  --enable-rust) rust=enabled
> +  ;;
> +  --disable-rust) rust=disabled
> +  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -859,6 +874,7 @@ Advanced options (experts only):
>                             at build time [$host_cc]
>    --cxx=CXX                use C++ compiler CXX [$cxx]
>    --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
> +  --rustc=RUSTC            use Rust compiler RUSTC [$rustc]
>    --extra-cflags=CFLAGS    append extra C compiler flags CFLAGS
>    --extra-cxxflags=CXXFLAGS append extra C++ compiler flags CXXFLAGS
>    --extra-objcflags=OBJCFLAGS append extra Objective C compiler flags OBJCFLAGS
> @@ -869,8 +885,9 @@ Advanced options (experts only):
>    --python=PYTHON          use specified python [$python]
>    --ninja=NINJA            use specified ninja [$ninja]
>    --static                 enable static build [$static]
> -  --without-default-features default all --enable-* options to "disabled"
> -  --without-default-devices  do not include any device that is not needed to
> +  --rust-target-triple=TRIPLE  target for Rust cross compilation
> +  --without-default-features   default all --enable-* options to "disabled"
> +  --without-default-devices    do not include any device that is not needed to
>                             start the emulator (only use if you are including
>                             desired devices in configs/devices/)
>    --with-devices-ARCH=NAME override default configs/devices
> @@ -1139,6 +1156,21 @@ EOF
>  fi
>  
>  ##########################################
> +# detect rust triple
> +
> +if test "$rust" != disabled && has "$rustc" && $rustc -vV > "${TMPDIR1}/${TMPB}.out"; then
> +  rust_host_triple=$(sed -n 's/^host: //p' "${TMPDIR1}/${TMPB}.out")
> +else
> +  if test "$rust" = enabled; then
> +    error_exit "could not execute rustc binary \"$rustc\""
> +  fi
> +  rust=disabled
> +fi
> +if test "$rust" != disabled && test -z "$rust_target_triple"; then
> +  rust_target_triple=$rust_host_triple
> +fi

Defaulting to the $rust_host_triple is incorrect when QEMU has been
told to build for a non-host target.

Either we need todo the right thing and auto-set rust target based
on QEMU target (preferred), or we need to make it a fatal error
when rust target is omitted & QEMU is building a non-host target.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


