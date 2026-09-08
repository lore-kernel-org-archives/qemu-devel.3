Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EF9C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wJb-0002Wc-9z; Tue, 08 Sep 2026 09:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3wJZ-0002V9-JI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:56:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1x3wJV-0005Rx-EO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788875798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nWfJfl1G3S+YtzT/slaLmBYn3ZsytAc4ywzh0Jy0+UE=;
 b=Kvi1Kt5uLRs7pVz7IuqwlaYKBAcgx8dw0gma302yulFAUqe1ifN3O7/pPkVF+RLz9hYEmR
 iMMxZYhxR0dUosfft5sadMD3HA/6nxMgze+lIhVsLcWt1OEDdCS7DNTrsL5iUPly/SchHm
 yLo6DNhg9xR2onApqil1rEPRzLF9DEk=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-A4f0U2crOrmmwGsEL0nNLQ-1; Tue, 08 Sep 2026 09:56:37 -0400
X-MC-Unique: A4f0U2crOrmmwGsEL0nNLQ-1
X-Mimecast-MFC-AGG-ID: A4f0U2crOrmmwGsEL0nNLQ_1788875795
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ce3040ea9so5815514d50.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 06:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788875795; cv=none;
 d=google.com; s=arc-20260327;
 b=C7Od5JSa2MJQGD3gtnC5LyGWzzJNfz1E30T7TnGwpucD4KFFNoiLgPlcS7cOWFDYO0
 mT8pVsK2vEYQRhCCPhnquW5VPO/VSMQWVAmhVrg6VaJx81VHes4yPgOMXtl6cuK81/P1
 d6NwMVZwkPfzLW+LBLCE8pudzDLVSZc8WKyAP8jg8dGaGE9Pf13yuK8G0b7hQGuwva55
 DBl42H44NPHO28xQS0aC8RlVpY13mCqT1DsiVwb8K1f5JmqYSC/KABsF6BzykJSvfunn
 tMBaZpR8UqMn3JZEUxREnYlbkJncNHm/rZnLOlwSSdjv7xIJQgk6zbMWP7CaEzNXDpzm
 9z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nWfJfl1G3S+YtzT/slaLmBYn3ZsytAc4ywzh0Jy0+UE=;
 fh=7BenLOkexnzZXZeAX/W9eiWW1xYLfksBps3xitlKG8A=;
 b=lqDxF2AzrdyQKYD+9Rdo7YqhgT8O6+HlEfbUycMVT73Ba4hgwH6C7Bq5dXnhdG/4Ec
 XIfC5hq8jrMk7VR3rCAXVFqOu73EagOVLIcC3pLwKtw10l35ajBJA8RgoUi3N3Rdj/fD
 JYyTNpieNcrpjYuzY2tpkHaN06ZsukWcRhCUvKLDirK2MOCPhXC81q5yRDSqjY2RHUul
 rlwOWA4NVjzUh0SqaZjprOUaIQS+ggUWqXUbNbLywsu4DTKnjd67kFCW/QU2c+wl2rgU
 qbcAfCGh8JBMBnvbpTSugbsiPKaP33fK67PZFKIZb9d7hQ3RRiMJoXPX3O8x7Y9EqZcW
 yVKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788875795; x=1789480595; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nWfJfl1G3S+YtzT/slaLmBYn3ZsytAc4ywzh0Jy0+UE=;
 b=cLk4/JKcGE+ioddNebULIABXq7K46jTLL6J0gyznmDDuMHBM3nqvUa2w8QDWkPMRSb
 OrhS7bUpImkPf3s0vSfQNfw+gxP2OYEVKeFn8dBj5qeuJY8GXWshyGXhFaZsCfBl7/Fi
 eEODZdN0LLiCA+lJCEhis0E639MzWAEYF4fMO8NnI2fVwH2Hr+V3AizdIDUW1SDH0zLk
 7YHBdQ7qhCI2djW4MzFkUNLCIM3oo6rhHqi4vXxaBA/7tR3Hz2rli9U0vK8A2uRQMuby
 rvUbLTAyjMdOJboKPumuFtVOW7Osheing/bycL7/UAf44xtLn6Inzkp6LJo8pQ6YGsmv
 o5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788875795; x=1789480595;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nWfJfl1G3S+YtzT/slaLmBYn3ZsytAc4ywzh0Jy0+UE=;
 b=f6VHsHso1CDV+jZm52bU/t1Hywm4CGtQuzgO8TkP/zGkLsIWOJTqgY2pxrsrB/k5nF
 8dizpSs7AYgkUNHywYnzADk+5KVJ0ODVckQRqUMOhNkP/UF+2NIUeG+z/1FgakTCC1mW
 B9vDv0SujPzMY6XpBpbmwZj5tYIZnUnSsVIMv3RHIMVVw+078X2fVg+xa+yz5QVd58LX
 Q5Qr17qbY2pZ6rz6LbfB7H4hpJDpAZR0o0CQeZgI0cd5pqbMcfgycWCwyBewDonuYIyr
 XeqtvmBdiLUc3HTlH7UMHbpv+WuvOGHxvHpN9P91HXBAjF0glw2rsKqeT5/aXh6jWxri
 87Qw==
