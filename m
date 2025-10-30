Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC6FCCF9FE
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 12:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vERmz-0006rd-Ps; Thu, 30 Oct 2025 08:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vERmy-0006rR-Fm
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vERmn-0006DJ-VU
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 08:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761827382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V8tsY0bibyYs3/R08KHMq4hHKdQzEUS22utMa8+DGko=;
 b=UsOsd8Q1wsza/QzRh3/w3l7p4lk4hDUBhUxgNC6ggiIeHNWFtqgMhv2LdvZR8WVUmGNivl
 BEf1j7tjsvSw1Y5ylKSbinj5j58qY8DZ/fKvV4kdveV9uM6OzvTnqr800Unn8NS6yz29fl
 7KALgWE+ZnHRxst1JbZlCLB1EZ7hmqc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-tv8YcnTTMXmBGaHpJPeU0Q-1; Thu, 30 Oct 2025 08:29:41 -0400
X-MC-Unique: tv8YcnTTMXmBGaHpJPeU0Q-1
X-Mimecast-MFC-AGG-ID: tv8YcnTTMXmBGaHpJPeU0Q_1761827380
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-427015f62a7so542066f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 05:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761827380; x=1762432180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V8tsY0bibyYs3/R08KHMq4hHKdQzEUS22utMa8+DGko=;
 b=bX1SawUDjw8TqUJdxLP8XR4HpQXWPEm3TPhlzKvGKIKIQptl9BUDG8vV8cd4oAe6QR
 xL1lvS18v1WFV5fyANIIXLyQm3N0HDoA8GPxsMPZCwkFXOeKvar7Q1Gvt0MrhI8I3Ch1
 q5XNcRG6BVks69z77yqd53Znfimvxavx5Q+0qT/mwSX++PajcPh4EsoVE92WFhSBhDjs
 bR56Q8xC5FMcvdHjGSKpkd7G45Gpg2zX1DCCS3PUSHUrCZyQpdXpMZgZfhlsbalahCN5
 CSiBK/ArtquQk4eAbWJjPfNXGl/j+FX2lLjQCQb6qHT+ucJwxhNTPWTlHFHGNt1zuga6
 LUMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXqS0eX3Ywbg6gKOsBSDg/WUReXuMs7LwfdZNZAR8ABys54eKrFNXXR47YZA3DN3xzAPP0ZbJ8basn@nongnu.org
X-Gm-Message-State: AOJu0YzLZGqE/ad/kv8/7JWwf6YcuOFXysnvx+4RL9N/uVavZfIs9odt
 Mw/1M/85y1yvP9hJ6Z/S7/dEGr272bzSq3xpyzYxtcqKhMvLgL3RX3H6WJKAM4rpM3aiRXj1gTQ
 1RBEg7ltld9PG1PInCYGkZOYnDwEOuIjjcIMbhW6EyYcF1N+irHisPA47oPs5lKlGA+wq+Jr7P4
 D8trtrw0uRClvkEWsbSuoIpnDTorcZfps=
X-Gm-Gg: ASbGncs4KDngk1ahlorwhKH6aUVvk89Gso6ySziLky9Tfj8FTVnJoVGTDJzBLbbDrs/
 85OfI4TCHNQWJNXOr6oiyvaw1d27nSJZa395gxwqGlj/YzPaPdaAe77GGzzBJLkmSXp5pMoNCWO
 jTOW4LotFfooUf1EHMIN+cP5AKQ53WXCcmHlhxMsc5vigaOi8KkU4sA1dfA0ok/Uu7EzjxS8tb1
 lMYAibOj360F+WKrVYZG/icC0nCvfB0mtFVrDHEVnioaH3+hjqkUTa64ii3
X-Received: by 2002:a05:6000:2505:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-429b4c734d9mr2631577f8f.12.1761827379714; 
 Thu, 30 Oct 2025 05:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/SQ2l20Pd/adTG/FbLc8O09celfND9oqpi+NzW0oIoWUfWUfoTj0F3LReA/whuUfKyYSTmKgIezVXZqUhII=
X-Received: by 2002:a05:6000:2505:b0:3ec:ea73:a91e with SMTP id
 ffacd0b85a97d-429b4c734d9mr2631557f8f.12.1761827379232; Thu, 30 Oct 2025
 05:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu> <aQJpDE6FvkIF6GgE@x1.local>
 <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
 <b525a0c5-bcc0-7349-a925-6827591b7a34@eik.bme.hu>
 <3849eccc-ca94-49f9-87a4-4c5aad496976@redhat.com>
 <ffde4e42-58ae-3338-e056-dcfea5d43475@eik.bme.hu>
