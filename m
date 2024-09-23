Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D5CF9C69
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 13:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssjYz-00047v-LJ; Mon, 23 Sep 2024 09:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1ssjYw-00045T-U3; Mon, 23 Sep 2024 09:57:14 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1ssjYu-00008r-Nd; Mon, 23 Sep 2024 09:57:14 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d88c0f8e79so3497266a91.3; 
 Mon, 23 Sep 2024 06:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727099831; x=1727704631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsz4ufxDmUH3PmXAB9PIDusWZxftLYtYCI9LtBhZEyE=;
 b=Io9E9/w9lrOWWKrAw7rwb8gN/21+xO4x5QHg5gG1gSJNElpXBwzPCuZ8fi6VHj3IDT
 4VsqYht7m1A9VbFb7hE7tHO9TsK4ueVuINN36Q8sVHFtO/YFZaiM69S96t1p+1LQ60OS
 HOnlaOvfYxQOKbPG29lXwOedogUMl86SiRuOTagnYhXw3Vknbyt6Syn+SxWeubi12Kj7
 S75Y/xSu2TYOwvb/3lojAlO0lhcaQYuX2nOtDC7oRL81AlvRfpXDHzjyEfkFVHD+z5Ti
 BsiFjIDoSemB1MaXm4+b8ehhOtQYUWVkRBDU36Z70F+dRv7gsHdBi8X5Tm4yNXuUrV0F
 I8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727099831; x=1727704631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xsz4ufxDmUH3PmXAB9PIDusWZxftLYtYCI9LtBhZEyE=;
 b=II134Nrbx1f6LApWbOclJxRleO/XdZJd1nqLfjVgZOp6UnHRdMcfZNJe5/5KHY21aA
 CGCLT0PkolRvEZxPLZ17Ni6UlZfxRq5pj2A/0qL6hJPmTgqLj/osXHjfHl4Bg+HqG0FI
 oVHGPHF6r6iNZRRFMlXYd9RjuF7UCjJbh8wwobdjP7RvYLqkRV4Rei5U3t80SH4HhrGa
 uAYXJF/683merAFpWUnLxRxf1YF5pRJph7l2fXAzyWnR/zLY/8FFkpEFTezo6+0MaFM4
 QobTzYOtMfvczoqFRv0GkwtljZI48Pc5ZXoIGBxvcTWrG+Q52YoXU0x/SSv/Fjw6y/90
 EgdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0zH5bQwB7pXCPbdtZIjh7mknEzA3gzCXF2a6Zmok7tJcyXo+wF7MfixTplAB+svzX2+uzlv+6MCUwhg==@nongnu.org,
 AJvYcCViMOfCMPvqdHnfvCHt/euuNDSfA3NcgrDROAiszEujxmgx8q7bcEmFN9dFKlERKDUpjJnDY0wvSQkr@nongnu.org
X-Gm-Message-State: AOJu0YwYr6sleBeHXLnHsXX9j5yr4+qPVkiQkfwqTLF49CZEHaqpLqxg
 3Y61iS51ZFubE/oTMHwYXfHG8dfGhrDP9Vba+0B1s2DP6T+VT3EiEU6j4cHa7sWRz+G4x8A/ojS
 RDQAB3uqJa9f2tgUiO1RjD5i7wuc=
X-Google-Smtp-Source: AGHT+IF5nr9RbM0mIoez3Coy19y2Ym/EdPiyjjcV9zvjZ30JtLFS1VanWrSS11LCEKnyiyTCusqHswKiCpvWG49aMQk=
X-Received: by 2002:a17:90b:3142:b0:2d8:f0e2:96bc with SMTP id
 98e67ed59e1d1-2dd80c06a9bmr14514515a91.4.1727099830799; Mon, 23 Sep 2024
 06:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-4-faithilikerun@gmail.com>
 <20240312183010.GB389553@fedora>
 <CAAAx-8LyxDtZra_5TC0CLmq4F4ShYtQqVTF0OCGVZ9tYWP4QMA@mail.gmail.com>
 <bc821290-2003-4795-a5fa-99a7c55e1374@kernel.org>
 <CAAAx-8JrPFEgBPKWEjXCXi8=ReEMkCEVGe-GEPSWUnfEGcZ=XQ@mail.gmail.com>
 <1a673b82-4362-4f10-bf62-41825f5a203b@kernel.org>
