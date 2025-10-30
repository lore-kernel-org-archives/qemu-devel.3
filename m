Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349AFCCF9F6
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 05:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vELWa-0002V0-CV; Thu, 30 Oct 2025 01:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1vELWX-0002QJ-UB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 01:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nanliu@redhat.com>) id 1vELWP-0000NT-8U
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 01:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761803307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKDXzeGoT92LMljzjA5alHgmCQRBI+W+byfC8plt9yI=;
 b=JDbBhx3H/FwxVv3HeOA11xai95SITzLsW33mS1mpOoKh6QlCrAJxKT3jrj+bVjsHcWGDYT
 T1LbQRftkGRl6RsmBUs+lLKhQRAuI5KFyF6aQUQCIL+wusNxpNQ3DJpgRcwIl0KOR+vfjJ
 jJlAgAlwXv/3qxoYwiUItdyq3nVC02o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-YxymPgJHM4eQ3kG_12S26g-1; Thu, 30 Oct 2025 01:47:06 -0400
X-MC-Unique: YxymPgJHM4eQ3kG_12S26g-1
X-Mimecast-MFC-AGG-ID: YxymPgJHM4eQ3kG_12S26g_1761803225
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-63c0edb0593so676834a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 22:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761803224; x=1762408024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zKDXzeGoT92LMljzjA5alHgmCQRBI+W+byfC8plt9yI=;
 b=AMWIru2JT7oWM0MVQU1/5KNuVNSAe5y8el6cmk9SvssMhWobuBLLsom23GsYUw+Gur
 8+GGEbyGI2p1c/fHFJVnD5G28FCdDDu181YIicpU+rt4kmazfVukOSXy3ZlEsPJ6a5wb
 v9OoGf2RUHhp22GRmlofulYNmF8uUkQLSfjTWxYGa4DRKPtQZ70u0QyVo5bSRdzCdvii
 7iLNIfYrLayqI1Ljh21R1Lxzp+ptWOFTl9J3Hn1BbcQybJzLHjSRllTxPhCkTnNHU47g
 +DLRhMbR2rc2A+rTFRVPEyppXI+wbt/LtRkJ/xkTatpJbp/cSH4j/zZklIIAOAQc3aIg
 1LQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOXsISUY/eHYANYjBAWs3QLe1sIq8wQrP+XsVXT0oHYvh+oJ9YxSl3m+VlHSpbSnbDn32E5Gryhf/l@nongnu.org
X-Gm-Message-State: AOJu0Yz6oS8s0EkEmaQELx1u64N0MU9HI9RE22MT1gB5mCLLzmwHHZ84
 gra57QG85oMdtwjLe/iLsPwIqayRY8CJ6JSNHByl1KOlOMagnpeaRvsTiA3KqOJxxg2aHLlQtOC
 HUDVF6zFG7I7A2vA6VywuIxGBF82Y+yjsNhvIBmp0kfvdUhBNOy6wNeIAUfj3mewiMbC7FZdq8f
 BvwV+H4EPhlJDzJvCFAHHNzlmdfFaSBQqiDoPZu7xaE09s7eQ=
X-Gm-Gg: ASbGncsw6kdwwwuoydyInAHqz9wjTAdE8KxBXSjMEJNnv0eB46NHxIctVBK+oXv9UwN
 Hp7nFVo1WxLemF5BUBZ/tvZYyA+z6D/MAqhxqjD/LIHh2jfnjNrgCN6KW7D0+qD3/JEcfTJvb+2
 QQS0YLKgXcTN8xfLy+WF9EVTSCnedQ8tHM9bncPeGP4tOI0LsWyguNm4QT
X-Received: by 2002:a05:6402:3553:b0:633:d0b7:d6d2 with SMTP id
 4fb4d7f45d1cf-64061a3f66cmr1571637a12.18.1761803224225; 
 Wed, 29 Oct 2025 22:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv1p+gOEEmlhrPO8SsbzlyARRTmp7Hn7fRGHKuEIr0We62RhhnOazO3T6eYWOP9K6TIwjDSY9U8jkDvo3Vris=
