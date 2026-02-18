Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54176E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsl4h-0003hh-Lo; Wed, 18 Feb 2026 12:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsl4e-0003hL-3M
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:10:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vsl4b-0004AJ-RY
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771434648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yZOYREIGtRPX+8pY2LD675Ku519rx5HQrWS7PHdYO4=;
 b=UNNIIHkWqWLCApXC4YT8EITWwN4CtrDSCXbMW0R+TrzcpENk1NYKa4eP0P6UlnUEZb+hU4
 ioHRBJVfz4itHkteY4eY/pB6D5YaDLpg9RX3+wcZXV6h7YeeqT+SRDlyF6DAc1NVvrdrIm
 hKMw7dkDvbx9kgOEQsYhGgwhqM05yx8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-RbUQzzDRPpOL2QotD6zmtQ-1; Wed, 18 Feb 2026 12:10:46 -0500
X-MC-Unique: RbUQzzDRPpOL2QotD6zmtQ-1
X-Mimecast-MFC-AGG-ID: RbUQzzDRPpOL2QotD6zmtQ_1771434646
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64ad6073938so7155590d50.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 09:10:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771434646; cv=none;
 d=google.com; s=arc-20240605;
 b=FKlNp/pbQWm0oq6Kyz35wqGcbDvBHNZmeeDlF21LpN/KleID537t6IliQa8+d7+xuv
 P17cJWKQJ9ZuThk8QDjUNtx1O4yKIPt/OfLhj8+4rdDZlBRa8kx33Da3+MV0QG4LAdME
 BcaF0o1W7m9ICStxBEBKmZgNPVwUNW9lRxyg8o0Gkoekbkp2U3hLqLohtr3JQJoO0oe2
 sfVt5QU1/xzl5pjPYBUiS7FvwYnrdPuzmyoSXMb1chL6yzz86Fibn/X+PLh/QM5vd/lR
 TVRDQrLO1iNxUxZQHI1ZAL6TOhmeuZR+tPsITDSSjZHAiaj8NPPI0DEHwg4I+X16YI6q
 9ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7yZOYREIGtRPX+8pY2LD675Ku519rx5HQrWS7PHdYO4=;
 fh=EsIWcOWKjuJZ8l9VUz5dq7PTh/G/+K2s19IZmZo75Jc=;
 b=Hvlbmm5SwP26rv+eNbs1Xy43kt8GXl5ueYLFEdDsQJEhRkeF573+3qSoWmPOfCY2oA
 IzdlwUlRO0G0B3ayG2q68QcoFb7zCGtrg8rIx1Yoh7qxtArkYx4EXLfFWiZTfvjc+mvn
 ged7qsP+4XSJmPN0bWauG8d0Q8AY85at2/p/HQfAEzLiTMm1nIlFv4IpHIF9D039iw61
 r2VokFb/W23EsAzw8oCO4yt7FNFFoxnZmO95cqd0MJ121M31mXHwSfvJ20om/aaCbqiX
 /XtTCbmi2SN844cyTxJ17md7yeKMBo+W0qfpE1+I1s7Xy81myMq8Aqca58gqfxceS8tJ
 +Ing==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771434646; x=1772039446; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yZOYREIGtRPX+8pY2LD675Ku519rx5HQrWS7PHdYO4=;
 b=Pxl1tfcgBCpNKoBWcKHU49EItP2haGdB47IIkyt6DjmlJNy8AkmfPEuV2uk1BpCvzQ
 0tFb3QacEKpumuawASU1lb9mN0jmfvuWMjVVlO7/vkiK/oBcxaU3tbYQ53T+cBw1S4FJ
 b4AJ8qDDRmuUY3DU6nh1lTnDXT690WQeLL1u+fMj7KvsokIkn2iHZeXxJflWudqFK04w
 fwjGmU+bsVpX7idG+QBz/IzC3bv62vT4RYrbaKzBecHNC+IVWS5bzgmazV1ktFGpzWRd
 stSEnF+/Kl5pVhj6KzmHi9cXqxTnDUyJM+HcCN2jhXrPqnVMZN7Ro77ykqrHnWxkM/mO
 pwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771434646; x=1772039446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yZOYREIGtRPX+8pY2LD675Ku519rx5HQrWS7PHdYO4=;
 b=IvH0yrvUskPOGzx1g/6N7TZ2TEC13F+AcLEtkFm5HyAv5u8ucNxJSD2fOeiSFJa3ci
 TTOV/M5hSqThCx8KSyaoYPoinUqhDsirhsGCW6MROj36+YjeXVY+qdhA3qpgSnk75k2J
 7BDDxxsY2E/AHdJRD+GdRY8EGnsAWt/i1JxTK67R9d0kgID9fVFr3rT1rnr7Tf+k/9Ap
 owRd47fdfytH75cgaNm2iVE37758mNC1HD1uoYqnpLa+hDzs7AmxGO1QOlU3N0q6mRLG
 dpf665zJDGFQF4CZeYn0QdA6WjXPXIpdwQs7nkJOZOK3KKkPL03P9mkJGSODfo2Frhh8
 t5+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpcNT4O6CJMEMy6IAFXmUwPB1GsBD9roETS5fZO9Ct+6uKXws/Ve6heJDFX3bOFJGlUOweE4XKt3Xh@nongnu.org
