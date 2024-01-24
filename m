Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9FBC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 14:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSdnA-00038Q-Gj; Wed, 24 Jan 2024 08:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rSdn8-00038B-T1; Wed, 24 Jan 2024 08:59:47 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1rSdn6-0006CM-VV; Wed, 24 Jan 2024 08:59:46 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so6523670a12.2; 
 Wed, 24 Jan 2024 05:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706104782; x=1706709582; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8fNpQFi2GM0w37a0PO1Z4htSzc3o14Ers8stsbamzC8=;
 b=Rr6RvpLagDK/eOPKz4M2UYwUX8ijdoqWhSeCjNJ3y/NZmZNr7kFgLlmXcK99/awbeX
 rVxAu8xLPxF0N9AJXmszXwU6i3Wlgo0rJxV9NOpvqKpM5fuOJwtfzdvBV3VMCDU5eHrK
 t/dYlfu2/6X4qimPieFDkv96mXs8ik6eK8dAiWfZviEEfTWWss+HfJk0FKY0xW0tWeZg
 mLyQS0VL/eBKyidPmNS0hqJ9Vec/BUZXPqRflG9RURywK1N3C5+M/vmBrm1Bg+8srGKR
 X6qG1raqS+9kZwECPdq6xJ0Yx7XP7T1BHzm18mEjfYCbTZ5rcRyuCzYyoDKhH6hSuhz8
 Smqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706104782; x=1706709582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8fNpQFi2GM0w37a0PO1Z4htSzc3o14Ers8stsbamzC8=;
 b=lXLG35Qplru5nzZUEdNTLU5NYUPwgWmI1A3AMTkcT4w32xACtHNLtzivqMYrM9lDf3
 WwXbzPisEQpcxctnLuCL9IscBJ6Aiqgk3+OBEjkpAibMAruMeb7gLLfHEnmnLxXy24Eg
 ilGVHtxgHDv3LLnUKOzRHPX2PCNqwo50E2kCf766655AWBl0TFxZYS4PSR0N+sbOyghA
 UqDU2DEF62SPzUFs3f5VmJqVnA4hbKnLUFklCbqUdQlOEUyEtzxJXMgkI+Sm/2oVhZNy
 mkFZufypGIwiHLMaVxYOd+972vO3DhZLOSXleBEANjAqBwSgB6bDPAocho0aDPvLerdM
 VZ0Q==
X-Gm-Message-State: AOJu0Yw5PV50I3e/oBYgAmEQ4YI749x6tNJsyMIJf9qMP7AHasC8DBd/
 oDCNjRWrJgXNgGkoYyYl7tECPVH/W6WCiylwnPB2TC/EOOKKV7gbrd7V5mm52CVt6mnJks295sL
 gYofdxaBFZr/I6UzQyviQVrlh/n8=
X-Google-Smtp-Source: AGHT+IEIiUNtaw0Djb+h4wv6InydMRC9iK8ay6yELMASXhGw+2lMNB0xwGazogaamNzlbn8coQQSf/Bvu53RFGNj4Hk=
X-Received: by 2002:a05:6402:2550:b0:55c:a89c:359f with SMTP id
 l16-20020a056402255000b0055ca89c359fmr392192edb.15.1706104781630; Wed, 24 Jan
 2024 05:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
 <20230925144854.1872513-5-alex.bennee@linaro.org>
 <ZRG1g/2hWi8+AzNn@redhat.com> <878r8urxxc.fsf@linaro.org>
 <CAJy5ezoucKM=VvYsHeFep7r0i1PV_JUCgq6gs4JJQVHqq3Yz3Q@mail.gmail.com>
 <5a1cb4ae-b43c-4ef5-9572-6636a2d787e7@linaro.org>
In-Reply-To: <5a1cb4ae-b43c-4ef5-9572-6636a2d787e7@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 24 Jan 2024 14:59:28 +0100
Message-ID: <CAJy5ezoW40OxdEjLgu4VXLrA7CurVSSUcj5JM18fh6wxPb0eYg@mail.gmail.com>
Subject: Re: [PATCH 04/31] docs: mark CRIS support as deprecated
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, libvir-list@redhat.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, Song Gao <gaosong@loongson.cn>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liweiwei@iscas.ac.cn>, Nicholas Piggin <npiggin@gmail.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Eduardo Habkost <eduardo@habkost.net>,
 Cleber Rosa <crosa@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 qemu-ppc@nongnu.org, 
 David Hildenbrand <david@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>, 
 Rabin Vincent <rabinv@axis.com>