In-Reply-To: <1a673b82-4362-4f10-bf62-41825f5a203b@kernel.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 23 Sep 2024 15:57:00 +0200
Message-ID: <CAAAx-8LgNgd=6D9UOJyyiaUjcc7coB3qPfBGBTddWdQDTu=fgw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] qcow2: add zoned emulation capability
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e817d00622c9c30f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000e817d00622c9c30f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 15:48 Damien Le Moal <dlemoal@kernel.org> wrote:

> On 2024/09/23 15:40, Sam Li wrote:
> > Hi Damien,
> >
> > Damien Le Moal <dlemoal@kernel.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8823=
=E6=97=A5=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/09/23 13:06, Sam Li wrote:
> >>
> >> [...]
> >>
> >>>>> @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriverState *bs,
> int64_t offset, int64_t bytes,
> >>>>>          qiov_offset +=3D cur_bytes;
> >>>>>          trace_qcow2_writev_done_part(qemu_coroutine_self(),
> cur_bytes);
> >>>>>      }
> >>>>> +
> >>>>> +    if (bs->bl.zoned =3D=3D BLK_Z_HM) {
> >>>>> +        index =3D start_offset / zone_size;
> >>>>> +        wp =3D &bs->wps->wp[index];
> >>>>> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
> >>>>> +            /* Advance the write pointer when the write completes =
*/
> >>>>
> >>>> Updating the write pointer after I/O does not prevent other write
> >>>> requests from beginning at the same offset as this request. Multiple
> >>>> write request coroutines can run concurrently and only the first one
> >>>> should succeed. The others should fail if they are using the same
> >>>> offset.
> >>>>
> >>>> The comment above says "Real drives change states before it can writ=
e
> to
> >>>> the zone" and I think it's appropriate to update the write pointer
> >>>> before performing the write too. The qcow2 zone emulation code is
> >>>> different from the file-posix.c passthrough code. We are responsible
> for
> >>>> maintaining zoned metadata state and cannot wait for the result of t=
he
> >>>> I/O to tell us what happened.
> >>
> >> Yes, correct. The wp MUST be updated when issuing the IO, with the
> assumption
> >> that the write IO will succeed (errors are rare !).
> >>
> >>> The problem of updating the write pointer before IO completion is the
> >>> failure case.  It can't be predicted in advance if an IO fails or not=
.
> >>> When write I/O fails, the wp should not be updated.
> >>
> >> Correct, if an IO fails, the wp should not be updated. However, that i=
s
> not
> >> difficult to deal with:
> >> 1) under the zone lock, advance the wp position when issuing the write
> IO
> >> 2) When the write IO completes with success, nothing else needs to be
> done.
> >> 3) When *any* write IO completes with error you need to:
> >>         - Lock the zone
> >>         - Do a report zone for the target zone of the failed write to
> get the current
> >> wp location
> >>         - Update bs->wps->wp[index] using that current wp location
> >>         - Unlock the zone
> >>
> >> With that, one may get a few errors if multiple async writes are being
> issued,
> >> but that behavior is consistent with the same happening with a real
> drive. So no
> >> issue. And since the report zones gets you the current wp location, th=
e
> user can
> >> restart writing from that location once it has dealt with all the
> previous write
> >> failures.
> >
> > I see. To allow the concurrent writes, the lock will only be used on
> > the failure path while processing append writes.
> >
> >>
> >>> The alternative way is to hold the wps lock as is also required for w=
p
> >>> accessing. Therefore only one of multiple concurrent write requests
> >>> will succeed.
> >>
> >> That is a very simple solution that avoids the above error recovery,
> but that
> >> would be very bad for performance (especially for a pure sequential
> write
> >> workload as we would limit IOs to quue depth 1). So if we can avoid
> this simple
> >> approach, that would be a lot better.
> >
> > Yeah, I'll drop this approach. Although, it reminds me of how
> > file-posix driver emulates zone_append. It holds the lock whenever
> > accessing wps. Does that limit IOs to QD 1 too? If so, it can be
> > improved.
> > -- one zone_append starts
> >>> wp_lock()
> >>>> IO processing
> >>>>> wp_update
> >>>>>> wp_unlock()
> > -- ends
>
> Yes, this limits the IO queue depth to 1, so not great. file-posix can us=
e
> the
> exact same error recovery mechanism as I explained. The write IO flow
> would thus
> become:
>
> On submission:
>
> 1) wp_lock()
> 2) Check write alignement with wp (or change zone append into regular
> write)
> 3) Issue write as an asynchronous IO
> 4) wp_update
> 5) wp_unlock()
>
> And on completion, all you need is:
> 1) If no error, return success
> 2) wp_lock()
> 3) Do a report zone and use the reported wp value as the current wp
> 4) wp_unlock()
> 5) return IO error
>
> With this simple scheme, when there are no IO errors, things are fast and
> there
> is no "big lock" limiting the number of writes that can be issued. Only
> write
> error recovery ends up locking everything during the report zones, but
> that is
> fine. Errors are rare :)


