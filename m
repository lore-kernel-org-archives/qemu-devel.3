Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B02C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqZN-0002zM-2I; Thu, 22 Jan 2026 04:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1viqZL-0002ye-2t
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1viqZJ-0007Lc-2W
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769072492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mF5Kw0tJ/JaDynDKNn2r+DF4VV4EH0HLjp0Hsb1jQV8=;
 b=cw/qNkKb9zyLzVC7RwcR1PEze3Fu/ZPUF9YpONrDb4XzgVEPH7HNxJgXsBFoxi+bqnW38Z
 jbWextGSkquobb98btCvJQH/Y26sXJrZ0JQP2XQe6/wh7u1t2u3c1Minh0D/VfNXnaWzZk
 nrtozwI1UU1LwHOHV84G5KgzlsIQlzk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263--9jlZbZ4OJmhvC0qoVbWIw-1; Thu, 22 Jan 2026 04:01:30 -0500
X-MC-Unique: -9jlZbZ4OJmhvC0qoVbWIw-1
X-Mimecast-MFC-AGG-ID: -9jlZbZ4OJmhvC0qoVbWIw_1769072490
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c6a69b7813so191184385a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:01:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769072490; cv=none;
 d=google.com; s=arc-20240605;
 b=FHWSmOGimtDE0f4UMRQYb1uFXgxC1008AE1wY1TavJASyTdGczgFdvd+rl59+eLabW
 TofqEOvmzwIGi/9MUd015kqK/CFitpk6skA+cjkzoDx3UrdFB9b9jiS2qtGPyZAmGf1y
 NpluPjK+ROayyGfeHqO50qqt9kGHtS65v/8CsUkoHSA8QW0x/ldMVvbYa3CqoX+cRt0U
 1criHSe0jyrlQNqvlf6889Gu2d2cdGY/BzRXS4+ZIhYVe8Mwar/v7q35Boa8Wxv3xRgW
 NWLPZbdC25zz5pK3l4h8Bim3P+hL0UJfuBQ9LSML6IuQGYXgNqOi2yYQp7al9QtQ4/zo
 5CDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mF5Kw0tJ/JaDynDKNn2r+DF4VV4EH0HLjp0Hsb1jQV8=;
 fh=RQb6/9sMnP4wQOnMcErtFVCxILJK7yBnLmhI9F6/Gd0=;
 b=XxcAN6yA600hT5EClbbXCTdvXJYCH8YtpenZttvlMqyRaHxnAVtbBxvF0q7F0OWSmg
 mLVUQXKmohUasjDenqrO+t/vC1gbHPdRoejITsD+HOg4s2wasvZM7bRQSBuNFqRPjCnP
 JclZZ5yFp6pCPTLf0OHCRi7HDI4MW/Ke/tRNX155syO9uG4/suoBhe6V9BiquVM9oEt0
 34WnCHRCQcVeLi80WJlHVsafMRq7IkPcIspYqwWfNG4skV+T1iDxlONQ0FHbidwL7Xfp
 XVJz5cDj1NO0BdSsICB7mQWx+ftFm07bG9yYatKgFCmiUZsq8TXnauFxxC3lO5I/nzge
 sSpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769072490; x=1769677290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mF5Kw0tJ/JaDynDKNn2r+DF4VV4EH0HLjp0Hsb1jQV8=;
 b=Yi+ZGrAq8AzstE38JvOGG+x9GmBQJUdKaWSX8/EmUTR+rp3oEm9yd+5nnA745yCF//
 EyzbS5ltC9v2E16aHdHg6LMCAOJDaC8xBSRKI2uEW4skWbZ2BQA8wJa9InWrRrta/gfX
 Wcdzi8aNz5GljAvhucSiN2k1AUbH1M5FSRG/uoCyJdmv2aNI9CNHp1fLt9rUVbnBSNGE
 wMghywTAwuwkKKeSYunxW/GXt9XfqomI/A+nnF1CwlaZyBXF29YATyNny8SVKicY2PfP
 5HbYS85m6UInbxmz22oXHzraYeUglWhrijpV0Rd/q7f4+WURegzKmeUnGnrVFwggrmE1
 rePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072490; x=1769677290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF5Kw0tJ/JaDynDKNn2r+DF4VV4EH0HLjp0Hsb1jQV8=;
 b=T1nWS3QpZAktz7Y2ttWQ/fIlzEmQITgTrREkrdcPF0rBpYWFcB1t9T0oyzrJs5rU3i
 Yi2djdCUxFhPArK3zuvbysVFjycJn/XQVficR8SB2TNNaLLgP4DNmYLHK+iHv3b6w+Bd
 Ewnv/tb8Tm71doxgnpqf4sMypprGTH1fiokCzguC1XJ26SZ5/SCTrIeeXWt26e92r6ea
 ReI3q5INhVseTAwp58SS4wqYnvWdqyA8JgGwNN1V1FaC4qUlr5HdPMJGlFZDnBIMIAJB
 xptAvmUv7MHDaBq8ydkG2B91FLv726frR7esBqMaYbTF/hzzXxCMOGa83DcumJDQ65s6
 51aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWXPy4KwR5391dnZSYbLlp2PtcLiKeWUIwb7st41qHeJ3sNpdNFxAJdLDZVjko/3fTVjF0+4rWgRG@nongnu.org
