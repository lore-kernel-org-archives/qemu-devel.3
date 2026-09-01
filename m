Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A117FC624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SUr-0002LD-F2; Tue, 01 Sep 2026 13:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x1SUi-0002Kj-MU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:42:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x1SUg-0001B6-Cb
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788284516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c4dQkfQbZYeZ0eTyRC57v8Im39dL6dbnfA6OKhuiV+o=;
 b=JPaalQplFuWe+CXoasv8ABoPuLyWEzAUIGr9o1OHfztA0LzDtUs41Mhcqn32x+RWuFuvS3
 Hrm2PT8zTsFUS37nJnaBzHxGgq9X8D2Qy96QHAYFiaUas92xA26R1nJn7GeMgAH0V9e0me
 pG9lyN8zksGdGRhcXgmRn6haKCjDfzo=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-5oa7Ou4UOJC2_nj4DSpJag-1; Tue, 01 Sept 2026 13:41:54 -0400
X-MC-Unique: 5oa7Ou4UOJC2_nj4DSpJag-1
X-Mimecast-MFC-AGG-ID: 5oa7Ou4UOJC2_nj4DSpJag_1788284513
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2d52734fc41so976485ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788284513; cv=none;
 d=google.com; s=arc-20260327;
 b=bz31sjOrgU4dVMUVOCOX8Y/Wn3sERLZgGtJodDMSwGHoaBO9aweULQDvE/6gNJ8kNd
 uN9X36B7VDjzX7m5i4rj5OKlgzlumB1yLEkiooLRBFcX1Dg5t6SkW6Ai/jrGc9P89Y1O
 6Xop9kH1gAV0lAoXEC0k4bmUYj4KHxOgjPJa8lorIwUiZkSAUp6u9Ht0IEYYprEs4SbR
 2h+R3tklJU/LylVcWljnKy1+bDRxghCNxY0oDTDaFgaQqjK35jFG1kt8YbrsTposdxT+
 tIhgx/6DzustUN5jNHNSPCdWZJy7uP6vk7YaQtIc4grKhjiT5EsxOtwf9ue4B1/rBpP4
 7Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c4dQkfQbZYeZ0eTyRC57v8Im39dL6dbnfA6OKhuiV+o=;
 fh=oPtfXQM5EZVioUGQT0clvqK6TK6ir1gI82An+AX8V3g=;
 b=qSpTPwPMyJFYQD/SzvausXQlj7dA3mxlVA5m0y8aCWqtYSHcpqEVJkmy7xO9qVogHk
 JDVjTJZvlbNYmeI9WSdCRNj4cqaDdN1ztQAuNQbzQjjvN24ER7WBUU9fxmvX35vGfI5c
 Tz78GP25ywBGLVPPZpFw91O+gx9zE1bInDyfPxRoo3cFeT9mmc+dKiuLvhXEPZ9BojsE
 I3y4KckPSg9K80I2TeRUJe3Ap4exuK4Qil4AYy15/iEMiXkjsI30HFS3NCjHyiZPon0F
 qwUjN9MZ9F6zW4LDvCPZt5pekvxq3cl8VaLbkblg9JDy0RuJUxAccAyK75TLm2+Rq7G0
 0gDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788284513; x=1788889313; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c4dQkfQbZYeZ0eTyRC57v8Im39dL6dbnfA6OKhuiV+o=;
 b=Irv3jm1bQisyLzXzB+yXF9ahyEnO/OEj948JJhz6fhXS/Z8WgKr2w4gSKUdA/aMsBY
 uwxRrE/xozGLCCFfQi6dnTP3uPp9zM2nSNRjK4d2wR+2r7dmGpuBkydbCrjm1ndcNy+t
 flJVqbklXOkFJGD8jC3WwayQJdYFzL/QLnd39VOywvabrwD/BUPNpIrWRFUV1DVJfEp2
 ZCu/a/RtNCpe9BtA6DufZ34iESCT+5MmLm/Q/F1v3La/l7au7M6n3MZezHObql+otD17
 kBRjB/sV3C/fzN+YkEwp0/v8QR+6QqM40odIZCv7S5z7eQNcX9aYqYo8Vj3uPqUkiRdq
 w9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284513; x=1788889313;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c4dQkfQbZYeZ0eTyRC57v8Im39dL6dbnfA6OKhuiV+o=;
 b=rb7garCsTzxggBWz46yKGBncrxae9HVD+hon01i2j9O5vBGekbVWK5idkyIIibb6ka
 hJ46l6voTr65REEwc9UVWjYXZilsz5wxHvIo7lor4Iq8BbTsIuLfEQ27eegbjir3sLkH
 rfl2WJ1oCjbE8mjwMw5ZsX0czJ+1LDM/wxbWQbZ8OPHNE2Sv4ixWzVgOVAbyEh98xsn6
 96SvyE4q9yUdlhIK9fWSX0r7+HzJHeAtTJJZK+yYaZCWVr0/CeXEE3P0Dq75MYuiNv55
 lammcjsC+X7FnoHQLRLLqbqN47XbeP7aDUgvrTnc+HT7tO4qOfG0V9HedRe3KaU95lc6
 tNWA==
