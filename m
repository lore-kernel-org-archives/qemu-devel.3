Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC366CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uliJp-0000se-Fx; Tue, 12 Aug 2025 02:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uliJJ-0008SY-Au
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:16:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uliJF-00053Z-0L
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 02:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754979386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ls3mZEixJglTtJfcXdPDiePRuTtqbFD6CoBnDwtFEzo=;
 b=FabFLqLvb4EGBowY5FTOSnm5BsdtVGzFxohKKcEfjg6mAKv7P4f803cD09wVYa7c6zinLk
 4XfA0P0n2CHpj1mXgV8n+GsMT2g5IFSsa+teGzLEw59VG/mFUWFssOeyF+RJvruWTWrm8y
 8BFE4fRNcHUsGj/zl/MQxO4ijUf39OU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-bQVZ_GqMNcKcqEgoydP5zA-1; Tue, 12 Aug 2025 02:16:25 -0400
X-MC-Unique: bQVZ_GqMNcKcqEgoydP5zA-1
X-Mimecast-MFC-AGG-ID: bQVZ_GqMNcKcqEgoydP5zA_1754979384
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-459d5f50a07so28792175e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 23:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754979384; x=1755584184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ls3mZEixJglTtJfcXdPDiePRuTtqbFD6CoBnDwtFEzo=;
 b=j9LPSCtPcUo2btQkCx8c4ZdnyCoLMhfZkAZc1a5+MDCu23ilA5g8wTB1ekYdFsVFkm
 752FPy7dOIhNuf4Aax9Qw0Rhugw9B4MNOh/Ba/1igq/pUKEuJEmrNvx1vXpfTZgG4/D7
 Iq2rMvI0t1ItPH7ndi4cOh1Wxjab1Dfu52D/N57a0SJdi+Lv1sJvQxQLkdS/VPbtFzdr
 idSUMB96F01ZP1o266Xk/jgdL/z5k+IINyDsHsaRMBvjCwDFN2Tr2+FGmHnsDfHORAGx
 0tW7sfdoOgow2d284PXyrmrWB/1GUn1w+lX9Ljht+MfwbxKWnmFduxnYxvyXoI1PSWmv
 kQMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD60Jtm7aQQozmzmqSgfshu5rQqQ9f4EtOYw3XwWnwGrPZ9whBNkpXN4nQIG9cx1rhcYd9zwu6A3uk@nongnu.org
X-Gm-Message-State: AOJu0YxMXn08GsJFSD/8Evk6RLw8W/P5B156W+CMrIPuMcKd0d8synWF
 RhFazOwD74zMN0hQ0YACbxC5TAzIFr8gSZ9EnGGnbGQAPoYZl1cF8kq3kHKV+CSuOrwTkGxmSCc
 BWgYooTCgMuYauionV04b6A+IJXVxN54iSI108xoyGwUeY7JqXYSUl5SF1Rkvx9VHV8MoRyqXKP
 ui1aefmStRXNyCNfJ3hfNVxoxWYhs5mjk=
X-Gm-Gg: ASbGnctydi8rA/XvxK5pKMMQLKiGAMq2pIG9WLLe287hjdPEc5z8LnsIlcBgM1/n9fS
 PfsGeE2KWTuTCi32hHicfGGc72htkPQFrKbeBJxp+noq7kMviijpOLDwL0vdWLzg+9WkGe6zBLm
 Z5pSOHScE+RfXlnQ7ynvduag==
X-Received: by 2002:a05:600c:314f:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45a10c127fbmr19004025e9.30.1754979383734; 
 Mon, 11 Aug 2025 23:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz3gAfdH8TbXWssiDNwp3FAN1P6uOafQ1JN9/jj6Os7NYWAubwA9sT06VKnHgGwThG7YKsv23Q6Yza6yZ7La0=
X-Received: by 2002:a05:600c:314f:b0:456:1d61:b0f2 with SMTP id
 5b1f17b1804b1-45a10c127fbmr19003775e9.30.1754979383305; Mon, 11 Aug 2025
 23:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250811190159.237321-1-jsnow@redhat.com>
 <CABgObfZ5izVnO1ZNGEstr55Lko0P4vzuOjaC=Ddy-xgh_hhRwA@mail.gmail.com>
 <6ef750a2-915f-4fc5-8b50-f92712fa800f@tls.msk.ru>
