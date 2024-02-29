Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6904C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 02:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfVpA-0008LT-ER; Wed, 28 Feb 2024 21:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rfVp7-0008L2-QT
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:07:01 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rfVp5-0005Y4-Cu
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 21:07:01 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29a2545a1e7so240733a91.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709172295; x=1709777095;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2Bq9p+qG96xfPkv9tuIHKkMJIOOzAymeS4gG1kGJAAE=;
 b=z+ZwDUVEqBSTHoAPcpIn/IPzUVPVfuMaYPbKUSjOA1KYiCswlJMEu2ZMeaFEkvBl+C
 JtLvtR/YtkD5B/Zq5pteI5b2qtVVkQbP//259vENi8CPSQ4Wb0x3euv0bZ9+DTYS2kKE
 /tBtx+5gar/o542RGh9OlSM0vXIX6oWPLsvoqJ2h34fpwexgi7IGGPOLq4ODkv5eWfgy
 3LOGnFOc7+sGHder5kemVGVoM10DHm+21/tgrZbq+4resWIMP4Y9HJ267iuTmgQuch5R
 agQ6ORLwt3JJ68+w0LCTOHKPPWOjuLjqZiqAnG0V7utpmRo2iS06m9eMsSfUXrSa4G12
 Gm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709172295; x=1709777095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Bq9p+qG96xfPkv9tuIHKkMJIOOzAymeS4gG1kGJAAE=;
 b=fVBXJCdKXMzBwvnm6f/w8ChGTbE4mLJCy9PitYtOFwQ/xJ0Zdxgj3i0p1Sb231+Xxg
 pfpOthZVU1yYyF5Jjk3xR06CGWVWEUQFqst1sfwQW14RCcm1yKkNRzt8MD3hO/oZ1+C9
 Qzoc2W62iuwHy5916wrvgoW4xRx92e+m9GgLv1Bsi8nLFUI4V3mPf7osTsLt80pK2LkH
 jqw7RBwr6Cm/uo2CRmuJUOT9VsLr2TOB0b5YWJHKWEWfvdRjaXBCT26B/bxQCt71qOJ7
 sf4lHfTprZONqSG+vU38kFntCGqurIG4yuWekz/rhD03HD/m2ZPP904A6n1CoAkHKdWc
 xF0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXDalCZdZ2xweKe+ughKJDZhl+HdDrisr/F9STVf+TjYKv4Ar7t0wBRrKZUQ/YbM2rCOOx21kctlMqZsG0yeryLBIcSjU=
X-Gm-Message-State: AOJu0YzcKw8omm/ipHlAieLR9L0SxHgyEYWRjOYNa9kMkSfElwhAdRbl
 AhqpDvVhtm2VBioLJ6sM+lg5gn1+XdEmBzyJ0NIiE9bEpBHy3GdyaJCOx60jKksB/CMkPZVDpBM
 iUkeuPqRwOFOqlIPEWmVnYk7CnQZNVjo2N6xpWg==
X-Google-Smtp-Source: AGHT+IF7J+iu5jMfkxOpPZI81WYyyz0aFa902LdNcWt0awTWM4j3C97FIo28sPTm+9tyM7hfcYHF5NHD2Z56O+DCcWA=
X-Received: by 2002:a17:90b:3017:b0:29a:56d5:230 with SMTP id
 hg23-20020a17090b301700b0029a56d50230mr974910pjb.25.1709172293130; Wed, 28
 Feb 2024 18:04:53 -0800 (PST)
MIME-Version: 1.0
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 <875xyiz0ho.fsf@pond.sub.org>
 <CAK9dgmZOEqd=EgBjsiZZoK3R+VQRMqSdUrK_WwKHfP7LiWzQMQ@mail.gmail.com>
 <87v8693x7c.fsf@pond.sub.org> <Zd8IQShNrGeXEnLz@redhat.com>
 <Zd8ZOHJxhgrmbIWc@redhat.com> <Zd8f3CGhoDDsZnGU@redhat.com>
