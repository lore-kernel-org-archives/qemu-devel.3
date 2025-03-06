Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12462C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCRG-0004aq-Ah; Thu, 06 Mar 2025 09:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqCRC-0004YY-Kt
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:43:03 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqCRA-0005jR-LK
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:43:02 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so116290666b.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741272177; x=1741876977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAIOZnmJ3XnmeO3qQw/irnoz4/ysd8Sms3GQg/H5qiA=;
 b=jCj+5eYvgH6dSkqD55EljZ+W2DPR/iiEXQk0wpJ8GQGRpicP80d/Gwqm5Oy0PwB4yn
 XFKihEL7gjyKZxLVaEbya4idDyClVgC0g9IL5qGPSDKsVHuOZnxitsBTdo8TamTPPo1o
 csWgZ1qMnFeB9JdjN4ctXF6mGh0Q1R83aMS+BRhMKIRpuBa+lewTNpmJkogP01RIRH58
 AWCG0gK07k1dZGMR7faYV+yjZ3HEwmP9u9bw0G/84leXY7i7pLntyLdq6ajjzCmdzAt9
 mDVc4TfMjPXslXLxyRLdvCey82FiUIAHYINvEhLd8Kr/GpvHcrImhPsrTNY0l1rQw7sg
 6ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741272177; x=1741876977;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rAIOZnmJ3XnmeO3qQw/irnoz4/ysd8Sms3GQg/H5qiA=;
 b=Yx4Y20GtmZd3hiNWXc6XoCaRUY6i8bMRpGvTUn0GkCPsIS9MfRDmkgDvcfNUXC9C22
 r+Fmeb+GdG4MIEx8pHdgi6tbO3aXxq+la7AV5yHNbDgv6TtUCh70i2R8Fer87MmId5k3
 G1v5j51wDPZ7u79aG9rtLhE3onR+HWr31OIZadPBKhrDEYDOt0R8baOljV5RqWJtWq5P
 +RtJH4alHFG6n7aY+Fs5tbiJzMgE9X8cjXbnHtMd1iBXknzGf5+jJaMt//H1YFtXQwpw
 /15wNSf6UjzjhFZBwyLq5V7E8zPHM5TOiHxw0NZpEkGjoB5wy/HTY3D9gaIKkqKXeGvj
 5DuA==
X-Gm-Message-State: AOJu0YxAjTKegNqX45m5y0hwGJ1LKR1mCN+VGwS6ezulORPl1GsrI2fw
 PS9tyUH7a5MLuwrLXhKVd1kl2c3B5IjqJxQgqyfk5fvFjyoFjv71uGUxjvBtdBk=
X-Gm-Gg: ASbGncs3UApHYGtyBRcFe4qhqqHIqRr5a+XFbaGUA2D74VtWACQ5YopFia6rM1ea+Va
 BKYgyD3NVW2IA5Zp+ma//Cu/bJpVtCPquw/TjegQSnOgKWdvZUW7zHLLcIN9W52WqwDbf1KtiPq
 09D5aS9aKeu2aYjrtrVbl6bdVIkl5bFeX5xKlEhzXb13rqo56lraqdYfiy/tlPItmA/9s6a9mJ9
 mbkMNSzABmarSp05lHSD9wJwt18n2zpbnGF9CQiAe/h6m8d9k5ONFzo/laS2JdFsk6dvV45PC64
 aEn6rTdk3HcE0y0bnsoz8Q89E40qAqM92Fb7Oh6LHZD4OOU=
X-Google-Smtp-Source: AGHT+IG4UiyL6qDQlK3Ws7QYxoc/KgmTe5FVQUBXo/+iWZHkSsy1gSHgVDrDuEaxYgRAW8jlMiPohA==
X-Received: by 2002:a17:907:2550:b0:ac2:166f:42fc with SMTP id
 a640c23a62f3a-ac2166f4767mr505596766b.52.1741272176775; 
 Thu, 06 Mar 2025 06:42:56 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac239485558sm107505966b.60.2025.03.06.06.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:42:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5404F5F9CF;
 Thu,  6 Mar 2025 14:42:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] meson.build: default to -gsplit-dwarf for debug info
