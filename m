Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACC7D715E9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 13:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vje0T-0003Qn-TI; Sat, 24 Jan 2026 08:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vje0E-0003IW-Mo
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 08:48:39 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vje0C-0002iJ-Tr
 for qemu-devel@nongnu.org; Sat, 24 Jan 2026 08:48:38 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8845cb580bso497348966b.3
 for <qemu-devel@nongnu.org>; Sat, 24 Jan 2026 05:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769262514; cv=none;
 d=google.com; s=arc-20240605;
 b=JPJN6yFCj/JP0UVY4LChZqisLV8fxkuMGSfxpcdnHeRhJdciVSK+FzmKNMPA2ijPw7
 3WI1iEXegDRUCfeVYGRUv9UaKm7fy0vCipmnSTYWBOdfY6EMtMz+ckZb0xxZTIfd1z/1
 N6EF+GYCw+WQ/Tl//frTyf1Gk5FecURvsojMiw7AdLhPh2/Oyv7jx4RmD0nOPUnAEnC6
 Jzj2HzWg+KA5ZHyPiQYAPZ9f3seFL2nVl4JhsJwgN3HRRuXEdPcUd8YpFpWm+X6vKdLq
 SI2YFyniXFGFjcdKPtvj0U0WUxyGMwmLKih4Sx2yl93W+Lh2fxOlF+N2g/G68D5ugDJe
 ZsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0XoKv/wstgnwQwr2/AN/KYB3PLKYFU1XguoIE45ZoUg=;
 fh=vQbBMjDeY6U3HE+UeJp5v6uIN83dG/vAq7BcDvxpk30=;
 b=R5wQ5Y8U7YpXh2OZ/5/bpaTuypVbD0O7k03VbDbeQJsuzBKdpWsl6oqYTeIU2vlRRI
 2Rn10Tici8s+rwSV5aZbq+wN6D3EY6KfKdzFSHYOykKGRA4INMx+E1vM3QwMaNbR5lF3
 ka6QwKNqDKBPxz3EvCQNOhm44NvwAZOokitaSRoo1wZrvKSDlT6peIF3HNUPRxbPbX3H
 pMRU0VvW9hvOA0JkFulUnJkRRpsb6o+/BNVIztYymfUyVldBEYlNfrVGcJx8yyYCGxNj
 Ss+mi8X44QZMj0mM979fNJiOG4ZrBvLdf/2pTOUyTS+dzDaVgoL72i5ZFbWH22B8f5mY
 zV0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769262514; x=1769867314; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0XoKv/wstgnwQwr2/AN/KYB3PLKYFU1XguoIE45ZoUg=;
 b=auzkD1psfIg2JDCbFXCowXRrsIrIbRQuANiE6TcOC1SciwyDHDvh2tpviUJautiqqb
 Z7sON/xxKACAyxeusUqT6ILX72Jek9xxqFUtQ+DyQUm9hBA/7I4ziw2uGBtcpLRSHub9
 pCTKxoCuPNXgZC2UVeWR1ainfypNU1uuIrlw8Kk5XN+4xQf6ey8DAQvbwfPQSNreO+n4
 t3gwz1PENsSnPcoOLDgzGggCu8afafEmPfHoQfb2aNZvXZCpwmGQmNr03BxnOWtriRhb
 RWidCy+q8vwQ5KQE9JGpwrEt+pGHkU/Iqx1s/o+z11iwnMDaB77pwVcjkkBP0muLwuEJ
 PpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769262514; x=1769867314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0XoKv/wstgnwQwr2/AN/KYB3PLKYFU1XguoIE45ZoUg=;
 b=r3VghMfF9+tbq0GroCYwzYCLW2u7YckhBar19PDYih//g5mz66lXZl7zJ2Eywg/lJE
 4SKkN9yW6MTDRDF5YoZ3LMrRNjf9N2xoN7LGEEWmRmquyB2qm2D78rEDmQ9P7y2Sg24Z
 kNsddKpyxbgyuoq2f5t+9CkcTqD06xSBlUqI0L0Im5Tj4dOJZGVK6RVu+lrA/9Pc0s7W
 MYr53F3JU400WMnnXl42KC+p299Tel5I2FGqAa4SyA/LEHeICIQHZ1RIEp4geuHjcV30
 0oQqYcpmr+9oWN/jJwzQdg/Dw1q3l13tqaF+RmM7d3Ky2Qov8rOyFcETZoZQNsFVC2W/
 U9Vw==
X-Gm-Message-State: AOJu0Yw2EDGOSneGmMwC5Diu5Hk5zMi3r2svsmr7Rmee4gZfHhHW3If+
 QU1D3RnJIfVHY/t4ho+fKIpHXQbEc5DobUQy5y80YThY7N9zMRGzv3z//iK3vjaVUTTgdrtKSEU
 jV5TDJ7fpu0RRXCG7DFFMwcbDI/XTu3k=
