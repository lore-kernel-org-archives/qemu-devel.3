Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E55CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 02:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwX8g-000722-3a; Wed, 10 Sep 2025 22:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1uwX8W-00071Z-Mz
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:34:14 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1uwX8T-0006Jm-8F
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 22:34:11 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-30ccea94438so196681fac.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 19:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1757558046; x=1758162846;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OoVxjFsjJAlh0WPqHUA9/nu+myTrSDHO/Iwng+HtCbs=;
 b=NPe9f0u1LkUgeU8ELsWyw1Ork3oyVnnUgJOc1WlsJtD+hBmtwmgTv8+7Bx8UqfzgdA
 fiu/OQFCKmAgVKN/Wk+JMUurYoOQg9lVzu6svIIXtvXeLImOfjYBQ5ouIGHYjQBPmmvz
 c7yuzCnSW4qZK9NL/qv8B8IIEbdmj/0Z/Y+Sf0rQm74+TOPvTbH+1ZInMVhJ/7z6U3T7
 IfZJ0JDF6BccI+396nPPJPYiA4/KL/8C6ntQmUff0ZtNrIVYm/iDmJ/0CD63JjPBfN0k
 HVC3u1FDhU+MIX/71kMZzxv+mtagbLFlRGblbJTzWCPRgIIuQsJN7/iyKjUrQ95GFojG
 Ef7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757558046; x=1758162846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OoVxjFsjJAlh0WPqHUA9/nu+myTrSDHO/Iwng+HtCbs=;
 b=e0d8kJgw3WimBF64MrO8fG/N8cH7Eh9n1xKBNySIUJzEljngYCHpZMfkfPsHzn5/JG
 ZXQ2We9em5cRtUonBPBjcbWWftX4Cwg/7cxEnnoPzbEsStbZOZYpH40o2qWWwBdYs5O6
 Y6468eq5qpO6WMiZHQFjFn6egxOTCeDsfa6vngIQZFi1uCij3EvgqVDM4ytf8o7+euFG
 X/hIN/U1xw61+a+x7Lew/S8gSG+5uQt+MObs58bGTmcYnNidaFXuKlVWPAgiF4WbUlkw
 yN/fCfyJ6gfcVRQbsjF64GwEYD9enyq1P40XOWOvPkhg5ZLZ7w2qAMZjwtS7HlLQwSSQ
 uLHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmzWaLItGII7bB59VZr11fIo/Pywni1M43OzNUUJamf1P5rpYkPnu3+VfSeX0DcAHmb5CF1VUbqOTD@nongnu.org
X-Gm-Message-State: AOJu0YyS08gCKER0j7RWdWhIVxEUW4e3vP15QQs6IVrfKFVQ5Oxkyy7y
 zRCSL+dopgIW05Fj/Q8XDCLjnes3EV+8RgC0g59ne40az4XC201XL0ECeewp+l1eesdAYWyifeK
 AcwyzL1GzXB+Ah0L65ty7K6gcvaAZ13yqu4+vy8XvMA==
X-Gm-Gg: ASbGncsNy/33DukqHnzinhBbgMuBW2Vw/NWCrTa29sGcJQjK4EhP3LEvPY2n/LePyvD
 5qfEnkBSbvvDZwF5zIpbGJ8zzZEtr33awCOIMCOWauOIt1JC/WWcAGnWMGX4ARoXWcHrmL87IHi
 6tXXqwHrDEoE9S+D33HqQodzHzZcpzh2DBYazs7wCtY/1sdVkEsnMAnV0fyeUdXUdaW800wazRI
 pXiGxCS+u8DJYSE2W1Ukfr/vxRePlvEnt4xiuHC6YKA
