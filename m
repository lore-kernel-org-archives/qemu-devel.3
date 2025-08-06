Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A81C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 13:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujdna-0000q9-6N; Wed, 06 Aug 2025 09:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujdgJ-00051A-Ig
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 08:55:48 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujdgG-00069A-Hi
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 08:55:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b422863dda0so3806902a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754484940; x=1755089740; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3JTJPfUhT+gm4/gGFQpf7WXS4dRdwDALmZ1wK95ulx4=;
 b=Weq0/Mrg+/lnnFCHN9/bbUlIdNrFOpOu7rk7Sp81P2woyGA2GQh/hX0dPdPMbcZKwN
 8GoqGZ8Ie8GaqEJ2NJoenFYpphOAL2daEXt1JEaa2zM102LllQo9xjt5lkVUnmCBBOB9
 J7XEWAfd/wVOz6X4+blJwqJgEgHtUjjn3Ml8qaPW+voHd1CcGzmb6Bh8WlNvqJm5vWdx
 7asypjlY3Z/OxvFvx62Xj1UvWUWxYAL/nqdnE912B5bnQcIi6MxLMf40Nvr7SVITyRkt
 tyVjv6LaZ2D2DSJfDYZquJPbOwEefbSC/eM+utU7gKYqUBvW8H1aMWFh6WdjCS/AX52D
 BLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754484940; x=1755089740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3JTJPfUhT+gm4/gGFQpf7WXS4dRdwDALmZ1wK95ulx4=;
 b=JdKCqCef9cAquYiI27C+M8QIOgNyLxDP3DV4FPfh/w5PXYy7NqMJfBynsUGTqCxKON
 HIgek4BevmoxViLNSU/viUKH9kzjoTlsO0kiCsh08jK/7yJDPV7DWUORLQVnB3YJ1SwN
 tF4NHld0aUAh8gG+oVD3fBcdZenT70/w1L+J0B7kphZqMAZgK+mrcpIZXm6kZDA9aZiO
 uX13Y2BD1s8sCjjFYujAjRbhx7pgPevnMPXDvWeZYXmiTV3l5ljAVoNk2U1gOElm80FU
 2gMvk57H8EBck5rqKlTQAA6TbQJ+mKbLhDcQzXPCYvlHZukOqqwrYEuAZsqJcQTKKZEg
 QfRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrD9pkwthkZXE59aSrgTq/hCBYHypBVlKUGfF/1SMFq4h1v2VHqPwwOyzwsGdF3GciZoeletCpNMSs@nongnu.org
X-Gm-Message-State: AOJu0Yxa8bBK65dpMsRjYSjWFwnxV30vqwYS85ZyYw9e+HNeprYe99Tx
 CUWkRhn5VhP3T7jHA7TbGp31C76qydSK7Zv9RfPsWS9HF+DVASh1NKr3n23fQFObpUXMvJcpSto
 15piDvlWwhPIsAxinOFtCb074ovLNgIAQeS6M
X-Gm-Gg: ASbGncu4sARZqfYOte9PYiITHuv6SpFjES19Rpb4r5JCWo/uX/3HE/KY5UVLc+1CcG/
 iiYbl78FWFbYI9Yrh9NZA2RCN1gBrGJzVSSqNlpGSzPDiTGbjLXN39PUn046/zz8rHHZLaduYQN
 +XUpdE4KtYdKDtSjHzTTBmfnyt27Jb3/KeBPPRNt+xp1NCTehrgYACDcbm487LTD4iqvoUsaepu
 n8AeUgWMkTZIqYzGRPzfiME18HDt9mDWLR4qQ==
X-Google-Smtp-Source: AGHT+IFpFxt7rTknXJfhfgaxXZWuslG/elVIQ4x+cWEZ39VVfRt1JQDGFtTlnY68oCxoHty8Um4EPiCrQOTAn+owk9A=
X-Received: by 2002:a17:902:e785:b0:242:9bbc:3646 with SMTP id
 d9443c01a7336-242a0c022d5mr36158735ad.56.1754484939832; Wed, 06 Aug 2025
 05:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
 <fb2867b2-4e4b-43df-9cd6-ba476cde6379@linaro.org>