X-Received: by 2002:a05:6402:3553:b0:633:d0b7:d6d2 with SMTP id
 4fb4d7f45d1cf-64061a3f66cmr1571626a12.18.1761803223816; Wed, 29 Oct 2025
 22:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250922065714.93081-1-nanliu@redhat.com>
 <CAFEAcA8pLFu6eOK5N+E97qo5PCp3OW3BRfYNSEL7=YQS6+eh2g@mail.gmail.com>
 <fcf01a1c-3503-4397-a41b-d453ca2b7df9@tls.msk.ru>
 <CAFEAcA_BR4VEsZrq1eq19E6iguk49W=Fx2OKQvkvTZ7_6Pd0KA@mail.gmail.com>
In-Reply-To: <CAFEAcA_BR4VEsZrq1eq19E6iguk49W=Fx2OKQvkvTZ7_6Pd0KA@mail.gmail.com>
From: NaNa Liu <nanliu@redhat.com>
Date: Thu, 30 Oct 2025 13:46:52 +0800
X-Gm-Features: AWmQ_bmMsu5UWgtKZu-L-DwXOOZmZTOPccIj-DRmRArJnWINPBcLK69IAOEkaPs
Message-ID: <CANUVZAznv1aP5DH6pHEQBZGxczkoNVQfKR5oOV7eTyrk4rVrpQ@mail.gmail.com>
Subject: Re: [PATCH] docs/devel: Correct uefi-vars-x64 device name
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, kraxel@redhat.com,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000051eab7064259c7cd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=nanliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000051eab7064259c7cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 7:41=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Sat, 27 Sept 2025 at 09:48, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > On 23.09.2025 14:57, Peter Maydell wrote:
> >
> > > We could probably also correct the bit of the text in this file
> > > that currently reads "depend on SMM emulation on x64" to either
> > > say "x86" or "x86_64".
> >
> > This one will be a bit more than trivial :)  I for one don't know
> > if this is related to any x86 or to x86_64 only.
>
> I just mean exactly and specifically the one place in this
> file which says "x64" and ought to say either "x86" or
> "x86_64". To me a single word change is pretty trivial,
> especially since nowhere else in our docs do we use "x64".
>
> This is to ensure consistency between the documentation and the API code
(var-service-api.h) parameters and json file, which use "uefi-vars-x64".


Thanks.
Nana



> -- PMM
>
>

--00000000000051eab7064259c7cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 27,=
 2025 at 7:41=E2=80=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Sat, 27 Sept 2025 at 09:48, Michael =
Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=3D"_blank">mjt@tls.msk=
.ru</a>&gt; wrote:<br>
&gt;<br>
&gt; On 23.09.2025 14:57, Peter Maydell wrote:<br>
&gt;<br>
&gt; &gt; We could probably also correct the bit of the text in this file<b=
r>
&gt; &gt; that currently reads &quot;depend on SMM emulation on x64&quot; t=
o either<br>
&gt; &gt; say &quot;x86&quot; or &quot;x86_64&quot;.<br>
&gt;<br>
&gt; This one will be a bit more than trivial :)=C2=A0 I for one don&#39;t =
know<br>
&gt; if this is related to any x86 or to x86_64 only.<br>
<br>
I just mean exactly and specifically the one place in this<br>
file which says &quot;x64&quot; and ought to say either &quot;x86&quot; or<=
br>
&quot;x86_64&quot;. To me a single word change is pretty trivial,<br>
especially since nowhere else in our docs do we use &quot;x64&quot;.<br>
<br></blockquote><div>This is to ensure consistency between the documentati=
on and the API code (var-service-api.h) parameters and json file, which use=
=C2=A0&quot;uefi-vars-x64&quot;.<br></div><div><br></div><div><br></div><di=
v>Thanks.</div><div>Nana</div><div><br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
-- PMM<br>
<br>
</blockquote></div></div>

--00000000000051eab7064259c7cd--


