Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422CC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMwGB-0003iu-Ly; Wed, 04 Jun 2025 18:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMwG9-0003iV-No
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 18:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uMwG7-0000cU-QW
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 18:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749074813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rfy7XYRTPYXFfIFssByvydiB/s5a7ZtyoD88g0tQAJo=;
 b=QEjIAUEIbVtb5fL+CJjheRnS8z+Bz2nDWvWUzWzBRsF3bnG7qVmQ9Sx1jAfOGb7j6QPdrb
 u5LUqzeOxuUkXkT/Tua3hGIOAwNvuco1GEKkV7ZnqHWFi+Xntk4MMgInAy0p4ai9unyL5Q
 O4HwuxsnYNSybILPJmq7YYd9Lrket8Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-4nMLMwV2P76OfFAjy3Cb0w-1; Wed, 04 Jun 2025 18:06:51 -0400
X-MC-Unique: 4nMLMwV2P76OfFAjy3Cb0w-1
X-Mimecast-MFC-AGG-ID: 4nMLMwV2P76OfFAjy3Cb0w_1749074810
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b26eec6da92so1148075a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749074810; x=1749679610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rfy7XYRTPYXFfIFssByvydiB/s5a7ZtyoD88g0tQAJo=;
 b=v/D5K9EVoV2Sr0OV+s5WhVP16+N7dMVskg8YEzU6Cr1xTUMQrGGFVRxm5FC+4BdT+X
 fzJT7Vcgzh/h0SMEDDjRrCvCUn1uwciD76lOiH/k16AIoZDQC+nuzCstRTKbw93EFWRB
 ka6f+3wA4l90pNAgP5DFL5A/wGmr+4H9BxqhLISSb6gKBNruu7MynuqyNces6qmceQ2I
 UxPsTlx32nHd7fYSts2qyzi4GhL9bNoJBWEvZR6krF2ssUOsYkmRIXynSZY3lthpHtss
 z6SGPutKrVzVYKbY96tk0D8lFHJK6WGswUjqZcEt0Caf3AJcG5NRnx7YfCNFdAn8ny+B
 c38w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6bH8XsvaJ5Fc6TBoRd8/LVeUGIitakX6Zwuk59Be8PCkQlV8+R7hALj4k61kpID4U8FgCbRDcY02O@nongnu.org
X-Gm-Message-State: AOJu0YwxUKPN6jw3VjiZ71KCdu2jLlUkM1nJdiBgm45xc3AK8a33tFLT
 GhgkiefdTUUI37ixscxkfjSPs0tiJ/0fEj5ehiYMPLq7NW/mQ0ratyzAz4zqkRQp39c/APR2fMM
 j3Cc2ehj0RFGin1QlaUaMcLiapVwmf0n7nMAGk6agrUyuyQvJDTs6ZtB8koP+KDXaiOhZ18mDv4
 f5Mh84mYsVgC4TtF9AOd1bQNNSwy9PmPo=
X-Gm-Gg: ASbGncvi+kHdLNGyr9ZjFRGxs38B5sQZPnZYi6Qv20NFmNIVm2VEjsIXuwD8K3QJ8iI
 I9brjAOXOgdIeu+qfKvKsQ/VX87liVSplM1uwfSOeEaF2Eeyc9Ib3PDP4oMixUisZd+0GYoCEnE
 dxTNv53elKlvSy3oTvryMsNW4xE93RA5cC8zI=
X-Received: by 2002:a17:90b:3912:b0:312:e751:8213 with SMTP id
 98e67ed59e1d1-31328fb549dmr1480717a91.13.1749074810395; 
 Wed, 04 Jun 2025 15:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAcAOxRJHQ0hYOFVmnGWTlxdP6r0vTQGtpbDLP6IOLf9U7xd0FpooddDY5sCUIYkAkkLDbiE4+h6K1RCkTvJo=
X-Received: by 2002:a17:90b:3912:b0:312:e751:8213 with SMTP id
 98e67ed59e1d1-31328fb549dmr1480692a91.13.1749074809990; Wed, 04 Jun 2025
 15:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
 <CAFn=p-aL6OQKqq4nLp+LV2QxpRSo8yp3c0veT+DMG-Tt7aSYxg@mail.gmail.com>
In-Reply-To: <CAFn=p-aL6OQKqq4nLp+LV2QxpRSo8yp3c0veT+DMG-Tt7aSYxg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 4 Jun 2025 18:06:37 -0400
X-Gm-Features: AX0GCFs_MnMybUXspNZ3wck73YK-_jHaIZ-sToYXvXWljSdD5kPapk6_Jw8hJqo
Message-ID: <CAFn=p-ZQ+NDFGJG=eqGF75CpBtdcwSH0j8wKjoBGtFqH8C4hag@mail.gmail.com>
Subject: Re: [PATCH 0/3] docs: Bump sphinx to 6.2.1
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 devel@daynix.com
Content-Type: multipart/alternative; boundary="000000000000bc56470636c63615"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

--000000000000bc56470636c63615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 1:47=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