X-Gm-Message-State: AOJu0YyPGYPaBhl6WjdXit2GQgIbujyxcVB/DT0WcSJaOps8bewfpA0O
 RQZyK7wjksZBjTACLePNJdphYjT8k0b9CQcN6GQf9i/V/IvH/8y4+xkhZeJTpIWCEvqvhkXPdCz
 6GqvkEmpl05p1NOnTqPHjCqfIxPWCM/0DDjCSIS5NPI9XIs6T7Yj7DGvFlcisGTvf+MOv/PCtgD
 882RjjYhs0fLwHpFQ1XyqCA3xzB47Th+k=
X-Gm-Gg: AZuq6aKi2LAaXL2hetI2uxQbFUPBXO1OQ5dSxAYcI+wuCeVz4VWiBjzD5mKHvEVel58
 tsE3Jb+i+NqM+ecpwQNpCCLr5oBeug/pNbRScweQU/ecG0RLmxOVRWa+i1fHCzHAtgZDoEt1GSK
 zjuAZ5NUAjmipZmVYytrL3tC2uMDrkw5S2jNkeVFhclOVEi3thx0M19kupIKjjjtZlIfJg
X-Received: by 2002:a05:620a:3727:b0:8b2:faa3:4c77 with SMTP id
 af79cd13be357-8c6a67fae4emr2814434185a.0.1769072489771; 
 Thu, 22 Jan 2026 01:01:29 -0800 (PST)
X-Received: by 2002:a05:620a:3727:b0:8b2:faa3:4c77 with SMTP id
 af79cd13be357-8c6a67fae4emr2814432085a.0.1769072489366; Thu, 22 Jan 2026
 01:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20260122040430.51001-1-wei.wang@smartx.com>
 <87cy32gh42.fsf@pond.sub.org>
In-Reply-To: <87cy32gh42.fsf@pond.sub.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 22 Jan 2026 11:01:18 +0200
X-Gm-Features: AZwV_QhWDFWYP0R_ESQ7Jn9IsaUZuQhaTl-NXDueVzWzjk_0LgJhberxED4V4ws
Message-ID: <CAPMcbCqVQtOxHPrsmVC316nV4sK11ERAGj2DXwdtyHVBabUvmw@mail.gmail.com>
Subject: Re: [PATCH] qga: Fix crash due to redundant error setting in
 qmp_guest_file_open()
To: Markus Armbruster <armbru@redhat.com>
Cc: Wei Wang <wei.wang@smartx.com>, qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000004f9c740648f6499a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--0000000000004f9c740648f6499a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 10:57=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Wei Wang <wei.wang@smartx.com> writes:
>
> > Avoid setting GError multiple times in qmp_guest_file_open() by checkin=
g
> > if errp is already set.
> > This prevents crash caused by repeated error handling calls.
> >
> > Signed-off-by: Wei Wang <wei.wang@smartx.com>
> > ---
> >  qga/commands-win32.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > index 0fd0c966e4..8c45ca5004 100644
> > --- a/qga/commands-win32.c
> > +++ b/qga/commands-win32.c
> > @@ -263,7 +263,9 @@ int64_t qmp_guest_file_open(const char *path, const
> char *mode, Error **errp)
> >      fd =3D guest_file_handle_add(fh, errp);
> >      if (fd < 0) {
> >          CloseHandle(fh);
> > -        error_setg(errp, "failed to add handle to qmp handle table");
> > +        if (!*errp) {
> > +            error_setg(errp, "failed to add handle to qmp handle
> table");
> > +        }
> >          goto done;
> >      }
>
> Can guest_file_handle_add() fail without setting an error?
>

I checked the code, and it looks like guest_file_handle_add always
set error if fail


>
> If yes, that's the bug that needs fixing.
>
> If no, the error_setg() here is wrong and needs to be deleted.
>
>

--0000000000004f9c740648f6499a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 22,=
 2026 at 10:57=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@re=
dhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Wei Wang &lt;<a href=3D"mailto:wei.wang@smartx.c=
om" target=3D"_blank">wei.wang@smartx.com</a>&gt; writes:<br>
<br>
&gt; Avoid setting GError multiple times in qmp_guest_file_open() by checki=
ng<br>
&gt; if errp is already set.<br>
&gt; This prevents crash caused by repeated error handling calls.<br>
&gt;<br>
&gt; Signed-off-by: Wei Wang &lt;<a href=3D"mailto:wei.wang@smartx.com" tar=
get=3D"_blank">wei.wang@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-win32.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
&gt; index 0fd0c966e4..8c45ca5004 100644<br>
&gt; --- a/qga/commands-win32.c<br>
&gt; +++ b/qga/commands-win32.c<br>
&gt; @@ -263,7 +263,9 @@ int64_t qmp_guest_file_open(const char *path, cons=
t char *mode, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fd =3D guest_file_handle_add(fh, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (fd &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(fh);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to add hand=
le to qmp handle table&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!*errp) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;fail=
ed to add handle to qmp handle table&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto done;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Can guest_file_handle_add() fail without setting an error?<br></blockquote>=
<div><br></div><div>I checked the code, and it looks like=C2=A0guest_file_h=
andle_add always set=C2=A0error if fail</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
If yes, that&#39;s the bug that needs fixing.<br>
<br>
If no, the error_setg() here is wrong and needs to be deleted.<br>
<br>
</blockquote></div></div>

--0000000000004f9c740648f6499a--