X-Gm-Message-State: AFuF++k+xmfMWQxgf1kmXbb4KqvAdPPLCI5GwWby+8em0ql732q4SbRW
 jDEpWSpkKrSJKnhXiv98WLu9gh2Cxy+CVWIaWReW3mR3uJuEZEDdPB9LoBvUuq4qxrw24BPq6Mw
 FjGBPcliu6Sr7jh95Rh3usP/ZtXIyftwTy/YdJ9jPPHTHSmEjftH3ewN/j2FdTT71uDFtg5ANYz
 91QAv0newOqZ4KQkR6yVeXID4GRPa80QE=
X-Gm-Gg: AYBFou0LKAWYtmEFgQGJZy6sQma49p1x3D2McWBU7pISAlNlgZ7SfL+gCqf9HCDUVEY
 9Un+eosa3n2/mdnP8vi/X6UNcF3gbU7sUsBmBgosytTDh7lOeeoRMTQ0ISxNZ5sZgAyP2q2o7cF
 1M3Kuc8BjRUdPXp8Ys71HHSV44OXrhBEocuwr5+LBatviy3MqkW3ruSyFvH5Q=
X-Received: by 2002:a17:90b:288a:b0:396:6344:3b62 with SMTP id
 98e67ed59e1d1-396d0f1a708mr56762115a91.12.1788284513223; 
 Tue, 01 Sep 2026 10:41:53 -0700 (PDT)
X-Received: by 2002:a17:90b:288a:b0:396:6344:3b62 with SMTP id
 98e67ed59e1d1-396d0f1a708mr56762046a91.12.1788284512688; Tue, 01 Sep 2026
 10:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260719160329.73695-1-bogorodskiy@gmail.com>
 <CAPMcbCrLmS2NXASKAWujm6=do9cAvMcB4p5Yxp73T_6HshRGQA@mail.gmail.com>
 <apcL3cfPcBw9YEf9@tulp>
In-Reply-To: <apcL3cfPcBw9YEf9@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 1 Sep 2026 20:41:39 +0300
X-Gm-Features: AcwNN1UeajGkwubCFiU71UHJvkuJ-d7j8HoEO-gtX9cF8JDzXfNif0jhdoRlpJM
Message-ID: <CAPMcbCo6_cx0NJmixpgzd+P7M6Wot_Z2XD_9mDx0vdfguQOaGw@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000237835065a6f6f57"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000237835065a6f6f57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:32=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmail=
.com>
wrote:

