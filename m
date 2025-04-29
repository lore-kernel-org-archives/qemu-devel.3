Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF1FC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9max-00039q-Hu; Tue, 29 Apr 2025 11:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9maw-00039Z-9H
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9mau-0001ko-J6
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745939399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blgVg5ELbBfFq0mKa0XlQ0lHhwJsv6Fel2TzlXN2O0s=;
 b=eDffIeMhqGMfWVWDxWUkpzFJf7oo2K39f5z6SGdgUbywmxVxylIyovS9tsrll5eb7a529X
 alG3ww3Xb8G0ezP29r9YQwNAPCNEZUWVT+tZf3Dor5N58J61OS2yIK4azY59MbKkWBReV0
 QQ9P32G5clcKrJNUDyOlgxKIJWFSn1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-flWHCZNxOEyigD9x4Gv6TQ-1; Tue, 29 Apr 2025 11:09:58 -0400
X-MC-Unique: flWHCZNxOEyigD9x4Gv6TQ-1
X-Mimecast-MFC-AGG-ID: flWHCZNxOEyigD9x4Gv6TQ_1745939394
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39135d31ca4so2352443f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745939393; x=1746544193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=blgVg5ELbBfFq0mKa0XlQ0lHhwJsv6Fel2TzlXN2O0s=;
 b=mcPaeSgMCQB2ixXr3d5fcV0kCQROoUHjT0g8/JTRk2f3PJqsE9nglmsZJ3cWjk/MYZ
 bbAzfqyJgnrdtgHH8nBZ0vnBYK4d5zPd7BLkHJZ19yaXm4D/4mXRh5pEnt20rhXsjXy0
 tfUxWio5WRg5QnQvOLQf8mxl1qXzhlcgbzdbWjyuJxqbUP+gaKaeExqvEi9ZUHsJjhkx
 bm7Z7xcGTQAYXIn+RnOUAcm+X+sTYuEztOC+TQMbN+EOenL1fWP4ibx2VBsF//7GbjJc
 q80qU7v9j0N/6wwSyIjjdyI31aL9AdvPC3q71ZkuXJngHvOkEVMMrMP7M7K2wHHTtiOm
 ZzBw==
X-Gm-Message-State: AOJu0Yxcm5GFS0zyTA7S0kW45eSaiJGjPmwTwTIcZuaP3bSE7EOLDeSy
 Eoee0HmNYRO9YqUSOwckhK2iHMg69WTY/aDQ9XEKBLRK1fVQ5ZzzVkyRm0X6AFD0x7j7WYukLlj
 cIDpDtkvdb8HJFkfj2pzo2ARC6F/UThB3gzxDlO2bWPzITwQRnABomUZD8Jq0KoTSi/Df38vwW+
 w0e8iP7hjuvbOCRJ73htL4yrIx7lgIikeA3fE=
X-Gm-Gg: ASbGncuU/PeCKygYoEmJHUuaA/Ow83A6qmDZWa/iMqSTJcROsPCFV+xCubgAbF3TB/F
 YP5FT3bnvMYtcOCdiHUCPs0UhqYkCcgDc34WzBsW+dHszmTKgCAo+C+3xKs8LGBPuscw=
X-Received: by 2002:a5d:4804:0:b0:3a0:8282:88e3 with SMTP id
 ffacd0b85a97d-3a08a536701mr2261877f8f.27.1745939393025; 
 Tue, 29 Apr 2025 08:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIAc18JhZ6llGerrla3NZvx18BM8D/TUz1nLhqPaqYWMv+VexqJBjDzYSZ0eNLTs5InKT0SENKbbSH5p5wqrE=
