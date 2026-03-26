Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0540010A88FC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 18:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5pPv-0007oK-0N; Thu, 26 Mar 2026 14:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5pPt-0007nq-0G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5pPr-0006lL-3d
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 14:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774549604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xWeOj0brF1shrbvQa0ImHlZ6Y3/l694qXGPs1DXB2IU=;
 b=WkV5UvW/3o/0YXNuyaqFUHf9N5E3iSQlca8Yl2AWSqfEfUn3CgGDu0BuIbJptsRuaAuYIT
 Y2Gx1+/RuBD0yFpIBGjpftMFddkCi5+F1SsBHYYFPZjtrWv2oeBCHDXFgrxFQHg/0KY0fW
 R7fBerVe+DqjnTA4yIIDFCbND6VN0Pg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-MeXk_H7pNimoCpZpton-UQ-1; Thu, 26 Mar 2026 14:26:42 -0400
X-MC-Unique: MeXk_H7pNimoCpZpton-UQ-1
X-Mimecast-MFC-AGG-ID: MeXk_H7pNimoCpZpton-UQ_1774549602
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79aa3a19ea3so27524517b3.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 11:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774549602; cv=none;
 d=google.com; s=arc-20240605;
 b=Hq14XjDcwMkG424KZ5ovEWcM2viLKrkWNdHAItZyUjR5Gnj9CbmZhtii7dGoQmqKCV
 vTB6Y3F9bmTjDNOp37JrFDcgkA7l+E6jdZb0HuCNs7whOu4Mqyh6GUci9bAx/ZfbaA+l
 ScBBsY9HZQ1aymNH7BAfdhjCINeeydAQlQFY5uPWwsMe93fwamGrXY+2kaGRwRNmsu6R
 1LpSDNcBQiJJ8+qRhnTI3dzQ4+YHXNFBc93247EAfkW3+TqhvOkWcvcrP/vmzjVeExmr
 Met72VSBYPU6b+JINnlrM16AP7pPj0aq1zayz9WOWa/ck56BU3SPuzSfXGWEYrj3AWO1
 +Nog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xWeOj0brF1shrbvQa0ImHlZ6Y3/l694qXGPs1DXB2IU=;
 fh=nwp2bTnwiDDlym3zubbK19oED52DUA9W8gFPhWxh01U=;
 b=ehN3tiBVuvI1FIf+x79RGZbtNL58zUKz9dvP+drmx8yx+Su1wNSHb/z80fNFvHbdIf
 NaV99ww6SEjZAORFUatPTlYC2P8Z6hANWedWaDNi8KenvI1XhNeY2LKCfq+52q0wr671
 gT9zNmjxO3Gbkqa3OQk7+wM87bebXqNPKlk8nqhOGElDeeS5uWxXDolmGUblhnRvQ85Y
 IDLs+1aSc7Z+kAehjjI8RqqfATNTyYEi51CccA1Fkt9drerrJUH9Dkcn50/ldHbre7n/
 dUpSQ6MA9iKzpV3liVlajep4iC6Pql/A+Ht3iURCLS1NUnzBxJKehC7LIvkL6SuXux88
 MLhw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774549602; x=1775154402; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xWeOj0brF1shrbvQa0ImHlZ6Y3/l694qXGPs1DXB2IU=;
 b=AlC1hXERYZcPtdXUWhYLU4m50SBhwNwFBnQ0o1EfRO6m+FN7qLhQyN91Se8jkeYmnz
 gOmzxcrY5SXlgmZvIATATeS6pdPqvwhZ1V/E8wzxMt1wmxEj+V2MiwsaUflf6R1tDAxD
 HVZy5HAgW1HntDEew1GM7JbQv/wN6T0rrTdCKwpZDldcTiaJQ7T7mfHtkevWPO/RzsKh
 5/2eu+xL7N3EMzIpHm7kA0yfnJV7cE4QqmSPzecRgtc2Gsnh7g9y7b2wdtIlQsHH3y8k
 ieGIKqtqULaNrswPfT744dsi60C+vbUyJ70PuCrh9xUUX36Re4szQJgBfkoaN7TfXHA0
 7z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774549602; x=1775154402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xWeOj0brF1shrbvQa0ImHlZ6Y3/l694qXGPs1DXB2IU=;
 b=PIho9DcJZBHVxEBGPyFDmP6+PStbYhzWHWoj7JSg7VZgn6IQYpt3QV5ahiRxmusAy0
 H4VMOZDS35FvAahcBgJ9jKBnUa7c+sFqwUrXB3qXEKHG/51+lCeFDwI5E+z5Hfq/47nN
 LmfU/m8BqpzzJpBS7ufBssijP2dHgwaZgUxFZMiCMqFMNeJyjVQSHS8vIiuF0ipUkSQC
 ALzYXOc5Mu2KXEYN+ghz47FmDAROAr/cl16qu6zXSpFALrCmzFun0M2mIwDRHmsczBtd
 7lXmBnKQBArojI08n8F3/c1+xmChpXWmPAcVc/7ICFbiNZt3Lm8ifvx9CZBMje0aDdKl
 3ILA==
