Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E261AC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFw0q-0003vR-3f; Fri, 16 May 2025 10:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uFw0c-0003pd-HD
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uFw0T-00075p-0x
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747405546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrF4pYVcjbo6GMClZE+gP2RQ74y9eA4XrUI4Fxpw0pc=;
 b=hUPN4b5ULgzMqpphNaweY1BNkGy622BUNCMCGZC12+uGBfqYz+kyGr/xuPf37SlBjAYNG3
 /F9WW+rvRG0tGtRs3W2FiiDPrifTR1eOHwRLrnZ3YhC7WpweQ+nbzZn/RtbF2lEUwQgX0g
 kQQXbQ/Vde8k9Sus72NaA8v8M/4ri14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-1g0Oa5M7NRCUimWPU0NVig-1; Fri, 16 May 2025 10:25:44 -0400
X-MC-Unique: 1g0Oa5M7NRCUimWPU0NVig-1
X-Mimecast-MFC-AGG-ID: 1g0Oa5M7NRCUimWPU0NVig_1747405543
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a360d01518so526231f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747405543; x=1748010343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrF4pYVcjbo6GMClZE+gP2RQ74y9eA4XrUI4Fxpw0pc=;
 b=e0N7bAWcjCIILn+IkTpUj+MDB9BLTe+t08yPdgBpOasdFuCeozpMg9aBuDzBmONyTb
 jv5yEHn/GvNT6YBh8Pew36aRfS9C7RCj1cTkDD9MVbwVvX73SctzVfYLXpVusX8/jsEM
 lvAPY7hmx1VI+lLo7UBZcSnZqJAHkFflYTl11AV0w7U7gc9RSHB2jiaa53I5HO8NFPXx
 +cTNCdjgGWeCZOgfmLqIrCaddtrPzgHOBtnD9Rq+gmcbw5aMS6/lLS2dAMugmpdnkZdw
 qn1mwepeh2kUYFOn0Fe980cNWBfos8bxGk3fu11sX86fEaNnS27HvPkREZHjFVC54fc6
 O5ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU/D6N/lHCCAdxZxW5Hh9c0tHulOemiAl4h/vzXJbJIqLMGDvZ3B6noI8EuQVY8N48/p8A2CL6UBQW@nongnu.org
X-Gm-Message-State: AOJu0YwK2gwpPHBVeJi0+Bviga4HQCPYYkeQ3fqKCiJ8IqkRj/D3YMDd
 8YIvfxI13N4AC7qawR4bVfFcNyZ6G+Vbk9ACl1h/q5RhLPREMu90LTo7zzy8oGG1C1SHfqlqaU2
 eUnx95bSAr+1y2aoxUBoCxS3nwBGZH756DgnqaRpw0c0+grEDrkBdWqCnGSJCmu+rPgcRyLNP0G
 /EXH3UmAqoMZBPH9DU8LH3+LPbKe67cCU=
X-Gm-Gg: ASbGnctpLA4aWQaNRHQFCIGlGXqidAfUWnySeCnMHOPvjIMwvtPcymYUzSCmrBei7NW
 QieSlT62RDviNSmrZqmzX+kPDEO7TB10gS6vN0NJ2l8hQZW6JK3qF++PbmchnWoBtI3Gxbg==
X-Received: by 2002:a05:6000:290f:b0:3a3:4bd8:4c6 with SMTP id
 ffacd0b85a97d-3a3601dc673mr2747897f8f.59.1747405543217; 
 Fri, 16 May 2025 07:25:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGALKPLDmf4Hm0B1OzWx8x9Llsa+QX+kLP7fEGKwjW/0dVeHc76JN85Cjs9SCgChvb89eXVEk5Ebs5BaJ47xXQ=