In-Reply-To: <ffde4e42-58ae-3338-e056-dcfea5d43475@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 30 Oct 2025 13:29:28 +0100
X-Gm-Features: AWmQ_bmRDUATseBD7lLwRK9I8Ea816nG6FfgxmTaJw0-oUvHqH5hNqpm5WTaVo4
Message-ID: <CABgObfZ5fa40SStxMb+OXmg1k2iup1391n+doQNVyZWnR=_v-w@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000018538806425f6783"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

--00000000000018538806425f6783
Content-Type: text/plain; charset="UTF-8"

Il gio 30 ott 2025, 12:01 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:

> > Not sure what's different between
> >
> >    MemoryRegion foo_mr;
> >
> > in the struct, versus
> >
> >    mr = g_new(MemoryRegion, 1);
> >
> > in the realize function.  It's one line either way.
>
> Please read back in thread. An example here:
> https://lists.nongnu.org/archive/html/qemu-ppc/2025-10/msg00785.html
> from this series
> https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu/


I did read it of course.

There's four people in this thread telling you not to do something. Just
stop arguing please.

Paolo


> >> - Documentation says it should work this way QOM managing memory
> regions so
> >> it was meant to be that way. I'd rather fix code than documentation as
> I
> >> think if it just works that's easier than loosing that convenience.No,
> >> that's *your* reading of the documentation, and it's based on the
> > incorrect assumption that destruction implies freeing the memory.
> Akihiko
> > explained that
> > (
> https://lore.kernel.org/qemu-devel/802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp/
> ).
> >
> > The memory region documentation does not exist in a void, the difference
> > between QOM object_initialize() and object_new() exists independent of
> that
> > documentation.  It may be worth improving the QOM documentation on the
> object
> > lifecycle; that could be.
>
> I'll try to also clarify documentation but IMO the fix is not dropping
> this intended feature but fixing and using it where helps.
>
> Regards,
> BALATON Zoltan
>
>

--00000000000018538806425f6783
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 30 ott 2025, 12:01 BALATO=
N Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu">balaton@eik.bme.hu</a>&g=
t; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&=
gt; Not sure what&#39;s different between<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 MemoryRegion foo_mr;<br>
&gt;<br>
&gt; in the struct, versus<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 mr =3D g_new(MemoryRegion, 1);<br>
&gt;<br>
&gt; in the realize function.=C2=A0 It&#39;s one line either way.<br>
<br>
Please read back in thread. An example here:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-ppc/2025-10/msg00785.=
html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.nongnu.=
org/archive/html/qemu-ppc/2025-10/msg00785.html</a><br>
from this series<br>
<a href=3D"https://patchew.org/QEMU/cover.1761232472.git.balaton@eik.bme.hu=
/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patchew.org/QEMU=
/cover.1761232472.git.balaton@eik.bme.hu/</a></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I did read it of course.=C2=A0</di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">There&#39;s four people in =
this thread telling you not to do something. Just stop arguing please.=C2=
=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
&gt;&gt; - Documentation says it should work this way QOM managing memory r=
egions so <br>
&gt;&gt; it was meant to be that way. I&#39;d rather fix code than document=
ation as I <br>
&gt;&gt; think if it just works that&#39;s easier than loosing that conveni=
ence.No, <br>
&gt;&gt; that&#39;s *your* reading of the documentation, and it&#39;s based=
 on the <br>
&gt; incorrect assumption that destruction implies freeing the memory. Akih=
iko <br>
&gt; explained that <br>
&gt; (<a href=3D"https://lore.kernel.org/qemu-devel/802b77f2-2c23-4b5a-a739=
-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp/" rel=3D"noreferrer noreferrer" target=
=3D"_blank">https://lore.kernel.org/qemu-devel/802b77f2-2c23-4b5a-a739-d56b=
09c335de@rsg.ci.i.u-tokyo.ac.jp/</a>).<br>
&gt;<br>
&gt; The memory region documentation does not exist in a void, the differen=
ce <br>
&gt; between QOM object_initialize() and object_new() exists independent of=
 that <br>
&gt; documentation.=C2=A0 It may be worth improving the QOM documentation o=
n the object <br>
&gt; lifecycle; that could be.<br>
<br>
I&#39;ll try to also clarify documentation but IMO the fix is not dropping =
<br>
this intended feature but fixing and using it where helps.<br>
<br>
Regards,<br>
BALATON Zoltan<br>
<br>
</blockquote></div></div></div>

--00000000000018538806425f6783--