X-Gm-Message-State: AOJu0YyEi+9KImYYFOk2bKqSoUJ/vT/ObY+wHlrK9UbuV6rHaqoHgC1b
 mwnGMYCrs2M7K+ApT2LaLPZCnVU0JG7oxgG8msmDlRmxHM8G3pvJmLeJF5FQXWapiNcBtQnd5Wk
 UZlOLTwtJYPwTgHc0Pws+1MS/3PwKhhQPhdzJ1B38Q1wpaSH7C/KOHoxxj3/tiot8gqHAiMvPLP
 NlJ85TtVKBZksIbs8wtcUItDqambNgRfo=
X-Gm-Gg: ATEYQzzuOxzwX4io2zbHILajUc3z780Euvp8k39mGm4Bqg0ji4bTfhdgWt5SNNO2UGf
 ZgfmZ4J/Ai1efVkPdh6id0YzpBOIdv1jxfvcbJaJgDZiocR9ehL1FO4khn+MGl+m7fMU6nGtlQL
 2kFDccv6fRuh8xGn7X07Oh2f28tlV6tpPs2PuA/X3fM62zNDGhbZ9QbV/QhfoOj04boJea56P9j
 TY2oLBh
X-Received: by 2002:a05:690c:e731:b0:79a:cc64:8869 with SMTP id
 00721157ae682-79acf69bed4mr72093307b3.56.1774549601866; 
 Thu, 26 Mar 2026 11:26:41 -0700 (PDT)
X-Received: by 2002:a05:690c:e731:b0:79a:cc64:8869 with SMTP id
 00721157ae682-79acf69bed4mr72092787b3.56.1774549601199; Thu, 26 Mar 2026
 11:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-4-kkostiuk@redhat.com>
 <CAFEAcA9-j6qnKJEyk1F9Nkr0NNP9D9Oue=ptPb5py6ex=mdQnQ@mail.gmail.com>
 <CAPMcbCqzvcHU2GGKt1fjTdhY0M=6_NVD61TFoRevQ0S1ba-DNQ@mail.gmail.com>
 <CAFEAcA8VgyEuue8Hojp2wLbzyA+2H1EGJCsGTJ_yFRRt+Wo0RQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8VgyEuue8Hojp2wLbzyA+2H1EGJCsGTJ_yFRRt+Wo0RQ@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 20:26:30 +0200