X-Received: by 2002:a5d:4804:0:b0:3a0:8282:88e3 with SMTP id
 ffacd0b85a97d-3a08a536701mr2261851f8f.27.1745939392649; Tue, 29 Apr 2025
 08:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-7-marcandre.lureau@redhat.com>
 <CABgObfY03pS2DV6ttABt0-82RGvRbVKq8atM9Eoki2-WFELhXA@mail.gmail.com>
 <CAMxuvaxn83Fmx2DPhYrYuHJJDyCLAxJtuz_Sjrt3Y=CoiEu73w@mail.gmail.com>
In-Reply-To: <CAMxuvaxn83Fmx2DPhYrYuHJJDyCLAxJtuz_Sjrt3Y=CoiEu73w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 29 Apr 2025 17:09:40 +0200
X-Gm-Features: ATxdqUEHCQhyTkFFiemriNYptUpPys81nOT6A6ohUqYR0zLekOGxwgsdsLF3HuQ
Message-ID: <CABgObfZCccn0o7jm=q-4vAG+LVVa+F5b25oCwggwnC8zs8MWQg@mail.gmail.com>
Subject: Re: [PATCH 6/6] RFC: qom/object: simplify object_property_del_all()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004c73220633ec319c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

--0000000000004c73220633ec319c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 29 apr 2025, 16:37 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
ha scritto:

> Hi
>
> On Tue, Apr 29, 2025 at 6:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> >
> >
> > Il mar 29 apr 2025, 16:03 <marcandre.lureau@redhat.com> ha scritto:
> >>
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Since commit 9859fac ("object: release all props"), the code was chang=
ed
> >> to tracks the already released properties in a hash table. I am not su=
re
> >> why this was done, perhaps to prevent from potential crashes if
> >> properties are being added dynamically during release. I am not sure i=
f
> >> it's a valid concern though.
> >
> >
> > You always need object_property_iter_init in case prop->release deletes
> a property, thus invalidating the GHashTable iterator. The hash table
> instead is needed in case prop->release does *not* delete a property,
> because then the property reappears on subsequent recreations of the
> iterator.
>
> Yes, changing the properties while they are being removed is I think
> the reason I added the HashTable/Set. But is this a valid concern?
> (the penalty is a bit sad)
>

I think deleting is a possibility... For example releasing a property could
trigger an object_unparent(). Since there is no better way to notice I
think it's better to keep it.

Maybe we could add a generation count to the Object struct?

Paolo

>

--0000000000004c73220633ec319c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 29 apr 2025, 16:37 Marc-A=
ndr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcand=
re.lureau@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">Hi<br>
<br>
On Tue, Apr 29, 2025 at 6:23=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"mailto=
:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Il mar 29 apr 2025, 16:03 &lt;<a href=3D"mailto:marcandre.lureau@redha=
t.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.com</a>=
&gt; ha scritto:<br>
&gt;&gt;<br>
&gt;&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lurea=
u@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redhat.=
com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Since commit 9859fac (&quot;object: release all props&quot;), the =
code was changed<br>
&gt;&gt; to tracks the already released properties in a hash table. I am no=
t sure<br>
&gt;&gt; why this was done, perhaps to prevent from potential crashes if<br=
>
&gt;&gt; properties are being added dynamically during release. I am not su=
re if<br>
&gt;&gt; it&#39;s a valid concern though.<br>
&gt;<br>
&gt;<br>
&gt; You always need object_property_iter_init in case prop-&gt;release del=
etes a property, thus invalidating the GHashTable iterator. The hash table =
instead is needed in case prop-&gt;release does *not* delete a property, be=
cause then the property reappears on subsequent recreations of the iterator=
.<br>
<br>
Yes, changing the properties while they are being removed is I think<br>
the reason I added the HashTable/Set. But is this a valid concern?<br>
(the penalty is a bit sad)<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">I think deleting is a possibility... For example =
releasing a property could trigger an object_unparent(). Since there is no =
better way to notice I think it&#39;s better to keep it.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Maybe we could add a generation count to t=
he Object struct?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
=C2=A0</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--0000000000004c73220633ec319c--


