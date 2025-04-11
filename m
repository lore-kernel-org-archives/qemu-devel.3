Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA9EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3C75-0003n8-W3; Fri, 11 Apr 2025 07:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3C71-0003lu-DJ; Fri, 11 Apr 2025 06:59:59 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3C6z-0001zE-J7; Fri, 11 Apr 2025 06:59:54 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ad51f427054so1393080a12.1; 
 Fri, 11 Apr 2025 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744369191; x=1744973991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oVuOWbJrwKWkgdC2ARq1ig1b8sNfy4nE1XFpACDLWmE=;
 b=k35WTVmHbICp+2OoVIaQdGySDPEwnd85tB41qN3wZDK8kVryTdFAI7fpKy23Azflkp
 tPz/BxwhxNTPI1fZD+NrXw+Kh7JOgdzPzT0tmq4IO5Miumby7uoc0Mb1A7XXAFu9SjoT
 XJbtn0c1NF+EHdHM0BrPVCkELTgHWaUCO6L1Pa2EGOP5tmoXzmilxJtTTWCiKI4DdpBr
 LzhE09m+Er8b5ZquiwwZBbM8WQg0PJcBvOvQnqE2+60H2kiEfa9qRbSWT44kJHjMeYO9
 y5DILUaweVSCvuz6C02q2CbWvWSCmY2vAJJ4xW2BCj4FqLScJAG/GMXGS7fZCSQYDu8W
 G1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744369191; x=1744973991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVuOWbJrwKWkgdC2ARq1ig1b8sNfy4nE1XFpACDLWmE=;
 b=kTTcz57pAOoJ1SQJ2lFtfH8mREbVfIROno9ehx89CyaWBIcyGWx8CtdbLTHU5YJTqI
 MAFAT1CEh4Zr7f7BZbXbkfBnyHSX2ahvDDu5Cx7vGOxe/3pSubZOIw/2TsUp/ovNqHoH
 QmfjH05dt6QHwLDtZfgQZDDLIEtrwx36ryWQxBNdaOjUFTMIsIxj9FJ4PyDYoRZY5ctJ
 PB6yDxVt9aDVixl+JxwyT9bHGfz0n0LJEYkxvxZksRDC3eDOZbkoS/JlmiYXoEFZSMOX
 GRjqsfb8JFpCgBe95Q+fvhLIwsYHoF/8YBLroJeIFnEZ64Dvvl/4ruxCmtsXX0favF2p
 nDfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+re//bOquk/Cze1QleNc1xkJlHPQKonO1zZEb2brgzq6aLFKxE0pnxLg4bYE/BrGoUM07pKvIQ==@nongnu.org,
 AJvYcCV+9n0xWodTcfeT3BysJOwlTOLEdF7pTqQJ08fVJ49JsTqb8O70VjfXc3f364vtnu5aHWtG+ZnJ3Q03cA==@nongnu.org,
 AJvYcCVgTIARXhl8t9zFKUW9bdG6kG4agbD4V1zY133eA6XMW/0aTzPDV7gMIeOmjENAVzgMUeFY0CVD0u+F9Q==@nongnu.org,
 AJvYcCWu884rqtRDeRacR9E+Sswfvg7SuQns+ShaUwBOAJzDHM8eH46nGCponFN6DF8dwp7x8tI6m1fvn681Lw==@nongnu.org
X-Gm-Message-State: AOJu0YwUt01BgQZDczRf+IOIbymDfiMwEpElu+1x/5vl8wT/8Gm8vtUN
 VyuyRfwEW6tfVaYAquMa7Eg/FGRapsk3kFlZXMGIle1O/oQNrp39GxTZo8H5VKXgTUaTm7noqr6
 Q+yTbILe4dll0tYBWK7jJci4thx8=
X-Gm-Gg: ASbGnctKBxqrYgTbWtNnf+iPS3QxWoSGGeq/jjujHoaxTZRD7gaqQYgffYTuO9hv/0U
 0LmWeulgo32ps8Of5WI5b5TUt7mpM49LbsP5Wi6n7xE84hdihpN15qz5jTWUAKkfH+rb/qFsy9h
 zJ4WxktajRWIxbett3r22UKSQWuPg+V1rhtkxOIUc0cqebq0y1QVKVrMKzeyfOvg==
