Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87834C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKI33-0000Ld-0A; Thu, 20 Jun 2024 09:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKI31-0000Kj-UX
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:41:55 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKI2z-0005px-F6
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 09:41:55 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d280e2d5dso212316a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718890911; x=1719495711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WGVE6bacOXyeyjuV9YJCqy1fmtZxN0dyDUEVXERGhAc=;
 b=U9Hce7ZcUImHb56K89EhQmGG9+MHCutlNRRgPu5qzz2i8i9hqvB5N1QOOc2bW+5oLF
 aEHtbikbqUXhAxMn4MVxlVMZIfrxsh5rH1PxfSs+04+QDGL8XxUkFKDg23Du4Oh2UQAy
 e8Ptq82imSmsPOAVRUC4X6wedp+pcjTj/kCc7QZ7WlR8VPgj1E/LlrkdGnq+hYl4fEc1
 XpQb+uBJSNwwiO73LCHBfIVX4O93Dl3ikofewFFCx431q2ZHhYAS1SUf44d5yu6cGEUH
 hr+o5+c6T0lCsBYvh+bYWbSpRq27BdO5fWaAjf+8ipcs6cwH+V2oEyqn9ZcrZaR/5lcb
 gizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718890911; x=1719495711;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGVE6bacOXyeyjuV9YJCqy1fmtZxN0dyDUEVXERGhAc=;
 b=u4NDPlhnC4Z8QDcNNauDB5ZR5fmKuoRf7UXLT+Rhut48yfFzt8VPurkEpK4IMouZHd
 OeQWLfr+lKHAS+NBYwOwj109hXub/2WrJsFLTpCsqiPobr/kyuxUUmS680UfAwKT1ori
 NWci/UqBZSYBm/cgGPUVX5SRK4y1ATjyUW2e0DHEyIGNQSEAafgwk67AbjNh22pgH08M
 k6+PdqGXTinsHtyjGN+ZEhFfKvgJ0kjYdHO5pQECYP7yMFHVG+y37LBW0uAyBdqZAJzc
 jMNZuHvHZEXiuhvscOhbr4dsnppweW8KvcdLwz9D8oB8N8vCgDw3/E0ClyyoM3StVUZA
 jJDA==
X-Gm-Message-State: AOJu0Yw41YEb9pt36VwMUjB3wPaYjedPH/lS6QYZTH9Qy3vLAlJOnjxE
 /XyLILLsTJmWlh/TshXtqE4jiwe5FkYQ+7hg7ztjpw3Gzi5DhSFudVEbarL0Yro=
X-Google-Smtp-Source: AGHT+IHNehz4YpJM3jbj5HbqG5OfsYBuNrUQITNacn4uv+g3RwhS2JK/O9X1T++OqUKAQafWHCNJJA==
X-Received: by 2002:a17:907:c283:b0:a6f:d1f:6469 with SMTP id
 a640c23a62f3a-a6fab7d7eadmr311222966b.64.1718890910946; 
 Thu, 20 Jun 2024 06:41:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f43220sm765024566b.185.2024.06.20.06.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:41:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 65C335F7B1;
 Thu, 20 Jun 2024 14:41:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Mads
 Ynddal <mads@ynddal.dk>,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  rowan.hart@intel.com,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 1/5] build-sys: Add rust feature option
In-Reply-To: <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Wed, 19 Jun 2024 23:13:58 +0300")
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <e74803e6b570ab36ebc538dd84dc7c4bc2fbe4e7.1718827153.git.manos.pitsidianakis@linaro.org>
Date: Thu, 20 Jun 2024 14:41:45 +0100
Message-ID: <87y16zbujq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add options for Rust in meson_options.txt, meson.build, configure to
> prepare for adding Rust code in the followup commits.
>
> `rust` is a reserved meson name, so we have to use an alternative.
> `with_rust` was chosen.
>
> A cargo_wrapper.py script is added that is heavily based on the work of
> Marc-Andr=C3=A9 Lureau from 2021.
>
> https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat=
.com/
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
<snip>
>=20=20
> +with_rust=3D"auto"
> +with_rust_target_triple=3D""
> +
>  ar=3D"${AR-${cross_prefix}ar}"
>  as=3D"${AS-${cross_prefix}as}"
>  ccas=3D"${CCAS-$cc}"
> @@ -760,6 +763,12 @@ for opt do
>    ;;
>    --gdb=3D*) gdb_bin=3D"$optarg"
>    ;;
> +  --enable-with-rust) with_rust=3Denabled
> +  ;;
> +  --disable-with-rust) with_rust=3Ddisabled
> +  ;;
> +  --with-rust-target-triple=3D*) with_rust_target_triple=3D"$optarg"
> +  ;;
>    # everything else has the same name in configure and meson
>    --*) meson_option_parse "$opt" "$optarg"
>    ;;
> @@ -1796,6 +1805,8 @@ if test "$skip_meson" =3D no; then
>    test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_eng=
ine=3D$LIB_FUZZING_ENGINE"
>    test "$plugins" =3D yes && meson_option_add "-Dplugins=3Dtrue"
>    test "$tcg" !=3D enabled && meson_option_add "-Dtcg=3D$tcg"
> +  test "$with_rust" !=3D enabled && meson_option_add "-Dwith_rust=3D$wit=
h_rust"
> +  test "$with_rust_target_triple" !=3D "" && meson_option_add "-Dwith_ru=
st_target_triple=3D$with_rust_target_triple"
>    run_meson() {
>      NINJA=3D$ninja $meson setup "$@" "$PWD" "$source_path"
>    }
<snip>

> +summary_info +=3D {'Rust support':      with_rust}
> +if with_rust and get_option('with_rust_target_triple') !=3D ''
> +  summary_info +=3D {'Rust target':     get_option('with_rust_target_tri=
ple')}
> +endif
<snip>

I wonder if we should display the auto-probed triple here as well, not
just when its been overridden?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

