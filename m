Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B0AC3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLmvg-0008Ti-10; Mon, 24 Jun 2024 12:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLmvd-0008TD-T1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLmvY-00009g-Ef
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 12:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719247943;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=llpvSV62JQaxnuw6MTYZruZzcT7eOgPQdd6jb39f2Co=;
 b=RhH9O6nnC5dAK+JjVgjILTYJO9/8PuDUT58SyPZNXOkJq+Cqch2+MYxUM/U+DhIfdjsnse
 lMpOlOEmR1J1MNK57zwNXz3bgknmpjKJ+ECF0h52tn3NBGnL3EosUiF7CTKdOocbscUEsQ
 Gsy2vVw36Ifob18OOxlRQKHIVatXQFU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-JmX5wpcAOquDDyg4W40aew-1; Mon,
 24 Jun 2024 12:52:20 -0400
X-MC-Unique: JmX5wpcAOquDDyg4W40aew-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F387A1955EF2; Mon, 24 Jun 2024 16:52:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BCAC195605B; Mon, 24 Jun 2024 16:52:11 +0000 (UTC)
Date: Mon, 24 Jun 2024 17:52:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
Message-ID: <ZnmkN2PL3r-2sxqe@redhat.com>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 19, 2024 at 11:13:58PM +0300, Manos Pitsidianakis wrote:
> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
> 
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.
> 
> A cargo_wrapper.py script is added that is heavily based on the work of
> Marc-André Lureau from 2021.
> 
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.com/
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS                   |   5 +
>  configure                     |  11 ++
>  meson.build                   |  11 ++
>  meson_options.txt             |   4 +
>  scripts/cargo_wrapper.py      | 279 ++++++++++++++++++++++++++++++++++
>  scripts/meson-buildoptions.sh |   6 +
>  6 files changed, 316 insertions(+)
>  create mode 100644 scripts/cargo_wrapper.py

> diff --git a/configure b/configure
> index 38ee257701..6894d7c2d1 100755
> --- a/configure
> +++ b/configure
> @@ -302,6 +302,9 @@ else
>    objcc="${objcc-${cross_prefix}clang}"
>  fi
>  
> +with_rust="auto"

On last week's call one of the things we discussed is the expectations
for consumers of QEMU around the usage of Rust & its optionality (or
not) long term.

If we consider Rust to be an optional feature, then this largely
precludes re-writing existing C code in Rust, as we would be
forced to either remove existing features from users, or maintain
parallel impls in both C & Rust. Neither of these are desirable
situations.

I'm of the view that to be valuable for QEMU, we need to consider
Rust to become a mandatory feature. There's a question of how quickly
we move, however, before declaring it mandatory. The longer we take
to declare it mandatory, the longer we are limiting the value we
can take from Rust.

If we want to make Rust mandatory, then we should set the user
expectations to reflect this from the start.


IOW, with_rust="enabled" should be the default, and require an
explicit  --disable-rust to opt-out on a very time limited
basis.  Any use of --disable-rust ought to print a warning at
the end of configure, and solicit feedback:

    WARNING: Building without Rust is deprecated. QEMU intends
    WARNING: to make Rust a mandatory build dependency in the
    WARNING: 10.0.0 release.
    WARNING:
    WARNING: If you have concerns about this requirement
    WARNING: please contact qemu-devel@nongnu.org

I illustrated '10.0.0' on the assumption that we add Rust
support in 9.1.0, and thus have 2 releases where it is
optional to align with our deprecation policy. Even though
we don't usually apply our deprecation policy to build
dependencies, this is a significant unique situation so
IMHO worth doing.


> +with_rust_target_triple=""
> +
>  ar="${AR-${cross_prefix}ar}"
>  as="${AS-${cross_prefix}as}"
>  ccas="${CCAS-$cc}"
> @@ -760,6 +763,12 @@ for opt do
>    ;;
>    --gdb=*) gdb_bin="$optarg"
>    ;;
> +  --enable-with-rust) with_rust=enabled
> +  ;;
> +  --disable-with-rust) with_rust=disabled
> +  ;;

--enable-with-XXX / --disable-with-XXX is pretty unsual naming.

Normally you'd see either --enable-XXX or --with-XXX and their
corresponding --disable-XXX or --without-XXX.




> +  --with-rust-target-triple=*) with_rust_target_triple="$optarg"

As with previous posting, IMHO, this should ideally not exist. We should
honour the --cross-prefix= values, re-mapping to to Rust targets for all
the combos we know about. --with-rust-target-triple should only be needed
as a workaround for where we might have missed a mapping.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


