Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8240D10A88D4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nTu-0007E4-FR; Thu, 26 Mar 2026 12:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5nTp-0007DL-Ab
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w5nTn-0007nl-NB
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774542161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0HyIzol5lG5zsvpnpa2fCpkqMRf9zjB9Zr06lCEYD+4=;
 b=EGmwE0XCbo3Ah7BNv5duNvQk+BMVELJK8D3wKEEWl7KjE/2hiGOZbvvXQvjA+mEks0ZLO9
 bCnqp4XTl13abSFWRxVT4ZaVEQyyDK2o6IIfhWd2UDivM0rB/NNvLCQaJ9SCoxkK9FJeK4
 9gwKxURg517zCzFLF8ACTvYbvfzFa5o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-qe4poWCGPwShsdOuJj2N3w-1; Thu, 26 Mar 2026 12:22:39 -0400
X-MC-Unique: qe4poWCGPwShsdOuJj2N3w-1
X-Mimecast-MFC-AGG-ID: qe4poWCGPwShsdOuJj2N3w_1774542159
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a0013d87bso52301676d6.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542159; cv=none;
 d=google.com; s=arc-20240605;
 b=Kx266J8BvbL1CkV1PhkBKWYxdjStjPgK6999oYnfP8/9e0AZOMLdtcLckUSGZVUIOS
 sot/7/WBcVgZiEn+/zWZ3n1UlTaFGxyexWKlknWlHGIDUkRfSMWSPJvqUjGosfeT5Pq6
 XJQr32iH+HeDPdZs/BXZO1iNuHycU4J0+R97XcTuAn0NwsTuz6QB62A4xjbD3va/l+1P
 J19n4TQUkHpVX6WUuGOvolBMedotSi+5VT/etv0Zpi4MIDSKxGkkuHg6CltPban6878T
 EW8Xi9wngftn4bFIFNJx1KuIPGrfgktnJMfs4ecJ7nuRAzjguFGDWVEZUYRDkwhvitLV
 PoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0HyIzol5lG5zsvpnpa2fCpkqMRf9zjB9Zr06lCEYD+4=;
 fh=nwp2bTnwiDDlym3zubbK19oED52DUA9W8gFPhWxh01U=;
 b=QGoHYjZNR+5EPN6rLoLMHpgzfTAlyuLCotkk4AXj68Tklvwf7I9Wr/F6k93isf3kpA
 3wcIZH8zqZZTy1HSCUAwBaNZaj8CqJc842eA6gMGD7j0eiliKSAcmD735wPPFUbvHlb7
 dvA+cJLWJn7aMQq3KuCXLP6vt7eUzBturzRYSvoF5wk9hs/DODHxUWRdwO9LCOvkCvhc
 XfyiO3Kwv3es0X/h4SZ/d46SolTlllkkL/RiVRfUHMB9A+wfpYWLPd2B0ha2+fuoSI00
 CktGtUDkhB+wg+wevJmF0aNBgt+k1I/UjkB+UnEyJdLDgmG0cKqrxOFH4pxTIDXQdICf
 hlMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774542159; x=1775146959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0HyIzol5lG5zsvpnpa2fCpkqMRf9zjB9Zr06lCEYD+4=;
 b=bwTpiCd59MYbrhF8PwiTtqn7A9CDrrNa0oGw26QOzxabxFYpkyLhFv/edDhv8fph56
 6o4c0ZUPTOu8zvZ/bsEbwBw6Qa5DGR7m9KJLzbSP9cal97VlDTe5oOTy5lgbTvsdu8/E
 y4jQn9lWAzIOfTJ/+o9PUkoMoJnPbfJDc6QjPFXmHHHPUZMrTeJu7+JZTyiKFDd1ivBq
 woKesDGUg+7thBqfGCQuJe4fqshTc7DW5Q7YxQwQRPh08gUvRjWGBeYLbF5hqQh9oy//
 m656kYHh4c9VbBMP4nZOYbaNWCglbFq8kKJZyVXFwB7T1gM34Eh4x4sIg4XjYCcZn1Ub
 Zgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774542159; x=1775146959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HyIzol5lG5zsvpnpa2fCpkqMRf9zjB9Zr06lCEYD+4=;
 b=ULYOIxh9ozDYCLaP9wKB/wBxTYWk9tb5LKFIuGll4cS2OM8G3CN3kVGIuOl/XcT3Td
 hkUPnDfN8UOf3HsV2+K0YTaDxwcrEUDH4mLlOA8z8hxbHHjZqXHrQuKNx8+fwvOzSzVl
 U0WoG04Vz/QuKE/ZuPlI2tigqSInv/xlrMotihZczqyUFo5+h4M+kjK7X1GjSFBWSu2u
 XP/iIHP4Gy07LCPcMGgeYUT2sC6MUi3cLgaV2lNFGSxgxEJUKVdhbNzL/WN+RvrAVqZo
 ZQ0bA5HTt0vrsWCs6ieE1p2l+GXVuTD1zdPQA+MiVsLTQgERqDV68FypWL1EvwShkdzo
 rFcA==