Content-Type: multipart/alternative; boundary="000000000000757348060fb1796c"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000757348060fb1796c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 25/9/23 19:17, Edgar E. Iglesias wrote:
> >
> > On Mon, Sep 25, 2023 at 7:00=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org
> > <mailto:alex.bennee@linaro.org>> wrote:
> >
> >
> >     Daniel P. Berrang=C3=A9 <berrange@redhat.com
> >     <mailto:berrange@redhat.com>> writes:
> >
> >      > On Mon, Sep 25, 2023 at 03:48:27PM +0100, Alex Benn=C3=A9e wrote=
:
> >      >> This might be premature but while streamling the avocado tests =
I
> >      >> realised the only tests we have are "check-tcg" ones. The aging
> >      >> fedora-criss-cross image works well enough for developers but
> >     can't be
> >      >> used in CI as we need supported build platforms to build QEMU.
> >      >>
> >      >> Does this mean the writing is on the wall for this architecture=
?
> >      >>
> >      >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org
> >     <mailto:alex.bennee@linaro.org>>
> >      >> Cc: Rabin Vincent <rabinv@axis.com <mailto:rabinv@axis.com>>
> >      >> Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com
> >     <mailto:edgar.iglesias@xilinx.com>>
> >      >> ---
> >      >>  docs/about/deprecated.rst | 11 +++++++++++
> >      >>  1 file changed, 11 insertions(+)
> >      >>
> >      >> diff --git a/docs/about/deprecated.rst
> b/docs/about/deprecated.rst
> >      >> index dc4da95329..7cfe313aa6 100644
> >      >> --- a/docs/about/deprecated.rst
> >      >> +++ b/docs/about/deprecated.rst
> >      >> @@ -399,6 +399,17 @@ Specifying the iSCSI password in plain tex=
t
> >     on the command line using the
> >      >>  used instead, to refer to a ``--object secret...`` instance
> >     that provides
> >      >>  a password via a file, or encrypted.
> >      >>
> >      >> +TCG CPUs
> >      >> +--------
> >      >> +
> >      >> +CRIS CPU architecture (since 8.1)
> >      >> +'''''''''''''''''''''''''''''''''
> >      >> +
> >      >> +The CRIS architecture was pulled from Linux in 4.17 and the
> >     compiler
> >      >> +is no longer packaged in any distro making it harder to run th=
e
> >      >> +``check-tcg`` tests. Unless we can improve the testing
> >     situation there
> >      >> +is a chance the code will bitrot without anyone noticing.
> >      >
> >      > Deprecated is generally a warning that we intend to delete the
> >      > feature.   If we're just going to relegate it to untested
> >      > status (what I'd call "tier 3" quality), then we should document
> >      > that elsewhere.  I don't mind which way we go.
> >
> >     We do have reasonably good coverage with tests/tcg/cris but of cour=
se
> >     without a compiler we can't build them.
> >
> >     Both nios2 and microblaze have build-toolchain scripts which can be
> used
> >     to re-create containers. However my preference is having pre-built
> >     toolchains hosted by others like we do for loongarch, hexagon, xten=
sa
> >     and tricore. Then the docker image can simply curl them into an
> image.
> >
> >
> > Yeah, I guess it's time to deprecate it...
>
> Is that an informal Acked-by? (:
>
>
OK with me!

Acked-by: Edgar E. Iglesias <edgar.iglesias@gmail.com>

--000000000000757348060fb1796c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 24, 2024 at 12:06=E2=80=
=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On 25/9/23 19:17, Edgar E. Iglesias wrote:<br>
&gt; <br>
&gt; On Mon, Sep 25, 2023 at 7:00=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com" target=3D"_blank">berrange@redhat.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:berrange@redhat.com" t=
arget=3D"_blank">berrange@redhat.com</a>&gt;&gt; writes:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On Mon, Sep 25, 2023 at 03:48:27PM +0100, Ale=
x Benn=C3=A9e wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; This might be premature but while streaml=
ing the avocado tests I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; realised the only tests we have are &quot=
;check-tcg&quot; ones. The aging<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; fedora-criss-cross image works well enoug=
h for developers but<br>
&gt;=C2=A0 =C2=A0 =C2=A0can&#39;t be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; used in CI as we need supported build pla=
tforms to build QEMU.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Does this mean the writing is on the wall=
 for this architecture?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Signed-off-by: Alex Benn=C3=A9e &lt;<a hr=
ef=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.o=
rg</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org=
" target=3D"_blank">alex.bennee@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Cc: Rabin Vincent &lt;<a href=3D"mailto:r=
abinv@axis.com" target=3D"_blank">rabinv@axis.com</a> &lt;mailto:<a href=3D=
"mailto:rabinv@axis.com" target=3D"_blank">rabinv@axis.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; Cc: Edgar E. Iglesias &lt;<a href=3D"mail=
to:edgar.iglesias@xilinx.com" target=3D"_blank">edgar.iglesias@xilinx.com</=
a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:edgar.iglesias@xilinx.=
com" target=3D"_blank">edgar.iglesias@xilinx.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;=C2=A0 docs/about/deprecated.rst | 11 ++++=
+++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;=C2=A0 1 file changed, 11 insertions(+)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; diff --git a/docs/about/deprecated.rst b/=
docs/about/deprecated.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; index dc4da95329..7cfe313aa6 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; --- a/docs/about/deprecated.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +++ b/docs/about/deprecated.rst<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; @@ -399,6 +399,17 @@ Specifying the iSCSI=
 password in plain text<br>
&gt;=C2=A0 =C2=A0 =C2=A0on the command line using the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;=C2=A0 used instead, to refer to a ``--obj=
ect secret...`` instance<br>
&gt;=C2=A0 =C2=A0 =C2=A0that provides<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;=C2=A0 a password via a file, or encrypted=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +TCG CPUs<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +--------<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +CRIS CPU architecture (since 8.1)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;=
&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +The CRIS architecture was pulled from Li=
nux in 4.17 and the<br>
&gt;=C2=A0 =C2=A0 =C2=A0compiler<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +is no longer packaged in any distro maki=
ng it harder to run the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +``check-tcg`` tests. Unless we can impro=
ve the testing<br>
&gt;=C2=A0 =C2=A0 =C2=A0situation there<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;&gt; +is a chance the code will bitrot without=
 anyone noticing.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Deprecated is generally a warning that we int=
end to delete the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; feature.=C2=A0 =C2=A0If we&#39;re just going =
to relegate it to untested<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; status (what I&#39;d call &quot;tier 3&quot; =
quality), then we should document<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; that elsewhere.=C2=A0 I don&#39;t mind which =
way we go.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We do have reasonably good coverage with tests/tcg/=
cris but of course<br>
&gt;=C2=A0 =C2=A0 =C2=A0without a compiler we can&#39;t build them.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Both nios2 and microblaze have build-toolchain scri=
pts which can be used<br>
&gt;=C2=A0 =C2=A0 =C2=A0to re-create containers. However my preference is h=
aving pre-built<br>
&gt;=C2=A0 =C2=A0 =C2=A0toolchains hosted by others like we do for loongarc=
h, hexagon, xtensa<br>
&gt;=C2=A0 =C2=A0 =C2=A0and tricore. Then the docker image can simply curl =
them into an image.<br>
&gt; <br>
&gt; <br>
&gt; Yeah, I guess it&#39;s time to deprecate it...<br>
<br>
Is that an informal Acked-by? (:<br><br></blockquote><div><br></div><div>OK=
 with me!</div><div><br></div><div>Acked-by: Edgar E. Iglesias &lt;<a href=
=3D"mailto:edgar.iglesias@gmail.com">edgar.iglesias@gmail.com</a>&gt;</div>=
<div>=C2=A0</div></div></div>

--000000000000757348060fb1796c--