Neat! I=E2=80=99ll send a separate patch for that.

Additionally, I was thinking about changing the zone size/capacity field to
64 bit in block layer and qcow2 config, as Stefan once suggested, which
will be in the next version of this patch series. Eventually, the 4GB of
zone size might be hit. Better change it beforehand.

Sam


>
>
> --
> Damien Le Moal
> Western Digital Research
>

--000000000000e817d00622c9c30f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>On Mon, Sep 23, 2024 at 15:48 Damien Le Moal &lt;<a href=3D"mailto:dle=
moal@kernel.org">dlemoal@kernel.org</a>&gt; wrote:<br></div><div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;bo=
rder-left-color:rgb(204,204,204)">On 2024/09/23 15:40, Sam Li wrote:<br>
&gt; Hi Damien,<br>
&gt; <br>
&gt; Damien Le Moal &lt;<a href=3D"mailto:dlemoal@kernel.org" target=3D"_bl=
ank">dlemoal@kernel.org</a>&gt; =E4=BA=8E2024=E5=B9=B49=E6=9C=8823=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A<br>
&gt;&gt;<br>
&gt;&gt; On 2024/09/23 13:06, Sam Li wrote:<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriv=
erState *bs, int64_t offset, int64_t bytes,<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qiov_offset +=3D cur=
_bytes;<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_qcow2_writev_d=
one_part(qemu_coroutine_self(), cur_bytes);<br>
&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; +<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 if (bs-&gt;bl.zoned =3D=3D BLK_Z_HM) {<=
br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D start_offset / =
zone_size;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 wp =3D &amp;bs-&gt;wps-&g=
t;wp[index];<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!QCOW2_ZT_IS_CONV(*wp=
)) {<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Advance =
the write pointer when the write completes */<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Updating the write pointer after I/O does not prevent othe=
r write<br>
&gt;&gt;&gt;&gt; requests from beginning at the same offset as this request=
. Multiple<br>
&gt;&gt;&gt;&gt; write request coroutines can run concurrently and only the=
 first one<br>
&gt;&gt;&gt;&gt; should succeed. The others should fail if they are using t=
he same<br>
&gt;&gt;&gt;&gt; offset.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The comment above says &quot;Real drives change states bef=
ore it can write to<br>
&gt;&gt;&gt;&gt; the zone&quot; and I think it&#39;s appropriate to update =
the write pointer<br>
&gt;&gt;&gt;&gt; before performing the write too. The qcow2 zone emulation =
code is<br>
&gt;&gt;&gt;&gt; different from the file-posix.c passthrough code. We are r=
esponsible for<br>
&gt;&gt;&gt;&gt; maintaining zoned metadata state and cannot wait for the r=
esult of the<br>
&gt;&gt;&gt;&gt; I/O to tell us what happened.<br>
&gt;&gt;<br>
&gt;&gt; Yes, correct. The wp MUST be updated when issuing the IO, with the=
 assumption<br>
&gt;&gt; that the write IO will succeed (errors are rare !).<br>
&gt;&gt;<br>
&gt;&gt;&gt; The problem of updating the write pointer before IO completion=
 is the<br>
&gt;&gt;&gt; failure case.=C2=A0 It can&#39;t be predicted in advance if an=
 IO fails or not.<br>
&gt;&gt;&gt; When write I/O fails, the wp should not be updated.<br>
&gt;&gt;<br>
&gt;&gt; Correct, if an IO fails, the wp should not be updated. However, th=
at is not<br>
&gt;&gt; difficult to deal with:<br>
&gt;&gt; 1) under the zone lock, advance the wp position when issuing the w=
rite IO<br>
&gt;&gt; 2) When the write IO completes with success, nothing else needs to=
 be done.<br>
