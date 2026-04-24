Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9290CFB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8TF-0000RU-VJ; Fri, 24 Apr 2026 00:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wG8TB-0000R8-6m
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prtyagi@redhat.com>)
 id 1wG8T9-0000OX-7K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777006124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UaW8VfN7qeKGcyj5LjkfQGFN0MBHwTh30QwNNITkG84=;
 b=PAEDG9rftIHa9W77ffeF14tvfyNdxkoJUIRTTJejIr0Xg8nUXUkcgiVSMflK3zYOs0g07y
 7AqZK502eZ8o8xUGoylt3HeGaa4OgcDXI7E+KQVr6dmbYGwT8jto+doQA8NNdl1lN6GLXs
 1K9q5TU8CS6d0W9+mEO3hIhV7+cz/iE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ChNYXtzsNEa3npkneJM6Lw-1; Fri, 24 Apr 2026 00:48:42 -0400
X-MC-Unique: ChNYXtzsNEa3npkneJM6Lw-1
X-Mimecast-MFC-AGG-ID: ChNYXtzsNEa3npkneJM6Lw_1777006121
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ba661b6c550so631438966b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777006121; cv=none;
 d=google.com; s=arc-20240605;
 b=dgpYmaKjEc9+MnTClG6VI9nWPHR8SShwBF78uejRXLx+y8KLxNr7AqEJPTTb/cxcoT
 0V/K20BU245JsqZhSIpz/UDRE5MdJR02t20FitTzDySpJBlrKpXBI+fO0qGQ4mZuJ0lu
 MvCkO4stHvll9oP9PuvKCKVX2SxGAeXFgw3JWDkd8k5nhp3CiC81j79AsIKMN6fUfIpC
 ZPhLM2n+acH1I/jP8NuKbbFYfMD+Od2DQ4JSqhy5GrkV0P4ERU4WHOe8AGlc45PUOOQl
 LKvdnxAYP/LPM+MJEoNJ5eobZ77Y1SJ3TfHiFbVR88jRUubMNYfXSoBnkLBDwhZQ0ucY
 WZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UaW8VfN7qeKGcyj5LjkfQGFN0MBHwTh30QwNNITkG84=;
 fh=tqeddvYnnfVFRES8/MufanmBVJwlsV6HFTbK+mWQ8lQ=;
 b=By+iN/JfYA2rsIABV4k85I8HiODV/reI/tO7XRxfe+4fexWBJECdsj4c8Uv+CSiGPz
 2U98OH2og+KtliHyZJZZwnVPsLN0VZNEabZSCi4FtjGMEqq8OYA4FXYv6EGIYt9pBNqf
 w/qt1Md8vXcvhipzwLmDKc6eWIAvkEAY+4LjMvHtqcejQvSFqfsddkuH8JaJ5W0Vbxru
 hML3zli6XIYI7GOh/IJgL4Tuw1h/pU2KfWKLwgnabt1cpl+Rc9Mk5eV49HgELPvDSnSz
 RW6f8RmnNUwmFBAreKpF3glp2WrXhtoUnnlyZpQqzb4zjx6wGUT1xG3bMWIPHxwwuRe6
 WVOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777006121; x=1777610921; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UaW8VfN7qeKGcyj5LjkfQGFN0MBHwTh30QwNNITkG84=;
 b=abqCJSDXG8ZlQDXFGJvxiGe3cZBuBvqFa29Is4LNruqhktkGpSgPPDl+xJb6x468uM
 Kh4ZE3CRXRVqhPVBClxQLUIU+HKnjSEWjmTaI5CvO4f+LPCpdKeO994BmNxBFeDoOThi
 lHNaUNVpb8/q0DR6E60Tr2qHTaXAOrmlEd+pVoL6EMsEndmeAumaXql5zahh8mfxALXJ
 F3Su1hOFC6rQ89BYyfrAiaKqAzWBQesx9zyP+gxWCBffrdL9sJtl0mEPh8erjTIo2Lr+
 JjSu+EhtveAYChHtF90HMAQBwVexwc+yswxpJ3hrUK+2gwdeLBZ4+AfHA4R9T4Ceu3bs
 SX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777006121; x=1777610921;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaW8VfN7qeKGcyj5LjkfQGFN0MBHwTh30QwNNITkG84=;
 b=DBiDSqEFx+IKSVxU82L4fQNz/Ik0BNZnALikTFycfahxWfPj7pkJEE33jnQQvdIONm
 OFi3xJr+I9Bhm6jLaye37ZpTp2+fXbdsQ7gP7SqzvW6U7rqmHoBXypNYQDs9vh7myjTC
 /4vZ+DpmS++bGtjMAAZuP+yWCUWyulEV5x99kARvFDD7D2bu7bnjFND8WIW3fGbcdjH6
 zsoI+I+v9rWVaFwQslHTHe/Zwb5VzHz2vVuFw91HbFjBQeLM6I6UR27KwuRzWXZ0e9fc
 bExd4/IDFfsoVUmXwiCqG/q6yLgcFFfFlppKiE3yEWfnsYbZ4RFvLeJHGuabzDVdhG9j
 ufsA==
X-Gm-Message-State: AOJu0YyGKqFU7eXal3gB3oT8kWwNL0LVrco3JXXvwDZATqgcJkhJA2dw
 4qCehTRX1bKzrRCkmOWDcBiQ9Y85r+RLVER/UwlA+6Jof9HjTsYIdqfQ7QUmv4rquJPDAFp0pl+
 e9p34dRSlAmv5i7eK7Cj6ozBKcx3iPpOS1wuhRgEQw/QelEL02C4XVATBUStRvku/Vf67F0ky3b
 3/wqYt7pBRShsjhIiytqEwE4fVvp+cG7w=
