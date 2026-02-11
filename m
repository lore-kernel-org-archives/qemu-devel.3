Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55578EB596D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4Es-0002oy-Lk; Wed, 11 Feb 2026 02:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vq4Ek-0002nz-30
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vq4Eh-0000q3-Oa
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770793325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GdMx+GNpOpFAsrjlouhs6n4mWeL4MCXM6C+447qyidA=;
 b=ffL3tyw8pBJVcsNXkd7CQRZNWwgpWEE7PYbgZ8nK8TzIU25SnLdi7jDQhfOS4m29gNx/85
 0F8nlsDhSY1qTqlb4Glh2pT+9W+r2uku+7dPnMjJg7XNRRKa54xklk3PEzUKIEwZ9gBp4O
 LdoTbXRL8b7M0ms1lWG52pCi7Ey+o1s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Cror-zuxMv-mYy6c0uAUdA-1; Wed, 11 Feb 2026 02:02:03 -0500
X-MC-Unique: Cror-zuxMv-mYy6c0uAUdA-1
X-Mimecast-MFC-AGG-ID: Cror-zuxMv-mYy6c0uAUdA_1770793322
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-436267b01c4so1766731f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 23:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770793322; cv=none;
 d=google.com; s=arc-20240605;
 b=GohDPPTBwyz7e9qybO53eOYCVnstCWs5Zsiaof0p4CD3Rjkm9eJ1PkzmECNZNk3h6M
 Uwh75c6vb6QFKByn2ArtDbcmRevlvJ2/DM4TsnHtC0Y7RNYcGSOfQstYQC3yuI8a4xYf
 YESCloeEfnyrXlubeYSVKW1oHa40WsKrawU76xEmAPbfIgXxDpESkEarwLwm+U/EX3M7
 YsCc9sRpXXnTrA26PRRBiAhINtrRFFFleFDa8yMZHnIuCu7TaQ1sdMeXpygfmqoa1f9D
 mlXPw72Bs6ywL9orfiuLJ5MVAJK+fqr0T6UsnGeGqY+oshqZzra7SAimDHb2UEdP/RoK
 K1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GdMx+GNpOpFAsrjlouhs6n4mWeL4MCXM6C+447qyidA=;
 fh=aB6rdLME4MpV6JeztnHvwLEKxzoGTJku46L2Lv1NnbE=;
 b=ZSHJJnmSqAFlyC0re46vQmvvPd3pj2AJEfWZkaj/i8PlJohoijJ4t6jJh3ng8qOHgy
 aIOIa714wVhRithpHgTcU8TK8kKphgyiY6NPA1PuWAu+ZhZegKWYoV/A127CL+nu1cAa
 lD43AOWNWKg7VkTv2pQM8U1so6qCfqidHIM39IFYCIoImap8d8l+aDOR1UXalJs7vkkj
 VnZy41nA2bJPISJnNqB4e4JAEcnJT5sCpobBYJN82OYw9LT41q0kpHGF37IeA+Er2WtD
 qCkJAlfug/WAVxcwwUFnQGqJ5H+3Acy+lDGoV689RZN/7uJc5S2JCkrWOmIPlyG8b9hn
 eRtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770793322; x=1771398122; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GdMx+GNpOpFAsrjlouhs6n4mWeL4MCXM6C+447qyidA=;
 b=R4S/M1SSKA4SAwQc5EmSUYfI1Gftho5vN76nUBTg0aHMQtI0NXOIYOrMdCDDv76o9r
 S7JY25HvJirLz9gYiCgHqaS/bQVsj0ZL76mYbosanWizL2wPUeTDo/mEEpwr+DwGWu2S
 5vTTqgvv5/El8bCcMRT2ChUzdRSlB8US4ad+ifs6RRoUFMqp+TDQp8b43utkzY0u7cMm
 fkzJRCEOLV9BKrqH+FW6DBuzrpHKRBmOosHCbNB0vgmJyYyWbBj08/hlQUIzT5OszgG8
 hMnaiwNG/ZxrhEKXxE3EXGlmp0xuQEa3+dPKGJzHd1vYNtLDAt4ydU25VZO4X9/h0BDB
 3wnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770793322; x=1771398122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdMx+GNpOpFAsrjlouhs6n4mWeL4MCXM6C+447qyidA=;
 b=mhOAdR5H65Z2vU+T1/+Lct5Hkf0P7oAN6Kl9PLL2Zcvrbo9W3UU26iG+Th7JtcWGIJ
 K0zB/MuycQ5PoihJe++5V816GSoT0QvCcvHkS3s2AYDLfxG532rs6L2TuCEGHRSr3ECH
 yHJZmcbjkiURetdDyw/YJtEWSZ2KSZpqi6qZfWW+yfYrBQSkELEsLsDGiNckMSgmsV4x
 /V6A1t0aWoG6M+hDz1zoX31Ro5y1rBvz7nq75+Kph5klt8gYBC4gCq5HQGcWgWGMeSsb
 IT8zdh1X0j3rhc+Jdl2t/NuQoqnUTVaNNrubXwb8t25BkQbudW8SuQLDvoIbOcY+T/o0
 2XcA==