X-Google-Smtp-Source: AGHT+IE2GpFosUiKjNelR08dxR71Fb2diAnjKjNXQdm1S7hWRCm4/ZwKDdKMgR+roDIOCCKXjYPq4t10aHUklRgW8P0=
X-Received: by 2002:a17:90b:5823:b0:301:1d03:93cf with SMTP id
 98e67ed59e1d1-308237c0c88mr3646020a91.30.1744369191004; Fri, 11 Apr 2025
 03:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <5f2a8fa2d7116b1d65b79fbb3a95244096fb7308.1744032780.git.ktokunaga.mail@gmail.com>
 <5cc73887-1073-49d3-8267-0e84483bfc2b@redhat.com>
In-Reply-To: <5cc73887-1073-49d3-8267-0e84483bfc2b@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Fri, 11 Apr 2025 19:59:38 +0900
X-Gm-Features: ATxdqUHdCpCrgjtKUrRDwrJofLyKqzJ4ydVniPukslLn_-oH_eDcjqHmdFXJByw
Message-ID: <CAEDrbUaMN3OM0_vyRZwfdu9eTQ=H0Ruc-=ZbEWB3VoNgKqE+6g@mail.gmail.com>
Subject: Re: [PATCH 02/10] various: Define macros for dependencies on
 emscripten
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fcb38806327e99a7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fcb38806327e99a7
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> > +#ifdef EMSCRIPTEN
> > +/*
> > + * emscripten exposes copy_file_range declaration but doesn't provide
the
> > + * implementation in the final link. Define the stub here but avoid
type
> > + * conflict with the emscripten's header.
> > + */
> > +ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
> > +                             off_t *out_off, size_t len, unsigned int
flags)
> > +{
> > +    errno = ENOSYS;
> > +    return -1;
> > +}
>
> Please add a file stubs/emscripten.c with this function, and add it to
> the build in stubs/meson.build.
>
> > +#ifdef EMSCRIPTEN
> > +            error_report("initgroups unsupported");
> > +            exit(1);
>
> I think it's best to add a new function os-wasm.c in addition to
> os-posix.c and os-win32.c, and disable all the functionality of
> -run-with and -daemonize in vl.c via
>
> -#if defined(CONFIG_POSIX)
> +#if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
>
> (there are a couple occurrences).

Sure, I'll apply these reorganization in the next version of the series.

--000000000000fcb38806327e99a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Paolo,</div><br>&gt; &gt; +#ifdef EMSC=
RIPTEN<br>&gt; &gt; +/*<br>&gt; &gt; + * emscripten exposes copy_file_range=
 declaration but doesn&#39;t provide the<br>&gt; &gt; + * implementation in=
 the final link. Define the stub here but avoid type<br>&gt; &gt; + * confl=
ict with the emscripten&#39;s header.<br>&gt; &gt; + */<br>&gt; &gt; +ssize=
_t copy_file_range(int in_fd, off_t *in_off, int out_fd,<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 off_t *out_off, size_t len, unsigned int flags)<br>&gt=
; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0errno =3D ENOSYS;<br>&gt; &gt; + =C2=
=A0 =C2=A0return -1;<br>&gt; &gt; +}<br>&gt; <br>&gt; Please add a file stu=
bs/emscripten.c with this function, and add it to<br>&gt; the build in stub=
s/meson.build.<br>&gt; <br>&gt; &gt; +#ifdef EMSCRIPTEN<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;initgroups unsuppo=
rted&quot;);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1=
);<br>&gt; <br>&gt; I think it&#39;s best to add a new function os-wasm.c i=
n addition to<br>&gt; os-posix.c and os-win32.c, and disable all the functi=
onality of<br>&gt; -run-with and -daemonize in vl.c via<br>&gt; <br>&gt; -#=
if defined(CONFIG_POSIX)<br>&gt; +#if defined(CONFIG_POSIX) &amp;&amp; !def=
ined(EMSCRIPTEN)<br>&gt; <br>&gt; (there are a couple occurrences).<br><br>=
Sure, I&#39;ll apply these reorganization in the next version of the series=
.<br><br></div>

--000000000000fcb38806327e99a7--