X-Gm-Features: AQROBzCo-zy8xGf2mkBmrhy99g92IgCqSZ_sJPVWExtJb60JZwyuPgNMPbURRpg
Message-ID: <CAPMcbCr+hqVvfsm9t33Rkd47LjkYgH-e6A-OHpksvb+BvMiUWw@mail.gmail.com>
Subject: Re: [PATCH 3/7] osdep: Remove unused strings.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009e1099064df186b9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009e1099064df186b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:41=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 26 Mar 2026 at 16:32, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> >
> >
> >
> >
> > On Thu, Mar 26, 2026 at 6:20=E2=80=AFPM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >>
> >> On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >> >
> >> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> >> > ---
> >> >  include/qemu/osdep.h | 1 -
> >> >  1 file changed, 1 deletion(-)
> >> >
> >> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> >> > index f151578b5c..2f0e61ad6b 100644
> >> > --- a/include/qemu/osdep.h
> >> > +++ b/include/qemu/osdep.h
> >> > @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);
> >> >  #include <stdio.h>
> >> >
> >> >  #include <string.h>
> >> > -#include <strings.h>
> >> >  #include <inttypes.h>
> >> >  #include <limits.h>
> >> >  /* Put unistd.h before time.h as that triggers localtime_r/gmtime_r
> >>
> >> This needs more rationale about why we can drop the header.
> >> POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),
> >> which we don't use, but also strcasecmp() and strncasecmp()
> >> which we definitely do use.
> >
> >
> > Will be ok if I replace strcasecmp with g_ascii_strcasecmp (and other
> functions)
> > in the full QEMU tree?
> >
> > Currently, I see in QEMU we have a mix of strcasecmp/g_ascii_strcasecmp=
.
> > In some places we use glb2, in some libc.
>
> Yes, it would be OK, but we need to be a bit careful, because
> strcasecmp() and g_ascii_strcasecmp() aren't identical; the
> former honours locale and the latter is a pure ASCII comparison.
> So we need to check that that's what we want. A quick look at
> the grep results suggests that in fact we really do want an
> ASCII comparison in all these places (and the locale stuff
> in strcasecmp can be a source of bugs, as noted e.g. here:
> https://daniel.haxx.se/blog/2008/10/15/strcasecmp-in-turkish/ );
> but it does need a little bit of a check of the context where
> the functions are used. Where we're doing something like "check
> this input value matches 'off'" this is a code cleanup regardless
> of portability requirements.
>
>
Is this ok to update several strcasecmp usage in one commit,
or better to split it per component?


> thanks
> -- PMM
>
>

--0000000000009e1099064df186b9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 26,=
 2026 at 6:41=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, 26 Mar 2026 at 16:32, Kostianty=
n Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkos=
tiuk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Mar 26, 2026 at 6:20=E2=80=AFPM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk &lt;<a href=3D"ma=
ilto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wro=
te:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkost=
iuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 include/qemu/osdep.h | 1 -<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h<br>
&gt;&gt; &gt; index f151578b5c..2f0e61ad6b 100644<br>
&gt;&gt; &gt; --- a/include/qemu/osdep.h<br>
&gt;&gt; &gt; +++ b/include/qemu/osdep.h<br>
&gt;&gt; &gt; @@ -114,7 +114,6 @@ QEMU_EXTERN_C int daemon(int, int);<br>
&gt;&gt; &gt;=C2=A0 #include &lt;stdio.h&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 #include &lt;string.h&gt;<br>
&gt;&gt; &gt; -#include &lt;strings.h&gt;<br>
&gt;&gt; &gt;=C2=A0 #include &lt;inttypes.h&gt;<br>
&gt;&gt; &gt;=C2=A0 #include &lt;limits.h&gt;<br>
&gt;&gt; &gt;=C2=A0 /* Put unistd.h before time.h as that triggers localtim=
e_r/gmtime_r<br>
&gt;&gt;<br>
&gt;&gt; This needs more rationale about why we can drop the header.<br>
&gt;&gt; POSIX says it brings in ffs(), strncasecmp_l() and strcasecmp_l(),=
<br>
&gt;&gt; which we don&#39;t use, but also strcasecmp() and strncasecmp()<br=
>
&gt;&gt; which we definitely do use.<br>
&gt;<br>
&gt;<br>
&gt; Will be ok if I replace strcasecmp with g_ascii_strcasecmp (and other =
functions)<br>
&gt; in the full QEMU tree?<br>
&gt;<br>
&gt; Currently, I see in QEMU we have a mix of strcasecmp/g_ascii_strcasecm=
p.<br>
&gt; In some places we use glb2, in some libc.<br>
<br>
Yes, it would be OK, but we need to be a bit careful, because<br>
strcasecmp() and g_ascii_strcasecmp() aren&#39;t identical; the<br>
former honours locale and the latter is a pure ASCII comparison.<br>
So we need to check that that&#39;s what we want. A quick look at<br>
the grep results suggests that in fact we really do want an<br>
ASCII comparison in all these places (and the locale stuff<br>
in strcasecmp can be a source of bugs, as noted e.g. here:<br>
<a href=3D"https://daniel.haxx.se/blog/2008/10/15/strcasecmp-in-turkish/" r=
el=3D"noreferrer" target=3D"_blank">https://daniel.haxx.se/blog/2008/10/15/=
strcasecmp-in-turkish/</a> );<br>
but it does need a little bit of a check of the context where<br>
the functions are used. Where we&#39;re doing something like &quot;check<br=
>
this input value matches &#39;off&#39;&quot; this is a code cleanup regardl=
ess<br>
of portability requirements.<br>
<br></blockquote><div><br></div><div>Is this ok to update several=C2=A0strc=
asecmp usage in one commit,</div><div>or better to split it per component?=
=C2=A0=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div>

--0000000000009e1099064df186b9--