X-Gm-Message-State: AOJu0YyGqKk0UQjmNjF5a0VfkO4JmcM4ioISxBt/21de7Kikc0ftveW8
 XonaZeFMxmV5JdYrWwDjUfClyX8+INUk2XpHH5Y1PPI+DW5IDBGhORliINw3FWDJPeUJClKwUue
 VEUe7fixtibz8XOpuyfj89+G0/IQvZAmIauepaAt00nY0K9xn3LN3UTyDxJcNaGSDgJmTbpw1Pi
 c1R0jkvFo0r4UY+tL6O+iKVxay4S+u5vU=
X-Gm-Gg: AZuq6aLMdO3MKIPkylTzxKh4UAkFnCOiJaW2kel8aChRmoHmTl9j0hVD1XCHbyILXH5
 hZSa0HNQQfNbhKG0auvCjg+wfDYQjmWO9MQo0nNYB0cTe/vxXXBd+dCal2nfQEhJ71vRK+GMMgD
 Od5LKNOU2d9Iyra7Rxog3hp5Vn4BpaRYkrnW/10njjrC55T8b/curv1VmPm41Hm3LXpRouMlE+n
 5Dd9I/+/h8S/iarOf0wsc6bG6CXts0uckXLtagpH3Yx/lThVwILnEtFqrgE88AaGKQI/P5P5O1O
 whejYQ==
X-Received: by 2002:a05:6000:22c6:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-4362938ff1emr24770461f8f.59.1770793321735; 
 Tue, 10 Feb 2026 23:02:01 -0800 (PST)
X-Received: by 2002:a05:6000:22c6:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-4362938ff1emr24770418f8f.59.1770793321277; Tue, 10 Feb 2026
 23:02:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770753117.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770753117.git.balaton@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Feb 2026 08:00:00 +0100
X-Gm-Features: AZwV_QgrBMYTpSyGOl8zQb6scZpswyKjZ5dqfKA-cg3Cv5NE9y0nX3KuO7v6vmU
Message-ID: <CABgObfYpW0YMofv4O8gf4p-aWVxfvQ+BCMPsm2w+5MtD8-9s0Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e2c1aa064a86f24b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

--000000000000e2c1aa064a86f24b
Content-Type: text/plain; charset="UTF-8"

Il mar 10 feb 2026, 21:02 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> Our documentation says that memory regions are automatically freed
> when the owner dies and the reference counting to do this is also
> implemented. However this relies on the QOM free funtion that can only
> be set by creating objects with object_new but memory API only
> provides constructors that call object_initialize which clears the
> free function that prevents QOM to manage the memory region lifetime.
> Implement corresponding memory_region_new_* functions that do the same
> as the memory_region_init_* functions but create the memory region
> with object_new so the lifetime can be automatically managed by QOM as
> documented. The memory_region_init functions are kept because they are
> useful for memory regions embedded in other object or managed
> externally and not by QOM for some reason.
>

I think there was pretty much agreement *not* to do this?

Paolo

