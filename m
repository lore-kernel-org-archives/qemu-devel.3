Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517A0C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wusel-0007Jv-SN; Fri, 14 Aug 2026 10:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wusef-0007Jc-7b
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wuseb-0004ZB-6n
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 10:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786716779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVMothFpjIXo5xabxn5wH+Vfs/WsHrxNQ5uUvWZOEMU=;
 b=Azu5hdFbyD4DmZ80GT7NddJKkuO1cm9krizOVa+Xkbpb1hpOQAlMSIeJO3VoWw/JUYDNVZ
 e++OnLPW3Jv4iAW+/7rakG82TwhCTCuHFoQTeQkxDzLyTwXWGL1y86GHgCdo6vnkcL45EU
 7U30MTlksWD7yuk/+ljy35GF3kxNayI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ylIr-3J9MlWOl6_Rr99yiA-1; Fri, 14 Aug 2026 10:12:57 -0400
X-MC-Unique: ylIr-3J9MlWOl6_Rr99yiA-1
X-Mimecast-MFC-AGG-ID: ylIr-3J9MlWOl6_Rr99yiA_1786716777
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9080b7b2f2bso10874006d6.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 07:12:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786716777; cv=none;
 d=google.com; s=arc-20260327;
 b=AVPgoNAQXTkAwuf3OzXzlcx/FY5ZpO40n5Y1+8ZbWbeR2l6aBNzRhn1CJ+H0uqpv2v
 wVU7WyoQiXcWtALFCR7J2RMISmalr1dZbLYqdGRRfZylwIYRtC6kFnMxfehCfOrxxjqP
 RWJFpTBQHLB1w200p098hIYbnGcwcjsKwpMuN3viOiPjM2nL0iG4wI4Lkx/uO5HHtQam
 al/EfrbIXt4HCeftS+Oa4cuB6w+0ZHGsuR3qfvf9tfEX+DdbLoiR8j/Or/Tp+95py6ZK
 MRLAYKo0wxCKSXv1zAArBJW6+TWMAqRxozGY84Wj5CVmxj7xyAAlCk0tlphx6m8RA0+M
 mzZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PVMothFpjIXo5xabxn5wH+Vfs/WsHrxNQ5uUvWZOEMU=;
 fh=7BenLOkexnzZXZeAX/W9eiWW1xYLfksBps3xitlKG8A=;
 b=JQpfxtIFRK3MaIpa00F5L98HOf2eYzVyyk895FfO5a8wKfPLx1i55AtiOQ/gKmg9WS
 sWPUwq6oJVpbGNY3KGVSJyUSFZDUkZkqhan84rYrVGSIYYn8ltUabiW5JpiVt9PlTYpi
 ivZTFSBSFX2KdGE8XYJop9e+pS/sR5K7+1SnxM8hbZsNKX4hNeR8lCmOwxNQ9g35vuln
 SAOixBTPbLpoc/6POA3VXG4ut2pMx0cpCAWjDekC140f7emvtw+lrPK7forKehCW7ecS
 6RqRsxuMUY1Cbe6Xkjm4ezOTSPR+Aw1DAMllZP3/NL4yQm0nKrdHWjTmUBYbJ9iwssq3
 kOmg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786716777; x=1787321577; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PVMothFpjIXo5xabxn5wH+Vfs/WsHrxNQ5uUvWZOEMU=;
 b=bGLjx1vbd9807vzr8pqepk4GgKK1uGVnxs5YEIzWBfvKRU8i++yA/YqDgiD3mz40wN
 WOJLf9USOltDEZDka33zuuIe6BgijSbTLkopv3RHEB7x6Nv5FGcM6YOvWWyuqWsLKdxI
 lAxktD8JZfTeB2U8+8hJJkImd0Qq7rdpnXhqULQReG0zu1QNcsEGeDralkzFiAJsL6mK
 t/JHWBezO1tcmBEm7qanSYhE72zV/XdUUoLmIgXjbllQbdX1+esfQ5+MQA/bGGtuQ2ym
 w4ry98LFPy4n3jHAM4k2mOzsA+2mQgo7Gy2Sz7M78LCs7IlJsW0JvshTCtBVE4wiaYrO
 xu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786716777; x=1787321577;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PVMothFpjIXo5xabxn5wH+Vfs/WsHrxNQ5uUvWZOEMU=;
 b=EhVaNaePjxpE+sz1jScRR/OkhF/Vh2pqMV86jgDgbMrHzAQMJvtUYqiO0rCHrGcmEV
 GDIXmzIqf5tcpvx6rYf1pdpSKySqE10n2iCupR6IQgFePPZKBmf+dpXlieFB1Xf0h/TS
 HoQnzQfRWWacSykDdFgKMsAE5lsRsO1yQXG3eADJPt4TDD8fHZgkNaL3uQ9WcPUCjxm9
 OlB821QHNB6ASmAZbXdYbvK2LEyRWqDt6xG747jPIUx8xVjfYkkA8+Ni282q0HosChWr
 oDZhJXWBpQn4kX7OB9oXmJXTX1NsQXA+Zv0WHNbUzpVG+JcCcMsEgsGB8fQHD5T+FDn8
 zl/g==