>   Kostiantyn Kostiuk wrote:
>
> > Hi Roman,
> >
> > Thanks for your patch, and sorry for the late reply
> >
>
> Thanks for review!
>
> > On Sun, Jul 19, 2026 at 7:04=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@=
gmail.com
> >
> > wrote:
> >
> > > Implement the 'guest-get-diskstats' for FreeBSD.
> > > This implementation uses the devstat(3) library which is a part
> > > of the FreeBSD base system.
> > >
> > > The build system is updated to link qga with `-ldevstat`.
> > >
> > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > > ---
> > >  qga/commands-bsd.c   | 127 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  qga/meson.build      |   3 +
> > >  qga/qapi-schema.json |   6 +-
> > >  3 files changed, 133 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> > > index 94ff6fee6a..763db33c9f 100644
> > > --- a/qga/commands-bsd.c
> > > +++ b/qga/commands-bsd.c
> > > @@ -27,6 +27,9 @@
> > >  #include <net/ethernet.h>
> > >  #endif
> > >  #include <paths.h>
> > > +#ifdef CONFIG_FREEBSD
> > > +#include <devstat.h>
> > > +#endif
> > >
> > >  #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
> > >  bool build_fs_mount_list(FsMountList *mounts, Error **errp)
> > > @@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa,
> unsigned
> > > char *buf,
> > >      return true;
> > >  }
> > >  #endif /* HAVE_GETIFADDRS */
> > > +
> > > +#ifdef CONFIG_FREEBSD
> > > +static uint64_t bintime_to_msec(const struct bintime *bt)
> > > +{
> > > +    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) *
> 1000ULL) >>
> > > 32);
> > > +}
> > > +
> > > +static void guest_diskstats_append(GuestDiskStatsInfoList ***tailp,
> > > +                                   const struct devstat *dev)
> > >
> >
> > Can we simplify pointer logic?
> > For example, return GuestDiskStatsInfo* for devstat* and then append th=
e
> > list in guest_get_diskstats.
> > ***tailp -> more pointers - easier to make a mistake or memory leak.
>
> Yes, will address in v2.
>
> > > +
> > > +    diskstat->has_ios_pgr =3D true;
> > > +    if (dev->start_count >=3D dev->end_count) {
> > > +        diskstat->ios_pgr =3D dev->start_count - dev->end_count;
> > > +    }
> > >
> >
> > In case start_count < end_count, you have has_ios_pgr =3D true, and
> ios_pgr =3D
> > 0 (g_new0 initialized to 0=E2=80=99s)
> > Is this expected? And in general, is this possible?
>
> That's an interesting question.
> `start_count` and `end_count` are uint's. It is possible that
> `start_count` will wrap sooner than `end_count`, so
>
>    start_count < end_count
>
> But apparently the correct behaviour is still report the difference
> instead of reporting 0.
>
> devstat(9) describes that:
>
>      start_count        Number of operations started.
>
>      end_count          Number of operations completed.  The =E2=80=9Cbus=
y_count=E2=80=9D
> can
>                         be calculated by subtracting end_count from
>                         start_count.  (sequence0 and sequence1 are used t=
o
> get
>                         a consistent snapshot.)  This is the current
> number of
>                         outstanding transactions for the device.  This
> should
>                         never go below zero, and on an idle device it
> should
>                         be zero.  If either one of these conditions is no=
t
>                         true, it indicates a problem.
>
>
> So it looks like the conditional is not needed. libdevstat in FreeBSD
> does not have it too [1].
> I'll remove that in v2.
>
> > > +
> > > +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
> > > +{
> > > +    return guest_get_diskstats(errp);
> > >
> >
> > Any reason for this wrapper?
> > I see it in the Linux implementation, but not for other commands.
>
> I followed the Linux implementation schema here. Apparently it is not
> necessary. Will address in v2 as well.
>

Then let's drop it


>
> 1: https://cgit.freebsd.org/src/tree/lib/libdevstat/devstat.c#n1547
>
>
>

--000000000000237835065a6f6f57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div>=
<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"=
ltr" class=3D"gmail_attr">On Tue, Sep 1, 2026 at 8:32=E2=80=AFPM Roman Bogo=
rodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
=C2=A0 Kostiantyn Kostiuk wrote:<br>
<br>
&gt; Hi Roman,<br>
&gt; <br>
&gt; Thanks for your patch, and sorry for the late reply<br>
&gt; <br>
<br>
Thanks for review!<br>
<br>
&gt; On Sun, Jul 19, 2026 at 7:04=E2=80=AFPM Roman Bogorodskiy &lt;<a href=
=3D"mailto:bogorodskiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Implement the &#39;guest-get-diskstats&#39; for FreeBSD.<br>
&gt; &gt; This implementation uses the devstat(3) library which is a part<b=
r>
&gt; &gt; of the FreeBSD base system.<br>
&gt; &gt;<br>
&gt; &gt; The build system is updated to link qga with `-ldevstat`.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodski=
y@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 qga/commands-bsd.c=C2=A0 =C2=A0| 127 ++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt; &gt;=C2=A0 qga/meson.build=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
&gt; &gt;=C2=A0 qga/qapi-schema.json |=C2=A0 =C2=A06 +-<br>
&gt; &gt;=C2=A0 3 files changed, 133 insertions(+), 3 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c<br>
&gt; &gt; index 94ff6fee6a..763db33c9f 100644<br>
&gt; &gt; --- a/qga/commands-bsd.c<br>
&gt; &gt; +++ b/qga/commands-bsd.c<br>
&gt; &gt; @@ -27,6 +27,9 @@<br>
&gt; &gt;=C2=A0 #include &lt;net/ethernet.h&gt;<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 #include &lt;paths.h&gt;<br>
&gt; &gt; +#ifdef CONFIG_FREEBSD<br>
&gt; &gt; +#include &lt;devstat.h&gt;<br>
&gt; &gt; +#endif<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)<br>
&gt; &gt;=C2=A0 bool build_fs_mount_list(FsMountList *mounts, Error **errp)=
<br>
&gt; &gt; @@ -178,3 +181,127 @@ bool guest_get_hw_addr(struct ifaddrs *ifa,=
 unsigned<br>
&gt; &gt; char *buf,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 #endif /* HAVE_GETIFADDRS */<br>
&gt; &gt; +<br>
&gt; &gt; +#ifdef CONFIG_FREEBSD<br>
&gt; &gt; +static uint64_t bintime_to_msec(const struct bintime *bt)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 return (uint64_t)bt-&gt;sec * 1000ULL + (((bt-&gt;=
frac &gt;&gt; 32) * 1000ULL) &gt;&gt;<br>
&gt; &gt; 32);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static void guest_diskstats_append(GuestDiskStatsInfoList ***tai=
lp,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct =
devstat *dev)<br>
&gt; &gt;<br>
&gt; <br>
&gt; Can we simplify pointer logic?<br>
&gt; For example, return GuestDiskStatsInfo* for devstat* and then append t=
he<br>
&gt; list in guest_get_diskstats.<br>
&gt; ***tailp -&gt; more pointers - easier to make a mistake or memory leak=
.<br>
<br>
Yes, will address in v2.<br>
<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 diskstat-&gt;has_ios_pgr =3D true;<br>
&gt; &gt; +=C2=A0 =C2=A0 if (dev-&gt;start_count &gt;=3D dev-&gt;end_count)=
 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 diskstat-&gt;ios_pgr =3D dev-&gt;sta=
rt_count - dev-&gt;end_count;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; <br>
&gt; In case start_count &lt; end_count, you have has_ios_pgr =3D true, and=
 ios_pgr =3D<br>
&gt; 0 (g_new0 initialized to 0=E2=80=99s)<br>
&gt; Is this expected? And in general, is this possible?<br>
<br>
That&#39;s an interesting question.<br>
`start_count` and `end_count` are uint&#39;s. It is possible that<br>
`start_count` will wrap sooner than `end_count`, so <br>
<br>
=C2=A0 =C2=A0start_count &lt; end_count<br>
<br>
But apparently the correct behaviour is still report the difference<br>
instead of reporting 0.<br>
<br>
devstat(9) describes that:<br>
<br>
=C2=A0 =C2=A0 =C2=A0start_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 Number of operat=
ions started.<br>
<br>
=C2=A0 =C2=A0 =C2=A0end_count=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Number of o=
perations completed.=C2=A0 The =E2=80=9Cbusy_count=E2=80=9D can<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 be calculated by subtracting end_count from<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start_count.=C2=A0 (sequence0 and sequence1 are used to get<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 a consistent snapshot.)=C2=A0 This is the current number of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 outstanding transactions for the device.=C2=A0 This should<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 never go below zero, and on an idle device it should<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 be zero.=C2=A0 If either one of these conditions is not<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 true, it indicates a problem.<br>
<br>
<br>
So it looks like the conditional is not needed. libdevstat in FreeBSD<br>
does not have it too [1].<br>
I&#39;ll remove that in v2.<br>
<br>
&gt; &gt; +<br>
&gt; &gt; +GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)<br=
>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 return guest_get_diskstats(errp);<br>
&gt; &gt;<br>
&gt; <br>
&gt; Any reason for this wrapper?<br>
&gt; I see it in the Linux implementation, but not for other commands.<br>
<br>
I followed the Linux implementation schema here. Apparently it is not<br>
necessary. Will address in v2 as well.<br></blockquote><div><br></div><div>=
Then let&#39;s drop it</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
1: <a href=3D"https://cgit.freebsd.org/src/tree/lib/libdevstat/devstat.c#n1=
547" rel=3D"noreferrer" target=3D"_blank">https://cgit.freebsd.org/src/tree=
/lib/libdevstat/devstat.c#n1547</a><br>
<br>
<br>
</blockquote></div></div>

--000000000000237835065a6f6f57--