v3:
> Based-on: <cover.1770753117.git.balaton@eik.bme.hu>
> - convert xtfpga from nomigrate as this has no migration compatibility
> issue
>
> v2:
> - rebase on master
> - update documentation
> - use these function to fix some leaks (there may be more, e.g. in
> hw/pci-host/bonito but I leave that for later and/or others)
>
> BALATON Zoltan (6):
>   memory: Add memory_region_new* functions
>   memory: Update documentation for memory_region_new*()
>   hw/ide/sii3112: Use memory_region_new to avoid leaking regions
>   hw/pci-host/articia: Map PCI memory windows in realize
>   hw/pci-host/articia: Add variable for common type cast
>   hw/xtensa/xtfpga: Fix leaking memory region
>
>  docs/devel/memory.rst   |  21 ++---
>  hw/ide/sii3112.c        |  30 +++----
>  hw/pci-host/articia.c   |  22 +++--
>  hw/ppc/amigaone.c       |  28 ++-----
>  hw/ppc/pegasos.c        |  13 ---
>  hw/xtensa/xtfpga.c      |   7 +-
>  include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++
>  system/memory.c         | 181 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 407 insertions(+), 74 deletions(-)
>
> --
> 2.41.3
>
>

--000000000000e2c1aa064a86f24b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 10 feb 2026, 21:02 BALATO=
N Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
ur documentation says that memory regions are automatically freed<br>
when the owner dies and the reference counting to do this is also<br>
implemented. However this relies on the QOM free funtion that can only<br>
be set by creating objects with object_new but memory API only<br>
provides constructors that call object_initialize which clears the<br>
free function that prevents QOM to manage the memory region lifetime.<br>
Implement corresponding memory_region_new_* functions that do the same<br>
as the memory_region_init_* functions but create the memory region<br>
with object_new so the lifetime can be automatically managed by QOM as<br>
documented. The memory_region_init functions are kept because they are<br>
useful for memory regions embedded in other object or managed<br>
externally and not by QOM for some reason.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">I think there was pretty much agr=
eement *not* to do this?</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
v3:<br>
Based-on: &lt;<a href=3D"mailto:cover.1770753117.git.balaton@eik.bme.hu" ta=
rget=3D"_blank" rel=3D"noreferrer">cover.1770753117.git.balaton@eik.bme.hu<=
/a>&gt;<br>
- convert xtfpga from nomigrate as this has no migration compatibility<br>
issue<br>
<br>
v2:<br>
- rebase on master<br>
- update documentation<br>
- use these function to fix some leaks (there may be more, e.g. in<br>
hw/pci-host/bonito but I leave that for later and/or others)<br>
<br>
BALATON Zoltan (6):<br>
=C2=A0 memory: Add memory_region_new* functions<br>
=C2=A0 memory: Update documentation for memory_region_new*()<br>
=C2=A0 hw/ide/sii3112: Use memory_region_new to avoid leaking regions<br>
=C2=A0 hw/pci-host/articia: Map PCI memory windows in realize<br>
=C2=A0 hw/pci-host/articia: Add variable for common type cast<br>
=C2=A0 hw/xtensa/xtfpga: Fix leaking memory region<br>
<br>
=C2=A0docs/devel/memory.rst=C2=A0 =C2=A0|=C2=A0 21 ++---<br>
=C2=A0hw/ide/sii3112.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 30 +++----<br>
=C2=A0hw/pci-host/articia.c=C2=A0 =C2=A0|=C2=A0 22 +++--<br>
=C2=A0hw/ppc/amigaone.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 28 ++-----<br>
=C2=A0hw/ppc/pegasos.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 ---<br>
=C2=A0hw/xtensa/xtfpga.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +-<br>
=C2=A0include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++=
<br>
=C2=A0system/memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 181 ++++++++++++++=
++++++++++++++++++++++++++<br>
=C2=A08 files changed, 407 insertions(+), 74 deletions(-)<br>
<br>
-- <br>
2.41.3<br>
<br>
</blockquote></div></div></div>

--000000000000e2c1aa064a86f24b--