In-Reply-To: <fb2867b2-4e4b-43df-9cd6-ba476cde6379@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 6 Aug 2025 21:55:28 +0900
X-Gm-Features: Ac12FXwfLB4KBHEaOYglo1YvaKlxK0L1klNLlVAvSaDfWm64ty48OYUbc7QAlNQ
Message-ID: <CAEDrbUaDkXKqC5jDBuWzLDSV7NTXVm-i9O9sw8xta1vPd6wZJA@mail.gmail.com>
Subject: Re: [PATCH 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009a412a063bb1db25"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52b.google.com
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

--0000000000009a412a063bb1db25
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

Thanks for the suggestion.

> On 4/8/25 14:57, Kohei Tokunaga wrote:
> > Currently there are some engines that don't support wasm64 (e.g.
unsupported
> > on Safari[1]). To mitigate this issue, the configure script allows the
user
> > to use Emscripten's compatibility feature, "-sMEMORY64=2" flag[2].
> >
> > Emscripten's "-sMEMORY64=2" flag still enables 64bit pointers in C
code. But
> > this flag lowers the output binary into wasm32, with limiting the
maximum
> > memory size to 4GB. So QEMU can run on wasm32 engines.
> >
> > This commit adds "--wasm64-memory64" flag to the configure script. This
> > takes the value to propagate to Emscripten's -sMEMORY64. 1(default)
targets
> > wasm64 engines and 2 targets wasm32 engines with still enabling 64bit
> > pointers.
> >
> > [1] https://webassembly.org/features/
> > [2]
https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
> >
> > Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> > ---
> >   configure | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 7f3893a42f..8573f84e26 100755
> > --- a/configure
> > +++ b/configure
> > @@ -182,6 +182,8 @@ EXTRA_CXXFLAGS=""
> >   EXTRA_OBJCFLAGS=""
> >   EXTRA_LDFLAGS=""
> >
> > +wasm64_memory64=1
> > +
> >   # Default value for a variable defining feature "foo".
> >   #  * foo="no"  feature will only be used if --enable-foo arg is given
> >   #  * foo=""    feature will be searched for, and if found, will be
used
> > @@ -239,6 +241,8 @@ for opt do
> >     ;;
> >     --without-default-features) default_feature="no"
> >     ;;
> > +  --wasm64-memory64=*) wasm64_memory64="$optarg"
> > +  ;;
> >     esac
> >   done
> >
> > @@ -537,7 +541,7 @@ case "$cpu" in
> >       CPU_CFLAGS="-m32"
> >       ;;
> >     wasm64)
> > -    CPU_CFLAGS="-m64 -sMEMORY64=1"
> > +    CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
> >       ;;
> >   esac
> >
> > @@ -795,6 +799,8 @@ for opt do
> >     ;;
> >     --disable-rust) rust=disabled
> >     ;;
> > +  --wasm64-memory64=*)
> > +  ;;
> >     # everything else has the same name in configure and meson
> >     --*) meson_option_parse "$opt" "$optarg"
> >     ;;
> > @@ -920,6 +926,8 @@ Advanced options (experts only):
> >     --disable-containers     don't use containers for cross-building
> >     --container-engine=TYPE  which container engine to use
[$container_engine]
> >     --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
> > +  --wasm64-memory64        Used only for wasm64 build. Set -sMEMORY64
of
> > +                           Emscripten to 1(default) or 2 (choices: 1/2)
>
> I wouldn't expose "1" or "2" to the users. Instead, keep 1 as internal
> default, and provide the --wasm64-32bit-address-limit option which sets
> internal value to 2. Configure help could be:
>
>     --wasm64-32bit-address-limit    Restrict wasm64 address space to
>                                     32-bit (default is to use the whole
>                                     64-bit range).
>
> WDYT?

It looks good to me. I'll update the patch.

Regards,
Kohei

--0000000000009a412a063bb1db25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<br><br>Thanks for the sugges=
tion.<br><br>&gt; On 4/8/25 14:57, Kohei Tokunaga wrote:<br>&gt; &gt; Curre=
ntly there are some engines that don&#39;t support wasm64 (e.g. unsupported=
<br>&gt; &gt; on Safari[1]). To mitigate this issue, the configure script a=
llows the user<br>&gt; &gt; to use Emscripten&#39;s compatibility feature, =
&quot;-sMEMORY64=3D2&quot; flag[2].<br>&gt; &gt;<br>&gt; &gt; Emscripten&#3=
9;s &quot;-sMEMORY64=3D2&quot; flag still enables 64bit pointers in C code.=
 But<br>&gt; &gt; this flag lowers the output binary into wasm32, with limi=
ting the maximum<br>&gt; &gt; memory size to 4GB. So QEMU can run on wasm32=
 engines.<br>&gt; &gt;<br>&gt; &gt; This commit adds &quot;--wasm64-memory6=
4&quot; flag to the configure script. This<br>&gt; &gt; takes the value to =
propagate to Emscripten&#39;s -sMEMORY64. 1(default) targets<br>&gt; &gt; w=
asm64 engines and 2 targets wasm32 engines with still enabling 64bit<br>&gt=
; &gt; pointers.<br>&gt; &gt;<br>&gt; &gt; [1] <a href=3D"https://webassemb=
ly.org/features/">https://webassembly.org/features/</a><br>&gt; &gt; [2] <a=
 href=3D"https://emscripten.org/docs/tools_reference/settings_reference.htm=
l#memory64">https://emscripten.org/docs/tools_reference/settings_reference.=
html#memory64</a><br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Kohei Tokunaga &=
lt;<a href=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>=
&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0 configure | 10 +++++++++-<br>&gt;=
 &gt; =C2=A0 1 file changed, 9 insertions(+), 1 deletion(-)<br>&gt; &gt;<br=