X-Gm-Gg: AZuq6aJ7++IlrhLzONGE7s+PQLLhYta/hvUZAwWoO5++OdW3qgPWNeoCLH2FECLoAdR
 Yzv6BDHaxgZljyMcYPUfLzahYUh7ZE04X6gTe0jtvCvryBIL8FlSIg0gJOIBV8XBtGFmoAZ2ZXM
 GkAxpCMNopjS0VDBejulGS2gY0K6o2/NG6juWttNWStZpErxizZsxJChF93DayPWACohip8QkZC
 VreDcEcNadZ/f0ij1YKuQwtrzEsmqeFfEiWXFy3HGyIvYVHOunnKkB6TK8ISlRBgHWCWWfT
X-Received: by 2002:a17:906:208f:b0:b87:324b:9ae1 with SMTP id
 a640c23a62f3a-b885ad28dbemr326571166b.40.1769262513671; Sat, 24 Jan 2026
 05:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20260121064110.28760-1-zhangckid@gmail.com>
 <871pjgbige.fsf@pond.sub.org>
In-Reply-To: <871pjgbige.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 24 Jan 2026 21:48:22 +0800
X-Gm-Features: AZwV_QhYqZVaeOvbPDOnxc8CheQRAnWO5JEF8SEcVVEI5gnuSak-2hMCt15pNNA
Message-ID: <CAK3tnvKjuhPM+W0_EO=kBGhvmOSML8kJpOFyee_4_N+8Rh90uw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] qapi/misc: Fix missed query-iothreads items
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a452e806492287a7"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000a452e806492287a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026, 8:51=E2=80=AFPM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > The example is incomplete: it misses members @poll-max-ns, @poll-grow,
> > @poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
> > (monitor: add poll-* properties into query-iothreads result) and
> > commit 1793ad0247c (iothread: add aio-max-batch parameter).
> >
> > cc: qemu-stable@nongnu.org
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  qapi/misc.json | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 28c641fe2f..e87994c9d9 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -117,11 +117,19 @@
> >  #     <- { "return": [
> >  #              {
> >  #                 "id":"iothread0",
> > -#                 "thread-id":3134
> > +#                 "thread-id":3134,
> > +#                 'poll-max-ns':32768,
>
> Double quotes, please.
>
> > +#                 "poll-grow":0,
> > +#                 "poll-shrink":0,
> > +#                 "aio-max-batch":0
> >  #              },
> >  #              {
> >  #                 "id":"iothread1",
> > -#                 "thread-id":3135
> > +#                 "thread-id":3135,
> > +#                 'poll-max-ns':32768,
>
> Likewise.
>
> > +#                 "poll-grow":0,
> > +#                 "poll-shrink":0,
> > +#                 "aio-max-batch":0
> >  #              }
> >  #           ]
> >  #        }
>
> Easiest way to avoid such mistakes is to copy actual QMP output.
>

Oh, sorry to typo for this series... Will fix it with double check.

Thanks
Chen


>

--000000000000a452e806492287a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 23, 2026, 8:51=E2=80=
=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Zhang Chen &=
lt;<a href=3D"mailto:zhangckid@gmail.com" target=3D"_blank" rel=3D"noreferr=
er">zhangckid@gmail.com</a>&gt; writes:<br>
<br>
&gt; The example is incomplete: it misses members @poll-max-ns, @poll-grow,=
<br>
&gt; @poll-shrink, @aio-max-batch.=C2=A0 Messed up in commit 5fc00480ab1<br=
>
&gt; (monitor: add poll-* properties into query-iothreads result) and<br>
&gt; commit 1793ad0247c (iothread: add aio-max-batch parameter).<br>
&gt;<br>
&gt; cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank" rel=3D=
"noreferrer">qemu-stable@nongnu.org</a><br>
&gt;<br>
&gt; Signed-off-by: Zhang Chen &lt;<a href=3D"mailto:zhangckid@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">zhangckid@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/misc.json | 12 ++++++++++--<br>
&gt;=C2=A0 1 file changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/qapi/misc.json b/qapi/misc.json<br>
&gt; index 28c641fe2f..e87994c9d9 100644<br>
&gt; --- a/qapi/misc.json<br>
&gt; +++ b/qapi/misc.json<br>
&gt; @@ -117,11 +117,19 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0&lt;- { &quot;return&quot;: [<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&=
quot;id&quot;:&quot;iothread0&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
thread-id&quot;:3134<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
thread-id&quot;:3134,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;p=
oll-max-ns&#39;:32768,<br>
<br>
Double quotes, please.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
poll-grow&quot;:0,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
poll-shrink&quot;:0,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
aio-max-batch&quot;:0<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&=
quot;id&quot;:&quot;iothread1&quot;,<br>
&gt; -#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
thread-id&quot;:3135<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
thread-id&quot;:3135,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;p=
oll-max-ns&#39;:32768,<br>
<br>
Likewise.<br>
<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
poll-grow&quot;:0,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
poll-shrink&quot;:0,<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
aio-max-batch&quot;:0<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0]<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
Easiest way to avoid such mistakes is to copy actual QMP output.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Oh, sorry t=
o typo for this series... Will fix it with double check.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Thanks</div><div dir=3D"auto">Chen</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"></div></div>

--000000000000a452e806492287a7--