In-Reply-To: <CABgObfbJz3ctqJ=pidb=gRxspwfnXMY9dtD0QYSwcjP6A-BQJw@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 6 Mar 2025 14:38:59 +0100")
References: <20250306105306.2064458-1-alex.bennee@linaro.org>
 <CABgObfZpf7Oki+0rH-3OTBLF_cW8+5e-jAaG=AU58oAn8CP=5w@mail.gmail.com>
 <877c524agm.fsf@draig.linaro.org>
 <CABgObfbJz3ctqJ=pidb=gRxspwfnXMY9dtD0QYSwcjP6A-BQJw@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 06 Mar 2025 14:42:52 +0000
Message-ID: <87tt862par.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

> Il gio 6 mar 2025, 13:20 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scr=
itto:
>
>  Paolo Bonzini <pbonzini@redhat.com> writes:
>
>  > Il gio 6 mar 2025, 11:53 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha =
scritto:
>  >
>  >  -option_cflags =3D (get_option('debug') ? ['-g'] : [])
>  >  +option_cflags =3D []
>  >  +if get_option('debug')
>  >  +  option_cflags +=3D get_option('split_debug') ? ['-gsplit-dwarf'] :=
 ['-g']
>  >  +endif
>  >
>  > option_cflags does nothing, it's only for clarity in the final summary=
. So you need
>  >
>  > if get_option('debug') and get_option('split_debug')
>  >   qemu_cflags +=3D '-gsplit-dwarf'
>  > endif
>
>  Should I update the optimization field as well? is this the reason why I
>  wasn't seeing changes occur for the tests that meson builds?
>
> I am not sure what you mean by optimization field; anyway, qemu_cflags ap=
plies to all C sources and qemu_ldflags to all
> programs linked with the C compiler. As I understand it,
> '-gsplit-dwarf' should go in qemu_cflags.


if get_option('optimization') !=3D 'plain'
  option_cflags +=3D ['-O' + get_option('optimization')]
endif

Are you saying this is never applied to the build?


>
> Paolo=20
>
>  >
>  > (I wonder if it should be implemented in meson instead... It should be=
 beneficial for other projects surely).
>  >
>  > Paolo
>  >
>  >   if get_option('optimization') !=3D 'plain'
>  >     option_cflags +=3D ['-O' + get_option('optimization')]
>  >   endif
>  >  diff --git a/meson_options.txt b/meson_options.txt
>  >  index 59d973bca0..3432123fee 100644
>  >  --- a/meson_options.txt
>  >  +++ b/meson_options.txt
>  >  @@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: fal=
se,
>  >          description: 'mutex debugging support')
>  >   option('debug_stack_usage', type: 'boolean', value: false,
>  >          description: 'measure coroutine stack usage')
>  >  +option('split_debug', type: 'boolean', value: true,
>  >  +       description: 'split debug info from object files')
>  >   option('qom_cast_debug', type: 'boolean', value: true,
>  >          description: 'cast debugging support')
>  >   option('slirp_smbd', type : 'feature', value : 'auto',
>  >  diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptio=
ns.sh
>  >  index 3e8e00852b..aca6e68830 100644
>  >  --- a/scripts/meson-buildoptions.sh
>  >  +++ b/scripts/meson-buildoptions.sh
>  >  @@ -504,6 +504,8 @@ _meson_option_parse() {
>  >       --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=3Df=
alse ;;
>  >       --enable-strip) printf "%s" -Dstrip=3Dtrue ;;
>  >       --disable-strip) printf "%s" -Dstrip=3Dfalse ;;
>  >  +    --enable-split-debug) printf "%s" -Dsplit_debug=3Dtrue ;;
>  >  +    --disable-split-debug) printf "%s" -Dsplit_debug=3Dfalse ;;
>  >       --sysconfdir=3D*) quote_sh "-Dsysconfdir=3D$2" ;;
>  >       --enable-tcg) printf "%s" -Dtcg=3Denabled ;;
>  >       --disable-tcg) printf "%s" -Dtcg=3Ddisabled ;;
>  >  --=20
>  >  2.39.5
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