X-Gm-Message-State: AOJu0YzrOI470VI1DCXmltfEHSKJ9b/68UbFcSmHPs4dunIobtmaTY/7
 xLEq3bDzxxK/YfyfJEs+UGuLmmsv2oMG/hH+JGmbE/rY6+Th81KLTqxxFEbQS/S1BGZiYPhHmLZ
 i1zVfxNxmoYwLPa+YgC3Kk2QCnqhbgZ0oDjS3Eohzf8m2xyGGa8N/pT0xjC1lt6ykoZZzYjaDRH
 aMV2NgO7V57FJRLS2QNTVJQ6NX0VdNkKI=
X-Gm-Gg: ATEYQzy/AD1OEVcIS/BbjfqSNysf+8ecIht2f8G7D5ReMYBDyKDzFUEqKEXm9Lp2HdC
 OIvAScvDg6C5azzzteDg0AW22TeeXIYSIBvJk6YYZzBguACQCvnSjk+cMKMDe8G4EAvm1TL48Wo
 lf9+nI6lrhFsQ/n9D6/alUZ5GSb9vyJgO9KPoAu8eNkKN91hsHqtuworJ6zXAsm3FuHxNg/JVat
 CssSsQU
X-Received: by 2002:a05:6214:5508:b0:89c:ae4c:39c5 with SMTP id
 6a1803df08f44-89cc4987516mr140565006d6.11.1774542159066; 
 Thu, 26 Mar 2026 09:22:39 -0700 (PDT)
X-Received: by 2002:a05:6214:5508:b0:89c:ae4c:39c5 with SMTP id
 6a1803df08f44-89cc4987516mr140564316d6.11.1774542158519; Thu, 26 Mar 2026
 09:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-6-kkostiuk@redhat.com>
 <CAFEAcA8+qpP=TfSY3oa_2jpH2vD+ot7UxSnVWJCqUVshOCZbNA@mail.gmail.com>
In-Reply-To: <CAFEAcA8+qpP=TfSY3oa_2jpH2vD+ot7UxSnVWJCqUVshOCZbNA@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Mar 2026 18:22:27 +0200
X-Gm-Features: AQROBzCZ0qstdYlzttEJFzPg2ukqnYPe6ALow26r0VIRAeRs6nCXGZ8H1jfOL5U
Message-ID: <CAPMcbCp7GTnH=tJtDkJVFb_hfR_p3uaZV-XcwNdWbQqnH6+VSg@mail.gmail.com>
Subject: Re: [PATCH 5/7] Remove unused sys/param.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ff74ba064defca75"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000ff74ba064defca75
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

This is a very old commit. I tested removing sys/param.h based on 512b794b1=
09
(Update version for v11.0.0-rc1 release).
The full QEMU tree was compiled successfully, so I am not sure why we need
it.

Best Regards,
Kostiantyn Kostiuk.


On Thu, Mar 26, 2026 at 6:17=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 26 Mar 2026 at 16:02, Kostiantyn Kostiuk <kkostiuk@redhat.com>
> wrote:
> >
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  util/path.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/util/path.c b/util/path.c
> > index 72a255890e..e1565894d2 100644
> > --- a/util/path.c
> > +++ b/util/path.c
> > @@ -4,7 +4,6 @@
> >     The assumption is that this area does not change.
> >  */
> >  #include "qemu/osdep.h"
> > -#include <sys/param.h>
> >  #include "qemu/cutils.h"
> >  #include "qemu/path.h"
> >  #include "qemu/thread.h"
>
> We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which
> basically completely rewrote the path handling); I think that
> was likely why we wanted param.h.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
>

--000000000000ff74ba064defca75
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0Peter,</div><div><br></div><div>This is a ver=
y old commit. I tested removing=C2=A0<span class=3D"gmail-im">sys/param.h b=
ased on=C2=A0</span>512b794b109 (Update version for v11.0.0-rc1 release).<b=
r></div><div>The full QEMU tree was compiled successfully, so I am not sure=
 why we need it.=C2=A0</div><div><br></div><div><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Be=
st Regards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Thu, Mar 26, 2026 at 6:17=E2=80=AFPM Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, =
26 Mar 2026 at 16:02, Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@red=
hat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 util/path.c | 1 -<br>
&gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/util/path.c b/util/path.c<br>
&gt; index 72a255890e..e1565894d2 100644<br>
&gt; --- a/util/path.c<br>
&gt; +++ b/util/path.c<br>
&gt; @@ -4,7 +4,6 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0The assumption is that this area does not change.<b=
r>
&gt;=C2=A0 */<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -#include &lt;sys/param.h&gt;<br>
&gt;=C2=A0 #include &quot;qemu/cutils.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/path.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/thread.h&quot;<br>
<br>
We dropped the use of PATH_MAX in commit f3a8bdc1d5b26 (which<br>
basically completely rewrote the path handling); I think that<br>
was likely why we wanted param.h.<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div>

--000000000000ff74ba064defca75--