>&gt; &gt; diff --git a/configure b/configure<br>&gt; &gt; index 7f3893a42f=
..8573f84e26 100755<br>&gt; &gt; --- a/configure<br>&gt; &gt; +++ b/configu=
re<br>&gt; &gt; @@ -182,6 +182,8 @@ EXTRA_CXXFLAGS=3D&quot;&quot;<br>&gt; &=
gt; =C2=A0 EXTRA_OBJCFLAGS=3D&quot;&quot;<br>&gt; &gt; =C2=A0 EXTRA_LDFLAGS=
=3D&quot;&quot;<br>&gt; &gt; =C2=A0 <br>&gt; &gt; +wasm64_memory64=3D1<br>&=
gt; &gt; +<br>&gt; &gt; =C2=A0 # Default value for a variable defining feat=
ure &quot;foo&quot;.<br>&gt; &gt; =C2=A0 # =C2=A0* foo=3D&quot;no&quot; =C2=
=A0feature will only be used if --enable-foo arg is given<br>&gt; &gt; =C2=
=A0 # =C2=A0* foo=3D&quot;&quot; =C2=A0 =C2=A0feature will be searched for,=
 and if found, will be used<br>&gt; &gt; @@ -239,6 +241,8 @@ for opt do<br>=
&gt; &gt; =C2=A0 =C2=A0 ;;<br>&gt; &gt; =C2=A0 =C2=A0 --without-default-fea=
tures) default_feature=3D&quot;no&quot;<br>&gt; &gt; =C2=A0 =C2=A0 ;;<br>&g=
t; &gt; + =C2=A0--wasm64-memory64=3D*) wasm64_memory64=3D&quot;$optarg&quot=
;<br>&gt; &gt; + =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0 esac<br>&gt; &gt; =C2=
=A0 done<br>&gt; &gt; =C2=A0 <br>&gt; &gt; @@ -537,7 +541,7 @@ case &quot;$=
cpu&quot; in<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 CPU_CFLAGS=3D&quot;-m32&quot=
;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 ;;<br>&gt; &gt; =C2=A0 =C2=A0 wasm64)<b=
r>&gt; &gt; - =C2=A0 =C2=A0CPU_CFLAGS=3D&quot;-m64 -sMEMORY64=3D1&quot;<br>=
&gt; &gt; + =C2=A0 =C2=A0CPU_CFLAGS=3D&quot;-m64 -sMEMORY64=3D$wasm64_memor=
y64&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 ;;<br>&gt; &gt; =C2=A0 esac<br>=
&gt; &gt; =C2=A0 <br>&gt; &gt; @@ -795,6 +799,8 @@ for opt do<br>&gt; &gt; =
=C2=A0 =C2=A0 ;;<br>&gt; &gt; =C2=A0 =C2=A0 --disable-rust) rust=3Ddisabled=
<br>&gt; &gt; =C2=A0 =C2=A0 ;;<br>&gt; &gt; + =C2=A0--wasm64-memory64=3D*)<=
br>&gt; &gt; + =C2=A0;;<br>&gt; &gt; =C2=A0 =C2=A0 # everything else has th=
e same name in configure and meson<br>&gt; &gt; =C2=A0 =C2=A0 --*) meson_op=
tion_parse &quot;$opt&quot; &quot;$optarg&quot;<br>&gt; &gt; =C2=A0 =C2=A0 =
;;<br>&gt; &gt; @@ -920,6 +926,8 @@ Advanced options (experts only):<br>&gt=
; &gt; =C2=A0 =C2=A0 --disable-containers =C2=A0 =C2=A0 don&#39;t use conta=
iners for cross-building<br>&gt; &gt; =C2=A0 =C2=A0 --container-engine=3DTY=
PE =C2=A0which container engine to use [$container_engine]<br>&gt; &gt; =C2=
=A0 =C2=A0 --gdb=3DGDB-path =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gdb to use f=
or gdbstub tests [$gdb_bin]<br>&gt; &gt; + =C2=A0--wasm64-memory64 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Used only for wasm64 build. Set -sMEMORY64 of<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Emscripten to 1(default) or 2 (choices: 1/2)<br>&gt; =
<br>&gt; I wouldn&#39;t expose &quot;1&quot; or &quot;2&quot; to the users.=
 Instead, keep 1 as internal<br>&gt; default, and provide the --wasm64-32bi=
t-address-limit option which sets<br>&gt; internal value to 2. Configure he=
lp could be:<br>&gt; <br>&gt; =C2=A0 =C2=A0 --wasm64-32bit-address-limit =
=C2=A0 =C2=A0Restrict wasm64 address space to<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32-bit (default is to use the whole<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 64-bit range).<br>&gt;=
 <br>&gt; WDYT?<br><br>It looks good to me. I&#39;ll update the patch.</div=
><div dir=3D"ltr"><br></div><div>Regards,</div><div>Kohei</div></div>

--0000000000009a412a063bb1db25--