X-Google-Smtp-Source: AGHT+IFhx2nKtH7yglkmrGelJOxzWb8+CRkvvpFXYdXaKrsjfThV1ebagG+7/rQsW35xPv1jeP+tSzN5s6SHQJ3gJUI=
X-Received: by 2002:a05:6870:3043:b0:315:bcca:be26 with SMTP id
 586e51a60fabf-3226480ed2amr8497916fac.32.1757558045636; Wed, 10 Sep 2025
 19:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com> <aMHFrDEW8cbnXajG@redhat.com>
In-Reply-To: <aMHFrDEW8cbnXajG@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 11 Sep 2025 10:33:49 +0800
X-Gm-Features: Ac12FXwGXXbL2huPE7zgjaN_iLCIWfZOt-Lt0MhuguUnGgG-imoQ5nUY8J4GYYc
Message-ID: <CAK9dgmYY-193Nom=DteAp2mDCNCMdA-fUMi8PH5iAoVVZ59cKQ@mail.gmail.com>
Subject: Re: Some iotests are failing with -luks
To: Kevin Wolf <kwolf@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 hreitz@redhat.com, 
 Maxim Levitsky <mlevitsk@redhat.com>, berrange@redhat.com, armbru@redhat.com
Content-Type: multipart/alternative; boundary="000000000000fb885b063e7d5e15"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fb885b063e7d5e15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:38=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 10.09.2025 um 18:08 hat Kevin Wolf geschrieben:
> > Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
> > > luks-detached-header   fail       [17:15:26] [17:15:38]   12.2s
>         failed, exit status 1
> > > ---
> /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header.out
> > > +++
> /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-deta=
ched-header/luks-detached-header.out.bad
> > > @@ -1,5 +1,55 @@
> > > -..
> > > +EE
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +ERROR: test_detached_luks_header
> (__main__.TestDetachedLUKSHeader.test_detached_luks_header)
> > > +--------------------------------------------------------------------=
--
> > > +Traceback (most recent call last):
> > > +  File
> "/home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header",
> line 139, in setUp
> > > +    res =3D qemu_img_create(
> > > +          ^^^^^^^^^^^^^^^^
> > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> 278, in qemu_img_create
> > > +    return qemu_img('create', *args)
> > > +           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> 261, in qemu_img
> > > +    return qemu_tool(*full_args, check=3Dcheck,
> combine_stdio=3Dcombine_stdio)
> > > +
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> 241, in qemu_tool
> > > +    raise VerboseProcessError(
> > > +qemu.utils.VerboseProcessError: Command
> '('/home/thuth/tmp/qemu-build/qemu-img', 'create', '-f', 'luks', '-o',
> 'iter-time=3D10', '-o', 'key-secret=3Dsec0', '-o', 'detached-header=3Dtru=
e',
> '--object', 'secret,id=3Dsec0,data=3Dfoo',
> '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-det=
ached-header/detached_header.img2')'
> returned non-zero exit status 1.
> > > +  =E2=94=8F=E2=94=81 output
> =E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81
> > > +  =E2=94=83 Formatting
> '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/l
> > > +  =E2=94=83 uks-file-luks-detached-header/detached_header.img2', fmt=
=3Dluks
> > > +  =E2=94=83 size=3D-1 key-secret=3Dsec0 iter-time=3D10 detached-head=
er=3Dtrue
> > > +  =E2=94=83 qemu-img:
> /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luk
> > > +  =E2=94=83 s-file-luks-detached-header/detached_header.img2: Parame=
ter
> > > +  =E2=94=83 'detached-header' is unexpected
> > > +
> =E2=94=97=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81
> >
> > This one is surprising. I don't think anything relevant in the luks
> > driver has changed since the test was introduced. At the same time, the
> > code clearly has a problem when it tries to convert a QemuOpts
> > containing a "detached-header" option into a QAPI object when the schem=
a
> > doesn't even have this option. Was this broken from the beginning? Woul=
d
> > have been for a year and half.
>
> I bisected this one because I was curious how this could happen, and it
> was broken quite explicitly by commit e818c01a:
>
> commit e818c01ae6e7c54c7019baaf307be59d99ce80b9 (HEAD)
> Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Date:   Mon Feb 19 15:12:59 2024 +0000
>
>     qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header
>
>     The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
>     was left over from earlier patch iterations.
>
>     Acked-by: Markus Armbruster <armbru@redhat.com>
>     Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The test case demonstrates that it actually wasn't unused.
>
> If we don't want to reintroduce the field in QAPI, we need to explicitly
>

Keeping the detached-header option is more convenient for users when

creating a detached-header image.

My inclination is to bring this optionback.  Any suggestions? cc @Daniel P.
Berrang=C3=A9 <berrange@redhat.com>


> delete it from the QemuOpts in block_crypto_co_create_opts_luks() before
> block_crypto_create_opts_init() creates a QCryptoBlockCreateOptions from
> the given options and fails now that this option doesn't exist any more.
>
> Kevin
>
>

--=20
Best regards

--000000000000fb885b063e7d5e15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Thu, Sep 11, 2025 at 2:38=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailt=
o:kwolf@redhat.com">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1e=
x">Am 10.09.2025 um 18:08 hat Kevin Wolf geschrieben:<br>
&gt; Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:<br>
&gt; &gt; luks-detached-header=C2=A0 =C2=A0fail=C2=A0 =C2=A0 =C2=A0 =C2=A0[=
17:15:26] [17:15:38]=C2=A0 =C2=A012.2s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 failed, exit status 1<br>
&gt; &gt; --- /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached=
-header.out<br>
&gt; &gt; +++ /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-fi=
le-luks-detached-header/luks-detached-header.out.bad<br>
&gt; &gt; @@ -1,5 +1,55 @@<br>
&gt; &gt; -..<br>
&gt; &gt; +EE<br>
&gt; &gt; +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>
&gt; &gt; +ERROR: test_detached_luks_header (__main__.TestDetachedLUKSHeade=
r.test_detached_luks_header)<br>
&gt; &gt; +----------------------------------------------------------------=
------<br>
&gt; &gt; +Traceback (most recent call last):<br>
&gt; &gt; +=C2=A0 File &quot;/home/thuth/devel/qemu/tests/qemu-iotests/test=
s/luks-detached-header&quot;, line 139, in setUp<br>
&gt; &gt; +=C2=A0 =C2=A0 res =3D qemu_img_create(<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^^^^^^^^^^^^^^^^<br>
&gt; &gt; +=C2=A0 File &quot;/home/thuth/devel/qemu/tests/qemu-iotests/iote=
sts.py&quot;, line 278, in qemu_img_create<br>
&gt; &gt; +=C2=A0 =C2=A0 return qemu_img(&#39;create&#39;, *args)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^=
^^<br>
&gt; &gt; +=C2=A0 File &quot;/home/thuth/devel/qemu/tests/qemu-iotests/iote=
sts.py&quot;, line 261, in qemu_img<br>
&gt; &gt; +=C2=A0 =C2=A0 return qemu_tool(*full_args, check=3Dcheck, combin=
e_stdio=3Dcombine_stdio)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
&gt; &gt; +=C2=A0 File &quot;/home/thuth/devel/qemu/tests/qemu-iotests/iote=
sts.py&quot;, line 241, in qemu_tool<br>
&gt; &gt; +=C2=A0 =C2=A0 raise VerboseProcessError(<br>
&gt; &gt; +qemu.utils.VerboseProcessError: Command &#39;(&#39;/home/thuth/t=
mp/qemu-build/qemu-img&#39;, &#39;create&#39;, &#39;-f&#39;, &#39;luks&#39;=
, &#39;-o&#39;, &#39;iter-time=3D10&#39;, &#39;-o&#39;, &#39;key-secret=3Ds=
ec0&#39;, &#39;-o&#39;, &#39;detached-header=3Dtrue&#39;, &#39;--object&#39=
;, &#39;secret,id=3Dsec0,data=3Dfoo&#39;, &#39;/home/thuth/tmp/qemu-build/t=
ests/qemu-iotests/scratch/luks-file-luks-detached-header/detached_header.im=
g2&#39;)&#39; returned non-zero exit status 1.<br>
&gt; &gt; +=C2=A0 =E2=94=8F=E2=94=81 output =E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81<br>
&gt; &gt; +=C2=A0 =E2=94=83 Formatting &#39;/home/thuth/tmp/qemu-build/test=
s/qemu-iotests/scratch/l<br>
&gt; &gt; +=C2=A0 =E2=94=83 uks-file-luks-detached-header/detached_header.i=
mg2&#39;, fmt=3Dluks<br>
&gt; &gt; +=C2=A0 =E2=94=83 size=3D-1 key-secret=3Dsec0 iter-time=3D10 deta=
ched-header=3Dtrue<br>
&gt; &gt; +=C2=A0 =E2=94=83 qemu-img: /home/thuth/tmp/qemu-build/tests/qemu=
-iotests/scratch/luk<br>
&gt; &gt; +=C2=A0 =E2=94=83 s-file-luks-detached-header/detached_header.img=
2: Parameter<br>
&gt; &gt; +=C2=A0 =E2=94=83 &#39;detached-header&#39; is unexpected<br>
&gt; &gt; +=C2=A0 =E2=94=97=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=
=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=
=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=
=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81=E2=94=81<br>
&gt; <br>
&gt; This one is surprising. I don&#39;t think anything relevant in the luk=
s<br>
&gt; driver has changed since the test was introduced. At the same time, th=
e<br>
&gt; code clearly has a problem when it tries to convert a QemuOpts<br>
&gt; containing a &quot;detached-header&quot; option into a QAPI object whe=
n the schema<br>
&gt; doesn&#39;t even have this option. Was this broken from the beginning?=
 Would<br>
&gt; have been for a year and half.<br>
<br>
I bisected this one because I was curious how this could happen, and it<br>
was broken quite explicitly by commit e818c01a:<br>
<br>
commit e818c01ae6e7c54c7019baaf307be59d99ce80b9 (HEAD)<br>
Author: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" =
target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Mon Feb 19 15:12:59 2024 +0000<br>
<br>
=C2=A0 =C2=A0 qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-head=
er<br>
<br>
=C2=A0 =C2=A0 The &#39;detached-header&#39; field in QCryptoBlockCreateOpti=
onsLUKS<br>
=C2=A0 =C2=A0 was left over from earlier patch iterations.<br>
<br>
=C2=A0 =C2=A0 Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:=
berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
The test case demonstrates that it actually wasn&#39;t unused.<br>
<br>
If we don&#39;t want to reintroduce the field in QAPI, we need to explicitl=
y<br></blockquote><div><br></div><div><p style=3D"color:rgb(0,0,0)"><font f=
ace=3D"comic sans ms, sans-serif">Keeping the detached-header option is mor=
e convenient for users when</font></p><p style=3D"color:rgb(0,0,0)"><font f=
ace=3D"comic sans ms, sans-serif">creating a detached-header image.<span cl=
ass=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">=C2=A0</span></font></p><p style=3D"color:rgb(0,0,0)"><span style=3D"=
color:rgb(34,34,34)"><font face=3D"comic sans ms, sans-serif">My inclinatio=
n is to bring this option<span class=3D"gmail_default" style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif"></span>back.<span class=3D"gmail_def=
ault" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"> =C2=A0Any=
 suggestions? cc=C2=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-1" h=
ref=3D"mailto:berrange@redhat.com" tabindex=3D"-1">@Daniel P. Berrang=C3=A9=
</a>=C2=A0</span></font></span></p></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
delete it from the QemuOpts in block_crypto_co_create_opts_luks() before<br=
>
block_crypto_create_opts_init() creates a QCryptoBlockCreateOptions from<br=
>
the given options and fails now that this option doesn&#39;t exist any more=
.<br>
<br>
Kevin<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--000000000000fb885b063e7d5e15--