In-Reply-To: <Zd8f3CGhoDDsZnGU@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 29 Feb 2024 10:04:36 +0800
Message-ID: <CAK9dgmaeY6GE5UDk6D9Sg+X-m-P32RcQQfmfPFOH_O9AseXHww@mail.gmail.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000647bc406127baf39"
Received-SPF: none client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000647bc406127baf39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:58=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 28.02.2024 um 12:30 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Wed, Feb 28, 2024 at 11:17:37AM +0100, Kevin Wolf wrote:
> > > Until now, @size has been mandatory for creating images with every
> > > driver. Maybe we should even have put it into BlockdevCreateOptions's
> > > base, because without a size, you're not really creating an image.
> >
> > NB, @size isn't mandatory for creating images. It isn't required
> > when creating qcow2 files with backing stores, as the size is
> > acquired from the backing file instead.
> >
> > $ qemu-img create demo.raw 1g
> > Formatting 'demo.raw', fmt=3Draw size=3D1073741824
> > $ qemu-img create -o backing_file=3Ddemo.raw -o backing_fmt=3Draw -f qc=
ow2
> demo.qcow2
> > Formatting 'demo.qcow2', fmt=3Dqcow2 cluster_size=3D65536 extended_l2=
=3Doff
> compression_type=3Dzlib size=3D1073741824 backing_file=3Ddemo.raw backing=
_fmt=3Draw
> lazy_refcounts=3Doff refcount_bits=3D16
>
> Yes, 'qemu-img create' is different, it adds some convenience magic like
> this. But for 'blockdev-create', it's mandatory for every driver. I
> double checked the QAPI schema.
>
> Kevin
>
>
IMHO, LUKS detached header creation is not the case as qcow2 backing store
creation in
aspect of allowing @size absent, since qemu-img creation process fetch
the @size from
backing file as Daniel said above actually, while contrastively LUKS
detached header
creation with no need for @size. Making @size optional feels better for me.

Yong

--=20
Best regards

--000000000000647bc406127baf39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 28, 20=
24 at 7:58=E2=80=AFPM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kw=
olf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex">Am 28.02.2024 um 12=
:30 hat Daniel P. Berrang=C3=A9 geschrieben:<br>
&gt; On Wed, Feb 28, 2024 at 11:17:37AM +0100, Kevin Wolf wrote:<br>
&gt; &gt; Until now, @size has been mandatory for creating images with ever=
y<br>
&gt; &gt; driver. Maybe we should even have put it into BlockdevCreateOptio=
ns&#39;s<br>
&gt; &gt; base, because without a size, you&#39;re not really creating an i=
mage.<br>
&gt; <br>
&gt; NB, @size isn&#39;t mandatory for creating images. It isn&#39;t requir=
ed<br>
&gt; when creating qcow2 files with backing stores, as the size is<br>
&gt; acquired from the backing file instead.<br>
&gt; <br>
&gt; $ qemu-img create demo.raw 1g<br>
&gt; Formatting &#39;demo.raw&#39;, fmt=3Draw size=3D1073741824<br>
&gt; $ qemu-img create -o backing_file=3Ddemo.raw -o backing_fmt=3Draw -f q=
cow2 demo.qcow2<br>
&gt; Formatting &#39;demo.qcow2&#39;, fmt=3Dqcow2 cluster_size=3D65536 exte=
nded_l2=3Doff compression_type=3Dzlib size=3D1073741824 backing_file=3Ddemo=
.raw backing_fmt=3Draw lazy_refcounts=3Doff refcount_bits=3D16<br>
<br>
Yes, &#39;qemu-img create&#39; is different, it adds some convenience magic=
 like<br>
this. But for &#39;blockdev-create&#39;, it&#39;s mandatory for every drive=
r. I<br>
double checked the QAPI schema.<br>
<br>
Kevin<br>
<br>
</blockquote></div><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">IMHO, LUKS detached header c=
reation is not the case as qcow2 backing store creation in</div><div class=
=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f">aspect of allowing=C2=A0@size absent, since qemu-img creation process fe=
tch the=C2=A0@size from</div><div class=3D"gmail_default" style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif">backing file as Daniel said above=
 actually, while contrastively=C2=A0LUKS detached header</div><div class=3D=
"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">=
creation with no need for=C2=A0@size. Making=C2=A0@size optional feels bett=
er for me.</div><br clear=3D"all"><div><div class=3D"gmail_default" style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Yong</div><br></div><=
span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-ser=
if">Best regards</font></div></div></div>

--000000000000647bc406127baf39--