X-Received: by 2002:a05:6000:290f:b0:3a3:4bd8:4c6 with SMTP id
 ffacd0b85a97d-3a3601dc673mr2747875f8f.59.1747405542908; Fri, 16 May 2025
 07:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-4-f7f69247d303@daynix.com>
 <e86aeab6-ef67-4f5a-9110-93309a77acf6@redhat.com>
 <a40b0b1d-b1f8-478d-bde4-cac386323691@daynix.com>
 <CABgObfa+sBbA3OURGm=6WGzs1TQKyaHjRj+QS3n9dUvSjEPkZw@mail.gmail.com>
 <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
In-Reply-To: <12b1dba8-ecb5-4167-841f-0a32256285d5@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 May 2025 10:25:30 -0400
X-Gm-Features: AX0GCFsSieLoxDMkQkT4l1oNAvuJonYvMOIkIYlBF5mYKsylS80S3Z27pS_rODI
Message-ID: <CABgObfaT6XJTkkQMfQt4bMhXGu7EvTqAv-qf+qStU9cezBwBgQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, 
 qemu-devel <qemu-devel@nongnu.org>, devel@daynix.com, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000a9fcb60635418eca"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a9fcb60635418eca
Content-Type: text/plain; charset="UTF-8"

Il ven 16 mag 2025, 08:58 Akihiko Odaki <akihiko.odaki@daynix.com> ha
scritto:

> I also found smp_mb__after_rmw() before qemu_futex_wake_all() is no
> longer necessary. Summing up, I think the code should look like as follows:
>
> #ifdef HAVE_FUTEX
>

You would still need smp_mb__before_rmw() here.

     if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
>

Removing the qatomic_read() works, but it's more expensive in the case that
the event is already set.

The barrier before qemu_futex_wake_all(ev) could be unnecessary because
there is probably one in FUTEX_WAKE. But not being able to audit Windows
makes me a bit uneasy about it.

Paolo


         /* There were waiters, wake them up.  */
>          qemu_futex_wake_all(ev);
>      }

#else
>      pthread_mutex_lock(&ev->lock);
>      qatomic_store_release(&ev->value, EV_SET);
>      pthread_cond_broadcast(&ev->cond);
>      pthread_mutex_unlock(&ev->lock);
> #endif
>
> Regards,
> Akihiko Odaki
>
>

--000000000000a9fcb60635418eca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 16 mag 2025, 08:58 Akihiko Odaki &lt;<a href=3D=
"mailto:akihiko.odaki@daynix.com" target=3D"_blank" rel=3D"noreferrer">akih=
iko.odaki@daynix.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">I also found smp_mb__after_rmw() before qemu_futex=
_wake_all() is no <br>
longer necessary. Summing up, I think the code should look like as follows:=
<br>
<br>
#ifdef HAVE_FUTEX<br></blockquote></div></div><div dir=3D"auto"><br></div><=
div dir=3D"auto">You would still need smp_mb__before_rmw() here.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (qatomic_xchg(&amp;ev-&gt;value, EV_SET) =3D=3D EV_B=
USY) {<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Removing the qatomic_read() works, but it&#39;s more expensive in the=
 case that the event is already set.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">The barrier before qemu_futex_wake_all(ev) could be unnecessar=
y because there is probably one in FUTEX_WAKE. But not being able to audit =
Windows makes me a bit uneasy about it.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* There were waiters, wake them up.=C2=
=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_futex_wake_all(ev);<br>
=C2=A0 =C2=A0 =C2=A0}</blockquote></div></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
#else<br>
=C2=A0 =C2=A0 =C2=A0pthread_mutex_lock(&amp;ev-&gt;lock);<br>
=C2=A0 =C2=A0 =C2=A0qatomic_store_release(&amp;ev-&gt;value, EV_SET);<br>
=C2=A0 =C2=A0 =C2=A0pthread_cond_broadcast(&amp;ev-&gt;cond);<br>
=C2=A0 =C2=A0 =C2=A0pthread_mutex_unlock(&amp;ev-&gt;lock);<br>
#endif<br>
<br>
Regards,<br>
Akihiko Odaki<br>
<br>
</blockquote></div></div></div>

--000000000000a9fcb60635418eca--


