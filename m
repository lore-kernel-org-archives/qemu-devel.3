Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C93CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPo9c-00027c-Pt; Wed, 20 May 2026 17:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPo9b-00027Q-IZ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:08:35 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <infra.ai.cloud@bitdeer.com>)
 id 1wPo9Z-0000xG-TJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:08:35 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5a8ee4b703fso5144272e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779311312; cv=none;
 d=google.com; s=arc-20240605;
 b=b0C6iCsywVWuhS7l524Uadmv+Q0jepKALl9sFspaqBrj/8/4GHh7U/9zZ4MJcEEUeh
 f0ATp5IaZgpKk1Vtw/tdtXPoFsLvlspc+QWcWvl60YIvEMF1AC+u71U5QnPT028MX9sw
 lfL4pjoh5ODEJ03t9ifaBYaaydhL6kClV5mdzXLWhAjuTlR13reCMd3iuIpM2KjCAGK7
 vhiB5eWa//MPDSlR/tdptZJBqd1i89T3kO3attJpLocWLKpvl903PFOwmiuoMct0rFKs
 E8Sd2tm17PCnxEFbtE1Vtr247YW6WDskV+lD/L74cnYFnW9MG08Rp2C+GHewKp1Qo9rg
 g9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Q3qdC7qVa5e6g17UkmvMSp7kPIV2dLkO8jrIZWiwJXM=;
 fh=7d+eDs1Zqko+mFtjv8NQI3f4QimVpmTOMJe4tPdyAlc=;
 b=TiOg2Old72o89pLrv8gV0K7t46+hIpuRGskWJ0pXC+GQ4ra20Pl196eNoCreSBTFtP
 oFgpi6las/0+LmLUZxOzHtftiZSA83TqqeBavHrqJ3FDIIHMtgbCwEdvuCN39l0OdeUy
 gx9V9Tc0S3qknSGtxdu4fOpYOtdD7GENCPPZ8S+i+mAXnuwwN48w+N/2FLwQX37SSTn2
 s4EiGLI5rJyMTX/RCK59NsHNcLcvd8qKdY+2PTklIr+7bL9FKhjIME3yD/FoH3xgwIoY
 BZR0B8zroDZclKCNprmETS56o5vvBYBwFJ3itM/8nsu4Qv3UJWiOffLsjFqUa5GHOmW7
 V9Kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdeer.com; s=google; t=1779311312; x=1779916112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3qdC7qVa5e6g17UkmvMSp7kPIV2dLkO8jrIZWiwJXM=;
 b=JgfjUG0EtEmsE7f2T/giYiU1uAIrFUCvLdUUn4wXl+RM5dh9VkQCt1TlKi735DM7/k
 lXKvaWmHpGgAbt6PX9wYEAJcA8ajRgp0XIVwlNvibXGwqDbUMwLJ7pNLNSXY5T40qGou
 OfdJvwQjBTo8nZPl1pCyo5izTFrSZc4g3FzM2cLGhsBQTw0HqDWrxMgRWvcGvEpf+9vs
 RLJpQa27lSuYjcPKJg1xTUgNzZiiPaEVdO7aYiCnv5zyyHXjAA8pTgsZxFov19xwdGvv
 edgqfaTJlRyczReECUUvPezqpAB2ASXE1dEyJsZfpz0Qe2BGQ9hnaDO8MmcsnwaauMez
 hxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779311312; x=1779916112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3qdC7qVa5e6g17UkmvMSp7kPIV2dLkO8jrIZWiwJXM=;
 b=GKVU+e5UfZIb9m0KwQuSfEZ/u5Rr71jwx9ZhY4QTW44+UQ/o1nT9kScuusJXF0iBGx
 M1ztBtVT670U8vBSkZYaQzIrjr0c2hiPNYhDV/0OWJNPyYd/32clv0huJHjnVnD7Howc
 bRU9UooOAYWfjPRghRn4Dvl5RzzQYEpinHxnr/TGd3LLxOapRud4Vy3XboutAUtYaazN
 LevTE1EEyUN48/rsYirMud+1oFiYCyJoBXVr1MBNT0D3Ahkw8EMhDgepxdIRGBbG3oYT
 /Lz+A9KttlOBaN3CrjU2WIPOt6EwsAVJEqBUXJucxd3YNr7ANv6efY0rmk9DV6mowDFC
 lzQQ==
X-Gm-Message-State: AOJu0YxJkG9n70WJkwP/66IXUr94hm7nYPvcWamOyR7f1UTusILfh668
 p81leH5EwpTQape7eNZKJ1FR1YREfxBvVh10BKCJ6A9UqVqVq4n1c6lt8J7pIxgAT7AX+mNIwDJ
 JAaoWe2ZGt/Ji/CtJP9DVGzjTlyQc5hiVvKgczHeq6A==
X-Gm-Gg: Acq92OF1QQ5aypcjMw7vqZ5rAQHBO0QcKM302V7nF8TtYuqYJOEDCqMDgLy0ybTn0s0
 VekLLrO3JApmjOwpcY3wHGCvURHmt/SR5iLXKw/E0a60JhtIX2gRYM98SeK7SicUTN2oSmeedGL
 bUh6hpCxzAMjTkjk1XY1E+8pzbd/pebSz1l6ocr1qhLshLFNGe9VoRP2IRFxpxUO+HgJAqsOoCE
 5YIhMzY2elROO8cL0gj3m3Ec+0fpy2QC3zgy7Zk7OHBQPod2/CrOLwSCxDWRC6gNZQKSd411VH/
 OXY9lORNr6UKLbi3qvpWSN+98nf0OKk=
