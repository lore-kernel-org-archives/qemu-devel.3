Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A42CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 12:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqADb-0002lN-9p; Thu, 06 Mar 2025 07:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqADK-0002jk-C5
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:20:35 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqADH-0004J4-DJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 07:20:33 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abf57138cfaso108433766b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741263628; x=1741868428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rT1YCztb4Hh7u9SljOfPZl9P0rIXzctNgjxjZmwRtIc=;
 b=BRh9M+G5rvIMfdty1Ii72fSvBFmN98bP7EW8BNY4mhgTaARFTHK5LCyNaQJBdsyO6/
 g7bihQQ023K+U1Y3ZNZldjbClv0Zqy2KLjXyUcy7WW+Tkram+E6WKe4HiVr4kRT1vCUH
 bwCr5+fGYSpsDxJA+JFVHvLEtq46Zf/WgWwoKfR6+RfOybsz/U3lgI7Rd1evbNFcwStg
 /05JEkpqFfo7R+DiGjRfCMplBiiWbNV/Pkv3pf5OVEpmGLiLrh0SGLYpGHTIlcTPW6KA
 nUWJW6l0Skhg/fXM+HMVrRwURuvVSxHvRw6k/OwMZGyoZ/LHnV9VNadHc+s9TFcjuBp8
 9xAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741263628; x=1741868428;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rT1YCztb4Hh7u9SljOfPZl9P0rIXzctNgjxjZmwRtIc=;
 b=s0g0v6WVyuEtBqE6VUcAFVhrkxY9RYWKV14H6LQLwP1vbRPwmKp7EhVfXZR+ZquFe6
 omSB66aDY1EGXBgIdQBRI2uWsefnUcVr883FB4Nt+osCtmppqfE96TEM+Q2PUHol55s1
 PlT/nEmRKoRDlgSw/HAtnw7VaxDBR+mkyzPlCr/tG8cYHddZyBY1+C9Urwjfo0JkSGFh
 fvd2DwMFYyk+jv5Vek1UlU9GehMs/ZuEIhFVUbcCt6loD+wkapbvrXCTmEuWVt27cL7p
 CaDnLRbSCF/WsAaAYswZmTOK852c3mvScFFPaTqnPeWbwvllqWIcaQtWtkS04YUOMcUU
 5bSA==
X-Gm-Message-State: AOJu0YwVty6jVE6uqCyBRt704ELCQsaEwtoo8/L1TTlKNsVyKEShu+MJ
 n9vlmspcnOvTTzGz4Tiu9gegTXVJ07zVJQe0xBP8m++Vw/ZJsjkigciu9vb04f4=
X-Gm-Gg: ASbGncurdeUDdbiiEyE9372HDyzDho1rI6h2Vb/i328pqzHoE51TF/12w18lUwhGbQw
 3JHx/bzZ86U/fZCHF3em7x51TT225FGTYP8lhKW0kjE7C7xh31BPwjLng6UxSy3MfOffh5ZDfxK
 R23B2wHgzyk7zIZYDSFcCpcPAHL29Vrw2Ps6Ea5a1vb5xctNKVhNF1CINmrQyU2nPRC31S1X7M8
 qKv9n+57ZG7BbJ7pP9hjf7qfdgfVaREXglHo9gcgH9Nb61G6Mh6tFbTkIijB3p34PJ0+4pdEMyR
 Safr8WgOTpbiNIvuGZe+Su83oU3ZneTLYnNLg8CqAbTCwzE=
X-Google-Smtp-Source: AGHT+IGsS6u7RiEQGIRRSqNpad5wb/GVJxpyjnpQ9ll5i6Uw8c/E/Zr73jdwK6Z04SR2eAEHimgK9w==
X-Received: by 2002:a17:907:3f29:b0:ac1:e889:c2a with SMTP id
 a640c23a62f3a-ac20da47762mr645255566b.11.1741263627667; 
 Thu, 06 Mar 2025 04:20:27 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac23988c54esm87204566b.132.2025.03.06.04.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 04:20:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A88BE5F9CF;
 Thu,  6 Mar 2025 12:20:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] meson.build: default to -gsplit-dwarf for debug info
In-Reply-To: <CABgObfZpf7Oki+0rH-3OTBLF_cW8+5e-jAaG=AU58oAn8CP=5w@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 6 Mar 2025 12:36:40 +0100")
References: <20250306105306.2064458-1-alex.bennee@linaro.org>
 <CABgObfZpf7Oki+0rH-3OTBLF_cW8+5e-jAaG=AU58oAn8CP=5w@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 06 Mar 2025 12:20:25 +0000
Message-ID: <877c524agm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il gio 6 mar 2025, 11:53 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scr=
itto:
>
>  -option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  +option_cflags =3D []
>  +if get_option('debug')
>  +  option_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] : ['=
-g']
>  +endif
>
> option_cflags does nothing, it's only for clarity in the final summary. S=
o you need
>
> if get_option('debug') and get_option('split_debug')
>   qemu_cflags +=3D '-gsplit-dwarf'
> endif

Should I update the optimization field as well? is this the reason why I
wasn't seeing changes occur for the tests that meson builds?

>
> (I wonder if it should be implemented in meson instead... It should be be=
neficial for other projects surely).
>
> Paolo
>
>   if get_option('optimization') !=3D 'plain'
>     option_cflags +=3D ['-O' + get_option('optimization')]
>   endif
>  diff --git a/meson_options.txt b/meson_options.txt
>  index 59d973bca0..3432123fee 100644
>  --- a/meson_options.txt
>  +++ b/meson_options.txt
>  @@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
>          description: 'mutex debugging support')
>   option('debug_stack_usage', type: 'boolean', value: false,
>          description: 'measure coroutine stack usage')
>  +option('split_debug', type: 'boolean', value: true,
>  +       description: 'split debug info from object files')
>   option('qom_cast_debug', type: 'boolean', value: true,
>          description: 'cast debugging support')
>   option('slirp_smbd', type : 'feature', value : 'auto',
>  diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.=
sh
>  index 3e8e00852b..aca6e68830 100644
>  --- a/scripts/meson-buildoptions.sh
>  +++ b/scripts/meson-buildoptions.sh
>  @@ -504,6 +504,8 @@ _meson_option_parse() {
>       --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Dfals=
e ;;
>       --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
>       --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
>  +    --enable-split-debug) printf "%s" -Dsplit_debug=3Dtrue ;;
>  +    --disable-split-debug) printf "%s" -Dsplit_debug=3Dfalse ;;
>       --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
>       --enable-tcg) printf "%s" -Dtcg=3Denabled ;;
>       --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>  --=20
>  2.39.5

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