&gt;&gt; 3) When *any* write IO completes with error you need to:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Lock the zone<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Do a report zone for the target=
 zone of the failed write to get the current<br>
&gt;&gt; wp location<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Update bs-&gt;wps-&gt;wp[index]=
 using that current wp location<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- Unlock the zone<br>
&gt;&gt;<br>
&gt;&gt; With that, one may get a few errors if multiple async writes are b=
eing issued,<br>
&gt;&gt; but that behavior is consistent with the same happening with a rea=
l drive. So no<br>
&gt;&gt; issue. And since the report zones gets you the current wp location=
, the user can<br>
&gt;&gt; restart writing from that location once it has dealt with all the =
previous write<br>
&gt;&gt; failures.<br>
&gt; <br>
&gt; I see. To allow the concurrent writes, the lock will only be used on<b=
r>
&gt; the failure path while processing append writes.<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;&gt; The alternative way is to hold the wps lock as is also require=
d for wp<br>
&gt;&gt;&gt; accessing. Therefore only one of multiple concurrent write req=
uests<br>
&gt;&gt;&gt; will succeed.<br>
&gt;&gt;<br>
&gt;&gt; That is a very simple solution that avoids the above error recover=
y, but that<br>
&gt;&gt; would be very bad for performance (especially for a pure sequentia=
l write<br>
&gt;&gt; workload as we would limit IOs to quue depth 1). So if we can avoi=
d this simple<br>
&gt;&gt; approach, that would be a lot better.<br>
&gt; <br>
&gt; Yeah, I&#39;ll drop this approach. Although, it reminds me of how<br>
&gt; file-posix driver emulates zone_append. It holds the lock whenever<br>
&gt; accessing wps. Does that limit IOs to QD 1 too? If so, it can be<br>
&gt; improved.<br>
&gt; -- one zone_append starts<br>
&gt;&gt;&gt; wp_lock()<br>
&gt;&gt;&gt;&gt; IO processing<br>
&gt;&gt;&gt;&gt;&gt; wp_update<br>
&gt;&gt;&gt;&gt;&gt;&gt; wp_unlock()<br>
&gt; -- ends<br>
<br>
Yes, this limits the IO queue depth to 1, so not great. file-posix can use =
the<br>
exact same error recovery mechanism as I explained. The write IO flow would=
 thus<br>
become:<br>
<br>
On submission:<br>
<br>
1) wp_lock()<br>
2) Check write alignement with wp (or change zone append into regular write=
)<br>
3) Issue write as an asynchronous IO<br>
4) wp_update<br>
5) wp_unlock()<br>
<br>
And on completion, all you need is:<br>
1) If no error, return success<br>
2) wp_lock()<br>
3) Do a report zone and use the reported wp value as the current wp<br>
4) wp_unlock()<br>
5) return IO error<br>
<br>
With this simple scheme, when there are no IO errors, things are fast and t=
here<br>
is no &quot;big lock&quot; limiting the number of writes that can be issued=
. Only write<br>
error recovery ends up locking everything during the report zones, but that=
 is<br>
fine. Errors are rare :)</blockquote><div dir=3D"auto"><br></div><div dir=
=3D"auto">Neat! I=E2=80=99ll send a separate patch for that.=C2=A0</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Additionally, I was thinking abo=
ut changing the zone size/capacity field to 64 bit in block layer and qcow2=
 config, as Stefan once suggested, which will be in the next version of thi=
s patch series. Eventually, the 4GB of zone size might be hit. Better chang=
e it beforehand.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Sam</di=
v><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;paddin=
g-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto"><br>
<br>
<br>
-- <br>
Damien Le Moal<br>
Western Digital Research<br>
</blockquote></div></div>

--000000000000e817d00622c9c30f--