>
>
> On Sat, May 10, 2025 at 2:17=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayn=
ix.com>
> wrote:
>
>> Supersedes: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
>> ("[PATCH 0/2] docs: Bump sphinx to 8.2.3")
>>
>> sphinx 5.3.0 fails with Python 3.13.1:
>>
>> ../docs/meson.build:37: WARNING:
>> /home/me/qemu/build/pyvenv/bin/sphinx-build:
>> Extension error:
>> Could not import extension sphinx.builders.epub3 (exception: No module
>> named 'imghdr')
>>
>> ../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3
>> version of python-sphinx and the readthedoc theme
>>
>> Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new
>> sphinx version.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>
> Reviewed-by: John Snow <jsnow@redhat.com>
>
> I figure if this causes issues, this early in the development cycle we ca=
n
> roll it back or pursue alternate solutions if necessary. I figure because
> this touches so much stuff I wrote, it probably ought to go through my
> tree, so I'll stage this tentatively.
>
> (Paolo, Peter: But if you want to stage it instead, be my guest.)
>
> ---
>> Akihiko Odaki (3):
>>       docs: Bump sphinx to 6.2.1
>>       docs: Require sphinx>=3D6.2
>>       MAINTAINERS: Add docs/requirements.txt
>>
>>  MAINTAINERS                |   1 +
>>  docs/requirements.txt      |   4 +-
>>  docs/sphinx/compat.py      | 230
>> ---------------------------------------------
>>
>
> Oh, thank you so much O:-) how beautiful...
>
>
>>  docs/sphinx/qapi_domain.py |  33 +++----
>>  pythondeps.toml            |   4 +-
>>  5 files changed, 20 insertions(+), 252 deletions(-)
>> ---
>> base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e
>> change-id: 20250508-sphinx72-400c521af710
>>
>> Best regards,
>> --
>> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
Just a note to say that I started staging and testing this and found a few
problems -- many are minor and I have patched them up accordingly, but I am
currently having an issue with debian claiming it can't find the
sphinxcontrib-jquery extension:

https://gitlab.com/jsnow/qemu/-/jobs/10257469021

It might be the case that we need to install the dependencies too, but that
might pose problems for offline source distributions. I haven't fixed this
yet, but I will continue looking into it.

Thanks,
--js

--000000000000bc56470636c63615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 19,=
 2025 at 1:47=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">=
jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 10, 2025=
 at 2:17=E2=80=AFAM Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@dayni=
x.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Supersedes: &lt;<a href=3D=
"mailto:20250505-sphinx82-v1-0-85f2418b33b1@daynix.com" target=3D"_blank">2=
0250505-sphinx82-v1-0-85f2418b33b1@daynix.com</a>&gt;<br>
(&quot;[PATCH 0/2] docs: Bump sphinx to 8.2.3&quot;)<br>
<br>
sphinx 5.3.0 fails with Python 3.13.1:<br>
<br>
../docs/meson.build:37: WARNING: /home/me/qemu/build/pyvenv/bin/sphinx-buil=
d:<br>
Extension error:<br>
Could not import extension sphinx.builders.epub3 (exception: No module name=
d &#39;imghdr&#39;)<br>
<br>
../docs/meson.build:39:6: ERROR: Problem encountered: Install a Python 3 ve=
rsion of python-sphinx and the readthedoc theme<br>
<br>
Bump sphinx to 6.2.1 and also sphinx_rtd_theme as required for the new<br>
sphinx version.<br>
<br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
" target=3D"_blank">jsnow@redhat.com</a>&gt;</div><div><br></div><div>I fig=
ure if this causes issues, this early in the development cycle we can roll =
it back or pursue alternate solutions if necessary. I figure because this t=
ouches so much stuff I wrote, it probably ought to go through my tree, so I=
&#39;ll stage this tentatively.</div><div><br></div><div>(Paolo, Peter: But=
 if you want to stage it instead, be my guest.)</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
Akihiko Odaki (3):<br>
=C2=A0 =C2=A0 =C2=A0 docs: Bump sphinx to 6.2.1<br>
=C2=A0 =C2=A0 =C2=A0 docs: Require sphinx&gt;=3D6.2<br>
=C2=A0 =C2=A0 =C2=A0 MAINTAINERS: Add docs/requirements.txt<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A01 +<br>
=C2=A0docs/requirements.txt=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A0docs/sphinx/compat.py=C2=A0 =C2=A0 =C2=A0 | 230 ---------------------=
------------------------<br></blockquote><div><br></div><div>Oh, thank you =
so much O:-) how beautiful...</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
=C2=A0docs/sphinx/qapi_domain.py |=C2=A0 33 +++----<br>
=C2=A0pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A04 +-<br>
=C2=A05 files changed, 20 insertions(+), 252 deletions(-)<br>
---<br>
base-commit: 1da8f3a3c53b604edfe0d55e475102640490549e<br>
change-id: 20250508-sphinx72-400c521af710<br>
<br>
Best regards,<br>
-- <br>
Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_bl=
ank">akihiko.odaki@daynix.com</a>&gt;</blockquote></div></div></blockquote>=
<div><br></div><div>Just a note to say that I started staging and testing t=
his and found a few problems -- many are minor and I have patched them up a=
ccordingly, but I am currently having an issue with debian claiming it can&=
#39;t find the sphinxcontrib-jquery extension:</div><div><br></div><div><a =
href=3D"https://gitlab.com/jsnow/qemu/-/jobs/10257469021">https://gitlab.co=
m/jsnow/qemu/-/jobs/10257469021</a></div><div><br></div><div>It might be th=
e case that we need to install the dependencies too, but that might pose pr=
oblems for offline source distributions. I haven&#39;t fixed this yet, but =
I will continue looking into it.</div><div><br></div><div>Thanks,</div><div=
>--js <br></div></div></div>

--000000000000bc56470636c63615--