X-Gm-Gg: AeBDievpeNDR1Xyd+39vDnLbyVQBEejrKsdUeG7uAsq3w/FboD1LTBmOAATNuuCWOPD
 F+/pgi1tPqBDCC80U2RJTPG5nocIAZv4DqTJfMS/tOONmhbcgg/1ilpuL65r2aaCC8IS2QWVpJj
 NQSQ1uTb/MHxJ/Q8Bvlvd7XrJf7w1joyMjzh0qLYylmBXq2bwJZYBFJbUuCpjJlN2se4JYdeUkE
 qBxziO+1vvsGKb/1wk=
X-Received: by 2002:a17:907:940a:b0:bab:af3:1008 with SMTP id
 a640c23a62f3a-bab0af31068mr532233066b.8.1777006121279; 
 Thu, 23 Apr 2026 21:48:41 -0700 (PDT)
X-Received: by 2002:a17:907:940a:b0:bab:af3:1008 with SMTP id
 a640c23a62f3a-bab0af31068mr532231766b.8.1777006120674; Thu, 23 Apr 2026
 21:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260423094438.43556-1-prtyagi@redhat.com>
 <aepvNu6ko5KfFY3a@x1.local>
In-Reply-To: <aepvNu6ko5KfFY3a@x1.local>
From: Pranav Tyagi <prtyagi@redhat.com>
Date: Fri, 24 Apr 2026 10:18:29 +0530
X-Gm-Features: AQROBzAEB_Hz1efkhcLLmgAEf1e_kifmz3BS_7CVG87so6_tZeNo61wmpgeHlgs
Message-ID: <CALY4kkTxHo8Bju1zWoHiiwUF0YcXuHHtwZo4GOcaTafGJ7Jdkg@mail.gmail.com>
Subject: Re: [PATCH v2] migration: Fix blocking in POSTCOPY_DEVICE during
 package load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000963df406502d7a61"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=prtyagi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000963df406502d7a61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:43=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:

> On Thu, Apr 23, 2026 at 03:14:38PM +0530, Pranav Tyagi wrote:
> > The package_loaded event is not set in case MIG_RP_MSG_PONG does not
> > arrive on the source from the destination in the return path thread. Th=
e
> > migration thread would then be blocked waiting for package_loaded event
> > indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition th=
e
> > source VM can safely resume as the destination has not yet started. The
> > pong message can get lost in case of a network failure or destination
> > crash before sending the pong.
> >
> > This patch removes the package_loaded event and uses rp_sem, instead of
> > kicking multiple events. The error is detected in case of network
> > failure or destination crash and rp_sem is set in the out path of the
> > return path thread. This will kick the migration thread out from a
> > condition of indefinitely waiting for rp_sem. The migration thread then
> > fails early and breaks from the migration loop to resume the vm on the
> > source side.
> >
> > Fixes: 7b842fe354c6 ("migration: Introduce POSTCOPY_DEVICE state")
> > Signed-off-by: Pranav Tyagi <prtyagi@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> I assume Juraj has looked at this already internally, in that case you ca=
n
> always attach his R-b directly when post / repost.
>
> If not, then it becomes a sincere request.. :-D
>
> Thanks!
>
> --
> Peter Xu
>
> Hello Peter, thanks for the review. Juraj had already reviewed the patch.
In such a case, I'll remember to attach the R-b tag directly from next time=
.

Regards
Pranav Tyagi

--000000000000963df406502d7a61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 24,=
 2026 at 12:43=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com"=
>peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On Thu, Apr 23, 2026 at 03:14:38PM +0530, Pranav Tyagi wr=
ote:<br>
&gt; The package_loaded event is not set in case MIG_RP_MSG_PONG does not<b=
r>
&gt; arrive on the source from the destination in the return path thread. T=
he<br>
&gt; migration thread would then be blocked waiting for package_loaded even=
t<br>
&gt; indefinitely in POSTCOPY_DEVICE state. Where as, in such a condition t=
he<br>
&gt; source VM can safely resume as the destination has not yet started. Th=
e<br>
&gt; pong message can get lost in case of a network failure or destination<=
br>
&gt; crash before sending the pong.<br>
&gt; <br>
&gt; This patch removes the package_loaded event and uses rp_sem, instead o=
f<br>
&gt; kicking multiple events. The error is detected in case of network<br>
&gt; failure or destination crash and rp_sem is set in the out path of the<=
br>
&gt; return path thread. This will kick the migration thread out from a<br>
&gt; condition of indefinitely waiting for rp_sem. The migration thread the=
n<br>
&gt; fails early and breaks from the migration loop to resume the vm on the=
<br>
&gt; source side.<br>
&gt; <br>
&gt; Fixes: 7b842fe354c6 (&quot;migration: Introduce POSTCOPY_DEVICE state&=
quot;)<br>
&gt; Signed-off-by: Pranav Tyagi &lt;<a href=3D"mailto:prtyagi@redhat.com" =
target=3D"_blank">prtyagi@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"_b=
lank">peterx@redhat.com</a>&gt;<br>
<br>
I assume Juraj has looked at this already internally, in that case you can<=
br>
always attach his R-b directly when post / repost.<br>
<br>
If not, then it becomes a sincere request.. :-D<br>
<br>
Thanks!<br>
<br>
-- <br>
Peter Xu<br>
<br></blockquote><div>Hello Peter, thanks for the review. Juraj had already=
 reviewed the patch.<br></div><div>In such a case, I&#39;ll remember to att=
ach the R-b tag directly from next time.<br><br></div><div>Regards<br></div=
><div>Pranav Tyagi</div></div></div>

--000000000000963df406502d7a61--


