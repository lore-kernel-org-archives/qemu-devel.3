Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE76DEEC2AD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufKJ-0003C5-O5; Mon, 23 Feb 2026 18:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vufKH-0003Bs-NF
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:26:53 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vufKF-00022c-B8
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:26:53 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2aaf9191da3so31413705ad.2
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 15:26:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771889209; cv=none;
 d=google.com; s=arc-20240605;
 b=fm12hMJbWq3rhNZz6KSnS0q0pc0NHGVFsxb2Nmn2RjxXMu+ZRgwi0aVkhVs6ir4bjf
 V+Qb+VrCyG6+t7No7Iw08OwS7OWAw/vy/GCaNSEKnLYMxL2KX70n4r703kCLlZIvVdBV
 qAR8JmZU/lzkriIEW7z5Cs34t4auwhL3gIGYK2p+8WIDov0J0itEp9qwu7ta2l+VLImi
 QPSFrIB+vcJC45/Uid50Zyo+kSA2UcwImm+9jcxECQW7IzSNHTbjaCRy6+lkdK/8CyKs
 moecDz9XbZ4xH4To4uF0vZcNDaTqvOoWk3HTwDXrJ+qGvJnQu+ZO1THCpOFmyDY9rAT9
 vhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LQdYxKCgXz/2gGsZ8l7b1XKrjitjE+FuQECL3RRmvlM=;
 fh=FafIafKr2nleapE4n9ARu5eMejrusEAvm3TmrfWUFiM=;
 b=iHZg9riQiTbQFkmGMQCzQq4/idCkeUkZa9mTnrbpe8GP2F2wHeABJ9xJ7/43oegfiq
 ZMexnyLktqtflu6jsIeVxWCwOjWtG8/chYKsHUGNIrfYpCAQJDf8onu3qpF+TqmsmB1e
 /3eTFd0tRGf9J9e5pBDgk0+BpheS/q8lp16v9kHhrDltAniQbEifUDZngzB1qYFE2XL9
 eRMyFllZS7WWgE/Z/MfWGDoaeDFD+hhi5rPCiXPrQqj01zpcL7xKHzH25mea0jgQfHVF
 4sKOrJ3mR7WkrxVK6cboGrnP76Bin2MTaZvTFzucXZoZaSBheCD1sSsHznsb+AnYB6vd
 06Cg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1771889209; x=1772494009;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LQdYxKCgXz/2gGsZ8l7b1XKrjitjE+FuQECL3RRmvlM=;
 b=ffgdBSuJhQLDjJkV/NYIbsaONm9WtKoY9GFeRNrNB1spQobk0HDsp1jgKIu2GGSohg
 9zSFT8kbeNBOp+rd4AVLZR1jBLIJkzH3BLIFJbvNIp21cBKxLREgXqi8uWz9fd0simDd
 kSSYParD/o5tPAwCe+3I9tnBNZnzZYA4VFTaeM6MCtp9YGojgfDe8XxlGjeWrRXNR0Qb
 mbuLNRJeeZcyS2qXFksAvvXsPLrJp0YFJUFUpkK2FEhX+YvN/TkEXggXL/7ocBVLejuS
 +PULVpeoOqP+FGvshXh1QrG+WXfx3axF634uCXAmbfNlneXaNEIpOTb/rGB9jfnHBB1I
 2aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771889209; x=1772494009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQdYxKCgXz/2gGsZ8l7b1XKrjitjE+FuQECL3RRmvlM=;
 b=bcVuD2fNNkzXWLivNMVfNVTOKkisnTwpSZ5wZ93xN1hSFXi0S/+wTfwZlaD9wA48Ap
 q09GAIuGVaaR+G28Z+YmbJ2IfjJhtgyvUyuEB67xeJsfGGE2W+S2VG/x80yd6Kd1ZZNM
 vaAhJ6iVkM88+AM7PLw8rGYVrjqA6bUORThb50RjASl+tN7dJd7HzSTRAP+4JDNj5Y/k
 EL8fZ1UjnUdJZ8O9DWB5gGYrTW7y4Bu1FS90ltp4cxeYekHA2RDAetP1SSDmjOzfYdDK
 azcG58sMincFgZ2Nhrc8EyPVHgwpjEiv3u011lmr6WjwsxD/pVoMKAleY3/nhiFps+pM
 UWbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvoqV8XNxTiZISyvSm7rxfNH8AQzZ8B5q5HifBaZCxnFY92/IzQYe1TqbLwhUqAVZv/Sol30uszybA@nongnu.org
X-Gm-Message-State: AOJu0Yw6tBsnyJGwIADPC2rA7gIYaDtw0rRymMauWO08un8xxrGnu8Fj
 ac63zYufBw8u4c6bcWfaCVlODnxxJ79yRDME1izDBWZ5Cxulmuz0vSyqWV2w2wctwNe44m7wyWS
 XaFb5UAa/bS8dEuXTw2seELQ0HATQmM57k+SrP32fSw==
X-Gm-Gg: ATEYQzxNMG8f4abCq3YL/h0ehFCoySXjM2SSnsw01ACf5gNXOhxzC6k3P9dl63kvWjb
 q8mCQhqmFiOgO/prePJnbxWmMnf6T7fTafyFpagN26JJ1F7fq5kwEtrE/GNguJtgn5Qh6ANX1Ki
 Jer2T9GjFpZlI4NSW4ouF0JVgFW9AZ/6r6hs7QQdnPBJoJ12hLNlIzLqFxJnFOvqC+mpAYXU9bm
 TiG2YR73sVIOjJ9lNQZTLsYi5Ah6v3m3lZfU9qLIxMzrCelhQOMKbH5xgUmaHph+kRuzRvvgI+j
 A7MoyZ0=