In-Reply-To: <6ef750a2-915f-4fc5-8b50-f92712fa800f@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Aug 2025 08:16:11 +0200
X-Gm-Features: Ac12FXwvwG_tPHVFNA2YP0C8zC5lwSJxBb0Lavjy2wmfyP2JWvDz_lVbucacch4
Message-ID: <CABgObfYkZaWuPPXrUoSw+c9o5SmG1hnkKVE29KcH_0-njHQrCw@mail.gmail.com>
Subject: Re: [PATCH] mkvenv: Support pip 25.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Sv. Lockal" <lockalsash@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bafcf7063c24fa1f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000bafcf7063c24fa1f
Content-Type: text/plain; charset="UTF-8"

Il mar 12 ago 2025, 07:47 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> > We're bending over backwards just because the Python developers on one
> > hand keep shipping pip while saying that "no, pip is absolutely not
> > special"; and on the other hand keep *not* shipping packaging and
> > distlib while complaining that people don't use them.
>
> This is a bit backwards, it looks like, and a bit too gross.
>
> First, pip vendors a few crate^Wlibs for internal use, but these libs
> had never been public, - that's why distlib is imported from
> pip._vendor.  We used this hack in qemu to simplify bootstrap, but
> it was never the intended usage in pip, and hence there's no backwards
> compatibility break here from the pip side.
>

Yes, absolutely. We were doing something gross as a convenience, but never
documented that it's just that, a convenience.

Second, which is a continuation of the first, strictly speaking it
> is our fault that we use distlib without depending on it.
>

Agreed, hence my suggestion to just require distlib.

And 3rd, it seems like Current Way (tm) is to use "packaging" library
> instead of distlib.  And packaging library is shipped within pip for
> a decade or so already - the same way as distlib.  This is why I
> wrote "backwards" above - by requiring distlib, we seems to work
> backwards, because current python way - which's been this way for
> years - is to use packaging, not distlib.


They are different libraries and both have their role. pip used
distlib.scripts but not distlib.version, and therefore decided to stop
shipping what it doesn't use

https://github.com/pypa/pip/pull/13337
https://github.com/pypa/pip/pull/13342

Using distlib is not going backwards, especially considering that we have
no other use for "packaging" in QEMU. There's no replacement for
distlib.scripts in the "packaging" library, and no official deprecation of
distlib.version. All that we would get from doing version matching with
"packaging" is requiring two dependencies instead of one (which is why John
kept the possibility to use an installed distlib).

Paolo

--000000000000bafcf7063c24fa1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 12 ago 2025, 07:47 Michae=
l Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha s=
critto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; We&=
#39;re bending over backwards just because the Python developers on one <br=
>
&gt; hand keep shipping pip while saying that &quot;no, pip is absolutely n=
ot <br>
&gt; special&quot;; and on the other hand keep *not* shipping packaging and=
 <br>
&gt; distlib while complaining that people don&#39;t use them.<br>
<br>
This is a bit backwards, it looks like, and a bit too gross.<br>
<br>
First, pip vendors a few crate^Wlibs for internal use, but these libs<br>
had never been public, - that&#39;s why distlib is imported from<br>
pip._vendor.=C2=A0 We used this hack in qemu to simplify bootstrap, but<br>
it was never the intended usage in pip, and hence there&#39;s no backwards<=
br>
compatibility break here from the pip side.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yes, absolutely. We were doing s=
omething gross as a convenience, but never documented that it&#39;s just th=
at, a convenience.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Second, which is a continuation of the first, strictly speaking it<br>
is our fault that we use distlib without depending on it.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Agreed, hence my s=
uggestion to just require distlib.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
And 3rd, it seems like Current Way (tm) is to use &quot;packaging&quot; lib=
rary<br>
instead of distlib.=C2=A0 And packaging library is shipped within pip for<b=
r>
a decade or so already - the same way as distlib.=C2=A0 This is why I<br>
wrote &quot;backwards&quot; above - by requiring distlib, we seems to work<=
br>
backwards, because current python way - which&#39;s been this way for<br>
years - is to use packaging, not distlib.</blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">They are different libraries and both=
 have their role. pip used distlib.scripts but not distlib.version, and the=
refore decided to stop shipping what it doesn&#39;t use</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><a href=3D"https://github.com/pypa/pip/pull=
/13337">https://github.com/pypa/pip/pull/13337</a></div><div dir=3D"auto"><=
a href=3D"https://github.com/pypa/pip/pull/13342">https://github.com/pypa/p=
ip/pull/13342</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">Using =
distlib is not going backwards, especially considering that we have no othe=
r use for &quot;packaging&quot; in QEMU. There&#39;s no replacement for dis=
tlib.scripts in the &quot;packaging&quot; library, and no official deprecat=
ion of distlib.version. All that we would get from doing version matching w=
ith &quot;packaging&quot; is requiring two dependencies instead of one (whi=
ch is why John kept the possibility to use an installed distlib).</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--000000000000bafcf7063c24fa1f--