X-Gm-Message-State: AOJu0YwtEZQfVRqeV8zDIKYQa3r9bu6BMK4vb4uSsXaj+CLFJNda52Tb
 3cdCbuA5N08jnimMtep32Zz3FBtPfKJpNDYoVx5mfEco8s5vEJChIrtvKvA62AGI70DThweDYsi
 /0jbEMlWuyjHZwcUnXxMWgduvuh++OoHcmn1IkPyWyFuygZ24fjk8wqz9cLZtUMjcWBb05M6Brx
 XHCtVKGOijkj9/MY3PlhmUwhPJx05Umio=
X-Gm-Gg: AR+sD12lT94uVmJqzYgmiXWhE+GlrYLuk+08lyYqoPctUqWN/vNM5LVi/GcGnMmlcNa
 EvbggzDn2f8ICzyem+jyrriQv4BIfv56Yo76iPEusK2n7QBZ8BntKr1oTpWJ7Uz3KR55amcSuDR
 kWVDXy7r3XZP18lJbNihhBLGx6jB2evC+TccR1jgLs/bjm75gdFjyQDcyiKzk=
X-Received: by 2002:a05:6214:5094:b0:8e5:d7d1:7bf with SMTP id
 6a1803df08f44-90a91cdc860mr59725516d6.4.1786716776775; 
 Fri, 14 Aug 2026 07:12:56 -0700 (PDT)
X-Received: by 2002:a05:6214:5094:b0:8e5:d7d1:7bf with SMTP id
 6a1803df08f44-90a91cdc860mr59724846d6.4.1786716776352; Fri, 14 Aug 2026
 07:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260714165759.7521-1-bogorodskiy@gmail.com>
 <anxADf6QF3lqzLLw@tulp>
In-Reply-To: <anxADf6QF3lqzLLw@tulp>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 14 Aug 2026 17:12:44 +0300
X-Gm-Features: AcwNN1Xje0cTlYW2uJYVIyc1NnLwYxxB2AkBK99ymfLaoSrtk1tZYruhcD_s1DE
Message-ID: <CAPMcbCr9=tX=PKCiqOK=kPa70ccw3_WUArYepLYdUxvx5q0gmg@mail.gmail.com>
Subject: Re: [PATCH v3] qga: implement 'guest-get-fsinfo' for FreeBSD
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c4e7670659026a68"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

--000000000000c4e7670659026a68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Will be merged after code freeze

On Wed, Aug 12, 2026 at 12:43=E2=80=AFPM Roman Bogorodskiy <bogorodskiy@gma=
il.com>
wrote:

>   Roman Bogorodskiy wrote:
>
> > Implement the qmp_guest_get_fsinfo() API for FreeBSD.
> > To implement it, reuse build_fs_mount_list() which is already
> > implemented for FreeBSD. Extend the FsMount type to include
> > a string "fromname" attribute to store the disk the FS is mounted from.
> >
> > Disk mapping info is not covered by this implementation.
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> > Changes since v1:
> >
> >  - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo
> >
> > Changes since v2:
> >
> >  - Drop the unused 'errp' argument to build_guest_fsinfo() and
> >    clean up the related code.
> >  - Fix leaking string through g_strdup() for a g_path_get_basename()
> >    allocated string.
> >
> >  qga/commands-bsd.c    | 53 ++++++++++++++++++++++++++++++++++++++++++-
> >  qga/commands-common.h |  1 +
> >  qga/commands-posix.c  |  3 +++
> >  qga/qapi-schema.json  | 12 +++++-----
> >  4 files changed, 62 insertions(+), 7 deletions(-)
>
> ping
>
> https://patchew.org/QEMU/20260714165759.7521-1-bogorodskiy@gmail.com/
>
>

--000000000000c4e7670659026a68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br clear=3D"all"></div><div><div dir=3D"ltr" class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div>Reviewed-by: K=
ostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redha=
t.com</a>&gt;</div></div></div><div><br></div><div>Will be merged after cod=
e freeze=C2=A0</div></div><br><div class=3D"gmail_quote gmail_quote_contain=
er"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 12, 2026 at 12:43=E2=
=80=AFPM Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gmail.com">bog=
orodskiy@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">=C2=A0 Roman Bogorodskiy wrote:<br>
<br>
&gt; Implement the qmp_guest_get_fsinfo() API for FreeBSD.<br>
&gt; To implement it, reuse build_fs_mount_list() which is already<br>
&gt; implemented for FreeBSD. Extend the FsMount type to include<br>
&gt; a string &quot;fromname&quot; attribute to store the disk the FS is mo=
unted from.<br>
&gt; <br>
&gt; Disk mapping info is not covered by this implementation.<br>
&gt; <br>
&gt; Signed-off-by: Roman Bogorodskiy &lt;<a href=3D"mailto:bogorodskiy@gma=
il.com" target=3D"_blank">bogorodskiy@gmail.com</a>&gt;<br>
&gt; Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.=
com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes since v1:<br>
&gt; <br>
&gt;=C2=A0 - Replace g_malloc0() with g_new0(.., 1) for GuestFilesystemInfo=
<br>
&gt; <br>
&gt; Changes since v2:<br>
&gt; <br>
&gt;=C2=A0 - Drop the unused &#39;errp&#39; argument to build_guest_fsinfo(=
) and<br>
&gt;=C2=A0 =C2=A0 clean up the related code.<br>
&gt;=C2=A0 - Fix leaking string through g_strdup() for a g_path_get_basenam=
e()<br>
&gt;=C2=A0 =C2=A0 allocated string.<br>
&gt; <br>
&gt;=C2=A0 qga/commands-bsd.c=C2=A0 =C2=A0 | 53 +++++++++++++++++++++++++++=
+++++++++++++++-<br>
&gt;=C2=A0 qga/commands-common.h |=C2=A0 1 +<br>
&gt;=C2=A0 qga/commands-posix.c=C2=A0 |=C2=A0 3 +++<br>
&gt;=C2=A0 qga/qapi-schema.json=C2=A0 | 12 +++++-----<br>
&gt;=C2=A0 4 files changed, 62 insertions(+), 7 deletions(-)<br>
<br>
ping<br>
<br>
<a href=3D"https://patchew.org/QEMU/20260714165759.7521-1-bogorodskiy@gmail=
.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/202607=
14165759.7521-1-bogorodskiy@gmail.com/</a><br>
<br>
</blockquote></div>

--000000000000c4e7670659026a68--