X-Received: by 2002:a17:902:c952:b0:2a9:838e:8d7f with SMTP id
 d9443c01a7336-2ad74524453mr98667785ad.41.1771889209152; Mon, 23 Feb 2026
 15:26:49 -0800 (PST)
MIME-Version: 1.0
References: <CAFMJydMjLq+O+wuez_eSPYAqMgH9DPBXAW-o9zMZCSQVb_3e0w@mail.gmail.com>
 <CAJSP0QV7V-r_tm7e204PgCWFFy4Vzw4w0Em7f6h22QLt4jtivg@mail.gmail.com>
In-Reply-To: <CAJSP0QV7V-r_tm7e204PgCWFFy4Vzw4w0Em7f6h22QLt4jtivg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 23 Feb 2026 16:26:38 -0700
X-Gm-Features: AaiRm51hb3YacWL4qb5p9U32IlT4oYRIRADibukoOHitsbkvnTNOOaX_LgTB168
Message-ID: <CANCZdfoJD=j_NU52mk3yPpea6QmdQEokQ3COiY3SRY4Yj5jykA@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Arun Krishna K <arunkrishnak2407@gmail.com>,
 Alex Bennee <alex.bennee@linaro.org>, danpb@redhat.com, 
 Helge Deller <deller@gmx.de>, German Maglione <gmaglione@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, 
 kvm <kvm@vger.kernel.org>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e4a13a064b861a89"
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000e4a13a064b861a89
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 12:18=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:

>
>
> On Tue, Feb 24, 2026, 00:18 Arun Krishna K <arunkrishnak2407@gmail.com>
> wrote:
>
>> I am reaching out to you regarding a potential GSoC project, as suggeste=
d
>> by Warner Losh.
>>
>
> Warner did not volunteer to mentor this year. This sounds like an idea
> from a previous year. Is this the project idea?
> https://wiki.qemu.org/Internships/ProjectIdeas/FreeBSDUser
>

His project is for Linux-user, so I sent him here for advice.

Warner


> I have been researching potential areas for contribution and noticed that
>> QEMU currently has several missing ioctl calls. I am curious if
>> implementing these would be a suitable topic for a GSoC project or a
>> general contribution.
>>
>> I want to be clear that I am still evaluating this idea and am not
>> entirely sure of its feasibility or scope. My current plan is to focus o=
n
>> the discrepancy between the ioctl headers and their actual implementatio=
ns
>> in linux-user/syscall.c to identify unimplemented ioctls. I also noticed
>> that the current automation relies on regex, which I think can be improv=
ed
>> in complex cases.
>>
>
> You will need to provide more details in order to find a mentor. Which
> ioctls and which functionality will it enable?
>
> Alternatively, maybe there is a project idea in the project ideas list
> that you would like to apply for?
> https://wiki.qemu.org/Google_Summer_of_Code_2026
>
> Stefan
>
>
>> I am interested in building a more reliable method to identify and
>> address these gaps.
>> If this is a viable path, I would appreciate your guidance on how to bes=
t
>> approach it or if there are specific areas within this topic I should fo=
cus
>> on.
>>
>> Thank you for your time.
>>
>> Best regards,
>> Arun Krishna K
>>
>>

--000000000000e4a13a064b861a89
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 23,=
 2026 at 12:18=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@gm=
ail.com">stefanha@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 24, 2026, 00:18=
 Arun Krishna K &lt;<a href=3D"mailto:arunkrishnak2407@gmail.com" target=3D=
"_blank">arunkrishnak2407@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>I am reaching out =
to you regarding a potential GSoC project, as suggested by Warner Losh.</di=
v></div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Warner did not volunteer to mentor this year. This sounds like an idea =
from a previous year. Is this the project idea?</div><div dir=3D"auto"><a h=
ref=3D"https://wiki.qemu.org/Internships/ProjectIdeas/FreeBSDUser" target=
=3D"_blank">https://wiki.qemu.org/Internships/ProjectIdeas/FreeBSDUser</a><=
/div></div></blockquote><div>=C2=A0</div><div>His project is for Linux-user=
, so I sent him here for advice.</div><div><br></div><div>Warner</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"a=
uto"><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div></div><div>I
 have been researching potential areas for contribution and noticed that
 QEMU currently has several missing ioctl calls. I am curious if=20
implementing these would be a suitable topic for a GSoC project or a=20
general contribution.</div><div><br></div><div>I want to be clear that I am=
 still evaluating this idea and am not entirely sure of its feasibility or=
=20
scope. My current plan is to focus on the discrepancy between the ioctl=20
headers and their actual implementations in linux-user/syscall.c to=20
identify unimplemented ioctls. I also noticed that the current=20
automation relies on regex, which I think can be improved in complex=20
cases.=C2=A0</div></div></blockquote></div></div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">You will need to provide more details in order to find =
a mentor. Which ioctls and which functionality will it enable?=C2=A0</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Alternatively, maybe there is =
a project idea in the project ideas list that you would like to apply for?=
=C2=A0</div><div dir=3D"auto"><a href=3D"https://wiki.qemu.org/Google_Summe=
r_of_Code_2026" target=3D"_blank">https://wiki.qemu.org/Google_Summer_of_Co=
de_2026</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">Stefan</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br><=
/div><div>I am interested in building a more reliable method to identify=20
and address these gaps.</div><div>If this is a viable path, I would=20
appreciate your guidance on how to best approach it or if there are=20
specific areas within this topic I should focus on.</div><div><br></div><di=
v>Thank you for your time.</div><div><br></div><div>Best regards,</div><div=
>Arun Krishna K</div><br></div>
</blockquote></div></div></div>
</blockquote></div></div>

--000000000000e4a13a064b861a89--