X-Gm-Message-State: AOJu0YyfP87j2Bnn4N60K3QuBxq7bYY5czLop3wkwphTj6H74VXSiiZb
 4AHRAvH/sa/2gULu27gGaJZlACn+9VbzUAmzGJ0v+vza9v9f9Gzn7K/rzi28witQvrXuu7ufFY2
 euLQDGYpkDTN3NLVkDWkm53pCSpuvPy5WxFOH4Fgo5zgUyEXxXx9i7z0/Nxug9BU6NdSiPBbysp
 r/Yj18jvxh9aQ/d1oSYV/6c7TNRVIZ1DI=
X-Gm-Gg: AZuq6aJJdzFraicPyZ2NBS+Bl0FtUH24pmE2SI8H6i3x6YNjOHeARZkvWBRVVi9RauN
 o9n8oIfEhgUc5kfoFWWTZufb7DBI5MIxkD+uukqrQLXE4o04XLuptAOrcn/6W3iiNg8lrK9L4pl
 XzXoKexvJqbhgR8miWGkPwFD6TlrkhYdrVfJtLvRGuj+mW0hXuzBA8ZRFIiEn32fuKx9KHSSZdd
 OBb3quEuFvBVtZedLPNPbVsvQJe9uvbM3OTkg==
X-Received: by 2002:a53:cc8d:0:b0:64a:e5dc:bbb9 with SMTP id
 956f58d0204a3-64c21b713afmr8956947d50.75.1771434645991; 
 Wed, 18 Feb 2026 09:10:45 -0800 (PST)
X-Received: by 2002:a53:cc8d:0:b0:64a:e5dc:bbb9 with SMTP id
 956f58d0204a3-64c21b713afmr8956923d50.75.1771434645449; Wed, 18 Feb 2026
 09:10:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFn=p-YGckyEF8GCOviMJ-FfWsM_dDa6nqEBJChPmUxP7Ydi_w@mail.gmail.com>
 <87wm0afsnh.fsf@pond.sub.org>
 <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
In-Reply-To: <56a8affc-e786-4dc8-81bd-c1f78a224afd@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 18 Feb 2026 12:10:34 -0500
X-Gm-Features: AZwV_Qip-cxSCFExB79gbiyZncvsyZXoiWGyR53tNbxSGQMiIo-wvJxwIOvueE0
Message-ID: <CAFn=p-YqRu3eaR+RvpCi3uaq8Y7s0pGtXwOLztqMDCqYG6McPA@mail.gmail.com>
Subject: Re: CentOS 9, Python, and other Fairytales
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c981a0064b1c44be"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c981a0064b1c44be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026, 6:48=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> w=
rote:

> >> With most of the new sticking points being debian 12 (EOL in June) or
> >> FreeBSD (timeline uncertain for when they'll re-modernize their python
> >> stack)
> >>
> >> One edge case here, however, is Sphinx, which does not actually have a
> >> modern package in centOS stream 9.
> >>
> >> CentOS currently ships 3.4.3, but it would not be usable if using the
> >> optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian 12
> >> have sphinx 5.3.0 to offer us, which is a reasonable version jump, but
> >> it means that CentOS would not be able to build docs unless you
> >> enabled `--online` for configuring QEMU or sideloaded Sphinx
> >> otherwise.
> >
> > CentOS 9 reaches end of life on May 31 next year.  I do not think
> > keeping its ability to build bleeding edge docs offline out of the box
> > for its final year (give or take) is worth your time, or anybody's.
>
> That's exactly the reason why we (John and I) introduced mkvenv.py,
> except it was CentOS 8 and SLES 15 at the time
> (https://www.qemu.org/2023/03/24/python/):
>
> "Some of these tools are run through the python3 executable, while
> others are invoked directly as sphinx-build or meson, and this can
> create inconsistencies. For example, QEMU=E2=80=99s configure script chec=
ks for
> a minimum version of Python and rejects too-old interpreters. However,
> what would happen if code run by Sphinx used a different version?
>
> This situation has been largely hypothetical until recently; QEMU=E2=80=
=99s
> Python code is already tested with a wide range of versions of the
> interpreter, and it would not be a huge issue if Sphinx used a different
> version of Python as long as both of them were supported. This will
> change in version 8.1 of QEMU, which will bump the minimum supported
> version of Python from 3.6 to 3.8. While all the distros that QEMU
> supports have a recent-enough interpreter, the default on RHEL8 and
> SLES15 is still version 3.6, and that is what all binaries in /usr/bin
> use unconditionally."
>
> So yeah, there's precedent for doing this, and it's the right thing to
> do anyway.
>
> >> My plan:
> >> - Wait and see what happens after the current QEMU release
> >> - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)
> >> - Gleefully drop Debian 12 in June
> >> - Hold my breath and see if FreeBSD happens to modernize by this point
> >> (They have until October 2027 to do so, so it's a dice roll if they
> >> will or not)
> >> - Do a big round of Python modernization all at once; either to 3.11
> >> or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray for
> >> forgiveness that I am removing CentOS stream 9's ability to build docs
> >> offline so I don't have to wait another six months and then do another
> >> big cleanup round
>
> The main nice features of 3.12 are improved f-strings, which are nice
> but not really a necessity.
>
> If I read it correctly, https://www.freshports.org/lang/python says it
> has 3.9 on PPC and 3.11 elsewhere, but
> https://www.freshports.org/lang/python311 says 3.11 exists on PPC as well=
.
>
> I'd go for 3.11 and Sphinx 7.  For FreeBSD we can require Python from
> Ports.
>

freebsd ports is currently at 3.11, which is the main reason I am saying
"see what freebsd does by June"

if they update, we can have Python 3.12 and Sphinx 7.x. If they don't, we
get 3.11 and 5.x. Both are good jumps, but on the chance I can make the
bigger jump, I'd rather do it in one round instead of two.


> Paolo
>
>

--000000000000c981a0064b1c44be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 18, 2026, 6:48=E2=80=
=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">&gt;&gt; Wit=
h most of the new sticking points being debian 12 (EOL in June) or<br>
&gt;&gt; FreeBSD (timeline uncertain for when they&#39;ll re-modernize thei=
r python<br>
&gt;&gt; stack)<br>
&gt;&gt;<br>
&gt;&gt; One edge case here, however, is Sphinx, which does not actually ha=
ve a<br>
&gt;&gt; modern package in centOS stream 9.<br>
&gt;&gt;<br>
&gt;&gt; CentOS currently ships 3.4.3, but it would not be usable if using =
the<br>
&gt;&gt; optional 3.12 upgrade. If we ignore this, both FreeBSD and Debian =
12<br>
&gt;&gt; have sphinx 5.3.0 to offer us, which is a reasonable version jump,=
 but<br>