X-Gm-Message-State: AFuF++mG5oYOdImKZI7iL2hnudWJZD9UquqJaPNj+C75L6mFW2xSp5FC
 lyCksXjCm+WejGbCg3d+y5z1Masy5KlAbn6xQwZOFOGwkyvAomw53tV5AD7Zcz/VEhaZUA1G7n8
 80GXvkSNdawM5mn9p8KLD/r8dHRexwP98Ao7pWi3gDCF5ERTa06shgNQrNWCqJ2zyJjnmf5i2Ch
 KbDFR+X9LbvAnyvToL9s1kFKfN+CPZ35s=
X-Gm-Gg: AYBFou1/QOWsGmglAvBvZG+BUP6R78D4v6nz1km1IMC3+9+QFICyKU1xHMxT+n417ty
 ZAWNyuEy3GnghI0BiHA8MtNWRPfv+cXi4Q2PsruzmSGUFHQHWpstigiJ3RPqFM1NtydbB36QK4r
 nQhF+jrrcq3+ifwGB91J0RsuhmSuIWXUgC+63pTaMwYbvEaUcqOEIV8A97eAs=
X-Received: by 2002:a05:690e:44e:b0:66f:c1bc:4093 with SMTP id
 956f58d0204a3-66fc1bc4801mr4972633d50.86.1788875795439; 
 Tue, 08 Sep 2026 06:56:35 -0700 (PDT)
X-Received: by 2002:a05:690e:44e:b0:66f:c1bc:4093 with SMTP id
 956f58d0204a3-66fc1bc4801mr4972607d50.86.1788875794923; Tue, 08 Sep 2026
 06:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260714165759.7521-1-bogorodskiy@gmail.com>
 <anxADf6QF3lqzLLw@tulp>
 <CAPMcbCr9=tX=PKCiqOK=kPa70ccw3_WUArYepLYdUxvx5q0gmg@mail.gmail.com>
 <aqAOaBGmp5oOAIIT@tulp>
In-Reply-To: <aqAOaBGmp5oOAIIT@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 8 Sep 2026 16:56:22 +0300
X-Gm-Features: AcwNN1Xd7yvmKxexJh1y7SN6zVQsz0Duf0gZrwpq3xdF6wOSEed7EbXAsfg_ljY
Message-ID: <CAPMcbCqQN7ipZLK86A3X4jwitZoaXDH8McC5V9t=iU814QV-pw@mail.gmail.com>
Subject: Re: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004e6048065af91ad5"
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

--0000000000004e6048065af91ad5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I plan to merge this patch this week

On Tue, Sep 8, 2026 at 4:33=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gmail=
.com>
wrote:

>   Kostiantyn Kostiuk wrote:
>
> > Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> >
> > Will be merged after code freeze
>
> Hi Kostiantyn,
>
> Gentle ping on this one now that the code freeze should be over.
>
> > On Wed, Aug 12, 2026 at 12:43=E2=80=AFPM Roman Bogorodskiy <
> bogorodskiy@gmail.com>
> > wrote:
> >
> > >   Roman Bogorodskiy wrote:
> > >
> > > > Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> > > > To implement it, reuse build_fs_mount_list() which is already
> > > > implemented for FreeBSD. Extend the FsMount type to include
> > > > a string "fromname" attribute to store the disk the FS is mounted
> from.
> > > >
> > > > Disk mapping info is not covered by this implementation.
> > > >
> > > > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > > > ---
> > > > Changes since v1:
> > > >
> > > >  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> > > >
> > > > Changes since v2:
> > > >
> > > >  - Drop the unused 'errp' argument to build_guest_fsinfo() and
> > > >    clean up the related code.
> > > >  - Fix leaking string through g_strdup() for a g_path_get_basename(=
)
> > > >    allocated string.
> > > >
> > > >  qga/commands-bsd.c    | 53
> ++++++++++++++++++++++++++++++++++++++++++-
> > > >  qga/commands-common.h |  1 +
> > > >  qga/commands-posix.c  |  3 +++
> > > >  qga/qapi-schema.json  | 12 +++++-----
> > > >  4 files changed, 62 insertions(+), 7 deletions(-)
> > >
> > > ping
> > >
> > > https://patchew.org/QEMU/20260714165759.7521-1-bogorodskiy@gmail.com/
> > >
> > >
>
>

--0000000000004e6048065af91ad5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I plan to merge this patch this week</div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Sep 8, 2026 at 4:33=E2=80=AFPM Roman Bogorodskiy &lt;<a href=3D"m=
ailto:bogorodskiy@gmail.com">bogorodskiy@gmail.com</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0 Kostiantyn Kostiuk=
 wrote:<br>
<br>
&gt; Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.=
com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Will be merged after code freeze<br>
<br>
Hi Kostiantyn,<br>
<br>
Gentle ping on this one now that the code freeze should be over.<br>
<br>
&gt; On Wed, Aug 12, 2026 at 12:43=E2=80=AFPM Roman Bogorodskiy &lt;<a href=
=3D"mailto:bogorodskiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0Roman Bogorodskiy wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; Implement the qmp_guest_get_fsinfo() API for FreeBSD.<br>
&gt; &gt; &gt; To implement it, reuse build_fs_mount_list() which is alread=
y<br>
&gt; &gt; &gt; implemented for FreeBSD. Extend the FsMount type to include<=
br>
&gt; &gt; &gt; a string &quot;fromname&quot; attribute to store the disk th=
e FS is mounted from.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Disk mapping info is not covered by this implementation.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogor=
odskiy@gmail.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; &gt; &gt; Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
&gt; &gt; &gt; Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkosti=
uk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; Changes since v1:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 - Replace g_malloc0() with g_new0(.., 1) for GuestFile=
systemInfo<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Changes since v2:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 - Drop the unused &#39;errp&#39; argument to build_gue=
st_fsinfo() and<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 clean up the related code.<br>
&gt; &gt; &gt;=C2=A0 - Fix leaking string through g_strdup() for a g_path_g=
et_basename()<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 allocated string.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 qga/commands-bsd.c=C2=A0 =C2=A0 | 53 +++++++++++++++++=
+++++++++++++++++++++++++-<br>
&gt; &gt; &gt;=C2=A0 qga/commands-common.h |=C2=A0 1 +<br>
&gt; &gt; &gt;=C2=A0 qga/commands-posix.c=C2=A0 |=C2=A0 3 +++<br>
&gt; &gt; &gt;=C2=A0 qga/qapi-schema.json=C2=A0 | 12 +++++-----<br>
&gt; &gt; &gt;=C2=A0 4 files changed, 62 insertions(+), 7 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; ping<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://patchew.org/QEMU/20260714165759.7521-1-bogorod=
skiy@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/Q=
EMU/20260714165759.7521-1-bogorodskiy@gmail.com/</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</blockquote></div>

--0000000000004e6048065af91ad5--