X-Received: by 2002:ac2:456a:0:b0:5aa:b6a:6028 with SMTP id
 2adb3069b0e04-5aa2baa222emr23114e87.45.1779311311844; Wed, 20 May 2026
 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
 <ag4HBdzJXGdKgy50@x1.local> <ag4h_-o7u9-0pdqN@x1.local>
In-Reply-To: <ag4h_-o7u9-0pdqN@x1.local>
From: Hy Man <infra.ai.cloud@bitdeer.com>
Date: Thu, 21 May 2026 05:08:19 +0800
X-Gm-Features: AVHnY4JfVqOalV4tUrXSLghcmTkSPTEa7CtSE2ADz4J0h5Jq-NIcHD66Jt1V9dI
Message-ID: <CAFWXh4w5FjKZ=+WWTOCeaK3ut5N57dwfFfEgV6Qw0sH=JcbSYg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Yong Huang
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@bitdeer.com>
Content-Type: multipart/alternative; boundary="000000000000b005a206524632ac"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=infra.ai.cloud@bitdeer.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000b005a206524632ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Haha, thanks!

Peter Xu <peterx@redhat.com>=E4=BA=8E2026=E5=B9=B45=E6=9C=8821=E6=97=A5 =E5=
=91=A8=E5=9B=9B05:05=E5=86=99=E9=81=93=EF=BC=9A

> On Wed, May 20, 2026 at 03:09:57PM -0400, Peter Xu wrote:
> > > @@ -3784,7 +3784,7 @@ F: migration/rdma*
> > >  F: scripts/rdma-migration-helper.sh
> > >
> > >  Migration dirty limit and dirty page rate
> > > -M: Hyman Huang <yong.huang@smartx.com>
> > > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
> > >  S: Maintained
> > >  F: system/dirtylimit.c
> > >  F: include/system/dirtylimit.h
> > > @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h
> > >  F: docs/devel/migration/dirty-limit.rst
> > >
> > >  Detached LUKS header
> > > -M: Hyman Huang <yong.huang@smartx.com>
> > > +M: Hyman Huang <infra.ai.cloud@biitdeer.com>
>
> Both addresses are wrong.  I think you typed one more "i".  Well, I
> enriched my life by finding a bug in a maintainer file update..
>
> I'll fix it when sending the pull.
>
> > >  S: Maintained
> > >  F: tests/qemu-iotests/tests/luks-detached-header
> > >  F: docs/devel/luks-detached-header.rst
> > > --
> > > 2.43.0
> > >
> >
> > --
> > Peter Xu
>
> --
> Peter Xu
>
>

--000000000000b005a206524632ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Haha, thanks!</div><div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">Peter Xu &lt;<a href=3D"mailto=
:peterx@redhat.com">peterx@redhat.com</a>&gt;=E4=BA=8E2026=E5=B9=B45=E6=9C=
=8821=E6=97=A5 =E5=91=A8=E5=9B=9B05:05=E5=86=99=E9=81=93=EF=BC=9A<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On Wed, May 20, 2026 at 03:09:57PM -0400, Pe=
ter Xu wrote:<br>
&gt; &gt; @@ -3784,7 +3784,7 @@ F: migration/rdma*<br>
&gt; &gt;=C2=A0 F: scripts/rdma-migration-helper.sh<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 Migration dirty limit and dirty page rate<br>
&gt; &gt; -M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" targ=
et=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; +M: Hyman Huang &lt;<a href=3D"mailto:infra.ai.cloud@biitdeer.com=
" target=3D"_blank">infra.ai.cloud@biitdeer.com</a>&gt;<br>
&gt; &gt;=C2=A0 S: Maintained<br>
&gt; &gt;=C2=A0 F: system/dirtylimit.c<br>
&gt; &gt;=C2=A0 F: include/system/dirtylimit.h<br>
&gt; &gt; @@ -3794,7 +3794,7 @@ F: include/system/dirtyrate.h<br>
&gt; &gt;=C2=A0 F: docs/devel/migration/dirty-limit.rst<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 Detached LUKS header<br>
&gt; &gt; -M: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" targ=
et=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
&gt; &gt; +M: Hyman Huang &lt;<a href=3D"mailto:infra.ai.cloud@biitdeer.com=
" target=3D"_blank">infra.ai.cloud@biitdeer.com</a>&gt;<br>
<br>
Both addresses are wrong.=C2=A0 I think you typed one more &quot;i&quot;.=
=C2=A0 Well, I<br>
enriched my life by finding a bug in a maintainer file update..<br>
<br>
I&#39;ll fix it when sending the pull.<br>
<br>
&gt; &gt;=C2=A0 S: Maintained<br>
&gt; &gt;=C2=A0 F: tests/qemu-iotests/tests/luks-detached-header<br>
&gt; &gt;=C2=A0 F: docs/devel/luks-detached-header.rst<br>
&gt; &gt; -- <br>
&gt; &gt; 2.43.0<br>
&gt; &gt; <br>
&gt; <br>
&gt; -- <br>
&gt; Peter Xu<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div></div>

--000000000000b005a206524632ac--