&gt;&gt; it means that CentOS would not be able to build docs unless you<br=
>
&gt;&gt; enabled `--online` for configuring QEMU or sideloaded Sphinx<br>
&gt;&gt; otherwise.<br>
&gt; <br>
&gt; CentOS 9 reaches end of life on May 31 next year.=C2=A0 I do not think=
<br>
&gt; keeping its ability to build bleeding edge docs offline out of the box=
<br>
&gt; for its final year (give or take) is worth your time, or anybody&#39;s=
.<br>
<br>
That&#39;s exactly the reason why we (John and I) introduced mkvenv.py, <br=
>
except it was CentOS 8 and SLES 15 at the time <br>
(<a href=3D"https://www.qemu.org/2023/03/24/python/" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://www.qemu.org/2023/03/24/python/</a>):<br>
<br>
&quot;Some of these tools are run through the python3 executable, while <br=
>
others are invoked directly as sphinx-build or meson, and this can <br>
create inconsistencies. For example, QEMU=E2=80=99s configure script checks=
 for <br>
a minimum version of Python and rejects too-old interpreters. However, <br>
what would happen if code run by Sphinx used a different version?<br>
<br>
This situation has been largely hypothetical until recently; QEMU=E2=80=99s=
 <br>
Python code is already tested with a wide range of versions of the <br>
interpreter, and it would not be a huge issue if Sphinx used a different <b=
r>
version of Python as long as both of them were supported. This will <br>
change in version 8.1 of QEMU, which will bump the minimum supported <br>
version of Python from 3.6 to 3.8. While all the distros that QEMU <br>
supports have a recent-enough interpreter, the default on RHEL8 and <br>
SLES15 is still version 3.6, and that is what all binaries in /usr/bin <br>
use unconditionally.&quot;<br>
<br>
So yeah, there&#39;s precedent for doing this, and it&#39;s the right thing=
 to <br>
do anyway.<br>
<br>
&gt;&gt; My plan:<br>
&gt;&gt; - Wait and see what happens after the current QEMU release<br>
&gt;&gt; - Gleefully drop Ubuntu 22.04 in April (Allows Python 3.11+)<br>
&gt;&gt; - Gleefully drop Debian 12 in June<br>
&gt;&gt; - Hold my breath and see if FreeBSD happens to modernize by this p=
oint<br>
&gt;&gt; (They have until October 2027 to do so, so it&#39;s a dice roll if=
 they<br>
&gt;&gt; will or not)<br>
&gt;&gt; - Do a big round of Python modernization all at once; either to 3.=
11<br>
&gt;&gt; or 3.12 depending, and either to Sphinx 5.x or 7.x depending, pray=
 for<br>
&gt;&gt; forgiveness that I am removing CentOS stream 9&#39;s ability to bu=
ild docs<br>
&gt;&gt; offline so I don&#39;t have to wait another six months and then do=
 another<br>
&gt;&gt; big cleanup round<br>
<br>
The main nice features of 3.12 are improved f-strings, which are nice <br>
but not really a necessity.<br>
<br>
If I read it correctly, <a href=3D"https://www.freshports.org/lang/python" =
rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.freshports.org/=
lang/python</a> says it <br>
has 3.9 on PPC and 3.11 elsewhere, but <br>
<a href=3D"https://www.freshports.org/lang/python311" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">https://www.freshports.org/lang/python311</a> sa=
ys 3.11 exists on PPC as well.<br>
<br>
I&#39;d go for 3.11 and Sphinx 7.=C2=A0 For FreeBSD we can require Python f=
rom Ports.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">freebsd ports is currently at 3.11, which is the main reason I am=
 saying &quot;see what freebsd does by June&quot;</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">if they update, we can have Python 3.12 and Sphin=
x 7.x. If they don&#39;t, we get 3.11 and 5.x. Both are good jumps, but on =
the chance I can make the bigger jump, I&#39;d rather do it in one round in=
stead of two.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div></div></div>

--000000000000c981a0064b1c44be--


